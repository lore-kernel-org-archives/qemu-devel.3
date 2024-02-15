Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027A5C48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:26:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rachB-0001pl-MY; Thu, 15 Feb 2024 09:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1rach9-0001pW-W4
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:26:36 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1racgv-0001MN-MR
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:26:35 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a3d002bc6f7so88424966b.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1708007180; x=1708611980; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZYdDtSCMTkJNYvAd6MsMMttRe2dw3Q+k4CC2NfImhx0=;
 b=OU0NbRSqWva/98NXoizVExlJpygYzN2T2TbCrtxupyrZab2apP6IXvMorZssmRbGRh
 S0W9gSQZS59mb0V6+DIjA7ve5pK6LdIS5xAJPk5Rp1yMRYkH/v8RGKmH2IDlETaQTKKg
 HNT57QPXuZmoH5dtab5TIlzWhF1qeSbg4S1Jxgv7Zxz0yqUW8+nJSUFvDOUN/hjC+1m7
 egIbsVhFycJYqzpC9NEzFFhRqLTUy50wvctchx4RuuWenBPiurvw1pFzDuKBnFo0ucYk
 hVl4+YJFO0KDiq7sJYwbAbbHUjeQfd3Oz2KDgmA0tDkzIgdeevEbDUQExzVeUS9cQ70i
 ioHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708007180; x=1708611980;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZYdDtSCMTkJNYvAd6MsMMttRe2dw3Q+k4CC2NfImhx0=;
 b=ZtQFz4LwZ3Q7I4scWIghMfFmgDj1yAy5x7/qkjhoxIDGUfx+xuiOnBLAAsBfWwCgqi
 E5RZYbl6pwABsViQxaLwroyU2bFMBlGTUoDFN4/u5hZXsyOSYbOECiMDz2rlK1doKhc2
 SpHR+lSeq1/evkf7+lu7uAG89XVcD0p3nL+VcO3rdkFQnHx3wGD2pwjIXGuIc8wokI7J
 vSUZatW1LjQ6ATqkRBye6mjc49YoVM2v/6jlTm4Z+Avmd3moe5RI/zaQOpy6k/JUbxqp
 u7jtVHjdLV3goLeo7wXg5I2mi1h5uVq2Y2FcaqlTvWCl63mqb3lI6+esU4U2wW6fX5g3
 LRuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8rxQpyptAGQqmr5wbaMWyJWnEjbpkYxXq4JwOVGb2qpI49xxJCRNZ8dw+zFxO5240VZPKjuaOwwZIJ3A0O724/UpjrZQ=
X-Gm-Message-State: AOJu0Yw9rx7gRJSPs3GKOs5EdM8pqRuPosIbTfAgoAIhfSQ4lTkjy+s2
 hsqxbrS95rC9WuGqQ+SIZrJqeqIbel3nVq7We5nQRvSoebaVzUuLdjql2gT8b74=
X-Google-Smtp-Source: AGHT+IGJVFoYp+lWudsffHxUYb69f6QjU4yntF2LKwJ6+lGIpI4kiXsKmHVZ00YZ90UFN7UkBv8RJQ==
X-Received: by 2002:a17:906:40d1:b0:a36:ff9f:4256 with SMTP id
 a17-20020a17090640d100b00a36ff9f4256mr1525420ejk.54.1708007179815; 
 Thu, 15 Feb 2024 06:26:19 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 hw12-20020a170907a0cc00b00a3d5d8ff745sm605393ejc.144.2024.02.15.06.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 06:26:19 -0800 (PST)
Date: Thu, 15 Feb 2024 15:26:18 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Conor Dooley <conor@kernel.org>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Subject: Re: [PATCH v3 3/6] target/riscv: add remaining named features
Message-ID: <20240215-55440212b4d6cde9feab5d94@orel>
References: <20240202152154.773253-1-dbarboza@ventanamicro.com>
 <20240202152154.773253-4-dbarboza@ventanamicro.com>
 <20240215-alkaline-saturday-275cd8e3aa39@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-alkaline-saturday-275cd8e3aa39@spud>
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=ajones@ventanamicro.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 15, 2024 at 01:33:47PM +0000, Conor Dooley wrote:
> On Fri, Feb 02, 2024 at 12:21:51PM -0300, Daniel Henrique Barboza wrote:
> > The RVA22U64 and RVA22S64 profiles mandates certain extensions that,
> > until now, we were implying that they were available.
> > 
> > We can't do this anymore since named features also has a riscv,isa
> > entry. Let's add them to riscv_cpu_named_features[].
> > 
> > Instead of adding one bool for each named feature that we'll always
> > implement, i.e. can't be turned off, add a 'ext_always_enabled' bool in
> > cpu->cfg. This bool will be set to 'true' in TCG accel init, and all
> > named features will point to it. This also means that KVM won't see
> > these features as always enable, which is our intention.
> > 
> > If any accelerator adds support to disable one of these features, we'll
> > have to promote them to regular extensions and allow users to disable it
> > via command line.
> > 
> > After this patch, here's the riscv,isa from a buildroot using the
> > 'rva22s64' CPU:
> 
> Why does an "rva22s64" cpu have "zicclsm" in it? Isn't zicclsm only
> present in "u" profiles?

"s" profiles mandate all the "u" profile mandatory extensions. For example
6.2.2 says

"""
The RVA22S64 mandatory unprivileged extensions include all the mandatory unprivileged
extensions in RVA22U64.
"""

> 
> >  # cat /proc/device-tree/cpus/cpu@0/riscv,isa
> > rv64imafdc_zic64b_zicbom_zicbop_zicboz_ziccamoa_ziccif_zicclsm_ziccrse_
> > zicntr_zicsr_zifencei_zihintpause_zihpm_za64rs_zfhmin_zca_zcd_zba_zbb_
> > zbs_zkt_ssccptr_sscounterenw_sstvala_sstvecd_svade_svinval_svpbmt#
> 
> I want to raise my frustration with the crock we've been given here by
> RVI. Any "named feature" that just creates a name for something that
> already is assumed is completely useless, and DT property that is used
> to communicate it's presence cannot be used - instead the property needs
> to be inverted - indicating the absence of that named feature.
> 
> Without the inversion, software that parses "riscv,isa" cannot make any
> determination based on the absence of the property - it could be parsing
> an old DT that does not have the property or it could be parsing the DT
> of a system that does not support the extension.

I'm guessing any platform which wants to advertise that it's compliant
with a profile will update its hardware descriptions to ensure all the
profile's mandatory extensions are presented. But, I think I understand
your concern. If somebody is parsing the ISA string as way to determine
if the platform is compliant with a profile, then they may get a false
negative due to the ISA string missing a newly named feature. I'm not
sure how much of a problem that will be in practice, though, since testing
for profile compliance, just for the sake of it, doesn't seem very useful.
Software really only needs to know which extensions are available and if
it's an old feature that got newly named, then software likely already
has another way of detecting it.

> 
> This is part of why I deprecated `riscv,isa`. It's the same problem as
> with "zifencei" et al - does a system with `riscv,isa = "rv64imac"`
> support fence.i?

Yes, there's a handful of these messy things and the first profiles
expose them since they're trying to define them. Fingers crossed that
the next profiles won't have to name old features. FWIW, I at least
don't see any "This is a new extension name for this feature" notes in
the RVA23 profile.

Thanks,
drew

