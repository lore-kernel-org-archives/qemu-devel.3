Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21F5D66BA2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 20:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVy31-0003MQ-6w; Wed, 17 Dec 2025 15:22:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy2w-0003Lh-PF
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:22:55 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vVy2v-0004hZ-68
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 15:22:54 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7e2762ad850so6545790b3a.3
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 12:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766002971; x=1766607771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vky/hzWYcaWnYXHxxTjTJXMCxcLIANxQfZ4tz9wT2mU=;
 b=OMLwfI/PZxkDGAb7pOJjCyMSRDeS45c4w/wLRYunXKXcdaIhZxCeFQMrWLxelYSqPN
 Ps/LHm7ATq/YfPnvCzUBAlHJc7G+OFCwGNCbeDdLQRaxVDnyA75ZKtG2DS3PdZM8RJCK
 30zcxjkcKjDnwTCvTYhe1+nuW6l/AQkZEVApCkOT+WB0fy/wxI5joiq/bpnttSjyKKCj
 pTG4t9927fGzyxC4xN0dZPSl7IRx82lzd02LCRMSbLo60QEMZlOGxHuDjHyLb4+baZT8
 US6Jtuk8GY3yPJEMDRwdqm7dZlkRfefQPNPqYROtlNJRcK9k8+OV3dCavG6ruKdZsClK
 aAmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766002971; x=1766607771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vky/hzWYcaWnYXHxxTjTJXMCxcLIANxQfZ4tz9wT2mU=;
 b=RkH6RIKDSvEkyN1vrkDqP2LK8pgr9J3Yu3OY+YZGwDSgIHgwCbRkbkPkSPueSIZdJZ
 QyK08y/5o/Lq7/6Lt9CmlrTwq3s/GYkO1CYYr5+I+UebiEs/gOFDIgKYGbvOWeKmMHl7
 /0E+s/4/Q0fskavdt/OPeNSGDKjEAqrU56e/Bz6RSyVWGaMis5AlAxJbSjGXXp9tNpco
 Ex9K4+ULGg0oCfyxwUd78GYWyC6teEiO8C8E10/0xyuWuZqUcHNc6FeGapBCdL5s6dym
 oQdK4Luam1FdPpJfaGarU/fjplwtfvnef/mtCQMSp4ZF5va3dQ7ZSgT5mmuVhXU8RLdX
 mtSg==
X-Gm-Message-State: AOJu0YzmOkdD5TmwNKKSZ8UCA3s2TM9TjaLys2NNE2t1gg+kQp8pftsr
 rytH39NJ48P2/jz0Al2HRpy7GPNF7cEoc94ChPgC/F6x4FgscP39VyEA/xqBPh/UIksKeS5yQf+
 9YpB8iOs=
X-Gm-Gg: AY/fxX4R/ebXVzjgXshgw2UD2ombhxa61QK6QMeSw3GJ5oglE9UMH/t0ijNzvRSiHiZ
 iyt46oG/v/cWb5LI8VPpMK66E/6P2DWm+0XwlP3C4eGVFLn9vEZU+X6CCC2QPJNTjrneUSGD3Bz
 HcyWtLwqW9OrSxz3Nis5EP2fEZXgG9CBih2WMAP8JcusY+jkMpW1NWG+uPOLfg5NebBfui9mvmr
 OzwRe3xZe+mAoioCRvRxTEDAJJxblQ4Iey41R27Ma9OXpPZQ9aDIeQ6CpFcbZ2YOEUSPNLLayv/
 jdBVAZwrFmlq1gNiZCRKQUBlF2vHiDrjHMXd/q/mopwtJkk1QdoXhAhL1vm9T9fuqjHpgTbSVwS
 VWZ/YViSHpkuo6IMQJ7U/OEYm92DYZ0LTICisBshUmmQbPO0wMkFiKI1HkWS9mwJZ2z9z56Dbav
 oFgtyoi0LMNWXZ0cUZxHl3Yf9udk2D7Q==
X-Google-Smtp-Source: AGHT+IH0eU2/3FBJnYJkS9J7BxxM57j4ko+i5sRVtISoOA0jC0TOHLLicerVXMf/n4Bgzngb7fMO7w==
X-Received: by 2002:a05:6a20:958f:b0:35f:c643:105e with SMTP id
 adf61e73a8af0-369ae77784cmr18195900637.34.1766002971400; 
 Wed, 17 Dec 2025 12:22:51 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.245])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7fe11762132sm321053b3a.14.2025.12.17.12.22.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 12:22:50 -0800 (PST)
Message-ID: <2944477e-413f-4d7e-9c6e-e83bdd5a7baf@linaro.org>
Date: Thu, 18 Dec 2025 07:22:46 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/14] system/memory: Define address_space_ldst[Q] endian
 variants via template
To: qemu-devel@nongnu.org
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251217143150.94463-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 12/18/25 01:31, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/exec/memory_ldst.h.inc               | 17 ++------
>   include/exec/memory_ldst_phys.h.inc          | 36 -----------------
>   include/system/memory_ldst_endian.h.inc      |  4 ++
>   include/system/memory_ldst_phys_endian.h.inc | 10 +++++
>   system/memory_ldst.c.inc                     | 42 --------------------
>   system/memory_ldst_endian.c.inc              | 14 +++++++
>   6 files changed, 31 insertions(+), 92 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

