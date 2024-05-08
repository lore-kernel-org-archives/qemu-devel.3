Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D61C19F4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 15:20:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4j5V-00058z-OC; Wed, 08 May 2024 11:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4j5U-00058l-5O
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:20:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4j5S-0002c3-GG
 for qemu-devel@nongnu.org; Wed, 08 May 2024 11:20:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a59a934ad50so1066493566b.1
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 08:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715181605; x=1715786405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVcPlbO2s26PlyrrMjby+JkTbGWLfVju1wec6fSphlI=;
 b=Gf9+87rMLBZaUP59ir05bDSG2twqOs2Ei0jFC23lkOUUXoQrJ9Sx5ha3jY4BL3awic
 BJaNsnNbo+/mzKiYwdJpRz/FbrG1GCnThRQGCJMuQsIky8pFfIlQRe+IGJIHBm6qFr8L
 ywQOeFb84zatZftxQSw4oynT+PKgcDgy3D8Bby4wVvwmwc6AbQRwoTb9QNeUji9x1KJj
 GQVcVtJ26hbSrq1IAx0Yvv82sDSCHoHNswpevdTEGvdmkA8R8olZpc4al05wnxw+3S6v
 hl23jIf19jh0n7bz/Uzr1EFgaFEDsqA5KZoAa5Qwpi7NdHdfK0X9V2NNYUVlRAHyXFsv
 WVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715181605; x=1715786405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SVcPlbO2s26PlyrrMjby+JkTbGWLfVju1wec6fSphlI=;
 b=V18TQYkDhgw8AX8Pp60N9gcKXVM8lbQeGIROwZffN/Nk9CXNzE1V4DUMyhZWijj+ML
 mj+DFASa1aKZ4QloLzV/5VBMLTPiVhfKQYaMbAuLE93Ob1BdzQLwnMbbScwTdGeHZb8t
 Q9y0Tv1CohOc+SfhqygLW2bJd32zxmFPD1HC36KRroPjmGo9/yxtItsjW73cus6epEfk
 8g3ulvuHHmAzJfTUeTDzkydtkTyZffzfWipzhIGkXeybwWAo77N8lDrrgZnwmdoJl1xY
 t5t/VQJYVjTmOBeFRVoKdsYJ4sN6elIm9dk8ahZnj9h5fpQlCpSYytm7+HCteoBAlHz2
 UIeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuyCgpM7GA7/9BiVtWjmQBFHvYDDYeo3eK1DxdjUlWzbUqTMgYoG7551CSWD+1VkDm3VhZ+FUC2Yr8FXCyzLQvRA8y/RA=
X-Gm-Message-State: AOJu0YxfofFGkjE50xA2OQbmbRRcI3fSAAytIaDYvYjDW79eQ1x2otAK
 S1c3P5MQ+bHL3AP/kAMEFCDBEWn1DVAZNkPFm6AAZrBpVrCbIimQ/qogULwp9G+QC9IC1CHVNrS
 D
X-Google-Smtp-Source: AGHT+IGqcEhMbV9mTMGFyoaS4N541PxZ5MuDvPKsRcVWY28chvXwyvFmfGa676FnjwyGmRbgAbY7Wg==
X-Received: by 2002:a50:a45d:0:b0:572:d1e1:b4b3 with SMTP id
 4fb4d7f45d1cf-5731d9ce4f1mr2033203a12.7.1715181604657; 
 Wed, 08 May 2024 08:20:04 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 p5-20020a50cd85000000b0057259943ba2sm7945602edi.12.2024.05.08.08.20.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 08:20:03 -0700 (PDT)
Message-ID: <a19d84f5-d59e-4a59-a3ca-baa3a630eca1@linaro.org>
Date: Wed, 8 May 2024 17:20:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/33] accel/tcg: Implement translator_st
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240424233131.988727-1-richard.henderson@linaro.org>
 <20240424233131.988727-11-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240424233131.988727-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

On 25/4/24 01:31, Richard Henderson wrote:
> Copy data out of a completed translation.  This will be used
> for both plugins and disassembly.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h | 23 ++++++++++++++++
>   accel/tcg/translator.c    | 55 +++++++++++++++++++++++++++++++++++++++
>   2 files changed, 78 insertions(+)
> 
> diff --git a/include/exec/translator.h b/include/exec/translator.h
> index e92dfba035..3c354a4310 100644
> --- a/include/exec/translator.h
> +++ b/include/exec/translator.h
> @@ -246,6 +246,29 @@ translator_ldq_swap(CPUArchState *env, DisasContextBase *db,
>    */
>   void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8);
>   
> +/**
> + * translator_st
> + * @db: disassembly context
> + * @dest: address to copy into

Or s/address/buffer/

> + * @addr: virtual address within TB
> + * @len: length
> + *
> + * Copy @len bytes from @addr into @dest.
> + * All bytes must have been read during translation.
> + * Return true on success or false on failure.
> + */
> +bool translator_st(const DisasContextBase *db, void *dest,
> +                   vaddr addr, size_t len);

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



