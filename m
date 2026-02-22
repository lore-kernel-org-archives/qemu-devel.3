Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB37FC636B2
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 21:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuH3b-0005SP-1O; Sun, 22 Feb 2026 16:32:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuH3Z-0005Rl-Ay
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:32:01 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuH3X-0004tz-UL
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:32:01 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48329eb96a7so20384275e9.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 13:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771795917; x=1772400717; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Rn2rO8jJswLS/t/Dr6eFLxD3NkZ038wxEV/XO69NTmo=;
 b=WxPXjbV1NFV0JV6wZRoO9afQtP10x78pPNZILKka5aDGfjdyprYh0AxnFfyKXWZ3Mh
 JVGSxPwhwQuTRyi9vRtovA3+ZNiaaaHTYBJ6NhXB6ddNsWoCNUL0xC2LfMKrtYRwCB/Z
 y3ONZVeoybjt9vXp7U4CZftA8GBQiG5y7TfPK0mVTkMT8mBfXDy1fWQeUSiCrRu24h6j
 1gepbWgPkmNCZQexSqsgwSR9AZP00FoERblTzBjNS4GCsAIHJlqGqLaaDQtwuqsMyyWK
 prFta9kpDUpsrpRVYN1ys6GbwrdeS1Jp3dxUw0159VMHB2X/3aBSLabUUbtGiTLmkENg
 G2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771795917; x=1772400717;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rn2rO8jJswLS/t/Dr6eFLxD3NkZ038wxEV/XO69NTmo=;
 b=LbZlB4aIFj3rpBNmvQQf6bbSfLXrrh4qbVDlumPPEU/3/+yRfjdmZUfFLJdnfB//1v
 m1iP9mFdoiXIkX2bKirbyadaHeZFIELHUbZEfbwQjZHamsDDdKtTReUBvbzIENsv+Dbx
 e+LTJF485GIzAVO4fsg8sFSJlRPffPGPFy2J3jjPC/qv5UDw/wShUmd4g9KP3WbL1B5+
 mBs9AQRYUlzjMSmPF25Qq3wVxbj+3cDi9JTAXzZJzg1hptcK/Kt/fWV/5YEjOUVBzzdm
 ub8UxVTYGBQ3bX31OA9S2L6lVO+WFS/mOfg6TPrU6XB3tvkIgPpUfA8YnO12qlquoqSQ
 I6mA==
X-Gm-Message-State: AOJu0Yyd/+9zc1lhdxgYUDz4J4fDWdPCTuhDrw5FW32SNkDaXPeqZMp2
 3dOjqbOgFjsVPEnuo0Tu6esZBU2NGi1D78b5GG1FLG6/S3xaMPjTxg5crYwd1NVmhgdfEFLO8/G
 Lgoh6l4M=
X-Gm-Gg: AZuq6aILT2Hk0Sm+zEWt/jWgC8F4luPOTOodYYWiR5AGwc8UNGetNAgkXgUwFvMmmZ/
 Ln2zVbRT9fjscYnVr1fx/4PCLTLR4ejCmwc2B0AI4XjRd359NUcS7nxxoFTFQqz/5MDZ9l42ZXP
 N6+eGhy+xQirWQ3onf0LBQ7cQEASlh9avAzO4PYzttcvSn3NhHWh7lvllMo14aLaHY8rqsqqvbP
 XglLDwJNB6W/YC4O0QvJSTiGTA7PZAR+AmmV5bhvrfT1sPPgUsZ1IakY4W9DC3GdfnIYTu1aGRe
 nSpy0n6xu3WEDWUHJlih/gRtXFcwvYiUFrCXIMBgSGpT+EtcRJM2tygIBUDKALDLGkXRWTFk6GO
 SvMEdSr0zIHC6ClIzUvbAzBPWnhtn7FUUik9mylut4CGqI/w6SVRlWyNo/1VEXMHUxkdBd7vpvH
 NVv2gHhaDazpVjcd4donk3ddRTqzk5PeGTpQPrANlZdF95ehzsnzT5dexvrqU4W5b5QQ==
X-Received: by 2002:a05:6000:2301:b0:435:a501:359 with SMTP id
 ffacd0b85a97d-4396f18a666mr12561054f8f.41.1771795917462; 
 Sun, 22 Feb 2026 13:31:57 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bf9f77sm16365174f8f.5.2026.02.22.13.31.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 13:31:56 -0800 (PST)
Message-ID: <77076f22-d75f-434a-9cd0-e45502594514@linaro.org>
Date: Sun, 22 Feb 2026 22:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] system: Absorb globals-target.c within common
 globals.c
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Chinmay Rath <rathc@linux.ibm.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20260216213121.47122-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260216213121.47122-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/2/26 22:31, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (8):
>    hw/display/macfb: Constify macfb_sense_table[] array
>    hw/display/macfb: Constify macfb_mode_table[] array
>    hw/m68k/q800: Use MacFbMode fields in q800_machine_init()
>    hw/m68k/q800: Set MACFB_DISPLAY_APPLE_21_COLOR within MacFrameBuffer
>    hw/m68k: Set graphic display dimensions generically
>    hw/sparc: Set graphic display dimensions generically
>    hw/ppc: Set graphic display dimensions generically
>    system/globals: Build as common code

Series queued, thanks.

