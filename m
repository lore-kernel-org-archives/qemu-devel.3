Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987FBE8304A
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 03:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn72T-00028K-DI; Mon, 02 Feb 2026 22:25:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn72P-00020J-TC
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:25:14 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vn72N-0002YO-SK
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 22:25:13 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a0d67f1877so34164815ad.2
 for <qemu-devel@nongnu.org>; Mon, 02 Feb 2026 19:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770089110; x=1770693910; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X/9yZDopGoXavAPjzoTEP71d80Rly6U6mL31XLE+OvE=;
 b=frS46CCA6CWf4z/s92k7KXJqwfNYl1RUZmCj4BSHffi0qnNIFdZRJXSmbF9Iy4gdh4
 rcS3ESNLxL0oQEKQL7rr5KIt7iSaOzJlYG+2w/+y4yuX/ZJjHtmhnbb5JhG+5jBhRwAy
 VhY59NhS8gTdKaSN8Wp/ZEj6Wfkkn4zQy+VaHIMdx3MLQo37sIpdxjkGR82SRjvpPF1y
 CrOBzC4sOG4/0TqcoWSZKBH51vob+rWU/BBJmTL5oyYCKtuN34l++owPIpGxz8HdXCmw
 +aTCOeBktTLbfb4Xv434xS6vQyIs6y70XdVShE5SbkXy3RM8TWtadtrMDCmB+UAIZDhC
 6hKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770089110; x=1770693910;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X/9yZDopGoXavAPjzoTEP71d80Rly6U6mL31XLE+OvE=;
 b=LIde52z+joNhphpsCaQagZ/t0zMJBz7+dpMp/4eoD1mBaUKyLT8ZoTVXXOVMf1ehyH
 cQUrjRBAkMGvoxiIK8yCvJwI/AAmH3r5dDi3t1piQ64GZrtfKRu06rqdQHSLysVlvSGp
 VoInwaN/iZ5PW2QpZSg69EUxVdsQ4jfUQNLsgNIWmCGGUPd5jQxYVQDZwQqFMjI/R72v
 P6N6eIBHLcDqwYGSd2UYv6Qt+zi0IZsvFEXvyhlnlQurbzaLplpgQGjWOX+8M4/Fop1S
 d9m0u48XQ9E9uzGzqk4vHHShgwQR+r0iWl3wPxLco17dsLRVj6R2iHmDcSfI0HjsBVBR
 uoNA==
X-Gm-Message-State: AOJu0YwsWz+tWfAKk3a3FEvQZxUugk6isNN/3UoMJXerysj40xlT1qWc
 4kS6CVQtDUbc7+VVax+6r2qlnKXQENvhkFrfPaWtp+4TBRX7Qx06YlzbY232xtMD81dqeT3cJk9
 bxswNXUD2ww==
X-Gm-Gg: AZuq6aIcM1qcyGAXKk4pzVcSISnqfnzKl17vKZyi0266oOXyeLbm0AeA2U0I1Fn0/az
 yru8NNfkS2AA0sHUSxJPm0IA8QQ5t7+wRq/VmGYsi03nvA6vGfwtATpkkUmdLLh+rMPtQRALe9N
 q3Z350SH3MlSFP2uRKMqksdaj4/sr4UrQpv1u48DLor8yhFnInov65hWZmzOKB/RXCFnUPlBoEU
 iX2cUSbNB0/IVXTVTKmgD81VsBNd0cGljGJd8yrHAc09rwvqhJHRxlbBRWXasBHbvY7nTFOWx44
 kfvcxSGz6meKpSBNjx3MnnlFTqHzWjeSpJ7TCCRwCkZTWBPDhiDDYT7MH82BbPLLhXEIE661TkN
 SYUlE4uDG8Zud7oqHjm2MxwppvAsPE65XmYoWDjtDP2+KQDAJCmoqddzG02Q02iCZFRGudwv5MS
 kgR1JlnPpKppNM8+1oyRSUPb6UzsePX5MLWPPhpH1AakA5HP+aP9lFzCK+8cleSMlR2VB5ivzyS
 2axNjAJW/szoQ9qwbIt/oxiSBtxLtRREiTyr7S6Pg==
X-Received: by 2002:a17:902:e944:b0:2a1:e19:ff4 with SMTP id
 d9443c01a7336-2a8d8037a5dmr155857065ad.29.1770089110209; 
 Mon, 02 Feb 2026 19:25:10 -0800 (PST)
Received: from ?IPV6:2401:d002:dc0f:2100:1047:c02f:591b:6a5c?
 (bg30dhzn7h1zhjqnvj08.ip6.superloop.au.
 [2401:d002:dc0f:2100:1047:c02f:591b:6a5c])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a8ebcba378sm88779895ad.97.2026.02.02.19.25.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Feb 2026 19:25:09 -0800 (PST)
Message-ID: <8ccfd282-5754-41a6-87ea-6d2b4708de25@linaro.org>
Date: Tue, 3 Feb 2026 13:25:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: Inline translator_ld[uw,l,q]() calls
To: qemu-devel@nongnu.org
References: <20260202213810.97141-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260202213810.97141-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

On 2/3/26 07:38, Philippe Mathieu-Daudé wrote:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the RISC-V targets, using mo_endian(ctx) -- which
> we introduced in commit 504f7f304ff -- instead of MO_TE.
> 
> Mechanical change using the following Coccinelle 'spatch' script:
> 
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, mo_endian(ctx))
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, mo_endian(ctx))
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, mo_endian(ctx))
>      )
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/translate.c | 15 ++++++++++-----
>   1 file changed, 10 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

