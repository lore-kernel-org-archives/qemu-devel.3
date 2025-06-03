Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFEEC5AE59
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMsi-0000Xq-PB; Tue, 03 Jun 2025 04:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uMMse-0000Wj-BZ
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:20:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uMMsZ-0006si-C8
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:20:19 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442e9c00bf4so34249085e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1748938813; x=1749543613; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ytVo3I4Jj948IhQXe6T2docq7k4zZhFsaschVv85TZY=;
 b=aIb4QM0C6XBEirq8+NIzp05kVOlcRA17KbK6OLSCvk/8ezSlpJVuZY9nWs9MyY4EJO
 cW6gDiyLkcVVzg2LHWnNmasl8FqjRdvnWddgXbqSAsN4FXufBrJcH6DtOIrcj+BbIVSW
 3wNMXkfs6vZLcT1HlkwUQ1FG29k/5dKKdwSm9YHwnIgvGv7BYmJ/c+sDJvHvKzqUGDLM
 AREBFjSONEcsMu30maItSd/VvmdZrAr7pJE+GS5BK/QuFWnNX9n6BWbvolRSAJVCDMpM
 DABk1ZwxO9xQobl6wbcWlxtT4X5+bjxzm0FsEyD0r/vbOxOa6eD0B0zw27d+scab1e3X
 INFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938813; x=1749543613;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ytVo3I4Jj948IhQXe6T2docq7k4zZhFsaschVv85TZY=;
 b=v+wxsd9c8lX5PJUdjtetpHgaeVc16Shscn7LZqmcuPRmTbdYOigZeBcUEXnjenlDcT
 fDK9EoECMeN+3+Gy62eHWkIwn75UQN2450XNebGfCiJgfUb5nH/60kjJCR1nE1eKg8GB
 DTH/xmnzOvV8C/T8qUA4nZzM3FZs2muAKajGeqFrl3H4auyQC2BeYmFx2uUb/b1a0Rf+
 ztFSlu4dTDXyJ+QCn6SAqRO9P26G7Wjqhz+dCtgJryUx7zcnlX8F2ccAF4hcAoG62N3J
 3W8wU2YNTQadG3KHGvUZOHQeNU+om6fDCEJtalV+H3OWrOEzzp1zYmnoajE/EYcmU2FQ
 ePHw==
X-Gm-Message-State: AOJu0YxDLxte8/hjuojz+SnTuRw3dIicY5FYO66zksioVUrR7TsoElq9
 H6+1Y7/SOcFlXGfJGddbwN1Zqmi27l2Egkj658UFdv4PsT2xmG0e+V4p/6WOg/ahTxOP1IesVzY
 Rn2FJgtXdoXNMmjE4cM9vhM4F5DAapyk=
X-Gm-Gg: ASbGncurL78wncH9+dRrpi6pndASJjwRSi2NCWckJoyN9QVlcf5QlmTI8u8iHP54zD7
 wd3sGz2JT2r52wvnjlnNd1l5nX70hajhUaTLrWP0SvEUAFNoLrdvihYcxoEwk/kpRd8APhpstCe
 AqZy0XR4+k+XV81OZ34wXjLHUznwuOygC4
X-Google-Smtp-Source: AGHT+IGsY3JogtAT3jrlqpKjgEiJuji+GUAa+uVqds0kcT08ldeJfFDVeVphwFSh1mTThMc2t/sitFEGMzjCZuvIhk4=
X-Received: by 2002:a05:600c:3b8b:b0:442:e9eb:1b48 with SMTP id
 5b1f17b1804b1-450d8876132mr126983895e9.24.1748938812970; Tue, 03 Jun 2025
 01:20:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAJHT5-JwrQ31MEKKSNL-E0RPm+cg7UOiqzV5cPL-mnTOPa7eUA@mail.gmail.com>
 <87h60y41u1.fsf@draig.linaro.org>
 <CAJHT5-+tAuCoDV2G=-bZfP-j0gvY8Um-8TO8un2uNSGZpA1pcg@mail.gmail.com>
 <87bjr63y9i.fsf@draig.linaro.org>
In-Reply-To: <87bjr63y9i.fsf@draig.linaro.org>
From: Jon Wilson <jonwilson030981@googlemail.com>
Date: Tue, 3 Jun 2025 09:20:01 +0100
X-Gm-Features: AX0GCFsXRDtpT_S3f_sm9jlV9U_0-n2GTp41-GRoIg_diybNQ0_WTZFtsmEBwYQ
Message-ID: <CAJHT5-Ku6QRPY3mHm2_wEqNF+-8HPrMS2httv=wtWROPgDcr4Q@mail.gmail.com>
Subject: Re: TCG Address Sanitizer Optimization.
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000ae5a4f0636a68c61"
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--000000000000ae5a4f0636a68c61
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm not sure what is needed to be fair, I'm kind of focussed on just this
one
aspect of the emulation. The previous implementation of ASAN was to
implement
the shadow map in the host address space and translate all the guest memory
access using g2h using helpers to check the shadow map. This was done
through
necessity since older versions of QEMU didn't work well with allocating the
large sparse memory regions used for the shadow maps.

