Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4395AC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 18:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpt6s-0001T6-7t; Wed, 05 Mar 2025 13:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpt6q-0001SX-F7
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:04:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tpt6o-0003uw-Fl
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 13:04:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741197880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJuZgcMocYwCu9vqN4Wz33eUnHRUI1MA8noBhjtICko=;
 b=axUCNDmMp63RRRBIeH1C+4zDnso9TUQf9JL3l7n3IyakoSTo3LVAgP6eFdQ/kRblu0Kcwl
 HYsxk6adOZoz7FLlrZzw2rm/mj6lKtXjWr2hNtdnlhF13B50kWhBHIJi/CxuABfXqaWjvl
 tvAA5L4SPqnZ7eh88S0FVgpyNd1oAC0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-KNA8ZqswNvWWbgKGDd1rfw-1; Wed, 05 Mar 2025 13:04:22 -0500
X-MC-Unique: KNA8ZqswNvWWbgKGDd1rfw-1
X-Mimecast-MFC-AGG-ID: KNA8ZqswNvWWbgKGDd1rfw_1741197861
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3910b93cb1eso1706932f8f.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 10:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741197861; x=1741802661;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QJuZgcMocYwCu9vqN4Wz33eUnHRUI1MA8noBhjtICko=;
 b=G1SUfzn5+acHubF3WzMh97cA0UftQkhrNzMz6H8UdMHX+5tsGYUnwbnBw/BC0fdmZd
 Df3A/RSE6lbGca2eLPCtZVifWoZSAuTrP/jYEq6wz1AUixSNUqdkGyTT3dC0QTCQ99zZ
 bLHnsoOHvOJHTGK6tig0Xvx5QYvGYGPVdf5kHJKQIFQJ07KvGhQkRMvNpy3Vfzjy4IPJ
 awq9a1fiXMvfut4s8959P3NofLznwy6o7k7tZ2joXbBzXzoZ4b+JPsqaIhsoWn7zZNjL
 cM0qkmHnSd3J/Ro7gC79BLPT52AVIg5Jb/3hEqoURM5Xpo1afqzUD4brxudw36Wvdn12
 7UlQ==
X-Gm-Message-State: AOJu0Yw0wLnDpkHxBUULBtPD2dOZtMz+IZUTxhDZliHaL3p8ARG7Q5Ex
 C36VCZgYirUb5JeBvvhCXdCxLPabSkhODGlrQ/zQv2Q2CIjVvUg/E7XzygKYPG21XZPLE6fRgGE
 v7O5xIkZi6f+UnXUC90cKIkAeFBVQjfNQ8eC8lpFhLLM8Rbzen5ct
X-Gm-Gg: ASbGnctNypRsy8X1wWdy5bAc8ypeo2IOm51UWTmApwFxsjv1Yom/t3aijluFcIYrpoE
 lRCbYWSld946qL3UMiH9ArWLncAvURJlWMbL6kAkfmuOEXSbLDGwug9xbvn8/l0T8UVZoRjQztN
 CA45MpCsvSHx2888l9waEuM/cw/FF0LgDoVMU1QdntqoIOSW+lAIGbUdWjh0aLyizxvH62ZGplc
 7C7CPXeW5b0A9JdLrr0i1DpdNLfSw6jpGP0U/LvQsTWlPmxV5cb2D+OqTtkPPDnEnOzf9u37Do0
 y/Mh07rvx/MPugvTr29AKTSzFdrVhsv38904AqSDCTGJgYA=
X-Received: by 2002:a05:6000:4007:b0:390:f45e:c84a with SMTP id
 ffacd0b85a97d-3911f7cb10fmr4554013f8f.48.1741197861152; 
 Wed, 05 Mar 2025 10:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQUCcP3cBYXp0qFqQsKTVbFFYOG2iUfZF+VsYkbypt5D+3B14cX5M8p4Z31Xu4+9K5zG4zFQ==
X-Received: by 2002:a05:6000:4007:b0:390:f45e:c84a with SMTP id
 ffacd0b85a97d-3911f7cb10fmr4553940f8f.48.1741197860600; 
 Wed, 05 Mar 2025 10:04:20 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-231.web.vodafone.de.
 [109.42.51.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4796084sm22097263f8f.19.2025.03.05.10.04.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 10:04:20 -0800 (PST)
Message-ID: <01508dbb-7ee5-4c5b-87c9-667bc296fdbf@redhat.com>
Date: Wed, 5 Mar 2025 19:04:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH qemu v2 2/3] hw/s390x: add SCLP event type CPI
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250224120449.1764114-1-shalini@linux.ibm.com>
 <20250224120449.1764114-2-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250224120449.1764114-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 24/02/2025 13.04, Shalini Chellathurai Saroja wrote:
> Implement the SCLP event type Control-Program Identification
> (CPI) in QEMU. This event is used to send CPI identifiers,
> which provide information about the guest OS to the host.
> 
> Save the information obtained from the SCLP CPI event to the
> QOM along with the timestamp in which the data was received.
> 
> Example:
> virsh # qemu-monitor-command vm --pretty '{
> "execute":"qom-get","arguments": {
> "path": "/machine", "property": "s390-control-program_id"}}'

I guess it should be a "-" instead of a "_" between "program" and "id"?

