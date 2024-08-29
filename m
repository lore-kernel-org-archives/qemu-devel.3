Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF500C83F12
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2024 12:26:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjeE7-0002dU-5f; Thu, 29 Aug 2024 08:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjeE2-0002ck-GF
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:26:06 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sjeDy-0000ZS-Bu
 for qemu-devel@nongnu.org; Thu, 29 Aug 2024 08:26:05 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c0abaae174so609929a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2024 05:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724934360; x=1725539160; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I+bFiiWHwg+S1SlMlqQlidd45CJKeyXad20DDKqFU2o=;
 b=D02+DVOD2tOZpelR2kx/c65dA4ftWR/yytSxLb5vYekr3Z6FoosKSGioe1++SxbKK+
 7MekJpJOH4t0QrRnbc9cb9IyRDd4JgFhv2k5mhNEhc/8yaNrmyXdfPU04//lIgL42OUD
 3tV3Ugqdk4LPiRMSpNqKI3GyfeJXlGcZhIGNnTV5CyaPA5bY5SKMn+9uH2wWOPewZzE+
 5ujCwonDAaZe5In0P7tP1aob0wys31guLN1tyrbnO40vN/SkUmAgDX66WieOs8WU1Xal
 oF+eqHDgGNanvwaLvGj/G8IA5EwX79ItRbQVtNgH30niQNNGXWR5pBt50jx/JCN6Jx0o
 jmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724934360; x=1725539160;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I+bFiiWHwg+S1SlMlqQlidd45CJKeyXad20DDKqFU2o=;
 b=Q8dPTBM1SPfFZAyY9H/GI9tN5GK3YEpRfw7HYx3o7eOdA6L0NDTIV9CKIRjilPQMMp
 N8Ao93Gkec/K4hGKLqT1qZ81ta6DoibuSg26qyjs7eYb96YvBAAjjbz7bIg+4ZvyuJCm
 yZgYRvTvSicgRC/SwquzHi5AEglcePCH8JqDbV3bG331Apj0VYCsXpiWR5Ndb3qUfueB
 4/QbqJ+4qI9zaH9Pt5GptOk5wLoC1UhCi/4Ae08+8iRc+gFp4CE7BPxG8nACCz6WzvKz
 P+by23P59gY6STcOxCQRG1+f8+98S4UYcHlfIZUTwcHYsDRy7d/mvpb+DSKSYF1W/r7z
 TmGA==
X-Gm-Message-State: AOJu0Yz6sOz4ITPRS87/5cAOIOv6mpZ1oOJ1K5cL8VNeQBN8x82Wa/14
 wwRrKEu+YLo8/EoXYN8qQeRNGF+6ezwBjwchqKhnn+yju2lnAVz3nybKtcc4qnx46mdebRZVsJv
 X6L6NxueyIESBewj5HWaTRfdTLsI4TkrXG8apdF+78NUQOzUN
X-Google-Smtp-Source: AGHT+IHC8/wXa5Syp5YUDA4i4v4b/T3UR2z7j5XDJpD9BUpAwwScn3hMSIRWt7IBA2VKCqIOiJ9kmdi/0tn7hSDDYek=
X-Received: by 2002:a17:907:7e94:b0:a7a:a3f7:389e with SMTP id
 a640c23a62f3a-a897f78daccmr246547066b.6.1724934359916; Thu, 29 Aug 2024
 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240815122747.3053871-1-peter.maydell@linaro.org>
In-Reply-To: <20240815122747.3053871-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 29 Aug 2024 13:25:48 +0100
Message-ID: <CAFEAcA8avK960jpseD-QUb8Ef_hGem1LDstF=bxgb0Beb53YFg@mail.gmail.com>
Subject: Re: [PATCH for-9.2] kvm: Use 'unsigned long' for request argument in
 functions wrapping ioctl()
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Johannes Stoelp <johannes.stoelp@googlemail.com>,
 Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x532.google.com
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

Ping for code review, please?

thanks
-- PMM

