Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CF4CF45D4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 01:21:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfT6J-00066u-Rj; Mon, 12 Jan 2026 20:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT5W-0005fH-S5
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:20:53 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vfT5U-0001yz-QW
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 20:20:50 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2a09d981507so44704715ad.1
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 17:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768267247; x=1768872047; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H/KA3sfCKde+1lDvxy4Qi6KcSUidmC22RMDt2hOFbAw=;
 b=aTI61s/vWi69YMUjZi8l1sCqyQlepdSRZX9csxAKkHLxUmFMbrqziLKU2oPGnNJThL
 Zpk6kUU3nN5c39olqo7W0w7rw+CgfuOPsAuzKVb+LHGwloap/+8SZAprkO+8t6q9HTtV
 YFcsAzVP2rwnbmioyRCwgsbWkD1hwiOrfJFU+Ss4XzgHiFS7t5PwSVdXnzhTKEL7qRpX
 ti4uokTTFzQ18XpOTho5sAbliKiEY430uutvCU9AB0Vx8LMlRZtCAdGydFtZ6qC+Eu8d
 es0OGFDUAGeIbM+FpO0cjZp/OsXg+ORH98DCWMNRuHfh9/KgegBhHDPzp81p/Pq2IK5k
 6C6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768267247; x=1768872047;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=H/KA3sfCKde+1lDvxy4Qi6KcSUidmC22RMDt2hOFbAw=;
 b=ustcoBvoNCFbsdLGQG/FuFDU4JrUVyYhEFbdqHo6YrD9xIzHc4oub4DSwWvcZUCS4T
 Ksntkx+Si3yk7abdr0uhaL9TMQ69qjNhBbirxM40OllEJMwXTz617GwYWkg4xLp8UbkD
 OcEqnbGl2Q4gbC+1b9pjOIH3RQpkrmnxqslWpgiF2w2EOpuJxzgvxCEiGrZwmjqa3FvZ
 uNBMKYOmUn+DPZkcsOewMgyknvE/pZf98epsg1mBu7HQSkxCY43x2wYV57J5B48tOvkm
 C8TbPZHV2cj59/kIrefvKYd9eB1zMJH4ynEjAP7T2gmXOKY6TvD8ukwylvzMKaunTQch
 4cig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZXTGAwnmgFRYo4tdVdDkHJ/GPLuXCNI34+EBX4htD2E2y3oV+6uSwrW5lsGwadm7jqPJjnASrIQsM@nongnu.org
X-Gm-Message-State: AOJu0Yx3122ekGLq0Am7ZvRccZi3DZUun1V8q2wfm64g0NwTBgInHIM9
 u6rUd3kldBHx+T4fNxjP5EfgXD0tklSkPEUXnJN4Tn8iOuPGo4eaLiLbbOZ22aFRr68=
X-Gm-Gg: AY/fxX76Rv+AwYBNCj8WMANm94RzxVSg7ZDrIDZVdlQtlua+18cC0zti20EdoYg4uQI
 QSeUAzimwVyndgRa6DaCxmzo2QrdDSSkjMPGUN3r83NjbEMYhilp2g6qlO0wiNvjCEIRBAC0NkJ
 utzPXPz7wIKrmpgWxvJXZlls8QKbwBnI/k2bhXdczY5T9JIav/0zm8TXHcNyUUOGewgftGYcVAK
 8YuDOJk+ydViDMWN/TX4qdPc31ndHGuTkk59X0IAGIGWaPWQYdqZdQKkSi+KUQSsM+Kst111Nwr
 /1pogilD3A7K0emqthvtbFlb6wofxkOIeF6U6AfMVwXCcVDWcYfS+Wy6OYH5Iu0R5+5STX42Dru
 B6sfVZXhutHmZx7WyxhjQyUrrN5M6qHjAtEv97D3nff0e+BcSTSOC0ErWIC8WRfM79YuikscUJ5
 UEmZZQojS5BVtN39IYkruMzsZPjhN3Bm1do7vRsw==
X-Google-Smtp-Source: AGHT+IEYhtsB0qtxmR5KG9cbfJ8jv8WA/f+enpJB8/+LXxUg3f7PrGI5DlYmHo6akS4d6YIH0cbseA==
X-Received: by 2002:a17:902:db08:b0:2a0:971b:151 with SMTP id
 d9443c01a7336-2a58b4b5f69mr10908375ad.2.1768267247027; 
 Mon, 12 Jan 2026 17:20:47 -0800 (PST)
Received: from [192.168.15.8] ([101.187.175.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3c4796asm186920075ad.34.2026.01.12.17.20.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 17:20:46 -0800 (PST)
Message-ID: <7f0d5a47-6462-4b10-b34a-07bdd7feb63e@linaro.org>
Date: Tue, 13 Jan 2026 12:20:37 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/12] hw/m68k: register a nextcube_cpu_reset handler
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Yoshinori Sato <yoshinori.sato@nifty.com>,
 Yanan Wang <wangyanan55@huawei.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20260108143423.1378674-1-alex.bennee@linaro.org>
 <20260108143423.1378674-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260108143423.1378674-4-alex.bennee@linaro.org>
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

On 1/9/26 01:34, Alex Bennée wrote:
> This is a fairly simple migration to the handler. Alternatively we
> could eschew stashing the value in reset_pc and just re-read the ROM
> on reset.
> 
> Signed-off-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   hw/m68k/next-cube.c | 23 +++++++++++++++++------
>   1 file changed, 17 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

