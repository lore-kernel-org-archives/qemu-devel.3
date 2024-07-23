Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39870C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 23:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWOvg-0006CL-2M; Tue, 23 Jul 2024 19:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOvd-0006Bl-Q3
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:28:21 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWOvc-0007Gt-9l
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 19:28:21 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70d19c525b5so2077856b3a.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 16:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721777298; x=1722382098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lTsGOF6/1RIFxHctUvcrMWWp+gPobBdnA85lEzkM4ns=;
 b=rx7RSTmO6j5D5P6ditWUK6fReU/Hdes72LI9Nygiz0TFP+cODHivioAVkTUEUQcZ83
 Eby3sPoOmjXdorZcMlPJSfnWTYO4nX7A/LBLaTqA4Ela7gvspgNmFf8vFFM2N87EP3xy
 Yq4aSHXWbOdKJeqOVStSfmakmVGEy1xBNc/1SoTqVZatJqE0d3GB+y5ZPiUGKOuGMcE6
 kyDQh7/a2M03IR77JQ2lxE+xUMFq0uyb/r96l0JCuln0IgkT7DWpIaXgM3adieRgMtik
 HqjyS1Ub26nS7fIhhRtYAQTLCAmmQ1bBLXZSVEZ6c144bGPBuV+BFC7HH8ke9KKEhEbt
 PXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721777298; x=1722382098;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lTsGOF6/1RIFxHctUvcrMWWp+gPobBdnA85lEzkM4ns=;
 b=ihTP9OXNh/Z9aVSBIhVjNQHgT7NDcg3D8n94DBvabmMEdnECVfSDeOZVOufQi1Vuqq
 /2anFUvincPnm2gCNjoAIY6np7gMMGlj2fO/S9cTR8AvjwRxE3i0FEP6M4C7jBCYOpf6
 vkV/cbs/mJipM8926CbwqkyUW2rfHXXVaDcdzC67tRwM7mYZWl00WzOgTdt9fpwTl4NS
 gtIHnfvUPAd8XlOUGfjE2Oju6ftZsp9NOKdew2CxP2LW85isvIZ8MlhxdaQTyoS1pIAk
 VWIxkTXn/HsP7x+xhkaw7bDvKrn/8NIjorw1r46rT3uzilYnS7NE2RZG2Wrdt+HpGrGJ
 14OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeVylAVB0Z+/90Phv81IXUxc3ndZSrvwGlrK5YlM9kMCJxQC2XuG7/qll8u+zwqbvhcMOx0zvTcli1rxvzEcBN30d3Hzs=
X-Gm-Message-State: AOJu0YzvM+0BqhWkzt1X3e1jej9ZXfNFnGyaofVkMkHfcIhtx/AEI9yq
 7AMtekwZQozTRuqva5wGlCtK0n9U3JAVwgyW2Rd0JnT+Q7vH+0l/w+GqZ+QHFIDqgXnTJQfgHgM
 CcdnF/A==
X-Google-Smtp-Source: AGHT+IHvvx4lFm5/yS8feRXkKpk2J0yqjAP7gvialn+0eQnZP9f+F5N9epGVg96YCjeGFFJRYNhSGQ==
X-Received: by 2002:a05:6a00:244f:b0:70d:3354:a194 with SMTP id
 d2e1a72fcca58-70e996739f5mr1399477b3a.2.1721777298358; 
 Tue, 23 Jul 2024 16:28:18 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70d191ff0f3sm5213911b3a.11.2024.07.23.16.28.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Jul 2024 16:28:17 -0700 (PDT)
Message-ID: <31514acf-13b6-4af5-903b-eba410d2de67@linaro.org>
Date: Wed, 24 Jul 2024 09:28:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/tricore: Use unsigned types for bitops in
 helper_eq_b()
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20240723151042.1396610-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240723151042.1396610-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

On 7/24/24 01:10, Peter Maydell wrote:
> Coverity points out that in helper_eq_b() we have an int32_t 'msk'
> and we end up shifting into its sign bit. This is OK for QEMU because
> we use -fwrapv to give this well defined semantics, but when you look
> at what this function is doing it's doing bit operations, so we
> should be using an unsigned variable anyway. This also matches the
> return type of the function.
> 
> Make 'ret' and 'msk' uint32_t.
> 
> Resolves: Coverity CID 1547758
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/tricore/op_helper.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

