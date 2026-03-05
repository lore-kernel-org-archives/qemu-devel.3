Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE16F3D31C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 16:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyBNs-000161-SI; Thu, 05 Mar 2026 11:17:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBNb-0000yJ-LT
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:16:54 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyBNY-0004oF-DZ
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 11:16:49 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-79827d28feaso83015087b3.3
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2026 08:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772727407; x=1773332207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gv5MgCkEMh1sx9qjJXHI7ntcf6DXKcKuXxAJibRJ3M=;
 b=x3DGYPJVfpzeX31VTfh+218LIIegBXYJiRKopvs5NbCtVAYeyMPPPOBjEtxapaED1W
 pjNCMTN81LMmU0Y18SGg9R/3qMBhC6MDpWa8+G9q+EIw+pUDJtEN7T0M01oX6i5A0DNG
 ylxUI2pozGob2F+pRePKRNC79wpAEL0HgDz49+mJ8g7yb/3+7e4Ky8fPEDYocyqYIucv
 DSgvUUMLPKo3joNFQkwMVWy3jvNqx2+uMFmbI1ugIaVkHXYaqwA/7A1mcMgVdTo7k5yw
 eR4cFIEDOqoX+1wXKennupZKqXMD81HPG9h2e1bdc+RDPk9nMe6Tij1DG5BH+rJk/rui
 rfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727407; x=1773332207;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gv5MgCkEMh1sx9qjJXHI7ntcf6DXKcKuXxAJibRJ3M=;
 b=dVCrOOfhVL8+Tgfy72Xi0fX3Bm0Kj4+QHRT46Zyc9Y8ziIndBlcFKvBFoRi/XSCQMs
 FV9rk+ZhQmkM01POJypWNdKjkmVksqnBDoDhrO7SgQXejO37wLYLEJXwdVk8tPsVA01K
 yUTOL7iJYUx0MeiOd6IVkacZRQLaM+1yUEkTPE9iJjOJ8q+9MkanSGPjoCktwEndKmLX
 ZRFMNS/FRxPNQwKsuEAAHx/rtN/F9BNBLlp8aRP5h49K9EomH9ituIU1TN+44EORHSEw
 niF/5U7mwdtUmM707jPTTpWKs1yOwr92RTl+PhPsY725R+MDklNi7ZGB7qh1WXg5zhII
 oYQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH6Q5M8JlC4ozkzE3FxUxsGcU62vvqy4DzqPivGVYTu7ySSpWOAQg36XklFLTy0TFAcvS5FjmxK3Lu@nongnu.org
X-Gm-Message-State: AOJu0Yx+oSOF03lrSMyFCJwYW2VR4NFBNrJ7/ZQwbkwbpcuqboAqmA40
 BZqFH8YFhkAIkEEHoBEt5CSwDCFdMeuPbvSMIgdwFUcGCDlhKwx25l+vLZBZXTYE028=
X-Gm-Gg: ATEYQzxVctucbVKmX2DxmMwrbsdPaEI2J19RJur68PUjy7tmPkubI5iGMEUuTihcwoa
 3ZrGORXgY30ku6yAr0huUiHhACisdnefTc9IuP6NCqpavab6/jEOlQMDJbQB0amecPuhC99NaoF
 j0iHRNGDmObLKt3FHcEZ9Gi8dNa5iJtHwnJntxBxcRlnY9/+jfPtjL59C5ynsyMyICGawMmO9wo
 8objT9cXgQlSFAAMmUFNs8QwuF94MSqiKyH3I5Nqp+ajmbwVwgXSEwZS/QjaU/u/E9cx6AGpQGM
 546E1C+ghq/oHqWjvtxY0ygmkfMlnmU4VMw9D8iygwLtOyDAU+44xDOxUwthU+eZvoTdbYYc2eU
 nFbT+86hcPnhNWgVfmXlhze8mtkPMDCS7YGv73STqd+gURUOCdeFruveNzsPZHeU9qRemkY2VcT
 sDWoKPNi22GGbj9CGMfA1KycU0cRxABK5qnTnKjJvBijKu9atikwEvzR7DMJlhwYCgavIB
X-Received: by 2002:a05:690c:6b12:b0:798:23f:7933 with SMTP id
 00721157ae682-798da4cda78mr3957927b3.37.1772727406667; 
 Thu, 05 Mar 2026 08:16:46 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a20471119sm40176606d6.40.2026.03.05.08.16.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Mar 2026 08:16:46 -0800 (PST)
Message-ID: <85925cff-7e90-405d-9bb4-af2f98f00939@linaro.org>
Date: Thu, 5 Mar 2026 08:16:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] tests/tcg/plugins/mem: Don't access unaligned memory
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20260305161531.1774895-1-peter.maydell@linaro.org>
 <20260305161531.1774895-2-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260305161531.1774895-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-yw1-x1130.google.com
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

On 3/5/26 8:15 AM, Peter Maydell wrote:
> In commit eb3f69cac62670 we removed the dependency of this mem plugin
> on the QEMU headers, but in doing that we introduced undefined
> behaviour when the plugin accesses unaligned memory.  This shows up
> if you build with the gcc or clang undefined behaviour sanitizer
> (--enable-ubsan) and run 'make check-tcg', in numerous warnings like:
> 
> ../../tests/tcg/plugins/mem.c:167:27: runtime error: load of misaligned address 0x7f1f300354b1 for type 'uint16_t' (aka 'unsigned short'), which requires 2 byte alignment
> 0x7f1f300354b1: note: pointer points here
>   00 00 00  00 01 02 03 04 05 06 07  08 09 0a 0b 0c 0d 0e 0f  10 11 12 13 14 15 16 17  18 19 1a 1b 1c
>                ^
> SUMMARY: UndefinedBehaviorSanitizer: undefined-behavior ../../tests/tcg/plugins/mem.c:167:27
> 
> Fix this by rearranging the data reads and writes to use
> memcpy() instead.
> 
> Fixes: eb3f69cac62670 ("tests/tcg/plugins/mem.c: remove dependency on qemu headers")
> Tested-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/tcg/plugins/mem.c | 71 +++++++++++++++++------------------------
>   1 file changed, 30 insertions(+), 41 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

