Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C10C282C6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 19:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpB4O-00082E-1p; Mon, 03 Mar 2025 14:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpB4M-0007y3-1I
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:03:14 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpB4K-0000Of-Db
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 14:03:13 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so30854865e9.2
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 11:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741028590; x=1741633390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HpNCDMqr9ofV4zMIvFBgpuAzQ6AQt2EVqCFH295cKBU=;
 b=Nm0H6T03c8ABGAeHxlvQWklTI2V3ujHddL7xNbzEGHF/82DwInJih3bi6Te4G4YGJx
 u8vGZeQIQEwKwjZMAbjdygh50rI/v4/dde7kndS8Qe1zEQhdFk5ZnJwm1+JaG9uXCOqP
 rC34rZEbQLcKmZHvYNAuytATTXLJ4PoZSqRUiHq57xk6rxcmPETdw2WqzraYDdTGEei+
 5N1P1/GU3BO6NySPG+b4fdKimK0qiCP7XOWdn7lnTcrwpHCkThYxt8aQnaPgaqFqrSVt
 75ZJ/zqzxnY+JhsCQwe6Mt4/ZbDQaXnLCr6u0zyAkAIGe/AvbbGzeFqnqEzp5+mKYBCe
 sOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741028590; x=1741633390;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HpNCDMqr9ofV4zMIvFBgpuAzQ6AQt2EVqCFH295cKBU=;
 b=a4n+RM3Fpyp+a4wIRCqxRFe6Ua++ufZf5orDfMdfGB/OlHvrurGZ0+zYJC6slNed3k
 LSQdZLY1Enkzm+DbubmGbMKInd35P1rxzdy6f4bKZ6hlNalkxEgiZmpkI4TIrauZpO5y
 dHuDlynf7XYLz9P/zlXEDuozpYn9xW+e76/qFIB5iRPTqeZZLmmqHc7TZ9oUzrUHaAry
 oUGNhlznS6XjjKwbPTzLzpQNLBeQlcu1kgsaYP7COZ28G/pPsyZuWaAox1dZebRsVcbt
 OULNBVdvIq8rJZFyfYk8befsiUOiRTRwYsBadtcL/9zFVv59SQeKTFe7Qk6ENCxKblIU
 qskw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFFwJ/9TPR/YVmhvm3R5g+SpXxLPTxuUca3EXO7UV0oOh7SvUmrXwlQfxzSGNOdfMjQtx6x+GILj65@nongnu.org
X-Gm-Message-State: AOJu0Yx763Pc5FbHZNAoYm5FGvEoz6FVbgnhPVJQPgh2F3wrRgT/B38q
 HsygpFPytcnub2NvPsTHM6WrsTTYx7jkDlRWSvm9qt+0qfe+79ceB/TS+mbsoWo=
X-Gm-Gg: ASbGncuCgdg33HEAFraL2ajYJuo1wkYSETIeyR6bIeoKi4Gl2YVh5wqVNaNtZSOOCJA
 6DofEd5br4yVd9wtqErhwgF9UB1xp51qceUY/qyCRCFUdfRs1jBQf7acZuTvqUakNAd44Kr+uFF
 gqOQDZ5e+fARRjZ7Zp1h4KMboruHOmY1UX/f5aEh9TQM/WAp+IJtvegVEzC/jpO+hZi5DZ1FzJ2
 WVvKVn2dRkupfWoC5H/reEWXQaYmC0z4F2U+nraH/B2eSCjcCdnNVzVPA+kdk+Pr4VJdnoErxsn
 gWPhWw0NgHeIr5etLceWgoUkTNzaxXnmsVRvkgFHxFp7I67B1meEljTjbEKtNYLOdfpe4y2XF7B
 80+MNXDGmel2w
X-Google-Smtp-Source: AGHT+IEgpXDh5bbA1oMbYFshI1H7iWJ2ylywogCfKe4O1oeGdDHJAOiIwMNy5OxfkSLs+hOJgapgtQ==
X-Received: by 2002:a05:600c:6545:b0:43b:c0fa:f9dd with SMTP id
 5b1f17b1804b1-43bc0fafe4cmr34625185e9.25.1741028589706; 
 Mon, 03 Mar 2025 11:03:09 -0800 (PST)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bc63877desm20482495e9.1.2025.03.03.11.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Mar 2025 11:03:09 -0800 (PST)
Message-ID: <afeba573-188d-4101-ba45-22cb0fd79a72@linaro.org>
Date: Mon, 3 Mar 2025 20:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: add boot error detection for RME tests
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Troy Lee <leetroy@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>
References: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250303185745.2504842-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 3/3/25 19:57, Pierrick Bouvier wrote:
> It was identified that those tests randomly fail with a synchronous
> exception at boot (reported by EDK2).
> While we solve this problem, report failure immediately so tests don't
> timeout in CI.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   tests/functional/test_aarch64_rme_sbsaref.py | 3 ++-
>   tests/functional/test_aarch64_rme_virt.py    | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


