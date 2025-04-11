Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D815BC369AA
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 10:20:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3BU4-00010T-Kv; Fri, 11 Apr 2025 06:19:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BTz-0000x3-Kq
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:19:35 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u3BTv-0004z1-0u
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 06:19:35 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43cfecdd8b2so13830925e9.2
 for <qemu-devel@nongnu.org>; Fri, 11 Apr 2025 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744366768; x=1744971568; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MFSGtYjRoUNW2s+46/ImbSOnz9YYRL8lig0f8U3unLs=;
 b=l53VtkGP6WAPSwAn3I5dDwEHtrUnPBhMK8eoVPIdJQY/La/KiwiNPazzXZL5d7z8Ya
 UI68aso2gKxFAWN8UHkVq38z3LucDsvtP9ZoGGGI7r67CqSkXSRrKGxzwBHPA+Sb5Swp
 /wW39xtUd9soh+qOoXb0YktS+pudKUGRBNebzTyKPSIkOI9b60vUR3bOJCRgLVC0voAn
 W0mkcVQVcsuzwu25+RH04FGDlsKoQrgkAnjBA1wpKj+CwWRMUPsJnI9iILd1Gq62eNV2
 MMee+RnbIdzAkUAN5IApVgcKyFflMdvAJvMw8qz/FE9Sn0x8Ef0S/hd8/DtBVrcdYrPR
 YHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744366768; x=1744971568;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MFSGtYjRoUNW2s+46/ImbSOnz9YYRL8lig0f8U3unLs=;
 b=rOfbNpbQWu57Ofi/StqPtGeDbGtsdx5+Pl3Kel2lG2ZJFijL9cmfmjPBl2A6s+fRGI
 FRh2WolbLLOOud5+smcYVP9WO8xwbFWOU1sX6tWNVdqzwpiiq86hzLlj9TkkMmlI1zn5
 +NrmQdidr+FnkefeQG3noaFmNAKgspTEqX1NMxI6+d6aK6u0c1+9gt6A6CFDD2D0nOdP
 fK/J3bSe8NdzYUK5czSjclKjnI6YbVy4tlkbBST1xk1bXkSRoxpLtnL5SZQANxXFZh+b
 R5lPqDw1QAGq9vRKjl4h+xEh814icRVetHySMlFlscXl0NplFbjk7DOt0lCkdlwt97Cw
 +ZlQ==
X-Gm-Message-State: AOJu0YzVfwP02c9nXGEEWmhMqvEwULJ6CmPNwezsPzQ0J4n9PFk5iH61
 MVvxS+xZRwyh4OmeNH4Jcfcl54Ls5IkHrUYN2cAxf4lFNC/5GTS/ci4/n9Zn53E=
X-Gm-Gg: ASbGncuUdJQhzN6+YAdyPh5YM7K84H+HNf3PHRUpJK0FVtZ+M4GPo8UO/XQPZN8DWeo
 6Av/fjW7wQEZb/lCVlZnPxO/kusfkO8/NWE4yPjGpM7AbyOLLknCJ7irYdA2Aq5WlaEDOX6aHY7
 BRXuNID17gHYf/h2a+8uWsAhLgGaeACEor2p0rM5/T2a3L0R6nZHfN5vwcvW9UVY1yjrkhBPncm
 Go7joeY4BOzj+VvxvAr29wN+5N3s6F3h/eXkUAW1YdVAo+DM6K/o7gBlnLL/UvLC4IvTLGOAeFq
 0lF0UCL6ob5l5Mq07r+yK3R45eXpQiYZoIbebyZuIZ9cyNIRrJRh9c/vbOjhPyiNs6wDeSU+iM8
 VqNfd2J2m
X-Google-Smtp-Source: AGHT+IEfV7zMV2PvTwgcsjSvDYWX3fgb5+t94FPaSChthNxMMyMQqC9fyYuTnHuJw0OWVwTDVFAgWw==
X-Received: by 2002:a05:6000:401f:b0:391:1458:2233 with SMTP id
 ffacd0b85a97d-39ea51ee473mr1836241f8f.11.1744366767775; 
 Fri, 11 Apr 2025 03:19:27 -0700 (PDT)
Received: from [192.168.69.238] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f208e96dasm58636405e9.0.2025.04.11.03.19.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 03:19:27 -0700 (PDT)
Message-ID: <8b28c2b8-deee-4258-abf5-1fd9089a60be@linaro.org>
Date: Fri, 11 Apr 2025 12:19:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] usb/msd: Improved handling of mass storage reset
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
References: <20250411080431.207579-1-npiggin@gmail.com>
 <20250411080431.207579-4-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250411080431.207579-4-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 11/4/25 10:04, Nicholas Piggin wrote:
> The mass storage reset request handling does not reset in-flight
> SCSI requests or USB MSD packets. Implement this by calling the
> device reset handler which should take care of everything.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/usb/dev-storage.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


