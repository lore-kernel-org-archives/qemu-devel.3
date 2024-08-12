Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894F4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:57:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQrF-00012w-W6; Mon, 12 Aug 2024 04:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sdQrE-0000zW-Dx; Mon, 12 Aug 2024 04:56:52 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sdQrC-0007fb-D1; Mon, 12 Aug 2024 04:56:52 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5a108354819so5257345a12.0; 
 Mon, 12 Aug 2024 01:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723453008; x=1724057808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pwj1l/v8vmo0WVQsRXxiPvKgQwT9EeGJS92n+uiDDlU=;
 b=GUbCQ87xKGbL15m/o6OkV0vkXLnIIOb7vzy8lt2IES/YMC0/uP8nTHedsIbbMcjnUC
 R473727uu4plAY03bKf1oXLb2YPS5W9XOE2CaLLgflEdOsO1xHiYIhfFLJof9/SwzgzG
 VF52ps1tmJ0cjt4s3dLn/DAbLgMcpOSjG1UFhfAyTJe55LBJymfUmxkbmr0kpk2lZ7Jr
 yKU84xncCSoUuwioxPvzypeSaXP5EXUwu1vEvrtq3pkat3GVDmAkQEHXIcmSVl8zutRt
 01tyKQCeoYWLxM+YtYnrSuaiQljYDSyQAKTPPxLPFrcHkDt2iwUlaQ8/9dny4W1EHvxf
 AQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723453008; x=1724057808;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pwj1l/v8vmo0WVQsRXxiPvKgQwT9EeGJS92n+uiDDlU=;
 b=f7wTrAloe/dEsH1hlZaiFRXTWbA49oiISRh8PtRqy+YBehMPxj511+uUud/covOAAi
 fdw6P2bf5tJzkLZ543bg3T2EKifVPV0JQqpKteAmOIytpnDi0IsgNaNuFOAmkvdYJyHh
 TlkKIK4Dx0sqQdoez6ON12uD9fK1b5JFBhK9F2YeUc4RKzf3sPFU4TJmH6eNDJ05shZt
 EGq1Wo479MwKQOJEgA+EZ/+ryQ66Tu+Qzf1JNAXdTOS7xbydmNC80YY6NGYMn0q16RX3
 8P1VXdB3EtIRFWahfExO6vO7r0RnKmb/YCLhnmQ2gYhEsK32jYpzSRVFraTwpbSR/rnB
 V5Dw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8NbedVqjnGNqJs/QwOpuWjoq0Lxiev99GbtzlyHvNoUSYzDuQK6HCJNzSHn9SyUyam+l+T8d+3dFW8tPzSWl9LhSTKG2wCdfFhpbNN5f0hlGN+k/TAoEyGKU=
X-Gm-Message-State: AOJu0YybQOkg27y3/21GPpg4tEyrfdD0p/1V7BLsLod8PCO+HlBdq47+
 0OLXYmrFsoKeECRQNG0R8sobp1KVM2T37347KnlR/k+Jkr1rX7ZY
X-Google-Smtp-Source: AGHT+IEWS6twxHNRfU8xhbBpUg03fQTQ9ZuQqRvmMbNKf1S7TVmJW/CjOLAHbynrW9Ys9DZoIzy9+w==
X-Received: by 2002:a05:6402:358a:b0:5a4:2c8:abda with SMTP id
 4fb4d7f45d1cf-5bd0a50a533mr6107529a12.3.1723453007410; 
 Mon, 12 Aug 2024 01:56:47 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-028-074.77.183.pool.telefonica.de.
 [77.183.28.74]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bd1a602e67sm1914053a12.97.2024.08.12.01.56.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 01:56:47 -0700 (PDT)
