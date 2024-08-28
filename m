Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA014C7114C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2024 22:31:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjRBx-00074H-VJ; Wed, 28 Aug 2024 18:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjRBv-00073l-TX
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 18:31:04 -0400
Received: from mail-oo1-xc34.google.com ([2607:f8b0:4864:20::c34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sjRBr-0003CU-HO
 for qemu-devel@nongnu.org; Wed, 28 Aug 2024 18:31:03 -0400
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so17114eaf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Aug 2024 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724884256; x=1725489056; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xADMDLdOGAqMKlMRybIHzX/D9tLGG+KAZj1ApVp9YMw=;
 b=rOLMkV5qU7Mr2vc0ojxiAq4EuTc1bv4wisSWm/ZzOnIJM9KtIPFq0/PtfuIkSIkV7S
 Njp0aGz44EqOD+7lGduyu1Fmc6YhNEK5Gbr9BGS8PiRL2Itlk2gfJSftM1sVEh0XguGx
 jah0akz9sM2XDxy6mgPybQAvg6O7N45N9+fTofTGUfqRl4hsfRp0X2o14HCm3hqygLUu
 SBkGnI4ndyLaeEhonn6PLOiSzh2yBc7flyIeLVOWTZWqxiu1jd209wPU3tFJ2YhEmZ8Z
 PY/BSSbZhvdW+UiB9syPXEdZtaf0VlHH4bEiSxWgcZAzqOiktCAGih297MlaEzJrlVxp
 AIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724884256; x=1725489056;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xADMDLdOGAqMKlMRybIHzX/D9tLGG+KAZj1ApVp9YMw=;
 b=c9OvsXI4kIPXVL/a+SAbvY+fFlOL1MbuRmpsq26O2OHAeXZp5FFoSL2LUIjWBP9Iyi
 5XWkiXYSfeoCdITR6kUfywOrjEpGyYX+LV2N9XYcvfswaaAX4NrVUsYoCCCLnFe4vEOU
 P1qDzR7511MNyAi5viXj/2mDDCkyjKDvk0w77rIsp6HHNg193QGv2nEJ5IF1K9MpHjaB
 sBA/CgHPWeCA7fcxsI9a5CuIf1vAoy9xMtagDUaz8JrAh6lZWuarJCu1yNgGY+RCXA8S
 6Hlv8tUD2sBbkN7sJw5rmjEiMtYrH2VIATMtjMyesPWlpOowKgtiqpZcV6VDtCAGrFzn
 a+9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWrXJf+tsukH3Xdv3MIBrf+ho/eEkBSDZxvwyvCFPHN+g4zSjtOCBRf8Tc7mbbHdapD5V9WuZvV35/@nongnu.org
X-Gm-Message-State: AOJu0YxO54YkaD2m9gIsKFu86jTOdcND/4xxekEp7jAu2uHCHTe9osEF
 TmTtRetSntdF4l7z7qWooA4jY05rsAO4a24NEOKkesZORImcHw/GIWhcJGnGv08=
X-Google-Smtp-Source: AGHT+IEAozg9MXQ4PH8UTSZUIgC+kY74ox51SoS6IvWxhRMibH8NpLHr1YqQYL67nLh4bT2NLK4nKA==
X-Received: by 2002:a05:6870:240d:b0:24f:d178:d48d with SMTP id
 586e51a60fabf-277902654f8mr1139102fac.31.1724884256419; 
 Wed, 28 Aug 2024 15:30:56 -0700 (PDT)
Received: from [192.168.98.227] ([172.58.111.246])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-273ce9e3ec0sm4045245fac.18.2024.08.28.15.30.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 15:30:56 -0700 (PDT)
Message-ID: <02ff2d1e-d5f7-4e98-9758-aa39f58bae6b@linaro.org>
Date: Thu, 29 Aug 2024 08:30:47 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/1] QAPI patches patches for 2024-08-27
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <20240827103532.799039-1-armbru@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240827103532.799039-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc34.google.com
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

On 8/27/24 20:35, Markus Armbruster wrote:
> I'm nominating this fix for v9.1 because it can only affect generated
> documentation, and CI should protect us from surprise build breaks.
> Feel free to delay it to v9.2 if you think even that is too much risk
> or simply too much trouble to be worthwhile.
> 
> The following changes since commit afaee42f777bc359db95f692804f7fc7e12c0c02:
> 
>    Merge tag 'pull-nbd-2024-08-26' of https://repo.or.cz/qemu/ericb into staging (2024-08-27 07:06:42 +1000)
> 
> are available in the Git repository at:
> 
>    https://repo.or.cz/qemu/armbru.git tags/pull-qapi-2024-08-27
> 
> for you to fetch changes up to 43e0d14ee09a0565adcf4ce5f35be79695958fb0:
> 
>    docs/sphinx: fix extra stuff in TOC after freeform QMP sections (2024-08-27 11:10:58 +0200)
> 
> ----------------------------------------------------------------
> QAPI patches patches for 2024-08-27
> 
> ----------------------------------------------------------------
> John Snow (1):
>        docs/sphinx: fix extra stuff in TOC after freeform QMP sections
> 
>   docs/sphinx/qapidoc.py | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

