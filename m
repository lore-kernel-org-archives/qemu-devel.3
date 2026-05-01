Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4833CD3424
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2026 14:22:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIokB-00082q-2e; Fri, 01 May 2026 10:21:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIokA-00082b-5f
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:21:26 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wIok7-0007Zs-N6
 for qemu-devel@nongnu.org; Fri, 01 May 2026 10:21:25 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso1127057f8f.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2026 07:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777645281; x=1778250081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBnnGCpYSonyRl/RZZsL4XC/Tyffyj/BGojejPAjpWk=;
 b=tE4HVR6TNGPD8f5NHWuAuCL2G2+tsQBmjjZNKngmWSOtItUVomdgmIgmcYpopky2Hz
 WD2QvJgSXhAs2Htf3slxJdMNBsF9PX+vflMrpNPzYkHiwmrTNEZaUcVkaTYSw1Jzcflf
 awNs/VMabxqkcjqhbmYAv/VzJWJdTgXWXAfQr7bm5Z9D/QPWoYXzwfSprcEJZRhr4ZKD
 mIepw9fETTaghkDgDpkknu31YTH9WHojP8wgRt3hlG5svWK9NvBlyI5QGSw0wJz91AUt
 Q/ON4ixb8bYJhPVu78/IURPc5h2xujBw39vFqR3C7xPTSoZMDpa2E7LE9Hetvb3uc9x9
 zKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777645281; x=1778250081;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DBnnGCpYSonyRl/RZZsL4XC/Tyffyj/BGojejPAjpWk=;
 b=ZkWs1apVgJMhBq7c9eRW5pzj7BCCiprPrGT+9bRIMS1aNDngfVBCFrGJ/rhum+zoPG
 BCM+i33LcMWaYkKTEk84SwjqWxpxriSWWYPiKb/v0GAZtl7BlIvy70Sj96zlc5rY9epa
 buBZuFbNTLxb3p+FI0yAuaMoSiu5qvBZ+kFsBfsVZii+aS0Ei60bd0X7yXQ3NuoDHWRB
 yrnMBNi6pwLWc66Nu0Jj6ERsnSWtu4t1CAj4xOOtfXbXe+WRTAyhGUT0KEVGd2wgBAsq
 AV3ZXIM/xE0JdpeM2RZ5X7mMgGWBbEzzSUfH4j3PiaSWeqAVqPdyECACHNWaXZJKU9Ew
 9qOw==
X-Gm-Message-State: AOJu0YzmXlvZ1Hdht57o/K48Ps9rYqrjiTXS2f++7W0PHkPZTSdZnCqz
 K7xG50jlymPq6iSoWuNHp3U/MAsSbCNvQhKRkhscXPN+ixPQdAWWPAILpOlFtWF4acY=
X-Gm-Gg: AeBDiest/cht+0alejtwTIsllKHFpNfirPoK3YMG5orp3FWK6LNfSp8eomlLpveV4qr
 wOHUIrZhedwdLuK0vM4fccSPvInSGo8nmz8r9CC37+m4+G4XdfTqOiUV4Dz7KMJUoQUuY5f87vL
 tfw3oxHl1TCudlMqOqPfAP+HNcSn//FynAs9e5EmT7ESLv45HsVfIBPD63zN5hxrKR599Z5+/G7
 NEjMgzoNdIptb2H6QvFwJqVegDb7LZ3UylRhC3Vp7ENvIkw2CTAPCfc6a0rcyOpPifaWenBfoqI
 cPgX2bNExSbqJHtT4kj41QJxp/NiAXZZQfyFM2Ria5F1/hMrxJpojvYX02mymhi88tsbB0KKSLq
 xZBk8n/of0robKWwV6AosIDFwqM8I37GZyQa3PxUy4fAwWYryi8uEtrErmEQTMEjkxbM895sBq7
 jjRxfXbPEoGRNysciHUwgvVQ6cvKjEhOqENw==
X-Received: by 2002:a5d:5d83:0:b0:43f:e413:f6fd with SMTP id
 ffacd0b85a97d-44a83318609mr5106522f8f.0.1777645281205; 
 Fri, 01 May 2026 07:21:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a986aa3a5sm5802041f8f.26.2026.05.01.07.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 07:21:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8A2A75F8FC;
 Fri, 01 May 2026 15:21:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: qemu-devel@nongnu.org,  Andrew Jones <andrew.jones@linux.dev>,  Eric
 Auger <eric.auger@redhat.com>,  "open list:ARM" <kvmarm@lists.linux.dev>,
 "open list:Default mailing list" <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH] arm: add wfx test case
