Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B8D5C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sElWZ-0006qb-HH; Wed, 05 Jun 2024 03:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElWY-0006qH-72
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:57:34 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sElWW-0004vg-MU
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 03:57:33 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42138eadf64so32224335e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 00:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717574251; x=1718179051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=egrl/d8rzBTRdPhuc6RcD/PapG2iaIfvjCjdwARZSLA=;
 b=BsTDy75BN6G+P1C0CpdvAaO4mGT0hFpJWpBmvQwdX19LejmLE4VrxUAlXNNSH2SUtL
 01BlfKTJKbbkAdaxqJ/h2nJMdUjz1bwGSdzBAV8zSlJo0mP9aKIll2RoalyfxLjiINPg
 yp6rgPYJa57akl6eiq0RFfL01ju1b1Pp14AcFVhnYzoyc//gWBo1PHap7V7blXSo99P+
 bPC9WQ9Addn+SjMhbOOzhIkOQZ0Wb4ADe+MreyjX2TLp2z19i89YabeJMxr9S2CUXp2l
 zmL4068PQSOqpjMVTtxvsdDTZHIJifajY/LBKXBXxu7vfZEVn+GqJP5ZwmUr7QWUrUbe
 mYrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717574251; x=1718179051;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=egrl/d8rzBTRdPhuc6RcD/PapG2iaIfvjCjdwARZSLA=;
 b=Nb+0tDRAfXfZo+RHX2hzfQ/QUTSiKZY6AnAE0BvQNl4lTZLJ5ovr2j8AubM+OQHzyV
 h4K6mL7F9ts22T9g5IyM6JxjX37+bEk8BdNKwp5O6uqut5riExB2DH03BKUWbcu0YI8o
 I3jLCgWprHiL2V2Ls5W8EfkIIK/wbt9Hb/7C7uQGALBePkPTj1Kl4xN9P8saFvu80y6H
 15uOMZ4lfH8RTc4noPEbepG+EK70eAQdYJI5vOl3dZE010HoV0tbcfFpBRNrI2i2Bf7D
 29Y3RJ7zNOH5pbGeOk1dAi87o6uPfZ7QISFkXKVvIp9K2uAs6urcDeNo+1hnWm14JMSu
 wm2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdUlJS5znnfSJDpg8/bz3zS1aFCIVHxIarVhcNof3CCKHnIs34qPpgxudDDt44vrGrAlVUdo7Sr6y1RsvIJoNlLMRN4b8=
X-Gm-Message-State: AOJu0YyhZxP1Ne129a0ZEmayqGmsM9lU87xvSbxbbuUOqucCd68HOUZk
 r8zfdcfljGD/nT4xqDa8Tmx1J1le4aF6srG1ywxaANK0nx3ZEWuzwaKVVANK+8k=
X-Google-Smtp-Source: AGHT+IGjAHp1inj4UgHzqUbci2IGN2xsLD19xiN/rXBykXqhvKJ5p/X9zo8dIIa9gZ+5xNJQZoI1FQ==
X-Received: by 2002:a05:600c:458e:b0:420:2986:ccee with SMTP id
 5b1f17b1804b1-4215633febamr13040875e9.30.1717574250967; 
 Wed, 05 Jun 2024 00:57:30 -0700 (PDT)
Received: from [192.168.60.175] (144.red-88-29-107.staticip.rima-tde.net.
 [88.29.107.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-421581111easm10757595e9.19.2024.06.05.00.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 00:57:30 -0700 (PDT)
Message-ID: <849a91fa-b3fe-4981-a7e3-e174179be26b@linaro.org>
Date: Wed, 5 Jun 2024 09:57:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] target/sparc: Implement FPCMPEQ8, FPCMPNE8,
 FPCMPULE8, FPCMPUGT8
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk
References: <20240526194254.459395-1-richard.henderson@linaro.org>
 <20240526194254.459395-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240526194254.459395-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 26/5/24 21:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sparc/helper.h     |  4 ++++
>   target/sparc/insns.decode |  5 +++++
>   target/sparc/translate.c  |  9 +++++++++
>   target/sparc/vis_helper.c | 40 +++++++++++++++++++++++++++++++++++++++
>   4 files changed, 58 insertions(+)


> +uint64_t helper_fcmpeq8(uint64_t src1, uint64_t src2)
> +{
> +    uint64_t a = src1 ^ src2;
> +    uint64_t m = 0x7f7f7f7f7f7f7f7fULL;
> +    uint64_t c = ~(((a & m) + m) | a | m);
> +
> +    /* a.......b.......c.......d.......e.......f.......g.......h....... */
> +    c |= c << 7;
> +    /* ab......bc......cd......de......ef......fg......gh......h....... */
> +    c |= c << 14;
> +    /* abcd....bcde....cdef....defg....efgh....fgh.....gh......h....... */
> +    c |= c << 28;
> +    /* abcdefghbcdefgh.cdefgh..defgh...efgh....fgh.....gh......h....... */
> +    return c >> 56;
> +}

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


