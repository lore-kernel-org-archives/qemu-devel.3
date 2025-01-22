Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD71DC0218C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:03:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUlV-0001cp-KP; Wed, 22 Jan 2025 02:03:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUlQ-0001cN-UC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:03:01 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUlO-0005Xj-Fm
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:03:00 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so66940365e9.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737529372; x=1738134172; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHrZ66LepaFE0FBEbBTQvX0yn2KYf68GYDha8yIrFLY=;
 b=qKPDdjZxxxNqCLpS+is7ha9pEAIN1+92RIRk0Lpj8zttiUts20iZPKGMQQLY0p6asd
 6jSq8D08cVzvrvtSPWXJcMeEwaoJhnwsmOs3v/qSgzj9Flrj1MifV3jO2ljfTJrBayrZ
 Y1zMMofxJKjfG+C0KAJIQDMi5jmtzUwAxm6VtMhPpztaOOxUBuOZj6qiI67cusVHVl/c
 BA6f2jFWxI9caezTSEvHIsxUPfc6X/6dTaPOirxNCbKnMM1sE79GMjyzEMmnb1SaMKD7
 vTF7F4JRJUn73PZLdA1Grsje0w19ryi7j6vMKuSq+FtQNFl6Xs8XQlSOB4Hn0zGyXC+A
 80TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737529372; x=1738134172;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xHrZ66LepaFE0FBEbBTQvX0yn2KYf68GYDha8yIrFLY=;
 b=VDTyJwDvRzLyLQ1Wvzy7/3JYNLx+XCxUj7xgpSILirEfjDfsNbmVRkYXabR8xZi5Wg
 7K52okFX5xYxNb2Z2bBtYBPiul8UslEpnZGDHGnEU/62Q76NkehNzmkrYiRlUKbGblxv
 WGShGKoyLFBqXyhsphViUZwrjZeHPEGnjW9jHntfmmFsqzizXVaO+u+1OVaGs/HHyKTi
 pUve8VJKcvP2sYZVS0Xr1ZvF0gF9IExddR1ZRR39RfUvoXu7EbRkCQ3kkqtVQ5UddVA/
 FAwIrguEB/1oELFFhikvV0mDFJV97MwOkKJvp8/XDH1yrQZS+31kT4AwFHa8r/7IH8qN
 Pc6w==
X-Gm-Message-State: AOJu0YwRxGVSugKHKT0Nm2TuXBb+8L1jyYGQy/d8+2dZjLws8cm2k7lS
 yEf1XrrBMCrnVL/jgNRLa2RMlPSv0V5p9AXrFDNpOrx0b7gMKVw10CK/Bx+uppD0Vz2BiL3glTt
 Grac=
X-Gm-Gg: ASbGnct2Et8w2wV6e05GXFiVsknJbxQRZ7/oS3ZA5R5E8y9RGzmLiE7+A+4KWsaJtbk
 F+iE3NhWzyFkW1NmqNy9k4kfrq02wnFWftMGlfE7828sTcTgMvGJdvmmBxPyXVAzteipsGSo0l2
 8yCxjmxFC0iCfwL53sNEELnA+jIfqCtB/r4KZAyAShTtnCXMvMowLkShYWqNv1w2sCR49O8hJ3V
 8iqWnamb5HU+tJYYvc/NkFzBslvmZsJ9eYPMWH3RW+328Gq3/9GPEBKJCtSfRp/9zZfh2cBPq3k
 RTjwpO4d2G9lQPjB+612maKszOeZPLOITzfZsg==
X-Google-Smtp-Source: AGHT+IH4YQX6qBdLA6G6Cj7eFlm14eJ1Rouyrp3nU6SJRlBwsGFhiIRKfwCzh2yzf6+4dkuEy1drcw==
X-Received: by 2002:a05:600c:3b0a:b0:434:9c60:95a3 with SMTP id
 5b1f17b1804b1-438913ca93cmr202971415e9.11.1737529371668; 
 Tue, 21 Jan 2025 23:02:51 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438b31b6cacsm12594855e9.26.2025.01.21.23.02.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:02:51 -0800 (PST)
Message-ID: <a6b184bb-bfc8-4cc5-80b3-5675dc4dd16d@linaro.org>
Date: Wed, 22 Jan 2025 08:02:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] hw/ipack: Clarify KConfig symbols
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, Bernhard Beschow <shentey@gmail.com>
References: <20250121155526.29982-1-philmd@linaro.org>
 <20250121155526.29982-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250121155526.29982-3-philmd@linaro.org>
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

On 21/1/25 16:55, Philippe Mathieu-Daudé wrote:
> Split IPACK Kconfig key as {IPACK, TPCI200, IP_OCTAL_232}
> 
>    - IPack is a bus
>    - TPCI200 is a PCI device providing an IPack bus
>    - IP-Octal232 is an IPack device plugged on an IPack bus
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/char/Kconfig                | 5 +++++
>   hw/char/meson.build            | 2 +-
>   hw/ipack/Kconfig               | 4 ++++
>   hw/ipack/meson.build           | 3 ++-
>   tests/qtest/libqos/meson.build | 4 +++-
>   tests/qtest/meson.build        | 4 +++-
>   6 files changed, 18 insertions(+), 4 deletions(-)

Missed from v1:
Acked-by: Fabiano Rosas <farosas@suse.de>


