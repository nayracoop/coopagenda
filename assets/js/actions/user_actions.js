import * as types from "./action_types";

export const receiveUser = (user, token) => {
  return { type: types.RECEIVE_USER, user, token, receivedAt: Date.now() };
};

export const logout = () => {
  return { type: types.LOGOUT_USER };
};
