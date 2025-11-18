Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EABCEE347
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 18:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLQIS-00025w-Ug; Tue, 18 Nov 2025 13:19:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQIN-00025N-0s
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:19:16 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vLQIK-0007nb-Uw
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 13:19:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-477549b3082so48144285e9.0
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 10:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763489951; x=1764094751; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m2o/vzhdbdBH50L3PVVu18xCzUtmD1sqotZMWevcjPA=;
 b=toKOrgrbeI3yIkjaoLBGS2P31KumArJj+kCRhtHS5tZDGSqPtw62u9eNLscrpECUAs
 SmFWCCvk/SPB38DdK34okZ6YSBtlI1RiMpdhgHODcSOHYtNDWdrOWW2pt8fveIWJy1jH
 3i3U8jx6WOdtGqUq06e99ADoRdnCvVSORrkzuLbOJQRqsQ8TwGE0GV28oYpT/pDD5T3M
 6qgM6FqYA/e3HltZnsWnpBwOr6XjDecGDKIbu2NjGzbIRze0hqffog3lFdocGp0Qxjr5
 KkrGdsegveiXYCshCDfhquGC2820unLcHrkiLqcYbEyl6YmxvHkXvlUR5lHM0NmWjsDG
 ZpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763489951; x=1764094751;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=m2o/vzhdbdBH50L3PVVu18xCzUtmD1sqotZMWevcjPA=;
 b=QD20Bpd7gwqXXfbhI/R3t8E7T6vOvDboNCA6QUM7aEgBP+k5ShrSFrOmQdTx7diPWx
 Zlc5Zd57nlWJiPsAwCxkfiMXUeXosgETboLmJWOffOZl99eIYUao7TmdvWz/zRKvSTlo
 LK8U04mVRU5kU29rv4prKC7kfyXNKT3yNxehUbzIFAO/sUJMGW5qvvaQqdiuwei61CQ6
 vkDhBD5wEixMdAK79ncO/OqzXnXnT8/KJDt3/pDpzyf4YYqVKrVG9vPKukV/AqtSs9j7
 wr2Q921hly3xYF5Yu0c+o5BAUpjd30kDkBbjBf1ANM771R2VVRL0sYlFrFoCAY5xoPT8
 oJFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUet3QZe8qqeTQ5rK/QkJP3IHWKnK4ZPlQ1g0Iw9/tY7jj+GQV/ZNBwNdX9fn6kD3Nfd6ir9L5GsXuy@nongnu.org
X-Gm-Message-State: AOJu0Yxl6tXwdGciBtGVRgtV79Po3jPb3WC6MyCE2hYnPwSnL8LJBJs/
 ehm9Q9Mg73ZIYNtpdCKM08KMXx+mvkxISoBpK/9qmCeSyOM+prkKh9YoJw6tkYOIW9QMxvM5XDT
 HK9cp6yIuhtQv
X-Gm-Gg: ASbGncs0LCZ2FrPy5jQN6G4s1vd7v0DS+3rUmlL6ks4Z8km/CMT+wEwM4hoDYBzWaft
 Psx8fgL4Gq0JGW/15bOg4geUz4TtZ0qX38rsoZDyUe6qUiq+hLnO8UtdGKdC8Myyvu1EhEIyeNr
 2Pm4V4kiT0xWMBDGlkeGjhXE9I5aIp/rY7dISrGxaz6Mr/tGdcy/tLKWeFT0PLUZaALBIRhadF4
 9Y9qTvzlwa/eGlkJseKhKOIYWkYYcsMWlGAI5WgSEFWRs5+Wkqh06BjapXZvBqqNbomfOmuTcrd
 jA/KTm0qkSr7/vr1kfLG/7EEMUtFl6FG5Ofsvd8DCkK5LQEdWbz45+UJnH9ngHk/8PKj7TmyGVX
 4rFSK3nC0PYIQW5BExzwOV2ta6VhC3YzgO0+6btuTOg0W4AWK3o4RcXTDH57fGl+vE1CyrVtele
 11i4sq4VRhSQXahKS5461flCFoTGHMTZBGuo9VQq1KAR9Atj4ebL+wrw==
X-Google-Smtp-Source: AGHT+IEqiqXw6cb7TD6NSdvufBkOc7/Kd3eCb+47iRwVheMFRZRNHbLza8+v3cVfjKm0LmchOUZiRg==
X-Received: by 2002:a05:6000:40cc:b0:42b:2c53:3abc with SMTP id
 ffacd0b85a97d-42b593414d2mr16909383f8f.19.1763489951245; 
 Tue, 18 Nov 2025 10:19:11 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e91f2dsm34514988f8f.19.2025.11.18.10.19.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 10:19:10 -0800 (PST)
Message-ID: <2ba57b1a-09ec-4fb5-9d2a-cc209134e746@linaro.org>
Date: Tue, 18 Nov 2025 19:19:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/sd: Fix ACMD41 state machine in SPI mode
Content-Language: en-US
To: Bin Meng <bmeng.cn@gmail.com>, QEMU <qemu-devel@nongnu.org>
Cc: Tom Rini <trini@konsulko.com>
References: <20251110110507.1641042-1-bmeng.cn@gmail.com>
 <20251110110507.1641042-3-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251110110507.1641042-3-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x344.google.com
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

On 10/11/25 12:05, Bin Meng wrote:
> In SPI mode, the ACMD41 argument only defines bit 30 (HCS); all other
> bits are reserved. The current implementation incorrectly checks the
> voltage window bits even in SPI mode, preventing the state machine
> from transitioning to the READY state. As a result, the U-Boot
> mmc-spi driver falls into an endless CMD55/ACMD41 loop.
> 
> Fixes: 3241a61a ("hw/sd/sdcard: Use complete SEND_OP_COND implementation in SPI mode")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2945
> Reported-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> 
> ---
> 
>   hw/sd/sd.c | 23 ++++++++++++-----------
>   1 file changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