However, by lowering the shadow map into the guest address space, we can
omit
this additional translation stage and we can avoid the overhead (albeit
small)
of calling a helper function (and any associated register pressure caused
by
needing to put arguments in the correct registers to support the ABI). But
given the
code is on such a hot path, even tiny improvements get significantly
magnified.

I'm hopeful though, that if it is possible to optimize the fast path (e.g.
the
shadow map value is zero) that it may be possible to reduce the performance
overhead of ASAN even further.

Best Regards.

Jon

On Mon, Jun 2, 2025 at 5:26=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linaro=
.org> wrote:

> Jon Wilson <jonwilson030981@googlemail.com> writes:
>
> > It would be good if we could have QEMU provide clean APIs to allow the
> sort of additional instrumentation that fuzzing
> > requires. I guess the qemu-libafl-bridge project show the sort of
> modification which has been required so far...
> > https://github.com/AFLplusplus/qemu-libafl-bridge/tree/main/libafl
> >
> > I would like to conditionally call a helper, or even just insert a
> breakpoint instruction, but like I say I don't seem to be able to
> > make use of any sort of branches.
>
> For TCG plugins we have:
>
>   /**
>    * qemu_plugin_register_vcpu_tb_exec_cond_cb() - register conditional
> callback
>    * @tb: the opaque qemu_plugin_tb handle for the translation
>    * @cb: callback function
>    * @cond: condition to enable callback
>    * @entry: first operand for condition
>    * @imm: second operand for condition
>    * @flags: does the plugin read or write the CPU's registers?
>    * @userdata: any plugin data to pass to the @cb?
>    *
>    * The @cb function is called when a translated unit executes if
>    * entry @cond imm is true.
>    * If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never
> interpreted and
>    * this function is equivalent to qemu_plugin_register_vcpu_tb_exec_cb.
>    * If condition QEMU_PLUGIN_COND_NEVER, condition is never interpreted
> and
>    * callback is never installed.
>    */
>   QEMU_PLUGIN_API
>   void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb *t=
b,
>
>  qemu_plugin_vcpu_udata_cb_t cb,
>                                                  enum qemu_plugin_cb_flag=
s
> flags,
>                                                  enum qemu_plugin_cond
> cond,
>                                                  qemu_plugin_u64 entry,
>                                                  uint64_t imm,
>                                                  void *userdata);
>
> Along with qemu_plugin_register_vcpu_insn_exec_cond_cb() for individual
> instructions. They are designed work with per-cpu indexed scoreboards
> using inline operations (e.g.
> qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu) which can either add
> or store values.
>
> Currently we inline memory operations are a bit limited:
>
>   /**
>    * qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op for mem
> access
>    * @insn: handle for instruction to instrument
>    * @rw: apply to reads, writes or both
>    * @op: the op, of type qemu_plugin_op
>    * @entry: entry to run op
>    * @imm: immediate data for @op
>    *
>    * This registers a inline op every memory access generated by the
>    * instruction.
>    */
>   QEMU_PLUGIN_API
>   void qemu_plugin_register_vcpu_mem_inline_per_vcpu(
>       struct qemu_plugin_insn *insn,
>       enum qemu_plugin_mem_rw rw,
>       enum qemu_plugin_op op,
>       qemu_plugin_u64 entry,
>       uint64_t imm);
>
> Although you can get access to the memory information through helpers:
>
>   /**
>    * qemu_plugin_register_vcpu_mem_cb() - register memory access callback
>    * @insn: handle for instruction to instrument
>    * @cb: callback of type qemu_plugin_vcpu_mem_cb_t
>    * @flags: (currently unused) callback flags
>    * @rw: monitor reads, writes or both
>    * @userdata: opaque pointer for userdata
>    *
>    * This registers a full callback for every memory access generated by
>    * an instruction. If the instruction doesn't access memory no
>    * callback will be made.
>    *
>    * The callback reports the vCPU the access took place on, the virtual
>    * address of the access and a handle for further queries. The user
>    * can attach some userdata to the callback for additional purposes.
>    *
>    * Other execution threads will continue to execute during the
>    * callback so the plugin is responsible for ensuring it doesn't get
>    * confused by making appropriate use of locking if required.
>    */
>   QEMU_PLUGIN_API
>   void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
>                                         qemu_plugin_vcpu_mem_cb_t cb,
>                                         enum qemu_plugin_cb_flags flags,
>                                         enum qemu_plugin_mem_rw rw,
>                                         void *userdata);
>
> where you can then process qemu_plugin_meminfo_t info in the callback to
> get the value or address of a memory operation. I guess you want some
> sort of operation to do an inline transform of the address to use a
> lookup to compare and branch to. The trick is coming up with an
> interface which is general and flexible enough and not just "what asan
> needs for a specific use case".
>
> > Even if I add a benign instrumentation that simply conditionally
> branches at a label and
> > nothing else (e.g. no actual functionality), I still have the same
> problem.
> > e.g.
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
>
> >
> > TCGLabel *done =3D gen_new_label();
> > TCGv addr_val =3D temp_tcgv_tl(addr);
> > TCGv zero =3D tcg_constant_tl(0);
> > tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);
> > gen_set_label(done);
> >
> >
> /////////////////////////////////////////////////////////////////////////=
///////
>
> >
> > Hence the current implementation is a little clumsy!
> >
> > Thanks for your advice.
> >
> > Jon
> >
> > On Mon, Jun 2, 2025 at 4:09=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@li=
naro.org>
> wrote:
> >
> >  Jon Wilson <jonwilson030981@googlemail.com> writes:
> >
> >  (Adding Richard, the TCG maintainer to CC)
> >
> >  > I am attempting to optimize some TCG code which I have previously
> written for
> >  > qemu-libafl-bridge (https://github.com/AFLplusplus/qemu-libafl-bridg=
e),
> the
> >  > component used by the LibAFL project when fuzzing binaries using QEM=
U
> to
> >  > provide runtime instrumentation. The code is used to write additiona=
l
> TCG into
> >  > basic blocks whenever a load or store operation is performed in orde=
r
> to provide
> >  > address sanitizer functionality.
> >
> >  I would like to figure out if we can push any of this instrumentation
> >  into TCG plugins so you can avoid patching QEMU itself. I guess you ne=
ed
> >  something that allows you to hook a memory address into some sort of
> >  gadget?
> >
> >  > Address sanitizer is quite simple and works by mapping each 8-byte
> region of
> >  > address space to single byte within a region called the shadow map.
> The address
> >  > (on a 64-bit platform) of the shadow map for a given address is:
> >  >
> >  >     Shadow =3D (Mem >> 3) + 0x7fff8000;
> >  >
> >  > The value in the shadow map encodes the accessibility of an address:
> >  >
> >  >     0  - The whole 8 byte region is accessible.
> >  >     1 .. 7 - The first n bytes are accessible.
> >  >     negative - The whole 8 byte region is inaccessible.
> >  >
> >  > The following pseudo code shows the algorithm:
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > https://github.com/google/sanitizers/wiki/addresssanitizeralgorithm
> >  >
> >  > byte *shadow_address =3D MemToShadow(address);
> >  > byte shadow_value =3D *shadow_address;
> >  > if (shadow_value) {
> >  >   if (SlowPathCheck(shadow_value, address, kAccessSize)) {
> >  >     ReportError(address, kAccessSize, kIsWrite);
> >  >   }
> >  > }
> >  >
> >  > // Check the cases where we access first k bytes of the qword
> >  > // and these k bytes are unpoisoned.
> >  > bool SlowPathCheck(shadow_value, address, kAccessSize) {
> >  >   last_accessed_byte =3D (address & 7) + kAccessSize - 1;
> >  >   return (last_accessed_byte >=3D shadow_value);
> >  > }
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > My current implementation makes use of conditional move instructions
> to trigger
> >  > a segfault by way of null dereference in the event that the shadow
> map indicates
> >  > that a memory access is invalid.
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > #if TARGET_LONG_BITS =3D=3D 32
> >  > #define SHADOW_BASE (0x20000000)
> >  > #elif TARGET_LONG_BITS =3D=3D 64
> >  > #define SHADOW_BASE (0x7fff8000)
> >  > #else
> >  > #error Unhandled TARGET_LONG_BITS value
> >  > #endif
> >  >
> >  > void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)
> >  > {
> >  >     if (size =3D=3D 0)
> >  >         return;
> >  >
> >  >     TCGv addr_val =3D temp_tcgv_tl(addr);
> >  >     TCGv k =3D tcg_temp_new();
> >  >     TCGv shadow_addr =3D tcg_temp_new();
> >  >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
> >  >     TCGv shadow_val =3D tcg_temp_new();
> >  >     TCGv test_addr =3D tcg_temp_new();
> >  >     TCGv_ptr test_ptr =3D tcg_temp_new_ptr();
> >  >
> >  >     tcg_gen_andi_tl(k, addr_val, 7);
> >  >     tcg_gen_addi_tl(k, k, size - 1);
> >  >
> >  >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
> >  >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
> >  >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
> >  >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
> >  >
> >  >     /*
> >  >      * Making conditional branches here appears to cause QEMU issues
> with dead
> >  >      * temporaries so we will instead avoid branches.
> >
> >  This sounds like a TCG bug that may have been fixed.
> >
> >  >      We will cause the guest
> >  >      * to perform a NULL dereference in the event of an ASAN fault.
> Note that
> >  >      * we will do this by using a store rather than a load, since th=
e
> TCG may
> >  >      * otherwise determine that the result of the load is unused and
> simply
> >  >      * discard the operation. In the event that the shadow memory
> doesn't
> >  >      * detect a fault, we will simply write the value read from the
> shadow
> >  >      * memory back to it's original location. If, however, the shado=
w
> memory
> >  >      * detects an invalid access, we will instead attempt to write
> the value
> >  >      * at 0x0.
> >  >      */
> >
> >  Why not conditionally call a helper here? Forcing the guest to actuall=
y
> >  fault seems a bit hammer like.
> >
> >  >     tcg_gen_movcond_tl(TCG_COND_EQ, test_addr,
> >  >         shadow_val, tcg_constant_tl(0),
> >  >         shadow_addr, tcg_constant_tl(0));
> >  >
> >  >     if (size < 8)
> >  >     {
> >  >         tcg_gen_movcond_tl(TCG_COND_GE, test_addr,
> >  >             k, shadow_val,
> >  >             test_addr, shadow_addr);
> >  >     }
> >  >
> >  >     tcg_gen_tl_ptr(test_ptr, test_addr);
> >  >     tcg_gen_st8_tl(shadow_val, test_ptr, 0);
> >  > }
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > However, I would like test an implementation more like the following
> to see how
> >  > the performance compares. Whilst this introduces branches, the fast
> path is much
> >  > more likely to be executed than the slow path and hence bypassing th=
e
> additional
> >  > checks and unnecessary memory writes I am hopeful it will improve
> performance.
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)
> >  > {
> >  >     if (size =3D=3D 0) {
> >  >         return;
> >  >     }
> >  >
> >  >     if (size > 8) {
> >  >         size =3D 8;
> >  >     }
> >  >
> >  >     TCGLabel *done =3D gen_new_label();
> >  >
> >  >     TCGv addr_val =3D temp_tcgv_tl(addr);
> >  >     TCGv shadow_addr =3D tcg_temp_new();
> >  >     TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr();
> >  >     TCGv shadow_val =3D tcg_temp_new();
> >  >     TCGv k =3D tcg_temp_new();
> >  >     TCGv zero =3D tcg_constant_tl(0);
> >  >     TCGv_ptr null_ptr =3D tcg_temp_new_ptr();
> >  >
> >  >     tcg_gen_shri_tl(shadow_addr, addr_val, 3);
> >  >     tcg_gen_addi_tl(shadow_addr, shadow_addr, SHADOW_BASE);
> >  >     tcg_gen_tl_ptr(shadow_ptr, shadow_addr);
> >  >     tcg_gen_ld8s_tl(shadow_val, shadow_ptr, 0);
> >  >
> >  >     tcg_gen_brcond_tl(TCG_COND_EQ, shadow_val, zero, done);
> >  >
> >  >     tcg_gen_andi_tl(k, addr_val, 7);
> >  >     tcg_gen_addi_tl(k, k, size - 1);
> >  >
> >  >     tcg_gen_brcond_tl(TCG_COND_LT, shadow_val, k, done);
> >  >
> >  >     tcg_gen_tl_ptr(null_ptr, zero);
> >  >     tcg_gen_st8_tl(zero, null_ptr, 0);
> >  >
> >  >     gen_set_label(done);
> >  > }
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > However, when I change to using this implementation, I get the
> following error.
> >  > I have tested it with a trivial hello world implementation for x86_6=
4
> running in
> >  > qemu-user. It doesn't occur the first time the block is executed,
> therefore I
> >  > think the issue is caused by the surrounding TCG in the block it is
> injected
> >  > into?
> >  >
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  > runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assertion
> `ts->val_type =3D=3D TEMP_VAL_REG' failed.
> >  > Aborted (core dumped)
> >  >
> /////////////////////////////////////////////////////////////////////////=
///////
> >  >
> >  > I would be very grateful for any advice of how to resolve this issue=
,
> or any
> >  > alternative approaches I could use to optimize my original
> implementation. The
> >  > code is obviously a very hot path and so even a tiny performance
> improvement
> >  > could result in a large performance gain overall.
> >
> >  --
> >  Alex Benn=C3=A9e
> >  Virtualisation Tech Lead @ Linaro
>
> --
> Alex Benn=C3=A9e
> Virtualisation Tech Lead @ Linaro
>

--000000000000ae5a4f0636a68c61
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>I&#39;m not sure what is needed to b=
e fair, I&#39;m kind of focussed on just this one <br>aspect of the emulati=
on. The previous implementation of ASAN was to implement <br>the shadow map=
 in the host address space and translate all the guest memory <br>access us=
ing g2h using helpers to check the shadow map. This was done through <br>ne=
cessity since older versions of QEMU didn&#39;t work well with allocating t=
he <br>large sparse memory regions used for the shadow maps.<br><br>However=
, by lowering the shadow map into the guest address space, we can omit <br>=
this additional translation stage and we can avoid the overhead (albeit sma=
ll) <br>of calling a helper function (and any associated register pressure =
caused by <br>needing to put arguments in the correct registers to support =
the ABI). But given the</div><div>code is on such a hot path, even tiny imp=
rovements get significantly magnified.</div><div><br></div><div>I&#39;m hop=
eful though, that if it is possible to optimize the fast path (e.g. the <br=
>shadow map value is zero) that it may be possible to reduce the performanc=
e <br>overhead of ASAN even further.</div><div><br></div><div>Best Regards.=
</div><div><br></div><div>Jon</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 2, 202=
5 at 5:26=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D"mailto:alex.bennee@lin=
aro.org">alex.bennee@linaro.org</a>&gt; wrote:<br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Jon Wilson &lt;<a href=3D"mailto:jonwilson=
030981@googlemail.com" target=3D"_blank">jonwilson030981@googlemail.com</a>=
&gt; writes:<br>
<br>
&gt; It would be good if we could have QEMU provide clean APIs to allow the=
 sort of additional instrumentation that fuzzing<br>
&gt; requires. I guess the qemu-libafl-bridge project show the sort of modi=
fication which has been required so far...<br>
&gt; <a href=3D"https://github.com/AFLplusplus/qemu-libafl-bridge/tree/main=
/libafl" rel=3D"noreferrer" target=3D"_blank">https://github.com/AFLplusplu=
s/qemu-libafl-bridge/tree/main/libafl</a><br>
&gt;<br>
&gt; I would like to conditionally call a helper, or even just insert a bre=
akpoint instruction, but like I say I don&#39;t seem to be able to<br>
&gt; make use of any sort of branches.<br>
<br>
For TCG plugins we have:<br>
<br>
=C2=A0 /**<br>
=C2=A0 =C2=A0* qemu_plugin_register_vcpu_tb_exec_cond_cb() - register condi=
tional callback<br>
=C2=A0 =C2=A0* @tb: the opaque qemu_plugin_tb handle for the translation<br=
>
=C2=A0 =C2=A0* @cb: callback function<br>
=C2=A0 =C2=A0* @cond: condition to enable callback<br>
=C2=A0 =C2=A0* @entry: first operand for condition<br>
=C2=A0 =C2=A0* @imm: second operand for condition<br>
=C2=A0 =C2=A0* @flags: does the plugin read or write the CPU&#39;s register=
s?<br>
=C2=A0 =C2=A0* @userdata: any plugin data to pass to the @cb?<br>
=C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0* The @cb function is called when a translated unit executes i=
f<br>
=C2=A0 =C2=A0* entry @cond imm is true.<br>
=C2=A0 =C2=A0* If condition is QEMU_PLUGIN_COND_ALWAYS, condition is never =
interpreted and<br>
=C2=A0 =C2=A0* this function is equivalent to qemu_plugin_register_vcpu_tb_=
exec_cb.<br>
=C2=A0 =C2=A0* If condition QEMU_PLUGIN_COND_NEVER, condition is never inte=
rpreted and<br>
=C2=A0 =C2=A0* callback is never installed.<br>
=C2=A0 =C2=A0*/<br>
=C2=A0 QEMU_PLUGIN_API<br>
=C2=A0 void qemu_plugin_register_vcpu_tb_exec_cond_cb(struct qemu_plugin_tb=
 *tb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_plugin_vcpu_udata_cb_t cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0enum qemu_plugin_cb_flags flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0enum qemu_plugin_cond cond,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_plugin_u64 entry,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t imm,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0void *userdata);<br>
<br>
Along with qemu_plugin_register_vcpu_insn_exec_cond_cb() for individual<br>
instructions. They are designed work with per-cpu indexed scoreboards<br>
using inline operations (e.g.<br>
qemu_plugin_register_vcpu_tb_exec_inline_per_vcpu) which can either add<br>
or store values.<br>
<br>
Currently we inline memory operations are a bit limited:<br>
<br>
=C2=A0 /**<br>
=C2=A0 =C2=A0* qemu_plugin_register_vcpu_mem_inline_per_vcpu() - inline op =
for mem access<br>
=C2=A0 =C2=A0* @insn: handle for instruction to instrument<br>
=C2=A0 =C2=A0* @rw: apply to reads, writes or both<br>
=C2=A0 =C2=A0* @op: the op, of type qemu_plugin_op<br>
=C2=A0 =C2=A0* @entry: entry to run op<br>
=C2=A0 =C2=A0* @imm: immediate data for @op<br>
=C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0* This registers a inline op every memory access generated by =
the<br>
=C2=A0 =C2=A0* instruction.<br>
=C2=A0 =C2=A0*/<br>
=C2=A0 QEMU_PLUGIN_API<br>
=C2=A0 void qemu_plugin_register_vcpu_mem_inline_per_vcpu(<br>
=C2=A0 =C2=A0 =C2=A0 struct qemu_plugin_insn *insn,<br>
=C2=A0 =C2=A0 =C2=A0 enum qemu_plugin_mem_rw rw,<br>
=C2=A0 =C2=A0 =C2=A0 enum qemu_plugin_op op,<br>
=C2=A0 =C2=A0 =C2=A0 qemu_plugin_u64 entry,<br>
=C2=A0 =C2=A0 =C2=A0 uint64_t imm);<br>
<br>
Although you can get access to the memory information through helpers:<br>
<br>
=C2=A0 /**<br>
=C2=A0 =C2=A0* qemu_plugin_register_vcpu_mem_cb() - register memory access =
callback<br>
=C2=A0 =C2=A0* @insn: handle for instruction to instrument<br>
=C2=A0 =C2=A0* @cb: callback of type qemu_plugin_vcpu_mem_cb_t<br>
=C2=A0 =C2=A0* @flags: (currently unused) callback flags<br>
=C2=A0 =C2=A0* @rw: monitor reads, writes or both<br>
=C2=A0 =C2=A0* @userdata: opaque pointer for userdata<br>
=C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0* This registers a full callback for every memory access gener=
ated by<br>
=C2=A0 =C2=A0* an instruction. If the instruction doesn&#39;t access memory=
 no<br>
=C2=A0 =C2=A0* callback will be made.<br>
=C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0* The callback reports the vCPU the access took place on, the =
virtual<br>
=C2=A0 =C2=A0* address of the access and a handle for further queries. The =
user<br>
=C2=A0 =C2=A0* can attach some userdata to the callback for additional purp=
oses.<br>
=C2=A0 =C2=A0*<br>
=C2=A0 =C2=A0* Other execution threads will continue to execute during the<=
br>
=C2=A0 =C2=A0* callback so the plugin is responsible for ensuring it doesn&=
#39;t get<br>
=C2=A0 =C2=A0* confused by making appropriate use of locking if required.<b=
r>
=C2=A0 =C2=A0*/<br>
=C2=A0 QEMU_PLUGIN_API<br>
=C2=A0 void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_plu=
gin_vcpu_mem_cb_t cb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum qem=
u_plugin_cb_flags flags,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum qem=
u_plugin_mem_rw rw,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 void *us=
erdata);<br>
<br>
where you can then process qemu_plugin_meminfo_t info in the callback to<br=
>
get the value or address of a memory operation. I guess you want some<br>
sort of operation to do an inline transform of the address to use a<br>
lookup to compare and branch to. The trick is coming up with an<br>
interface which is general and flexible enough and not just &quot;what asan=
<br>
needs for a specific use case&quot;.<br>
<br>
&gt; Even if I add a benign instrumentation that simply conditionally branc=
hes at a label and<br>
&gt; nothing else (e.g. no actual functionality), I still have the same pro=
blem.<br>
&gt; e.g.<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
////////// <br>
&gt;<br>
&gt; TCGLabel *done =3D gen_new_label();<br>
&gt; TCGv addr_val =3D temp_tcgv_tl(addr);<br>
&gt; TCGv zero =3D tcg_constant_tl(0);<br>
&gt; tcg_gen_brcond_tl(TCG_COND_EQ, addr_val, zero, done);<br>
&gt; gen_set_label(done);<br>
&gt;<br>
&gt; //////////////////////////////////////////////////////////////////////=
////////// <br>
&gt;<br>
&gt; Hence the current implementation is a little clumsy!<br>
&gt;<br>
&gt; Thanks for your advice.<br>
&gt;<br>
&gt; Jon<br>
&gt;<br>
&gt; On Mon, Jun 2, 2025 at 4:09=E2=80=AFPM Alex Benn=C3=A9e &lt;<a href=3D=
"mailto:alex.bennee@linaro.org" target=3D"_blank">alex.bennee@linaro.org</a=
>&gt; wrote:<br>
&gt;<br>
&gt;=C2=A0 Jon Wilson &lt;<a href=3D"mailto:jonwilson030981@googlemail.com"=
 target=3D"_blank">jonwilson030981@googlemail.com</a>&gt; writes:<br>
&gt;<br>
&gt;=C2=A0 (Adding Richard, the TCG maintainer to CC)<br>
&gt;<br>
&gt;=C2=A0 &gt; I am attempting to optimize some TCG code which I have prev=
iously written for<br>
&gt;=C2=A0 &gt; qemu-libafl-bridge (<a href=3D"https://github.com/AFLpluspl=
us/qemu-libafl-bridge" rel=3D"noreferrer" target=3D"_blank">https://github.=
com/AFLplusplus/qemu-libafl-bridge</a>), the <br>
&gt;=C2=A0 &gt; component used by the LibAFL project when fuzzing binaries =
using QEMU to <br>
&gt;=C2=A0 &gt; provide runtime instrumentation. The code is used to write =
additional TCG into <br>
&gt;=C2=A0 &gt; basic blocks whenever a load or store operation is performe=
d in order to provide<br>
&gt;=C2=A0 &gt; address sanitizer functionality.<br>
&gt;<br>
&gt;=C2=A0 I would like to figure out if we can push any of this instrument=
ation<br>
&gt;=C2=A0 into TCG plugins so you can avoid patching QEMU itself. I guess =
you need<br>
&gt;=C2=A0 something that allows you to hook a memory address into some sor=
t of<br>
&gt;=C2=A0 gadget?<br>
&gt;<br>
&gt;=C2=A0 &gt; Address sanitizer is quite simple and works by mapping each=
 8-byte region of<br>
&gt;=C2=A0 &gt; address space to single byte within a region called the sha=
dow map. The address<br>
&gt;=C2=A0 &gt; (on a 64-bit platform) of the shadow map for a given addres=
s is:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0Shadow =3D (Mem &gt;&gt; 3) + 0x7fff8000=
;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; The value in the shadow map encodes the accessibility of an=
 address:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A00=C2=A0 - The whole 8 byte region is acc=
essible.<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A01 .. 7 - The first n bytes are accessibl=
e.<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0negative - The whole 8 byte region is in=
accessible.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; The following pseudo code shows the algorithm:<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; <a href=3D"https://github.com/google/sanitizers/wiki/addres=
ssanitizeralgorithm" rel=3D"noreferrer" target=3D"_blank">https://github.co=
m/google/sanitizers/wiki/addresssanitizeralgorithm</a><br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; byte *shadow_address =3D MemToShadow(address);<br>
&gt;=C2=A0 &gt; byte shadow_value =3D *shadow_address;<br>
&gt;=C2=A0 &gt; if (shadow_value) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0if (SlowPathCheck(shadow_value, address, kAcces=
sSize)) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0ReportError(address, kAccessSize, kIsWri=
te);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt; }<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; // Check the cases where we access first k bytes of the qwo=
rd<br>
&gt;=C2=A0 &gt; // and these k bytes are unpoisoned.<br>
&gt;=C2=A0 &gt; bool SlowPathCheck(shadow_value, address, kAccessSize) {<br=
>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0last_accessed_byte =3D (address &amp; 7) + kAcc=
essSize - 1;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0return (last_accessed_byte &gt;=3D shadow_value=
);<br>
&gt;=C2=A0 &gt; }<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; My current implementation makes use of conditional move ins=
tructions to trigger<br>
&gt;=C2=A0 &gt; a segfault by way of null dereference in the event that the=
 shadow map indicates<br>
&gt;=C2=A0 &gt; that a memory access is invalid.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; #if TARGET_LONG_BITS =3D=3D 32<br>
&gt;=C2=A0 &gt; #define SHADOW_BASE (0x20000000)<br>
&gt;=C2=A0 &gt; #elif TARGET_LONG_BITS =3D=3D 64<br>
&gt;=C2=A0 &gt; #define SHADOW_BASE (0x7fff8000)<br>
&gt;=C2=A0 &gt; #else<br>
&gt;=C2=A0 &gt; #error Unhandled TARGET_LONG_BITS value<br>
&gt;=C2=A0 &gt; #endif<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; void libafl_tcg_gen_asan(TCGTemp * addr, size_t size)<br>
&gt;=C2=A0 &gt; {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv addr_val =3D temp_tcgv_tl(addr);<br=
>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv k =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr=
();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_val =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv test_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr test_ptr =3D tcg_temp_new_ptr()=
;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_tl(k, addr_val, 7);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(k, k, size - 1);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_shri_tl(shadow_addr, addr_val, 3=
);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(shadow_addr, shadow_addr=
, SHADOW_BASE);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(shadow_ptr, shadow_addr);=
<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_ld8s_tl(shadow_val, shadow_ptr, =
0);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * Making conditional branches here appe=
ars to cause QEMU issues with dead<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * temporaries so we will instead avoid =
branches.<br>
&gt;<br>
&gt;=C2=A0 This sounds like a TCG bug that may have been fixed.<br>
&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 We will cause the guest<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * to perform a NULL dereference in the =
event of an ASAN fault. Note that<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * we will do this by using a store rath=
er than a load, since the TCG may<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * otherwise determine that the result o=
f the load is unused and simply<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * discard the operation. In the event t=
hat the shadow memory doesn&#39;t<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * detect a fault, we will simply write =
the value read from the shadow<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * memory back to it&#39;s original loca=
tion. If, however, the shadow memory<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * detects an invalid access, we will in=
stead attempt to write the value<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 * at 0x0.<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 */<br>
&gt;<br>
&gt;=C2=A0 Why not conditionally call a helper here? Forcing the guest to a=
ctually<br>
&gt;=C2=A0 fault seems a bit hammer like.<br>
&gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_tl(TCG_COND_EQ, test_add=
r,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shadow_val, tcg_constant_t=
l(0),<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shadow_addr, tcg_constant_=
tl(0));<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0if (size &lt; 8)<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tcg_gen_movcond_tl(TCG_CON=
D_GE, test_addr,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0k, shadow_va=
l,<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0test_addr, s=
hadow_addr);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(test_ptr, test_addr);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_st8_tl(shadow_val, test_ptr, 0);=
<br>
&gt;=C2=A0 &gt; }<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; However, I would like test an implementation more like the =
following to see how<br>
&gt;=C2=A0 &gt; the performance compares. Whilst this introduces branches, =
the fast path is much<br>
&gt;=C2=A0 &gt; more likely to be executed than the slow path and hence byp=
assing the additional<br>
&gt;=C2=A0 &gt; checks and unnecessary memory writes I am hopeful it will i=
mprove performance.<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; void libafl_tcg_gen_asan(TCGTemp* addr, size_t size)<br>
&gt;=C2=A0 &gt; {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0if (size =3D=3D 0) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0if (size &gt; 8) {<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size =3D 8;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGLabel *done =3D gen_new_label();<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv addr_val =3D temp_tcgv_tl(addr);<br=
>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_addr =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr shadow_ptr =3D tcg_temp_new_ptr=
();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv shadow_val =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv k =3D tcg_temp_new();<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv zero =3D tcg_constant_tl(0);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0TCGv_ptr null_ptr =3D tcg_temp_new_ptr()=
;<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_shri_tl(shadow_addr, addr_val, 3=
);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(shadow_addr, shadow_addr=
, SHADOW_BASE);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(shadow_ptr, shadow_addr);=
<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_ld8s_tl(shadow_val, shadow_ptr, =
0);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_brcond_tl(TCG_COND_EQ, shadow_va=
l, zero, done);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_andi_tl(k, addr_val, 7);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_addi_tl(k, k, size - 1);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_brcond_tl(TCG_COND_LT, shadow_va=
l, k, done);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_tl_ptr(null_ptr, zero);<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0tcg_gen_st8_tl(zero, null_ptr, 0);<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt;=C2=A0 =C2=A0 =C2=A0gen_set_label(done);<br>
&gt;=C2=A0 &gt; }<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; However, when I change to using this implementation, I get =
the following error.<br>
&gt;=C2=A0 &gt; I have tested it with a trivial hello world implementation =
for x86_64 running in<br>
&gt;=C2=A0 &gt; qemu-user. It doesn&#39;t occur the first time the block is=
 executed, therefore I<br>
&gt;=C2=A0 &gt; think the issue is caused by the surrounding TCG in the blo=
ck it is injected<br>
&gt;=C2=A0 &gt; into?<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt; runner-x86_64: ../tcg/tcg.c:4852: tcg_reg_alloc_mov: Assert=
ion `ts-&gt;val_type =3D=3D TEMP_VAL_REG&#39; failed.<br>
&gt;=C2=A0 &gt; Aborted (core dumped)<br>
&gt;=C2=A0 &gt; ///////////////////////////////////////////////////////////=
/////////////////////<br>
&gt;=C2=A0 &gt;<br>
&gt;=C2=A0 &gt; I would be very grateful for any advice of how to resolve t=
his issue, or any<br>
&gt;=C2=A0 &gt; alternative approaches I could use to optimize my original =
implementation. The<br>
&gt;=C2=A0 &gt; code is obviously a very hot path and so even a tiny perfor=
mance improvement<br>
&gt;=C2=A0 &gt; could result in a large performance gain overall.<br>
&gt;<br>
&gt;=C2=A0 -- <br>
&gt;=C2=A0 Alex Benn=C3=A9e<br>
&gt;=C2=A0 Virtualisation Tech Lead @ Linaro<br>
<br>
-- <br>
Alex Benn=C3=A9e<br>
Virtualisation Tech Lead @ Linaro<br>
</blockquote></div></div>

--000000000000ae5a4f0636a68c61--