In-Reply-To: <afSnVJLe7HrB6ISS@raptor> (Alexandru Elisei's message of "Fri, 1
 May 2026 14:15:14 +0100")
References: <20260427130045.3669851-1-alex.bennee@linaro.org>
 <afSnVJLe7HrB6ISS@raptor>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Fri, 01 May 2026 15:21:19 +0100
Message-ID: <87zf2jcisg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x433.google.com
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

Alexandru Elisei <alexandru.elisei@arm.com> writes:

> Hi Alex,
>
> On Mon, Apr 27, 2026 at 02:00:45PM +0100, Alex Benn=C3=A9e wrote:
>> This is based on a similar test case I wrote for QEMU's tcg tests althou=
gh
>> obviously able to take advantage of kvm-unit-tests additional plumbing f=
or
>> dealing with the GIC and IRQs.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  arm/Makefile.arm64        |   1 +
>>  lib/arm64/asm/processor.h |   7 ++
>>  lib/arm64/asm/sysreg.h    |   3 +
>>  arm/wfx.c                 | 137 ++++++++++++++++++++++++++++++++++++++
>>  arm/unittests.cfg         |   5 ++
>>  5 files changed, 153 insertions(+)
>>  create mode 100644 arm/wfx.c
>>=20
>> diff --git a/arm/Makefile.arm64 b/arm/Makefile.arm64
>> index a40c830d..52b3f35d 100644
>> --- a/arm/Makefile.arm64
>> +++ b/arm/Makefile.arm64
>> @@ -64,6 +64,7 @@ tests +=3D $(TEST_DIR)/cache.$(exe)
>>  tests +=3D $(TEST_DIR)/debug.$(exe)
>>  tests +=3D $(TEST_DIR)/fpu.$(exe)
>>  tests +=3D $(TEST_DIR)/mte.$(exe)
>> +tests +=3D $(TEST_DIR)/wfx.$(exe)
>>=20=20
>>  include $(SRCDIR)/$(TEST_DIR)/Makefile.common
>>=20=20
>> diff --git a/lib/arm64/asm/processor.h b/lib/arm64/asm/processor.h
>> index 32ddc1b3..2104036d 100644
>> --- a/lib/arm64/asm/processor.h
>> +++ b/lib/arm64/asm/processor.h
>> @@ -173,5 +173,12 @@ static inline bool system_supports_rndr(void)
>>  	return ((id_aa64isar0_el1 >> ID_AA64ISAR0_EL1_RNDR_SHIFT) & 0xf) !=3D =
0;
>>  }
>>=20=20
>> +static inline bool system_supports_wfxt(void)
>> +{
>> +	u64 id_aa64isar2_el1 =3D read_sysreg_s(ID_AA64ISAR2_EL1);
>> +
>> +	return ((id_aa64isar2_el1 >> ID_AA64ISAR2_EL1_WFxT_SHIFT) & 0xf) !=3D =
0;
>> +}
>> +
>>  #endif /* !__ASSEMBLER__ */
>>  #endif /* _ASMARM64_PROCESSOR_H_ */
>> diff --git a/lib/arm64/asm/sysreg.h b/lib/arm64/asm/sysreg.h
>> index f2d05018..cb96a649 100644
>> --- a/lib/arm64/asm/sysreg.h
>> +++ b/lib/arm64/asm/sysreg.h
>> @@ -77,6 +77,9 @@ asm(
>>  #define ID_AA64ISAR0_EL1_RNDR_SHIFT	60
>>  #define ID_AA64PFR1_EL1_MTE_SHIFT	8
>>=20=20
>> +#define ID_AA64ISAR2_EL1		sys_reg(3, 0, 0, 6, 2)
>> +#define ID_AA64ISAR2_EL1_WFxT_SHIFT	0
>> +
>>  #define ID_AA64MMFR0_EL1_FGT_SHIFT	56
>>  #define ID_AA64MMFR0_EL1_FGT_FGT2	0x2
>>=20=20
>> diff --git a/arm/wfx.c b/arm/wfx.c
>> new file mode 100644
>> index 00000000..912e50e6
>> --- /dev/null
>> +++ b/arm/wfx.c
>> @@ -0,0 +1,137 @@
>> +/*
>> + * WFX Instructions Test (WFI, WFE, WFIT, WFET)
>> + *
>> + * Copyright (c) 2026 Linaro Ltd
>> + *
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include <libcflat.h>
>> +#include <asm/processor.h>
>> +#include <asm/gic.h>
>> +#include <asm/timer.h>
>> +#include <asm/io.h>
>> +
>> +#define TIMEOUT 200000
>> +
>> +#define sev() asm volatile("sev" : : : "memory")
>> +#define sevl() asm volatile("sevl" : : : "memory")
>> +#define wfi() asm volatile("wfi" : : : "memory")
>> +#define wfe() asm volatile("wfe" : : : "memory")
>> +
>> +#define wfit(reg) \
>> +	asm volatile(".arch armv8.7-a\n\twfit %0" : : "r" (reg) : "memory")
>> +#define wfet(reg) \
>> +	asm volatile(".arch armv8.7-a\n\twfet %0" : : "r" (reg) : "memory")
>> +
>> +static void timer_handler(struct pt_regs *regs)
>> +{
>> +	/* Disable timer to stop IRQ from re-firing */
>> +	write_sysreg(0, cntv_ctl_el0);
>> +}
>
> It is customary for the interrupt handler to ack the interrupt at the GIC=
 level.
