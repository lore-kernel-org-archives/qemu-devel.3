Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA87C0219D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 15:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tibXv-0007aY-Ap; Thu, 13 Feb 2025 10:54:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibXt-0007aC-LP
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:54:33 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tibXr-0004KV-V0
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 10:54:33 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38de1a5f039so966682f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2025 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739462070; x=1740066870; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dsE7R6Bjyvt0SJcXBV7n01h1oRmG1RIcf9a7eibRVnE=;
 b=gzsIDiXqdMSNFcwR7uI6fWUzuPbGvbvRiQ2zLNkiRSgae965zfoae0jP/T55vAgriW
 kzcxnKuppuKGweS9a22ONf46RehkYOjYVYw48XLDLzjHp579pyTxBGfbZ1t8wbU42Uz4
 H5Z4wjpwi6eMmpSE5D+bNlMznJgkCQiwc5w5rgna5L+FF+fbwbosE909aiybCJF3ASz6
 TiErllWt9z7q3Kl8XD+en2hmcPKUZz7odlR9jqGy3Jvh0+uEMrPqVaWutjWorukvw/BC
 SHSmO5SNrWx81d5lJzSpM9k6+cCwN7p+AyY3IAHqu2z3nAcUC6ZxPQ6Pnv5NoLWru865
 AhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739462070; x=1740066870;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dsE7R6Bjyvt0SJcXBV7n01h1oRmG1RIcf9a7eibRVnE=;
 b=PLqrDmESF6i8EoGTD5CG0WqrURTw/8MB7B2U5unQhJyLN5mBBRKND53Upg+sZRXpyU
 RO1fHGwQ7q4aGJU5OD8cSXnaJ99LTrmbq6EmXmtJhXm5uxnKree87VhktZNSD4w7mgpb
 GJ3bvcYCa7HIf99qT115x4ukbO41ouEY3N19JXxgKrSWhwCmNGw9bsCx5iDxuv4cR8i6
 pDuLxUEzuJ67IJ431YSFnObTps/wCPYeYprSGFjWTREDsXjaJ/zFGm6lmYmgOuIL5c4s
 jHfhioYbO9f4rXN9460/CEtTD/Ym5gPlgcXMsU6TXRggG65msFHHh85tgcgDVbLLfhCz
 QFsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVW6m4IrtYa9Y/yrdBm+9rOxpg53MHBopYme+gESsrdpH1w3W3s1IP2GLN4ZUmU/tbi+clavnFnUqkg@nongnu.org
X-Gm-Message-State: AOJu0YzRPXp9fJNj+uzUxb1Nq/D7eyBo6ir5ISbhEA9XwVPebEmBOzn/
 6wOyXiZ1QsqGOvXCfnzcUoEud56+vA2t00Ln4ChCbCnWJShge+H16bXqiHYpJD5+8sLmBT0UhoN
 fb48=
X-Gm-Gg: ASbGncvUf+NUXdl7x1CLhK2g5+fpY8O5kOhwmBmNH/VBVtDOUSnQyGwMagjiykSEF+h
 6DDJeGBD36bjcBN9AdaDUXcvYfGoF783ek74jwl6l9Kk7em6wfPJMhQkWbGPpF1Px811w8i2De+
 /NVCdXCpCo++M2V2D9N+klfM3+f0MCdETKOXmT8QDn5JW4tqnJQu7ark84j2NmIeTnWWV1IOxMc
 TpOf0MoOunkY4ZGDIokJI70bgsUBXCfpnxNTkgwcTqnKga4sx8CV5vYS8o1UtZz1gWquuo7ehHQ
 lzO4gMTtjIkbV7j4JiIagoT32/kGwlFXaQPT6v9S8R3vrKQqo3+PrMnULWrWJiuyJVH9ddecxw=
 =
