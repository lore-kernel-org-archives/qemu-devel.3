Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A447ECE577
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 17:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sniQG-0002A4-1s; Mon, 09 Sep 2024 13:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniQ9-0001zX-KF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:43:25 -0400
Received: from mail-lj1-x22e.google.com ([2a00:1450:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sniQ8-0007Tr-0I
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 13:43:25 -0400
Received: by mail-lj1-x22e.google.com with SMTP id
 38308e7fff4ca-2f761461150so30810991fa.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 10:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725903802; x=1726508602; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JxTDx8eoVUEAljuYGurj6YB5cLMFbf3dvrrf5/ODnI4=;
 b=tBrSq0/MfmpuedyDSAofLu3MP+gyqb75o3Ci02bA8k0JJ4Etq5rrgCWLhJTFahmLJr
 a++5ByS7/FifMMKC5FudSLhoyk2q+6Opi2lNS2Dq/91ZqejZgj1V41D8sTB9gXSss3DR
 eIQQJ+guxmsRvLY8D/O4K0dl7VR0mjtj7VULxh89rYqmHtofg7pSU8hvxpdkDNbW/mRS
 J5X49zqmiElXWLgTs61v9um7PlkSOkO1aw3QKg2shpcBsr/HxNP6nShfBWCLOjdMQBI2
 glY91Ph3+RYTK0SI6kHhX5h1WydlJ1zySF9PkYole3sZCN3V77+X6sw7VLz+1RI/9nDc
 YgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725903802; x=1726508602;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JxTDx8eoVUEAljuYGurj6YB5cLMFbf3dvrrf5/ODnI4=;
 b=qaZ4cuHRb+QHUpMay3yC3OhxcnPRbueLOFZXA4xG4x1gFPmsVuN3ol0PqjdwXyzcme
 WHdE5GIyctb86QSbavcnBF5WRg+HuQReKLUdAoEGEu/DHSZDQTzdD92Hyx+XIJ0AUOfo
 Em8imljmFV+X+8etU3tino3Tj9OMFCtbEJ85E3zXRo3Z1Hh2CnmCjSueSsjk7C90nitS
 F/HTDk04mNId1jPgxugPX5b6M5l7uaKgp6WGCBTKNnlcgOV8mkNrGCvV2SRnCufO9Izy
 hbLTWHkR/mlX/2K1JrWGsjFMZaKafbHtCQJHJQIdNscbJW9BCOiqivh2nQ79QoC66Jgc
 CoBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHFhTkeJFCdzyScXoV5zfOtnqW6gC5MsVErfcOkmoGp+fQqOnBA8i0Uj8A8mwheNY1ASXC8QzbGYj/@nongnu.org
X-Gm-Message-State: AOJu0Yy6VMjClmROxL9iJumMNviyV2/U5zdE5gKd/SNb8q5cEsJxpw8f
 Lqu/jSZg2VkYgUmGuELbSMFrtTZoT9B4CRJ7yvPP+Yl/3nbEHCCe9WhBdDyWVYueDy3awFSLeku
 x
X-Google-Smtp-Source: AGHT+IGWBqoz1rkZD6dEPxUoYSNbxE+wEsNCJ8d4uMnLO/1Reh2xVGbDyISrGs7AS8WKxxN5SmAsDw==
X-Received: by 2002:a05:651c:50b:b0:2ef:17ee:62a2 with SMTP id
 38308e7fff4ca-2f75a986f47mr67192011fa.14.1725903802102; 
 Mon, 09 Sep 2024 10:43:22 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c72ef7sm370409166b.106.2024.09.09.10.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 10:43:21 -0700 (PDT)
Message-ID: <a1808a6d-a2d8-43ed-a74a-2ce1daafeaec@linaro.org>
Date: Mon, 9 Sep 2024 19:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 07/53] hw/arm/KConfig: Replace ZAURUS with
 ZAURUS_SCOOP
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240903160751.4100218-1-peter.maydell@linaro.org>
 <20240903160751.4100218-8-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240903160751.4100218-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22e;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22e.google.com
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

On 3/9/24 18:07, Peter Maydell wrote:
> The ZAURUS KConfig symbol used to do multiple things:
>   * pull in the tc6393xb display device
>   * pull in the Zaurus SCOOP GPIO device
>   * pull in hw/block/nand.c code
>   * pull in hw/block/ecc.c code
> and was used by multiple machine types in the Zaurus family.
> 
> Now that we've removed all the Zaurus machine types except
> "collie" (which is not currently deprecated), we can simplify
> this. "collie" doesn't need any of the above things except
> for the SCOOP GPIO device.
> 
> Remove the does-lots-of-things ZAURUS KConfig symbol and instead have
> collie pull in ZAURUS_SCOOP, a new KConfig symbol which exists only
> to control the presence of the SCOOP GPIO device.  Move the
> associated source file lines in MAINTAINERS into the Collie
> subsection, since this is now its only user.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS         | 4 ++--
>   hw/arm/Kconfig      | 7 +------
>   hw/gpio/Kconfig     | 3 +++
>   hw/gpio/meson.build | 2 +-
>   4 files changed, 7 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


