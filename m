Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E153D2ECF7
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Jan 2026 11:03:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vi9V7-0004pT-MX; Tue, 20 Jan 2026 06:02:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9V5-0004kw-72
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:02:19 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vi9V3-0003L3-LH
 for qemu-devel@nongnu.org; Tue, 20 Jan 2026 06:02:18 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-4327555464cso2710303f8f.1
 for <qemu-devel@nongnu.org>; Tue, 20 Jan 2026 03:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768906935; x=1769511735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSG9PX+BUEW13FzyKteNKhsD2RRqb7YazOQZIxP/CKQ=;
 b=eVbpLSEfVxri3nXVmttJ6ajHA3bwXfSeu2I9lH3EqrB/sUb1TLvIb8EAtJ/hlMb2Jk
 /Pg15HkvloIop5A1y54usic36upoyiBOuAQHl9mqLJx27TxIKGXlO6KiBan7uXRxoawC
 VyqG+mI4vVV71Qh3SU48fFncCtG6Xb6nrcNdoIA+y+OEI8n2K9je873ZDI/8t+uLQpI6
 88Hndp3oHwvVquSoBSvXhnV3djkQDoTtkWiPEQ4rYZY+e1Ror8jwxg+Veq4L16MsP5JS
 etRBTFQj4HZ0/7570Mn0+Es7lUdxNY9hTGGeXs9MjU4+JBpCV1hzbOqaj07o+L1XWhSu
 I7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768906935; x=1769511735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSG9PX+BUEW13FzyKteNKhsD2RRqb7YazOQZIxP/CKQ=;
 b=jqcaJf0AhRK5CUMc2sZwMSCGWrxmyS6ltlDbbZOTplzaSFfdoZ3Q1LHlUTuZiod7o8
 seNPFJRZbfEYdWJbuxzHCm5EO5FSSwRzlwTEXFa/jBPjfREKNr52sQFDptBfEeaV+0GZ
 XYWzSQFmgwwPZ1Tkv6/2DdQX4dKKEva5353zYxsCUK2uW+ZdUceo99oiMXa8RSrhDW6j
 T2cdjvkU7tegTsp1LJMcxzvkNhVLTxH3FVsohtlYQQI3eayjKf5NWN702lMGY1yP9ld0
 PVMWrcDEcqE2H6sq+na9Ht17cQnigMB0xVuOmXxqEm6y7OVZ8rIgIlliYb9L0O99lnhy
 ou4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOxs7hbieLxuN0KwKmwVt+LvHMSXoDEkiLfIz05ZnhIKXIpCnsO84mdZmuAsgpvioZtluB15fbBDmW@nongnu.org
X-Gm-Message-State: AOJu0YydoJfeM9a5zn+jm5QyaGFFNOPEZntJ4mPH+psuX0dbpgcEHZuU
 AA9BnEtc4W/D0x3HPOLNQ3hwUZ8KkktV78RG35fJTTfZARkBjS282Z1TMXwjnMLzL011CWJgdlU
 jmdDCiDs=
X-Gm-Gg: AZuq6aJ55H7bx5PpRVTKQfPQQKqifQmvNNmN5EAdzIWuRve+2gqsN0KR5I1pWZrIuXI
 gmbKMFQnBZsNA2KlGaeq1foAhBsDR05u0ePJ5BJN467CQoJWvCOBvnyVlzACn83M+/mBgVIsB7f
 k0ytTe08GGPVdoe0BouX/JF9NZfhq1IICUHTWunWZv9lRpMChrODEOSRa9M51HAPnb5FGPGAjcc
 QVUsj9Pmqpv6Of6/1zLZ1CSGyHlQTuyTodre4/CQPi7jbwF2n2DKCWulLaneMKdtdsdlgroKa0U
 vVLilPoJ5QC1SDEADLhSOKN4dFhY9ZjZ/9IDipROsT7I6kUiuDXZlNwIxIpqI1AHn23YuM1fae7
 2bBF6EUW1uOex+p9Z8oigFKC4s9BHBRoUFGp5jt5qvwD6YktC9JPpyoVFAfgbXdNq+01cdLnuST
 W3knJhc4adfPMj3HuuI2khBfd6xBGWb6o3B6C8Kp6ftwt6ML1PSfEyuA==
X-Received: by 2002:adf:ea0b:0:b0:435:94aa:df3c with SMTP id
 ffacd0b85a97d-43594aae27cmr971722f8f.61.1768906934862; 
 Tue, 20 Jan 2026 03:02:14 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921facsm27509337f8f.5.2026.01.20.03.02.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jan 2026 03:02:14 -0800 (PST)
Message-ID: <bbcbfa37-6d13-4c6c-9c14-84975c13a7e4@linaro.org>
Date: Tue, 20 Jan 2026 12:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 19/26] hw/arm, accel/hvf, whpx: unify
 get_physical_address_range between WHPX and HVF
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
 <20260116135235.38092-20-mohamed@unpredictable.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116135235.38092-20-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 16/1/26 14:52, Mohamed Mediouni wrote:
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> 
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   accel/hvf/hvf-all.c        |  7 +++++--
>   hw/arm/virt.c              | 43 +++++---------------------------------
>   include/hw/core/boards.h   |  4 ++--
>   include/system/hvf_int.h   |  4 ++++
>   target/arm/hvf-stub.c      | 20 ------------------
>   target/arm/hvf/hvf.c       |  6 +++---
>   target/arm/hvf_arm.h       |  3 ---
>   target/arm/meson.build     |  1 -
>   target/arm/whpx/whpx-all.c |  5 +++--
>   target/i386/hvf/hvf.c      | 11 ++++++++++
>   10 files changed, 33 insertions(+), 71 deletions(-)
>   delete mode 100644 target/arm/hvf-stub.c

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

