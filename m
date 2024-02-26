Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C356C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 08:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reW4t-0001dQ-Fx; Mon, 26 Feb 2024 03:11:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW4p-0001bl-Dq
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:11:07 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reW4n-0002dC-Qr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 03:11:07 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso3331831a12.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 00:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708935064; x=1709539864; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IXxTAwoJKY2jfKurotE+rFCHnfcn+5saUQNAytaPDDk=;
 b=hpW2teennsvUyXYD4DAlYBH61/J/IQd7quphUYPHodY59J31ASQ14ag387H7yU9wbQ
 bF43DkD3bLZeJSpf1Ef9D8iMT/drMh4anGdm07eFCfIhwyZQnP1qTsNjm7EThihiOMyL
 HIE1jcP6Tt7QPt3zCHuwmMX0ttrp5Aluo0YC2KhM3lj9qfttWHoFNwzIzSIc1129gt4I
 1nfmo8wVUiz8Gf20G1LW2jKwYTIlAGBfFWuQXsRGcDBgesmVAJBZidG4dyhJD0zJrEmi
 X0Tjj4dHJULVsXMPnjTR739Zm8g+LhHu8Uf3WSeQfjZbdCJZ1OZ/wt4L3VjaX/j0ZW6X
 qKUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708935064; x=1709539864;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IXxTAwoJKY2jfKurotE+rFCHnfcn+5saUQNAytaPDDk=;
 b=PfOu/NzQqY1UVV18YVlENMfbYYYqofYvEQjTeieHSfeMegvOwXn189y6iroea+92Ia
 /3zcz4Yx1njDwGejaEca/OWRY3V6O5MWCzj5sYJCWM8tBV4h0anRl1H3ANwZv44ZKj2w
 jh8NvbhYcpDaAouQlfCjVdRv3vp8ZJD7YoqTmwLK1m2Fa0JJw7r6hgpGzx4Ez8FbxKu3
 BZat/sDljD9cCYGYbqeZLYo7QQ+AUSV13ursU0H2tJprmoTUurPx61OceqR8ybZn4qoN
 32+jtLp6+/AXERil5IqAbC5FrySeqESMr65rDzpZ/gjmr1Fl0a2QsKQceKV9JSPXFjBL
 1Tvw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsW6EKjVhbjJFFwXsNEJrurt6GV1Ihrg9+FUBahRcMFXJXA9TMtuEUUTxUozOAyd2VRRhfkFUKa0bgKUlUEMxbfrT7aWY=
X-Gm-Message-State: AOJu0Yy3zkRBYQOY/OmwKjTkLTOHkx/dUF/zu6tm9Q7l94MrDcLhZmjZ
 ub/chD+YGEO+yFZ5rqkgEFqsMlj0LKacjHRS9DvnbxjSeos7Nbnyp0ZCbhNXrVs=
X-Google-Smtp-Source: AGHT+IEUzjguIvkERSszRezAEUNX5PU20OKfYznX22BzTzPMfMcO6fG96j4iVNrClVcUhP5cyoH4yQ==
X-Received: by 2002:a17:906:2e89:b0:a3f:5144:ada2 with SMTP id
 o9-20020a1709062e8900b00a3f5144ada2mr4542878eji.2.1708935064325; 
 Mon, 26 Feb 2024 00:11:04 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 tb24-20020a1709078b9800b00a42fa329ebfsm1948745ejc.54.2024.02.26.00.11.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 00:11:03 -0800 (PST)
Message-ID: <c2a2b5b5-10ca-4a7c-84aa-308273e6c7d9@linaro.org>
Date: Mon, 26 Feb 2024 09:11:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ui/cocoa: Fix window clipping on macOS 14
Content-Language: en-US
To: David Parsons <dave@daveparsons.net>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, akihiko.odaki@daynix.com, mjt@tls.msk.ru,
 kraxel@redhat.com, marcandre.lureau@redhat.com
References: <20240224140620.39200-1-dave@daveparsons.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240224140620.39200-1-dave@daveparsons.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52a.google.com
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

On 24/2/24 15:06, David Parsons wrote:
> macOS Sonoma changes the NSView.clipsToBounds to false by default
> where it was true in earlier version of macOS. This causes the window
> contents to be occluded by the frame at the top of the window. This
> fixes the issue by conditionally compiling the clipping on Sonoma to
> true. NSView only exposes the clipToBounds in macOS 14 and so has
> to be fixed via conditional compilation.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1994
> Signed-off-by: David Parsons <dave@daveparsons.net>
> ---
>   ui/cocoa.m | 7 +++++++
>   1 file changed, 7 insertions(+)

Patch queued, thanks!

