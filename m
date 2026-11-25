Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D54606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=HlCBr9aV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFpa-0007K0-Pk; Wed, 25 Nov 2026 11:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpH-0007GE-Ue
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:33 -0500
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xWFpG-0005E1-4s
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 11:26:31 -0500
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cc147d86bebso3545061a12.0
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 08:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795623989; x=1796228789; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j9pGz37Z47SZLXQFLys1IVh34mi3oJgK/QTVw2Xp7Rw=;
 b=HlCBr9aVLkEs4H4Fn5K+duBywAYG5pINVlcWpcSYErv8AiF50e+xb1UnU5DZQep9e9
 qiRbJ2pe7Je8q/MT06pYikyPrF32372N09D7nPJh+Pp9D+IkPSkfAmXIIoiJZQRRQE5P
 SMBG3bLQAQ3Q01aIGvkoMX6owhmD2xDVz+1c9q6NyYuU3ACCgYLa6vu0dnHmtHVY9QhM
 COcFM/Fq8OGPy4ZBXtosOL6N0kyvysAmoH6PjEXCMZNDHjFb1spYSVcmowd5uIQ3aitq
 68/Etp9TkOUlzXT9pFdvjH7Of/TdvcPdc/TUBSeM7SlxEGEnj4xsiUo8M8xkzxcaZnlH
 OhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795623989; x=1796228789;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j9pGz37Z47SZLXQFLys1IVh34mi3oJgK/QTVw2Xp7Rw=;
 b=bbb8h1Tn3XcgrwNkXhYoGLTrz9/1hDV3eb/2IZc8hCRkNiveRFTo3y8sI+6w4bmA1a
 +0B6xe2zi3WELFtB7VhwJcvLWB7WOD2Ms1yLPAo2/iQi17t8CUaMdBR79oywH13ANklD
 P8Wf10jYMUlZ76LbxIWBG6G3aMsn4eBGb8dyGgMxUsgdUP+IP+nPVxguknDHTBTMSQdy
 Flf9n5tYtJb3rHbhd5o78NYvsvGZp3ZNTkv+noHroWKKXBl6yXUauF05ZeetWbZGr9Rc
 1GBnDXFp13B+YJMNQ9CQoxENJAlsj8EPienMxK1CRDRXTDJVfzXy43CE43UHWBhCoDnq
 d7JA==
X-Forwarded-Encrypted: i=1;
 AL+hErE37tOhUdB1lgHHGehQh0e+hxsiR9YIIqPoHJt3b3UdMlDyooMg23Z1HQosNjvAm5FlttLSFuf2cp7T@nongnu.org
X-Gm-Message-State: APuU4Z/92CnjKUQeJKiMiidq9A1Y3m2F0AvfNCn8W3CKOMyetDBUnAON
 EUlzylNk61Cu/xRTPI5EmITuVlR83ollvgLuwDtxfn8g04BXCr0OohyVieZcXZdLb3s=
X-Gm-Gg: AZFdTZeOulv1d1rS0boJ8ZbrApkHPK3j7RPTRqgQwaCAEHplOaK3zA27I1vfeyaN8Rk
 di+5pklAa7Rb/duP+k9/XHbMztZg5o3OmflZIFybEQjiUrsZO2kA1BD6sMIqcQkiPGPyHnnwIxW
 Wo6nXTkPGQ1sXzwFDTPz/0h74jwMfg3kpsXRAxuxQMWXE1iJgmMKnI9gim6TRvAP110xg5bYmEa
 FcVtaTnwFQIUqJy/a0WRKpuCDyKOU7seCBz0XCFfJihjev4+zp1a2XGo5b5NcspFeKT6WoylhE9
 nF6Nt/6hY9hgqVpoSu3UsxaM3B59wJKft3QUPpYLPhCkJGHx/PgCFX1xHZSWhWZ5ER1QT3oey33
 B6U2rUGmMCUGgiZwNwunpevo4/6Mr+1EyHrgqxgXHhOAqqrIua2WiVaRpu/ahHX/aVf2InY+cBw
 zdiW8cB37WwOu7X5eFf3hnXIhYcwF65uzcrPKVwdr1dNsRc+H247Om5yGJm5/KiiYhTFai06N4a
 Q7RKncrl14/eKH3TXwqxohd9/OfBBYzu3Mqardlojk6IFVv8bWzJJoPnR0kYEoGy3ll0fFAJD25
 R5/n2suC7TLKxF4Mc03ggdyQySWd71aAz79R47eaC4U=
X-Received: by 2002:a17:90a:c10e:b0:3b4:1356:5c66 with SMTP id
 98e67ed59e1d1-3b41c8df703mr12665718a91.13.1795623988354; 
 Wed, 25 Nov 2026 08:26:28 -0800 (PST)
Received: from [172.20.3.121] ([156.19.246.27])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b405ffa98esm31100275a91.17.2026.11.25.08.26.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Nov 2026 08:26:28 -0800 (PST)
Message-ID: <1b20738f-da17-4b36-b687-ef2e5be8aae2@linaro.org>
Date: Wed, 25 Nov 2026 08:25:41 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] Misc HW patches for 2026-11-24
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
References: <20261124230917.88704-1-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261124230917.88704-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/26 15:09, Philippe Mathieu-Daudé wrote:
> The following changes since commit 6bf90d4fc5027567cb704d7888f5ec792b4ed75a:
> 
>    Merge tag 'pull-target-arm-20261124' ofhttps://gitlab.com/pm215/qemu into staging (2026-11-24 07:09:41 -0800)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/hw-misc-20261124
> 
> for you to fetch changes up to c3800302668ff745e10b810f12723eac7068abda:
> 
>    hw/ppc/amigaone: Invalidate TBs on NVRAM write (2026-11-25 00:02:01 +0100)
> 
> ----------------------------------------------------------------
> Misc fixes for 11.2
> 
> - SD (card, controller)
> - VMWare VGA display
> - Parallel NOR Flashes
> - I8257 DMA controller
> - IDE ATAPI layer
> - Amiga One

Applied, thanks.

r~

