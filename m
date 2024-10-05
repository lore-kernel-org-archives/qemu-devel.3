Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B81CF8868
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 01:18:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swtRW-0000Un-1J; Fri, 04 Oct 2024 21:18:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtRU-0000Sf-Ld
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:18:44 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1swtRT-0005Oy-4g
 for qemu-devel@nongnu.org; Fri, 04 Oct 2024 21:18:44 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-20b5affde14so21264665ad.3
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2024 18:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728091122; x=1728695922; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cc+/5PQgcKV0fK4ECQSe14XQyMhqW2gBRzK9BSJXUD8=;
 b=D6EQRZCigZFrKJIR6Z8ssI7LdFrlV5sw3QMrkHLO2AEAJx9XWzgweU5IWN7/UtoWpa
 eRngev1bbX6+lNtEqon43o5Jg3uCiCcyRG2DfLbcXKYItDMW86B/WhQY2y8+OabIY1LO
 W2uQvhWh0g0czq0Ham3T9ueTPGHHKM2apeOED3rKX2cJfziuv5IySw6DqMbvm3rFxKhd
 1m2qsJhSDH8VleQRmdM/5grVTpezhYqDlzV1HL8Bnhc3OdgidbYGOFUc4PRjieaTF3+v
 768VsCTXCTMQ+iTsABPkZ5Ybj0T+Iw34U4hw7b0V+blQMkpGRxNvoU9YMpXKtaPllemR
 PSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728091122; x=1728695922;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cc+/5PQgcKV0fK4ECQSe14XQyMhqW2gBRzK9BSJXUD8=;
 b=OdBrbDOUDCEwOk7X9DN2pI6AkvMmx6ki/VzXfEnE5tvxhL09Rcn5Siw1RacpW1n+My
 7whe3mvrw38W4NOKKUvbVZFc3lwUPPmhxQF/qt0ZAdbIeUIOUeLH5f0ExDlBAqVzDgxM
 vyQY2rxR4zjl3X68lv33HVis4e31yDD2scSY9dEvgD9oBBfZt8ZbZk8bAbBNxonzYr7v
 z2Kh6C1o7Kra77+QxG3A9EzdE+MvpkY0cuvUUZcnnoLfWOmrb3S3qqUXsKeNGOcG6SAT
 k+h1GrP8MmNMPDsNnSoeUSTzR8IJqWZEcO+zMLIUaR/W9AdyUt/rs95CG45APRR8amCN
 vJGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4EsEKPnJNstwbGhGFdAQyLL+10sYSEzNvpS5CpKvMPVn1d44GQiKquLJOrVbn2l6cOXALbdeF4Kz7@nongnu.org
X-Gm-Message-State: AOJu0Yxg8neLyMb0Ne3fcnxNoFIzewRYk96fiunO/RyBLHyteIWd0ZwC
 iAx9bVAmRjMSnmdNBAMVSachmTrjS6crgAT0b/j2QVVJnmkTzhghfhUR3aXeVji6ia+EtTCGo0v
 +
X-Google-Smtp-Source: AGHT+IEaIuGCWBvNIIOeasKZoX4TACjZ+b9fVASTv0c0tptpGUhkTjRzPeftMhTD7QCCkKZ3urbpqg==
X-Received: by 2002:a17:902:e747:b0:20b:9062:7b16 with SMTP id
 d9443c01a7336-20bfdf800f1mr55932135ad.9.1728091121879; 
 Fri, 04 Oct 2024 18:18:41 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13930b92sm4373145ad.128.2024.10.04.18.18.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Oct 2024 18:18:41 -0700 (PDT)
Message-ID: <75fcdbbf-d0c0-4fde-9e92-ce548060c8fc@linaro.org>
Date: Fri, 4 Oct 2024 18:18:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/25] target/avr: Use explicit little-endian LD/ST API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-ppc@nongnu.org
References: <20241004163042.85922-1-philmd@linaro.org>
 <20241004163042.85922-11-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241004163042.85922-11-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 10/4/24 09:30, Philippe Mathieu-Daudé wrote:
> The AVR architecture uses little endianness. Directly use
> the little-endian LD/ST API.
> 
> Mechanical change using:
> 
>    $ end=le; \
>      for acc in uw w l q tul; do \
>        sed -i -e "s/ld${acc}_p(/ld${acc}_${end}_p(/" \
>               -e "s/st${acc}_p(/st${acc}_${end}_p(/" \
>          $(git grep -wlE '(ld|st)t?u?[wlq]_p' target/avr/); \
>      done
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/avr/gdbstub.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

