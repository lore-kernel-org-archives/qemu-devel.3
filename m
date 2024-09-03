Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8CBCD343E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 15:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slVNr-0001EJ-W6; Tue, 03 Sep 2024 11:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVNq-0001C3-BO
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:23:54 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1slVNo-0003Pp-Jr
 for qemu-devel@nongnu.org; Tue, 03 Sep 2024 11:23:54 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-427fc97a88cso45185255e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2024 08:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725377031; x=1725981831; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iT5pBN8PxBTkq82fOMKVzoFYg8GWHcdkhNz9qrdMkRU=;
 b=PYRWDnKAvGIO1UTXORGp9OnMMStKHDtH+/48Gu0tiglh1KnjUczlv3v2A/AUB8dWIg
 US2NniAs1xA6MxLqmxU/ycWohyk9+/bfRfCg8wQyWrF05SYWvsTLqRwmk/R5Qwd7Y7T0
 SFZne4r0s5DkinSm8oyeCXDUnuYWT+O2y3fEnx4Efw0o78g6OOp3Wfde1WYTyuBxgKa6
 WtlTDW/SdhjX3oZyTzdHqA7ganzfyP8u/9q+rRLbiwHJhi3FE/yL2VJq6EZbKKLD4dOC
 DCm+Jz4WBTdDkHVn93NY0VMs2mtSvJEhlX6sl207rrQu9dHHf9DN7JA37yvPw8yOpRy3
 KTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725377031; x=1725981831;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iT5pBN8PxBTkq82fOMKVzoFYg8GWHcdkhNz9qrdMkRU=;
 b=V/7lEp4H5bzL2TLgQCCfk3mWBQU/RifLtaB4JWAWFqotGE6944i919IHAM47v0QW4s
 0YLWMiU6CzaK6g5SNeas0FLB2+IMoSLgCaP8KLT5qWE0ZBowJzXcQdG0TS5BfXeib9MX
 27aAWRR3Wft9qLVNgzcW4s6IstVi+sPAvoSKrj8xQKpMKGBnQRf0MiTmmQkkqc59ajsP
 +OI9mi6TgnGq59UGyF+KcpXtFAP0ShhlVG8SYXEXL+FidOPYMJQKQ61dcRYTmIGjfdpK
 +T3URfCMe8TxP1WYgNtyNwIgpLcAjVB7NFYb2PQqbHUOfhV+Pumf9rv0/5QlqEbtsL1+
 0u/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW0A5pHU9UOHUTqO+7eeVE0pt5RMct0C6E3XecGXvtfUMiiKXlOBTs+nHquYIX+pn12JqFPwffAjbm@nongnu.org
X-Gm-Message-State: AOJu0YxDOJ+U5slfrO2BtlFR2a8lUSIT28ZL7bf6NY4HQfK1INwYdJMf
 M1FXjMYXtm+t1fB0x2VgXTfId4dOcXL201+EhN1WH5Mi85xnTT0YsBTOTh1QVDI=
X-Google-Smtp-Source: AGHT+IEMsfaZ7ob0Ym1L9PXiOpsYdgs2mYgQj5vYY9SsyfvXMu4jQ2YQ72ytU39m2gw6MhwTIWhtdg==
X-Received: by 2002:a5d:5184:0:b0:374:b960:f847 with SMTP id
 ffacd0b85a97d-374c947189amr4199068f8f.41.1725377030793; 
 Tue, 03 Sep 2024 08:23:50 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e2737dsm174239655e9.29.2024.09.03.08.23.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2024 08:23:50 -0700 (PDT)
Message-ID: <c07957a1-fb5c-4973-aa7d-220ad06a0889@linaro.org>
Date: Tue, 3 Sep 2024 17:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] target/arm/tcg: refine cache descriptions with a
 wrapper
To: Alireza Sanaee <alireza.sanaee@huawei.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: linuxarm@huawei.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, shameerali.kolothum.thodi@huawei.com,
 Jonathan.Cameron@Huawei.com, alex.bennee@linaro.org, jiangkunkun@huawei.com
References: <20240903144550.280-1-alireza.sanaee@huawei.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903144550.280-1-alireza.sanaee@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 3/9/24 16:45, Alireza Sanaee wrote:
> This patch allows for easier manipulation of the cache description
> register, CCSIDR. Which is helpful for testing as well. Currently,
> numbers get hard-coded and might be prone to errors.
> 
> Therefore, this patch adds a wrapper for different types of CPUs
> available in tcg to decribe caches. One function `make_ccsidr` supports
> two cases by carrying a parameter as FORMAT that can be LEGACY and
> CCIDX which determines the specification of the register.
> 
> For CCSIDR register, 32 bit version follows specification [1].
> Conversely, 64 bit version follows specification [2].
> 
> [1] B4.1.19, ARM Architecture Reference Manual ARMv7-A and ARMv7-R
> edition, https://developer.arm.com/documentation/ddi0406
> [2] D23.2.29, ARM Architecture Reference Manual for A-profile Architecture,
> https://developer.arm.com/documentation/ddi0487/latest/
> 
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>   target/arm/cpu-features.h |  50 ++++++++++++++++++
>   target/arm/cpu64.c        |  19 ++++---
>   target/arm/tcg/cpu64.c    | 108 +++++++++++++++++++-------------------
>   3 files changed, 117 insertions(+), 60 deletions(-)

For minor / doc changes it helps reviewer to carry their tag ;)
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


