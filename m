Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2704D3A66B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:28:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5o8N-0006oa-3h; Tue, 29 Oct 2024 11:27:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t5o8K-0006o0-Ec
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:27:49 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <goldstein.w.n@gmail.com>)
 id 1t5o8I-0001U3-Oe
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:27:48 -0400
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-718078c7f53so2541095a34.1
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730215664; x=1730820464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Nhul674GEg7qP7yMeE0m5dN+ZvQJNgcJpp88KqUawg=;
 b=L50U+AMlbNNFYmbWeRcpvosoe4HuHUeOKlaQSDVQOjV6hqaIA1pBttP5tgAgDQOSDI
 fn5ljdrq4l+XpsQyKjFplZFkuJouvXUahNY+RnZLYhYAsoqfCWjotD5+z0nZX53tSRe2
 IEdoBfhHnAeRz9vHYiyktep9PRoOSALV8WjEubC3mRDn3GwA66xo2FbWoHibBPV9bfyr
 +Tzpsr1j/8rv/C6jB89XafD2jeJcasAZeC712nVS3ioooOrRqJt3pWsGKM1e1YX12orl
 1cbzD2fbVz8w1XuNcj2aSnDWQOlzTzdw1+S9uhLTduBO3mJQo8yjOL/CBUUS/CA084dX
 273A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730215664; x=1730820464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Nhul674GEg7qP7yMeE0m5dN+ZvQJNgcJpp88KqUawg=;
 b=FzmG3SmnE5BcO54F4RtHBlrccgwNKP4B9fs4gT/UFZ/Cr9L/ecrsOdqkzWGZE7IUby
 6MlNHsD0a4Z4bDdttiR4VesGlrshptd0KiHLPBmNt+ygc4H4F1dNGG3ZNdoGimFgU8Bp
 BwDC+R1ycyotUTyfXwlnUrVt/K4M5l+/eqkmrrLl+OWW4POJ7CLS1EEPdIFyT74Faqco
 +RoFIs7b0cipDw07Nq6KWayJkQsNDjSgYxFD4EAyxiJOv6/e+yR4ShOTVXgUXgrCK3sh
 QQfMkQE8U+E0yP48caqVm/ILASNxk2sOF+yJwpnGzEjppd3awLmqbkxywqCF5dCxPfrb
 CctQ==
X-Gm-Message-State: AOJu0YwIGNjsnLHjA15IvRwHNYmKgqqWJqzrVYT7KMbMBU6/Z24lSKNH
 GQY7HfoQp11pvkIzsSP0YyYTTz3aD4VcSIItSTyexp+bgkV5z1mdlf7PK214Iy1M5PlafKi8Nw6
 1RvvY17RjEAjd4JR4MDeFQ+HpQXg=
X-Google-Smtp-Source: AGHT+IFrjiyE9bC03zMuisyvCFR3zPmUR2zRynt9zIAW7f1hhcaTAmv4WRsOvuakJoUsdBFGqlF3Qjpp9KzZJAaEIro=
X-Received: by 2002:a05:6830:7196:b0:710:f1e3:f681 with SMTP id
 46e09a7af769-7188a128d01mr1459510a34.9.1730215664162; Tue, 29 Oct 2024
 08:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240830223601.2796327-1-goldstein.w.n@gmail.com>
 <87iktb6ih6.fsf@draig.linaro.org>
In-Reply-To: <87iktb6ih6.fsf@draig.linaro.org>
From: Noah Goldstein <goldstein.w.n@gmail.com>
Date: Tue, 29 Oct 2024 10:27:33 -0500
Message-ID: <CAFUsyfL1hz-xi3D7Pfd3wty4AZGq=mb-_bc_GoKcZ4sM3e1vtA@mail.gmail.com>
Subject: Re: [PATCH v1] linux-user: Add option to run `execve`d programs
 through QEMU
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=goldstein.w.n@gmail.com; helo=mail-ot1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 29, 2024 at 10:23=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@lina=
ro.org> wrote:
>
> Noah Goldstein <goldstein.w.n@gmail.com> writes:
>
> > The new option '-qemu-children' makes it so that on `execve` the child
> > process will be launch by the same `qemu` executable that is currently
> > running along with its current commandline arguments.
> >
> > The motivation for the change is to make it so that plugins running
> > through `qemu` can continue to run on children.  Why not just
> > `binfmt`?: Plugins can be desirable regardless of system/architecture
> > emulation, and can sometimes be useful for elf files that can run
> > natively. Enabling `binfmt` for all natively runnable elf files may
> > not be desirable.
>
> Broadly I don't see anything wrong with the patch. However my principle
> concern is how test it. Currently nothing in check-tcg ensures this
> mechanism works and stresses the argument copying.

