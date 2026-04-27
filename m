Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7316FF8860
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHOnT-00084y-5g; Mon, 27 Apr 2026 12:26:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOnR-00084R-92
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:26:57 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wHOnP-0005Ar-QM
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 12:26:57 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so531204f8f.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 09:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777307214; x=1777912014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SrUC5pF46du65L633e0/mk/areAKrXU8mPp51KgUHtg=;
 b=TNNR14hbWZHwDf2PGK8BBj84f14gNteq/doXyWM0r6vlfKKTAIldV6H02xhf9rdNId
 bWzPC1wA/XD2yBrVRocAPKbDIHrPTZ6IUstO10X37CiBcKLSylZse0pgmbROKxuNrWxP
 G6bK4UvVYCFNOnsry+GQpvvngmCzTtuvS4uM/Euegcq/ENNwlcZdRZVcHyIyXngYDRIh
 n0G64mabIxson9Y3Khvrz96/+NWxEhbiaZ4MwPzCDZk+cGvWF6cPVWGBxRK6WapY5MKP
 VN8ZkaUclArp/CkPTHYhmXpZ8JZ7ZLl4CFqn+VuberztCW0WvqMNDiuo7poSyi4D+e1s
 rOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777307214; x=1777912014;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SrUC5pF46du65L633e0/mk/areAKrXU8mPp51KgUHtg=;
 b=MJoNm8RlQsLE3BRVk7r/7jWnNmJzRY1BDhda3rdrKp5NV4Mhh8e7M/QkPOI4vDUJ+g
 CeS1VNkUjAP3Y8hQKWDdMgmSWJLZ9WNgs3ztX4BHxU1RB9Sz0GADY1AblTUWELWq0TVI
 69zDYF4aRJYRv0LkETEBkTj/SI3BW7vNYLQr7iUjhVMdbOeSGyYbWzAdsi1nqnPfnUBu
 tXZJh2JMgO+8SBYj7OZf/kBsF0SALGjGa8sYQk1k6gdLZFUbisyn+ZYJLaukVXKHc2K6
 Em5BCVUtP1oH4qfbMWvt14n/Nt5H7FCyBvcvXVh/JsnR+7Jz+RLMfRoQAZwBaI1Toyrz
 AAMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/wEJNk7+hkSYPWn5FRDq/FP0oznPgUUow6GPQ8g20dOQ+j+lZ3SR04Tq0hnhSfYR2CErDGX7GlG92Q@nongnu.org
X-Gm-Message-State: AOJu0YwedRM4xV2Q2ogB48+s1UPTVr43YDr2ZbHPdKHFtVEnoITb0WHx
 i3XoaG5hYwdWredHHOhECZljHr4/WD3S4Q5KmH3Ke2rUigaPBKJMWbNaFfHl+AoidGY=
X-Gm-Gg: AeBDiet+NlEp3Pc/TE85dRuKp2JTn2DO1xgwXcBTOThek8AV4mLSxPvt5ffadustWwM
 AZm2Mx2Y5EwjelghZXyxjgZM42DqriJxU3k2pi9qCh1F/Kqh///4XMk1h5j1Y8LXVssahuC3b5L
 9U1486KAnh3lpsZWyxVdp0kCRQLwEXWI8u6TZcG4loCwgzBvJJ4sVyudFT++jds/SW6UVf8U8Fn
 fREZ1OrlAH3mKv6xCsAkvdEI0A+mH6TqYdJ7UJgsxRtKiliZgpP6oYR2ZW9mIMuwo/I0+f7HAeM
 72vapxNTTget0yT2YKCJ+sUBJi84hUDJYPdz9ncASPXZi6H9zPEZZb+OJ88MKK0NOqVGIkHcHFV
 1E+TYXEA7Bc/plEyeGqaFyhVWnMl5e5RCl2F4qFKXCG25/OJcUCe8ZdDH4KW6FvDb6c0ddfYZoi
 0otU43QqjWGTV8OfabUSJumEVkKTIvzhxE5/c/I9JyE+8gcgrdDOiJSA/DmdMWG8utiIkxp8oNq
 85j8OevlCBGk+k=
X-Received: by 2002:a5d:5d88:0:b0:43d:7d6f:f535 with SMTP id
 ffacd0b85a97d-43fe3e10c0dmr65402395f8f.35.1777307213731; 
 Mon, 27 Apr 2026 09:26:53 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4cb135asm87419375f8f.6.2026.04.27.09.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 09:26:52 -0700 (PDT)
Message-ID: <8f199d13-f81a-4048-aee7-975090b441e6@linaro.org>
Date: Mon, 27 Apr 2026 18:26:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/84] fpu: Drop parts_uncanon_normal
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20260426134002.865628-1-richard.henderson@linaro.org>
 <20260426134002.865628-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260426134002.865628-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 26/4/26 15:38, Richard Henderson wrote:
> Use partsN(uncanon_normal) and the single call site.

s/and/at/ or /in/?

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   fpu/softfloat.c           | 8 --------
>   fpu/softfloat-parts.c.inc | 2 +-
>   2 files changed, 1 insertion(+), 9 deletions(-)

