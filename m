Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48D4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 11:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryrma-0002WF-Sd; Mon, 22 Apr 2024 07:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryrmY-0002Ro-3U
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:24:22 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ryrmW-0007IX-Ku
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 07:24:21 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-349545c3eb8so3195244f8f.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 04:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713785059; x=1714389859; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4zSmrIlgHV0Vw1AbLT6ZWFHT7n9hH21z64JC62MO0XM=;
 b=dz1xJgrFqcljUFDeDVRxm7oL71Q2uR5iSN/ZjWqStsiWu78ShAEIZaHsT49OIvhHU1
 8XbGJRjdcwuSbyRbTA8b3HAG+u3xPaL9tb4VUxplLTT8n+zK3C3dHcrAMOpIn1h30TiB
 Y2FVh08gFTIiw8e0GfFAJyXG9H09nehvgR/D1J6oau9c/+2vh8+vbTjF8HbjZcpkvMAR
 4kItR81CK+eH2PjP0CGymsqzdvb4OC51nQwGwTQRSoJAkK2/G7AmdTJrjmiLvkek4wgO
 qFHO8GF5KZapxtAw2ISyApnyoryVLNU9NSkmJdxVPpypTxyWzV+RHUwgzLz4TcEY+ACu
 JFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713785059; x=1714389859;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4zSmrIlgHV0Vw1AbLT6ZWFHT7n9hH21z64JC62MO0XM=;
 b=H8IJKLWgO2Kue8qEv7XSDlUQ/cPfapix6c1Qz37+iUxPYIq9J3UWKYMUEgUE0E7qzF
 G0G/Q+XT1XIa1BIPsmGnuFgeG1Yt2PeerQfzuIJf0bWQZB99N2/HlHqhmKL3Zv15yaWF
 m03uT4ALAbXzedbxgzXcchBbImojJQJcHVa/iJ2LFxdtTPXyWUaQ853xNL/sH67leYvi
 WW0mTfqbGmKtQq9dfzGKis6Dddc/k+oGQp3aal1X4FSsChIqw8HQp6elny1d6wwRn9To
 kSj5Vwh35EK4rMZ1d74O2fm5twhClxofCVBUj8W05qDX9MlGNk36gw4xQ+VYTPi2iICH
 pH9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE+9udxb0gA6Z98bjNG6yo2qTXe457BRfP0LI3dT/0uT0sX3E0ocvSCcA/CMd9RJE3GEOTbUuwub8aPxXsdJmR1Az/k5A=
X-Gm-Message-State: AOJu0YzIxJPcc5IGsV3FixjMk39UpWsxlXkMSG7cMVwCe0FudOjl08ox
 CFhjM6egOT63Fjz59XbHPk9CNLHiebEvNdA2C30O4To05cBQduxQxziSJ7s8LN6GuUKFgAvvjMr
 w
X-Google-Smtp-Source: AGHT+IHYZZCA3d6fzzXLMawgId24Ckfnz7efzP+BFGnls7lk0ZuLhUqMsuvh6+G+5Ge17Bmm2jugxg==
X-Received: by 2002:a5d:6901:0:b0:343:5cc6:647f with SMTP id
 t1-20020a5d6901000000b003435cc6647fmr5601554wru.21.1713785058896; 
 Mon, 22 Apr 2024 04:24:18 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 n12-20020a5d67cc000000b0034a51283404sm9310828wrw.72.2024.04.22.04.24.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Apr 2024 04:24:18 -0700 (PDT)
Message-ID: <a7763561-62b3-4363-8049-fa4f7bb44047@linaro.org>
Date: Mon, 22 Apr 2024 13:24:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc : Correct 5 spaces indents in stm32l4x5_exti
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, qemu-arm@nongnu.org,
 Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
References: <20240421141455.116548-1-ines.varhol@telecom-paris.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240421141455.116548-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21/4/24 16:14, Inès Varhol wrote:
> Signed-off-by: Inès Varhol <ines.varhol@telecom-paris.fr>
> ---
>   hw/misc/stm32l4x5_exti.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

