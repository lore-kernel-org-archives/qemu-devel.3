Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C1DC41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 22:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOmIO-0002og-6X; Tue, 02 Jul 2024 18:48:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmIM-0002md-VL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:48:18 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOmIL-0002X3-BZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 18:48:18 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-706683e5249so3225893b3a.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 15:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719960496; x=1720565296; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UBdhsnI9HauDjnTw6n/TjoDJ9XLCtCEClbGiz3PMxh8=;
 b=RDlEU2S/lUA+IeVGhthhqKM+N/KCRz6PmU8cph3ccRbC326MFZc1jeFgS5bw+Kmze9
 0FH8B5abLHhgyOoUBVc/ETyZszHRzMQEg01n8euDbLGbWO2VrJTDl9nDKW2Spg8CN2F5
 XR5CQA/jRQdyFJUSdjN0tuHNvaocmnts3cjM7hv72ov7fXiiTdcTFqgXhj7rep9M2GFH
 VJKO+nLXIoQJJpkZvU6APjtmw4bjbXvs00rlVFC941aefsEp5npLBduosT5JWQ1/qFst
 EoANRMmu/19IhUr7h96HQJpvWQQ0f6lIbIiu/Imrx1t+H0G42ngiy8VvH0rntHpYs7ye
 JP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719960496; x=1720565296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UBdhsnI9HauDjnTw6n/TjoDJ9XLCtCEClbGiz3PMxh8=;
 b=cYVf5RjxkL5hRocslMa+/d5AYrdGO7QsorLyFcPuXTVM9U7xfoCLXq3tnZciugnEFK
 x3n+vKk/NCHzbV8aWPeZQ0xCcQpNKvJwstu2909+r3rLKEGjQaT5le8L+BRj/+2VMLCn
 rT0cFCoO6lRW6wGevE4+15zy13B3L5n9oIAsxjfQka2OEYEuYqxDdogEqaxIunS5xFoZ
 KuqQPThyu/KxXjcY8KzBiS8kDccwYjOS8Y4cuGo52vkPOdQuyP0/gJsmTMa7tVWUleM0
 AlquhWrhd3bYdre3BSLFiQhRqilzORJNXzw+m3DqwFIidiM6FCzjDFuaRYRUmDF/QCqS
 A4ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZsaghE5hjkxoZnElEaxgXA489W5qCg/NRsSldhU91yxh22fOpaxJmgj55Q3JDRE0vto/KT4Nr0rKgsrB7AoGCwaIConE=
X-Gm-Message-State: AOJu0YwaHGt8Qa3LpgmUMlwvkScv1ZcdsFVrBLiEVWInjtHWKH78sGTq
 xSnpMz8AHgPPLEV9uGRW3EMswug9fs3sYFt2zPEKrPYBbZXHuhhEk/7h3C9VIrkvSCRNrd4kVbR
 0
X-Google-Smtp-Source: AGHT+IGIHCbMavIl5KiGJRfYxm/sPG0TuwJ32pxpoiEkLSF5ZDRwEj/TX4QhDzCp47MQPw2Nvtq/yQ==
X-Received: by 2002:a05:6a00:3d43:b0:705:9d7b:2b3f with SMTP id
 d2e1a72fcca58-70aaaf12af8mr9389108b3a.21.1719960495558; 
 Tue, 02 Jul 2024 15:48:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803fc98b8sm9359852b3a.97.2024.07.02.15.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jul 2024 15:48:15 -0700 (PDT)
Message-ID: <2111ad47-67cc-4461-a820-c71309ee4264@linaro.org>
Date: Tue, 2 Jul 2024 15:48:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/67] SD/MMC patches for 2024-07-02
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240702092051.45754-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/2/24 02:19, Philippe Mathieu-Daudé wrote:
> The following changes since commit c80a339587fe4148292c260716482dd2f86d4476:
> 
>    Merge tag 'pull-target-arm-20240701' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-01 10:41:45 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/sdmmc-20240702
> 
> for you to fetch changes up to 8442e1625ba6723bee2c6d0fdb7207a3e27a2b05:
> 
>    hw/sd/sdcard: Add sd_acmd_SEND_SCR handler (ACMD51) (2024-07-02 10:08:32 +0200)
> 
> Checkpatch warnings ignored:
> 
>      WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>      WARNING: line over 80 characters
>      #64: FILE: hw/sd/sd.c:2327:
>      +        [23] = {8,  sd_spi, "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>      #72: FILE: hw/sd/sd.c:2386:
>      +        [23] = {8,  sd_ac,   "SET_WR_BLK_ERASE_COUNT", sd_acmd_SET_WR_BLK_ERASE_COUNT},
>      #75: FILE: hw/sd/sd.c:2395:
>      +        [42] = {8,  sd_ac,   "SET_CLR_CARD_DETECT", sd_acmd_SET_CLR_CARD_DETECT},
> 
> ----------------------------------------------------------------
> SD/MMC patches queue
> 
> - Deprecate SD spec v1.10
> - Improve tracing
> - Fix endianness on DAT lines
> - Introduce helpers for commands transmitting data on the DAT lines
> - Convert most commands to new helpers
> - Register various optional commands
> - Add command {name, type, class} fields to SDProto structure

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


