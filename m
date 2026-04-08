Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D58B10F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYPO-0001c4-HD; Wed, 08 Apr 2026 15:17:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAYJz-0001Fi-3U
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:12:15 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wAOMJ-0000zg-W9
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 04:34:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4684155f8f.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 01:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775637238; x=1776242038; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qo0yJ/uHy+c9FuGjyCkpI7+ZkEIiwzv2artNMVu2TQ0=;
 b=ejEQUzztQGkjrPUVtUc0h3DwO+37jlElL22ZofQCKM9zeW5EJc/RqgAxAnURBgzFtR
 JAtlu8fHzvK1qGia+mX+PoPneUbl9iz1OMN9KtKkejT3bAejEWZV4xaVOsGyqhBu6uUq
 Yfj9jI/wr4i3Ux7Aql1fKkBy5pDpWRRxzYPwwMS57OCdbcRh1qtDCpjz8mB2g61SyMA3
 Is5yJ1VBvDO7ItrubRPy61uymEBvkFhgX4izndSTL61tVkMVLZtcZXfoUtyQlI+P/x3y
 Ktd6aPoHAWV2FgGiq4H14ZfMjhLoCk5aE7SL0c7G9ZQPFA1+7HPQhMneOtBWhHoSp1XR
 WbtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775637238; x=1776242038;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qo0yJ/uHy+c9FuGjyCkpI7+ZkEIiwzv2artNMVu2TQ0=;
 b=VUC/DnbOyCu08jYGFPG7l+Rr+9eI7GrF2k4KZDoT95oVAk8lFUoNMCiCbw6QdGRz66
 UO4U2WlJEVGitsLl7dnE7eNulAW12MU+QZMNhJ29C5B8yoFwtiw4+zTvxf/vizEd/8z/
 RR+iGJLHe8wrZcCXfsJ1pp9DKL0mUgT+2JtO73Pg76OKVPUEwEmN4WBhFICOkRUSke1o
 44V1RonRNkByzpyv0YNjs3y9JhEj+qVp9RZeBl20uTSN3PyH2lkW5X6sfpSLlq4wihta
 aMCFhNJA4YfF2UuQ/577SgiTCbOFaghxGvDxRf5lgaHfMn4iELKnn8gTG+j1PYpnjRtQ
 Ul9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAm7biFz/oYQ6tbQ3BKwSU42IIXqs0wp5Mg75NLmrWLGNT/H2HVXaOGGr2ShV3yJ0vKEwtia2ii/lT@nongnu.org
X-Gm-Message-State: AOJu0YztqafPrTT0PxQHYNmatcX7zGkONHfQFFY7rQxOuleqTOzvorwi
 2TxJhXNQjx1tpKe3CYNGqAKzly2eZR92j2mkhALqqyM1r5I/P6t1cy0s4X2zHu7wbU4=
X-Gm-Gg: AeBDietSQjVrPevG94guGo1BlNQGHTxDluovpUp8T8X7cWWgkqvAHuJhDczqjF+yPtC
 CdMlvrB1WsAEjUWs42whWS3ty3Fc6wwzdT3CeYJStmEl3dbbTa+RTIm0+iH7IttkZxv8cTeRxQG
 XeQ7Am+7FCgwIH9D2ARrbz9GynP2oTRlnZloVK6OX0AgxRDAP40QYJPG4s2jH6fEp50R7W1SCya
 N+klIARBFXspLtdlsSjs4THUhLnMwfc+VOsJcfTge2jCvIWe7wRNKD47gPTOc6nZhPSt31JfvuM
 UDanf7qIEtRV1i3dY/rCNmdhs2r+wQwY7ssAhNwhBnavirYSXZwdHiWYWZwMqgL65QMc/cHdoFJ
 X31shVsw49l0fiN1Dtr38rIaUNFZ2vxVKZyQjmwLa4MPlQnjeYqpa+NX0LZfESXc2mCJmzU5yCz
 aDnv3tMWmQp+1cRzRBZzKX1esI7OpumDTeQhI=
X-Received: by 2002:a05:6000:184b:b0:439:cb9f:d635 with SMTP id
 ffacd0b85a97d-43d2930fa4fmr29981299f8f.46.1775637238388; 
 Wed, 08 Apr 2026 01:33:58 -0700 (PDT)
Received: from [192.168.69.228] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f7d4esm49664700f8f.34.2026.04.08.01.33.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Apr 2026 01:33:57 -0700 (PDT)
Message-ID: <94f181f5-46d9-4a13-9af4-d18e614baf59@linaro.org>
Date: Wed, 8 Apr 2026 10:33:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 18/21] target/arm/tcg/translate.c: replace
 translator_ldl_swap with translator_ldl_end
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: jim.macarthur@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
 <20260407222208.271838-19-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260407222208.271838-19-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 8/4/26 00:22, Pierrick Bouvier wrote:
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate.c | 13 +++++--------
>   1 file changed, 5 insertions(+), 8 deletions(-)

As per v10:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


