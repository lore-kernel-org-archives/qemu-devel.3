Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8403C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 09:22:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTdNR-0005on-AN; Mon, 23 Jun 2025 05:22:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uTdNN-0005oQ-Mb
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1uTdNL-0008IT-PC
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 05:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750670521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1RLjvLo9PYYy57mfCXQd3/XShT3kTBFNG+hcvgAyfRg=;
 b=f3tpEfShMMQ1l/I4w+pPv/uq49HX2WByVtl62h11I+g1f0Rh/BPAtmroj62AT8MUYsgZ0B
 B2EdxFp3O11aKeZl2vfRmtgA4WDw0gtwjNvTAconirJ2Tw/zqD/2eVuO5w9f+V4uOQTywb
 pkkf2s/tnlCSEUN6CQmkhhTPjsXeROM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-1mzqNY4ePgq9-z5nCbkzTQ-1; Mon, 23 Jun 2025 05:20:45 -0400
X-MC-Unique: 1mzqNY4ePgq9-z5nCbkzTQ-1
X-Mimecast-MFC-AGG-ID: 1mzqNY4ePgq9-z5nCbkzTQ_1750670444
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a5780e8137so2456358f8f.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 02:20:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750670444; x=1751275244;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1RLjvLo9PYYy57mfCXQd3/XShT3kTBFNG+hcvgAyfRg=;
 b=IbJs96eSXJs6zLZbLsMER5/D0s2wfdgMk8D+e0MNL69jYq+7gFK2iXkw0lCnZsfgvm
 Oukl/6oxpOTnz/Mof98YEc268vLwUa6daH+8I2TwLvX+bvK1GJTrmTGdGljiKzlq9lkt
 9PBfAWsQtJeuxhkFrx7VxG+0JhfCoRxJ89uzOkQkmT8Iip9IugoEdNd+O7t1+ty0vuRd
 AdJisZHtR/g+BlLNb3Kr+40+NKlLf8qKV+Se1gqhXNg7hQ5FNqCofjzAHHf3VfLTDc6R
 dBz+3aPHRsgW71e6PrrVTBruBeE29XlZe6fHaL8QKM3vGSngJhICTK59DNz00kb9iJU6
 xMPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBm5Hdds5SVRTeUZ5ZHfJEr68l6JGBTl4WDVsMzbPLkXpnL/KVHqQWrE0HsoGbDN0VanuwtPgM2hoU@nongnu.org
X-Gm-Message-State: AOJu0YzoMDczqJsstpGAkwvQpMJKIe2MJT0lf3tnXlDTo3WnJRehJmoc
 YNrF4ZWpAFCI+57FuYG2rQU6L71zKCWD2UZwESc4n9pnHB+gGQl90EGZaPqyw/e3OqAVVj5JCyl
 hTEVG8i2rtXtVuoFUnOC36SH7OG8T+ruATfjXJVqvxQk2zCZ2Ap/bUz14
X-Gm-Gg: ASbGncsudbJxFlSgZLghqV9UwLhU0u/Vtt7uJsGYdGmng78sqhMbd4wROwMVUsWdl8v
 9bjJfNwGnzoSnQ3rsfyIzy1BNzDLn9U/QOJx2UhKJjSMpvWuXz3QoRADFwYqRC9FKulaNcp3W1w
 fmtXmOfdZLWsV6IOrvcRWYZn4n0LDY7pr9pVza1B865cD4CXLo0zb0vOpPg34OI/FRZzaeU8/MX
 t4a1tH+gKQNU8amAO1AqEbI1pldiJZATn2RJOlBYXAy7XoxnhZ5hOK7pink3rlxthsJ4AuFQAhN
 bYEZbp5l1nAETfFP+Dx3HDSNRTR/JzymAhPUJqEsWIymqkOXm5o1Dr3ZfJbOitiP
X-Received: by 2002:a05:6000:bd1:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3a6d27ec99emr6976407f8f.20.1750670443865; 
 Mon, 23 Jun 2025 02:20:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnvVOh0TtjnrxbyPJmyuxRJBwhqTF48Gmz2PPoHjVRrKmB5VKmAS0bs7l/rnc8/wIyFu2/iw==
X-Received: by 2002:a05:6000:bd1:b0:3a4:ce5c:5e8d with SMTP id
 ffacd0b85a97d-3a6d27ec99emr6976384f8f.20.1750670443462; 
 Mon, 23 Jun 2025 02:20:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb5ecsm107086065e9.8.2025.06.23.02.20.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 02:20:42 -0700 (PDT)
Message-ID: <aa4ef145-9e08-4ad9-a152-dd8fa2371436@redhat.com>
Date: Mon, 23 Jun 2025 11:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] hw/i386: Add the ramfb romfile compatatibility
Content-Language: en-US
To: Shaoqin Huang <shahuang@redhat.com>, qemu-arm@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
References: <20250617030521.2109305-1-shahuang@redhat.com>
 <20250617030521.2109305-3-shahuang@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20250617030521.2109305-3-shahuang@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 6/17/25 5:05 AM, Shaoqin Huang wrote:
> Set the "use-legacy-x86-rom" property to false by default, and only set
> it to true on x86 since only x86 will need it.
s/compatatibility/compatibility in the title
> 
> Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>  hw/display/ramfb-standalone.c | 2 +-
>  hw/i386/pc_q35.c              | 3 +++
>  hw/vfio/pci.c                 | 2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
> index af1175bf96..ddbf42f181 100644
> --- a/hw/display/ramfb-standalone.c
> +++ b/hw/display/ramfb-standalone.c
> @@ -63,7 +63,7 @@ static const VMStateDescription ramfb_dev_vmstate = {
>  
>  static const Property ramfb_properties[] = {
>      DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState, use_legacy_x86_rom, false),
>  };
>  
>  static void ramfb_class_initfn(ObjectClass *klass, void *data)
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index fd96d0345c..f6d89578d0 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -45,6 +45,7 @@
>  #include "hw/i386/pc.h"
>  #include "hw/i386/amd_iommu.h"
>  #include "hw/i386/intel_iommu.h"
> +#include "hw/vfio/pci.h"
>  #include "hw/virtio/virtio-iommu.h"
>  #include "hw/display/ramfb.h"
>  #include "hw/ide/pci.h"
> @@ -67,6 +68,8 @@
>  
>  static GlobalProperty pc_q35_compat_defaults[] = {
>      { TYPE_VIRTIO_IOMMU_PCI, "aw-bits", "39" },
> +    { TYPE_RAMFB_DEVICE, "use-legacy-x86-rom", "true" },
> +    { TYPE_VFIO_PCI, "use-legacy-x86-rom", "true" },
this will only keep the legacy behavior along with q35 machine type but
not on other machines being used for x86. what about pc-i440fx? Doesn't
it apply to it as well? Are there other machine types also impacted.

Also what about Daniel's comment in v3:
https://lore.kernel.org/all/aEak8utPPkHepVfR@redhat.com/
"For non-x86, historical versioned machine types will need
likely it set to true, in order to avoid the memory layout
being changed IIUC."

Is it actually needed?

Thanks

Eric
>  };
>  static const size_t pc_q35_compat_defaults_len =
>      G_N_ELEMENTS(pc_q35_compat_defaults);
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index ff0d93fae0..a529500b70 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3564,7 +3564,7 @@ static const TypeInfo vfio_pci_dev_info = {
>  
>  static const Property vfio_pci_dev_nohotplug_properties[] = {
>      DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
> -    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, true),
> +    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice, use_legacy_x86_rom, false),
>      DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
>                              ON_OFF_AUTO_AUTO),
>  };


