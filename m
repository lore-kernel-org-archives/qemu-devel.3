Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D00C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2024 02:41:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0BVs-0000kz-EV; Thu, 25 Apr 2024 22:40:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0BVj-0000k6-Ri
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 22:40:28 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s0BVi-0002Oa-BS
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 22:40:27 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1e3e84a302eso13391975ad.0
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 19:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714099224; x=1714704024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=04X97xNqXSjQzBtq1kBERIfdbPW71UeGhld/nCtJCPI=;
 b=Ib18yg9WR2tzksSkh8F/1JWlPwggF1rE3cHIZGzU+la6uyooQQ5IbRkz7PV2Rm6cx9
 az9hGvEdm3Yl1/qTV2prE9jhwilqYUM2TT59fFrm/MoM9WVFM1iac1tWjc2Y6J3uQtPU
 0LjWX20TXER9E0VKMIeBsR+OlEl5xyCa0TALZtYNRISb8mQIT4sXVLunMpogIpt82TaC
 AU+QyF6X2HKyMeS782qRXvh6NEzv+9eiB3JhEVVelvW3DAiI2u76Dpwvme7mCCVpnQ8A
 fqRhOZ79YuoHtGMHerI8e3DB+wNzvLoLbWTAX+PvgOMAjhcF5T5nv8DCM17S9c2wUqOI
 PkhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714099224; x=1714704024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=04X97xNqXSjQzBtq1kBERIfdbPW71UeGhld/nCtJCPI=;
 b=G3pOJdyO9RL5nrSbRLcP7o7T+O2owAV/6RANPjTyiTWGXYxGVI81VzBbdVHeTxi1nB
 1WI9MCo2Q361xfPB8jyV5+Icl5VU14Cg0Mxa4hem7nMsS88T+zj/ouecplTtk/GWlOJT
 UwG4gk2ysM9xcvr42hxihugbIxPp7QW3adJbY4W7pObcdsZGWFUd5iM4fK+TtVVD+6Tk
 0XMHxTByZVjkRtZ/RwsbRlFEGoqXeKNLEBTTSdUV+55xrNroqdqOMcMI53oK1vzbbv1J
 VZrhSJ19sEbrTL79Q/ZdHNlfgeP201INqfouqrPCQPpKUfiB8bkXG0gclzTho0XuTZ4m
 PZMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5bgdnfOGe8lFgjgtQiBAIJFHyLGW2RrlaDHyhVR+/letHNi7v9eXHU8Ji/eNUkYQKx2FIc/ai7Gg1txFQjBwzWzJb1gk=
X-Gm-Message-State: AOJu0YzvOwDmUcNGWHoQjVHszqtm3OdnOkRInjPpwLASpts9vqJgSySr
 d36QSKwoMuua3JwoNMjs6jfs1HJtXfJRUzgTpxWVoCAutr6/922KJycJIY6ZarU=
X-Google-Smtp-Source: AGHT+IGEOMSc1UVGwLZcuiRcQ8qJmOQII0YLsODKXUU9I36/uI1Km5PCSuMhlJT3a+9Kz8sxDpuJxw==
X-Received: by 2002:a17:902:6b47:b0:1e2:a2d7:9f5a with SMTP id
 g7-20020a1709026b4700b001e2a2d79f5amr1144690plt.65.1714099224183; 
 Thu, 25 Apr 2024 19:40:24 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a170902e55200b001db5fc51d71sm14510997plf.160.2024.04.25.19.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 19:40:23 -0700 (PDT)
Message-ID: <5f9b23d5-6552-4b29-83f6-04809512bbad@linaro.org>
Date: Thu, 25 Apr 2024 19:40:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/22] Misc HW patches for 2024-04-25
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org
References: <20240425110157.20328-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/25/24 04:01, Philippe Mathieu-Daudé wrote:
> The following changes since commit 85b597413d4370cb168f711192eaef2eb70535ac:
> 
>    Merge tag 'housekeeping-20240424' ofhttps://github.com/philmd/qemu  into staging (2024-04-24 11:49:57 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git  tags/hw-misc-20240425
> 
> for you to fetch changes up to 098de99aad1aa911b4950b47b55d2e2bcc4f9c0c:
> 
>    hw/core: Support module-id in numa configuration (2024-04-25 12:48:12 +0200)
> 
> 2 checkpatch issues:
> 
> - one spurious:
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> - one deliberately ignored in a python script:
> ERROR: line over 90 characters
> 
> ----------------------------------------------------------------
> Misc HW patch queue
> 
> - Script to compare machines compat_props[] (Maksim)
> - Introduce 'module' CPU topology level (Zhao)
> - Various cleanups (Thomas, Zhao, Inès, Bernhard)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