> {
>    "return": {
>      "timestamp": 1711620874948254000,
>      "system-level": "0x50e00",
>      "sysplex-name": "SYSPLEX ",
>      "system-name": "TESTVM  ",
>      "system-type": "LINUX   "
>    },
>    "id": "libvirt-15"
> }
> 
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> ---
>   hw/s390x/event-facility.c         |  12 +++-
>   hw/s390x/meson.build              |   1 +
>   hw/s390x/sclpcpi.c                | 105 ++++++++++++++++++++++++++++++
>   include/hw/s390x/event-facility.h |   3 +
>   4 files changed, 120 insertions(+), 1 deletion(-)
>   create mode 100644 hw/s390x/sclpcpi.c
> 
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 2b0332c20e..c0fb6e098c 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -39,7 +39,7 @@ typedef struct SCLPEventsBus {
>   struct SCLPEventFacility {
>       SysBusDevice parent_obj;
>       SCLPEventsBus sbus;
> -    SCLPEvent quiesce, cpu_hotplug;
> +    SCLPEvent quiesce, cpu_hotplug, cpi;
>       /* guest's receive mask */
>       union {
>           uint32_t receive_mask_pieces[2];
> @@ -436,6 +436,10 @@ static void init_event_facility(Object *obj)
>       object_initialize_child(obj, TYPE_SCLP_CPU_HOTPLUG,
>                               &event_facility->cpu_hotplug,
>                               TYPE_SCLP_CPU_HOTPLUG);
> +
> +    object_initialize_child(obj, TYPE_SCLP_CPI,
> +                            &event_facility->cpi,
> +                            TYPE_SCLP_CPI);
>   }
>   
>   static void realize_event_facility(DeviceState *dev, Error **errp)
> @@ -451,6 +455,12 @@ static void realize_event_facility(DeviceState *dev, Error **errp)
>           qdev_unrealize(DEVICE(&event_facility->quiesce));
>           return;
>       }
> +    if (!qdev_realize(DEVICE(&event_facility->cpi),
> +                      BUS(&event_facility->sbus), errp)) {
> +        qdev_unrealize(DEVICE(&event_facility->quiesce));
> +        qdev_unrealize(DEVICE(&event_facility->cpu_hotplug));
> +        return;
> +    }
>   }
>   
>   static void reset_event_facility(DeviceState *dev)
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..eb7950489c 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -13,6 +13,7 @@ s390x_ss.add(files(
>     's390-skeys.c',
>     's390-stattrib.c',
>     'sclp.c',
> +  'sclpcpi.c',
>     'sclpcpu.c',
>     'sclpquiesce.c',
>     'tod.c',
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> new file mode 100644
> index 0000000000..f2830d2d57
> --- /dev/null
> +++ b/hw/s390x/sclpcpi.c
> @@ -0,0 +1,105 @@
> +/*

scripts/checkpatch.pl recently learnt a new check to mandate SPDX license 
tags now for new files ... so please add one here now!

> + * SCLP event type 11 - Control-Program Identification(CPI):
> + *    CPI is used to send program identifiers from the control-program to the
> + *    SCLP. The program identifiers provide data about the guest instance. It
> + *    is not sent by the SCLP.
> + *
> + *    The program identifiers are system type, system name, sysplex name and
> + *    system level. The system type, system name, and sysplex name use EBCDIC
> + *    ucharacters from this set: capital A-Z, 0-9, $, @, #, and blank. The
> + *    system level is a hex value.
> + *
> + * Copyright IBM, Corp. 2024
> + *
> + * Authors:
> + *  Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or (at your
> + * option) any later version.  See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/timer.h"
> +#include "hw/s390x/sclp.h"
> +#include "hw/s390x/event-facility.h"
> +#include "hw/s390x/ebcdic.h"
> +#include "hw/s390x/s390-virtio-ccw.h"
> +
> +typedef struct Data {
> +    uint8_t id_format;
> +    uint8_t reserved0;
> +    uint8_t system_type[8];
> +    uint64_t reserved1;
> +    uint8_t system_name[8];
> +    uint64_t reserved2;
> +    uint64_t system_level;
> +    uint64_t reserved3;
> +    uint8_t sysplex_name[8];
> +    uint8_t reserved4[16];
> +} QEMU_PACKED Data;
> +
> +typedef struct ControlProgramIdMsg {
> +    EventBufferHeader ebh;
> +    Data data;
> +} QEMU_PACKED ControlProgramIdMsg;
> +
> +static bool can_handle_event(uint8_t type)
> +{
> +    return type == SCLP_EVENT_CPI;
> +}
> +
> +static sccb_mask_t send_mask(void)
> +{
> +    return 0;
> +}
> +
> +/* Enable SCLP to accept buffers of event type CPI from the control-program. */
> +static sccb_mask_t receive_mask(void)
> +{
> +    return SCLP_EVENT_MASK_CPI;
> +}
> +
> +static int write_event_data(SCLPEvent *event, EventBufferHeader *evt_buf_hdr)
> +{
> +    ControlProgramIdMsg *cpi = container_of(evt_buf_hdr, ControlProgramIdMsg,
> +                                            ebh);
> +    S390CcwMachineState *ms = S390_CCW_MACHINE(qdev_get_machine());
> +
> +    ascii_put(ms->cpi.system_type, (char *)cpi->data.system_type, 8);
> +    ascii_put(ms->cpi.system_name, (char *)cpi->data.system_name, 8);
> +    ascii_put(ms->cpi.sysplex_name, (char *)cpi->data.sysplex_name, 8);
> +    ms->cpi.system_level = be64_to_cpu(cpi->data.system_level);

Can we be confident that system_level is always properly aligned?
Otherwise it's maybe better to use ldq_be_p() instead?

  Thomas


