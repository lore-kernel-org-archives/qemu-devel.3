Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A475FC10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 15:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3zx5-0001zL-Ie; Mon, 06 May 2024 11:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s3zwX-0001iN-SK
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1s3zwR-0004q4-F8
 for qemu-devel@nongnu.org; Mon, 06 May 2024 11:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715008066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y61HfgjVewkJQU10ucRJoENKWfyE1rPjSIkvm+7zPIg=;
 b=aS0MgBazVbHTEUh6PKvIkHStleIKmPAYkr06uyQEIOKcrzin3G8JCIP2KqFy9G+D5eoIoV
 d/Bs1tG1frUpog7sLuR/pLiCSeAhSPnDjP1lsJTqQ55JKEQdWbavgOcY+sLwIZq7RhYOW2
 0i9jmsJ21YsTu9XC7WxctaTdNp3dnAA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-K5R1uLlHNmi_iYRXtQj3UQ-1; Mon, 06 May 2024 11:07:44 -0400
X-MC-Unique: K5R1uLlHNmi_iYRXtQj3UQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6a0e9eddad0so8672206d6.0
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 08:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715008064; x=1715612864;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y61HfgjVewkJQU10ucRJoENKWfyE1rPjSIkvm+7zPIg=;
 b=bEYxcPYKpgF1LcAcGzn7x2A2JnOXVxG2iJi+XnanD6DIQUpVP4mJa0dvtSyWUrja5V
 mmQwFf+umAMmO3J/GILFChQ0cSLV0NprG/1obNkuMZxyzmcArd+sqrTN26b4/brUjSod
 uzd0HUMEyTSRxMkV3LqTvdqiHGBxmLPkweNOBHzAKITgZyXvoL517kBbs7IiRxrMu4xQ
 AucbHM9uIG2ajEcy5QASlZ96UQOcKYvvOQS/XOy02GHW3lJ4gPP9v5oijr2oRhL3baM/
 6AwHX8p2JfyvINRMnsgZD5/VhIfRol8gG0Eh4oO+qBg/ybg2vL9USTKxNbe3iZu4ECye
 2sjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8TcvagqExxL3skGBD5u1248zvyXVExmT8fNUKX6eYiBpSEchztuNCNT4a7/P+45gYvwN9gSxL4xfT1xnPUIUcQGMIBeM=
X-Gm-Message-State: AOJu0YxUKU5AUxzJDWaZEMlBP4uCBF3DRPK4Fes+AOqALYgbcFw0VmwB
 TeozNunBC4eX/9Zf+Pf8fwzV3RVhg86V9g3CSx0uyqNFSl5E2NuXGoLKpI1KbNd+pArZ832sjio
 b/xZx90y/A7ELh7JpBWZABgyYq1ZjynetcCGpwcZMAGQ4FNmxHxFB
X-Received: by 2002:a05:6214:e8b:b0:6a0:a44e:c59c with SMTP id
 hf11-20020a0562140e8b00b006a0a44ec59cmr12907849qvb.1.1715008063961; 
 Mon, 06 May 2024 08:07:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG83p3PQVdI++DfZEUxtljhspI7xaZ+GUQVSuE5phXO+0tUjolDZJcx9r4vqbSiIyli5EtV4Q==
X-Received: by 2002:a05:6214:e8b:b0:6a0:a44e:c59c with SMTP id
 hf11-20020a0562140e8b00b006a0a44ec59cmr12907772qvb.1.1715008063064; 
 Mon, 06 May 2024 08:07:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 m17-20020ad44a11000000b006a0d7154d13sm3789795qvz.78.2024.05.06.08.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 08:07:42 -0700 (PDT)
Date: Mon, 6 May 2024 11:07:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] vfio/migration: Emit VFIO device migration state
 change QAPI event
