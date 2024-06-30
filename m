Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39417C27C4F
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2024 03:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNl40-0006Ix-Du; Sat, 29 Jun 2024 23:17:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNl3t-0006H3-AU
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 23:17:10 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sNl3r-0001jg-Fr
 for qemu-devel@nongnu.org; Sat, 29 Jun 2024 23:17:09 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d5616d7273so1021876b6e.1
 for <qemu-devel@nongnu.org>; Sat, 29 Jun 2024 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719717426; x=1720322226; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k8q2D0KIGjipbRmNtDsfUfQY50UsmIKW0knd/+g3Yv0=;
 b=MydHDcl/dDxo8dqYeQocTOZB+17EQ3H7NzKH2jYf2G2jvFq29/00EbgDw2RM7LN154
 U5sD10qKmtrGLpNuvYl5DyRBRI5zfr1fKChfIUyxBypxQyrATJoAgHjfFmQj+EL/yw/I
 T2GS2Na58gQwKgKiEST1JgL5zqdRzUUHTX7L1QCR2JvypXnRnIg4KEOzdDdu01BCU6eL
 /jfO6ujJeluDH0T7liWxc9+HgQW6Xmk7rgJj7rrY0wiFe11OyC6gqtBglMHxXLTKIkoL
 vCBUn4FW/q4T4IbFlGMAnHn/SpgigVGlapI1+QTQhYg8WysaGYiKipvVF+3GFdODvBAs
 bJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719717426; x=1720322226;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8q2D0KIGjipbRmNtDsfUfQY50UsmIKW0knd/+g3Yv0=;
 b=OEgkwK1fOcA6SxwPs/K+5NvevKF0gASWwy+pVsAmzixJdIMYiQjRp56adIdyRfQ0Tw
 Ni2UGx0tzrefo7QhtyWXKO3k4dfKnww9GD2uZDPjdbSH2V4qhqyCCY35BDROIaQZC1xQ
 ODiCudiriRm7xt/EA1bS/0/XQMQ2JqS7qeVTp7tj5axF1P3Uv61VxW4JoQA7mLdsbvG2
 DuZ9IhdK5aJr9RU6QcN2PvQNkNFzZUeNQKyJhNRFiAWOd54pKbYYOtvatWMNbijnx3cz
 GCSYv59blz+S1snUjSYS5ouSnyh0Qpl/Q1WfP0LVkWl1sUPITas09qyZAAqy2FW9295a
 XUZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjxLOt+zijzfJlHFLypPn9cACn1Sf99ig/FBT8i6VXawiQmoTmNjh6g4qGh9/580P2r6r/5oWBe9f5t2PsO4ynDg23cgY=
X-Gm-Message-State: AOJu0Yx0lzvrXHX25dDtDefexipX2/3qLUzSmCB0IO+HmkvyHWhEm1kM
 uGl0BupaoKyWFMLLoR6iKtBPiqZW/JDgl+PzAnlN3qLySoNdliuIt++zguco5i8=
X-Google-Smtp-Source: AGHT+IGDYkdVsO5O9dhzrihav+bvzGlelmx50HGTxb2ixZXfBjPtW23fy9wkYgL+TA1ZM8+bCk9Kgg==
X-Received: by 2002:a05:6808:2288:b0:3d6:331d:b52d with SMTP id
 5614622812f47-3d6b2f07e53mr3506925b6e.4.1719717425759; 
 Sat, 29 Jun 2024 20:17:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044ac1e1sm3946964b3a.163.2024.06.29.20.17.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Jun 2024 20:17:05 -0700 (PDT)
Message-ID: <c9e7a8ab-aab7-4709-bf83-51cd78b41a0a@linaro.org>
Date: Sat, 29 Jun 2024 20:17:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/23] tests/tcg/arm: Fix fcvt result messages
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628124258.832466-1-alex.bennee@linaro.org>
 <20240628124258.832466-7-alex.bennee@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240628124258.832466-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
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

On 6/28/24 05:42, Alex Bennée wrote:
> From: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> The test cases for "converting double-precision to single-precision"
> emits float but the result variable was typed as uint32_t and corrupted
> the printed values. Propertly type it as float.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Fixes: 8ec8a55e3fc9 ("tests/tcg/arm: add fcvt test cases for AArch32/64")
> Message-Id: <20240627-tcg-v2-1-1690a813348e@daynix.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/tcg/arm/fcvt.c       |   2 +-
>   tests/tcg/aarch64/fcvt.ref | 604 ++++++++++++++++++-------------------
>   2 files changed, 303 insertions(+), 303 deletions(-)

tests/tcg/arm/fcvt.ref needs updating as well.
I have done this locally and will post the patch soon.


r~

