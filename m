Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27697CA101A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 01:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skCno-00062u-IS; Fri, 30 Aug 2024 21:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1skAFR-0004oB-Fw
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:37:41 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1skAFP-0004Ec-Ml
 for qemu-devel@nongnu.org; Fri, 30 Aug 2024 18:37:41 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-277c861d9f6so205455fac.2
 for <qemu-devel@nongnu.org>; Fri, 30 Aug 2024 15:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725057458; x=1725662258; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Er3RRvkf2zFkFd1d2lNHTkLGepGQdy7qmf7VH2ADMNg=;
 b=ToQoV76c4Zg0WuEW3MaDC1BrNzclUd4SROZ8gTksog784TF+a2fKN5n6NHd3BVYJd9
 AH2fczI72hMVJyRR4e9WL8hqoN4Bb129R5zkL43sclSSu74jbAYwYX0ASB6Q/OGJJQq5
 4mpUDBe8fSCc/GnZ+lsZ2KNlLxEz4gwjeuKOZZg8A2P+30oGKCHDFO2nNx9jvCMx91qv
 milNFmj3RwYLXkTF1c1HHLbrKACGLeNcoaXf/rEnHOzu2LM7MiH26xbmkmO9VZtpi5nX
 XKkOk0hUWxNhCo1VJeKuzJdBUODIn6TkR/jl6EZQwrDJEAMVkpaYQOg3o7yRuUcSh98s
 PHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725057458; x=1725662258;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Er3RRvkf2zFkFd1d2lNHTkLGepGQdy7qmf7VH2ADMNg=;
 b=C0Lno0NUoZ73O22aCcFmzSOzKhwGBKi4jdAs0K6xzks21b2VsRaUvIxShTWHaOuS7p
 A5UJYZs6eDlo//xmqSkB/VQLPMK1OBXGSd/0AlN+jpWfkBLUcgbOrnsDGd1kSzD3uRr/
 2bufrPimBeEm1jPtx2IxH43VOqMeRc8E54xvktVbS795D38RTqki2TBqNxih+4h6xj4s
 iayPz+iNXY5lkZzvbcLfeLnVLbLrH/BfmJC/U50sJBtayJjB3chpsk16bBLUDrT05sIA
 o6CfQtjChgmrGluYk9QV7gY5/m+tinhaSNFw3vsdPFcsOdtdfXqKLXnJtrnCO34LgWgM
 y8uw==
X-Gm-Message-State: AOJu0YyE2HNtoH0hmkD+E2pOm4f+Gf8YTkuZmhQXfXfAqn0etVXoe/Fw
 wzaphI+2DpuDq02+2+F+dhFbv7nnpMVZZRpU9xuWZaz4Gu65NNvJYVqxg0Sy6kUvSFS0iLvAhE8
 B+AKK8Ia3PHm3NqoknnZsIPoMRmQvhw==
X-Google-Smtp-Source: AGHT+IGjoiocg9eT14Z029MT1giIvggikiWldZ4XDrk+3S8VRYq2wIc9PywW6Alz9XpeIbCIrEiawKDvRv7j0AVRd10=
X-Received: by 2002:a05:6871:24c5:b0:269:2708:aff6 with SMTP id
 586e51a60fabf-277900cfd38mr7916354fac.16.1725057458163; Fri, 30 Aug 2024
 15:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
In-Reply-To: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Fri, 30 Aug 2024 15:37:27 -0700
Message-ID: <CAFUsyf+NgiOrzUEK_0Y6DxBG+49FLckbu_NdLQQ1LqWhDdVfMQ@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-oa1-x35.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 30 Aug 2024 21:21:16 -0400
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