Message-ID: <ZjjyPESK-YC-XtFO@x1n>
References: <20240430051621.19597-1-avihaih@nvidia.com>
 <20240430051621.19597-3-avihaih@nvidia.com>
 <08936db7-46bf-42ba-ac14-49cb14f34646@oracle.com>
 <0d368ac4-fbba-4829-b25d-d49957b7c9da@nvidia.com>
 <5e9c1edd-4e99-4fb7-8b9a-159b1a6503c5@oracle.com>
 <600825d2-a314-4120-ad2a-0b1f3c5bb8d9@nvidia.com>
 <87pltzsfl3.fsf@pond.sub.org> <87ikzrm2ev.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ikzrm2ev.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 06, 2024 at 11:38:00AM -0300, Fabiano Rosas wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
> > Peter, Fabiano, I'd like to hear your opinion on the issue discussed
> > below.
> >
> > Avihai Horon <avihaih@nvidia.com> writes:
> >
> >> On 02/05/2024 13:22, Joao Martins wrote:
> >>> External email: Use caution opening links or attachments
> >>>
> >>>
> >>> On 01/05/2024 13:28, Avihai Horon wrote:
> >>>> On 01/05/2024 14:50, Joao Martins wrote:
> >>>>> External email: Use caution opening links or attachments
> >>>>>
> >>>>>
> >>>>> On 30/04/2024 06:16, Avihai Horon wrote:
> >>>>>> Emit VFIO device migration state change QAPI event when a VFIO device
> >>>>>> changes its migration state. This can be used by management applications
> >>>>>> to get updates on the current state of the VFIO device for their own
> >>>>>> purposes.
> >>>>>>
> >>>>>> A new per VFIO device capability, "migration-events", is added so events
> >>>>>> can be enabled only for the required devices. It is disabled by default.
> >>>>>>
> >>>>>> Signed-off-by: Avihai Horon<avihaih@nvidia.com>
> >>>>>> ---
> >>>>>>    include/hw/vfio/vfio-common.h |  1 +
> >>>>>>    hw/vfio/migration.c           | 44 +++++++++++++++++++++++++++++++++++
> >>>>>>    hw/vfio/pci.c                 |  2 ++
> >>>>>>    3 files changed, 47 insertions(+)
> >>>>>>
> >>>>>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> >>>>>> index b9da6c08ef..3ec5f2425e 100644
> >>>>>> --- a/include/hw/vfio/vfio-common.h
> >>>>>> +++ b/include/hw/vfio/vfio-common.h
> >>>>>> @@ -115,6 +115,7 @@ typedef struct VFIODevice {
> >>>>>>        bool no_mmap;
> >>>>>>        bool ram_block_discard_allowed;
> >>>>>>        OnOffAuto enable_migration;
> >>>>>> +    bool migration_events;
> >>>>>>        VFIODeviceOps *ops;
> >>>>>>        unsigned int num_irqs;
> >>>>>>        unsigned int num_regions;
> >>>>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> >>>>>> index 06ae40969b..6bbccf6545 100644
> >>>>>> --- a/hw/vfio/migration.c
> >>>>>> +++ b/hw/vfio/migration.c
> >>>>>> @@ -24,6 +24,7 @@
> >>>>>>    #include "migration/register.h"
> >>>>>>    #include "migration/blocker.h"
> >>>>>>    #include "qapi/error.h"
> >>>>>> +#include "qapi/qapi-events-vfio.h"
> >>>>>>    #include "exec/ramlist.h"
> >>>>>>    #include "exec/ram_addr.h"
> >>>>>>    #include "pci.h"
> >>>>>> @@ -80,6 +81,46 @@ static const char *mig_state_to_str(enum
> >>>>>> vfio_device_mig_state state)
> >>>>>>        }
> >>>>>>    }
> >>>>>>
> >>>>>> +static VFIODeviceMigState
> >>>>>> +mig_state_to_qapi_state(enum vfio_device_mig_state state)
> >>>>>> +{
> >>>>>> +    switch (state) {
> >>>>>> +    case VFIO_DEVICE_STATE_STOP:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP;
> >>>>>> +    case VFIO_DEVICE_STATE_RUNNING:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING;
> >>>>>> +    case VFIO_DEVICE_STATE_STOP_COPY:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_STOP_COPY;
> >>>>>> +    case VFIO_DEVICE_STATE_RESUMING:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RESUMING;
> >>>>>> +    case VFIO_DEVICE_STATE_RUNNING_P2P:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_RUNNING_P2P;
> >>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY;
> >>>>>> +    case VFIO_DEVICE_STATE_PRE_COPY_P2P:
> >>>>>> +        return QAPI_VFIO_DEVICE_MIG_STATE_PRE_COPY_P2P;
> >>>>>> +    default:
> >>>>>> +        g_assert_not_reached();
> >>>>>> +    }
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void vfio_migration_send_state_change_event(VFIODevice *vbasedev)
> >>>>>> +{
> >>>>>> +    VFIOMigration *migration = vbasedev->migration;
> >>>>>> +    const char *id;
> >>>>>> +    Object *obj;
> >>>>>> +
> >>>>>> +    if (!vbasedev->migration_events) {
> >>>>>> +        return;
> >>>>>> +    }
> >>>>>> +
> >>>>> Shouldn't this leap frog migrate_events() capability instead of introducing its
> >>>>> vfio equivalent i.e.
> >>>>>
> >>>>>           if (!migrate_events()) {
> >>>>>               return;
> >>>>>           }
> >>>>>
> >>>>> ?
> >>>>
> >>>> I used a per VFIO device cap so the events can be fine tuned for each device
> >>>> (maybe one device should send events while the other not).
> >>>> This gives the most flexibility and I don't think it complicates the
> >>>> configuration (one downside, though, is that it can't be enabled/disabled
> >>>> dynamically during runtime).
> >>>>
> >>> Right.
> >>>
> >>>> I don't think events add much overhead, so if you prefer a global cap, I can
> >>>> change it.
> >>>> However, I'm not sure overloading the existing migrate_events() is valid?
> >>>>
> >>> migration 'events' capability just means we will have some migration events
> >>> emited via QAPI monitor for: 1) general global status and 2) for each migration
> >>> pass (both with different event names=.
> >>
> >> Yes, it's already overloaded.
> >>
> >> In migration QAPI it says: "@events: generate events for each migration state change (since 2.4)".
> >> This only refers to the MIGRATION event AFAIU.
> >>
> >> Later on (in QEMU 2.6), MIGRATION_PASS event was added and the events cap was overloaded for the first time (without changing @events description).
> >>
> >> Now we want to add yet another use for events capability, the VFIO migration state change events.
> >>
> >> I think what bothers me is the @events description, which is not accurate.
> >> Maybe it should be changed to "@events: generate migration related events (since 2.4)"? However, I'm not sure if it's OK to do this.
> >>
> >>>   So the suggestion was just what feels a
> >>> natural extension of that (...)
> >>>
> >>>>> Applications that don't understand the event string (migration related or not)
> >>>>> will just discard it (AIUI)
> >>>
> >>> (...) specially because of this as all these events have a different name.
> >>>
> >>> But overloading might not make sense for others IDK ... it was just a suggestion
> >>> :) not a strong preference
> >>
> >> Yes, I get your rationale.
> >> I don't have a strong opinion either, so maybe let's see what other people think.
> 
> I don't see the need to tie this to the migration events
> capability. Although there's overlap in the terms used, this seems more
> like exposing a device feature via QEMU, then a migration event
> per-se. The state changes also happen during moments unrelated to
> migration (cover letter mentions start/stopping guest), so I assume we'd
> like to keep those even if the management layer doesn't want to see
> migration events.

Yeh makes sense to me to keep that per-device flag, as it's not a generic
migration state change.

  @events: generate events for each migration state change (since 2.4)

The other option is to emit event only if "migrate_events() &&
vfio_dev_send_event", but that sounds like an overkill to overload "events"
cap, and doesn't look like bring anything better than just keeping them
separate.

While at it, another trivial comment is maybe it's nice to have a helper to
both update the vfio migration state, plus emitting events when necessary.

Thanks,

-- 
Peter Xu