On Thu, 15 Aug 2024 at 13:27, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> From: Johannes Stoelp <johannes.stoelp@googlemail.com>
>
> Change the data type of the ioctl _request_ argument from 'int' to
> 'unsigned long' for the various accel/kvm functions which are
> essentially wrappers around the ioctl() syscall.
>
> The correct type for ioctl()'s 'request' argument is confused:
>  * POSIX defines the request argument as 'int'
>  * glibc uses 'unsigned long' in the prototype in sys/ioctl.h
>  * the glibc info documentation uses 'int'
>  * the Linux manpage uses 'unsigned long'
>  * the Linux implementation of the syscall uses 'unsigned int'
>
> If we wrap ioctl() with another function which uses 'int' as the
> type for the request argument, then requests with the 0x8000_0000
> bit set will be sign-extended when the 'int' is cast to
> 'unsigned long' for the call to ioctl().
>
> On x86_64 one such example is the KVM_IRQ_LINE_STATUS request.
> Bit requests with the _IOC_READ direction bit set, will have the high
> bit set.
>
> Fortunately the Linux Kernel truncates the upper 32bit of the request
> on 64bit machines (because it uses 'unsigned int', and see also Linus
> Torvalds' comments in
>   https://sourceware.org/bugzilla/show_bug.cgi?id=14362 )
> so this doesn't cause active problems for us.  However it is more
> consistent to follow the glibc ioctl() prototype when we define
> functions that are essentially wrappers around ioctl().
>
> This resolves a Coverity issue where it points out that in
> kvm_get_xsave() we assign a value (KVM_GET_XSAVE or KVM_GET_XSAVE2)
> to an 'int' variable which can't hold it without overflow.
>
> Resolves: Coverity CID 1547759
> Signed-off-by: Johannes Stoelp <johannes.stoelp@gmail.com>
> [PMM: Rebased patch, adjusted commit message, included note about
>  Coverity fix, updated the type of the local var in kvm_get_xsave,
>  updated the comment in the KVMState struct definition]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is a patch that was posted back in 2021, and I reviewed it
> at the time
> https://lore.kernel.org/qemu-devel/20210901213426.360748-1-johannes.stoelp@gmail.com/
> but we never actually took it into the tree. I was reminded of it
> by the Coverity issue, where a change to Coverity means it now
> complains about the potential integer overflow when we put one
> of these high-bit-set ioctls into an "int". So I thought it would
> be worth dusting this off and getting it upstream.
>
> For more discussion of the ioctl request datatype see also the
> review thread on the previous version of the patch:
> https://lore.kernel.org/qemu-devel/CAFEAcA8TRQdj33Ycm=XzmuUUNApaXVgeDexfS+3Ycg6kLnpmyg@mail.gmail.com/
>
> Since this doesn't actually cause any incorrect behaviour this
> is obviously for-9.2 material.
> ---
>  include/sysemu/kvm.h     |  8 ++++----
>  include/sysemu/kvm_int.h | 16 ++++++++++++----
>  accel/kvm/kvm-all.c      |  8 ++++----
>  target/i386/kvm/kvm.c    |  3 ++-
>  accel/kvm/trace-events   |  8 ++++----
>  5 files changed, 26 insertions(+), 17 deletions(-)
>
> diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
> index 9cf14ca3d5b..613d3f7581f 100644
> --- a/include/sysemu/kvm.h
> +++ b/include/sysemu/kvm.h
> @@ -235,11 +235,11 @@ static inline int kvm_update_guest_debug(CPUState *cpu, unsigned long reinject_t
>
>  /* internal API */
>
> -int kvm_ioctl(KVMState *s, int type, ...);
> +int kvm_ioctl(KVMState *s, unsigned long type, ...);
>
> -int kvm_vm_ioctl(KVMState *s, int type, ...);
> +int kvm_vm_ioctl(KVMState *s, unsigned long type, ...);
>
> -int kvm_vcpu_ioctl(CPUState *cpu, int type, ...);
> +int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...);
>
>  /**
>   * kvm_device_ioctl - call an ioctl on a kvm device
> @@ -248,7 +248,7 @@ int kvm_vcpu_ioctl(CPUState *cpu, int type, ...);
>   *
>   * Returns: -errno on error, nonnegative on success
>   */
> -int kvm_device_ioctl(int fd, int type, ...);
> +int kvm_device_ioctl(int fd, unsigned long type, ...);
>
>  /**
>   * kvm_vm_check_attr - check for existence of a specific vm attribute
> diff --git a/include/sysemu/kvm_int.h b/include/sysemu/kvm_int.h
> index 1d8fb1473bd..b52e3483511 100644
> --- a/include/sysemu/kvm_int.h
> +++ b/include/sysemu/kvm_int.h
> @@ -122,10 +122,18 @@ struct KVMState
>      bool sync_mmu;
>      bool guest_state_protected;
>      uint64_t manual_dirty_log_protect;
> -    /* The man page (and posix) say ioctl numbers are signed int, but
> -     * they're not.  Linux, glibc and *BSD all treat ioctl numbers as
> -     * unsigned, and treating them as signed here can break things */
> -    unsigned irq_set_ioctl;
> +    /*
> +     * POSIX says that ioctl numbers are signed int, but in practice
> +     * they are not. Linux, glibc and *BSD all treat ioctl numbers as
> +     * unsigned, and real-world ioctl values like KVM_GET_XSAVE have
> +     * bit 31 set, which means that passing them via an 'int' will
> +     * result in sign-extension when they get converted back to the
> +     * 'unsigned long' which the ioctl() prototype uses. Luckily Linux
> +     * always treats the argument as an unsigned 32-bit int, so any
> +     * possible sign-extension is deliberately ignored, but for
> +     * consistency we keep to the same type that glibc is using.
> +     */
> +    unsigned long irq_set_ioctl;
>      unsigned int sigmask_len;
>      GHashTable *gsimap;
>  #ifdef KVM_CAP_IRQ_ROUTING
> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> index 75d11a07b2b..beb1988d12c 100644
> --- a/accel/kvm/kvm-all.c
> +++ b/accel/kvm/kvm-all.c
> @@ -3170,7 +3170,7 @@ int kvm_cpu_exec(CPUState *cpu)
>      return ret;
>  }
>
> -int kvm_ioctl(KVMState *s, int type, ...)
> +int kvm_ioctl(KVMState *s, unsigned long type, ...)
>  {
>      int ret;
>      void *arg;
> @@ -3188,7 +3188,7 @@ int kvm_ioctl(KVMState *s, int type, ...)
>      return ret;
>  }
>
> -int kvm_vm_ioctl(KVMState *s, int type, ...)
> +int kvm_vm_ioctl(KVMState *s, unsigned long type, ...)
>  {
>      int ret;
>      void *arg;
> @@ -3208,7 +3208,7 @@ int kvm_vm_ioctl(KVMState *s, int type, ...)
>      return ret;
>  }
>
> -int kvm_vcpu_ioctl(CPUState *cpu, int type, ...)
> +int kvm_vcpu_ioctl(CPUState *cpu, unsigned long type, ...)
>  {
>      int ret;
>      void *arg;
> @@ -3228,7 +3228,7 @@ int kvm_vcpu_ioctl(CPUState *cpu, int type, ...)
>      return ret;
>  }
>
> -int kvm_device_ioctl(int fd, int type, ...)
> +int kvm_device_ioctl(int fd, unsigned long type, ...)
>  {
>      int ret;
>      void *arg;
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index 2fa88ef1e37..ada581c5d6e 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -4102,7 +4102,8 @@ static int kvm_get_xsave(X86CPU *cpu)
>  {
>      CPUX86State *env = &cpu->env;
>      void *xsave = env->xsave_buf;
> -    int type, ret;
> +    unsigned long type;
> +    int ret;
>
>      type = has_xsave2 ? KVM_GET_XSAVE2 : KVM_GET_XSAVE;
>      ret = kvm_vcpu_ioctl(CPU(cpu), type, xsave);
> diff --git a/accel/kvm/trace-events b/accel/kvm/trace-events
> index 37626c1ac5d..82c65fd2ab8 100644
> --- a/accel/kvm/trace-events
> +++ b/accel/kvm/trace-events
> @@ -1,11 +1,11 @@
>  # See docs/devel/tracing.rst for syntax documentation.
>
>  # kvm-all.c
> -kvm_ioctl(int type, void *arg) "type 0x%x, arg %p"
> -kvm_vm_ioctl(int type, void *arg) "type 0x%x, arg %p"
> -kvm_vcpu_ioctl(int cpu_index, int type, void *arg) "cpu_index %d, type 0x%x, arg %p"
> +kvm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
> +kvm_vm_ioctl(unsigned long type, void *arg) "type 0x%lx, arg %p"
> +kvm_vcpu_ioctl(int cpu_index, unsigned long type, void *arg) "cpu_index %d, type 0x%lx, arg %p"
>  kvm_run_exit(int cpu_index, uint32_t reason) "cpu_index %d, reason %d"
> -kvm_device_ioctl(int fd, int type, void *arg) "dev fd %d, type 0x%x, arg %p"
> +kvm_device_ioctl(int fd, unsigned long type, void *arg) "dev fd %d, type 0x%lx, arg %p"
>  kvm_failed_reg_get(uint64_t id, const char *msg) "Warning: Unable to retrieve ONEREG %" PRIu64 " from KVM: %s"
>  kvm_failed_reg_set(uint64_t id, const char *msg) "Warning: Unable to set ONEREG %" PRIu64 " to KVM: %s"
>  kvm_init_vcpu(int cpu_index, unsigned long arch_cpu_id) "index: %d id: %lu"
> --
> 2.34.1

