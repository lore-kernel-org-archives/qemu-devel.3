Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EDAE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 15:06:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCfV-0006pS-Qw; Mon, 16 Dec 2024 10:05:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNCfU-0006pE-57
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:05:56 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tNCfR-0006qK-4Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 10:05:55 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361c705434so30237295e9.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 07:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734361550; x=1734966350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7r4iinr4YP0OtNo/6/weqqG2igi7FvWL2mFvwPSm87Q=;
 b=ZHM1Nz2eR9T5fVp0w18Pm0m1QrA/HrJ6T3HCEycjUOhLS17/FRD7Zd/+/GVuDH4SXV
 /2JV+JVair1MVvahAixkFdKkB4uNF6ce8Qjd8Yq3DV8GwzJOWJmFnlQJMVSwkG+49amZ
 /FZ2PMqzSOHUkcsFrcj3qZW013NQn9dL8IEqTegwVl1w3Ng3YA++GSgt/VcXhXWCye25
 cCtMD2qaQoNjYNVubQo36kknaZ72ZTmTnfPp8r0R3fGP5SIKY1QBzUV+FYOvdDLadDb+
 6kIIVGKFZ0IO4+l9SoR9hP1XN6thU//FH95zEq0gF5AB+PSMpzGYNWkBhu/8t0EF3aEI
 fskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734361550; x=1734966350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7r4iinr4YP0OtNo/6/weqqG2igi7FvWL2mFvwPSm87Q=;
 b=mJZCJVEqvkMd5rIxIQgY3fFFAnzTw/QaR1eOCv30pMizDedJ02k7dBqUzEMawS05n5
 AR9ELyOgDXbdUO4Pbi8DV569LvUPXFsyiZoAsIsz0jqsAhEbzqzs+AVJwA3MjDOr9pdM
 2iOV6OJt26dI6XHasXXBvz/I9a61qCLKYUSTTecOfhFnoOP45JBi4R7ZPMMyyprukRxO
 cACRjF0uGxxgCbEf2336wFBsdtH0a62QYVGjAINC4WjBVMpFiRTckzMKn8sjlCqZzKNo
 oyEoj5xPJuMw86HECarUS75tZVLfmeaBdrc0fo6LX+MCPRQk5a6JBTmcTSnWSV+Mzqum
 XhxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNSN28Vc/YPxsJM1Pd4ZxoE29UlbIO0T+rMhdjze052njgKDgaLmPEQONMtGj6/9eCnqa1O5IyJAHh@nongnu.org
X-Gm-Message-State: AOJu0YyTdPH1VBJhm4ssOc9Jsxgf1xUszmqgc6httT3KOA+ovnP89U1r
 +1gNVEHShJyRavcHGJow+6QtuQ+6JQCjy6hKmHveU+OekLgEOo8pHdDbSluLSgrgOyUNSnaI64o
 4
X-Gm-Gg: ASbGnctjHCXa8vvs24mRVO/X47O2MBzzhriUVAIPFEaUMMuTeLmXjXxwfLZ3U7GNmqp
 z1ov7It9tBA8YM7Ei4r5+4zkQGaQQfQ7xPsCZyJxNEPlTNqOoi4Y018t5Xd+xo6i/WpXsh7wSxs
 IsN3PMKwyXtO4p9uTmtZtdWlgzAfnSzYsMo/qcayc7d8V/01Ps94Mh+AG9PPPJFOJnyN/yNRCS9
 n+I9im79BsyYf/WX0/OrvbA93DFR3e4JVjkeCZOqaMBGhf52ys06whHarfS+sI8w/FTT2dP
X-Google-Smtp-Source: AGHT+IG68WGFxNS96b0ozgHnekJXBBFxAU/TuhIWxCSXdMTaTtaN7VvFVRO1WyFG6zvhy7vLLFZFdw==
X-Received: by 2002:a05:6000:1562:b0:385:edd1:2245 with SMTP id
 ffacd0b85a97d-38880ae114dmr10041756f8f.30.1734361549640; 
 Mon, 16 Dec 2024 07:05:49 -0800 (PST)
Received: from [192.168.1.117] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4362555053esm143270065e9.1.2024.12.16.07.05.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Dec 2024 07:05:48 -0800 (PST)
Message-ID: <26c97140-6ec5-49f5-b0d4-d4f7f82a12f0@linaro.org>
Date: Mon, 16 Dec 2024 16:05:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/misc/vmfwupdate: Introduce hypervisor fw-cfg
 interface support