Date: Mon, 12 Aug 2024 08:56:42 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
CC: qemu-stable@nongnu.org
Subject: Re: [PATCH 0/2] target/arm: Fix EL3-is-AArch32 mmu indexes
In-Reply-To: <20240809160430.1144805-1-peter.maydell@linaro.org>
References: <20240809160430.1144805-1-peter.maydell@linaro.org>
Message-ID: <607DEC48-4E7B-4985-97C4-8F80785BA83D@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 9=2E August 2024 16:04:28 UTC schrieb Peter Maydell <peter=2Emaydell@li=
naro=2Eorg>:
>Our current usage of MMU indexes when EL3 is AArch32 is confused=2E
>Architecturally, when EL3 is AArch32, all Secure code runs under the
>Secure PL1&0 translation regime:
> * code at EL3, which might be Mon, or SVC, or any of the
>   other privileged modes (PL1)
> * code at EL0 (Secure PL0)
>
>This is different from when EL3 is AArch64, in which case EL3 is its
>own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
>have their own regime=2E
>
>We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
>do anything special about Secure PL0, which meant it used the same
>ARMMMUIdx_EL10_0 that NonSecure PL0 does=2E  This resulted in a bug
>where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
>controlling register when in Secure PL0, which meant we were
>spuriously generating alignment faults because we were looking at the
>wrong SCTLR control bits=2E
>
>The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
>we wouldn't honour the PAN bit for Secure PL1, because there's no
>equivalent _PAN mmu index for it=2E
>
>We could fix this in one of two ways:
> * The most straightforward is to add new MMU indexes EL30_0,
>   EL30_3, EL30_3_PAN to correspond to "Secure PL1&0 at PL0",
>   "Secure PL1&0 at PL1", and "Secure PL1&0 at PL1 with PAN"=2E
>   This matches how we use indexes for the AArch64 regimes, and
>   preserves propirties like being able to determine the privilege
>   level from an MMU index without any other information=2E However
>   it would add two MMU indexes (we can share one with ARMMMUIdx_EL3),
>   and we are already using 14 of the 16 the core TLB code permits=2E
>
> * The more complicated approach is the one we take here=2E We use
>   the same MMU indexes (E10_0, E10_1, E10_1_PAN) for Secure PL1&0
>   than we do for NonSecure PL1&0=2E This saves on MMU indexes, but
>   means we need to check in some places whether we're in the
>   Secure PL1&0 regime or not before we interpret an MMU index=2E
>
>Patch 1 cleans up an out of date comment about MMU index
>usage; patch 2 is the actual bug fix=2E
>
>This fixes the bug with the repro case in the bug report, and it
>also passes "make check", but I don't have a huge range of
>Secure AArch32 test images to test with=2E I guess it ought to go
>into 9=2E1 as a bugfix, but the nature of the patch means it's
>not very easy to be confident it doesn't introduce any new bugs=2E=2E=2E
>
>Bernhard: I suspect this is the same bug you reported a few months
>back in this thread:
>https://lore=2Ekernel=2Eorg/qemu-devel/C875173E-4B5B-4F71-8CF4-4325F7AB76=
29@gmail=2Ecom/
> -- if you're able to test that this patchset fixes your test
>case as well, that would be great=2E

Hi Peter,

indeed this fixes my guest, too! Thanks for keeping me updated=2E

Series:
Tested-by: Bernhard Beschow <shentey@gmail=2Ecom>

>
>thanks
>-- PMM
>
>Peter Maydell (2):
>  target/arm: Update translation regime comment for new features
>  target/arm: Fix usage of MMU indexes when EL3 is AArch32
>
> target/arm/cpu=2Eh               | 50 ++++++++++++++++++++++------------
> target/arm/internals=2Eh         | 27 +++++++++++++++---
> target/arm/tcg/translate=2Eh     |  2 ++
> target/arm/helper=2Ec            | 34 +++++++++++++++--------
> target/arm/ptw=2Ec               |  6 +++-
> target/arm/tcg/hflags=2Ec        |  4 +++
> target/arm/tcg/translate-a64=2Ec |  2 +-
> target/arm/tcg/translate=2Ec     |  9 +++---
> 8 files changed, 95 insertions(+), 39 deletions(-)
>

