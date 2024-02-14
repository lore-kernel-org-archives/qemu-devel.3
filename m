Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785ACC4829A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 00:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ra3Iq-00052R-8F; Tue, 13 Feb 2024 19:39:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra3Io-00052J-7H
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 19:39:06 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ra3Im-0000ES-MO
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 19:39:05 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d7354ba334so41922095ad.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 16:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707871143; x=1708475943; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hnc3s4Fep88IoVol2G9FuK3lrMXicAFYQwEtc+uctFw=;
 b=xJnfTL3P2DuTygUdYx4f5zG183L7cqv1wRA88SYVEuZiZ0InUdFbeJ+Y9lrySrxND9
 l4cm8oYEhswjJrNP6MMrCCPUCJZulh+PwaImmD7EhrhXF2sEqdcc8PlKh8tmpCkR+Dz5
 CHS5QJDm6Y177bSHdZnEDfJlNiDvTUIV2nZf9xixjyYmxdzweO4K8kJ+LSTNcP3ApArL
 VjauPXy5q22KOqtlyS1W46VCbHdqAJGkTw1NXDU4tp9aJDYlOIDHGwyeTi4pNnMO8o2p
 Me5OuQYmdwa1LIwbSml4QAHY9Nes2fCaq5xsOm9lJVWt7F+8VoogB0LxyniI/027RDhJ
 b4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707871143; x=1708475943;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hnc3s4Fep88IoVol2G9FuK3lrMXicAFYQwEtc+uctFw=;
 b=vmA1ZX4jBZ3syCNpfO0WMva2hmeJ3aRzRdk0EDQiRKMmyFEnsSHJ9IvEJPakaPQ6qT
 Lgr5xZSDFbJVEkBbc5J8Jc0aThTbwEN7sKty44rXmGpYK6Va7v4orGHzkE57KBiZkuJ2
 KjYexzUQmmYcs1q1EDHbQjck+IlQVWBJhmsChwceBZgkkSSEfdYOEg8BS9G1eWkh+HeB
 VPUxuG5bM+inRJhyeWYmHlFaWaTXeubUcf4bvUMCI1aqq9ClN3WOOl8WUjId4KA9zY4L
 snwtltIX4ApLpGznQ7kDO98XheHCTDXJ4FO6tHWfX/V74XGeW+kGQrRtYs0cwxsS+Ijt
 64Aw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPKA4otpt96dVLcTvZ0m+XjMj6X+suYobA58vZHOS04ZI8zNWt5tCwQFiqMl1uQzqKSVXDukXiU1NddGRvuMKMoLuLa74=
X-Gm-Message-State: AOJu0Yz8nmXD8xJfRg/uZAxFMoURXLS4zMDLMbLkTgAdAxo/16vZon5Z
 +tF+yFwo+VA/vCXsbWErVksskvfQuvNURx3sdl7plE7N3AghiAi5OBFTh73nNmo=
X-Google-Smtp-Source: AGHT+IHB7VkkhjzAvA92X1ByZO1WjWNWd/fo1FvTGYkyxZCkRpUMaZg88w6l6n9s9uDZktohCbPnAA==
X-Received: by 2002:a17:902:e80d:b0:1db:43f9:fe1b with SMTP id
 u13-20020a170902e80d00b001db43f9fe1bmr1420986plg.26.1707871142756; 
 Tue, 13 Feb 2024 16:39:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUoiD/r+/a1k1BOpC+By8xca7j170Jp6NcUx0SOVb6XecXXfp8pSmodi5UzkuwmjltlQdubyMvZc+h0+2YoHTsm294VrK0=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 kk11-20020a170903070b00b001d8a93fa5b1sm828040plb.131.2024.02.13.16.39.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 16:39:02 -0800 (PST)
Message-ID: <75cc5830-a953-4d16-ab9d-0ca9307a6c33@linaro.org>
Date: Tue, 13 Feb 2024 14:38:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/33] linux-user: Allow TARGET_PAGE_BITS_VARY
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-30-richard.henderson@linaro.org>
 <ms3tptv4ivxdhh5w7kiqtyukg6de5zpjja7bwdjz5g5xhhdirq@octi35juyhse>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ms3tptv4ivxdhh5w7kiqtyukg6de5zpjja7bwdjz5g5xhhdirq@octi35juyhse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 1/30/24 03:47, Ilya Leoshkevich wrote:
> I wonder if it would make sense to add something like the following to
> this patch?
> 
> --- a/page-vary-target.c
> +++ b/page-vary-target.c
> @@ -26,8 +26,7 @@
>   bool set_preferred_target_page_bits(int bits)
>   {
>   #ifdef TARGET_PAGE_BITS_VARY
> -    assert(bits >= TARGET_PAGE_BITS_MIN);
> -    return set_preferred_target_page_bits_common(bits);
> +    return set_preferred_target_page_bits_common(MAX(TARGET_PAGE_BITS_MIN, bits));
>   #else
>       return true;
>   #endif

No, this conflicts with the system-mode usage.
If we want to bound, then we need this MAX in the user-only caller.


r~

