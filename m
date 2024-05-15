Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13073C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 12:57:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EBn-0005Nk-1a; Wed, 15 May 2024 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EBk-0005J9-JG
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:56:56 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EBi-0001Ul-OS
 for qemu-devel@nongnu.org; Wed, 15 May 2024 08:56:56 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4200ee78e56so29843055e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715777813; x=1716382613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1/cvUIvZY9BMG+6Q1tbPIhSKbYRpHeyciPYp/VC5e1o=;
 b=OXYVd1Vpw2diOUtRXaX1zzU7IcsEoC0fsCWiqvPnwHY4eQ0n2Nqa1ju/xP8Cy/dWwR
 bdLFud4lbo0YYFugK5Nz7rCL/L1tNGHJ5ZLAEMV94yK8dpuMDrh0fnr9skSE+XD9oCxH
 QtI2IrXMU3NIvMbTbWG2EKsprPIk7UGbw0tZYl9OmqgLrPLzAjXJQbAW2q6Js5HXVMQF
 Gh6W2HSUECxuvSEIvh8lpZ0bLCYQkJm5ifj6L8n/jVWUUHX60g8U3NZ8UoqUaU3m6kfi
 BjN8Z3jI8PJ5CE+4d1ffuReNMONvMjmW0Rc+UJgCH5k1CoPzLvtxT/otLVK+zStyoZx7
 KuXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715777813; x=1716382613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1/cvUIvZY9BMG+6Q1tbPIhSKbYRpHeyciPYp/VC5e1o=;
 b=cIT9ECKsePdmn3m0gVzOTaujsk0WzjU0zEuCKLtxWTKbqMsT4tAYDIScFqLPXHVGMV
 0/PM6FVvocsSnC9ytk798IOzcDy8eisw0f94C94NjmY4RtkwyH63vAnRBqTEcbVKQ6dS
 mGifMxYRFaKVXyChSxGzU1tS3zRYWHNSlVGv5LkT1GZmadj9bSU50HWc55waH29FLdfC
 xqBuN5Dz/OTxkptAEJnRO6M9y9xbNmtSfQlOeJn8sJQU1sVgtj18UQS548uINz8iUhRs
 MkkbAswsdfhwgkrbM397wop5rIdzx2BxQkmWfUKFYLKFxv7TN1y0x/QTltdgq9BbLzB1
 07xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXinypxBT526S4YOyMCWgWL9aXzamHj6kyhCuNs94VF1P2WSNrShQeyE3ZFjKSIy6g3xgAKYtmV80YINJbObLD7gMFlWmw=
X-Gm-Message-State: AOJu0Ywre3DUqFD/NaRQKiD2uiuEao3l4rz2/RbcK2Q8sd7nVfb+2HOu
 lbLTBrnNH1iYs0j80BnSFarmtt/qhANiUxCLC7tAst6+8VUojwMSwnugOBOdGp0=
X-Google-Smtp-Source: AGHT+IGLE2ZtmSw/FYS4ZpA0tHg+1K1djiYjBblGPfluxtFsaSDiy4XlG0KwjlnUwYZDZn6Jc7oyBw==
X-Received: by 2002:a05:600c:4712:b0:418:e04b:ee63 with SMTP id
 5b1f17b1804b1-41fead6acd5mr126031615e9.36.1715777813362; 
 Wed, 15 May 2024 05:56:53 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fe004eae9sm217432055e9.1.2024.05.15.05.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 05:56:52 -0700 (PDT)
Message-ID: <08c94103-e9ec-4bec-aae5-46118de5e4ed@linaro.org>
Date: Wed, 15 May 2024 14:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/17] aarch64: Use bool for sve_{z,p}reg_is_eq
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-15-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> The functions results are more naturally boolean.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   risu_reginfo_aarch64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


