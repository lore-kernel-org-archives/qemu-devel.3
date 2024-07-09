Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14033C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 15:47:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRD2r-0001CC-0w; Tue, 09 Jul 2024 11:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRD2i-0000mG-73
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:46:16 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRD2g-0002Od-3h
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 11:46:11 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-70af8062039so3219904b3a.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 08:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720539968; x=1721144768; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9JD0Dbr7T3ZUz9lt7nR+lfIlFQr6E0Gj/yU3KGxEYB0=;
 b=QmkBcCaKZ7skYU0nN0GGDfGiwnAdt8Vqr/N+36GDZk/nfem6dP/U+lcuD7oNsVA/RS
 XHPl+o6axKUvM4bpWR9zkgIy+QF4E5GzLJYqMi8L+hHboMYdUzhvEIiOXquUCiVph4mw
 yYS7b6wjwmNc/xFb+mMreSgH6pyDymV2UkI7B9Z4AaVdub7/M0KENwfAfS1tTaBkmvnM
 z7BTX+2rYeowY72OB2mbITopGcf2xW79XA3mmb84QAD50mygHoeS56MK967+dpds1CQl
 oL1l/6WUIJrMsAGBrE/00X2XngL0aRRRo9fo9kaXciBM1aVreZebKiiPe94wneaq6UVS
 d3GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720539968; x=1721144768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9JD0Dbr7T3ZUz9lt7nR+lfIlFQr6E0Gj/yU3KGxEYB0=;
 b=RgY39g3tNybCHL0qI07p8CUt4gkK5vJZAoFSk7+eUMwqwbmJnSny6yroWQdflABvU2
 VqKVd2o+6J5rDi+22Sp1tt/epNBGBl2Cl7aacnmogZGl/ai1ojrl/I2NfO9bosdTsiq+
 Jo6qdtaLu3NTyI8jb5BrG13kwaIAsVBuXESGGNYU1VZ1Y6tyN62qxJ+dx9g0iCUtuzeT
 rOXz4MN46OaUJwLlZ8xILhrW0bfqGnYbF5oLD+RSa9JmeuZaNq1Zyq6I2wd4rooGfFeW
 re+EIR0o2vnzTGP27YnyyrfnV9KC4/2u/66dLYHGeBMGKqSZGT3cjLXcm7m3J3+SXUrO
 S4PQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ9dyDILNtHUgAmzTq1uwmGZ7GSpn7K4w8m0/T6gZv8yzWNVBTWuP2nU5BmUmIrglzHC5ozNc0CK3V8mW/m+LP7MDqZyc=
X-Gm-Message-State: AOJu0YzamQ0lmdIm4+5VkWhnvvPxsGckHuk5xhP6Cy+PFMmFPW8e63CJ
 +TarvADXYJvz4hfUW2mjTxkhtHgn+aJPMiRYSQ7cFRrrA8NhcGL34DL17Q3gesk=
X-Google-Smtp-Source: AGHT+IH0XnyCvtEHHpJxqK/AnHS/F8YQaHps/BsNn1SwHSPY/KjymlQI5WaPf3MIaNpWa1EsbFGQdw==
X-Received: by 2002:a05:6a00:4650:b0:706:34d2:62bc with SMTP id
 d2e1a72fcca58-70b435709d9mr3391749b3a.18.1720539961482; 
 Tue, 09 Jul 2024 08:46:01 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b4397ed2esm2035874b3a.149.2024.07.09.08.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jul 2024 08:46:01 -0700 (PDT)
Message-ID: <b1edf94a-5003-4075-a92b-87a802e748ab@linaro.org>
Date: Tue, 9 Jul 2024 08:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Fix handling of LDAPR/STLR with negative
 offset
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240709134504.3500007-1-peter.maydell@linaro.org>
 <20240709134504.3500007-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240709134504.3500007-2-peter.maydell@linaro.org>
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

On 7/9/24 06:45, Peter Maydell wrote:
> When we converted the LDAPR/STLR instructions to decodetree we
> accidentally introduced a regression where the offset is negative.
> The 9-bit immediate field is signed, and the old hand decoder
> correctly used sextract32() to get it out of the insn word,
> but the ldapr_stlr_i pattern in the decode file used"imm:9"
> instead of"imm:s9", so it treated the field as unsigned.
> 
> Fix the pattern to treat the field as a signed immediate.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: 2521b6073b7 ("target/arm: Convert LDAPR/STLR (imm) to decodetree")
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2419
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/a64.decode | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

