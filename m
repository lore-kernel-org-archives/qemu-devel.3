Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3463C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:16:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaf3-0007Oq-2d; Thu, 01 Feb 2024 12:15:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaf0-0007Oh-JY
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:15:34 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVaej-000365-Rr
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 12:15:34 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3394b892691so634281f8f.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 09:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706807712; x=1707412512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hnlv+kbWuEuFLor8byMvVQAq0p8rrW5AFvzLRa6AGXk=;
 b=ZOmAPvFdketWOSKN4FSJFGGYe2CQrktSIpXUDsWOXyicPsdK3A/Q7j4dJ8fGb4ak/u
 SjLQX/LjvqJEo+6/W/yAJR99p5VByXQlB5q3wKXlVq8qdPs6hJC+18cXwemtt9mZM3i7
 QuWCrObO7ZPCQ+dsoVXTKsuuKcc+VeQZjpYAP5P3nstUYrpII0Bm7WafxNnVLREBsqtJ
 ++rWo9GiKVrarLHw2G/SCzXslzlRxuEVC2E1Z8fV6V+vqbNJOwN0JxyXm5cjBE37eCXr
 RCPtXp4nRD0k/i8tcf2IWMpl+LiMCWUb+MGZ7tS81ZDlewL0txdYBtd7y/sqJPCWcEot
 O0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706807712; x=1707412512;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hnlv+kbWuEuFLor8byMvVQAq0p8rrW5AFvzLRa6AGXk=;
 b=BTR6KuOtVg7ZnmLFvFedvaiGXgGgUKFijm32NskT8G8Qxskvd11ScBVO3ZpZomqG60
 4IcRMBF14DW6mg0y+foMb0TKuaRGqxSSZx+wxv5WI+wxgwwQ8nRIG1c6CLzOXF43ic0v
 0eV1uo1+i4YVh0pAosbyGjouITjBJELYV/87xa61zMR0kkd6SECwbqsoo2Yqf6RgXuHS
 //TSbp+kR/igOThNeKnwzoo91Qks2lySCnTkkbfWwL6LgCod0LkX3C48IodVqRZonf/U
 DZQxjlfNMc8wX3oUQSEz7qrriq6mI9AnPmHQ+KR1Ri609p4+AoM7pEHvJCjsLca6NP4F
 eoxg==
X-Gm-Message-State: AOJu0YxTbyq9+hg7EnbJo76FMOGukYw9qGAK6CV28kOCtb3nE74WSVlx
 HEakb1gSsmUglEtBGApdoS9VXIYUtLVB3/BM2T4xURcS0Z9TZZzdcdfgMr9hu1o=
X-Google-Smtp-Source: AGHT+IHsKkyAYqqx5rfl+suDUo6UtwbLkb5V3LCEnY/Ezxik8x6zfghodvhsnaIev4bd3gwpDqMnpQ==
X-Received: by 2002:adf:f406:0:b0:33a:ebf1:2bf9 with SMTP id
 g6-20020adff406000000b0033aebf12bf9mr5767386wro.21.1706807711440; 
 Thu, 01 Feb 2024 09:15:11 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCXgCVQmRFWQARUR95ECv6HpIXcysc5j1shtXN76JLQtcCZjk9olx40M7dtS8oa52rfJN5JSwt7CcTSKT6I17eyE1gMisCNTvHi2gavTqeLYjTGdJcLlHHQ+
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 fa1-20020a056000258100b0033af5716a7fsm9034328wrb.61.2024.02.01.09.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 09:15:11 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BC2D75F7AF;
 Thu,  1 Feb 2024 17:15:10 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Riku Voipio <riku.voipio@iki.fi>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] gdbstub: Implement catching syscalls
In-Reply-To: <20240116094411.216665-2-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Tue, 16 Jan 2024 10:41:53 +0100")
References: <20240116094411.216665-1-iii@linux.ibm.com>
 <20240116094411.216665-2-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 17:15:10 +0000
Message-ID: <8734uckswx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Ilya Leoshkevich <iii@linux.ibm.com> writes:

