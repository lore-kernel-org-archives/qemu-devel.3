Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3DAC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWxbu-00006C-F0; Wed, 02 Jul 2025 09:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWxba-0008R2-NR
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:34:32 -0400
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWxbW-0001ng-RE
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 09:34:29 -0400
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-2ea34731c5dso2687250fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 06:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751463262; x=1752068062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=170406iYqLKyQnT54NoiQhocvfVa4R5G1KtXLrLTqtg=;
 b=Ue98W5iNLQ1veTvQa9usRaqQiDNYesr7jL0X3BlxbOQXi/maFBul3RShi5bcOUinDq
 BNSgGhtAnZtwLMCY/t+aRjQKSpY9u+fIMcBELSa6tT5KhRnhOX8qz5qeDn4g/CyT8Yfr
 Pzk/Y2tcLBnN1WRHCsDfhzlsocet/WrBus07xFWplH8TGCkJGiYvWfTk49pbJOO0Osfp
 rjmdawCXES2QF3MNVqlDK+7BP8ouY3rkzRBDOkVCKmMgQSIq/5RYq6VBDfy7gEcXWewa
 Q0PXqjIh1Lr/BdSpOGWwgTFpsylv9C73Qs/U4ptdn5t+QbPjW79L6jVx8a2CHx5A3k2C
 7uBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751463262; x=1752068062;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=170406iYqLKyQnT54NoiQhocvfVa4R5G1KtXLrLTqtg=;
 b=EctCqHH42G3OX1/dCRlOGgUn+aWo5pdNZgePCVW2af451tIDJOe8MBCKWjjWy/PHJS
 JRvJjN4q6rhXhcunUi4/BCxmi5sK/TObk/sy2AZII7+yUwTQ59GlXJKm1Jdtm5mEeg1M
 kbigkH1PMcJAFKmnTSYDR4LGiMiCDFqRP+or5UARB0hZip+lC1Juxyy4gmkQw0U2jUHK
 xMJWg8NYYDW26EpGR+lgjyyj2gGs/3nCQ1L0K2qs8VNYFO+X1o7OwTOyPcDPTfkT6JHB
 jqVAcLkJCT/OBMhRWOmyDnUoJcM7utSqL7nxKPosetGSEQJuPYtYWYV8owySphcmFM69
 E2Yg==
X-Gm-Message-State: AOJu0YwKl/lFhfJHU94vB8Za6rYI3sXHluiRF7mjwVUE9prC1xne95vj
 qYc4+mtTSz4HzXFhAwd2CPauU1BjiJTH7F5MggJeM414ncxO3qgR+UETuvL9ZxX0To5jtbYn47J
 akE+veA8=
X-Gm-Gg: ASbGncsVLTny2g0HFxK79sBLx8NEMGvvpSFRjW4LENwEq2QZ4kP3EAFs+x89oWv5Oxn
 tk0S3HdZ1mksL64IKVS8+homkkvBbHUE7egPzWl7IPlGhgeVdNCU+Ef15vfRTvhKKWwNCRi1wgC
 LVOo0OFjLI73u3kSN49xRM2Xnsl8IEPjsqVmm6+JNWmqCNDugfnnJWEU2qvep0sLeno49rBVhr/
 zEjoXKeJToi+W8BKx23NTcacMPTnfnE/hEvPobn+90q78VJX1Ci+1ce7CWRgy7NViR8ttcnHnVK
 OSBfzq4L/Yx4Qrp4U910zn7yXnGaFA0Kbb9F7f+0vlZ6eb7zEJE5oy1frZ6gfDdw602ypiH42cA
 S
X-Google-Smtp-Source: AGHT+IH8acC8VFQDD+td3LbFAGLTUQYLlk+aAfK/8zZBdoFVM93aUGV0fvxz9Eon4DqryYdUW2evnA==
X-Received: by 2002:a05:6871:54d:b0:29e:74a0:e03f with SMTP id
 586e51a60fabf-2f5b98ccfc8mr2140900fac.24.1751463261675; 
 Wed, 02 Jul 2025 06:34:21 -0700 (PDT)
Received: from [10.25.7.74] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3885402fac.32.2025.07.02.06.34.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jul 2025 06:34:21 -0700 (PDT)
Message-ID: <7ac9e272-c0b2-49be-aae1-720ce4dc313a@linaro.org>
Date: Wed, 2 Jul 2025 07:34:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 60/97] target/arm: Introduce pred_count_test
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-61-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250702123410.761208-61-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x29.google.com
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

On 7/2/25 06:33, Richard Henderson wrote:
> For WHILE, we have the count of enabled predicates, so we don't
> need to search to compute the PredTest result.  Reuse the logic
> that will shortly be required for counted predicates.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/sve_helper.c | 47 ++++++++++++++++++++++---------------
>   1 file changed, 28 insertions(+), 19 deletions(-)

Hmm.

> @@ -4134,16 +4149,15 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
>       intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
>       uint64_t esz_mask = pred_esz_masks[esz];
>       ARMPredicateReg *d = vd;
> -    intptr_t i, invcount, oprbits;
> +    intptr_t i, invcount, oprbits = oprsz * 8;
>       uint64_t bits;
>   
> -    if (count == 0) {
> -        return do_zero(d, oprsz);
> -    }

It's possible this breaks sve_whileg until it's fixed by patch 63.


r~

