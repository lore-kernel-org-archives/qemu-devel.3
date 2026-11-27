Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A17C606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=x8u/Q5BV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWyt9-0003BF-Rt; Fri, 27 Nov 2026 11:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyt4-00039X-Bz
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:33:26 -0500
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWyt2-0008BZ-Sb
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 11:33:26 -0500
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67bee1f693bso6482267d50.1
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 08:33:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795797202; cv=none;
 d=google.com; s=arc-20260327;
 b=noPOLbJ1km/xFkcCNybynA7/vQWXUgwVX0XbvkWZccmyyzdsCxfieiDhoolxTmMJqJ
 oPkYPQzeYCZmdLuRw9Kb9ZSEtNU9wb7fBhJNSo0OpBinO/aVDJxC2lTxt9OB9R0RnSu/
 EoDRQeHe+lPZlObwKVFcaW4ro5jU61wSzgVKZwHD/+ubz7o89v6yLiPjaJaSSVq+fRhg
 X7yO5ppn8/ZbzSWe7aMipjaltSLZBTKeaebhqJoXbN6ZWpChOIFXbxN3iUxM5kDxueiX
 5SEpm7oj3ED4PBZ0TjSIToGbNfdyIOskYODb+Q0F7Fm97wYrWq5L9owqfVdbIp7RFYDt
 HWEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iluEXWYLL8WenezfR5PfG2NcJ+qFJ8RrrrOgkSCrR/Q=;
 fh=/ftcwOPYeEIhzseC7WF42kR+xVR/IJiWpLC1+A7SOWQ=;
 b=eMz6YN645DKHdurIx5LXM3dasavLJItFKDtsTg8CeNv3bG3ZZFh8ts4fXW8i63EI4w
 iOSKzD/zVyBVnMbjsM67WMhPC6tacOdznfQJjxNb7VPngCQfpRt3CPMtLAcQCElZr4Wm
 f1J08MV7atV0Rpu7ErCM1DMT9Klxz6/f39o6Lv0wMixoG0txuaWEVZkb3RzXX7llHbZX
 2law5qR16eqFMRgSKk+lV/nb71FAHtTR21AZ9EPkliAPhxqGf1PxE/l/1sXsn9XtzfBN
 rYFihdoJ05tmj4bXUPpSEa5x883+gVKPz9KBdV5hp9HWzZuOb1d2mWhPST/ex0ZpMC+S
 K6Aw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795797202; x=1796402002; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iluEXWYLL8WenezfR5PfG2NcJ+qFJ8RrrrOgkSCrR/Q=;
 b=x8u/Q5BVVg5er9kGjScLYCSdiioQSQCzUULTfpPRITfKeSOCMgQiR9jDXBy2G3io8y
 yPOKtjGtqXaN9WiVZH1tY08vZ0/Hs+i8FTyxFDWygpbscTyaIR2m7UhVHlCRL1NwLhO5
 UIkVMRDDVVhfLqMKAiVqi80FEuNAq9Xpre4i8jpZA424/NtVWi21MdeinuyMPU3fem+v
 zS54NrjJMnG2wLFx3oQGSnuluLgGRiNw2WiqG6Wsr3TbJEmEb4j8Y6pGLGxNwW8+KdcP
 J70ddHwzasvrWD/aY0d0WwP6uPboqf39LKrLaj/t+dxU2+sJSSvBxq44LrS+vA/u9C/u
 /jPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795797202; x=1796402002;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iluEXWYLL8WenezfR5PfG2NcJ+qFJ8RrrrOgkSCrR/Q=;
 b=yXzk470/7dY6VPcOGn4qwVTT8WAebwYtgSLC+LqUTF8QAfDrq3AqVTgRJO4cEcOrHG
 PbJlDRmUkW0/qRClpuCovJXZxjzMtJQdcdS2AW1+aHKiTu6BJ064EHqrtt7eOuDsw0Bo
 iWA3VdfZF5ZP70Emjpz+x7N11x1jrQBVCFJlF+A09C+11cBDfVjLfPz/NOCyAGBl8BzL
 N1ebgI657SYnOy96KFNNPYdEFKDDwdJdY5zOxrAYgAjL8SkvYTDB6gFl3g2y0x9y1vgA
 5hCdYZfnmy+L+7aq8DTChDTlPIJ81TPpK0XlMu/KwgArfFyatFN1qd6H4mTwo0tHMh51
 Byjw==
X-Gm-Message-State: APuU4Z/x9uZFHP2/xMmZUWvY6T/aE/fcBNDkC4LjOTYQ/QWiw7E7tUBG
 KpaZZOY3+kSn9V06lg4ZJtZmXY7uClyYVyZYTwFG/j2ubxLtCZGLrLUDJme1AaW4z21Ug7SGd7k
 8WKMw4pWzcEwOiY+YmRO6OWkQ8dwO7jKSaq0sNJX65A==
X-Gm-Gg: AZFdTZcW1/tmNxbwRtlUOnRJgFFmD9bL3G9tyK/jARfBI5GLcC67VL/MnyOvG7n6tVg
 k2dSTlQMaI60RT9k+1xY08LTgAWJXqXYKfVYlx1eYNiOmrVcQyBPLhAMoL5OGcISp9G0D4pBWcr
 upRnsFbB0dXLxspqHe8+M+I7TYqYSy+OqJNT4XXClPJioCO+L5dNWN5c+HUB8A2oHRaQwZUPvUh
 zumgSE2pEUmzaQdGTOwlPaXyET/M0Lej/FMFVMPsnC3txDeW9e94h7Y1jPU2N1at2MFAKtd6XM1
 b/LPOWvj5U+r5VkeFiF993FPUE3nnllp3FbGmXF8cO1bDFrmIDPcfRB+Rnrgm0sl/al6YSXPaor
 3Llhr80DMDOfq16hI16LNpN0dZZktPZa+qgGcFIRkIMDGtcq3601DOiOUFzXbY7ZXI68JNdz8vI
 YK4wkEZsLmoyQiW+d2HJLQ
X-Received: by 2002:a05:690e:144f:b0:67d:f32c:3bd9 with SMTP id
 956f58d0204a3-67df43f4b0dmr13002951d50.21.1795797197294; Fri, 27 Nov 2026
 08:33:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030194318.319310-1-richard.henderson@linaro.org>
 <20261030194318.319310-5-richard.henderson@linaro.org>
In-Reply-To: <20261030194318.319310-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 16:33:06 +0000
X-Gm-Features: Aa3M54pN8hijM6stuWJcMfe5HNCoFM0070__Fewu911fHDSwdmHE1U2U3wnJm5w
Message-ID: <CAFEAcA-tJRerH0x+LZjMWzX2pYLijaz3nn4+txBnOmVS5GnQ_g@mail.gmail.com>
Subject: Re: [PATCH 4/9] target/arm: Split out gen_goto_tb_int
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 19:45, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/translate-a64.c | 38 ++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 16 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

