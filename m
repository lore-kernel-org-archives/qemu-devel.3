Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD35606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=AsgRoVpZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVq4v-0002Ez-D6; Tue, 24 Nov 2026 07:56:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVq4p-0002D0-Be
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:56:52 -0500
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVq4n-0005ta-H2
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 07:56:50 -0500
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-677d35fd1d2so4444378d50.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 04:56:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795525008; cv=none;
 d=google.com; s=arc-20260327;
 b=O0XyMlohOUjgW+rPD+cO69BZ4FnmUaEIq9E69qIwNv4SbM8e/EmSpgLbqXIu+CuZhx
 xjBmcsi5LICRP3KSmCMHcZWNeLRSzsMZM1N6r9g8gT6Zcyvk6XEksaqtJs0ZO8y0u6Lz
 RPfwmf7Vv/hSxvIXiKC1ClH51L7UiRCInz0Ngh2JLK1/5ot32D4RCjClVwCO84nm0E9h
 S00G3WbW+ssli8Y8uOxlTZGuyYaXi8XwTX3txKZQWSmX5WfcxyCYO6UHeYsuZgUw8mdG
 K+Mu+F4yBk5/ZXc1/2/c5aCy8fmdKVwyWvRd9nt5125pwVDCVl1oizRG9ke0jS63EyLH
 zORw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ptZydUdAO5gMrta7243uYozof6VkAuFmQ5fWWpC/dmA=;
 fh=U0g1KGvIJG1SXS9gX0U+QQ//90eMkEVSf0mls2R54A0=;
 b=P3hsf5zuDV9mflh6daf8SNKWMBubyhwAgChsQuJ9DKqF4llnLuhlAnHcDdfXfxlnGo
 mdxi3L5DCXbjkU4xYxtymrUqrKaoKfEURfElx5bGS5RgEdv8f35jc7j2fS0E7tEv2lU4
 a6LGgq4pfT6YixqGjiFhDP2T7JeEkXbtO4deUmYllLDNH1JMuMTE9lZ5kaKNXa8c+X86
 JOGhnE+Dy+M4LCNb2Pl40Vd0Ys91Z4VPJn/+JtXjwkfV0nVt+BKvbIp+ARBjplH4t7dR
 OE2gdDQWJLKZTWbAvu6b9aoclI+KP3C0eYs9PdLCN+rKSpLhLJ6LxPtwSRQZY6FX+6X8
 3W1w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795525008; x=1796129808; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ptZydUdAO5gMrta7243uYozof6VkAuFmQ5fWWpC/dmA=;
 b=AsgRoVpZdWX81yLxUqjsm7iP4tPu9iqL9QYGeprAjiBu5qD+i5p4hHXSbnKNYPtrDq
 byMRtkgIsb8rtp/5pNVpxCjZtl3yWdZV6Vdsw4pe59OGPAnFK91+MZSJe/hNnOZEKh/q
 6klhlIEwPTwkANGX0k6eADD5UBipRTxJrgu52389YLTMlcUjNu1iJxIDN0HjiUqb8Py1
 CHNDNBsUBB6KQVphR6zKC0cprPWfcO4m7VpGXQczMEpMapFNFOZ2EoYTXV8VfDYEiXMp
 K2jOgMVMoD/OGyNkwipq1aKrkSOUHdBeU5MmQESck0v7qYzi0Jb+yMu2rfyRiRo0ehit
 IQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525008; x=1796129808;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ptZydUdAO5gMrta7243uYozof6VkAuFmQ5fWWpC/dmA=;
 b=Rx7OG6ftQyHInEMZpAnGPpYcc9Z1ea8U1NL+gMT71mTAAI+4uxozMARpu8FZ196Nuw
 bT+foOJung+Qusw6iwJVpi+Vj5eK7wBD+erGsAhEpMJ1Ziu9SSvLo7wUIIEX2r5tPrWO
 KWt6yT0xXrvQxcCWcRDeyRwap8+vFK0XNiplEezeOjIYWr+hQLgRSxC20hckbczdfEGA
 /pAzGLwPCmPAbVl27HNgRCGYDH7ovuvQHkN5Z/hFY8c0CxoNa2WjwwfyIBBvKfwfM87Y
 9pM7Eqvzr1IAxKpGNqi/t1v9/gy/FkQL/QLnRPy9yH71w9eKA/EziKXYhHwFFCM2Ip8D
 ebGg==
X-Forwarded-Encrypted: i=1;
 AL+hErEQOT8ZXHgqKR3t606ZtYVE40a5pgrS/VVA7DGY6oar7H81oZGr08YrCI3xAG3xob2FF2QMTuQu6PzA@nongnu.org
X-Gm-Message-State: APuU4Z9cM6lJp2Gqi85k/NJBsNVyvpjfiyBVwDUgGOrs8KhjpXa1toXY
 ljxt7uOxiTQuPHvDedHKdb/lJQC+aWk9acf8G/xlWtVPsH5XvhgH6a37PQTK03lkAU0sBAkVv2j
 y/R9pEHP9h0KOkAks/WQS9EUjApITGCbLmT9cM0bIkA==
X-Gm-Gg: AZFdTZfbCNebq9P+wmJhMViv/MfJroljZ8Gn0z+VAP1MMA7OkEiUXKSlEXrw2rjlMGw
 q7wKFPfY4tMhEz4EXrB0TjDKUSnuRl1LM0etbneu5vfZ+x7lWvEW32UbGZiK3+dd5D7gY+YoQjy
 8GROqxr+KebM0JFj3z8snPsNiwSExe34e29zFv0p37h5PXQWnW7T0jxgoMbMk7q7bmNGALn4PuN
 /xXnSn01hFexr+kn+0oKf/VDrt+R+br1aekoN4y/SVClMw3mKe3ZiT1c16vo566XWWeoQNyXTv7
 sCgnglVj6QXza2wENeuG817Nzv1hHi2K0QA9VT1oJ+4g8O0QzkkD20uKusXouODC+RE/wRC9A8D
 6n97QQltpWEEm5q/EXUbb3SaGfgB7HdEPyOLNjbT21or+VrVxIvvZBD5fJoOknwef9i2BDLmCCe
 pAY+p0ceZfboLQMp7cm4/t+veDfvGqds6gD6ocrW/R/w==
X-Received: by 2002:a05:690e:150b:b0:67d:a73e:2b61 with SMTP id
 956f58d0204a3-67df4515518mr3773279d50.99.1795525006344; Tue, 24 Nov 2026
 04:56:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261124120509.19746-1-zenghui.yu@linux.dev>
In-Reply-To: <20261124120509.19746-1-zenghui.yu@linux.dev>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Nov 2026 12:56:34 +0000
X-Gm-Features: Aa3M54qmV3hocHyszUPPNH7EVmVJ8vtrw6upS3drb0PCtF4LVz2-o4_R30eLhww
Message-ID: <CAFEAcA88=3CRBJQ5PSxrsb9F1yaL7ubF_hV8zxTQejKWnayGZA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv5: Fix value of the IRS_DEVARCH register
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, 24 Nov 2026 at 12:05, Zenghui Yu <zenghui.yu@linux.dev> wrote:
>
> The GICv5 spec says bits [31:21] of IRS_DEVARCH are 0x23b. We wrongly
> shifted it by 31 instead of 21, so guests read 0x80105a19 rather than
> 0x47705a19.
>
> Fixes: 22232793ecb8 ("hw/intc/arm_gicv5: Implement CoreSight ID registers")
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>

Whoops; thanks for the patch, applied to target-arm.next.

-- PMM