> GDB supports stopping on syscall entry and exit using the "catch
> syscall" command. It relies on 3 packets, which are currently not
> supported by QEMU:
>
> * qSupported:QCatchSyscalls+ [1]
> * QCatchSyscalls: [2]
> * T05syscall_entry: and T05syscall_return: [3]
>
> Implement generation and handling of these packets.
>
> [1] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-=
Packets.html#qSupported
> [2] https://sourceware.org/gdb/current/onlinedocs/gdb.html/General-Query-=
Packets.html#QCatchSyscalls
> [3] https://sourceware.org/gdb/current/onlinedocs/gdb.html/Stop-Reply-Pac=
kets.html
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  gdbstub/gdbstub.c            |   9 +++
>  gdbstub/internals.h          |   2 +
>  gdbstub/user-target.c        |   5 ++
>  gdbstub/user.c               | 104 ++++++++++++++++++++++++++++++++++-
>  include/gdbstub/user.h       |  29 +++++++++-
>  include/user/syscall-trace.h |   7 ++-
>  6 files changed, 151 insertions(+), 5 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 46d752bbc2c..7e73e916bdc 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -1617,6 +1617,7 @@ static void handle_query_supported(GArray *params, =
void *user_ctx)
>      if (gdbserver_state.c_cpu->opaque) {
>          g_string_append(gdbserver_state.str_buf, ";qXfer:auxv:read+");
>      }
> +    g_string_append(gdbserver_state.str_buf, ";QCatchSyscalls+");
>  #endif
>      g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
>  #endif
> @@ -1810,6 +1811,14 @@ static const GdbCmdParseEntry gdb_gen_set_table[] =
=3D {
>          .schema =3D "l0"
>      },
>  #endif
> +#if defined(CONFIG_USER_ONLY)
> +    {
> +        .handler =3D gdb_handle_set_catch_syscalls,
> +        .cmd =3D "CatchSyscalls:",
> +        .cmd_startswith =3D 1,
> +        .schema =3D "s0",
> +    },
> +#endif
>  };
>=20=20
>  static void handle_gen_query(GArray *params, void *user_ctx)
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 5c0c725e54c..56b7c13b750 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -136,6 +136,7 @@ void gdb_append_thread_id(CPUState *cpu, GString *buf=
);
>  int gdb_get_cpu_index(CPUState *cpu);
>  unsigned int gdb_get_max_cpus(void); /* both */
>  bool gdb_can_reverse(void); /* softmmu, stub for user */
> +int gdb_target_sigtrap(void); /* user */
>=20=20
>  void gdb_create_default_process(GDBState *s);
>=20=20
> @@ -194,6 +195,7 @@ void gdb_handle_v_file_close(GArray *params, void *us=
er_ctx); /* user */
>  void gdb_handle_v_file_pread(GArray *params, void *user_ctx); /* user */
>  void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user=
 */
>  void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /*=
 user */
