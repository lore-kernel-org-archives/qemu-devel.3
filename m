Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28673EE4992
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 18:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaeHf-0001Xd-99; Tue, 30 Dec 2025 13:17:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeHJ-0001Td-Ra
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:17:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vaeHI-0005R4-DC
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 13:17:05 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so102099265e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 10:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767118621; x=1767723421; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Xb2hTNtx/qyQ4gJeaq4ZU9TVpAEY6+uolSyyBWJ34yE=;
 b=UUCSGHGdK2q6UrBfOZr2b+POWGo6clbHBPkQ1iyCkLo5AxW2W7RLGBG4DI81VSSCgC
 jaoxdPfWY/O8hPDUCvwPgEwuFqRJlVrXQT0Zzm0SOf2xI71DivhAlTX983nQb5ADMpQ7
 JgdKTqbSLeUvmY1E0RkD9WC3RscjIBnw3rUGFcPzLXsBfBailz/FadHYtVkCNZG5KOb0
 7WonrsFqtC3Utmo6lkl+D0Xbo0h4LUob+8Pyr140QOX0IOGbFIOSv/vcubgZ84KVMdNM
 kZo/djrdQKusUV7f9WM/HsAfeAemjGVPp0QYsoo3E4vnLGKZrLlvCIRX6Bvc55Ss/yjY
 /Gdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767118621; x=1767723421;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xb2hTNtx/qyQ4gJeaq4ZU9TVpAEY6+uolSyyBWJ34yE=;
 b=k/ESAXA63rT8PveHOJvve1OKk43Gy6hCDNo2nHX9W8YfqbM5QVKvAXD+z9jaazMgxV
 7DmgmHe59ma0qICzk4rTTggn2aEDO8j2+0Rl39XlL5JAWV8Be4t2sXx5viulqNbtceO7
 SDaIH2HcihwwZUUeuMwdz7CUhLHRpddof450n0Q4XfXaZhXzW6xbT5tRGdFX7kp1Js6w
 MDzDV6YRqrW+uGV3KptVZDJLcETHYVqRoVF8w3ziLAUWbXxehDJcqjE6By5J24OCJeY0
 SMjYhmIXdcf4v6zcMpkthh6IPcji3G2De1E0IhJWXuDfcxUpo8yE8ChDTqHhLbAy9YIp
 YiIw==
X-Gm-Message-State: AOJu0YxOXxc9KKSnQRZPETjovk1bAwFf+rGXyUKORVDU74LydQQvaNWD
 Qy03d3sNGqvVOAdrbW3iC/k1eMqLyXNQ2SEkyPhWLe/T6RJIngfSW/xCDjiYtgsMRwn9hJ15P8Z
 4lw/l0Us=
X-Gm-Gg: AY/fxX60Y54W+w0xZKM/u4pfqUnogWTi3lxbq5d/oQBzRL4RrZWywoSo43S2/1V4VDG
 QhYf91hNTNBRaJi4ZfX7tRLkFL8KVnlM1KFQQmJJquzcf776iNQzugqM9Ftik+8LUbYtKZHLUPE
 2gK4yF8eBDtd4MUQN42trap6K0wvvapspSsK/kbkznzPi6qgu3Dh2Aw73BOscV85uzrFxDGjzr3
 WpOU9K62Gaaay4KrESFbOLWhijmNY0SKX4tiPxzu/2aa8uTv923VLnqrZjlV58SAMOduONPmrpS
 UHwOrNyXxdkeQs+zZXGMZKSEes5mgD57FymL717lggLLmu/pG5vAJQbR9oLaCflDVF3DzZGn0vw
 naLYLogxGMeRB6vUBtVu/3IFfSj7G2ImvgbWryKD1IOD32uQb+f2Wq1I36qoF+cZFVcnUYAQD5d
 ZvYhoydffgf3XeQ2K1favMQ/IEmNHSfvt8/19YXcSkL2g4fDC2upseGw==
X-Google-Smtp-Source: AGHT+IGHTPllILcQxRrbXtzTEwz8OEU8Globhvd9nEMB89k/yFmRgMS9/deltIDvvbrhDR4iNYu7nA==
X-Received: by 2002:a05:600c:a46:b0:477:5ad9:6df1 with SMTP id
 5b1f17b1804b1-47d1956ec3bmr442657075e9.3.1767118620949; 
 Tue, 30 Dec 2025 10:17:00 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d28bede16sm197931305e9.20.2025.12.30.10.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Dec 2025 10:16:59 -0800 (PST)
Message-ID: <921d5fda-5670-4526-96e8-1fbb48fe6a3b@linaro.org>
Date: Tue, 30 Dec 2025 19:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] hw: Preparatory cleanups previous to remove
 DEVICE_NATIVE_ENDIAN
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-rust@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Max Filippov <jcmvbkbc@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20251224134644.85582-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251224134644.85582-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 24/12/25 14:46, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (8):
>    hw/arm/Kconfig: Have FSL_IMX6UL SoC select IMX_USBPHY
>    hw/net/opencores: Clarify MMIO read/write handlers expect 32-bit
>      access
>    hw/char/serial: Let compiler pick serial_mm_ops[] array length
>    hw/misc/pvpanic: Expose MMIO interface as little-endian
>    hw/timer/hpet: Mark implementation as being little-endian
>    hw/char/pl011: Mark implementation as being little-endian
>    rust/system: Stop exposing bogus DEVICE_NATIVE_ENDIAN symbol
>    target/hexagon: Include missing 'cpu.h' header in 'internal.h'

Series queued.


