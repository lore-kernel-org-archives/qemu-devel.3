Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8025FF885A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 17:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJxKM-00085O-6z; Mon, 04 May 2026 13:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxK9-00081b-1f
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wJxK6-0007hN-1s
 for qemu-devel@nongnu.org; Mon, 04 May 2026 13:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777916593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bQb16KtLImMQCP+LqwJZLK0JGPjn/NTZu1uLjDjW1UY=;
 b=EmkSlh7pLFKCniWTeWJ4jng/1LfXzd1Zn3HhWFmyZ5g1Hi1kC4ByhuCpmkBdM1yZPrzZvO
 eenRxuYo+m41k8Gq4bn2/wcj1DMKItLXFEU90C7vCIpk1qqj3iT+2oge6+XNW4vegjgzKm
 CmYMDAaeB8jacMVyx/oYgWlt40Tgy0M=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-hlrzq0RKOBmsXNUliwwnVg-1; Mon, 04 May 2026 13:43:11 -0400
X-MC-Unique: hlrzq0RKOBmsXNUliwwnVg-1
X-Mimecast-MFC-AGG-ID: hlrzq0RKOBmsXNUliwwnVg_1777916591
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-36524e2c5dfso1730710a91.3
 for <qemu-devel@nongnu.org>; Mon, 04 May 2026 10:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777916590; x=1778521390; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bQb16KtLImMQCP+LqwJZLK0JGPjn/NTZu1uLjDjW1UY=;
 b=NFOlwDx2uEb0Hv3la/EwuoDuDSJLSLsLsoAK+HtodkjhSES692tQxl0t/DzRtodW8f
 ggdx0FZTTeI1zJQFZZdnxAp+xk8v/5QbFk7HPptay5xXeOJoMsRPoCYFUb/zv9A5XlaG
 HbnF0v/gLspKo6CfBtFgtHg1sufluKFfYVa9HpGoSLf+metwUpUxA8bAwaSa5pI5nfUg
 B6uIZdAs+O2iFBE7xUGYM3vVYVWwRRadI8nXungBtI6ZKKtam7g2wCUhVmrkUEWee1oW
 UFwg9Fg7HJ+OgSdddLAcf2PtcWD9Hds1BeIoknuV9/VPGc43sAKz+Orsod+2iOB/gemg
 D6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777916590; x=1778521390;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bQb16KtLImMQCP+LqwJZLK0JGPjn/NTZu1uLjDjW1UY=;
 b=Cqo/f/wr2vkw6HWsUtU6NHwKQyaYuC8UzGap7r37JN9+XbLa+0ZAPTitoACzB755IJ
 DpcsW6qgzr8vANAMxWXRyvBzmxikEvDcF6v7Nm9LWZe6cuocxaQCL0s/dAKsWxE/0Gin
 l4R8+DoRBrnsDzjyZhQ171d3AOrnJlhxN2ZUc3iBqHp1Ux0on/86h8Oo8vOCZVSiEDSb
 C7+ixNohoK/Z6UhZPunDGoaBNH9k1wUSGaM0x3aYXRwhrqWLnV+iY5edTvK4AHvDkB4v
 esJhDaCAF/7BaEzRZ7jNuw2TA8xsKabJqYREmPWFcaaCvEh5jhyH3KnKDc0HCjJCMATB
 Nw3A==
X-Gm-Message-State: AOJu0YyWkU9Awz/b2rgNqoAl1ZatfeGtYM/rplnbZXP72+p7AV+oPLLZ
 ut5NhDk7pgA4x7h8ADUCacjmOADNkSrQ5A5QPpWvGIeDx3wZ3QMBJbgnPZFY4a6Y0SkS968Km/P
 HYXMFuWhPKH7JHcWgkVFqB0NmC/9Vcpttu9doxOHKkiqidQSBdE4sHV1g