>
>> +
>> +static bool check_elapsed(uint64_t start, uint64_t threshold, const cha=
r *test, bool more)
>> +{
>> +	uint64_t end =3D read_sysreg(cntvct_el0);
>> +	uint64_t elapsed =3D end - start;
>> +	bool pass =3D more ? elapsed >=3D threshold : elapsed <=3D threshold;
>> +
>> +	report(pass, "%s (%ld ticks)", test, elapsed);
>> +
>> +	if (!pass) {
>> +		report_info("%s %s", test, more ? "woke too early" : "slept despite S=
EV");
>> +	}
>> +	return pass;
>> +}
>> +
>> +static void test_wfi(void)
>> +{
>> +	uint64_t start;
>> +
>> +	report_info("Testing WFI...");
>> +
>> +	start =3D read_sysreg(cntvct_el0);
>> +	write_sysreg(TIMEOUT, cntv_tval_el0);
>> +	write_sysreg(1, cntv_ctl_el0); /* Enable timer, no mask */
>> +	isb();
>> +
>> +	local_irq_enable();
>> +	wfi();
>
> Consider this scenario:
>
> 	local_irq_enable();
> 	// CPU takes the interrupt, handles it and returns.
> 	wfi(); <- CPU now waits forever for an interrupt that will never come
>
> The proper way to do it on baremetal would be:
>
> 	local_irq_disable();
> 	// Program timer to fire
> 	wfi();
> 	// Timer fires, GIC asserts the interrupt, WFI completes
> 	local_irq_enable();
> 	// CPU handles the interrupt
> 	check_elapsed(..)
>
> But this is not baremetal. KVM can decide not to trap WFI (look at
> arch/arm64/kvm/arm.c::kvm_arch_vcpu_load() -> kvm_vpcu_should_clear_twi()=
). In
> that case, the WFI might complete due a host interrupt, and check_elapsed=
() will
> fail because the timer hasn't yet fired.
>
>> +	local_irq_disable();
>> +
>> +	check_elapsed(start, TIMEOUT, "WFI", true);
>> +}
>> +
>> +static void test_wfe(void)
>> +{
>> +	uint64_t start;
>> +
>> +	report_info("Testing WFE/SEV...");
>> +	sev();
>> +	start =3D read_sysreg(cntvct_el0);
>> +	wfe();
>> +	check_elapsed(start, TIMEOUT, "WFE/SEV", false);
>> +
>> +	report_info("Testing WFE/SEVL...");
>> +	sevl();
>> +	start =3D read_sysreg(cntvct_el0);
>> +	wfe();
>> +	check_elapsed(start, TIMEOUT, "WFE/SEVL", false);
>> +}
>
> I haven't thought about this too much, but it looks to me like the same
> situation with WFI can happen with WFE
>
> Also, kvm-unit-tests() makes use of WFE and SEV for multithreading, and t=
he fact
> that multithreaded tests work at all might be taken as proof enough that =
the two
> instructions are correctly implemented.

So I'm using kvm-unit-test to exercise QEMU's TCG modelling of the
instructions, see:

  Message-ID: <20260430104434.1482407-1-alex.bennee@linaro.org>
  Date: Thu, 30 Apr 2026 11:44:27 +0100
  Subject: [PATCH v4 0/7] target/arm: fully model WFxT instructions for A-p=
rofile

So while I'm confident the current modelling doesn't cause issues
(because we basically treat it as a NOP) I wanted to check the various
modes behave as they should with the above patches.

I can limit the test to TCG only if it is likely to fail under KVM.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

