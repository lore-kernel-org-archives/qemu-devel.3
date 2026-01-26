Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427E0D19519
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 20:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkTFi-0003e3-3J; Mon, 26 Jan 2026 15:32:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkTFV-0003cA-R0
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:31:57 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vkTFT-0006fL-TC
 for qemu-devel@nongnu.org; Mon, 26 Jan 2026 15:31:49 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so41070315e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Jan 2026 12:31:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769459505; x=1770064305; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EOo7nqX/GPAdyn4aiSWZvKt4xp4MYueso7b5pMpApTY=;
 b=akVtWVXPttAkmnAeTQVeiVVVb/tqzqEf4O6DveDQAQl/ChazQhGWPjaysYmjNPoAOw
 a/KqqBAvLoJRqZByG2n4UugT2aLYePdF8bQ/jvdcb3nQPGjmyRtRLHJ9USljkh1lEW/9
 uqN1u2EioO1wuG9hzv1IyaOLr+hnwRpDTG4hmfHrqe+AIJr0NbMeiUjDoIZZn6ciOzHY
 qr2JCxoKzUUeO2DxRiXv94/UttMzUxIqg0WGqj/puNf+aKnyLe+f1Lt1ZZhP7p2fAd6m
 /4aAA8Px+ztXULjSjmc7KYTpoRyXx/xPdHgHcpxIsrOb/6rFnBZxtJcWLgj0FAKK79oP
 LsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769459505; x=1770064305;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EOo7nqX/GPAdyn4aiSWZvKt4xp4MYueso7b5pMpApTY=;
 b=i1/QA4MCIP/BO+PsM15f4awOf+rJmdIxPpCxV2vk+LgnubZvrLIU7MBNu8QJ/sCEWp
 N0ekzpEfxBrw2H4PPP6fY1XnvoXQhbFgY6gUCVM+Ghf0Pm6aNJ5KVQnfYDZhLBrEqKzT
 kAhenY4E/LqbSCNkxY5O4wX86JDUgcC9s335j0/XbjzycY1SO0NwPzv0AAFBlbytf6bX
 wQ8wn0tiQaW58M2wQmgNh9bl3sx2JwioQAEEBNtL/m4uJYJzxF+aTtxm+V7r4Bd/X31a
 erdf1Ft10ZPUgwxM3ez0pNMJK5L/45IHTAQNqIfYYhpMEZapregy4PbIFcJqquVBuKyE
 5Pkg==
X-Gm-Message-State: AOJu0YwHgGtNKWXMh0+wMQ5CUFH6MlcdM/vsUVt0lUz/5tomq9nLF0C6
 JCFJVsaR0DXKvV8qvBJ0eP1FhY2wu5DVMzykg49Nqa2xVCKOBkSemoj7ap+/Yz5qNrk=
X-Gm-Gg: AZuq6aJzF++nsM4sW7WVq056d5h+K7oqxGz0K3CUNNtWo8R1tURMqu8Uaq/vahiKJDP
 ylnyHDktJab7W/Dn9TvDJGFn85v1tCArt9WJUHiErYhdAstQF8DlVu+ikTjc/NotYVuCIo3wEKu
 8osb4Dtzfb8AKAjD41bbV6yTilSITbKQIda9RlQqR8yJCP3HtNvwBxWV+YoswerXXdxCCK0Br8a
 8EbLQo8iwB9hA/kkrOluAR+8pPOXmbAIJ52AnRPICOq6uqvseZw2ai02fJLieI6XabGLWXR5SZW
 z8s6L9Yo4RLF5RPOUFx2x0Fajp2ZPmPVvbQr2YQfcJxViAxELHoXzPozJ0WnzPlEJ+kt8QD+Uy9
 CSdRprYQrqAYcUBSzsQ1s+BEgybBs2MPsC+IH+PbKS8t5lwZnbQ+G07Q50Ps0KSluq1GDx6sZN2
 jB3OKWMB1AidGk
X-Received: by 2002:a05:600c:3b27:b0:47e:e20e:bbb7 with SMTP id
 5b1f17b1804b1-4805cf669a7mr91239925e9.25.1769459505235; 
 Mon, 26 Jan 2026 12:31:45 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066aaf30esm13147695e9.0.2026.01.26.12.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 12:31:44 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CD83C5F80B;
 Mon, 26 Jan 2026 20:31:43 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Florian Hofhammer <florian.hofhammer@epfl.ch>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org,
 richard.henderson@linaro.org,  laurent@vivier.eu,  imp@bsdimp.com,
 berrange@redhat.com
