Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B969C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 14:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryueh-0005mQ-Vg; Mon, 22 Apr 2024 10:28:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ryueg-0005kZ-HG
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:28:26 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ryuee-0008OE-L3
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 10:28:26 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-417f5268b12so46757255e9.1
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 07:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1713796103; x=1714400903; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bOahbN85LMWTmQuRMx/rDb9deOJN+b3weN6yXukcqAk=;
 b=NhB8TG0B8DHeoz1/Zpm9t+NwcungRFgePus8c2l8DJOflEYGNv0hGpYUS98naG3LNu
 mA6TrwmtgNc0ja//wJhC/bKOLZF+mH04u77cpT8tKO+94ExZuekEQDJoMUkGmxdumjKm
 MaB3WPH1saUoJuc5e6gCAdAhClAQ8zb9OuOvj6Sx30hCTsGvpy3ky4UCrO3QpUYWH/B2
 SJZ72Hprix1FFC17tnlkeKUbayt36kDUfIBzRnlXgQzJoTgy+8KjJLO+lIFoBwm+OyhP
 YW17koYxD4bI08o2BoU4AHsX+qZ8qujeqcyyLAXV2qJg4jv1h9jDRNUL9GffIg0mFnrX
 mwRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713796103; x=1714400903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bOahbN85LMWTmQuRMx/rDb9deOJN+b3weN6yXukcqAk=;
 b=o6O0582Bl045E7FWFvM4qg+zdC/xdkFCfti/xX95NszirfrgKbGXCsiE7iBs2CQ1Wa
 Eql6hJoT/H8RTAiq5JNTZUYRBr5oMzuCNvUkYyDSZnW1qBNQWsXkjQyXaD9DRZe9i6+m
 34/u+2/eCaG1WxhPDcaSQKQ+l/pWb3B9TPFwPAUUQdfMV9UH2f5NdRWZWA73GqUs3kBD
 NPqpyb3Ds39RiyIiV5y1cnjvvzg96rhsY8aP2DMVFAUBo/gzhfOVeWEljFhLtW6oTgil
 U+BN7SylxBoWcQ6gT2sTXx5L4ftjiBf7gnm4RsKvOav0FdPQHKmD9u+2ESlg2HIEFLmX
 w6Gg==
X-Gm-Message-State: AOJu0YwHAzEWDpeW36nA4ga7TtRsS8IFPk9eMTrhtwK3INwxdFllIXMf
 ARqNJBT3FOzanpgqUxtYmXcCNCTO06sudHpwyRXbdcQxniAmfG2aWPYZ+iOXYnM=
X-Google-Smtp-Source: AGHT+IEpkkn9T8FqXaEgAoyqMB/t0EwNqS7B2xpemCkzA3pQSEy1eCGu32e5sWYYBUJmYFCLKJ4Saw==
X-Received: by 2002:a05:600c:190a:b0:418:37e1:3f73 with SMTP id
 j10-20020a05600c190a00b0041837e13f73mr8337495wmq.2.1713796102826; 
 Mon, 22 Apr 2024 07:28:22 -0700 (PDT)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a05600c4fcc00b00418a6d62ad0sm20649029wmq.34.2024.04.22.07.28.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Apr 2024 07:28:22 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:28:21 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH] target/riscv/kvm: tolerate KVM disable ext errors
Message-ID: <20240422-e1c56f375313e82bad93244f@orel>
References: <20240422131253.313869-1-dbarboza@ventanamicro.com>
 <20240422-8145ee4f1a24e27ac9dcb1b3@orel>
 <09749ed3-840c-4a47-8cd2-9a50c9951cdb@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09749ed3-840c-4a47-8cd2-9a50c9951cdb@ventanamicro.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=ajones@ventanamicro.com; helo=mail-wm1-x330.google.com
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