Fair enough. I will add some tests.
>
> >
> > Signed-off-by: Noah Goldstein <goldstein.w.n@gmail.com>
> > ---
> >  linux-user/main.c           | 22 ++++++++++++++++++++++
> >  linux-user/syscall.c        | 20 +++++++++++++++-----
> >  linux-user/user-internals.h |  4 ++++
> >  3 files changed, 41 insertions(+), 5 deletions(-)
> >
> > diff --git a/linux-user/main.c b/linux-user/main.c
> > index 8143a0d4b0..dfb303a1f2 100644
> > --- a/linux-user/main.c
> > +++ b/linux-user/main.c
> > @@ -81,6 +81,10 @@ unsigned long mmap_min_addr;
> >  uintptr_t guest_base;
> >  bool have_guest_base;
> >
> > +bool qemu_dup_for_children;
> > +int qemu_argc;
> > +char ** qemu_argv;
> > +
> >  /*
> >   * Used to implement backwards-compatibility for the `-strace`, and
> >   * QEMU_STRACE options. Without this, the QEMU_LOG can be overwritten =
by
> > @@ -451,6 +455,11 @@ static void handle_arg_jitdump(const char *arg)
> >      perf_enable_jitdump();
> >  }
> >
> > +static void handle_arg_qemu_children(const char *arg)
> > +{
> > +    qemu_dup_for_children =3D true;
> > +}
> > +
> >  static QemuPluginList plugins =3D QTAILQ_HEAD_INITIALIZER(plugins);
> >
> >  #ifdef CONFIG_PLUGIN
> > @@ -526,6 +535,10 @@ static const struct qemu_argument arg_table[] =3D =
{
> >       "",           "Generate a /tmp/perf-${pid}.map file for perf"},
> >      {"jitdump",    "QEMU_JITDUMP",     false, handle_arg_jitdump,
> >       "",           "Generate a jit-${pid}.dump file for perf"},
> > +    {"qemu-children",
> > +                   "QEMU_CHILDREN",    false, handle_arg_qemu_children=
,
> > +     "",           "Run child processes (created with execve) with qem=
u "
> > +                   "(as instantiated for the parent)"},
> >      {NULL, NULL, false, NULL, NULL, NULL}
> >  };
> >
> > @@ -729,6 +742,15 @@ int main(int argc, char **argv, char **envp)
> >
> >      optind =3D parse_args(argc, argv);
> >
> > +    if (qemu_dup_for_children) {
> > +        int i;
> > +        qemu_argc =3D optind;
> > +        qemu_argv =3D g_new0(char *, qemu_argc);
> > +        for (i =3D 0; i < optind; ++i) {
> > +            qemu_argv[i] =3D strdup(argv[i]);
> > +        }
> > +    }
> > +
> >      qemu_set_log_filename_flags(last_log_filename,
> >                                  last_log_mask | (enable_strace * LOG_S=
TRACE),
> >                                  &error_fatal);
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 9d5415674d..732ef89054 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -8459,13 +8459,14 @@ static int do_execv(CPUArchState *cpu_env, int =
dirfd,
> >                      abi_long pathname, abi_long guest_argp,
> >                      abi_long guest_envp, int flags, bool is_execveat)
> >  {
> > -    int ret;
> > +    int ret, argp_offset;
> >      char **argp, **envp;
> >      int argc, envc;
> >      abi_ulong gp;
> >      abi_ulong addr;
> >      char **q;
> >      void *p;
> > +    bool through_qemu =3D !is_execveat && qemu_dup_for_children;
> >
> >      argc =3D 0;
> >
> > @@ -8489,10 +8490,11 @@ static int do_execv(CPUArchState *cpu_env, int =
dirfd,
> >          envc++;
> >      }
> >
> > -    argp =3D g_new0(char *, argc + 1);
> > +    argp_offset =3D through_qemu ? qemu_argc : 0;
> > +    argp =3D g_new0(char *, argc + argp_offset + 1);
> >      envp =3D g_new0(char *, envc + 1);
> >
> > -    for (gp =3D guest_argp, q =3D argp; gp; gp +=3D sizeof(abi_ulong),=
 q++) {
> > +    for (gp =3D guest_argp, q =3D argp + argp_offset; gp; gp +=3D size=
of(abi_ulong), q++) {
> >          if (get_user_ual(addr, gp)) {
> >              goto execve_efault;
> >          }
> > @@ -8537,9 +8539,17 @@ static int do_execv(CPUArchState *cpu_env, int d=
irfd,
> >      }
> >
> >      const char *exe =3D p;
> > -    if (is_proc_myself(p, "exe")) {
> > +    if (through_qemu) {
> > +        int i;
> > +        for (i =3D 0; i < argp_offset; ++i) {
> > +            argp[i] =3D qemu_argv[i];
> > +        }
> > +        exe =3D qemu_argv[0];
> > +    }
> > +    else if (is_proc_myself(p, "exe")) {
> >          exe =3D exec_path;
> >      }
> > +
> >      ret =3D is_execveat
> >          ? safe_execveat(dirfd, exe, argp, envp, flags)
> >          : safe_execve(exe, argp, envp);
> > @@ -8553,7 +8563,7 @@ execve_efault:
> >      ret =3D -TARGET_EFAULT;
> >
> >  execve_end:
> > -    for (gp =3D guest_argp, q =3D argp; *q; gp +=3D sizeof(abi_ulong),=
 q++) {
> > +    for (gp =3D guest_argp, q =3D argp + argp_offset; *q; gp +=3D size=
of(abi_ulong), q++) {
> >          if (get_user_ual(addr, gp) || !addr) {
> >              break;
> >          }
> > diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
> > index 5c7f173ceb..0719e65ff4 100644
> > --- a/linux-user/user-internals.h
> > +++ b/linux-user/user-internals.h
> > @@ -30,6 +30,10 @@ void stop_all_tasks(void);
> >  extern const char *qemu_uname_release;
> >  extern unsigned long mmap_min_addr;
> >
> > +extern bool qemu_dup_for_children;
> > +extern int qemu_argc;
> > +extern char ** qemu_argv;
> > +
> >  typedef struct IOCTLEntry IOCTLEntry;
> >
> >  typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro

