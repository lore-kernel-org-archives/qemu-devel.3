Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7131C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:54:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAWIM-0005EM-47; Fri, 24 May 2024 10:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWIK-0005Dp-4t
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:53:20 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAWII-0007vR-7g
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:53:19 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1f05b669b6cso29539735ad.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716562396; x=1717167196; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FNzWPCsvDdoOgTpeCtVFRWTW0vragVslvl1m8hftdZo=;
 b=DhKlMbpIIm7+y2sCGGarPlocLcmgODFu9i6BcH+223NJciZ1+Vwf1c1Kfev0+LyvF6
 o7ElKLrXTU/JFIW/bHRFzgtZ9ND+gAXrXz1mmVcCPSECIwZl2cAUoxEz4xSmbDWKg3Nl
 ucnTUZPeOn7USmts1EOX/MG7LGl9ngc8TNNamP5ImxAhjcQmgYg9Z4oS1/NwozLewGPC
 qDK7oYCKFBgP5LMlt7ykAYbm4xq6vi16sBYc8PsbdS9yWpDTdGIvPJhBvJS5bzCMB/ZW
 ueV4UuA0x3vofHkTSzy3upd5hWV26Wp0tHHO08fSle3EyI2FQR7YDS7kITMqMCJhZytY
 Tvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716562396; x=1717167196;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FNzWPCsvDdoOgTpeCtVFRWTW0vragVslvl1m8hftdZo=;
 b=jpQDEwltYaoeInSw40jt6tTMU8ajgrL2gt7Set5I31g8y6+rVNYO4AeQede0twDzMF
 MhwABphS3/ygXK/cSiFuzZa5U4KOUwrRbU9dT6E2OElH4WLlX0kNYZN4QhOL8Tt5b1OT
 IJcvp/ndBZBdJUa1IhkKqLDRsnlocP0xOFJXt2aH4k8fVfBskePK/m1INjGl3/Es/Yig
 xKZwGhPPs8Aju+ttDO4Nskr0tVSBIbpzQYCJ9G3c73m/7D2ahAE6V271e1JxcLHYchge
 AaTBnynMNmxYgDOSeMwdbBoIt06HXKkMSvDJ0RpaqVmvjD2IE7WWW1s8foyMN74RA7jE
 WzRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUV8iPjgO546YUtz3KGDeearfYeNJ4GP70lQY1HJmqrzXIVg4UKcBK/z0JrzmNTNNxMErzMZAF4T2eUxaVeYWkM2/5EWs=
X-Gm-Message-State: AOJu0YxsHTNFbkMWBOY+R7TGmAjLs65S7O7jWezp3BrEmX4hKYDEkF7m
 eoIKXMxIGCI8dvBDC5ghJjcjEx+IxFpWVES+gTgSg8rDFEpCZfyJ4Rqzu9xr4Zy/Ze4B3l8EVRd
 v
X-Google-Smtp-Source: AGHT+IGQBGrI3Z+FJExVG5PRrcsoPoLeV9w7SSTxPfvU6TXfGBEui2XyWRFh/oxSVLkMuSPsDRZHzQ==
X-Received: by 2002:a17:902:f68a:b0:1ea:cb6f:ee5b with SMTP id
 d9443c01a7336-1f44883876dmr30868385ad.38.1716562396506; 
 Fri, 24 May 2024 07:53:16 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c971d24sm14814365ad.129.2024.05.24.07.53.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:53:16 -0700 (PDT)
Message-ID: <b8ccb39a-c52c-4926-9d04-654ceb582cb3@linaro.org>
Date: Fri, 24 May 2024 07:53:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] target/i386: introduce gen_lea_ss_ofs
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-13-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-13-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Generalize gen_stack_A0() to include an initial add and to use an arbitrary
> destination.  This is a common pattern and it is not a huge burden to
> add the extra arguments to the only caller of gen_stack_A0().
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 51 +++++++++++++++----------------------
>   target/i386/tcg/emit.c.inc  |  2 +-
>   2 files changed, 22 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

