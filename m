Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BB1C27C77
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 14:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sH2iA-0002xk-Fa; Tue, 11 Jun 2024 10:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH2i8-0002w4-UH
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:42:56 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sH2i6-0001nC-Nb
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 10:42:56 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a6ef64b092cso409543166b.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 07:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718116973; x=1718721773; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PWXCS/ShO1VjkwkUPxbHgZ97GAoGArUOIrXRzfQrIu0=;
 b=W0G3vyZAQ3HSKjFC/sM748zvWWfnCuf/jz6bH6ikLVSYmMAVjPbtlNcRfoZh8BytZU
 j9IlkbUJ2d/HtBaHT7BVB4AhnvJsObN0m+yg9FNVh9IIKFxAAUClEzLmiaSHOPK/u5GX
 mavd9sFQaH+jWPjf7EntLFf4ylk3QZJSUnqVJxsp/KRhXhNRWIdei8QFMMnO4Aj/lNCz
 4J3zUxZ9sYuewEga/q0XmFm1zfYycq57ig30CitknMFD73SIaUKH2yu22e3P+lg4zmZU
 aRn/IoqKYm+/NgWjHGjqxPtG6ofpOpfvY9OM1Fxwc46lUNMK8NccNR+mZfMsvKbqVUe9
 EtLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718116973; x=1718721773;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PWXCS/ShO1VjkwkUPxbHgZ97GAoGArUOIrXRzfQrIu0=;
 b=XzhRnO8edztOk4MxIGvNH+UCzvQEHDuH4Df7hgp7jKtzEXUlAyFss68pVWOkn/P9/+
 H1kkx5KLgOwQsM+ZK7eqsQCn8b3f7rWjO3PzKMQEhJ/DmauUqDx3YWVQ1C01T4Ui0Dl+
 BZ8wjHtfu5aOKYi94x01AJBdqbneFEIcG4ZdsXGWOV4DAOBOfzLH3rS5O+5fKjNNM3cO
 UIQ0qxuocGmSqUq2cnbQsdHPp65lsbvOSrI1VXHpCE1cW7gD+lPRg9FGzgXWUQntivrc
 R97kgrTxHh/Lhe0sos7FtuQ9PK7aN2AHUllcexpA4WIQJgWpbqO+bfcUl8N1hA6B39II
 rrjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFgQavIsuKNZtXiFlAbjPxIPtbQnuOrSpF+7T6ZhMsY181iu316oVvCZvZvwrZWWp2xELPLNGAz7Gp/Gd7ns3M99l0qnI=
X-Gm-Message-State: AOJu0YxvEZNU9PlZaZHZKQyy8QRg+Un5dA8vNMo/s8+InqeqDOSzZejo
 rNvm6UjrcrricYFGYh0Vgwmj9xbDEpDs5QmcUTkUaFwyzQ9Rol7V64diYchGgxo=
X-Google-Smtp-Source: AGHT+IFFnhpeWZcCHn8NFM9GqQ6tJIyRdhZUXyXTqSiM2Y5YS+B4d8PLL87QO/+5Yj8/s+pfYLxTDQ==
X-Received: by 2002:a17:906:3410:b0:a6f:3f75:41ac with SMTP id
 a640c23a62f3a-a6f3f754297mr67268666b.63.1718116972977; 
 Tue, 11 Jun 2024 07:42:52 -0700 (PDT)
Received: from [192.168.69.100] (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6f1244180bsm376451966b.116.2024.06.11.07.42.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jun 2024 07:42:52 -0700 (PDT)
Message-ID: <01dce86d-9644-4a97-b066-0496398b3c56@linaro.org>
Date: Tue, 11 Jun 2024 16:42:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/arm/virt: allow creation of a second NonSecure
 UART
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20240610162343.2131524-1-peter.maydell@linaro.org>
 <20240610162343.2131524-4-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240610162343.2131524-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 10/6/24 18:23, Peter Maydell wrote:
> For some use-cases, it is helpful to have more than one UART
> available to the guest.  If the second UART slot is not already used
> for a TrustZone Secure-World-only UART, create it as a NonSecure UART
> only when the user provides a serial backend (e.g.  via a second
> -serial command line option).
> 
> This avoids problems where existing guest software only expects a
> single UART, and gets confused by the second UART in the DTB.  The
> major example of this is older EDK2 firmware, which will send the
> GRUB bootloader output to UART1 and the guest serial output to UART0.
> Users who want to use both UARTs with a guest setup including EDK2
> are advised to update to EDK2 release edk2-stable202311 or newer.
> (The prebuilt EDK2 blobs QEMU upstream provides are new enough.)
> The relevant EDK2 changes are the ones described here:
> https://bugzilla.tianocore.org/show_bug.cgi?id=4577
> 
> Inspired-by: Axel Heider <axel.heider@hensoldt.net>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Tested-by: Laszlo Ersek <lersek@redhat.com>
> ---
>   docs/system/arm/virt.rst |  6 +++++-
>   include/hw/arm/virt.h    |  1 +
>   hw/arm/virt-acpi-build.c | 12 ++++++++----
>   hw/arm/virt.c            | 38 +++++++++++++++++++++++++++++++++++---
>   4 files changed, 49 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

