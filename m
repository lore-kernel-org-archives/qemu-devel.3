Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD63D6DDF8
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 13:06:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBw1k-0002JE-4z; Fri, 15 Nov 2024 08:06:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBw1i-0002Hu-LS
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:06:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBw1g-0003jn-OC
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 08:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731675973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NQXaD2JOR6RELQ/812VXtwWSQD+1Nv8ZT5YA6GVKVic=;
 b=HOtK8ucSDwUq4Qcn65EnPj78l/+Tqu6QoguafdhZioTO/bGp3c2XeiR1rra8ZpKQOEIV2z
 x3sN2befwZud+whPSUBh2qAdfUJ8+K6X2O1nHC/QZXtTnQvILsdPyY6FZFgggZNYecadFe
 xt0p202Pt/Aakon6O7uzjwbOL6djhkA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-vhhxxV5CMcG6uLsTZL5CbA-1; Fri, 15 Nov 2024 08:06:12 -0500
X-MC-Unique: vhhxxV5CMcG6uLsTZL5CbA-1
X-Mimecast-MFC-AGG-ID: vhhxxV5CMcG6uLsTZL5CbA
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3822ec50b64so91919f8f.1
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2024 05:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731675971; x=1732280771;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NQXaD2JOR6RELQ/812VXtwWSQD+1Nv8ZT5YA6GVKVic=;
 b=PsH74JXdBnPoIEYO/IyR+zbjA/76iJaK9IWP7MoOFpPQNKLPytl40vSuAxRzcnJlLY
 4iQUuz4X5Pi/ZXPF/5CkoEra77MV33Dm0EB/fNv3Luc0KS5/lJTYSlW9cSDkwp7xxYlF
 CgSXaOpPjQBZHMgci2MIbQpWJKdHIsE/LcvM8zGosDbgUpROg7dV+WiO5v5mSQAYHbUb
 CAd1mtAT5m5ZgpTHb92zfx3I0nYaiAi5EVujwMz2/3/MmsIhl0u9aXSQ8lGxzO/vpTyz
 dPW6F3BxdtDDnaz6LnNea74QWJNdxhuq4urrL6aw+pwiWgOn1tS73jvLRtIH8m55d9AG
 yX4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEFpW0adCLj/23NbntozD4iZqixTh8xjo9rq2AKO7eqlLI8qU2VUA2ScTWQ+yW+2J5u/lk5XAmwiUV@nongnu.org
X-Gm-Message-State: AOJu0YytSvUQce5rVqiIaJHtlBiDYM3Zu/xmObLYbK+vemUAh1O3Aqag
 7/EEIGbXJyCAyXJpiPEOhshj030Er2fHiQcIWRk84FXHQ7dpgS7SpaYgBuGh9Plx0PtqJNRgcIM
 j2PdtC2zs67udqV5e9F6pbdKnhjOJJdy0r+njOyHw6T8K8sb0opyr
X-Received: by 2002:a5d:6488:0:b0:382:1e06:fb0 with SMTP id
 ffacd0b85a97d-38225aa63a2mr2142965f8f.56.1731675971278; 
 Fri, 15 Nov 2024 05:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJWaNYLIGVLFOhTPYjKj6vLIfiwOi6CzLrFsmHlmExgXtwSyAxnclvxZEn3Se60MB35IIM/w==
X-Received: by 2002:a5d:6488:0:b0:382:1e06:fb0 with SMTP id
 ffacd0b85a97d-38225aa63a2mr2142939f8f.56.1731675970841; 
 Fri, 15 Nov 2024 05:06:10 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3821adbe7dfsm4301782f8f.56.2024.11.15.05.06.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Nov 2024 05:06:10 -0800 (PST)
Message-ID: <9758c8c2-7496-493d-b33f-ce620caef25f@redhat.com>
Date: Fri, 15 Nov 2024 14:05:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw: Add "loadparm" property to scsi disk devices for
 booting on s390x
To: Thomas Huth <thuth@redhat.com>
Cc: Jared Rossi <jrossi@linux.ibm.com>, qemu-devel@nongnu.org,
 Boris Fiuczynski <fiuczy@linux.ibm.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Farman <farman@linux.ibm.com>
References: <20241114122919.973930-1-thuth@redhat.com>
 <9e7cb217-a33e-48aa-b030-efb991ca33f3@linux.ibm.com>
 <f0315077-eb61-4134-b81a-7d33906c6d31@redhat.com>
 <31889800-47fc-4ee0-8016-58a9d82b2719@linux.ibm.com>
 <0e9b5272-2aa9-41a4-b0bb-43f0c89751e7@redhat.com>
 <CABgObfZ5VqJUd9+HvoRkBqeg=pMo_WaZDop_jiRnrCz=gfTRfw@mail.gmail.com>
 <59fa56b8-46f6-4590-9e2e-07b4a935e0bf@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <59fa56b8-46f6-4590-9e2e-07b4a935e0bf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.12,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.658,
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

