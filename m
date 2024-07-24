Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C2C3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 00:24:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWPn6-0001qf-Gh; Tue, 23 Jul 2024 20:23:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWPmt-0001oW-RS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 20:23:24 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWPmo-0005Mn-KS
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 20:23:23 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fd640a6454so10451405ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 17:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721780596; x=1722385396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=blvuQL54whCUo+89n4bLUrBb6acssraDWlXzgrBRk/M=;
 b=kQZkdpaEMaaqFzhGT03dUvjMAeYe1AeV7RWAB8qNpFAqfimbwMVW52+icbxjUJ65Xi
 /okuxlt/Zfsnsq8tHPu2h2SRGTydCLIYnfdpLidJvWRkcrizwSuxxrHyPvwyjRBwfCbS
 1dm6udWIBbEBSK36k10MxJIas/YXYoHa+OH9oPGTP2w6namsRsqh6EMo5tnLDuipfr3M
 6bqp2X6HVfsP/3vWzjxJ04vB0+1P2g/XFV37eQn67xQ1ZS6fOt+/abm1jxFYrJjIguaV
 qYaaN+8UNrzBl9WtP6sYASf26wHoFBYc7Vk7vN/TnOGys0ToOCsMKtZPVMYsArie3GjD
 pAxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721780596; x=1722385396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=blvuQL54whCUo+89n4bLUrBb6acssraDWlXzgrBRk/M=;
 b=OxM7BKRLWHSKz4akpolEArUy7OtpqSofPIaUy2CXGDXhbDGfs4sWLE7/dG36+C3R5K
 zOtnKopbUGoBnuxp4NF9ZpIOPkNIy981iAD9EcgirSFIYh5aC3tcxr5nMODc3TbT/ck6
 CNSQKhvHPIg030PG90lHe6qwxashrHQ6ofXmjP9KVXCkc+R9prwXBixF6cHLWCRwbrzm
 Goj7soUg+6TJ4NhOwAcOiQfAWhEyt2cj7XMN4Pqx/D7MxDAzeRwHE1aULKa3ahJjkFth
 AprSSLTlUwSXLzwk7gtPCpY4H3cftbXSd6vaKRK4sKHJVLxoD2DA6WGltOzVKUgF7mbW
 0mDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq4QbvcvHzYaReUNTdZoIHMy0irdC74SY1cD/NI2lJzKVq7g845z1JLtWNxTK1doGAhIQGc/oeidmT9g49+R1wSZcAAWI=
X-Gm-Message-State: AOJu0YyuTDizhdeSimovdn3tjmYWwOhW9lNSnq/DJ/BdieMxzb/uRoiQ
 PNO4TqqeJqaGMe2V0vTibtkpC5dCyybVznpYu2ReVT7gYHjI4IQLrBueVpHp4iT1SMCgrIpxvnL
 DPbLG5g==
X-Google-Smtp-Source: AGHT+IG42r/X5SGWVqVth15QZVmhMWFMvBcMAsUZ2W63ny+clBvcP7XnC6Q+pOr9/8PkcU+sD6+n3g==
X-Received: by 2002:a17:902:d2d0:b0:1fc:2b3b:5cbe with SMTP id
 d9443c01a7336-1fdd54f487amr6305165ad.9.1721780595906; 
 Tue, 23 Jul 2024 17:23:15 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fd6f318462sm81290365ad.140.2024.07.23.17.23.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 17:23:15 -0700 (PDT)
Message-ID: <ba5d34d9-5887-4572-acd0-8d7f87182dbd@linaro.org>
Date: Wed, 24 Jul 2024 10:23:10 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/sh4: Avoid shift into sign bit in update_itlb_use()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20240723172431.1757296-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723172431.1757296-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/24/24 03:24, Peter Maydell wrote:
> In update_itlb_use() the variables or_mask and and_mask are uint8_t,
> which means that in expressions like "and_mask << 24" the usual C
> arithmetic conversions will result in the shift being done as a
> signed int type, and so we will shift into the sign bit. For QEMU
> this isn't undefined behaviour because we use -fwrapv; but we can
> avoid it anyway by using uint32_t types for or_mask and and_mask.
> 
> Resolves: Coverity CID 1547628
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/sh4/helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

