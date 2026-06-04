Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDB8CD6E6B
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:15:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV6xt-000756-W9; Thu, 04 Jun 2026 08:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6xr-00073C-75
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:14:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1wV6xo-0005h5-Pl
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:14:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780575258;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S4fOxdJhGEH8bp7SeHy15zCxGqh4MUpx91ihvBdC4Tw=;
 b=RfxY9DM1AFQZwYu6We0qeEYUPBtbbbjFBl16Cf0xVxvO7On5mNHAeAkbRzbiC2XrGA2TN9
 UklX4zvZ5jz0vr86P1DWHZZxH94ynfdDtkdY0yVQp8F8K2Rqgeox35genFU9tX6sJTKdZn
 M7adpfsvlaYbWXJbWQqeVfO/Y9sXwxA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-tJXp8iz1PyGce-aubVKXaA-1; Thu, 04 Jun 2026 08:14:17 -0400
X-MC-Unique: tJXp8iz1PyGce-aubVKXaA-1
X-Mimecast-MFC-AGG-ID: tJXp8iz1PyGce-aubVKXaA_1780575256
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490bae3a39bso7073645e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 05:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780575256; x=1781180056;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4fOxdJhGEH8bp7SeHy15zCxGqh4MUpx91ihvBdC4Tw=;
 b=pRUpOYC5y71Rqn+w1u8buS06IMk6nvYLTGc/NlwY78MHv1t4Dj0SYYf8xI+8ML3u6O
 yuEHmQ0vh6iImpS1g2U5v6U1EDERD1KhxgwAvKq1Q8YlHCTP+JCnJsCMbfraMOmj8dma
 zyBeBgnAPFKarStlgUMwXh01Ai0uM3kCDb3QqDmal9Rh4CwEp5X+RIv65TkNInP3aPoG
 CVSXAIoPSvGiP+cboMxFY+rpq2SHXFhMH0GCBbeV3rPf3DHkNQMSweTS1CPZ1wfyMYGN
 Kl4hC+yBRnOjdH6T4czNKhycDjgZYtXoA1MWv0lnT+rjHSAvJv9KBMT7CX6+HnQCcKvH
 i3CQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/sQ8Z2HKJATEx4zHjlZINTJJYltNGYdsfkva8mEZ0mRTVIGHgVbumZIi04LL1A7dTvJOaa9qie6Nl8@nongnu.org
X-Gm-Message-State: AOJu0YwK9hie15OSlvTFJ8QyoQeVMaTOgqLZzpvr4vJf0U5Pm3qwI4yZ
 X9yWxN9EQ0QuuJhtdN1/ysMXA2ciZZjS0guVM48d0DZQC7vMCbhU8pm9VrFWdPxkjeyBt5bwGLO
 k8pdNEOp6C8nAH+bC864qlt3t7sJZNM+DKrIN1HDHmFJrvKIMdfFpN8DZ
X-Gm-Gg: Acq92OE3tVAMwTVAipwUzIAXbGkUCfRwb0HTl3RPnm+7fjfGQu3UM95rGjcF+dkG9Rj
 IQDmxztMB7mZiF7wvOvk2QPB9PsOPsgObPvo3ij6X11qtYoenhr6l1haxyq2qIcU9BAFPFZxq0C
 XweZs1mh/fz61fqsds1aEK1A4Nc2X5utjGh6Z1c3KNLkDGABOzSIA6yzxOgv3KBtfxs60z81sZd
 aW+SrIalDFub9kW3LEhYVSrnxMXy1XH7EArUXOQAUvLlW5tgqFuMbZTUmPIXDfDAY7Dt7f02F0l
 4pi/sjfw4i3ks8e+99QFRUi4FV7/WtqFel6oM6qhmBVecD4IENe36uDeryz2MXwMOrIusUm2SCS
 cuADrB4PyAh/gEy40/ffSaTP1oqFuJ9aAcpRWlS3UTK+owH0U6TE/s4lOm+RHWF2UmRo93G2jPj
 8/kLYI
X-Received: by 2002:a05:600c:8216:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-490b610a410mr119575585e9.33.1780575256226; 
 Thu, 04 Jun 2026 05:14:16 -0700 (PDT)
