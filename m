Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF33BC87FDA
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 08:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiqia-0003ga-5C; Mon, 04 Aug 2025 04:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqiQ-0003Xp-VQ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:38:45 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uiqiO-0001RV-7Y
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 04:38:41 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so26760975e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 01:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754296719; x=1754901519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QsbtFW/tXxOzPexNURs7kjkvgYTUYDtqzosD3eCpQP8=;
 b=CdLUrIN9FwSs6sdPwmG9zH5l29p+gwG9qgADH+LsrmYJeb1Z/a61kdrMpHs8whbcMw
 Sv0sgWaj/7eWzMMpIDagGpzdGXfswB5Q67/g7Oprwic3BVLtGaFOxc8MnTaIbwgAOAsP
 k832E9IipJV0zfEA1K6r1vSpS5GDXzGaX/jhFTRjhZkwTbhPvd+Gdm8vmvoQ2/dMDnHY
 6qDfCbLWpB7DR3vCnolEGD1n1H7NiNcACR8O0BiGNXExDTSqyoRieJoi+9qqMjwOvtgA
 uC0GCaaCjbk2yrQdwr3mNuldjre/2bFtOPZ1MbEcgHwhzUUW9LYUdWSOAdt5wwGCQ656
 Lhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754296719; x=1754901519;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QsbtFW/tXxOzPexNURs7kjkvgYTUYDtqzosD3eCpQP8=;
 b=EbBc2BSWqtEFN7j1uRkCS6N5HWl549XClqtdi8OstiWMAMDnrB+uwqybJEN/JD5eBV
 Q9k5XARPqOYWXAVG/GerlPH5FprW2OP4CmNHHU7OFkRn8iXfF7ioXWyyhWccBuLvmhjM
 s7blr3OB2MaCZXX1UsKHKza4rxCIh9/up1Z6rhVAVlx2wEV7YIya6ZJhN73kTDYjl73C
 4vFl+kCFSAMv8Ee68Td/ihswAxlQnl8Z7GdHe/TKpq08fBASX2SaOxScnXHqklQ/5gK/
 nTzgRyCfi5K9ale2Ditv2wcWRwjUhkXeyQfWvq/l4bhpYcFcl3ISOM6kHYrSQwihRtMU
 fH7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHRt22uvTZqtPIR190r455sx3t2TAKhMFAlFhSM41yNEPsHEG3IxbxLsVbsqT1IKwlUlZNaEc5BjDH@nongnu.org
X-Gm-Message-State: AOJu0YzNsn8XSiU4pFHKv1/tB1hFb6jkMvxBc2SAjYeCpvmrnaVzvD7W
 bU4uC+pG0Dw+4qYL2OiMR2PDQGbOrdXySQWIA9ImZ2HSHdLl39XKVKm/14vcrZ7XzEk=
X-Gm-Gg: ASbGncsTcOe8ndWZYMl9xIa9i41aEKjDqdLmCA0ep0HoEV9voHv+pK5cPQq7lseiU92
 wbE+tnmUV4xkom9YZgbPK6CWigksGYNjjBRCNtcia63cFUZ7Bto82jVsClDnCJQEpgXcPDflmqB
 /tnVLrugLjGw34m45Yd6Hzt4HhkK8//AFu4lfDhEKRLr/5HJLkXu5sLL7MVcMS5Jo2OmirsBeaM
 eWpFCxZAYePaIHS9TnoU+cTNVykOo6jwhY7O21m01cSmCv2YyM0zy7TXNO4iAMx+hH+0s90LFBm
 iKnaLjuY6SZrpVWKwRnEWv7Z18snRgwh/5DNxH0x5pggHX7XnIUDVe1CnF4A07OCIsZ9BasN8yx
 EslZfR56mk4uVNS1DoOCP5/rTxUXcjq09DFXux2glZqXbdYjr+ttbIkqaPdzc0gkORgyAGM0=
X-Google-Smtp-Source: AGHT+IENAQOlrwkfiAGXdc8I/f5wGtB/heEwrWF1pyaI9F1rhXLW887AnkwjixG08JhVJOuKDV/LCw==
X-Received: by 2002:a05:600c:4f89:b0:459:d9a2:e920 with SMTP id
 5b1f17b1804b1-459d9a2ec83mr20468005e9.4.1754296718648; 
 Mon, 04 Aug 2025 01:38:38 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b8e0bfc79fsm4630940f8f.56.2025.08.04.01.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 01:38:38 -0700 (PDT)
Message-ID: <62925d88-fd45-4ef6-b3e5-182a4dfc13c8@linaro.org>
Date: Mon, 4 Aug 2025 10:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/24] tests/functional: Move avr tests into architecture
 specific folder
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250801151251.751368-1-thuth@redhat.com>
 <20250801151251.751368-9-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250801151251.751368-9-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 1/8/25 17:12, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The tests/functional folder has become quite crowded, thus move the
> avr tests into a target-specific subfolder.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   MAINTAINERS                                                 | 4 ++--
>   tests/functional/avr/meson.build                            | 6 ++++++
>   .../{test_avr_mega2560.py => avr/test_mega2560.py}          | 0
>   tests/functional/{test_avr_uno.py => avr/test_uno.py}       | 0
>   tests/functional/meson.build                                | 6 +-----
>   5 files changed, 9 insertions(+), 7 deletions(-)
>   create mode 100644 tests/functional/avr/meson.build
>   rename tests/functional/{test_avr_mega2560.py => avr/test_mega2560.py} (100%)
>   rename tests/functional/{test_avr_uno.py => avr/test_uno.py} (100%)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


