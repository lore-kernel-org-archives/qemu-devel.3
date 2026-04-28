Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA46EFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 14:57:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHjrr-0008Gb-QR; Tue, 28 Apr 2026 10:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wHjre-0008Ez-NL
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:56:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wHjra-0004zW-LX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 10:56:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4891d7164ddso58881185e9.3
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 07:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777388195; x=1777992995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZI5euwIVJ9QjGGXPpUqegNn9IsxNW5sxSo5xHMvQY0=;
 b=KviAAGiAo3AEztu57FBIs5/I1SMg7xjAeXVHHw5w3Z/1sP7RjygaZRnOugXjtZD5cg
 1yaQR9HNct4OiZ6VqGB9PukcR1dOdZUQd7p9E7mpOOluA78nUrlaAg2GXTJYyvGDx02b
 FluaR5r4Kp6n2mvlZzAtEBxRHXmDLKkWbk1KVTdzzeoVfIFLigevy6gH97yebKqOHhgc
 gvb1c2ddWNfki3yTwonpczJApKRkf7sbVB08UIGcdI1Q7ISfCsEJXr2S+ToNgpBruVPf
 jIdWxwgWsFzkZg5kT9jgt6ggB96eW4S72SG4r62JU9qWUVHB32dL3gawf1YW94vLLNwE
 SCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777388195; x=1777992995;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FZI5euwIVJ9QjGGXPpUqegNn9IsxNW5sxSo5xHMvQY0=;
 b=imlDa/3tDsHGkFXyEZZl6KAuR0pzb+P3NxnGjUoeOTXP8fapE+RmiU8bRUSOdmjhpj
 syPgQAt+heuY+cRzVesAVr0tx5rSvdDciOQyAvB+E6krV4yj5yIsnarlnTGtpsS039zs
 1SYP84nzDfLFkARmz3HZx+V3hhxpETrncb00OuQM57hmX4IU9gAxG4H789TL0Osq3Y7y
 Q7cqT0ZsnJ1jfMVWHvVxg4tl5DbNfrwuaKzXZ0pgqagTXamb60WJM8F5XveYR5NS8N7S
 lD4cFhnQa/y+Q5HCmc+t5SmKo6BaBWylpUuPINsGCgf+zAI40YjcXZpNjYliTfeiaaF8
 PCmQ==
X-Gm-Message-State: AOJu0YyYxNMMf4qQ0DwALbGrQSShIeVD1tSXJ8FBqoIF2t+TGoFLtucH
 mXNxc16ZEP2K7q7MXirQjPGkUQhtcG0qY5VvGSnDvDNuegHRfIkQnBFWSMDyyNTwabA=
X-Gm-Gg: AeBDievxTy9mnl8Rz/myjMUv7wvPuvshaTfZE70mMR8/pb0kP+CusxCo5g6MqE+j7cH
 Lmz1z6X5C5HmYqMFbL4iGuwyfq+Lm5CvgmpROBNOhnk6/zA2+0rsgz/naHnDf/OyWTbOdzHUVOE
 vwjV+RtsbbWPiVJLeB3XdZGwcbIKYuPsoXcDVhZcjG40EpjKu7qdV80En5/TQOJ2UnI6cYufi41
 2JC9WIWmvTvypWNgITg8GWzlNVuSmHh8ROHPNrTjeoC9LqVUxIarwwi3U/euSbkMoVknuG9Pxei
 n91Qn0xOtOtXbwbG2eNTROIoKOjwRRrZ5EGXXtPTJyLeBrbfKrJsSkYvXmL8BtNVyI/2+2jBhN3
 7ITAY5h78EFQOPknCCy7KTbLSxI4CfrJZBBBzXI7ObXYsxVnZpMX6xsrc7y+JjCLNqwTyHjkWv9
 aFVVSk5Drhm9hkj+sNBv1Y5Ld3pOzX12B6lg==
X-Received: by 2002:a05:600c:3f14:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48a7b535a0dmr61415e9.18.1777388195308; 
 Tue, 28 Apr 2026 07:56:35 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774c3ddfsm47637275e9.2.2026.04.28.07.56.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 07:56:34 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8317F5F7BC;
 Tue, 28 Apr 2026 15:56:33 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joey Gouly <joey.gouly@arm.com>
