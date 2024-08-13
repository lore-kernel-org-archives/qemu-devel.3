Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFCC52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:01:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjeM-0007Ny-IJ; Tue, 13 Aug 2024 01:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdje3-0007E1-Kc
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:00:32 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sdjdz-0006bg-NZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:00:30 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2689f749702so2811866fac.3
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723525224; x=1724130024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vxcTuB//eg0sBxa1utyJ6QZN+FWm7fFvJCs8viJvgeU=;
 b=MpZ21KQYUcmREsOfwsRXLcTUeoxEIGXc1lmoL/GEhuVqbnM8zO+lEYJ4NWCpsm0qn/
 jS5DuAChphSOIY/cJXOYEyT6/GKVYoyqeDfhrZONeTNJb3DvHTt5Ld1Nu4cSIy0XaICN
 fuYuzV+MitKgmq4xiiZgDwNkwXoh0Gcw7nVbclEtJODkjOrCAwd3R1p3659AVcXy9p8l
 2oQRRWTziTkeGDJm20HrO+yfkrdUofhyoBgzWYFhtEePSwtEvRgqy8TQMk2ekm5aKJ5i
 YDYyvg10zU3hQ9nUuN80S7Jh/WBBt+igmt59ZRlQhpankzdkGdUoAnuMJTCY6cNQriIm
 dSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525224; x=1724130024;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vxcTuB//eg0sBxa1utyJ6QZN+FWm7fFvJCs8viJvgeU=;
 b=Cl6Rtvjm76mmbCGZPbm1DD8qP3HUPrvSkD61ltZVgt47QQo3QUvXhR24ZVRVWNOq6g
 mufLOOztc9Y1Fol5bmyb+ucs4qq6IcLIcFZXJzby9wcPkQ/evhtzL/DSRWmfCDsE05Mw
 L+abU8RPHwBIEZXZQvlyyRqOhGMG3JF53KoT8whRSq2jHm9kvrZbb66GQoOFlWbaHcyb
 hYWv6RIkE7PWRtSq5/GHGHNf+IhR4UrDnqSHRsvtw6yAIfZ7gXq/sa6kToRW4IMgPbXo
 LQOAxNLhbErvrLM5hxUpF5V2t+6Uls4XMqFC7/AVsy50OBzhTYKA5AAQuV5md2plB/ei
 G9Fw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkHUSvPc6m8MdIiDMQrKMT7scpsC+zKkn/mdFmMy88EnExXXQhkZu18HzlG6Kzl7nmonMRvOL9rX6azKs+0/YXiOr+pao=
X-Gm-Message-State: AOJu0YyxV9wQkNw4SAYVmfL1td4hWHfTmFmcX1eCW3F9EF8FJgziUXRm
 mS7LBm0dR2txSrproLaXpWAZ43451iTSN2EvTnejI6xmmYuFSstcG+wED5+uqkU=
X-Google-Smtp-Source: AGHT+IHweCra3vISDCBRIe+Jp2yYZ32oJicYUD3W86jgR+b2TAZfKyOnB1PkLPvIWlJ7XRRbG+UpbA==
X-Received: by 2002:a05:6871:5827:b0:25e:b999:d24 with SMTP id
 586e51a60fabf-26fcb398fbbmr2874137fac.0.1723525224426; 
 Mon, 12 Aug 2024 22:00:24 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5ab56f0sm4831179b3a.197.2024.08.12.22.00.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Aug 2024 22:00:23 -0700 (PDT)
Message-ID: <6b1dbb73-386f-46b8-85fb-9f97c3fcd469@linaro.org>
Date: Tue, 13 Aug 2024 15:00:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/10] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20240812121021.1667713-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240812121021.1667713-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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

On 8/12/24 22:10, Peter Maydell wrote:
> v2: dropped PMCCNTR patch
> 
> The following changes since commit 0f397dcfecc9211d12c2c720c01eb32f0eaa7d23:
> 
>    Merge tag 'pull-nbd-2024-08-08' ofhttps://repo.or.cz/qemu/ericb into staging (2024-08-09 08:40:37 +1000)
> 
> are available in the Git repository at:
> 
>    https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-target-arm-20240812
> 
> for you to fetch changes up to ed5031ad5d4c4c3b6eee6ab21aa95ccfc9dffdd4:
> 
>    arm/virt: place power button pin number on a define (2024-08-12 11:40:16 +0100)
> 
> ----------------------------------------------------------------
>   * Fix BTI versus CF_PCREL
>   * include: Fix typo in name of MAKE_IDENTFIER macro
>   * docs: Various txt-to-rST conversions
>   * hw/core/ptimer: fix timer zero period condition for freq > 1GHz
>   * arm/virt: place power button pin number on a define


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

