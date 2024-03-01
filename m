Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71C79C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:04:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg8Al-0003SJ-JU; Fri, 01 Mar 2024 14:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8Aj-0003RQ-TX
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:03:53 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg8Ai-00050h-9g
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:03:53 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-412cb54f086so3879855e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319830; x=1709924630; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0Nau/AEooc9rNVy96Utg8TkIyXzpzRRRzAVdfocc8o=;
 b=RAY8zfzEJkGI7u0xQpyPHvEpDAgKEBC/9EiIN5vhs79Pnid7B6w+t6bqjXX6Yi3BbP
 /BTw9qg0sDQtGuDLSh1mM4andjlgpCgJusiBFnR9ymPgzAFxNoHe62hmJDqkRNxKH+F6
 AhGML//CHeLi/cIT4Ijn7JOa6PP09os+TR6MQKY79jo6RNxa6nQmXfZCraKgLvtDk9TB
 MAWn7ZjvJM5U36q27+Bag0Vt/kjKJqbn2CR3FqMYJcVIh8B46ECKh8BOdJuuwJmNiuaF
 tXQXY29u0UkKKtQ6T/Kpixd3vp9Yv2K4/b1pxKHUYd4eYt/LUk4FWtSV7vQrF6CgYDwn
 Ig5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319830; x=1709924630;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M0Nau/AEooc9rNVy96Utg8TkIyXzpzRRRzAVdfocc8o=;
 b=OFHamldB7kPmLvqzf/4z/5KEw/w+azUrRQHCxPB1hdrr8FYn6KLMzxJjUhTXWpHzNu
 xeoJvEgcyNkInorqzDGOyXaPT/7VDMtn0oPzQbsuDhUGYyexAlsgeljaE6XprqP/CYnz
 0XpCzJXPtdtIRPD2sA2rsaiuCVtH8yfUubhmLSxFl/V87AbftvnjgCpYWxKOhL60nXlR
 SrBWLFVNm9EkTGO+D+esLf1C3d3jiyhoIbQ9dP62vmOiyg+OPOCeq6cJhGmuhmwsHrPI
 h1UlazPhWXJUUkpRUIZCIXmjtEpPeqDttdEhouBp1EqhkxlCDH/BrUhw1CyMv8iQW14g
 IvZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKuepdNTdC/FmDLFUsNl1wXCliuDrX51V5sMfv1jA/AkfQTnnkq0h4m20c6sCrw5TOmj2QR2AXLY8ca9nadlE8aaJ4Lpg=
X-Gm-Message-State: AOJu0Yxhpw51CkPRmJGj0JD1BTIBxWiD6U6YVh7sLV2HN5ZnJouvhGup
 gT+kCrUkSk/pPuZlTDf5U10e+ww/HQpv72GdDHUnX/3S9BnmTgJY34vL4/dMZeM=
X-Google-Smtp-Source: AGHT+IFo1fVaMbQg2jdLjcfFBP6Cnqi+LrxVrEn7fpBNRFovBqZNGkt3DlZ6Cjw7dddzPthGP7/1bA==
X-Received: by 2002:a05:600c:3b12:b0:412:a266:f5e2 with SMTP id
 m18-20020a05600c3b1200b00412a266f5e2mr1800674wms.27.1709319830442; 
 Fri, 01 Mar 2024 11:03:50 -0800 (PST)
Received: from [192.168.69.100] ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a05600c45d000b00412b67388f0sm8572229wmo.6.2024.03.01.11.03.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 01 Mar 2024 11:03:49 -0800 (PST)
Message-ID: <01425b01-0975-4805-b302-af774abb795a@linaro.org>
Date: Fri, 1 Mar 2024 20:03:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] target/arm: Move some register related defines to
 internals.h
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20240301183219.2424889-1-peter.maydell@linaro.org>
 <20240301183219.2424889-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240301183219.2424889-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 1/3/24 19:32, Peter Maydell wrote:
> cpu.h has a lot of #defines relating to CPU register fields.
> Most of these aren't actually used outside target/arm code,
> so there's no point in cluttering up the cpu.h file with them.
> Move some easy ones to internals.h.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> I want to add some more CNTHCTL_* values, and don't really
> want to put more into cpu.h. There's obviously more that could
> be moved here, but I don't want to get into doing too much
> all at once. I pondered having a different file for these,
> but probably we'd end up pulling it in everywhere we do
> internals.h.

Yeah, have been there before :/

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   target/arm/cpu.h       | 128 -----------------------------------------
>   target/arm/internals.h | 128 +++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 128 insertions(+), 128 deletions(-)


