Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D63C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 15:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPOAF-0000OV-Ng; Thu, 04 Jul 2024 11:14:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOAE-0000OD-CT
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:14:26 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPOA9-0003A5-OP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 11:14:26 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58b447c513aso898493a12.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 08:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720106059; x=1720710859; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hX2WwmzVNzhxTT7b+SDkAoJmUOsIEXI/igO2mroUR9A=;
 b=ckQDqUvfStgXx2gZp1KmtsLdgHrb5nyJ1Xbgem4C3mqmB2Y5iY1qFeoHR3GUGG2JE+
 U6wBBWbFXUGb8T96F1+Zo0nCbQ7nyj2gxV4wUu9jsm4SYMBFOaHx0b2U9bSZtRpd7ai9
 uQCoXHzb6ueGT2TqTO2zOsfGqvEblpalHYphdnuASmN3fbzhe3Gkp2PPlhmcFAIV0MXx
 H9llnlhhdM3ruPzILUFC2p/YcuJR4DLEwh2MPkHeabDmmFiAbB+bQmRggX93qqlvAbF5
 zfKiePVBncqsEPfymITn1drWQW5gaWjRHnZnLXGOV+/eRe1gHt8F1dqoamG3AeUfjLiC
 n8fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720106059; x=1720710859;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hX2WwmzVNzhxTT7b+SDkAoJmUOsIEXI/igO2mroUR9A=;
 b=XCQzMHi/TJ7/kbk8Jo/Oai8olmDZM7eit/XjPVQstY0vsnevizTwgT+odk0/GCYzNx
 PTw4INaMPeS9bf+LZeruk+Rb8QmWcF+vmiCWMwmafDvdoGHNqOSMQnpT3NAOgWIdxEh0
 Nb5vbrxRT9dYrtKXA8FnTNqBLqELAtPca9s1OFRu5cEmForYK1nlOvVJt57CynQIJPGP
 bVXcly9c2LwJFllsoNXHZQyZlnpCyf9A1pFmIX0joK8+0rjmz5ekFHh/Xd/bm3F+5mNy
 NSlCt5SWYC6FTt3haHHJ/7+x67By29OzhyhUn6lehpT7bLML4KYBKzQj0ui1YXxsVX2X
 6ALw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXep1gAozVioLVWChGTVSHj7snhqmpZw/NwM7nakZ+bWt3y9qyenb9heK96tTK600L40WX1hbdGRMK6eTwqGN/nLPdLlHk=
X-Gm-Message-State: AOJu0YyZDsOSKYeBgi7IBusizf1g8dXB7fNavICP6qgSqKpfJPtjHQY9
 7ZLfYbUWG8+4DpqIoyH9vqjLa00P5cd0zxLBHw7H+RQJ9hUQfE4LCAN0YzrZHbhS0+AbxUmeVd4
 iU0gvvZ0mzJR0btPD/8X9mS4ugWC5vVjrTdwhBQ==
X-Google-Smtp-Source: AGHT+IEik4Msst34cAle3zHwP//FhNRcSYty3m+PDcYMR/u/rN8qP0zKRBBM86HMC6WLvnpBUGEk3OiXzmdT4GNRors=
X-Received: by 2002:a05:6402:5255:b0:58c:7c2f:5c0b with SMTP id
 4fb4d7f45d1cf-58e5b4ae20dmr1284314a12.25.1720106058133; Thu, 04 Jul 2024
 08:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240702154042.3018932-1-zheyuma97@gmail.com>
In-Reply-To: <20240702154042.3018932-1-zheyuma97@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 16:14:07 +0100
Message-ID: <CAFEAcA_FkMAmmGnKkpAHokmvfXscxWQyGmnKAU-rM3+RyHSNsg@mail.gmail.com>
Subject: Re: [PATCH v2] hw/misc/bcm2835_thermal: Fix access size handling in
 bcm2835_thermal_ops
To: Zheyu Ma <zheyuma97@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2 Jul 2024 at 16:41, Zheyu Ma <zheyuma97@gmail.com> wrote:
>
> The current implementation of bcm2835_thermal_ops sets
> impl.max_access_size and valid.min_access_size to 4, but leaves
> impl.min_access_size and valid.max_access_size unset, defaulting to 1.
> This causes issues when the memory system is presented with an access
> of size 2 at an offset of 3, leading to an attempt to synthesize it as
> a pair of byte accesses at offsets 3 and 4, which trips an assert.
>
> Additionally, the lack of valid.max_access_size setting causes another
> issue: the memory system tries to synthesize a read using a 4-byte
> access at offset 3 even though the device doesn't allow unaligned
> accesses.
>
> This patch addresses these issues by explicitly setting both
> impl.min_access_size and valid.max_access_size to 4, ensuring proper
> handling of access sizes.
>
> Error log:
> ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Bail out! ERROR:hw/misc/bcm2835_thermal.c:55:bcm2835_thermal_read: code should not be reached
> Aborted
>
> Reproducer:
> cat << EOF | qemu-system-aarch64 -display \
> none -machine accel=qtest, -m 512M -machine raspi3b -m 1G -qtest stdio
> readw 0x3f212003
> EOF
>
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

