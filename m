Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A58C4828C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 12:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVuS-00013K-Lt; Thu, 01 Feb 2024 07:11:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVuR-000134-29
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:11:11 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rVVuM-0007Ts-Ms
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 07:11:10 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40fb804e330so7673795e9.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 04:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706789463; x=1707394263; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8nf+Vul/bG+nJcpjCC7Pc3UnVx+gAiNabOtpExftkOY=;
 b=L2WrLn9FIT27xE57G7fDdc4CDQFjJ90vSJn+RPvxcxsRNJ1vYx2SAg4PVxypPVm8LQ
 GO9aP+RG451/1uwg3uda/AStsfnCgSkVI7k5S8wQNyb/oSY/PIUOw7Dw6IgMUeW9XOYV
 tUdT0Jh/k4tNgd7jd6uI94NHJzwSzYB20OCaW7VGfevE9PvEpZwA4cVQBwRA5HBAw/Dz
 BefkDVzDbhfEL9Bq2Y554eEqC4DkILgR9CW1pO8tfzceKBsJABPbd/1t/e/3cvbAGSga
 km2fhVGntR41I1mWanaPF3YtSLBXhGEoGLasZjNw5vjY62lXoquiyRJmJonvxLRANmP9
 Iy3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706789463; x=1707394263;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8nf+Vul/bG+nJcpjCC7Pc3UnVx+gAiNabOtpExftkOY=;
 b=pb5W78MWqZESlyPCSlhvm8C/cBcHDSxRKVwm0dmnPfcJqPZ9slCLynZk1cW20fFjQk
 Lyfj0QQcI3q/SDng0CexuJVTXUOCLvhKLRqEqIibX94JhICUpUYmlBo0JZZzJO38V+9h
 hhb1Mf7dhZfvJs+4zJ3DYdiUq8m3HmfeoD61SVfBfZDVeJSi5BQqEOetjJgqh4Gpy9dp
 F8vZnEYizP4XFz5hFke5MX6iYKV61MWQvFVoB8QdjflthOfY76caeqcZgQXPBtsN9L2R
 j5tjSrSgjrD6Qo3sJ4sxptqLjGdH1oco+JpOtU5cZHZq/SmGk81CqVtl0NOoCu/QdtXL
 QQ5Q==
X-Gm-Message-State: AOJu0YySn9RsFO8/mDnNzSR0T8b2Ga6+0T7O80up4yTyfn1voR7BBsY9
 PKEv7xW+xNggdIbY896tN37UMqZdEFykx2zGkSJkRvAtDwZgBO011dK/i5KMQDo=
X-Google-Smtp-Source: AGHT+IHeM8UqQMJHleT6aW5yBE/q+Tuy1lKs5g3OGoCrx+OAjztoufW2RSOmeVcmcAD4hch6D2qThw==
X-Received: by 2002:adf:cc85:0:b0:337:c730:d7e3 with SMTP id
 p5-20020adfcc85000000b00337c730d7e3mr3410472wrj.57.1706789463500; 
 Thu, 01 Feb 2024 04:11:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWj9fBGijARg2YqvOplc5fm0zcIBWE+blvyyW9HH9zyWuu0CDIO4DJ7RJYfCacdfh8yMixRpupjWEg6VcKV1MV0IaNHXu1k9EvjN1fktuuj8u0uoFy2+xrMpQWIB82U+MxFQcS9Gs7KHQhzZH7uhCRC0b3BRAl/
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0033ae6530969sm13367057wrb.85.2024.02.01.04.11.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 04:11:03 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B10B25F7AF;
 Thu,  1 Feb 2024 12:11:02 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Laurent Vivier <laurent@vivier.eu>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] gdbstub: Implement follow-fork-mode child
In-Reply-To: <20240131205031.144607-3-iii@linux.ibm.com> (Ilya Leoshkevich's
 message of "Wed, 31 Jan 2024 21:43:40 +0100")
References: <20240131205031.144607-1-iii@linux.ibm.com>
 <20240131205031.144607-3-iii@linux.ibm.com>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Thu, 01 Feb 2024 12:11:02 +0000
