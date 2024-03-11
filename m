Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9907BC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjbFb-0001Lt-VS; Mon, 11 Mar 2024 04:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbFa-0001Lc-7p
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:43:14 -0400
Received: from mail-lj1-x231.google.com ([2a00:1450:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjbFY-00045b-K5
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:43:14 -0400
Received: by mail-lj1-x231.google.com with SMTP id
 38308e7fff4ca-2d28e465655so61341961fa.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710146590; x=1710751390; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Y6ZqMmyct0W1Y2dJSNBqr9IYcMbdMIEvu4HIJcrAPjI=;
 b=Hod5Qt2jvxPRchHJVPizK4MpfVuLL8j7mBD+gjHeGTm3gXKq0VqHEyymMF8PLnLNR2
 MvZMWodJcvO8ZqQjLzhrvde2FTN6nm1noJMLm7ZQDqE1UJQTA3R/9TjM+Mu516VUgY52
 Xx9FwerlIPAkAhs46Yt0SPjjJSpTcqPGciGZ2UAEAoepEw8vcwB6rYJZZub0h4LFhNZp
 LvNTUX2eXLKFdFsxPPzLYsgfQ4wTxqNjWjkJ7efAa+ApZUAqaGxZKRDc/fhe7eCCjIhF
 +Ps3rMjGJlVpuXBqY01Nz/8PRJ2f8T+ppEAh3H8nDTESAzgNVpf7mqFyNwsblbuJVXF6
 qrDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710146590; x=1710751390;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y6ZqMmyct0W1Y2dJSNBqr9IYcMbdMIEvu4HIJcrAPjI=;
 b=p5tcxQ1/9LqlsrYYuuhHak1J7wlY1l7z8fpTJbXWQqIHMOG0AVEtVo7o+sZmkmAgtV
 SwwYe7BGblJ7Nq5NSKPhwQ2oGWjfmmwpKZ+yQIQ3jevstg3wVo5+eVoTulYOLSkGKEHw
 Sx6ssldDa96HfZ3Rd1nuObfVc04J42MkGSvSujZHVrpSINLX0XsbxGaMDjOeAywHIkuU
 Q0L39mgNPNLEZAych3E1v58qcwQ3M89pZrl5+4YqbhUWHSiBz/xek2acqwRj+rrTZC2r
 PkCPZmNHyg6ggxjjNzzYt0OfSdI5WwkgcNVgbF1+NGFi/x9H/gTJRPoihPQJEtQsmxij
 Gdng==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+h12Y4Oyt6ocivfxrIo3XIPUFPqEN5VBnE6eEAXOJJIyQEo6vKW9sZxjF91PGKxpkoMmh6msPlJAWKlxNdcyaVpScqGY=
X-Gm-Message-State: AOJu0Yzx1Aapq2bULTHNtpIKX3R4ZwgEtP/hZWp1MnGSmM9/r4JX+8r1
 EplsA9xBv6ll/itUdg6IUQdOjKa+I4N1jQmGvUMhFv2bpMzRO3LKs+Re5zg8bHU=
X-Google-Smtp-Source: AGHT+IGsdeaHjZgEoym9auFFnICCQvgTz2/UZuiHlrz4+o0Yyb8ge/okSQZgHmf0txX2vrdcJ86UrA==
X-Received: by 2002:a2e:b888:0:b0:2d4:2f37:1e27 with SMTP id
 r8-20020a2eb888000000b002d42f371e27mr3707840ljp.18.1710146590377; 
 Mon, 11 Mar 2024 01:43:10 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a05600c458700b004131b0c2bd1sm10221098wmo.16.2024.03.11.01.43.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:43:09 -0700 (PDT)
Message-ID: <2217f2c6-cc91-4f6b-ab5c-644c604c51a9@linaro.org>
Date: Mon, 11 Mar 2024 09:43:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw: gpio: introduce pcf8574 driver
Content-Language: en-US
To: Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Igor Kononenko <i.kononenko@yadro.com>,
 "Alexander A. Filippov" <a.filippov@yadro.com>,
 Alexander Amelkin <a.amelkin@yadro.com>
References: <ee386866ca7ba80add0c428b59efb936fd7ce797.camel@yadro.com>
 <0cbde20b-db66-4894-b498-8360b8006693@linaro.org>
 <56678f4f0c1e526b7b5a04104171e4feb372e7c2.camel@yadro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <56678f4f0c1e526b7b5a04104171e4feb372e7c2.camel@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::231;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x231.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 11/3/24 08:09, Dmitriy Sharikhin wrote:
> NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
> PCF8574 incorporates quasi-bidirectional IO, and simple
> communication protocol, when IO read is I2C byte read, and
> IO write is I2C byte write. User can think of it as
> open-drain port, when line high state is input and line low
> state is output.
> 
> Signed-off-by: Dmitrii Sharikhin <d.sharikhin@yadro.com>
> ---
>   MAINTAINERS               |   6 ++
>   hw/gpio/Kconfig           |   4 +
>   hw/gpio/meson.build       |   1 +
>   hw/gpio/pcf8574.c         | 162 ++++++++++++++++++++++++++++++++++++++
>   include/hw/gpio/pcf8574.h |  15 ++++
>   5 files changed, 188 insertions(+)
>   create mode 100644 hw/gpio/pcf8574.c
>   create mode 100644 include/hw/gpio/pcf8574.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Unfortunately your patch doesn't apply anymore:

Total patches: 1 (cherrypicked: 
<56678f4f0c1e526b7b5a04104171e4feb372e7c2.camel@yadro.com>)
Applying: hw: gpio: introduce pcf8574 driver
Patch failed at 0001 hw: gpio: introduce pcf8574 driver
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".
error: patch failed: hw/gpio/Kconfig:16
error: hw/gpio/Kconfig: patch does not apply
error: patch failed: hw/gpio/meson.build:15
error: hw/gpio/meson.build: patch does not apply

Also please don't reply as v3, I almost missed v2, see
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#use-git-format-patch:
"Patches are easier to find if they start a new top-level thread, rather 
than being buried in-reply-to another existing thread."

Regards,

Phil.