On Mon, Apr 22, 2024 at 11:08:31AM -0300, Daniel Henrique Barboza wrote:
> 
> 
> On 4/22/24 10:43, Andrew Jones wrote:
> > On Mon, Apr 22, 2024 at 10:12:53AM -0300, Daniel Henrique Barboza wrote:
> > > Running a KVM guest using a 6.9-rc3 kernel, in a 6.8 host that has zkr
> > > enabled, will fail with a kernel oops SIGILL right at the start. The
> > > reason is that we can't expose zkr without implementing the SEED CSR.
> > > Disabling zkr in the guest would be a workaround, but if the KVM doesn't
> > > allow it we'll error out and never boot.
> > > 
> > > In hindsight this is too strict. If we keep proceeding, despite not
> > > disabling the extension in the KVM vcpu, we'll not add extension in
> >                                                          ^ the
> > > riscv,isa. The guest kernel will be unaware of the extension, i.e. it
> >   ^ the
> > 
> > > doesn't matter if the KVM vcpu has it enabled underneath or not. So it's
> > > ok to keep booting in this case.
> > > 
> > > Change our current logic to not error out if we fail to disable an
> > > extension in kvm_set_one_reg(): throw an warning instead and keep
> > > booting.  We'll keep the existing behavior when we fail to enable an
> > > extension in KVM, since adding the extension in riscv,isa at this point
> > > will cause a guest malfunction because the extension isn't enabled in
> > > the vcpu.
> > 
> > I'd probably add a sentence or two explaining why we still want to warn,
> > which is because KVM is stating that while you may think you're disabling
> > an extension, that extension's behavior (instructions, etc.) will still
> > be exposed to the guest since there's no way not to expose it.  The user
> > should be aware that a guest could use it anyway, since that means the
> > attempt to disable it can't be relied upon for migration compatibility of
> > arbitrary guests. The guest needs to be well behaved, i.e. one that won't
> > try to use any extensions which aren't in the ISA string. So, disabling
> > these types of extensions either shouldn't generally be done (so a noisy
> > warning helps prohibit that) or done for debug purposes (where a noisy
> > warning is fine).
> 
> I'll add this in the next version.
> 
> > 
> > > 
> > > Suggested-by: Andrew Jones <ajones@ventanamicro.com>
> > > Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> > > ---
> > >   target/riscv/kvm/kvm-cpu.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> > > index 6a6c6cae80..261ca24504 100644
> > > --- a/target/riscv/kvm/kvm-cpu.c
> > > +++ b/target/riscv/kvm/kvm-cpu.c
> > > @@ -427,10 +427,14 @@ static void kvm_riscv_update_cpu_cfg_isa_ext(RISCVCPU *cpu, CPUState *cs)
> > >           reg = kvm_cpu_cfg_get(cpu, multi_ext_cfg);
> > >           ret = kvm_set_one_reg(cs, id, &reg);
> > >           if (ret != 0) {
> > > -            error_report("Unable to %s extension %s in KVM, error %d",
> > > -                         reg ? "enable" : "disable",
> > > -                         multi_ext_cfg->name, ret);
> > > -            exit(EXIT_FAILURE);
> > > +            if (reg) {
> > > +                error_report("Unable to enable extension %s in KVM, error %d",
> > > +                             multi_ext_cfg->name, ret);
> > > +                exit(EXIT_FAILURE);
> > > +            } else {
> > 
> > Maybe we should check for a specific error. Is it EINVAL? If we do, then
> > the message below would drop the (error %d) part and instead state
> > explicitly that it cannot disable this extension since it's not possible.
> 
> It's throwing a 22 (EINVAL).
> 
> > 
> > > +                warn_report("KVM did not disable extension %s (error %d)",
> > 
> > s/did not/cannot/
> > 
> > > +                            multi_ext_cfg->name, ret);
> > > +            }
> 
> 
> I don't mind rephrasing it to "The KVM module is not able to disable extension %s"
> But I'm unsure what we gain from not showing the error code.
> 
> Aside EINVAL the other (very unlikely) error code being thrown would be EBUSY. Should
> we handle EBUSY differently in this case? I don't think so. If we're already throwing a
> warning, with error code, the user is well informed about the guest having a flaky
> start and can proceed with discretion. Regardless of the extension disablement failing
> due to EINVAL or EBUSY.

But EBUSY means the VMM messed up and tried to do something it shouldn't,
which is to change the configuration of the VCPU after it already ran.
EINVAL isn't a VMM mess up. It wanted to disable the extension and will
remove it from the ISA string, KVM just can't guarantee that the guest
won't be able to use it anyway (making that a warn case). So, EBUSY isn't
a warn case (but it's also not something we'd expect to see in a function
called from kvm_arch_init_vcpu()). However, KVM is free to add new errors,
so I'd only warn for the ones which translate to warn cases (EINVAL).

Thanks,
drew