To: Ani Sinha <anisinha@redhat.com>, Alex Graf <graf@amazon.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffman <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
References: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241216114841.1025070-1-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Hi Ani,

On 16/12/24 12:48, Ani Sinha wrote:
> VM firmware update is a mechanism where the virtual machines can use their
> preferred and trusted firmware image in their execution environment without
> having to depend on a untrusted party to provide the firmware bundle. This is
> particularly useful for confidential virtual machines that are deployed in the
> cloud where the tenant and the cloud provider are two different entities. In
> this scenario, virtual machines can bring their own trusted firmware image
> bundled as a part of their filesystem (using UKIs for example[1]) and then use
> this hypervisor interface to update to their trusted firmware image. This also
> allows the guests to have a consistent measurements on the firmware image.
> 
> This change introduces basic support for the fw-cfg based hypervisor interface
> and the corresponding device. The change also includes the
> specification document for this interface. The interface is made generic
> enough so that guests are free to use their own ABI to pass required
> information between initial and trusted execution contexts (where they are
> running their own trusted firmware image) without the hypervisor getting
> involved in between. In subsequent patches, we will introduce other minimal
> changes on the hypervisor that are required to make the mechanism work.
> 
> [1] See systemd pull requests https://github.com/systemd/systemd/pull/35091
> and https://github.com/systemd/systemd/pull/35281 for some discussions on
> how we can bundle firmware image within an UKI.
> 
> CC: Alex Graf <graf@amazon.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Gerd Hoffman <kraxel@redhat.com>
> CC: Igor Mammedov <imammedo@redhat.com>
> CC: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>   MAINTAINERS                  |   9 ++
>   docs/specs/index.rst         |   1 +
>   docs/specs/vmfwupdate.rst    | 109 ++++++++++++++++++++++++
>   hw/misc/meson.build          |   2 +
>   hw/misc/vmfwupdate.c         | 157 +++++++++++++++++++++++++++++++++++
>   include/hw/misc/vmfwupdate.h | 103 +++++++++++++++++++++++
>   6 files changed, 381 insertions(+)
>   create mode 100644 docs/specs/vmfwupdate.rst
>   create mode 100644 hw/misc/vmfwupdate.c
>   create mode 100644 include/hw/misc/vmfwupdate.h

Can we have a test?

