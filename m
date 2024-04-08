Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2356EC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:07:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rti9m-00047R-Hb; Mon, 08 Apr 2024 02:07:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti9l-00047I-Bh
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:07:01 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rti9j-0005gD-OI
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:07:01 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-56e69a51a33so22517a12.1
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712556418; x=1713161218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=U4u6I5ikWwAhYL5pVzxgdlTz1Ydp99kIUbV3XEzi3iQ=;
 b=bYTlGDOIb2xVNI5p85JXOi8BJmy6gso8K3dQmO3Wr+MPFORcZUQpWP4hdqV4NnPes1
 aKpPK8A+ESoIxpQLjv2yRQ/IJ91El3+lLU7OZDCqwCFmIMYl1DiuCTAplGGcTXK1lgGa
 lBrSw9XvB+nW1k81aIxfy5X6p7OpdnCnp/mH7+gX2sTLLPTJmaLW+vL1AD1z5WfvsJu3
 qYnIzW1a5DiOGQrIh2nlcRNzGofkHMWnFvRXlIF/SwvoHAu/TrPT3xIMtWozZNLjER8x
 3fmRAxt38Wp4zwxQ/jM0AtjScNQsCJYawQ+xz4FDAPP7tMJXU0nHCr65Pvrc/Qa1KRpP
 YeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712556418; x=1713161218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=U4u6I5ikWwAhYL5pVzxgdlTz1Ydp99kIUbV3XEzi3iQ=;
 b=N5bciikqoZhI7+VazKeniVUYc3rfYnFdj6L4x1Jn6PXVu+kbk1iBMFAFSXK+uJM6ZD
 ZNWQ+IMAmXSeADp1gzagJ1DOx+KXAUZmXK3l4h84nTu1AQeQGFj5ymJTRTHBj+3C5La/
 uSAy1gDyB9E1lEXKh9+9V062JuUK6PInCNvtkFIFScqhJjekdIzInerII8xxIpqdjig7
 uFJ564/ggj7/0ghXTGNrkXzkYeMaQjcvxhBwnKhkMlt+0Kb/f96rOIf1n+Q11A/7Ox1A
 nZt2LRUQMnUKF5IUyyBN/ADw9A76yXrGBJm++KwCvj6FGG/jopt5+p9xAwJVSoEmKqmo
 mLdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHOZ7F/XOxa/gxQIaKrzuOnkKVri39oTE+cKSCBH5YZyDKAxHxNI2TEwg0GyYwDSeSBhJYYWmqhEyEn37xf1o7+ZqaEFs=
X-Gm-Message-State: AOJu0YzidfkXO61z/BIKBpv3XT7B3+AHKy862ZSI3bvTj597vNfIEFgg
 MxOl1hkzVT1rvVhnxZ+Bej51rBuYV8Q+9CqIqhFnYNftPB5W3zCeJo5NF7EPKBw=
X-Google-Smtp-Source: AGHT+IGtVL8ZpXOytuLUhdIQ/GVzEKTELIGnFepkGSu81xXEuWHJfvpj7cgHWZCnrY857bQDELgPDQ==
X-Received: by 2002:a50:c358:0:b0:56e:6d9:7bd6 with SMTP id
 q24-20020a50c358000000b0056e06d97bd6mr6919619edb.34.1712556417802; 
 Sun, 07 Apr 2024 23:06:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 cn10-20020a0564020caa00b0056e68b14986sm118137edb.29.2024.04.07.23.06.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Apr 2024 23:06:57 -0700 (PDT)
Message-ID: <ab82ee74-ab22-4204-9ae6-fdc57696f254@linaro.org>
Date: Mon, 8 Apr 2024 08:06:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] target/sh4: Fix mac.l with saturation enabled
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: zack@buhman.org, peter.maydell@linaro.org, ysato@users.sourceforge.jp
References: <20240406053732.191398-1-richard.henderson@linaro.org>
 <20240406053732.191398-4-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240406053732.191398-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
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

On 6/4/24 07:37, Richard Henderson wrote:
> From: Zack Buhman <zack@buhman.org>
> 
> The saturation arithmetic logic in helper_macl is not correct.
> I tested and verified this behavior on a SH7091.
> 
> Signed-off-by: Zack Buhman <zack@buhman.org>
> Message-Id: <20240404162641.27528-2-zack@buhman.org>
> [rth: Reformat helper_macl, add a test case.]
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/sh4/helper.h           |  2 +-
>   target/sh4/op_helper.c        | 23 ++++++------
>   tests/tcg/sh4/test-macl.c     | 67 +++++++++++++++++++++++++++++++++++
>   tests/tcg/sh4/Makefile.target |  5 +++
>   4 files changed, 86 insertions(+), 11 deletions(-)
>   create mode 100644 tests/tcg/sh4/test-macl.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