On Fri, Aug 30, 2024 at 3:36=E2=80=AFPM Noah Goldstein <goldstein.w.n@gmail=
.com> wrote:
>
> The new option '-qemu-children' makes it so that on `execve` the child
> process will be launch by the same `qemu` executable that is currently
> running along with its current commandline arguments.
>
> The motivation for the change is to make it so that plugins running
> through `qemu` can continue to run on children.  Why not just
> `binfmt`?: Plugins can be desirable regardless of system/architecture
> emulation, and can sometimes be useful for elf files that can run
> natively. Enabling `binfmt` for all natively runnable elf files may
> not be desirable.
>
> Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> ---
>  linux-user/main.c           | 22 ++++++++++++++++++++++
>  linux-user/syscall.c        | 20 +++++++++++++++-----
>  linux-user/user-internals.h |  4 ++++
>  3 files changed, 41 insertions(+), 5 deletions(-)
>
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8143a0d4b0..dfb303a1f2 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
>  uintptr_t guest_base;
>  bool have_guest_base;
>
> +bool qemu_dup_for_children;
> +int qemu_argc;
> +char ** qemu_argv;
> +
>  /*
>   * Used to implement backwards-compatibility for the `-strace`, and
>   * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten by
> @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
>      perf_enable_jitdump();
>  }
>
> +static void handle_arg_qemu_children(const char *arg)
> +{
> +    qemu_dup_for_children =3D true;
> +}
> +
>  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
>
>  #ifdef CONFIG_PLUGIN
> @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D {
>       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
>      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
>       "",           "Generate a jit-${pid}.dump file for perf"},
> +    {"qemu-children",
> +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children,
> +     "",           "Run child processes (created with execve) with qemu =
"
> +                   "(as instantiated for the parent)"},
>      {NULL, NULL, false, NULL, NULL, NULL}
>  };
>
> @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
>
>      optind =3D parse_args(argc, argv);
>
> +    if (qemu_dup_for_children) {
> +        int i;
> +        qemu_argc =3D optind;
> +        qemu_argv =3D g_new0(char *, qemu_argc);
> +        for (i =3D 0; i < optind; ++i) {
> +            qemu_argv[i] =3D strdup(argv[i]);
> +        }
> +    }
> +
>      qemu_set_log_filename_flags(last_log_filename,
>                                  last_log_mask | (enable_strace * LOG_STR=
ACE),
>                                  &error_fatal);
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 9d5415674d..732ef89054 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env, int di=
rfd,
>                      abi_long pathname, abi_long guest_argp,
>                      abi_long guest_envp, int flags, bool is_execveat)
>  {
> -    int ret;
> +    int ret, argp_offset;
>      char **argp, **envp;
>      int argc, envc;
>      abi_ulong gp;
>      abi_ulong addr;
>      char **q;
>      void *p;
> +    bool through_qemu =3D !is_execveat && qemu_dup_for_children;
>
I wasn't sure if this was feasible for `evecveat`. If anyone has any though=
ts
it would be nice to support that as well.

>      argc =3D 0;
>
> @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env, int di=
rfd,
>          envc++;
>      }
>
> -    argp =3D g_new0(char *, argc + 1);
> +    argp_offset =3D through_qemu ? qemu_argc : 0;
> +    argp =3D g_new0(char *, argc + argp_offset + 1);
>      envp =3D g_new0(char *, envc + 1);
>
> -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset; gp; gp +=3D sizeof=
(abi_ulong), q++) {
>          if (get_user_ual(addr, gp)) {
>              goto execve_efault;
>          }
> @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int dir=
fd,
>      }
>
>      const char *exe =3D p;
> -    if (is_proc_myself(p, "exe")) {
> +    if (through_qemu) {
> +        int i;
> +        for (i =3D 0; i < argp_offset; ++i) {
> +            argp[i] =3D qemu_argv[i];
> +        }
> +        exe =3D qemu_argv[0];
> +    }
> +    else if (is_proc_myself(p, "exe")) {
>          exe =3D exec_path;
>      }
> +
>      ret =3D is_execveat
>          ? safe_execveat(dirfd, exe, argp, envp, flags)
>          : safe_execve(exe, argp, envp);
> @@ -8553,7 +8563,7 @@ execve_efault:
>      ret =3D -TARGET_EFAULT;
>
>  execve_end:
> -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong), q=
++) {
> +    for (gp =3D guest_argp, q =3D argp + argp_offset; *q; gp +=3D sizeof=
(abi_ulong), q++) {
>          if (get_user_ual(addr, gp) || !addr) {
>              break;
>          }
> diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> index 5c7f173ceb..0719e65ff4 100644
> --- a/linux-user/user-internals.h
> +++ b/linux-user/user-internals.h
> @@ -30,6 +30,10 @@ void stop_all_tasks(void);
>  extern const char *qemu_uname_release;
>  extern unsigned long mmap_min_addr;
>
> +extern bool qemu_dup_for_children;
> +extern int qemu_argc;
> +extern char ** qemu_argv;
> +
>  typedef struct IOCTLEntry IOCTLEntry;
>
>  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
> --
> 2.34.1
>

