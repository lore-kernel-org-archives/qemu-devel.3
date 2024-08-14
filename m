Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8607EC52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:46:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seAa8-0002Zb-Pa; Wed, 14 Aug 2024 05:46:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seAa2-0002XX-T0
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:46:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seAa0-0006xX-Gt
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:46:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1fc566ac769so57580945ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723628767; x=1724233567; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6X71+HsB1YQYJJfxtHfZ1hgIKdng1QWhnmiWbAm7q+Q=;
 b=gUEXz4TAyhVtYF3PuFpf1sHIkwButnXH4Go9Vpn1AvPs0Wu4v4uKji8PmGicySc6TT
 CgxH0tTJiMW0uEQ5w3owhlUrX3YVmsQVEdQ39hRzj3IczTs4VGJmLJHhgFxjLMsrDx6d
 ZojkwHO9ZmHXUNIU2Nmfbj6JfhqceEWNpD2bX08E3ojtOkzlFHo2ePBIhyWzucvHeJ8a
 w9iltBt4AUiYXogWayI9c4PQq5bVNY6TaFcXEbDGbWjGjM7K2RZRZKAmF8mPZzuR25Sd
 q9+u6ryypQ7Yw4uYdj0A1iMfu3P9Tm7JqlReDJkBNed6bzcxbTTrKX7ANVeiHmIhE01M
 UDQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723628767; x=1724233567;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6X71+HsB1YQYJJfxtHfZ1hgIKdng1QWhnmiWbAm7q+Q=;
 b=o4NPHSgIOV0iFmVAi5P69tY7S10TOLxl10uE6iMMyDVCSoiomXU+VQQm6L2hia1mg1
 HDKvJZerGZ8L1jPhbxnabVk37MRRf31cWQSa48gwH7DZjDo1/zc8MTjugY+mQ8U7ZuIT
 6cQden8X0FRaZciIY9yus2ULdoAkghcUETifWZxzvTnP9qZgKmYLBwWvgt4iIdJNOQRU
 T37tTbcLbzKJ4GEe3AYwu15U/V0s1pUn/2CKu5BnNuI6PdNFuyVLQxeuexV/T0FRzwQ9
 pbK0dvzOFpuOTGr1M+S+pslJB7NO8/JuOTUjA9Sz9iZswnGC5H1MipMjlTUbddffOhQ9
 oZ3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLgeCKlk9AbUKW+2RR550UMn+QjLK3kfctM/zeUyk9uNixxXMqjGau1C9E7d/LCMr99JDbMGD4OhQq+8UEkBFJFg3wilM=
X-Gm-Message-State: AOJu0Yz0lwBBtEnpCyzuKW6mHCNnP5KTmjxxQitqJRloRtP9wEi8fOV+
 lSMHAbpxwcZeBuSL7y1YplE582ndrbuupKKER9pPQyJ59JPRN4c/7i9fgfCIszg=
X-Google-Smtp-Source: AGHT+IFY0utoZb7s4FcgNaNjz9qUUGXKi4jC6WDCb5K708vKLj14StiIJ+9DSA+G7o6qeqSRe3iA8Q==
X-Received: by 2002:a17:902:cf07:b0:1fc:3600:5cd7 with SMTP id
 d9443c01a7336-201d63bc101mr27351385ad.10.1723628766483; 
 Wed, 14 Aug 2024 02:46:06 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-201cd1a912csm26251675ad.148.2024.08.14.02.46.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:46:06 -0700 (PDT)
Message-ID: <2c3fe80e-fe1c-49a3-aa4a-03749801e4ee@linaro.org>
Date: Wed, 14 Aug 2024 19:45:59 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/15] tcg/riscv: Implement vector not/neg ops
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-11-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-11-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> @@ -2312,6 +2314,12 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>       case INDEX_op_xor_vec:
>           tcg_out_opc_vv(s, OPC_VXOR_VV, a0, a1, a2, true);
>           break;
> +    case INDEX_op_not_vec:
> +        tcg_out_opc_vi(s, OPC_VXOR_VI, a0, a1, -1, true);
> +        break;
> +    case INDEX_op_neg_vec:
> +        tcg_out_opc_vx(s, OPC_VRSUB_VX, a0, a1, TCG_REG_ZERO, true);
> +        break;

Any reason not to use vrsub.vi?  Not wrong, just surprising.

Obviously, NOT does not require SEW change.

r~

