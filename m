Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1599D5E376
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 15:59:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9nrS-0003PP-S8; Sat, 09 Nov 2024 10:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9nrQ-0003Ot-Hr
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 10:58:52 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9nrO-00054D-CG
 for qemu-devel@nongnu.org; Sat, 09 Nov 2024 10:58:52 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-431ac30d379so26799395e9.1
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2024 07:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731167928; x=1731772728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O5QJBE+exSNEWl13piD/ZWc/zu8Q994F5xC83jXETjo=;
 b=XeG5eR6qq9FpIOu7u9U5zT+K+fQ7iZyEyKTLzny/syBeZQtj2YbVwC7jcMedvgWfCd
 tspzyLKD1n26yEq2PE+3McNPTVusiaeYHVf8lZLIgu0Wuv7ynM8FNl98TF2Ov3tyS1m/
 ryZYk1mMOtcwYXJfsTWSUoFeBDVRUWyYrz/dqlz0jUFRE+Cjva1RhcQs1anEiH1yy/hm
 6eTbJGM3ijfTbnw7XAjI4UgHiawhdLKO8Xdm5vHcaWqq6TOct8dAaXN6hIGdVEvLb6V0
 zAhyTCuyVJ5x6DfAfV9EHcTejZOjUBZxzmPkCOXTMvcrm2xrhdlrD0ITc6HBDEVVfXOy
 6nFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731167928; x=1731772728;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O5QJBE+exSNEWl13piD/ZWc/zu8Q994F5xC83jXETjo=;
 b=ZcBIKL1fUN/fr5L8SCQsEuAppwmnUcGk0ivky2KpmZOk/SbTA0sCxbdAZCyl6Gd5lx
 SvgyzVgD9tAcdYhyX+9ylkinSzS6DkJnthmMnljKFY0dqWkD2SXrAIvDUgQUhxbfeDZY
 WlJx4vSBK2/SASrzvGKe5RkFWNox37sYkKuESubzftstRuAS5cNMIXxmZNC8kMhBcgj7
 CoDOThKU1NtTL6IrPOoL7GV/xywkeEEGMFL0tzMnHypsxVD60/2PBJhAnSAzYGyDBm9u
 sPSLjZqn63ca30YIwbE1isuPUfHoS0rtriVmsSQUynkTvAHUdL1P6b6/VqGD0OpWp8NT
 Jzjw==
X-Gm-Message-State: AOJu0Yw+R1MwEF2qxCZsVlPMQf+7W3lcAYqTlXNG8us95NTnQWsrlLNH
 rqpLZeeKKWEn8zKODj4p5hGLSedb+QQ53ihpBsS7ueweXOF0l5X/HmHPAB8Sal0=
X-Google-Smtp-Source: AGHT+IEdF64Da16/injPEnNM4CGcXvREr92TI2x4tU2BHjXMu8nVHZ2fJ3gn9VKceL1Nt+6kSIG1bA==
X-Received: by 2002:a05:600c:4590:b0:42c:b4f2:7c30 with SMTP id
 5b1f17b1804b1-432b7515c33mr55770805e9.23.1731167927842; 
 Sat, 09 Nov 2024 07:58:47 -0800 (PST)
Received: from [192.168.3.213] (73.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.73]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432b05e5f77sm112739325e9.43.2024.11.09.07.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Nov 2024 07:58:47 -0800 (PST)
Message-ID: <84046f49-a39f-4639-a383-fa3c4a97e17a@linaro.org>
Date: Sat, 9 Nov 2024 16:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] hw/openrisc: Mark devices as big-endian
To: Thomas Huth <huth@tuxfamily.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Anthony PERARD <anthony@xenproject.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jia Liu <proljc@gmail.com>,
 Stafford Horne <shorne@gmail.com>, Paul Durrant <paul@xen.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20241106184612.71897-1-philmd@linaro.org>
 <20241106184612.71897-5-philmd@linaro.org> <20241109074225.76e0e4ad@tpx1>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241109074225.76e0e4ad@tpx1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Hi Thomas,

On 9/11/24 06:42, Thomas Huth wrote:
> Am Wed,  6 Nov 2024 18:46:11 +0000
> schrieb Philippe Mathieu-Daudé <philmd@linaro.org>:
> 
>> These devices are only used by the OpenRISC target, which is
>> only built as big-endian. Therefore the DEVICE_NATIVE_ENDIAN
>> definition expand to DEVICE_BIG_ENDIAN (besides, the
>> DEVICE_LITTLE_ENDIAN case isn't tested). Simplify directly
>> using DEVICE_BIG_ENDIAN.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/openrisc/openrisc_sim.c | 2 +-
>>   hw/openrisc/virt.c         | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)


>> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
>> index 47d2c9bd3c..ede57fe391 100644
>> --- a/hw/openrisc/virt.c
>> +++ b/hw/openrisc/virt.c
>> @@ -236,7 +236,7 @@ static void openrisc_virt_serial_init(OR1KVirtState *state, hwaddr base,
>>       qemu_irq serial_irq = get_per_cpu_irq(cpus, num_cpus, irq_pin);
>>   
>>       serial_mm_init(get_system_memory(), base, 0, serial_irq, 115200,
>> -                   serial_hd(0), DEVICE_NATIVE_ENDIAN);
>> +                   serial_hd(0), DEVICE_BIG_ENDIAN);
>>   
>>       /* Add device tree node for serial. */
>>       nodename = g_strdup_printf("/serial@%" HWADDR_PRIx, base);
> 
> According to https://openrisc.io/or1k.html the openrisc CPU could be
> implemented as little endian, too ... so would it make sense to use
> a runtime detected value here instead?

While this patch is a code change, it aims to not introduce any
functional change. We are not building (nor testing) these devices
in a little endian configuration:

$ git grep -l TARGET_BIG_ENDIAN configs/targets/*softmmu*
configs/targets/hppa-softmmu.mak
configs/targets/m68k-softmmu.mak
configs/targets/microblaze-softmmu.mak
configs/targets/mips-softmmu.mak
configs/targets/mips64-softmmu.mak
configs/targets/or1k-softmmu.mak
                 ^^^^
configs/targets/ppc-softmmu.mak
configs/targets/ppc64-softmmu.mak
configs/targets/s390x-softmmu.mak
configs/targets/sh4eb-softmmu.mak
configs/targets/sparc-softmmu.mak
configs/targets/sparc64-softmmu.mak
configs/targets/xtensaeb-softmmu.mak

$ git grep -L TARGET_BIG_ENDIAN configs/targets/*softmmu*
configs/targets/aarch64-softmmu.mak
configs/targets/alpha-softmmu.mak
configs/targets/arm-softmmu.mak
configs/targets/avr-softmmu.mak
configs/targets/i386-softmmu.mak
configs/targets/loongarch64-softmmu.mak
configs/targets/microblazeel-softmmu.mak
configs/targets/mips64el-softmmu.mak
configs/targets/mipsel-softmmu.mak
configs/targets/riscv32-softmmu.mak
configs/targets/riscv64-softmmu.mak
configs/targets/rx-softmmu.mak
configs/targets/sh4-softmmu.mak
configs/targets/tricore-softmmu.mak
configs/targets/x86_64-softmmu.mak
configs/targets/xtensa-softmmu.mak

(no little-endian config here)

Having little-endian OpenRISC is certainly welcomed, but it
has to be done separately, preferably adding test coverage.

Should I rework the commit description to be more precise?

Regards,

Phil.