Cc: qemu-devel@nongnu.org,  Andrew Jones <andrew.jones@linux.dev>,
 Alexandru Elisei <alexandru.elisei@arm.com>,  Eric Auger
 <eric.auger@redhat.com>,  "open list:ARM" <kvmarm@lists.linux.dev>,  "open
 list:Default mailing list" <kvm@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH] arm: add wfx test case
In-Reply-To: <20260428132657.GA591628@e124191.cambridge.arm.com> (Joey Gouly's
 message of "Tue, 28 Apr 2026 14:26:57 +0100")
References: <20260427130045.3669851-1-alex.bennee@linaro.org>
 <20260428132657.GA591628@e124191.cambridge.arm.com>
User-Agent: mu4e 1.14.1-pre3; emacs 30.1
Date: Tue, 28 Apr 2026 15:56:33 +0100
Message-ID: <87h5ovdtge.fsf@draig.linaro.org>
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

Joey Gouly <joey.gouly@arm.com> writes:

> Hi,
>
> Few small comments.
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
>
> Instead of a hardcoded TIMEOUT, what about something similar to arm/timer=
.c:
>
> 	u64 time_10ms =3D read_sysreg(cntfrq_el0) / 100;

ok

>
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
>> +	local_irq_disable();
>> +
>> +	check_elapsed(start, TIMEOUT, "WFI", true);
>> +}
>> +
>> +static void test_wfe(void)
>> +{
>> +	uint64_t start;
>> +
>
> I think a comment here would be good, just to say it's testing that a wfe
> doesn't sleep for a 'long' period with no pending events, or something li=
ke
> that?

ok

>
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
>> +
>> +static void test_wfit(void)
>> +{
>> +	uint64_t start, timeout;
>> +
>> +	report_info("Testing WFIT...");
>> +	start =3D read_sysreg(cntvct_el0);
>> +	timeout =3D start + TIMEOUT;
>> +	wfit(timeout);
>> +	check_elapsed(start, TIMEOUT, "WFIT", true);
>> +}
>> +
>> +static void test_wfet(void)
>> +{
>> +	uint64_t start, timeout;
>> +
>> +	report_info("Testing WFET...");
>> +	/* Ensure no pending events */
>> +	sev();
>
> Could this just be sevl here? Not that it really matters.

it could be - ideally I would extend the test case to work with -smp so
we can properly exercise that code path as well.

>
>> +	wfe();
>> +
>> +	start =3D read_sysreg(cntvct_el0);
>> +	timeout =3D start + TIMEOUT;
>> +	wfet(timeout);
>> +	check_elapsed(start, TIMEOUT, "WFET", true);
>> +}
>> +
>> +int main(void)
>> +{
>> +
>> +	if (gic_init() < 0) {
>> +		report_abort("GIC init failed");
>> +		return 1;
>> +	}
>> +
>> +	/* Install timer handler for WFI wake-up */
>> +	install_irq_handler(EL1H_IRQ, timer_handler);
>> +	gic_enable_defaults();
>> +
>> +	/* Enable Virtual Timer PPI */
>> +	gic_irq_set_clr_enable(27, true);
>
> Instead of hardcoding 27 here, you can use:
>
> 	u32 irq =3D current_level() =3D=3D CurrentEL_EL1 ? TIMER_VTIMER_IRQ : TI=
MER_HVTIMER_IRQ;=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20
> 	gic_irq_set_clr_enable(irq, true);
>
> Which also allows the test to run at EL2.

sounds good.

>
>> +
>> +	report_prefix_push("WFx");
>> +	test_wfi();
>> +	test_wfe();
>> +	report_prefix_pop();
>> +
>> +	if (system_supports_wfxt()) {
>> +		report_prefix_push("WFxT");
>> +		test_wfit();
>> +		test_wfet();
>> +	} else {
>> +		report_skip("WFxT instructions not supported");
>> +	}
>> +
>> +	return report_summary();
>> +}
>> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
>> index 12fc4468..7adf96f2 100644
>> --- a/arm/unittests.cfg
>> +++ b/arm/unittests.cfg
>> @@ -339,3 +339,8 @@ groups =3D mte
>>  test_args =3D asymm
>>  qemu_params =3D -machine mte=3Don
>>  arch =3D arm64
>> +
>> +[wfx]
>> +file =3D wfx.flat
>> +groups =3D wfx
>> +arch =3D arm64
>
> Thanks,
> Joey

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