> +void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* u=
ser */
>=20=20
>  void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both =
*/
>=20=20
> diff --git a/gdbstub/user-target.c b/gdbstub/user-target.c
> index c4bba4c72c7..b7d4c37cd81 100644
> --- a/gdbstub/user-target.c
> +++ b/gdbstub/user-target.c
> @@ -418,3 +418,8 @@ void gdb_handle_query_xfer_exec_file(GArray *params, =
void *user_ctx)
>                      ts->bprm->filename + offset);
>      gdb_put_strbuf();
>  }
> +
> +int gdb_target_sigtrap(void)
> +{
> +    return TARGET_SIGTRAP;
> +}
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index dbe1d9b8875..01dd7169258 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -10,6 +10,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include "qemu/bitops.h"
>  #include "qemu/cutils.h"
>  #include "qemu/sockets.h"
>  #include "exec/hwaddr.h"
> @@ -21,11 +22,25 @@
>  #include "trace.h"
>  #include "internals.h"
>=20=20
> +enum GDBCatchSyscallsState {
> +    GDB_CATCH_SYSCALLS_NONE,
> +    GDB_CATCH_SYSCALLS_ALL,
> +    GDB_CATCH_SYSCALLS_SELECTED,
> +};
> +#define GDB_NR_SYSCALLS 1024
> +typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
> +
>  /* User-mode specific state */
>  typedef struct {
>      int fd;
>      char *socket_path;
>      int running_state;
> +    /*
> +     * Store syscalls mask without memory allocation in order to avoid
> +     * implementing synchronization.
> +     */
> +    enum GDBCatchSyscallsState catch_syscalls_state;
> +    GDBSyscallsMask catch_syscalls_mask;
>  } GDBUserState;
>=20=20
>  static GDBUserState gdbserver_user_state;
> @@ -121,7 +136,7 @@ void gdb_qemu_exit(int code)
>      exit(code);
>  }
>=20=20
> -int gdb_handlesig(CPUState *cpu, int sig)
> +int gdb_handlesig_reason(CPUState *cpu, int sig, const char *reason)
>  {
>      char buf[256];
>      int n;
> @@ -141,6 +156,9 @@ int gdb_handlesig(CPUState *cpu, int sig)
>                              "T%02xthread:", gdb_target_signal_to_gdb(sig=
));
>              gdb_append_thread_id(cpu, gdbserver_state.str_buf);
>              g_string_append_c(gdbserver_state.str_buf, ';');
> +            if (reason) {
> +                g_string_append(gdbserver_state.str_buf, reason);
> +            }
>              gdb_put_strbuf();
>              gdbserver_state.allow_stop_reply =3D false;
>          }
> @@ -499,3 +517,87 @@ void gdb_syscall_handling(const char *syscall_packet)
>      gdb_put_packet(syscall_packet);
>      gdb_handlesig(gdbserver_state.c_cpu, 0);
>  }
> +
> +static bool should_catch_syscall(int num)
> +{
> +    switch (gdbserver_user_state.catch_syscalls_state) {
> +    case GDB_CATCH_SYSCALLS_NONE:
> +        return false;
> +    case GDB_CATCH_SYSCALLS_ALL:
> +        return true;
> +    case GDB_CATCH_SYSCALLS_SELECTED:
> +        if (num < 0 || num >=3D GDB_NR_SYSCALLS) {
> +            return false;
> +        } else {
> +            return test_bit(num, gdbserver_user_state.catch_syscalls_mas=
k);
> +        }
> +    default:
> +        g_assert_not_reached();
> +    }
> +}
> +
> +void gdb_syscall_entry(CPUState *cs, int num)
> +{
> +    char reason[32];
> +
> +    if (should_catch_syscall(num)) {
> +        snprintf(reason, sizeof(reason), "syscall_entry:%x;", num);
> +        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
> +    }
> +}
> +
> +void gdb_syscall_return(CPUState *cs, int num)
> +{
> +    char reason[32];
> +
> +    if (should_catch_syscall(num)) {
> +        snprintf(reason, sizeof(reason), "syscall_return:%x;", num);
> +        gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);
> +    }
> +}

I'm not super keen on re-introducing snprintf's as we've been slowly
eradicating them from the code base. How about:

    g_autoptr(GString) reason =3D g_string_printf("syscall_return:%x;", num=
);
    gdb_handlesig_reason(cs, gdb_target_sigtrap(), reason);