Message-ID: <877cjomlk9.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> Currently it's not possible to use gdbstub for debugging linux-user
> code that runs in a forked child, which is normally done using the `set
> follow-fork-mode child` GDB command. Purely on the protocol level, the
> missing piece is the fork-events feature.
>
> However, a deeper problem is supporting $Hg switching between different
> processes - right now it can do only threads. Implementing this for the
> general case would be quite complicated, but, fortunately, for the
> follow-fork-mode case there are a few factors that greatly simplify
> things: fork() happens in the exclusive section, there are only two
> processes involved, and before one of them is resumed, the second one
> is detached.
>
> This makes it possible to implement a simplified scheme: the parent and
> the child share the gdbserver socket, it's used only by one of them at
> any given time, which is coordinated through a separate socketpair. The
> processes can read from the gdbserver socket only one byte at a time,
> which is not great for performance, but, fortunately, the
> follow-fork-mode involves only a few messages.
>
> Add the hooks for the user-specific handling of $qSupported, $Hg, and
> $D. Advertise the fork-events support, and remember whether GDB has it
> as well. Implement the state machine that is initialized on fork(),
> decides the current owner of the gdbserver socket, and is terminated
> when one of the two processes is detached. The logic for the parent and
> the child is the same, only the initial state is different.
>
> Handle the `stepi` of a syscall corner case by disabling the
> single-stepping in detached processes.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  gdbstub/gdbstub.c   |  29 ++++--
>  gdbstub/internals.h |   3 +
>  gdbstub/user.c      | 210 +++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 234 insertions(+), 8 deletions(-)
>
> diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> index 7e73e916bdc..46f5dd47e9e 100644
> --- a/gdbstub/gdbstub.c
> +++ b/gdbstub/gdbstub.c
> @@ -991,6 +991,12 @@ static void handle_detach(GArray *params, void *user=
_ctx)
>          pid =3D get_param(params, 0)->val_ul;
>      }
>=20=20
> +#ifdef CONFIG_USER_ONLY
> +    if (gdb_handle_detach_user(pid)) {
> +        return;
> +    }
> +#endif
> +
>      process =3D gdb_get_process(pid);
>      gdb_process_breakpoint_remove_all(process);
>      process->attached =3D false;
> @@ -1066,6 +1072,7 @@ static void handle_cont_with_sig(GArray *params, vo=
id *user_ctx)
>=20=20
>  static void handle_set_thread(GArray *params, void *user_ctx)
>  {
> +    uint32_t pid, tid;
>      CPUState *cpu;
>=20=20
>      if (params->len !=3D 2) {
> @@ -1083,8 +1090,14 @@ static void handle_set_thread(GArray *params, void=
 *user_ctx)
>          return;
>      }
>=20=20
> -    cpu =3D gdb_get_cpu(get_param(params, 1)->thread_id.pid,
> -                      get_param(params, 1)->thread_id.tid);
> +    pid =3D get_param(params, 1)->thread_id.pid;
> +    tid =3D get_param(params, 1)->thread_id.tid;
> +#ifdef CONFIG_USER_ONLY
> +    if (gdb_handle_set_thread_user(pid, tid)) {
> +        return;
> +    }
> +#endif
> +    cpu =3D gdb_get_cpu(pid, tid);
>      if (!cpu) {
>          gdb_put_packet("E22");
>          return;
> @@ -1599,6 +1612,7 @@ static void handle_query_thread_extra(GArray *param=
s, void *user_ctx)
>=20=20
>  static void handle_query_supported(GArray *params, void *user_ctx)
>  {
> +    const char *gdb_supported;
>      CPUClass *cc;
>=20=20
>      g_string_printf(gdbserver_state.str_buf, "PacketSize=3D%x", MAX_PACK=
ET_LENGTH);
> @@ -1622,9 +1636,14 @@ static void handle_query_supported(GArray *params,=
 void *user_ctx)
>      g_string_append(gdbserver_state.str_buf, ";qXfer:exec-file:read+");
>  #endif
>=20=20
> -    if (params->len &&
> -        strstr(get_param(params, 0)->data, "multiprocess+")) {
> -        gdbserver_state.multiprocess =3D true;
> +    if (params->len) {
> +        gdb_supported =3D get_param(params, 0)->data;
> +        if (strstr(gdb_supported, "multiprocess+")) {
> +            gdbserver_state.multiprocess =3D true;
> +        }
> +#if defined(CONFIG_USER_ONLY)
> +        gdb_handle_query_supported_user(gdb_supported);
> +#endif
>      }
>=20=20
>      g_string_append(gdbserver_state.str_buf, ";vContSupported+;multiproc=
ess+");
> diff --git a/gdbstub/internals.h b/gdbstub/internals.h
> index 56b7c13b750..b4724598384 100644
> --- a/gdbstub/internals.h
> +++ b/gdbstub/internals.h
> @@ -196,6 +196,9 @@ void gdb_handle_v_file_pread(GArray *params, void *us=
er_ctx); /* user */
>  void gdb_handle_v_file_readlink(GArray *params, void *user_ctx); /* user=
 */
>  void gdb_handle_query_xfer_exec_file(GArray *params, void *user_ctx); /*=
 user */
>  void gdb_handle_set_catch_syscalls(GArray *params, void *user_ctx); /* u=
ser */
> +void gdb_handle_query_supported_user(const char *gdb_supported); /* user=
 */
> +bool gdb_handle_set_thread_user(uint32_t pid, uint32_t tid); /* user */
> +bool gdb_handle_detach_user(uint32_t pid); /* user */
>=20=20
>  void gdb_handle_query_attached(GArray *params, void *user_ctx); /* both =
*/
>=20=20
> diff --git a/gdbstub/user.c b/gdbstub/user.c
> index 120eb7fc117..962f4cb74e7 100644
> --- a/gdbstub/user.c
> +++ b/gdbstub/user.c
> @@ -10,6 +10,7 @@
>   */
>=20=20
>  #include "qemu/osdep.h"
> +#include <sys/syscall.h>
>  #include "qemu/bitops.h"
>  #include "qemu/cutils.h"
>  #include "qemu/sockets.h"
> @@ -25,6 +26,41 @@
>  #define GDB_NR_SYSCALLS 1024
>  typedef unsigned long GDBSyscallsMask[BITS_TO_LONGS(GDB_NR_SYSCALLS)];
>=20=20
> +/*
> + * Forked child talks to its parent in order to let GDB enforce the
> + * follow-fork-mode. This happens inside a start_exclusive() section, so=
 that
> + * the other threads, which may be forking too, do not interfere. The
> + * implementation relies on GDB not sending $vCont until it has detached
> + * either from the parent (follow-fork-mode child) or from the child
> + * (follow-fork-mode parent).
> + *
> + * The parent and the child share the GDB socket; at any given time only=
 one
> + * of them is allowed to use it, as is reflected in the respective fork_=
state.
> + * This is negotiated via the fork_sockets pair as a reaction to $Hg.
> + */
> +enum GDBForkState {
> +    /* Fully owning the GDB socket. */
> +    GDB_FORK_ENABLED,
> +    /* Working with the GDB socket; the peer is inactive. */
> +    GDB_FORK_ACTIVE,
> +    /* Handing off the GDB socket to the peer. */
> +    GDB_FORK_DEACTIVATING,
> +    /* The peer is working with the GDB socket. */
> +    GDB_FORK_INACTIVE,
> +    /* Asking the peer to close its GDB socket fd. */
> +    GDB_FORK_ENABLING,
> +    /* Asking the peer to take over, closing our GDB socket fd. */
> +    GDB_FORK_DISABLING,
> +    /* The peer has taken over, our GDB socket fd is closed. */
> +    GDB_FORK_DISABLED,
> +};

gulp - thats a potentially fairly complex state diagram. Do we just work
through the states sequentially?

> +
> +enum GDBForkMessage {
> +    GDB_FORK_ACTIVATE =3D 'a',
> +    GDB_FORK_ENABLE =3D 'e',
> +    GDB_FORK_DISABLE =3D 'd',
> +};
> +
>  /* User-mode specific state */
>  typedef struct {
>      int fd;
> @@ -36,6 +72,10 @@ typedef struct {
>       */
>      bool catch_all_syscalls;
>      GDBSyscallsMask catch_syscalls_mask;
> +    bool fork_events;
> +    enum GDBForkState fork_state;
> +    int fork_sockets[2];
> +    pid_t fork_peer_pid, fork_peer_tid;
>  } GDBUserState;
>=20=20
>  static GDBUserState gdbserver_user_state;
> @@ -358,6 +398,18 @@ int gdbserver_start(const char *port_or_path)
>=20=20
>  void gdbserver_fork_start(void)
>  {
> +    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
> +        return;
> +    }
> +    if (!gdbserver_user_state.fork_events ||
> +            qemu_socketpair(AF_UNIX, SOCK_STREAM, 0,
> +                            gdbserver_user_state.fork_sockets) < 0) {
> +        gdbserver_user_state.fork_state =3D GDB_FORK_DISABLED;
> +        return;
> +    }
> +    gdbserver_user_state.fork_state =3D GDB_FORK_INACTIVE;
> +    gdbserver_user_state.fork_peer_pid =3D getpid();
> +    gdbserver_user_state.fork_peer_tid =3D qemu_get_thread_id();
>  }
>=20=20
>  static void disable_gdbstub(void)
> @@ -369,16 +421,168 @@ static void disable_gdbstub(void)
>      CPU_FOREACH(cpu) {
>          cpu_breakpoint_remove_all(cpu, BP_GDB);
>          /* no cpu_watchpoint_remove_all for user-mode */
> +        cpu_single_step(cpu, 0);
> +        tb_flush(cpu);
>      }
>  }
>=20=20
> -/* Disable gdb stub for child processes.  */
>  void gdbserver_fork_end(pid_t pid)
>  {
> -    if (pid !=3D 0 || !gdbserver_state.init || gdbserver_user_state.fd <=
 0) {
> +    char b;
> +    int fd;
> +
> +    if (!gdbserver_state.init || gdbserver_user_state.fd < 0) {
> +        return;
> +    }
> +
> +    if (pid =3D=3D -1) {
> +        if (gdbserver_user_state.fork_state !=3D GDB_FORK_DISABLED) {
> +            g_assert(gdbserver_user_state.fork_state =3D=3D GDB_FORK_INA=
CTIVE);
> +            close(gdbserver_user_state.fork_sockets[0]);
> +            close(gdbserver_user_state.fork_sockets[1]);
> +        }
>          return;
>      }
> -    disable_gdbstub();
> +
> +    if (gdbserver_user_state.fork_state =3D=3D GDB_FORK_DISABLED) {
> +        if (pid =3D=3D 0) {
> +            disable_gdbstub();
> +        }
> +        return;
> +    }
> +
> +    if (pid =3D=3D 0) {
> +        close(gdbserver_user_state.fork_sockets[0]);
> +        fd =3D gdbserver_user_state.fork_sockets[1];
> +        g_assert(gdbserver_state.process_num =3D=3D 1);
> +        g_assert(gdbserver_state.processes[0].pid =3D=3D
> +                     gdbserver_user_state.fork_peer_pid);
> +        g_assert(gdbserver_state.processes[0].attached);
> +        gdbserver_state.processes[0].pid =3D getpid();
> +    } else {
> +        close(gdbserver_user_state.fork_sockets[1]);
> +        fd =3D gdbserver_user_state.fork_sockets[0];
> +        gdbserver_user_state.fork_state =3D GDB_FORK_ACTIVE;
> +        gdbserver_user_state.fork_peer_pid =3D pid;
> +        gdbserver_user_state.fork_peer_tid =3D pid;
> +
> +        if (!gdbserver_state.allow_stop_reply) {
> +            goto fail;
> +        }
> +        g_string_printf(gdbserver_state.str_buf,
> +                        "T%02xfork:p%02x.%02x;thread:p%02x.%02x;",
> +                        gdb_target_signal_to_gdb(gdb_target_sigtrap()),
> +                        pid, pid, (int)getpid(),
> qemu_get_thread_id());

I don't think I messed up the merge but:

../../gdbstub/user.c: In function =E2=80=98gdbserver_fork_end=E2=80=99:
../../gdbstub/user.c:461:50: error: implicit declaration of function =E2=80=
=98gdb_target_sigtrap=E2=80=99 [-Werror=3Dimplicit-function-declaration]
  461 |                         gdb_target_signal_to_gdb(gdb_target_sigtrap=
()),
      |                                                  ^~~~~~~~~~~~~~~~~~
../../gdbstub/user.c:461:50: error: nested extern declaration of =E2=80=98g=
db_target_sigtrap=E2=80=99 [-Werror=3Dnested-externs]
cc1: all warnings being treated as errors

I cant see where gdb_target_sigtrap is from?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

