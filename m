Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548CCC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 13:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7EKl-0001HC-OL; Wed, 15 May 2024 09:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EKi-0001Gt-46
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:06:12 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s7EKf-0000Uw-2s
 for qemu-devel@nongnu.org; Wed, 15 May 2024 09:06:11 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-420116a6652so28642655e9.2
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 06:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715778367; x=1716383167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4xFTqiigjSDntv2GjgUMBo+nJpu2pd24JAmGO3r1Nsg=;
 b=YCOfoj5HTcro9eLtwgfkFk2ZbnUoNoeVJPmpU/Tunuoi6+/ixlKN3NZIx3c6cPejbA
 honm+kUJ4f0+/6T95OUrqybwMey6RT4Zxaw0d3FjX1TtGH8ad4HlZgRBGy4GEk4nvvLX
 IefPE33qo9nvPv82o955VoG8Myo+Y9tbfFvVOp4IRLgdepkuXMHK6cElQE/dj2OrQgjo
 NTMn9tqLhcxPrXzt33eGuHC/A2P5LshnWJbLm8JCYVvwT3mmGfmHEtkb1ApSX1qd87z5
 6bypHjxDGNJmTaYjYnm2mf8SLpo9OHKhuW7CejUcefn9cMTERpB758gBIvPWCIxdIXlD
 JAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715778367; x=1716383167;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4xFTqiigjSDntv2GjgUMBo+nJpu2pd24JAmGO3r1Nsg=;
 b=Ew3RaRHapoxshgc8e7c8BSw/2zdgW2xuCvcWLz1J8FjnhqQmNP2Bw+zYfsVQqHmGD9
 p6PGDyaQRQwa+8GW/7cIUtWSR3E9tJlkPl1Tq75RiU1SkVeJmRZvfKATLxl25nfauY1V
 kDMEuLRiw2R6H7UuSo9n31KUlF+LcxSdKmAN/P+HM80+OPrUCRCTTYMmTmOMIdTSxFgJ
 zaQiSI8JNM2SmSPI0I8kXOEsMGdHaJkJWbukejGl6xyuqyh95C5hdYM87YeitIlIc2wH
 s9zQ6CJuYbygfQt/DavLU1QWSqlBk+vUlQEIYDz7IgS6zWusgbLYsixMmrkNQ2OWfpFm
 bdkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbRs7zXhC9m9ZnpDYlY7fz9MBcrGAHcqKTTMuAojpRmh8d7oZLaES8opRZpgmD6gSZQEMFKJTRmp4huCN0+ywMHZCbueE=
X-Gm-Message-State: AOJu0YyGsDsnvINlqmlSAKEbZs+MUahTHGvZPnm72/6PQgaWy6hzRanH
 YT6rYZxG/y/i6VKRxn+j959+MMUtF1VTy5GkJL2/hzAbg3IX8AKa3syOkEek4Yw=
X-Google-Smtp-Source: AGHT+IFh6NuhWLTa2E05p4Xk8BJ6sglKU60gPoHFN6IhaAn6zGK+A4Q4Chr2JyjHPg/joU9P8nyyGg==
X-Received: by 2002:a05:600c:4ecf:b0:419:f630:57c2 with SMTP id
 5b1f17b1804b1-41fead61f20mr130503625e9.37.1715778367533; 
 Wed, 15 May 2024 06:06:07 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccce25casm232433755e9.20.2024.05.15.06.06.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 May 2024 06:06:07 -0700 (PDT)
Message-ID: <e454df7e-241e-4bfa-a07a-0abec2196be6@linaro.org>
Date: Wed, 15 May 2024 15:06:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/17] configure: Enable loongarch64
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20240511115400.7587-1-richard.henderson@linaro.org>
 <20240511115400.7587-17-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511115400.7587-17-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/5/24 13:53, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   configure | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