> diff --git a/hw/misc/meson.build b/hw/misc/meson.build
> index d02d96e403..4c5bdb0de2 100644
> --- a/hw/misc/meson.build
> +++ b/hw/misc/meson.build
> @@ -148,6 +148,8 @@ specific_ss.add(when: 'CONFIG_MAC_VIA', if_true: files('mac_via.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_cmgcr.c', 'mips_cpc.c'))
>   specific_ss.add(when: 'CONFIG_MIPS_ITU', if_true: files('mips_itu.c'))
>   
> +specific_ss.add(when: 'CONFIG_FW_CFG_DMA', if_true: files('vmfwupdate.c'))
> +
>   system_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa_ec.c'))
>   
>   # HPPA devices
> diff --git a/hw/misc/vmfwupdate.c b/hw/misc/vmfwupdate.c
> new file mode 100644
> index 0000000000..1e29a610c0
> --- /dev/null
> +++ b/hw/misc/vmfwupdate.c
> @@ -0,0 +1,157 @@
> +/*
> + * Guest driven VM boot component update device
> + * For details and specification, please look at docs/specs/vmfwupdate.rst.
> + *
> + * Copyright (C) 2024 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/module.h"
> +#include "sysemu/reset.h"
> +#include "hw/nvram/fw_cfg.h"
> +#include "hw/i386/pc.h"
> +#include "hw/qdev-properties.h"
> +#include "hw/misc/vmfwupdate.h"
> +#include "qemu/error-report.h"
> +
> +static void fw_update_reset(void *dev)
> +{
> +    /* a NOOP at present */
> +    return;
> +}
> +
> +
> +static uint64_t get_max_fw_size(void)
> +{
> +    Object *m_obj = qdev_get_machine();
> +    PCMachineState *pcms = PC_MACHINE(m_obj);
> +
> +    if (pcms) {
> +        return pcms->max_fw_size;
> +    } else {
> +        return 0;
> +    }
> +}
> +
> +static void fw_blob_write(void *dev, off_t offset, size_t len)
> +{
> +    VMFwUpdateState *s = VMFWUPDATE(dev);
> +
> +    /* for non-pc platform, we do not allow changing bios_size yet */
> +    if (!s->plat_bios_size) {
> +        return;
> +    }
> +
> +    /*
> +     * in order to change the bios size, appropriate capability
> +     * must be enabled
> +     */
> +    if (s->fw_blob.bios_size &&
> +        !(s->capability & VMFWUPDATE_CAP_BIOS_RESIZE)) {
> +        warn_report("vmfwupdate: VMFWUPDATE_CAP_BIOS_RESIZE not enabled");
> +        return;
> +    }
> +
> +    s->plat_bios_size = s->fw_blob.bios_size;
> +
> +    return;
> +}
> +
> +static void vmfwupdate_realize(DeviceState *dev, Error **errp)
> +{
> +    VMFwUpdateState *s = VMFWUPDATE(dev);
> +    FWCfgState *fw_cfg = fw_cfg_find();
> +
> +    /* multiple devices are not supported */
> +    if (!vmfwupdate_find()) {
> +        error_setg(errp, "at most one %s device is permitted",
> +                   TYPE_VMFWUPDATE);
> +        return;
> +    }
> +
> +    /* fw_cfg with DMA support is necessary to support this device */
> +    if (!fw_cfg || !fw_cfg_dma_enabled(fw_cfg)) {
> +        error_setg(errp, "%s device requires fw_cfg",
> +                   TYPE_VMFWUPDATE);
> +        return;
> +    }
> +
> +    memset(&s->fw_blob, 0, sizeof(s->fw_blob));
> +    memset(&s->opaque_blobs, 0, sizeof(s->opaque_blobs));
> +
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_OBLOB,
> +                             NULL, NULL, s,
> +                             &s->opaque_blobs,
> +                             sizeof(s->opaque_blobs),
> +                             false);
> +
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_FWBLOB,
> +                             NULL, fw_blob_write, s,
> +                             &s->fw_blob,
> +                             sizeof(s->fw_blob),
> +                             false);
> +
> +    /*
> +     * Add global capability fw_cfg file. This will be used by the guest to
> +     * check capability of the hypervisor.
> +     */
> +    s->capability = cpu_to_le16(CAP_VMFWUPD_MASK | VMFWUPDATE_CAP_EDKROM);
> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_CAP,
> +                    &s->capability, sizeof(s->capability));
> +
> +    s->plat_bios_size = get_max_fw_size(); /* for non-pc, this is 0 */
> +    /* size of bios region for the platform - read only by the guest */
> +    fw_cfg_add_file(fw_cfg, FILE_VMFWUPDATE_BIOS_SIZE,
> +                    &s->plat_bios_size, sizeof(s->plat_bios_size));
> +    /*
> +     * add fw cfg control file to disable the hypervisor interface.
> +     */
> +    fw_cfg_add_file_callback(fw_cfg, FILE_VMFWUPDATE_CONTROL,
> +                             NULL, NULL, s,
> +                             &s->disable,
> +                             sizeof(s->disable),
> +                             false);
> +    /*
> +     * This device requires to register a global reset because it is
> +     * not plugged to a bus (which, as its QOM parent, would reset it).
> +     */
> +    qemu_register_reset(fw_update_reset, dev);
> +}
> +
> +static Property vmfwupdate_properties[] = {
> +    DEFINE_PROP_UINT8("disable", VMFwUpdateState, disable, 0),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void vmfwupdate_device_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(klass);
> +
> +    /* we are not interested in migration - so no need to populate dc->vmsd */
> +    dc->desc = "VM firmware blob update device";
> +    dc->realize = vmfwupdate_realize;
> +    dc->hotpluggable = false;
> +    device_class_set_props(dc, vmfwupdate_properties);
> +    set_bit(DEVICE_CATEGORY_MISC, dc->categories);

How is this device instantiated?

> +}
> +
> +static const TypeInfo vmfwupdate_device_info = {
> +    .name          = TYPE_VMFWUPDATE,
> +    .parent        = TYPE_DEVICE,
> +    .instance_size = sizeof(VMFwUpdateState),
> +    .class_init    = vmfwupdate_device_class_init,
> +};
> +
> +static void vmfwupdate_register_types(void)
> +{
> +    type_register_static(&vmfwupdate_device_info);

New models should use DEFINE_TYPES().

> +}
> +
> +type_init(vmfwupdate_register_types);
> diff --git a/include/hw/misc/vmfwupdate.h b/include/hw/misc/vmfwupdate.h
> new file mode 100644
> index 0000000000..e9229d807b
> --- /dev/null
> +++ b/include/hw/misc/vmfwupdate.h
> @@ -0,0 +1,103 @@
> +/*
> + * Guest driven VM boot component update device
> + * For details and specification, please look at docs/specs/vmfwupdate.rst.
> + *
> + * Copyright (C) 2024 Red Hat, Inc.
> + *
> + * Authors: Ani Sinha <anisinha@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +#ifndef VMFWUPDATE_H
> +#define VMFWUPDATE_H
> +
> +#include "hw/qdev-core.h"
> +#include "qom/object.h"
> +#include "qemu/units.h"
> +
> +#define TYPE_VMFWUPDATE "vmfwupdate"
> +
> +#define VMFWUPDCAPMSK  0xffff /* least significant 16 capability bits */
> +
> +#define VMFWUPDATE_CAP_EDKROM 0x08 /* bit 4 represents support for EDKROM */
> +#define VMFWUPDATE_CAP_BIOS_RESIZE 0x04 /* guests may resize bios region */
> +#define CAP_VMFWUPD_MASK 0x80
> +
> +#define VMFWUPDATE_OPAQUE_SIZE (1024 * MiB)
> +
> +/* fw_cfg file definitions */
> +#define FILE_VMFWUPDATE_OBLOB "etc/vmfwupdate/opaque-blob"
> +#define FILE_VMFWUPDATE_FWBLOB "etc/vmfwupdate/fw-blob"
> +#define FILE_VMFWUPDATE_CAP "etc/vmfwupdate/cap"
> +#define FILE_VMFWUPDATE_BIOS_SIZE "etc/vmfwupdate/bios-size"
> +#define FILE_VMFWUPDATE_CONTROL "etc/vmfwupdate/disable"
> +
> +/*
> + * Address and length of the guest provided firmware blob.
> + * The blob itself is passed using the guest shared memory to QEMU.
> + * This is then copied to the guest private memeory in the secure vm
> + * by the hypervisor.
> + */
> +typedef struct {
> +    uint32_t bios_size; /*
> +                         * this is used by the guest to update plat_bios_size
> +                         * when VMFWUPDATE_CAP_BIOS_RESIZE is set.
> +                         */
> +    uint64_t bios_paddr; /*
> +                          * starting gpa where the blob is in shared guest
> +                          * memory. Cleared upon system reset.
> +                          */
> +} VMFwUpdateFwBlob;
> +
> +typedef struct VMFwUpdateState {
> +    DeviceState parent_obj;
> +
> +    /*
> +     * capabilities - 64 bits.
> +     * Little endian format.
> +     */
> +    uint64_t capability;
> +
> +    /*
> +     * size of the bios region - architecture dependent.
> +     * Read-only by the guest unless VMFWUPDATE_CAP_BIOS_RESIZE
> +     * capability is set.
> +     */
> +    uint32_t plat_bios_size;
> +
> +    /*
> +     * disable - disables the interface when non-zero value is written to it.
> +     * Writing 0 to this file enables the interface.
> +     */
> +    uint8_t disable;
> +
> +    /*
> +     * The first stage boot uses this opaque blob to convey to the next stage
> +     * where the next stage components are loaded. The exact structure and
> +     * number of entries are unknown to the hypervisor and the hypervisor
> +     * does not touch this memory or do any validations.
> +     * The contents of this memory needs to be validated by the guest and
> +     * must be ABI compatible between the first and second stages.
> +     */
> +    unsigned char opaque_blobs[VMFWUPDATE_OPAQUE_SIZE];
> +
> +    /*
> +     * firmware blob addresses and sizes. These are moved to guest
> +     * private memory.
> +     */
> +    VMFwUpdateFwBlob fw_blob;
> +} VMFwUpdateState;
> +
> +OBJECT_DECLARE_SIMPLE_TYPE(VMFwUpdateState, VMFWUPDATE);
> +
> +/* returns NULL unless there is exactly one device */
> +static inline VMFwUpdateState *vmfwupdate_find(void)

What is the point of this helper? Why inline it in header?

> +{
> +    Object *o = object_resolve_path_type("", TYPE_VMFWUPDATE, NULL);
> +
> +    return o ? VMFWUPDATE(o) : NULL;
> +}
> +
> +#endif


