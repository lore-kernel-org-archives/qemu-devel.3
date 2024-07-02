Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B92C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 16:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOgib-0004EG-U3; Tue, 02 Jul 2024 12:51:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOgia-0004CK-6p
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:51:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOgiY-00047q-DZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 12:50:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fa3bdd91c1so33715895ad.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 09:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719939057; x=1720543857; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODRNYG+QnvjBWckKEETLjwPkHbkiDmnXWlKB77O6xPg=;
 b=rNOTAfip8BFKJQGJt0+VE5sdzIkxeDGY22B4aSo5SmXan03Wj85uk6bD584Ueo9PeK
 WwoCiHV/XiqjX3n90+txnvYZl76WXiOLT0iNy8r3rDg1xCxkHe4IGipfsCdWd2E4sZgL
 Po70ijtgheEcy9KJyPqfDk8swpcOlpCWUErnFCd5lrvmGUAqzZxa7znzAyfJUeZ/MQTR
 STV7WV0X6WwGjJggWj5ooJJuSxMlUmwOYD3CxrcJXnqmCS11tvbb+fdtBEvQrZSNmale
 kwLOcIlzrK7Srs4r0i+ykNqXBtjX2e7lSBhNu0tBJ6mSXjBH/ev5vav5VUn7bsCuqURl
 ECuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719939057; x=1720543857;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ODRNYG+QnvjBWckKEETLjwPkHbkiDmnXWlKB77O6xPg=;
 b=qZOgrS397c49ZQ6v8zeJXJmsRTxhVBje7C4mIXxTvZ3aMhSPaASz14mIXqeO16Gkbu
 BZaJpscwkVl2OCssulT0737V3Qk76+YNzOGYzzLXqySXvTwFGtZHutNNJSBrY+JkHxDb
 8JOQ9xQ2NWwqg2+Q4xhIEb+PWhTsxSARjqDAhCkm3VOc90j2JRQfWkyixyXABU08aV/p
 8+NHx47bREkjt0paTvycFburoU71E86qPuYZ1rhefZBLoVdS0tSUCTrvsy+za/0re43o
 S7DAu4mC/Zd8Vwq4Q18UJTnokm6Wp8C++hAdZFEoiDXX52R94DqKLXY6AGarhwNVlg5x
 Kl+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpwPCX6TPwT7Fn/TQXwepazkV6/GaC/7vN1O5McNmCLNuDc14LBgGH6KKqa9XaYu0pnitXssmXEhDoWPo8ww/gKOIe+HI=
X-Gm-Message-State: AOJu0Yzx6g2wcxe1qfhVLZRFT2VFLKYU8GB9yAPq46WDSXoX8ILGJro4
 p9Q2rR5E/WUi3+JLep3c4xdoU400sIU/s4E8+DcLTBZrZ+GrGuUzb3K4ig/yy4DqF6exSDGHpTo
 C
X-Google-Smtp-Source: AGHT+IGDfQCZdgUD9MAPRBABpPhmx7RBuzCRK25mxmn00P1+ZT02rLYWbwnZ0Ap3oclP+NxOMu7yjA==
X-Received: by 2002:a17:902:c942:b0:1fa:d319:e0ae with SMTP id
 d9443c01a7336-1fadbce6a64mr107557455ad.51.1719939056511; 
 Tue, 02 Jul 2024 09:50:56 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1568dccsm86509565ad.196.2024.07.02.09.50.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 09:50:55 -0700 (PDT)
Message-ID: <614673dc-2aae-420e-98b8-688d10a0cc2b@linaro.org>
Date: Tue, 2 Jul 2024 09:50:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Misc HW patches for 2024-07-02
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240702050112.35907-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702050112.35907-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/1/24 22:00, Philippe Mathieu-Daudé wrote:
> The following changes since commit b6d32a06fc0984e537091cba08f2e1ed9f775d74:
> 
>    Merge tag 'pull-trivial-patches' ofhttps://gitlab.com/mjt0k/qemu  into staging (2024-06-30 16:12:24 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/hw-misc-20240702
> 
> for you to fetch changes up to f0936cbc1d42410ccd58c042bc26fa33a23a77d6:
> 
>    Remove inclusion of hw/hw.h from files that don't need it (2024-07-02 06:58:48 +0200)
> 
> Ignored checkpatch warnings:
> 
>    WARNING: line over 80 characters
>    #45: FILE: include/hw/boards.h:431:
>    + *          mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " Virtual Machine"; \
>    #205: FILE: include/hw/boards.h:591:
>    +    prefix ##_machine_  ## major ## _ ## minor ## _ ## micro ## _ ## tag ## _ ## sym
>    #40: FILE: hw/arm/virt.c:112:
>    +        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " ARM Virtual Machine"; \
>    #55: FILE: hw/s390x/s390-virtio-ccw.c:828:
>    +        mc->desc = "Virtual s390x machine (version " MACHINE_VER_STR(__VA_ARGS__) ")"; \
>    #43: FILE: hw/m68k/virt.c:345:
>    +        mc->desc = "QEMU " MACHINE_VER_STR(__VA_ARGS__) " M68K Virtual Machine"; \
> 
> ----------------------------------------------------------------
> Misc HW patches queue
> 
> - Prevent NULL deref in sPAPR network model (Oleg)
> - Automatic deprecation of versioned machine types (Daniel)
> - Correct 'dump-guest-core' property name in hint (Akihiko)
> - Prevent IRQ leak in MacIO IDE model (Mark)
> - Remove dead #ifdef'ry related to unsupported macOS 12.0 (Akihiko)
> - Remove "hw/hw.h" where unnecessary (Thomas)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


