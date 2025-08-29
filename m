Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69033CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN9a-0004Xb-PD; Sat, 30 Aug 2025 11:06:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uruTQ-0002Vu-5A
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:28:42 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uruTN-0006G3-85
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:28:39 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4b30d09da9dso5311471cf.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756456115; x=1757060915; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uUdQqHWciWr9duEGgnFbQRcLETXG7dgngEGdzVs/cEQ=;
 b=G/va/SxrMqP9i0IcbFh3N52bX5EySwzwt2XrTQpUy26lMX7nYPiq0XEXNjO/rRJE+b
 q4Qt44PeTM2HVJifqFpPH6BkVArxyge7qcSW3090H170Lr6zeWMtQRUaU8NoZZSmQh6Q
 VkWjI6GD2Kejhk+CNLuo1jvtAd9EjKoUxHEijx8noICrQd5/z2nG8XRmZTWT0o2tGqFo
 V2QDTKqfg0thusI/DJ2lYy/6qe2HbPGH4oHSrLEzXB3A9iuJLaxlxFjrCCjFKVNhg0fI
 Ggl6hP5s6lg7GcguXY63WhB+uwspEVaCaRYTwFgDUqz1TAzaQeC+osI3fXv5D3tvHzXq
 251w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756456115; x=1757060915;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uUdQqHWciWr9duEGgnFbQRcLETXG7dgngEGdzVs/cEQ=;
 b=dGJ8THoFBTMYda/mdwrhv7AgPZDqtSlGOR/4x6ZIJxHMyNSFMSLYbINAV0+jsKMQxj
 o3xMDwXLz4wFg9VzrMwxZjqzS9LrVVzl03BDfz2LiXdWuMe0I2C+cGmtDhc/J5bEybYa
 +qkH9mbtbL0SEz3O2htwu6x3seLrUoZ/CqYkvuDoor5zCb9M0exBeZQ2gdqa4+l5UMtN
 csRI/nF37/1TE1hTC97LgmmBykV5rF2qMLUuwHqiYM5FuCG82/mzrjTegPYz3YES6//F
 tUf7/KfVTIhRSrXEiBNjyf3NGzambzyNcgAYCp8CVFP5RPI6wlko1uZauaVeAaTwTRuP
 fh0Q==
X-Gm-Message-State: AOJu0YxJVhvw6Yo45fTYpEsXG+JmvIA2Mo8nTi4qt4aQQANm+VeNKHob
 h1zIW7364VnCvv1nR2cpPUSpaM/LwxhEi6oiAOCOaYm7Bqh8y5RpYwOlnIXfVFpWMZUE402p7eI
 IsscNpSA=
X-Gm-Gg: ASbGncvgBeX8mBCTDlV77wg844Rif8u6sBKKtzzTMLrJ0/YwjQhqrh+drhpJiqNPoAy
 M9EtG5oQlJyMwcOgfjkqdniiWALahh8nkCTnx2m/E9DeqAhtJfBj59gLdyWwvTAxTwMNVLP4b3h
 cpDuaT+W+UBNNkSPEXUP/NOUpvdDTEUJSKpW7SPec6AMINXRREKh/n4MpdHjU3vl+Dh/cZ1cmMP
 vtLdfr7H7btl/Zgsn6T1R35yjrTIEoT1W44vS6qy+0A/WnhDoRE0ggRFc2AFTMCp/ZAVTNXGAA/
 VHFpRX46pcB7wtUStj7Qx/MMmWeNN/u6tyAs1FeM/dbPHKAysq7ifd4/S2l2beH67NVDnkQpxid
 VQnWVcAZQxuM0sMYdlkwaHf3JMvWmnVq7rLwQOBIjAeHTkQ==
X-Google-Smtp-Source: AGHT+IHGN63i8lfYFwHZoCm1lTr6mV5ROhK2MLlocywWAXGZdbiHE5yhSe85fJdwjydT1jtNUV2Ymw==
X-Received: by 2002:a05:622a:1116:b0:4ab:3963:c650 with SMTP id
 d75a77b69052e-4b2e76f6fc9mr131173041cf.10.1756456114941; 
 Fri, 29 Aug 2025 01:28:34 -0700 (PDT)
Received: from [10.48.39.227] ([172.56.181.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7fc0d86df61sm134953385a.14.2025.08.29.01.28.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 01:28:34 -0700 (PDT)
Message-ID: <bfaaa5c9-de74-4f21-84a0-f6cc4177868d@linaro.org>
Date: Fri, 29 Aug 2025 18:28:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] loongarch-to-apply queue
To: qemu-devel@nongnu.org
References: <20250828120218.1227427-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250828120218.1227427-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x835.google.com
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

On 8/28/25 22:02, Song Gao wrote:
> The following changes since commit ca18b336e12c8433177a3cd639c5bf757952adaa:
> 
>    Merge tag 'pull-lu-20250828' of https://gitlab.com/rth7680/qemu into staging (2025-08-28 09:24:36 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/gaosong715/qemu.git tags/pull-loongarch-20250828
> 
> for you to fetch changes up to 86bca40402316891b8b9a920c2e3bf8cf37ba9a4:
> 
>    hw/intc/loongarch_pch_pic: Fix ubsan warning and endianness issue (2025-08-28 20:06:27 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20250828


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~