X-Received: by 2002:a05:600c:8216:b0:490:9588:bdb6 with SMTP id
 5b1f17b1804b1-490b610a410mr119575205e9.33.1780575255778; 
 Thu, 04 Jun 2026 05:14:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b7a273e3sm103740865e9.0.2026.06.04.05.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:14:15 -0700 (PDT)
Message-ID: <4086087f-1513-488e-b927-b268773cafe7@redhat.com>
Date: Thu, 4 Jun 2026 14:14:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 29/31] hw/arm/smmuv3-accel: Enforce viommu association
 when CMDQV is active
Content-Language: en-US
To: Shameer Kolothum <skolothumtho@nvidia.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@redhat.com, alex@shazbot.org,
 nicolinc@nvidia.com, nathanc@nvidia.com, mochs@nvidia.com, jan@nvidia.com,
 jgg@nvidia.com, zhenzhong.duan@intel.com, kjaju@nvidia.com,
 phrdina@redhat.com
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
 <20260601114221.457995-30-skolothumtho@nvidia.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20260601114221.457995-30-skolothumtho@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 6/1/26 1:42 PM, Shameer Kolothum wrote:
> When CMDQV is active, the first cold-plugged VFIO device establishes
> the viommu to host SMMUv3 association, and the guest's boot-time CMDQV
> configuration (VINTFs, VCMDQs) is built on top of that association.
>
> Hot-unplugging that device would release the viommu and tear down all
> CMDQV state. Hot-plugging another device behind a different host
> SMMUv3+CMDQV would then re-bind the same vSMMUv3 to new host hardware,
> while the guest keeps using its boot-time configuration and ends up
> issuing commands to the wrong host. Block hot-unplug of the
> establishing device to avoid this; retaining the binding across unplug
> is non-trivial and not required by any current use case.
>
> Also abort at machine_done if cmdqv=on is requested but no cold-plugged
> VFIO device was present to initialize it.
>
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/arm/smmuv3-accel.h |  1 +
>  hw/arm/smmuv3-accel.c | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
> index 5fc85fb89d..dd755c394d 100644
> --- a/hw/arm/smmuv3-accel.h
> +++ b/hw/arm/smmuv3-accel.h
> @@ -84,6 +84,7 @@ typedef struct SMMUv3AccelDevice {
>      IOMMUFDVdev *vdev;
>      QLIST_ENTRY(SMMUv3AccelDevice) next;
>      SMMUv3AccelState *s_accel;
> +    Error *unplug_blocker; /* set when CMDQV is active to block hot-unplug */
>  } SMMUv3AccelDevice;
>  
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp);
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index 9c3bd4413d..80900c2521 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -759,6 +759,18 @@ static bool smmuv3_accel_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>          return false;
>      }
>  
> +    /*
> +     * CMDQV is active: block hot-unplug of the device that established the
> +     * viommu association. Removing it would cause the vIOMMU to host SMMUv3
> +     * association be changed via device hot-plug.
> +     */
> +    if (s->s_accel->cmdqv_ops) {
> +        PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
> +        error_setg(&accel_dev->unplug_blocker,
> +                   "CMDQV is active: removing the device that established the "
> +                   "viommu association would break the guest CMDQV");
> +        qdev_add_unplug_blocker(DEVICE(pdev), accel_dev->unplug_blocker);
> +    }
>  done:
>      accel_dev->hiodi = hiodi;
>      accel_dev->s_accel = s->s_accel;
> @@ -1082,6 +1094,12 @@ static void smmuv3_accel_machine_done(Notifier *notifier, void *data)
>                       "at least one cold-plugged VFIO device");
>          exit(1);
>      }
> +
> +    if (s->cmdqv == ON_OFF_AUTO_ON && !accel->cmdqv) {
> +        error_report("arm-smmuv3 cmdqv=on requires at least one cold-plugged "
> +                     "VFIO device");
> +        exit(1);
> +    }
>  }
>  
>  bool smmuv3_accel_init(SMMUv3State *s, Error **errp)


