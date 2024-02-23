Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B3BC5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:51:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZCK-0002Ns-IN; Fri, 23 Feb 2024 12:18:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYtf-0005NX-7B
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:59:39 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rdYtd-0004cn-Iw
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:59:38 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-412960dbb0eso4301785e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708707575; x=1709312375; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EJtDN3jvV6Bj8KTt6+nIvPG6r5VgNuaGUyPGz//FAD8=;
 b=mrNmyZ/6xHdE11+UqVtl1vttGu73S/uHaWfbCfwxEq4wO05TKbEA5qbv/jhYQJ3Dle
 E0j1gJJbq98uLiMwLAfUuSuf6bz3zdRCUeY980RkkhFxs2P3n8Ovj6Gv5cwEHucNVXO/
 OwwGeu98xgdtml42zYrS6RAXln5wPCIcbJAhU/a3lSuKlGrCY5c5YKuoTRjTKUzWReDt
 c0kzRaEVxVnq/NEWsZTZBoGnBcAfZbsuiFngPRsS3WNV8hz/3GGyrzo1lQiFBMCSsIIA
 MIzCTBjrUpnlXxvl+dESyIlsR1PgoDcqVTD4P4GiU9FUCGKk1qae8Dd3HXbWRS59aznR
 2uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707575; x=1709312375;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EJtDN3jvV6Bj8KTt6+nIvPG6r5VgNuaGUyPGz//FAD8=;
 b=UZ+kjdM1qY+cQXH6lo/qNJIl0fDjT+4VVn8Em2dPGaP/ynPz4Hd1o5KtMa4s1Yz9e4
 hBz5lpwXIdWkKo9BQGNyJlghYzj9rVepdtBCxoguYnrbuNlVGtf9gRNDBLqg/9tAtctY
 X7g/9pig9JZXn3dUqtdT4CHvskQWTPfLjlT91QVV1sRDlT0RdcKSK90JPSBZsfIiR2IC
 J8U8dgEZA09/n3oUxJT0yh6p8REmx7M00qUVTSB0kPXBjAjiDjKLC+D7idgWjfLr29QS
 dN1Jhi/MZ/oi0FYoZYQdkWDe7i3pIOFdhjmGw7JpUDNTW/1q6zdzKWQLYrdOKOjAOfZu
 tKfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5mzrtKB28o7W0OvNLBUUOxC1+7y6z5l8LLNPnB+2vpEnOnR4VUaYB5KiQOSjsD0iVwNgp6ZQ+WGOlqqMvr7PN0i7gRng=
X-Gm-Message-State: AOJu0YxaeZW8bMxi30HDm9NZW8d+Bt2nhWrQOe9c5qGcMoAI4UdQFwaF
 pCUzkdzmpEpBhhETdrTEA+ktAzlaDJz+fTWlS9aKcg+oAgvxP3EKf88k3+cFyXI=
X-Google-Smtp-Source: AGHT+IGKslzmCY5IMrPdT60Bb19x427lwsGWjnZLW4wSNAMk+LEKHdzOGO0hjl8uZCC97P2g80IXQw==
X-Received: by 2002:a05:600c:45ca:b0:412:7880:3da8 with SMTP id
 s10-20020a05600c45ca00b0041278803da8mr298496wmo.16.1708707574983; 
 Fri, 23 Feb 2024 08:59:34 -0800 (PST)
Received: from [192.168.69.100] (xbn44-h02-176-184-35-109.dsl.sta.abo.bbox.fr.
 [176.184.35.109]) by smtp.gmail.com with ESMTPSA id
 m6-20020a7bce06000000b00410bca333b7sm2939507wmc.27.2024.02.23.08.59.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Feb 2024 08:59:34 -0800 (PST)
Message-ID: <e44fde31-ca7f-4b79-87ab-bf94881d1be7@linaro.org>
Date: Fri, 23 Feb 2024 17:59:33 +0100
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
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