On 11/15/24 13:26, Thomas Huth wrote:
> On 15/11/2024 12.49, Paolo Bonzini wrote:
>> On Fri, Nov 15, 2024 at 7:30 AM Thomas Huth <thuth@redhat.com> wrote:
>>> Ok, great! Sounds like we have a passable solution for QEMU 9.2. We 
>>> still
>>> can refine the loadparm handling of the scsi devices in future QEMU
>>> releases, but this will now at least solve the present problem that 
>>> Boris
>>> reported from the libvirt side.
>>
>> Please put in the release notes that in the future loadparm might be
>> limited to s390 emulators... Not sure how, but we'll come up with
>> something.
> 
> Sure, will do!
> 
> Alternatively, would you rather prefer something like this for the common
> scsi code:

Sure!  I completely forgot about arch_type.

Paolo

> 
> diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> index c1fa02883d..5c9362fa83 100644
> --- a/hw/scsi/scsi-disk.c
> +++ b/hw/scsi/scsi-disk.c
> @@ -32,6 +32,7 @@
>   #include "migration/vmstate.h"
>   #include "hw/scsi/emulation.h"
>   #include "scsi/constants.h"
> +#include "sysemu/arch_init.h"
>   #include "sysemu/block-backend.h"
>   #include "sysemu/blockdev.h"
>   #include "hw/block/block.h"
> @@ -3136,6 +3137,31 @@ BlockAIOCB *scsi_dma_writev(int64_t offset, 
> QEMUIOVector *iov,
>       return blk_aio_pwritev(s->qdev.conf.blk, offset, iov, 0, cb, 
> cb_opaque);
>   }
> 
> +static char *scsi_property_get_loadparm(Object *obj, Error **errp)
> +{
> +    return g_strdup(SCSI_DISK_BASE(obj)->loadparm);
> +}
> +
> +static void scsi_property_set_loadparm(Object *obj, const char *value,
> +                                       Error **errp)
> +{
> +    SCSI_DISK_BASE(obj)->loadparm = g_strdup(value);
> +}
> +
> +static void scsi_property_add_specifics(DeviceClass *dc)
> +{
> +    ObjectClass *oc = OBJECT_CLASS(dc);
> +
> +    /* The loadparm property is only supported on s390x */
> +    if (arch_type & QEMU_ARCH_S390X) {
> +        object_class_property_add_str(oc, "loadparm",
> +                                      scsi_property_get_loadparm,
> +                                      scsi_property_set_loadparm);
> +        object_class_property_set_description(oc, "loadparm",
> +                                              "load parameter (s390x 
> only)");
> +    }
> +}
> +
>   static void scsi_disk_base_class_initfn(ObjectClass *klass, void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -3166,7 +3192,6 @@ static const TypeInfo scsi_disk_base_info = {
>       DEFINE_PROP_STRING("vendor", SCSIDiskState, vendor),                \
>       DEFINE_PROP_STRING("product", SCSIDiskState, product),              \
>       DEFINE_PROP_STRING("device_id", SCSIDiskState, device_id),          \
> -    DEFINE_PROP_STRING("loadparm", SCSIDiskState, loadparm),            \
>       DEFINE_PROP_BOOL("migrate-emulated-scsi-request", SCSIDiskState, 
> migrate_emulated_scsi_request, true)
> 
> 
> @@ -3220,6 +3245,8 @@ static void scsi_hd_class_initfn(ObjectClass 
> *klass, void *data)
>       dc->desc = "virtual SCSI disk";
>       device_class_set_props(dc, scsi_hd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
> 
>   static const TypeInfo scsi_hd_info = {
> @@ -3260,6 +3287,8 @@ static void scsi_cd_class_initfn(ObjectClass 
> *klass, void *data)
>       dc->desc = "virtual SCSI CD-ROM";
>       device_class_set_props(dc, scsi_cd_properties);
>       dc->vmsd  = &vmstate_scsi_disk_state;
> +
> +    scsi_property_add_specifics(dc);
>   }
> 
>   static const TypeInfo scsi_cd_info = {
> 
> ?
> 
> Using the global arch_type variable is likely also not the
> nicest solution, but it at least limits the property to the
> s390x target for now...
> 
>   Thomas
> 
> 
> 


