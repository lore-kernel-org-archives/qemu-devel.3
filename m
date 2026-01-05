Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94808C2A073
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 00:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcYcL-0008Qc-VW; Sun, 04 Jan 2026 19:38:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYcK-0008QH-Hq
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:38:40 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vcYcH-0000t6-9o
 for qemu-devel@nongnu.org; Sun, 04 Jan 2026 19:38:39 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7b9215e55e6so8221867b3a.2
 for <qemu-devel@nongnu.org>; Sun, 04 Jan 2026 16:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767573515; x=1768178315; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aJhN+lvyv71Nrp83Hza0Icjtfk6l02rPippk9Yd6EOY=;
 b=yp1pDVx6WXjMOTtZgI+fz6VerOOveCu/GzgUoJrIwGcMaXC95l4f6TKaSpbeDTpm5e
 A72VPbyyyWXVy5nH38uc07Td5nASb8Iz9xRcg4rBIBy/zUIbVFhfpfMIGaU2G3TQHm7l
 8n1jYjOwSaZEE6waTUxdy5j1nArKbcnixoo8g8gD3dmS9PFVelPDCDwWdoGz/XXeGQqj
 mw7Dhajs6UoVjhzrycCcoRRocLhMZsCsSh8Tr0dRfL2RC+lvcMrZymlG/59z2O3utRV9
 lYYEd8V0AS1E7WvvrScJ8KJ+Gd97MdjQeacVuYxja2yl3efBS7Qvgezt8RffJvJF9Dhw
 a1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767573515; x=1768178315;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJhN+lvyv71Nrp83Hza0Icjtfk6l02rPippk9Yd6EOY=;
 b=nlB4kiencrpNWNlC2PYLieZtQur/Z5GmYJgV1F0k8vl9GXZCHTIF/x6u+FzuN4hDYE
 8UKvTypQnLACcTUt9hhrd6mzOWh+LLKEID7+YDv9NCRqEDNowpDVpy4XnolNSlvaumzq
 W+z5sfBx2q0hK6Vx1j2JBjQABMyofeu4fue3cB+7YGZIv8ZjFuP1eG73yT76lkkDIadN
 Ip07+utVOsawXpAfwGA2a4erNkFyJuhkbg6wSPY0p9n09WtWa0wCSuuahNVwdr5IKELP
 2WYY8pzBzYD3CO+3CnYmYMqUUVzJmay1ZEXwWn0kZ8Foh0vjKiivjsBUgiSU1ADk3KZf
 ZG3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeY8ZQ39s6iDY9j4++f5+aP7xQcnDpeDmhGn2e7s6Zsdrg1GfL5HwXOKzlVRcFZeZyECgnxzHfe48T@nongnu.org
X-Gm-Message-State: AOJu0Yxk3JAnOKPQYyKo2/dyWa78069wlD27/h633cgs3007yTivWo65
 qXe0qbmJ04ttjhDcWIr0QNy/B10OXuFOUptu3oz3tn9iv9OwgmCXCkXdxEe+ZrO1+zSg7eUeD7z
 ZWxzQGgw=
X-Gm-Gg: AY/fxX6GPfgl4NcM5mdcN28f+OF6qzKgE48eBPb4tcq7LF9piN/mpyaGlZfMbq3MZNX
 3jQs8KJthciE6LyGUB8KOU4GdYn9ygz+hl+d1oU8hecFzzLagD6EACO0SswvHlRhNjxfdtphVqS
 yZeKKxYHBTx+8Vw9kqiUM37Z4Wo49GVqMhxwu5J3QG1HpjweNobsjvMGobRWzI0xt33mn0xVpVl
 oxy5Rn6XGVmgZVdKHT/yQiDHcX+yAQo8l979AN4+OXdodp5Q1ERC6z+d6aI11jhgi9mULHkk/wh
 MVsKwvJjwjQh/oxcei2nf6wPw2INpReUfiVnOJLZnkghnW5f9jOFfkf6IRPT224/Wa5f0pARsCd
 7ViZzmAOh/ybv7CbJCOR7gl/nKkgBfstLQNO4MBmcai3B38eX/WjCz1d+M01KWtOpDTG0NeFz5G
 gEnGhWx3kpqbv/0OmQvyJ9bHR07OzkWw==
X-Google-Smtp-Source: AGHT+IFRwa+/+bNNOjsMCRars7gev2XORrwQRB0RkldpqFmgGpkW10S4MabyWR5IG2Sd6KWyJOflog==
X-Received: by 2002:a05:6a00:2e18:b0:7ff:c71d:ad1d with SMTP id
 d2e1a72fcca58-7ffc71dad4dmr40564146b3a.0.1767573515131; 
 Sun, 04 Jan 2026 16:38:35 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e493123sm46062289b3a.50.2026.01.04.16.38.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Jan 2026 16:38:34 -0800 (PST)
Message-ID: <8a84d206-e807-4515-b20a-f07b0dd2b584@linaro.org>
Date: Mon, 5 Jan 2026 11:38:30 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0] tcg/optimize: do use affected bits
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20251223163720.985578-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251223163720.985578-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 12/24/25 03:37, Paolo Bonzini wrote:
> Commit 932522a9ddc ("tcg/optimize: Fold and to extract during optimize",
> 2025-06-30) inadvertently disabled affected bits optimizations on
> operations that use fold_masks_zosa.  These happen relatively often
> in x86 code for extract/sextract; for example given the following:
> 
>     mov %esi, %ebp
>     xor $0x1, %ebp
> 
> the optimizer is able to simplify the "extract_i64 rbp,tmp0,$0x0,$0x20"
> produced by the second instruction to a move.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tcg/optimize.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tcg/optimize.c b/tcg/optimize.c
> index f69702b26e8..c546e8910ba 100644
> --- a/tcg/optimize.c
> +++ b/tcg/optimize.c
> @@ -1102,7 +1102,7 @@ static bool fold_masks_zosa_int(OptContext *ctx, TCGOp *op,
>   static bool fold_masks_zosa(OptContext *ctx, TCGOp *op, uint64_t z_mask,
>                               uint64_t o_mask, int64_t s_mask, uint64_t a_mask)
>   {
> -    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, -1);
> +    fold_masks_zosa_int(ctx, op, z_mask, o_mask, s_mask, a_mask);
>       return true;
>   }
>   

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

