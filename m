Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D9DC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoON-0001Op-3I; Wed, 21 Feb 2024 10:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcoKS-00010D-F8
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:14 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcmum-0002qL-Aw
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 08:45:41 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d4c0b198aso424005f8f.2
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 05:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708523130; x=1709127930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Fi2dhpL+qLMWxFcngjZldzHxIQ972VN9MgMUHj+ZWwQ=;
 b=wE0Zo6cb06S+DWw4KkY77ObErZKimpjOHAHXKQAlZ7qqc7UPCiSTWHpBpSBQ4jY90D
 p1oS7WEh4Grm1W2z7huceVM/CKSl5Z4KoGv5xGy2hYX/wi/xN7cvlZYfuRDY2oDZtrFF
 qrcSf1BT89g5sm1gYnU9Xkb2Tk26zRl64NJe/UH+wxkrP5O6P7yWWflkxvX1jyMfnIKk
 RPC+cDHu93ihLd8MSKyhY4z2iCUt9frlvgdeDRjLAosdN3csBKhmKMRBp/Jp8vgwsxj5
 M+v1CRmyQq4JMjuQy+7vrAbuxmHHYslfKgub9fmhriKBXsgm4VupiNi9ihpH1ECJ2HF9
 Da6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708523130; x=1709127930;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fi2dhpL+qLMWxFcngjZldzHxIQ972VN9MgMUHj+ZWwQ=;
 b=LcqSzEr6Tunxx8FnWKDJQLtjTZTfmqOeMa4qLTEbKqSYYeaqddR5ZCmu7OYLh+AwRl
 EAYrsHL0w++6fri+yDNFzUyapZr8QfFQhqa/FTNsGh+35n4q/dH765TAQeiilnElk2hj
 /ccRV5rwFfTclJjhlT4uDQiNQT7Ys3vAmFHk6dldL7s3c3BKJEnHrqyjsNeDHeb4b9Ut
 3uHS7YMVN+gu3GO2tzW1iSXVezCe3uDjQvajJAjRUgazO7c4KA0y1jun4sMmdRaCdgTY
 kzQyPymb9+OG3l39XYAHk32Yvy7Mzz+gSbAUIXwziV4zg2Liz4dqMYS+rcp4vq4LWQ26
 M+DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8qkcSOgSz1m0wApD2FZRzMQb5/8/h4qL/808XueKkTmPeFE6KcpQFDMVEaOgv+Qme0N2gPwrxYJfCt+LQQ1sYB7dhUis=
X-Gm-Message-State: AOJu0YzD0UzviEE3HoPv5JmUntIpibDpo4f9w29LAxS8vJUOI45Azhy2
 WaJO6B5/65xe2LxPw90205U9kFhMiVUBHsYh3W3MJ/fTq+vz89/z4XftD62XgK4=
X-Google-Smtp-Source: AGHT+IFT2+cVpKPUTuUdMzPxeTDttft+njFeJ3JTgfufCq5/t8hAkj8ZtbP0wSBTkswQEAp4MzSsjQ==
X-Received: by 2002:a05:6000:184a:b0:33d:6b89:fbbb with SMTP id
 c10-20020a056000184a00b0033d6b89fbbbmr3932116wri.47.1708523129812; 
 Wed, 21 Feb 2024 05:45:29 -0800 (PST)
Received: from [192.168.245.175] (99.red-88-29-190.dynamicip.rima-tde.net.
 [88.29.190.99]) by smtp.gmail.com with ESMTPSA id
 co3-20020a0560000a0300b0033d70dd0e04sm4790426wrb.8.2024.02.21.05.45.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 05:45:29 -0800 (PST)
Message-ID: <65a89550-7932-4ee4-a693-3456322cdca1@linaro.org>
Date: Wed, 21 Feb 2024 14:07:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] hw/i386: Store pointers to IDE buses in
 PCMachineState
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240220160622.114437-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Hi Peter,

On 20/2/24 17:06, Peter Maydell wrote:
> Add the two IDE bus BusState pointers to the set we keep in PCMachineState.
> This allows us to avoid passing them to pc_cmos_init(), and also will
> allow a refactoring of how we call pc_cmos_init_late().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/i386/pc.h |  4 +++-
>   hw/i386/pc.c         |  5 ++---
>   hw/i386/pc_piix.c    | 16 +++++++---------
>   hw/i386/pc_q35.c     |  9 ++++-----
>   4 files changed, 16 insertions(+), 18 deletions(-)


> @@ -300,13 +299,13 @@ static void pc_q35_init(MachineState *machine)
>                                                            ICH9_SATA1_FUNC),
>                                                  "ich9-ahci");
>           ich9 = ICH9_AHCI(pdev);
> -        idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
> -        idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
> +        pcms->idebus[0] = qdev_get_child_bus(DEVICE(pdev), "ide.0");
> +        pcms->idebus[1] = qdev_get_child_bus(DEVICE(pdev), "ide.1");
>           g_assert(MAX_SATA_PORTS == ich9->ahci.ports);
>           ide_drive_get(hd, ich9->ahci.ports);
>           ahci_ide_create_devs(&ich9->ahci, hd);
>       } else {
> -        idebus[0] = idebus[1] = NULL;
> +        pcms->idebus[0] = pcms->idebus[1] = NULL;

Since PCMachineState is zero-initialized, this part is now
pointless.

Since my ICH9 series clashes with your patch, I'm inclined to
queue it in my hw-misc tree, with the following squashed:

-- >8 --

-    } else {
-        pcms->idebus[0] = pcms->idebus[1] = NULL;

---

>       }
>   
>       if (machine_usb(machine)) {
> @@ -327,7 +326,7 @@ static void pc_q35_init(MachineState *machine)
>           smbus_eeprom_init(pcms->smbus, 8, NULL, 0);
>       }
>   
> -    pc_cmos_init(pcms, idebus[0], idebus[1], rtc_state);
> +    pc_cmos_init(pcms, rtc_state);
>   
>       /* the rest devices to which pci devfn is automatically assigned */
>       pc_vga_init(isa_bus, host_bus);


