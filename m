Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3F13C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:36:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxB4a-0005t2-9v; Wed, 17 Apr 2024 15:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB4W-0005s3-SF
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:35:56 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxB4U-0003Us-Cp
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:35:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e857e571f3so1205145ad.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713382552; x=1713987352; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zrPNVHFTcKs6Px5fsftAPHY2pCBoKGkUMoZFiNY5rTs=;
 b=CS+jal4JfSXdZy8uql1CTUcU/qo0CsaFfITwyJ9dJNmLrsHyeFghB40SsyBLjcYSc+
 052Y8t7acn1GB/KZ6TjjCCvSqfgGQFG0+vP9MOFPFaSvIqdP8GIY4RAG6iMV0APyyoBy
 XKwYxXEAyxkcBsWMgcViNvV9MvVLuJH0TfRBg1N4+SYcmPWaVnjGyuxgkD8W1mJdPr3r
 nQm3TQPfvDV3RlKw5ZLsbihZmGWfa792nW0CJyf5mKjWn5QMRpd5Af/Pdnef7IwRfxSc
 19YwBEJ0rWHCQKKZtQrxKkREXvg/HjV8xb7qmIyJJGDgk+H1z9ktJBd9ecsMTmL5KWfl
 Vdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713382552; x=1713987352;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrPNVHFTcKs6Px5fsftAPHY2pCBoKGkUMoZFiNY5rTs=;
 b=vtLIFostv7kVhxsvnzEBEVOOC0sRA3b/I4omX8sl2vhn7ejKMPhoyHqRSYngJ71mOY
 iJsrbTjg/YW3OR5EqOsb2ZR3hefZHdPnX15qZ+HhD/RUaXSrxHaPkb/LuSkKe326oFu2
 BkOWFeqY7eThJqDT33omws+mrFTXbgim19jfZPPpURE2I6erqGQZj+AMI2yYu75/OKyy
 2PJaVE6Jnx5CkHY8fRp/J7RTGrWjyxvPh/wWt8qXZFs41AS7XahNWnqlYp68uQC1MWH8
 zlmdreWJhPmgyqCLHf5n11Iwh4NPqd8WQbdRelqSBFCGa8p3w6/uu884GflP/5DJJeu0
 r1DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR84JVskAUYGrrUzTKpf9OCJ6MpznGo+NVbMEO9pEeHa+qGasnq9P1490Yl9Dde3Px4FeASIsRAzPZZoJgdBq0njen4ss=
X-Gm-Message-State: AOJu0YwT+V5PGsptrBOijMlSwem7sem6+WV7S6pTOcPozotrPpRTaAUh
 iAWpCHOdeMFe8ZJCGqaQy40whAHpLewOY778q9vsnnUMwM+F51ej4SYODD9dIBaqJDaU1OK2IcB
 A
X-Google-Smtp-Source: AGHT+IGvpTWDsVy6FzbF/W47q73axLBhH4+qotPRFCHdr2Nd/lcCf4hQ2cpfTc2WCmvKJ2Q1Aq2sWQ==
X-Received: by 2002:a17:903:25d4:b0:1e2:a467:1b6b with SMTP id
 jc20-20020a17090325d400b001e2a4671b6bmr485012plb.16.1713382552454; 
 Wed, 17 Apr 2024 12:35:52 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 e7-20020a170902784700b001e797d47ee5sm5263882pln.235.2024.04.17.12.35.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:35:52 -0700 (PDT)
Message-ID: <4be3aeb4-17a4-435b-86b6-b37216618f56@linaro.org>
Date: Wed, 17 Apr 2024 12:35:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] exec/user: Do not include 'cpu.h' in 'abitypes.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-21-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-21-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 4/17/24 11:28, Philippe Mathieu-Daudé wrote:
> "exec/user/abitypes.h" requires:
> 
>   - "exec/cpu-defs.h"           (TARGET_LONG_BITS)
>   - "exec/tswap.h"              (tswap32)
> 
> In order to avoid "cpu.h", pick the minimum required headers.
> 
> Assert this user-specific header is only included from user
> emulation.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Message-Id:<20231212123401.37493-20-philmd@linaro.org>
> ---
>   include/exec/user/abitypes.h | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