> +
> +void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx)
> +{
> +    enum GDBCatchSyscallsState catch_syscalls_state;
> +    const char *param =3D get_param(params, 0)->data;
> +    GDBSyscallsMask catch_syscalls_mask;
> +    bool catch_syscalls_none;
> +    unsigned int num;
> +    const char *p;
> +

Perhaps a little comment:

  /* terminating with 0/1 to disable/enable all */

> +    catch_syscalls_none =3D strcmp(param, "0") =3D=3D 0;
> +    if (catch_syscalls_none || strcmp(param, "1") =3D=3D 0) {
> +        gdbserver_user_state.catch_syscalls_state =3D
> +            catch_syscalls_none ? GDB_CATCH_SYSCALLS_NONE :
> +                                  GDB_CATCH_SYSCALLS_ALL;
> +        gdb_put_packet("OK");
> +        return;
> +    }

  /* otherwise decode the following list of syscalls... */

?

> +    if (param[0] =3D=3D '1' && param[1] =3D=3D ';') {
> +        catch_syscalls_state =3D GDB_CATCH_SYSCALLS_SELECTED;
> +        memset(catch_syscalls_mask, 0, sizeof(catch_syscalls_mask));
> +        for (p =3D &param[2];; p++) {
> +            if (qemu_strtoui(p, &p, 16, &num) || (*p && *p !=3D ';')) {
> +                goto err;
> +            }
> +            if (num >=3D GDB_NR_SYSCALLS) {
> +                /* Fall back to reporting all syscalls. */
> +                catch_syscalls_state =3D GDB_CATCH_SYSCALLS_ALL;

Is this the right thing or maybe we should error because gdb sent us
something strange? In fact you could do:

           if (qemu_strtoui(p, &p, 16, &num) ||
               (*p && *p !=3D ';') ||
               num >=3D GDB_NR_SYSCALLS) {
               gdb_put_packet("E00");
               return;
           }

and skip the goto err

> +            } else {
> +                set_bit(num, catch_syscalls_mask);
> +            }
> +            if (!*p) {
> +                break;
> +            }

Could this be in the for loop?

  for(p =3D &param[2]; *p; p++)
=20=20

> +        }
> +        gdbserver_user_state.catch_syscalls_state =3D catch_syscalls_sta=
te;
> +        memcpy(gdbserver_user_state.catch_syscalls_mask, catch_syscalls_=
mask,
> +               sizeof(catch_syscalls_mask));
> +        gdb_put_packet("OK");
> +        return;
> +    }
> +
> +err:
> +    gdb_put_packet("E00");
> +}
> diff --git a/include/gdbstub/user.h b/include/gdbstub/user.h
> index d392e510c59..68b6534130c 100644
> --- a/include/gdbstub/user.h
> +++ b/include/gdbstub/user.h
> @@ -10,9 +10,10 @@
>  #define GDBSTUB_USER_H
>=20=20
>  /**
> - * gdb_handlesig() - yield control to gdb
> + * gdb_handlesig_reason() - yield control to gdb
>   * @cpu: CPU
>   * @sig: if non-zero, the signal number which caused us to stop
> + * @reason: stop reason for stop reply packet or NULL
>   *
>   * This function yields control to gdb, when a user-mode-only target
>   * needs to stop execution. If @sig is non-zero, then we will send a
> @@ -24,7 +25,18 @@
>   * or 0 if no signal should be delivered, ie the signal that caused
>   * us to stop should be ignored.
>   */
> -int gdb_handlesig(CPUState *, int);
> +int gdb_handlesig_reason(CPUState *, int, const char *);
> +
> +/**
> + * gdb_handlesig() - yield control to gdb
> + * @cpu CPU
> + * @sig: if non-zero, the signal number which caused us to stop
> + * @see gdb_handlesig_reason()
> + */
> +static inline int gdb_handlesig(CPUState *cpu, int sig)
> +{
> +    return gdb_handlesig_reason(cpu, sig, NULL);
> +}
>=20=20
>  /**
>   * gdb_signalled() - inform remote gdb of sig exit
> @@ -39,5 +51,18 @@ void gdb_signalled(CPUArchState *as, int sig);
>   */
>  void gdbserver_fork(CPUState *cs);
>=20=20
> +/**
> + * gdb_syscall_entry() - inform gdb of syscall entry and yield control t=
o it
> + * @cs: CPU
> + * @num: syscall number
> + */
> +void gdb_syscall_entry(CPUState *cs, int num);
> +
> +/**
> + * gdb_syscall_entry() - inform gdb of syscall return and yield control =
to it
> + * @cs: CPU
> + * @num: syscall number
> + */
> +void gdb_syscall_return(CPUState *cs, int num);
>=20=20
>  #endif /* GDBSTUB_USER_H */
> diff --git a/include/user/syscall-trace.h b/include/user/syscall-trace.h
> index 557f881a79b..b48b2b2d0ae 100644
> --- a/include/user/syscall-trace.h
> +++ b/include/user/syscall-trace.h
> @@ -11,6 +11,7 @@
>  #define SYSCALL_TRACE_H
>=20=20
>  #include "exec/user/abitypes.h"
> +#include "gdbstub/user.h"
>  #include "qemu/plugin.h"
>  #include "trace/trace-root.h"
>=20=20
> @@ -20,7 +21,7 @@
>   * could potentially unify the -strace code here as well.
>   */
>=20=20
> -static inline void record_syscall_start(void *cpu, int num,
> +static inline void record_syscall_start(CPUState *cpu, int num,
>                                          abi_long arg1, abi_long arg2,
>                                          abi_long arg3, abi_long arg4,
>                                          abi_long arg5, abi_long arg6,
> @@ -29,11 +30,13 @@ static inline void record_syscall_start(void *cpu, in=
t num,
>      qemu_plugin_vcpu_syscall(cpu, num,
>                               arg1, arg2, arg3, arg4,
>                               arg5, arg6, arg7, arg8);
> +    gdb_syscall_entry(cpu, num);
>  }
>=20=20
> -static inline void record_syscall_return(void *cpu, int num, abi_long re=
t)
> +static inline void record_syscall_return(CPUState *cpu, int num, abi_lon=
g ret)
>  {
>      qemu_plugin_vcpu_syscall_ret(cpu, num, ret);
> +    gdb_syscall_return(cpu, num);

This clean-up belongs in a separate patch.

>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

