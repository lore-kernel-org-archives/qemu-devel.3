Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D4C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 04:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLxp5-0001fB-Af; Tue, 25 Jun 2024 00:30:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLxp2-0001dI-Tz
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 00:30:24 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sLxp0-000369-94
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 00:30:23 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-37636c3872bso11670295ab.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 21:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719289821; x=1719894621; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MevDkSwh/hK42NLzDU7PiIgkqotpPKvejuToxDUDioM=;
 b=Mtfbv1ppve2+MG3I2Gdok1SoG59CBlqmPx48ug3jO9WYUOXWhc/U/VRIll0MTcEnyh
 vpMA3/Z0oKuYbMO2i/oMU5CwxAq1t3X0ginCjWHPlGchfW+HBHovVEilBSUWCKO4IDXL
 JoutjwI/pBuVn7jPRT85r5R22hAD4nKtSGN4dikJjsJd4iRK7K4Un3bNs9iA0VrqdT06
 YaRVFLHqtBpZTXz88gCvuf/db+39caYWY/1tiYKdazOy4hwFiz5ez9CJjMKiM267018Y
 BXLHKBjBi+5HtHmw/48x7z5mKylU9xUFkhRx4PkTrPAvjMhzPd9RAYP2OVr6svrs5wSJ
 ZIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719289821; x=1719894621;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MevDkSwh/hK42NLzDU7PiIgkqotpPKvejuToxDUDioM=;
 b=JByRfxKg/yhJuDP1OXN7V8y2YyP6zgiLSVGm/POYyiiL8Hzzqy31I4228lxfxSyRYV
 t7PS/XXrw4P9W7mJWVEsJDOMgwhTOuomiQnl3ASu5pkQHM8ImS++L+7DaXswytKIR0P1
 D+LqurAg5JggRnFrBmd8JeeAd2Cx7KHp7kNcYrowiwGwWZDYfefin1ygVKaZJcW/gWWs
 LQIDZfWaGyLxexsFEO9NTx+xfknQO2EdEGa3giO0WHGNuasukgRQ1fog2Ksl34z0Sw1w
 O/S/bD5TKOZNs2/qWoFpqky6gxKPTHffIOe4/fcWSq+0SR5kSxneWvnt2i4VI38LywTz
 lAIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsSZwXNMEWK97c2Hqdy4XQK+FoA6GZMTUCjgCdmP6mHAJAxp511UjGOGYDgAEI1Us0eeNZMAj3J/7AXrG63OwqZVfDalk=
X-Gm-Message-State: AOJu0YxOVATW3BpDK5eI9v/qgj7MmmUVlR3SWIismM+nvLOEv4el2mrf
 iexm3SoWyoS5EaG/2hv/uqAQKKvz1uRf0r1H4PvdWJCqDleNIvWA8HSsvQJt4HI=
X-Google-Smtp-Source: AGHT+IFUW4meVkbMdZaMeZYNvnBGPT8ORhVy/Y+oV+TDbvbWaQoks6md5VdWXMNiDBBZAlAS7nT/Cw==
X-Received: by 2002:a92:c242:0:b0:374:a412:3da1 with SMTP id
 e9e14a558f8ab-3763f69621fmr81987225ab.20.1719289820689; 
 Mon, 24 Jun 2024 21:30:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716b3ee8e1fsm5288417a12.32.2024.06.24.21.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 21:30:20 -0700 (PDT)
Message-ID: <25859d67-d2b1-4614-a2f9-b1eb1ca7c4cf@linaro.org>
Date: Mon, 24 Jun 2024 21:30:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/19] SD/MMC patches for 2024-06-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240624131440.81111-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240624131440.81111-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12a.google.com
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

On 6/24/24 06:14, Philippe Mathieu-Daudé wrote:
> The following changes since commit c9ba79baca7c673098361e3a687f72d458e0d18a:
> 
>    Merge tag 'pull-target-arm-20240622' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-06-22 09:56:49 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/sdmmc-20240624
> 
> for you to fetch changes up to 76ae9a231487a2b127c90bcb657fd42a1f6c06f8:
> 
>    hw/sd/sdcard: Add comments around registers and commands (2024-06-24 15:08:40 +0200)
> 
> ----------------------------------------------------------------
> SD/MMC patches queue
> 
> One fix and various cleanups for the SD card model.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