X-Gm-Gg: AeBDietvPehcSXzEv/1+MFx9X41AZU5cuU8SzoFs8ppj/wj+Lu6GROAvYUwPobvP1w2
 UwsPqlrn+XxzhAqOhHlns2PERTBygHtobCspfpD5PkiczlDOtprJfuIAvU4InvoAeqbnSkbrDdz
 B5MSecMXrZGtco4FquOe9W58f+Enp8reeyPc6Bz0j0S8c/JIUgePdqfSOrTV52C81lTIsY1vQl4
 Vv2Ks/V96Buz4ZBI1yI6Zd0MmYIFFfnAX5UO7fTaoEKcY/zIUXvHLTlAbbQbsdsCO7t/1XUQPGO
 TRfDKcTX2/baWAg7q5gWWntD1Ok1jV0vJVaoo9qhHU68Art1FBoKOVPtc102gggi4yiyVyZvIXL
 1tFLYgYZeP8IWOGYVMlTXvw==
X-Received: by 2002:a17:90b:5830:b0:359:f77f:8cff with SMTP id
 98e67ed59e1d1-3650ce6f2c7mr10988770a91.19.1777916590342; 
 Mon, 04 May 2026 10:43:10 -0700 (PDT)
X-Received: by 2002:a17:90b:5830:b0:359:f77f:8cff with SMTP id
 98e67ed59e1d1-3650ce6f2c7mr10988722a91.19.1777916589656; 
 Mon, 04 May 2026 10:43:09 -0700 (PDT)
