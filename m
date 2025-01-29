Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2BDEC0218D
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 07:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1td24L-0004Ry-Dz; Wed, 29 Jan 2025 02:01:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td24C-0004QD-Hb
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:00:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1td249-0001Ff-Qk
 for qemu-devel@nongnu.org; Wed, 29 Jan 2025 02:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738134046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MA1u5uPGCu8BCbSxQC7HytUAHLgsivCdi4cGziGLfhA=;
 b=EW9zMpsGf26tLbT6PaoyUk7irtxTeeDJc2gJ5yc6RcXCi2jl7lyrYdg1ysV1+hWRe0BJQ2
 2r5aiGMBh+vRn+MU1nDvkmemL2SlgBIn16slsEt/1jPdIo8piSi+Ry630T4dZqXd++yO+F
 n+Cirydno5BYdbAoStvgviDgpYBkXy4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-Av_9KxZ2P4-MS1eRRIJwjg-1; Wed, 29 Jan 2025 02:00:44 -0500
X-MC-Unique: Av_9KxZ2P4-MS1eRRIJwjg-1
X-Mimecast-MFC-AGG-ID: Av_9KxZ2P4-MS1eRRIJwjg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-ab341e14e27so733182566b.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 23:00:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738134043; x=1738738843;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MA1u5uPGCu8BCbSxQC7HytUAHLgsivCdi4cGziGLfhA=;
 b=B4A8PrbsQB3ReQI9OSlUrTU7zfalNpR2ts9CTf1NWJW4M3UarP3JMV8iXpNyi/AbDD
 HXcUh2W4jGTtveAWFTkx+hiGitfGVGcBw+/5vlI6HZnBGOtE3zw4glRfWCfSs0KEgZFI
 52so6rSufYGCTkk/v37SxPxhhk4Y/Kx3TGfphn84Af9HAZADaa53W6zJWWXPYgEBAz4U
 TJfiflq2/ZcphnkfuU8lvjK0LuvVziOp0vtnrMPQME7pr6OsY/9wndZ4DkqGrOJNDeYZ
 QMKVoiufLrgj9SGW3rAHbEiXo/eJm6/5DC6wQJTRAVkL2Y6/5voyAYn3mQ6OmF5DigDj
 tSWA==
X-Gm-Message-State: AOJu0YxW5cpe4KIgTv6Wzg7VuciSRSN2xO8YQlZeFtWiS7gY4g+inmJH
 BbssssKlcJ6oSXLXbOR4/PDP4yLxHep8n9i8tfD3V43VAowa16AB+qyiwlFOqH9pN20WAeZKu9q
 MLRgTh9DWxDbUzLSpFcIuU4/n8LGwvS6mrVbTGFCooUDN++U7PDdbQQHIDsvhmkAwoNnIJQeO0I
 gugErRj5F91lZhTdBGo4csami64eqpXRs7
X-Gm-Gg: ASbGnctmmpJPGg1l0pvPWfAAbrV9wInBy/xc2RCDp0FozEW0MVQEnBp5D//NJKKpCvL
 uyepQF0zMMju9pK4j9+Ly1gyfLTweuL04XXaFyMUPQQtKjqfgBTBEg7KYk+UpNYJwKTJdlTvrFZ
 TODCbQD+TnhuFPlyV0tGada59f59yiojLOc+MUJEWHxkKju1O+HeYtJ5Ypd1u7D1aK5bKnCCejf
 CL4j7AiaPkJWUVsgSpWbgWwv8QKKPPhGvbAjIm5uHcDY9b+fayaBJVWeVNeOt0NRfZfTTm1x3Ab
 ZpYtjJKbqnTVAdXQ2w9ckhDkdyNG7BZhElsh
X-Received: by 2002:a17:907:1c27:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-ab6cfdc6719mr162228466b.47.1738134043504; 
 Tue, 28 Jan 2025 23:00:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuOyCRonC3/Hii2B9fn4cQEGrDK1hSFekn9+8yZU4Oj9WmR48oUTnGICP3bJTiHLhd6wyeYg==
X-Received: by 2002:a17:907:1c27:b0:aa6:873b:ed8a with SMTP id
 a640c23a62f3a-ab6cfdc6719mr162223966b.47.1738134043044; 
 Tue, 28 Jan 2025 23:00:43 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab6760fbb72sm911827166b.129.2025.01.28.23.00.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Jan 2025 23:00:42 -0800 (PST)
Message-ID: <7e719e2d-1f89-4f67-b519-3279f18bccd6@redhat.com>
Date: Wed, 29 Jan 2025 08:00:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/pc: Fix crash that occurs when introspecting
 TYPE_PC_MACHINE machines
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250117192106.471029-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250117192106.471029-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 17/01/2025 20.21, Thomas Huth wrote:
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

Friendly ping!

  Thomas