X-Google-Smtp-Source: AGHT+IHqzvEzOwgCqJKCrTktW5UGZDhb0vUKGK4F3KF0YnH8T/XLedCEUerjn/18J7c23EdVgkKu+A==
X-Received: by 2002:a5d:5109:0:b0:385:ee3f:5cbf with SMTP id
 ffacd0b85a97d-38f244e536emr3939320f8f.20.1739462070197; 
 Thu, 13 Feb 2025 07:54:30 -0800 (PST)
Received: from [192.168.1.20] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43961885077sm20967195e9.25.2025.02.13.07.54.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 07:54:29 -0800 (PST)
Message-ID: <f315aec4-e690-4dc2-a6bb-8ae0d784d873@linaro.org>
Date: Thu, 13 Feb 2025 16:54:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] tcg/riscv: Use 'z' constraint
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250212034617.1079324-1-richard.henderson@linaro.org>
 <20250212034617.1079324-6-richard.henderson@linaro.org>
 <17aa46cc-c9ac-4a99-b15d-6f1e3873b65a@linaro.org>
Content-Language: en-US
In-Reply-To: <17aa46cc-c9ac-4a99-b15d-6f1e3873b65a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 13/2/25 16:50, Philippe Mathieu-Daudé wrote:
> On 12/2/25 04:46, Richard Henderson wrote:
>> Replace target-specific 'Z' with generic 'z'.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   tcg/riscv/tcg-target-con-set.h | 10 +++++-----
>>   tcg/riscv/tcg-target-con-str.h |  1 -
>>   tcg/riscv/tcg-target.c.inc     | 12 ++++++------
>>   3 files changed, 11 insertions(+), 12 deletions(-)
> 
> 
>> diff --git a/tcg/riscv/tcg-target-con-str.h b/tcg/riscv/tcg-target- 
>> con-str.h
>> index 089efe96ca..2f9700638c 100644
>> --- a/tcg/riscv/tcg-target-con-str.h
>> +++ b/tcg/riscv/tcg-target-con-str.h
>> @@ -21,4 +21,3 @@ CONST('K', TCG_CT_CONST_S5)
>>   CONST('L', TCG_CT_CONST_CMP_VI)
>>   CONST('N', TCG_CT_CONST_N12)
>>   CONST('M', TCG_CT_CONST_M12)
>> -CONST('Z', TCG_CT_CONST_ZERO)
> 
> Squashing:
> 
> -- >8 --
> diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
> index 61dc310c1aa..6edeb743384 100644
> --- a/tcg/riscv/tcg-target.c.inc
> +++ b/tcg/riscv/tcg-target.c.inc

and:

@@ -112,13 +112,12 @@ static TCGReg 
tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
      return TCG_REG_A0 + slot;
  }

-#define TCG_CT_CONST_ZERO    0x100
-#define TCG_CT_CONST_S12     0x200
-#define TCG_CT_CONST_N12     0x400
-#define TCG_CT_CONST_M12     0x800
-#define TCG_CT_CONST_J12    0x1000
-#define TCG_CT_CONST_S5     0x2000
-#define TCG_CT_CONST_CMP_VI 0x4000
+#define TCG_CT_CONST_S12     0x100
+#define TCG_CT_CONST_N12     0x200
+#define TCG_CT_CONST_M12     0x400
+#define TCG_CT_CONST_J12     0x800
+#define TCG_CT_CONST_S5     0x1000
+#define TCG_CT_CONST_CMP_VI 0x2000

  #define ALL_GENERAL_REGS   MAKE_64BIT_MASK(0, 32)
  #define ALL_VECTOR_REGS    MAKE_64BIT_MASK(32, 32)

> @@ -391,9 +391,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
>       if (ct & TCG_CT_CONST) {
>           return 1;
>       }
> -    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
> -        return 1;
> -    }
>       if (type >= TCG_TYPE_V64) {
>           /* Val is replicated by VECE; extract the highest element. */
>           val >>= (-8 << vece) & 63;
> ---
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 


