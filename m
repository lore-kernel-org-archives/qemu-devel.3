Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5FEC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 18:40:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjjYA-0003F9-Or; Sun, 16 Feb 2025 13:39:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjY7-0003Em-Rt
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:39:28 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tjjY6-0007X7-4d
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 13:39:27 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4395dddb07dso38389505e9.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 10:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739731164; x=1740335964; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D2xPG3XKCkdLHxBzNUyPi7X3K6Pl9xEeosT53qYT+q8=;
 b=NGSEGkkqk8Tg6tPVyjt3fI+yjScLWKRpohw9Pt9DZApFXwOZ7ND+OjwDE/rmYAXLhD
 ySfcARXH7DYax4pH1OX/kukaM1UenoQdHl9rUmBxzzF3wJcmziWolKICxeHnCmDkDkW8
 C9Oi5wVIbUw1OkNPl3Ilxx2IIhKwqUgNVkKOpO0w25QLZfqwqPdFztZYBxjy6LlkpHvd
 9dxGNw/AoJDv3d0bICRcRC0Ws+3D+PAJkvxbPSZ+36okwOT7HUOJaYBHY7JDA1dIEozX
 GIhduu0bSHQYz/vcASPemyFXJTRtQkNJnUKQqFuDoTHX8p8LQYvhbsxBXKsSLnAE5Mis
 aciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739731164; x=1740335964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D2xPG3XKCkdLHxBzNUyPi7X3K6Pl9xEeosT53qYT+q8=;
 b=gu0FXJUqKgdo7idt503wgXLHvT8L9z1JTnIHQbNtMD6rmfkfpxDSivvOoFDaPb2Oh7
 r5VmPHbuiftRuASC658Kv64LKzdjPgNiO1+P//3cvOdxdNNRLFn+7oZxJeDggzr2JqN7
 kOaeX2njR1+WYSKELH/GP1yHfMqnYNsURn2Pb7eLvHTpZ6acMDa/a4MaFIRluQOwDIbq
 UFaLtDPjHXVjtVXKtnyxc5V6Y+YgOAFViek18awxfkeFnqBbJJcK7p596OmHrhEaltpR
 yKzTnPqgTuFkGQpF8LRNf8hz3i5QlmgANK89qoJdwrmsXRicSp9qbHILpe74DnqyDJ3N
 MG1w==
X-Gm-Message-State: AOJu0Ywf3/lo+TwddTtv4AiRSBbbhlmYwqKLa4RZX6RMPqfpFYlgaNLl
 a8d102utEigezU/HtiE5vppZ/2oUKX1CyN4LXToTlGM43tIglIJyj6YWfeXSlzs=
X-Gm-Gg: ASbGnctet3zSgk23O89Loe1/fZ8VrjQTdoEq/WzMWaQo6TaMGcdJLBhUqMmW4MSZof7
 S9qrBY/0or3xzYo/QOEz9fy6J7Yrkt8i5Mljtimh2ZeY62Z92iU5GIxVsdRSKDS9t9/2R8vquAv
 HM9IbDM5sMIsBclqzT8XDBl3haU1Zbj+/LPr7Eqp97CP9sePT8bGMCoffIKLnH1J3EOk26bs3Ut
 RLcC01ZkhAtBXw23taeZ1u/SMYfiJSE9A8/NqqDx25byWx4DKTOyGJ7VmvktoPREJ4ysGyoQybo
 8r/Ezi8gUbPiGYIBUswiM2+Kz9zSWb4sm00qKLIXlURLMcxvEFjOR6lTqII=
X-Google-Smtp-Source: AGHT+IFUdMkeTbUucZFZcqkfkT1ixMd7J12T3Crrqeiz4w6ctykaKZT+vler5YClYa3TAgwMH95Bzw==
X-Received: by 2002:a05:600c:1906:b0:439:6dba:adfc with SMTP id
 5b1f17b1804b1-4396e70a3e0mr69234225e9.13.1739731163826; 
 Sun, 16 Feb 2025 10:39:23 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4396b296afesm56684555e9.0.2025.02.16.10.39.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Feb 2025 10:39:23 -0800 (PST)
Message-ID: <249ee391-5e18-43f7-a836-c8ba974f0421@linaro.org>
Date: Sun, 16 Feb 2025 19:39:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 06/11] pcie_sriov: Do not manually unrealize
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com
References: <20250116-reuse-v20-0-7cb370606368@daynix.com>
 <20250116-reuse-v20-6-7cb370606368@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250116-reuse-v20-6-7cb370606368@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 16/1/25 10:00, Akihiko Odaki wrote:
> A device gets automatically unrealized when being unparented.

Correct, so:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

However this is totally undocumented, I was not even aware of that...

> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/pci/pcie_sriov.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/hw/pci/pcie_sriov.c b/hw/pci/pcie_sriov.c
> index e9b23221d713..499becd5273f 100644
> --- a/hw/pci/pcie_sriov.c
> +++ b/hw/pci/pcie_sriov.c
> @@ -204,11 +204,7 @@ static void unregister_vfs(PCIDevice *dev)
>       trace_sriov_unregister_vfs(dev->name, PCI_SLOT(dev->devfn),
>                                  PCI_FUNC(dev->devfn), num_vfs);
>       for (i = 0; i < num_vfs; i++) {
> -        Error *err = NULL;
>           PCIDevice *vf = dev->exp.sriov_pf.vf[i];
> -        if (!object_property_set_bool(OBJECT(vf), "realized", false, &err)) {
> -            error_reportf_err(err, "Failed to unplug: ");
> -        }
>           object_unparent(OBJECT(vf));
>           object_unref(OBJECT(vf));
>       }
> 


