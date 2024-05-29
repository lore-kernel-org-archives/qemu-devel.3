Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126B1C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 14:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCKMo-0008Od-9g; Wed, 29 May 2024 10:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKMn-0008OM-1B
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:33:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sCKMl-0001cG-D2
 for qemu-devel@nongnu.org; Wed, 29 May 2024 10:33:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716993202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3vFzH33+NQiuSN+CO+0+Fdi8kvD//hv8WgtX9RG9zM=;
 b=StdYrTDheGHVvGsb086834kH5tmyDufG+wlyfBZDNm6YMlU1SkbS5tiFANn+YPWN3Hxkfo
 mrvAuPs5jT66QgP0JCTn5u6wfwj019x5I0drdrQkP+XUYaB7+3f8tH875Cs1+VNIf4MB1k
 ThEe3KQKBdFDXJS/Z9B2U6gJ8oCwVF0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-gqZZ0CsMMluPUgF-ympHqw-1; Wed, 29 May 2024 10:33:20 -0400
X-MC-Unique: gqZZ0CsMMluPUgF-ympHqw-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5236c5cec7dso1821921e87.2
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 07:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716993199; x=1717597999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3vFzH33+NQiuSN+CO+0+Fdi8kvD//hv8WgtX9RG9zM=;
 b=uuW1cIPwusHlclKe6ImB8NK0EmwrCCb+QL6QQ5hrG/ZS5k/0t1/uIjXGhX0qABSB+w
 NIt/pIpXG9OlePw86n1GZNbKqigjJsqYbG2uBpRY3k+Ts2tXVFkjlmCMBF4KjHLbCknL
 PTgrH2DD4Dp7UollBZ0sq3SXNpDdvxS6KuMSCMjTdEWHCljZCeAUl/QIgSRy7jHUstQp
 tLwBffuWihcLR2siH3RAJSyz/37g7vQ8w/ALlZHecLGDWasGu+KNL7qnKbKQziF3yLJl
 HQjOr/5d+TRCd9xcD4gwnOEklIWK4+91i2PAcr4wEoPC0m78r8gRj+xXsqKHlm984x8o
 LchQ==
X-Gm-Message-State: AOJu0YyayImu5C7UNp6nfuTUjamlaE+X3DS7cYKax25aJkOmPKXrsHY0
 sLXjjXfqTAV/xPmvla+CRg+CmZOcumEMCGi7CYFO03OINrnB78nbasGtnPz3BiuSLS1sKoe9xWW
 /3AX40MCtmTk5zweXqkiWURSPz7abpcd2O3gV7D2p+m0x+u1Kkduz
X-Received: by 2002:a05:6512:2398:b0:51c:cc1b:a8f6 with SMTP id
 2adb3069b0e04-5296556f18cmr18321032e87.20.1716993199128; 
 Wed, 29 May 2024 07:33:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG53nEnK57Z5mOP9I6+Bq99zgtWKbw4ddibZiUprPi3FMeCVDPFfVmyY3Q2sSp84M80+r320g==
X-Received: by 2002:a05:6512:2398:b0:51c:cc1b:a8f6 with SMTP id
 2adb3069b0e04-5296556f18cmr18320998e87.20.1716993198612; 
 Wed, 29 May 2024 07:33:18 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4211e43e8easm61930665e9.16.2024.05.29.07.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:33:18 -0700 (PDT)
Date: Wed, 29 May 2024 16:33:17 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P .
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, David Hildenbrand
 <david@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH v5 15/23] hw/mem/memory-device: Remove legacy_align from
 memory_device_pre_plug()
Message-ID: <20240529163317.4004452e@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240529051539.71210-16-philmd@linaro.org>
References: <20240529051539.71210-1-philmd@linaro.org>
 <20240529051539.71210-16-philmd@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, 29 May 2024 07:15:31 +0200
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:

> 'legacy_align' is always NULL, remove it, simplifying
> memory_device_pre_plug().
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  include/hw/mem/memory-device.h |  2 +-
>  hw/i386/pc.c                   |  3 +--
>  hw/mem/memory-device.c         | 12 ++++--------
>  hw/mem/pc-dimm.c               |  2 +-
>  hw/virtio/virtio-md-pci.c      |  2 +-
>  5 files changed, 8 insertions(+), 13 deletions(-)
>=20
> diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-devic=
e.h
> index e0571c8a31..c0a58087cc 100644
> --- a/include/hw/mem/memory-device.h
> +++ b/include/hw/mem/memory-device.h
> @@ -169,7 +169,7 @@ uint64_t get_plugged_memory_size(void);
>  unsigned int memory_devices_get_reserved_memslots(void);
>  bool memory_devices_memslot_auto_decision_active(void);
>  void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
> -                            const uint64_t *legacy_align, Error **errp);
> +                            Error **errp);
>  void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
>  void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
>  uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 08d38a1dcc..c7d44420a5 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1389,8 +1389,7 @@ static void pc_hv_balloon_pre_plug(HotplugHandler *=
hotplug_dev,
>  {
>      /* The vmbus handler has no hotplug handler; we should never end up =
here. */
>      g_assert(!dev->hotplugged);
> -    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), NUL=
L,
> -                           errp);
> +    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev), err=
p);
>  }
> =20
>  static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index e098585cda..a5f279adcc 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -345,7 +345,7 @@ uint64_t get_plugged_memory_size(void)
>  }
> =20
>  void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
> -                            const uint64_t *legacy_align, Error **errp)
> +                            Error **errp)
>  {
>      const MemoryDeviceClass *mdc =3D MEMORY_DEVICE_GET_CLASS(md);
>      Error *local_err =3D NULL;
> @@ -388,14 +388,10 @@ void memory_device_pre_plug(MemoryDeviceState *md, =
MachineState *ms,
>          return;
>      }
> =20
> -    if (legacy_align) {
> -        align =3D *legacy_align;
> -    } else {
> -        if (mdc->get_min_alignment) {
> -            align =3D mdc->get_min_alignment(md);
> -        }
> -        align =3D MAX(align, memory_region_get_alignment(mr));
> +    if (mdc->get_min_alignment) {
> +        align =3D mdc->get_min_alignment(md);
>      }
> +    align =3D MAX(align, memory_region_get_alignment(mr));
>      addr =3D mdc->get_addr(md);
>      addr =3D memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
>                                         memory_region_size(mr), &local_er=
r);
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 836384a90f..27919ca45d 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -69,7 +69,7 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState =
*machine, Error **errp)
>                              &error_abort);
>      trace_mhp_pc_dimm_assigned_slot(slot);
> =20
> -    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, NULL, errp);
> +    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, errp);
>  }
> =20
>  void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine)
> diff --git a/hw/virtio/virtio-md-pci.c b/hw/virtio/virtio-md-pci.c
> index 62bfb7920b..9ec5067662 100644
> --- a/hw/virtio/virtio-md-pci.c
> +++ b/hw/virtio/virtio-md-pci.c
> @@ -37,7 +37,7 @@ void virtio_md_pci_pre_plug(VirtIOMDPCI *vmd, MachineSt=
ate *ms, Error **errp)
>       * First, see if we can plug this memory device at all. If that
>       * succeeds, branch of to the actual hotplug handler.
>       */
> -    memory_device_pre_plug(md, ms, NULL, &local_err);
> +    memory_device_pre_plug(md, ms, &local_err);
>      if (!local_err && bus_handler) {
>          hotplug_handler_pre_plug(bus_handler, dev, &local_err);
>      }


