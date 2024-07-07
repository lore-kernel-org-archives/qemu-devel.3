Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3199CC3DA44
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 20:23:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQYPV-0003pj-PM; Sun, 07 Jul 2024 16:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQYPU-0003pE-1g
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 16:23:00 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sQYPS-0003bp-6x
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 16:22:59 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-652fd0bb5e6so2154492a12.0
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 13:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720383776; x=1720988576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lk/O7wDD/7sHPGr13gWZQbjDvJur2ZHfkRKeMxGuqD8=;
 b=DRr9W0rfITjFS6O8UfDuYAVJV1mfmGf6KFovfhZKUzttWb2GOaskF12PzdIegFFg0E
 Yt6buvPafybHgrfq8NRjPTingcnmIekQ5x+kCi26Y666MbBtUV6Okn7E2pHb6KRo73mu
 lUZXQ/Jnq70x5oDU0hC3HTm/uw4HkML+GhIY5zeLnBjvNbGeWph6a2uoKAUM/d2iOEaV
 LCFPIVf8HEgFmA4H+2NQzFdsZ+BR8z6q9tdhtaz5enO7s+QYt7YvS3JhSDNH2Q/pIlaS
 Oe6NXBD+2ZiLIhbHc3maQGvn6kzaPRZqcukfH9HQRWEM9bcBf46ByztCFVpZgoF5IhNn
 Fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720383776; x=1720988576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lk/O7wDD/7sHPGr13gWZQbjDvJur2ZHfkRKeMxGuqD8=;
 b=m+lqDHquJGDVjFRVHZq/JrwOUBnItrKa5PAI38O33TTrr2XxkCTt2ZT2Fbc8/h/y3U
 GyTYxcqJJ12ClPTSWoryOBp/E6VJAwTk92l0KvrUMQDtBWvczV1fJ0+YVKnWHivhvOWx
 hodN8YEReLWMCd9w2jljk7vIzIqF27RoMyAXtUQmx3JG3V85lo0ATZCHV4td/97f6kiJ
 ffihIq2Jr5b5exwwg1LVuRjRbw8YFrz2tAkIb1T49zdshSucHNQw2tocSdN/0pLh/N4b
 mZb1H8DZhtkdlBJ+JV439BZwSc//CFy47MgmRm9gVNH04zB58kbS8u+1JW6Lw+cKQB5G
 0hlA==
X-Gm-Message-State: AOJu0YwaKW40744tMuf0IGmbaX5swruw7H2aK2O94DXPaJ9F7IN95V2D
 n9e+I9Sw3EBLHYHOqluWUmVGXhgolJciaCDlQtMSRJvNWaw8m9dVG1y7nnkEwN3o1Wn9QsczZIp
 XYKA=
X-Google-Smtp-Source: AGHT+IGxOKx8GU4NxQyUtGqjEjftvxsRceR/80Fh9tTG+6uQmQuysYgng3crO1CoGUTuI+klXAdokw==
X-Received: by 2002:a05:6a20:d48b:b0:1be:e1e1:d5de with SMTP id
 adf61e73a8af0-1c0cc88ee94mr14245814637.30.1720383775969; 
 Sun, 07 Jul 2024 13:22:55 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a92c27csm6764469a91.12.2024.07.07.13.22.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jul 2024 13:22:55 -0700 (PDT)
Message-ID: <26f31338-72ae-4073-8cd1-090c9c99b031@linaro.org>
Date: Sun, 7 Jul 2024 13:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] SD/MMC patches for 2024-07-06
To: qemu-devel@nongnu.org
References: <20240705220435.15415-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 7/5/24 15:04, Philippe Mathieu-Daudé wrote:
> The following changes since commit f2cb4026fccfe073f84a4b440e41d3ed0c3134f6:
> 
>    Merge tag 'pull-maintainer-july24-050724-1' ofhttps://gitlab.com/stsquad/qemu  into staging (2024-07-05 09:15:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/sdmmc-20240706
> 
> for you to fetch changes up to 0bcea3f74b04cdc23ecd6822bea7e46a55eb4be7:
> 
>    hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD (2024-07-05 23:55:02 +0200)
> 
> ----------------------------------------------------------------
> SD/MMC patches queue
> 
> - Use published card address (RCA) in qtest/npcm7xx_sdhci
> - Have cards use random RCA
> - Use SD spec v3.01 by default
> - Convert GEN_CMD to sd_generic_read/write_byte style
> - Extract SDMMC_COMMON abstract QDev parent from SD_CARD
> - Few housekeeping

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

