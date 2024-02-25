Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 333C1C54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 16:58:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reHom-0001NL-Br; Sun, 25 Feb 2024 11:57:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHol-0001Ml-3J
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:57:35 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reHoj-0008K6-Gd
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 11:57:34 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5129cdae3c6so3052270e87.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708880251; x=1709485051; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnEBkOmkGhaHOech3Xn7OifpmghjPt3Cn4mBCdxlO4Y=;
 b=tNJke8pMF3ldc+oRMQrL0Eoz2wzqXmnQbagc1f/8cDtvMqcOd7K0i+VBRiFARMJRMn
 utP6kETWWAwuH8QfEHUEN7F/iVdxA3+yYf/iEYjPcpfARXHKVWO9tAGvBTjSNSvDPca7
 QJMsFTQIzOIci56/n7i9EBMrTzO/Axsj1S3ltz/+1qStzhc37Bv/bOQmIKUtTtZ2ZLK0
 9R7DhLCD/Ed+wbG0v9ApE+p45QIInSfftuOXo3uInqIyx6/38vP2zAmfyhlAyFd6hRAb
 U2P3OwtqDj/g3Z7AJRbCt+Mtft4Sn3u/xmmorHsNS9Ddij0YI1uhHoFs4J9yr7xO4u8a
 bypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708880251; x=1709485051;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnEBkOmkGhaHOech3Xn7OifpmghjPt3Cn4mBCdxlO4Y=;
 b=DwZ8bW+oCXaPJ3T0w2fInqywHy1Rd84n2xhDUGq+hpxtQYxXJxsKe9asO55vwVO5fF
 QT+rsk8bQKqjJgesJ2rlLUrkfr8qReWO6DW8dYakKSOyNm3Zo/+NGR0xYNP9f/gN3ZTY
 99j4sgJK0NK8UGliil1s6SwxohP0P5NeoRqCxKbgzhT9Wv/hzmv4FTxMDEezlCw73Rf4
 /XIDvWw8bPqMgGHkkCec4y86U3nP3sOJTLiIcoavH37286GWXAL7JhNNreGXe3JJnov5
 unvm9dVlunpuvrkfHRuoEsE2We6lKW6skcZGOYVu8SxkSWV6yJ5klhcX7QLrlohXG3xW
 LRHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXcWNkbm/w1v/j9TAXVGByj9FiVCrx3S8E45euxg0gW76A8FPN2bYmYxSit4nQ2kVeyEnOWtmnwZOxaKk/WK66O6nIrKE=
X-Gm-Message-State: AOJu0Yxp9hO2YXzt4xQPP8IiVGnIVIelGsU4St/ECZN6qUFLTytTM/2Q
 1XOdKW1+kE4mZRjQIy+aaaA9KR5jEYDd2AuI9tjZXC6Fs2wUNxG604NwAWIPBWsGpay5ut4G1dR
 +
X-Google-Smtp-Source: AGHT+IHatZKmDFXwkg7Su/PE7UELC1CKL9ONe7QbXWpA0bXKVmAJoX539YtB1jQCqaqxCuE3vKwlPw==
X-Received: by 2002:ac2:53ac:0:b0:512:ee11:2a2b with SMTP id
 j12-20020ac253ac000000b00512ee112a2bmr2534911lfh.65.1708880251379; 
 Sun, 25 Feb 2024 08:57:31 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 d6-20020a05651221c600b00512e5b00318sm560430lft.218.2024.02.25.08.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Feb 2024 08:57:30 -0800 (PST)
Message-ID: <bcffda64-6805-4322-bfc2-888d246cc554@linaro.org>
Date: Sun, 25 Feb 2024 17:57:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ide: Remove last two uses of ide/internal.h outside of
 hw/ide
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20240223142633.933694E6004@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240223142633.933694E6004@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
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

On 23/2/24 15:26, BALATON Zoltan wrote:
> Remove last two includes of hw/ide/intarnal.h outside of hw/ide and
> replace them with newly added public header to allow moving internal.h
> into hw/ide to really stop exposing it.
> 
> Fixes: a11f439a0e (hw/ide: Stop exposing internal.h to non-IDE files)
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>   hw/arm/sbsa-ref.c                 | 2 +-
>   {include/hw => hw}/ide/internal.h | 0
>   include/hw/misc/macio/macio.h     | 2 +-
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename {include/hw => hw}/ide/internal.h (100%)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 5d3a574664..f027622a75 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -36,7 +36,7 @@
>   #include "hw/arm/smmuv3.h"
>   #include "hw/block/flash.h"
>   #include "hw/boards.h"
> -#include "hw/ide/internal.h"
> +#include "hw/ide/ide-bus.h"
>   #include "hw/ide/ahci_internal.h"

Unrelated, but what about this one ^?