Received: from fedora ([49.36.108.92]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-364ebec736dsm12082105a91.3.2026.05.04.10.43.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 10:43:09 -0700 (PDT)
Date: Mon, 4 May 2026 23:12:57 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, marcandre.lureau@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH v5 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
Message-ID: <afjaoQRkTEOu9Lki@fedora>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
 <ef476984-6a55-4654-89e3-2703d8baca25@linux.ibm.com>
 <afLkebmMTFPEyAuK@fedora>
 <56667f7a-71c9-4280-90ab-1b356741d803@linux.ibm.com>
 <afhGxAEyDWtofq_L@fedora>
 <caf85297-8277-44b2-82ca-aee6cd8770ce@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf85297-8277-44b2-82ca-aee6cd8770ce@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 04, 2026 at 10:33:38AM -0400, Stefan Berger wrote:
> 
> 
> On 5/4/26 3:12 AM, Arun Menon wrote:
> > On Thu, Apr 30, 2026 at 07:46:33AM -0400, Stefan Berger wrote:
> > > 
> > > 
> > > On 4/30/26 1:11 AM, Arun Menon wrote:
> > > > On Wed, Apr 29, 2026 at 07:14:38PM -0400, Stefan Berger wrote:
> > > > > 
> > > > > 
> > > > > On 4/22/26 6:30 AM, Arun Menon wrote:
> > > > > > From: Arun Menon <armenon@redhat.com>
> > > > > > 
> > > > > > - Add subsection in VMState for TPM CRB with the newly introduced
> > > > > >      command and response buffer GByteArrays, along with a needed callback,
> > > > > >      so that newer QEMU only sends the buffers if it is necessary.
> > > > > > - Implement a migration blocker to prevent migration of the VM if the
> > > > > >      user manually enables chunking capability, cap-chunk, but the machine
> > > > > >      type does not support it, using a new hw_compat property called
> > > > > >      allow_chunk_migration.
> > > > > > - Add a post_load_errp hook so that during a migration, the buffers are
> > > > > >      validated before destination VM is started.
> > > > > > 
> > > > > > Signed-off-by: Arun Menon <armenon@redhat.com>
> > > > > > ---
> > > > > >     hw/core/machine.c |  1 +
> > > > > >     hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> > > > > >     2 files changed, 72 insertions(+)
> > > > > > 
> > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > index 6d27cf69a2..b590af0125 100644
> > > > > > --- a/hw/core/machine.c
> > > > > > +++ b/hw/core/machine.c
> > > > > > @@ -40,6 +40,7 @@
> > > > > > 
> > > > > >     GlobalProperty hw_compat_11_0[] = {
> > > > > >         { "tpm-crb", "cap-chunk", "off"},
> > > > > > +    { "tpm-crb", "x-allow-chunk-migration", "off"},
> > > > > >     };
> > > > > >     const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> > > > > > 
> > > > > > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > > > > > index 29370d6f49..23e6948aee 100644
> > > > > > --- a/hw/tpm/tpm_crb.c
> > > > > > +++ b/hw/tpm/tpm_crb.c
> > > > > > @@ -24,6 +24,7 @@
> > > > > >     #include "hw/pci/pci_ids.h"
> > > > > >     #include "hw/acpi/tpm.h"
> > > > > >     #include "migration/vmstate.h"
> > > > > > +#include "migration/blocker.h"
> > > > > >     #include "system/tpm_backend.h"
> > > > > >     #include "system/tpm_util.h"
> > > > > >     #include "system/reset.h"
> > > > > > @@ -51,6 +52,8 @@ struct CRBState {
> > > > > >         TPMPPI ppi;
> > > > > > 
> > > > > >         bool cap_chunk;
> > > > > > +    bool allow_chunk_migration;
> > > > > > +    Error *migration_blocker;
> > > > > >     };
> > > > > >     typedef struct CRBState CRBState;
> > > > > > 
> > > > > > @@ -353,12 +356,63 @@ static int tpm_crb_pre_save(void *opaque)
> > > > > >         return 0;
> > > > > >     }
> > > > > > 
> > > > > > +static bool tpm_crb_chunk_needed(void *opaque)
> > > > > > +{
> > > > > > +    CRBState *s = opaque;
> > > > > > +
> > > > > > +    if (!s->allow_chunk_migration) {
> > > > > > +        return false;
> > > > > > +    }
> > > > > > +
> > > > > > +    return ((s->command_buffer && s->command_buffer->len > 0) ||
> > > > > > +            (s->response_buffer && s->response_buffer->len > 0));
> > > > > > +}
> > > > > > +
> > > > > > +static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
> > > > > > +{
> > > > > > +    CRBState *s = opaque;
> > > > > > +
> > > > > > +    if (!s->response_buffer || !s->command_buffer) {
> > > > > > +        error_setg(errp, "tpm-crb: Internal buffers are not allocated");
> > > > > 
> > > > > Could this happen that this state type is resumed but the buffers are not
> > > > > allocated?
> > > > 
> > > > Yes, this is not required. Its just a defense. The tpm_realize()
> > > > function should allocate the command and response buffers.
> > > > 
> > > > > 
> > > > > > +        return false;
> > > > > > +    }
> > > > > > +    if (s->response_offset > s->response_buffer->len) {
> > > > > > +        error_setg(errp, "tpm-crb: Invalid response "
> > > > > > +                   "offset %" PRIu32 " in migration stream",
> > > > > > +                   s->response_offset);
> > > > > > +        return false;
> > > > > > +    }
> > > > > 
> > > > > The check is correct but can this particular case occur other than through
> > > > > crafted input?
> > > > 
> > > > Not that I can think of. The check is indeed added to address malicious
> > > > migration stream / crafted input.
> > > 
> > > I think that devices are assuming trusted input for all devices resumed from
> > > their previously stored state...
> > 
> > I see. Shall I remove these two checks at the beginning and keep only
> > the last one?
> 
> I think so. For the last one I think you should write a description what
> role the external emulator can play here.

Sure. I have updated it in v6. Thank you.

> 
> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > +    if (s->response_buffer->len > s->be_buffer_size ||
> > > > > > +        s->command_buffer->len > s->be_buffer_size) {
> > > > > 
> > > > > I suppose this could happen if I was running with a PQC-enable swtpm/libtpms
> > > > > and suspended at the right moment that when a chunked command or response
> > > > > was in the buffer and now I am trying to resume with a non-PQC-enabled swtpm
> > > > > that only has 4kb buffer, while the newer PQC one had 8kb buffer.
> > > > > 
> > > > 
> > > > Yes. This check is for safety. We do not want to migrate to a VM that
> > > > has a tpm backend that does not support big buffers.
> > > > 
> > > > > > +        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
> > > > > > +        return false;
> > > > > > +    }
> > > > > > +    return true;
> > > > > > +}
> > > > > > +
> > > > > > +static const VMStateDescription vmstate_tpm_crb_chunk = {
> > > > > > +    .name = "tpm-crb/chunk",
> > > > > > +    .version_id = 0,
> > > > > > +    .needed = tpm_crb_chunk_needed,
> > > > > > +    .post_load_errp = tpm_crb_chunk_post_load,
> > > > > > +    .fields = (const VMStateField[]) {
> > > > > > +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
> > > > > > +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
> > > > > > +        VMSTATE_UINT32(response_offset, CRBState),
> > > > > > +        VMSTATE_END_OF_LIST()
> > > > > > +    }
> > > > > > +};
> > > > > > +
> > > > > >     static const VMStateDescription vmstate_tpm_crb = {
> > > > > >         .name = "tpm-crb",
> > > > > >         .pre_save = tpm_crb_pre_save,
> > > > > >         .fields = (const VMStateField[]) {
> > > > > >             VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
> > > > > >             VMSTATE_END_OF_LIST(),
> > > > > > +    },
> > > > > > +    .subsections = (const VMStateDescription * const []) {
> > > > > > +        &vmstate_tpm_crb_chunk,
> > > > > > +        NULL,
> > > > > >         }
> > > > > >     };
> > > > > > 
> > > > > > @@ -366,6 +420,8 @@ static const Property tpm_crb_properties[] = {
> > > > > >         DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> > > > > >         DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
> > > > > >         DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
> > > > > > +    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
> > > > > > +                     allow_chunk_migration, true),
> > > > > >     };
> > > > > > 
> > > > > >     static void tpm_crb_reset(void *dev)
> > > > > > @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
> > > > > >     static void tpm_crb_realize(DeviceState *dev, Error **errp)
> > > > > >     {
> > > > > >         CRBState *s = CRB(dev);
> > > > > > +    int ret;
> > > > > > 
> > > > > >         if (!tpm_find()) {
> > > > > >             error_setg(errp, "at most one TPM device is permitted");
> > > > > > @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
> > > > > >             error_setg(errp, "'tpmdev' property is required");
> > > > > >             return;
> > > > > >         }
> > > > > > +    if (s->cap_chunk && !s->allow_chunk_migration) {
> > > > > > +        error_setg(&s->migration_blocker,
> > > > > > +                   "The tpm-crb device does not support chunk migration with "
> > > > > > +                   "machine version less than 11.1");
> > > > > > +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> > > > > > +        if (ret < 0) {
> > > > > > +            return;
> > > > > > +        }
> > > > > > +    }
> > > > > > 
> > > > > >         memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> > > > > >             "tpm-crb-mmio", sizeof(s->regs));
> > > > > > @@ -463,6 +529,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
> > > > > > 
> > > > > >         g_clear_pointer(&s->command_buffer, g_byte_array_unref);
> > > > > >         g_clear_pointer(&s->response_buffer, g_byte_array_unref);
> > > > > > +
> > > > > > +    if (s->migration_blocker) {
> > > > > > +        migrate_del_blocker(&s->migration_blocker);
> > > > > > +        error_free(s->migration_blocker);
> > > > > > +    }
> > > > > >     }
> > > > > > 
> > > > > >     static void tpm_crb_class_init(ObjectClass *klass, const void *data)
> > > > > 
> > > > 
> > > > Regards,
> > > > Arun Menon
> > > > 
> > > 
> > 
> > Regards,
> > Arun Menon
> > 
> 

Regards,
Arun Menon


