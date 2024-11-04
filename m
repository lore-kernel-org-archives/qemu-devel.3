Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F33D132BE
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7wg7-0005yE-NA; Mon, 04 Nov 2024 07:59:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7wg4-0005xJ-GC
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:28 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t7wg2-0004k6-NE
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 07:59:28 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cebcf96fabso3321357a12.3
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730725165; x=1731329965; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=usraR9Sgjvrl3oPL/nuvCEg/Bb2HrMmnGGynllF0mp8=;
 b=X845xrSQ+cSQXnxrF4XGTzqkzMHt3PWis88CK85ljW0jlmsBh9dnaeK1y3eh3EkzFO
 GwHETMnVs4/qAOF77OLJYRP4Ar9B3f8NMDQWRsogxpoJ01NzDdG7Ust/EI3jT9l1oXuV
 +VMfsJUdUnGCA+YvCVYJrrjmDXgfdNBOGtHAtuSex4uDKVvY8C4rGGicHCyt59aifyXs
 bTBY1VQu5jQH5KrENDBml9cEoWvntOTOer+VB4dbEdRGN67+FQTrh8kYkkecOktFpvpb
 Cp+4tzOLf0cL7H00onxlgQePnHiZNIWAs+azcslIPr+DTEqNHdvj0FhKKivwmQqHvxms
 ZQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730725165; x=1731329965;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=usraR9Sgjvrl3oPL/nuvCEg/Bb2HrMmnGGynllF0mp8=;
 b=pyCmLBCVfCiBQnPawRNKmNqDU6mAp3NoN8Uakfq8NnQxAthXMj0Yn1JfXgCsDuJRX3
 8suFfPZUkFX4Tho2KIOsN7RQKJzG4RqUc8Q8AVFsurWt7pg7fhVMCkF5d0aANlvIYumt
 GH0/70wizROoVMTc9ybZhKsC020zqjsXS6sBcOkFg9XNmmOXfYhU0tsB3q2w3oZ5rdS0
 5EA7R5Gg9CjmJicAWeg40ZwVffzj04j4Fz4i/PSxyU4QyJjt5M+E2eV9ksZ2edXv94+o
 WqOPMd1rZopnMwf7hkaxT87Kf1NyT7Po9bDkhGDXLY+idkznF0ggSgzoaYYc1znarXJb
 xCvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmE2PPBN93CKwTd1e8J1s6lmaQfY6/h8p6QlU69UUs5nDpq3wbT8/lYBSGLRQg1FYqHb2j5Dyi0jRZ@nongnu.org
X-Gm-Message-State: AOJu0Yx86TqWlERKPPvut2FubTUwDIE6LVjHs/CLEHnug0mCVSSdrynt
 HWWpx6JVanCfd0m91CW2KjHE9NMT//PBcBS6BSkq39/tp9SwyQI02A99U+Oilbha8wZKlWI1Iqe
 kg2TnephUlhyHgdXTGTI1sh1fjI6YlerKZ3A/Vw==
X-Google-Smtp-Source: AGHT+IEtkTxVRm1ugB3qMguSrtdycCuuk3RD9sAK1U2bF2H/UtAFPHiISf6/mluEZdavvc87nU+wC589eL1G8Cnpebw=
X-Received: by 2002:a05:6402:2708:b0:5ca:da2:b2ca with SMTP id
 4fb4d7f45d1cf-5cea96894e1mr12916774a12.19.1730725163502; Mon, 04 Nov 2024
 04:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20241101142845.1712482-1-peter.maydell@linaro.org>
In-Reply-To: <20241101142845.1712482-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Nov 2024 12:59:12 +0000
Message-ID: <CAFEAcA8Uhj+HN0ieYetOwFEkfTb2p_71dp-A2bpc2m=nz2sHXg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix EL3 AArch32 MMU index usage (again)
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Fri, 1 Nov 2024 at 14:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In commit 4c2c0474693229 I tried to fix a problem with our
> usage of MMU indexes when EL3 is AArch32. The problem we're
> trying to fix is:
>
>     Architecturally, when EL3 is AArch32, all Secure code runs under the
>     Secure PL1&0 translation regime:
>      * code at EL3, which might be Mon, or SVC, or any of the
>        other privileged modes (PL1)
>      * code at EL0 (Secure PL0)
>
>     This is different from when EL3 is AArch64, in which case EL3 is its
>     own translation regime, and EL1 and EL0 (whether AArch32 or AArch64)
>     have their own regime.
>
>     We claimed to be mapping Secure PL1 to our ARMMMUIdx_EL3, but didn't
>     do anything special about Secure PL0, which meant it used the same
>     ARMMMUIdx_EL10_0 that NonSecure PL0 does.  This resulted in a bug
>     where arm_sctlr() incorrectly picked the NonSecure SCTLR as the
>     controlling register when in Secure PL0, which meant we were
>     spuriously generating alignment faults because we were looking at the
>     wrong SCTLR control bits.
>
>     The use of ARMMMUIdx_EL3 for Secure PL1 also resulted in the bug that
>     we wouldn't honour the PAN bit for Secure PL1, because there's no
>     equivalent _PAN mmu index for it.
>
> The "spurious alignment faults" part is
> https://gitlab.com/qemu-project/qemu/-/issues/2326
>
> Commit 4c2c047469322 tried to fix this using what I described in the
> commit message as a "more complicated approach", but didn't get it
> right in several ways. Full detail in the commit message of patch 1,
> but the major visible problem was that regime_el() would return 1
> even when the CPU was in Monitor mode; this meant that page table
> walks in Monitor mode would look at the wrong SCTLR, TCR, etc and
> would generally fault when they should not.
>
> Rather than trying to fix up the multiple problems with the complicated
> approach, this series first reverts that commit and then fixes the
> initial problem with the idea that commit 4c2c047469322 describes
> as "the most straightforward" approach: we add new MMU indexes
> EL30_0 and EL30_3_PAN, and use the EL3 index as EL30_3. These then
> correspond to "Secure PL1&0 at PL0", "Secure PL1&0 at PL1", and
> "Secure PL1&0 at PL1 with PAN", and parallel the NonSecure use
> of EL10_0, EL10_1_PAN and EL10_1.

The submitter tells me that this also fixes
https://gitlab.com/qemu-project/qemu/-/issues/2588
(a different variety of "misbehaviour in Secure Monitor mode").

-- PMM