Subject: Re: [PATCH v3 1/5] plugins: add PC diversion API function
In-Reply-To: <019586c9-94a0-4bcb-8a8b-4605c32754ed@epfl.ch> (Florian
 Hofhammer's message of "Tue, 20 Jan 2026 16:22:00 +0100")
References: <ef60bfbb-cc12-4411-acc1-8c131726f22e@epfl.ch>
 <019586c9-94a0-4bcb-8a8b-4605c32754ed@epfl.ch>
User-Agent: mu4e 1.14.0-pre1; emacs 30.1
Date: Mon, 26 Jan 2026 20:31:43 +0000
Message-ID: <87v7gocdzk.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Florian Hofhammer <florian.hofhammer@epfl.ch> writes:

> This patch adds a plugin API function that allows diverting the program
> counter during execution. A potential use case for this functionality is
> to skip over parts of the code, e.g., by hooking into a specific
> instruction and setting the PC to the next instruction in the callback.
>
> Redirecting control flow via cpu_loop_exit() works fine in callbacks
> that are triggered during code execution due to cpu_exec_setjmp() still
> being part of the call stack. If we want to use the new API in syscall
> callbacks, cpu_exec_setjmp() already returned and the longjmp()
> triggered by cpu_loop_exit() is undefined behavior. For this reason, we
> introduce a new return constant QEMU_ESETPC and do another setjmp()
> before executing syscall plugin callbacks and potentially the syscall
> itself.

I think we want to split this up into:

  - introduce the flags
  - re-factor the linux-user to use an inline helper (qemu_syscall_finalize=
_pc(ret)?)
  - implement the api call, tweak qemu_finalize_pc

>
> Link: https://lists.nongnu.org/archive/html/qemu-devel/2025-08/msg00656.h=
tml
> Signed-off-by: Florian Hofhammer <florian.hofhammer@epfl.ch>
> ---
>  include/qemu/qemu-plugin.h         | 15 +++++++++++++++
>  linux-user/aarch64/cpu_loop.c      |  2 +-
>  linux-user/alpha/cpu_loop.c        |  2 +-
>  linux-user/arm/cpu_loop.c          |  2 +-
>  linux-user/hexagon/cpu_loop.c      |  2 +-
>  linux-user/hppa/cpu_loop.c         |  4 ++++
>  linux-user/i386/cpu_loop.c         |  8 +++++---
>  linux-user/include/special-errno.h |  8 ++++++++
>  linux-user/loongarch64/cpu_loop.c  |  5 +++--
>  linux-user/m68k/cpu_loop.c         |  2 +-
>  linux-user/microblaze/cpu_loop.c   |  2 +-
>  linux-user/mips/cpu_loop.c         |  5 +++--
>  linux-user/openrisc/cpu_loop.c     |  2 +-
>  linux-user/ppc/cpu_loop.c          |  6 ++++--
>  linux-user/riscv/cpu_loop.c        |  2 +-
>  linux-user/s390x/cpu_loop.c        |  2 +-
>  linux-user/sh4/cpu_loop.c          |  2 +-
>  linux-user/sparc/cpu_loop.c        |  4 +++-
>  linux-user/syscall.c               |  8 ++++++++
>  linux-user/xtensa/cpu_loop.c       |  3 +++
>  plugins/api.c                      | 17 ++++++++++++++++-
>  plugins/core.c                     | 25 ++++++++++++++-----------
>  22 files changed, 96 insertions(+), 32 deletions(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 60de4fdd3f..f976b62030 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -321,11 +321,14 @@ typedef struct {
>   * @QEMU_PLUGIN_CB_NO_REGS: callback does not access the CPU's regs
>   * @QEMU_PLUGIN_CB_R_REGS: callback reads the CPU's regs
>   * @QEMU_PLUGIN_CB_RW_REGS: callback reads and writes the CPU's regs
> + * @QEMU_PLUGIN_CB_RW_REGS_PC: callback reads and writes the CPU's
> + *                             regs and updates the PC
>   */
>  enum qemu_plugin_cb_flags {
>      QEMU_PLUGIN_CB_NO_REGS,
>      QEMU_PLUGIN_CB_R_REGS,
>      QEMU_PLUGIN_CB_RW_REGS,
> +    QEMU_PLUGIN_CB_RW_REGS_PC,
>  };

Hmm should we consider making this an enum? or...

>=20=20
<snip>
> diff --git a/plugins/core.c b/plugins/core.c
> index b4b783008f..9e9a066669 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -395,15 +395,16 @@ void plugin_register_dyn_cb__udata(GArray **arr,
>                                     enum qemu_plugin_cb_flags flags,
>                                     void *udata)
>  {
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_udata_cb_t:
>           *   void (*)(uint32_t, void *)
>           */
> -        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
> +        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
>                                dh_typemask(i32, 1) |
>                                dh_typemask(ptr, 2))

...are we effectively ordering callback types here?

>      };
> @@ -425,15 +426,16 @@ void plugin_register_dyn_cond_cb__udata(GArray **ar=
r,
>                                          uint64_t imm,
>                                          void *udata)
>  {
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_udata_cb_t:
>           *   void (*)(uint32_t, void *)
>           */
> -        [0 ... 2].typemask =3D (dh_typemask(void, 0) |
> +        [0 ... 3].typemask =3D (dh_typemask(void, 0) |
>                                dh_typemask(i32, 1) |
>                                dh_typemask(ptr, 2))
>      };
> @@ -464,15 +466,16 @@ void plugin_register_vcpu_mem_cb(GArray **arr,
>          !__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32_t) &&
>          !__builtin_types_compatible_p(qemu_plugin_meminfo_t, int32_t));
>=20=20
> -    static TCGHelperInfo info[3] =3D {
> +    static TCGHelperInfo info[4] =3D {
>          [QEMU_PLUGIN_CB_NO_REGS].flags =3D TCG_CALL_NO_RWG,
>          [QEMU_PLUGIN_CB_R_REGS].flags =3D TCG_CALL_NO_WG,
>          [QEMU_PLUGIN_CB_RW_REGS].flags =3D 0,
> +        [QEMU_PLUGIN_CB_RW_REGS_PC].flags =3D 0,
>          /*
>           * Match qemu_plugin_vcpu_mem_cb_t:
>           *   void (*)(uint32_t, qemu_plugin_meminfo_t, uint64_t, void *)
>           */
> -        [0 ... 2].typemask =3D
> +        [0 ... 3].typemask =3D
>              (dh_typemask(void, 0) |
>               dh_typemask(i32, 1) |
>               (__builtin_types_compatible_p(qemu_plugin_meminfo_t, uint32=
_t)
> @@ -534,7 +537,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, =
uint64_t a1, uint64_t a2,
>      QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>          qemu_plugin_vcpu_syscall_cb_t func =3D cb->f.vcpu_syscall;
>=20=20
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a=
7, a8);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -558,7 +561,7 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int6=
4_t num, int64_t ret)
>      QLIST_FOREACH_SAFE_RCU(cb, &plugin.cb_lists[ev], entry, next) {
>          qemu_plugin_vcpu_syscall_ret_cb_t func =3D cb->f.vcpu_syscall_re=
t;
>=20=20
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          func(cb->ctx->id, cpu->cpu_index, num, ret);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -568,7 +571,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>  {
>      /* idle and resume cb may be called before init, ignore in this case=
 */
>      if (cpu->cpu_index < plugin.num_vcpus) {
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_IDLE);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -577,7 +580,7 @@ void qemu_plugin_vcpu_idle_cb(CPUState *cpu)
>  void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
>  {
>      if (cpu->cpu_index < plugin.num_vcpus) {
> -        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS);
> +        qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
>          plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
>          qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
>      }
> @@ -848,6 +851,6 @@ enum qemu_plugin_cb_flags tcg_call_to_qemu_plugin_cb_=
flags(int flags)
>      } else if (flags & TCG_CALL_NO_WG) {
>          return QEMU_PLUGIN_CB_R_REGS;
>      } else {
> -        return QEMU_PLUGIN_CB_RW_REGS;
> +        return QEMU_PLUGIN_CB_RW_REGS_PC;
>      }
>  }

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

