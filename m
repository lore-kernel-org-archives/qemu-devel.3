Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3072EC77B7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 22:39:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUCHR-0004dg-IQ; Tue, 24 Jun 2025 18:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCHP-0004dH-MO
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:38:15 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uUCHO-0005sB-6X
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 18:38:15 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2366e5e4dbaso3531965ad.1
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750804692; x=1751409492; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8mW7NLiMtRYcX0zQJNUOMwzpTlmVuc0fZs5xMOdQlEc=;
 b=MXHxYqChLWrES5CFyH4Rhu5g2eC1xVhhyO0kiRKf5j6HObCxydC5zyLOT0GAYFI3Ke
 0rM8eRoS9jUc8YS5bBxPjnQfIPq00ph357+BHMC6pXt2h85JeOw03OqwJfC1tfwvpRG0
 f5MUV3g3er4LMNmFMIogBT3LKhSt/eFwCvGMu2hAaLijps6h+/5fKJ/APan4/wrQ5EIu
 PUyAjihyZVw/7Cvn91gEH5TJEVZ+YmDgvqqjwaPY9LFJSIPjiu/VQHOGFQ9ZWmAE6rDq
 5aGCyLqMDO01EtqSiAWUE1NaL4Vj2lsdh/SlhSosCbPnSowCFNcLSfOIhX51mI2RRdnI
 j0ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750804692; x=1751409492;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8mW7NLiMtRYcX0zQJNUOMwzpTlmVuc0fZs5xMOdQlEc=;
 b=NWtZ/NUaoRqlV5jpojjPqHEBgHzZRxecRbE8oYjr6dpbZ+nd20c7DwgBmvy7NMDfae
 EyoG0CiY5fvRB18ryS1Gr84LUVt98yKEADfeyAW9mSjz4HpLZVCB79loKUlXpWTyj7Uc
 Ge6w4D4U0nU3n8dlTtqi+xIO9c0k4TfqZ4tYlr0Jj/hJgo/mPjNtvrTDWKoFwue3xWGi
 WN622vr9dfTSlpsCkgwj0E/iA3udUCQcHyj/Gu2d+fuCwqLe28Q+BEBQ98thx1eHcz48
 g/6gVit/atLwMihiHNm3/kO9jfLlMQluMv1iBDVk1OgCzaxFsbV0ADUA8ruAtoNHnENw
 2ldQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSzURPpdRj/LYqCjUhseCr0I6ETOS8tBsTQlynXqxf4VHHVFvZCG+HFTeLUPpI7AjRIsxY5cYeYpEv@nongnu.org
X-Gm-Message-State: AOJu0YyscIKGzjk+aARu7WjlYsuucMdqF5SahMuSXqHbtvgpg+5fekSg
 CZ32l2kynPaHtt6SIdZoQFy3/TjuFpmMrOASAg1ZFi8rjMfDNaaIKXFNrIXJJMX//Nc=
X-Gm-Gg: ASbGncuV3ibubteIeUq+IbIZFqrjy1V+qEezmaZr+ZrYtk9a+dSQcpwzYiQbsMHF3AR
 rixrM+GBeapbeVRaZrygIpXC9edTSa4lUVcqYYemRUGGhwpnbT4iV52nLjcH/AD4W5S1l4S7lPs
 XcEnfC735HgG0U3J52/xGdx3/rc1yp2fg9uxNgi7Jc9z25Qccs9yMN7aFuf8JShXSKJv091CnWy
 HQcPyh2fVC3Z6uygddMVjMeOex+8IwnJ210qwb0kJxXrJQGmTMouPO1uGMjl1k6pnuOojCu7fsQ
 4c97ne8XT/pLw2UK+MC+m0QL9A5oN2yJ0y3X373Xy34A6FugoquyeNgtbtaeJfgI/c6d/a98M3I
 =
X-Google-Smtp-Source: AGHT+IEQsCjpcSeMc6Seagw51rdXmwnwPSZUWjIIsP1XkuGFsCXug+j1AFaLEwSchXaiuUidvXm2jA==
X-Received: by 2002:a17:902:ce8f:b0:231:ad5a:fe9c with SMTP id
 d9443c01a7336-2382535bf6emr9860585ad.15.1750804692143; 
 Tue, 24 Jun 2025 15:38:12 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237f7579cddsm59825745ad.202.2025.06.24.15.38.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 15:38:11 -0700 (PDT)
Message-ID: <744419e2-2425-4d1e-824c-a766a7a209cd@linaro.org>
Date: Tue, 24 Jun 2025 15:38:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] tcg/optimize: Add one's mask to TempOptInfo
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
 <20250505202751.3510517-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250505202751.3510517-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 5/5/25 1:27 PM, Richard Henderson wrote:
> Add o_mask mirroring z_mask, but for 1's instead of 0's.
> Drop is_const and val fields, which now logically overlap.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 51 ++++++++++++++++++++++++++++++++++++--------------
>   1 file changed, 37 insertions(+), 14 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


