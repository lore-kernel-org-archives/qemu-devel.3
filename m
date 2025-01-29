Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145D3C0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td2F6-00079O-NB; Wed, 29 Jan 2025 02:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td2F2-00077l-Nx
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:12:05 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1td2Ew-0002fL-Pe
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:12:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so71810145e9.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 23:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738134715; x=1738739515; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2p2ksj7ggP9xkmHJv89UpMhMV4kP0D8Tyf4rnFnoxJg=;
 b=bLBgZ38q7vSsXZVAH4Xe7BiSbunm4selkjRJudRqxW0wLMtmlTrwBK+Z88OGFM3pR8
 MB6lR6/KGk/qrPOR4T8Ojl/d/RWbYCb/vl44EgoBTYe0l7aLwgDwOUFpPEmBNTWXjCfe
 SqxLIpJn+ivmiacSmh0iwKn4okCwDo4jlPAkNmAvhteTG4EOVnD49aez46sYYK5APF7f
 NVPI+CMlihfQENAaeF2Fo0V8TGC55DMRlAH5ghgfrFrMpeq/Vm4ewn6yiyJaxr5RIVVp
 wQFwRFz1KAzjfJu5nftHGaKMeewE1ElLxXDgIVuDvZhzOD7C/Hk7RAHnoPkrVv4frphV
 tqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738134715; x=1738739515;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2p2ksj7ggP9xkmHJv89UpMhMV4kP0D8Tyf4rnFnoxJg=;
 b=ELS+wWA7zpqySdldLXQcnyTCW+KIfHFhVVEpwOl11KjChuwiyknRwQwSFa7dyvK1NQ
 LeeozWN0RlSgnN6c0WOEKDp8HIr2VJH5USzO7HiNi+e7Le9mN4+sR3wKOZtHiWrPqz9e
 14AN2uBdQwi70JuvPxaaaew+fAD+3uesYCl8ZO27LihaeAc1996ghaetdlHgkudUXVHd
 /IZ00lXPeTrDUeg5Jra8UrO6yrCdegHpUehAKVZlE1BcKOhLSVwfA7/uDPn3rBq4VeW3
 HQZOVtmZeAqwguZNytS0pelvfQJj0tkIvQnbj3dLkDfKEUnoBlHMg8gJapWwVmltuxu8
 K7Zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV31GAEgW8FZUhMi6/Y47WVdbl/V+K3FmB4x2nX4n+Rz7qrkVWuWXolJ+j6a2ICSgFNLQ9sLZUdzP6v@nongnu.org
X-Gm-Message-State: AOJu0Yyq/5bA46EFdXRvj5D0Hrc7APuFfxQFk4+yd85sNvg8kVpVrens
 +OO62xIUARwq50+HKrHGYpUwx/e6gqmqVjXXepsBgxyuaa4O7KuT4OfN1e3SIvQ=
X-Gm-Gg: ASbGncv0rKhU7y1oUMSvAtacUJRIY9ZBOd5fFbwRDPsM53NRW0TIx+V1SDjgdrYIyrB
 NVnS68uS0B/ogBn/zvc0mQd0DzEf00aRob+++3Nkx2YpdUdXiWtuWG3NAQgQ3wZErzzl8mWCFoQ
 NcLQTTtC3UMX6AYd/efEtpJKPUkufideOLwf/9Arn+VU5XXM8ojmWq1Xftydpvw4VS2Rmv5mmnf
 Wj6fWnwUPxDP/ZIHrr3VuoDTNtOFUdSeSHLWIMZ6Quo4IeUjKmY9M6VdBbnyb99TgTo4IRHUlju
 88exhGYMzhxL4XQuZyRFOqTYtAH4uvHL4aUOaert19Bo0C3lPbsHa/LiEQo=
X-Google-Smtp-Source: AGHT+IF9ZGzR9eIIAOs5DodBdl1JRTbquD2toaxOr+G/hky2cNl61mi1NXieScidoKKrtUBO0LA4hg==
X-Received: by 2002:a05:600c:1e02:b0:434:a802:e9a6 with SMTP id
 5b1f17b1804b1-438dc3c22acmr15111105e9.7.1738134715271; 
 Tue, 28 Jan 2025 23:11:55 -0800 (PST)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a176434sm16352552f8f.13.2025.01.28.23.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 23:11:54 -0800 (PST)
Message-ID: <d48f6516-1c8f-4bf0-ae53-7bb364589c25@linaro.org>
Date: Wed, 29 Jan 2025 08:11:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250117192106.471029-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117192106.471029-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Thomas,

On 17/1/25 20:21, Thomas Huth wrote:
> QEMU currently crashes when you try to inspect the machines based on
> TYPE_PC_MACHINE for their properties:
> 
>   $ echo '{ "execute": "qmp_capabilities" }
>           { "execute": "qom-list-properties","arguments":
>                        { "typename": "pc-q35-10.0-machine"}}' \
>     | ./qemu-system-x86_64 -M pc -qmp stdio
>   {"QMP": {"version": {"qemu": {"micro": 50, "minor": 2, "major": 9},
>    "package": "v9.2.0-1070-g87e115c122-dirty"}, "capabilities": ["oob"]}}
>   {"return": {}}
>   Segmentation fault (core dumped)
> 
> This happens because TYPE_PC_MACHINE machines add a machine_init-
> done_notifier in their instance_init function - but instance_init
> of machines are not only called for machines that are realized,
> but also for machines that are introspected, so in this case the
> listener is added for a q35 machine that is never realized. But
> since there is already a running pc machine, the listener function
> is triggered immediately, causing a crash since it was not for the
> right machine it was meant for.
> 
> Such listener functions must never be installed from an instance_init
> function. Let's do it from pc_basic_device_init() instead - this
> function is called from the MachineClass->init() function instead,
> i.e. guaranteed to be only called once in the lifetime of a QEMU
> process.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2779
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/pc.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index b46975c8a4..85b8a76455 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1241,6 +1241,9 @@ void pc_basic_device_init(struct PCMachineState *pcms,
>       /* Super I/O */
>       pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
>                       pcms->vmport != ON_OFF_AUTO_ON, &error_fatal);
> +
> +    pcms->machine_done.notify = pc_machine_done;

I could accept if we rename:

   pc_machine_done() -> pc_basic_device_init_done[_notifier]()

> +    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>   }
>   
>   void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
> @@ -1714,9 +1717,6 @@ static void pc_machine_initfn(Object *obj)
>       if (pcmc->pci_enabled) {
>           cxl_machine_init(obj, &pcms->cxl_devices_state);
>       }
> -
> -    pcms->machine_done.notify = pc_machine_done;
> -    qemu_add_machine_init_done_notifier(&pcms->machine_done);
>   }
>   
>   static void pc_machine_reset(MachineState *machine, ResetType type)


