Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43FC9FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:12:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIJgZ-0004Bj-C0; Thu, 30 Apr 2026 01:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIJgX-0004BN-Op
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:11:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wIJgV-0001wt-HM
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 01:11:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777525893;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QtvHt4BhvAPCamBNHBZUWvNrFNRB5GIitFt+/jHVuMw=;
 b=WuJ6nwDRRojrY3fCiqNElTj9CtajB3VZnnusO+0dnfru2acnamqeXpKAZ+wJvK1bI+guIS
 hXMpq/gpZ6gDjpM1/ub/Ynl2uIji7NCQfDLKLM+fMtoaXBOVgMhYEmQZQo49dF4AJ4xYd/
 3eqRfqsuRs8lRgu5+kMFl/K1JpDQN6k=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-DO1X1vpeNSuGq6ksyQ-9Wg-1; Thu, 30 Apr 2026 01:11:32 -0400
X-MC-Unique: DO1X1vpeNSuGq6ksyQ-9Wg-1
X-Mimecast-MFC-AGG-ID: DO1X1vpeNSuGq6ksyQ-9Wg_1777525891
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b7c904d476so4272675ad.3
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 22:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777525891; x=1778130691; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QtvHt4BhvAPCamBNHBZUWvNrFNRB5GIitFt+/jHVuMw=;
 b=JUBKr3upaFg46/ULLv4TNsBdMsRmFrtsP3elrOLt5QBqjmagNW9JqB6fZA399xaj8S
 kLkQFf11IJCECI2/feSa6+skcSFTWVZMeA3pL8wAGP08lWqICOfiKG89gFwYAjETGPLK
 9LvqUM6fUwr6vtSRuaRfN4IZE3Qsi6qGX0EwGMLemphbk5j4ZxOi6nDGI9MabWMoULgX
 2iquD6U4giWKn3c06wgxfMFahSSOlUsN+meTNxb48Y7gEQ7bluCvpV4nqNFx3boiLEpd
 TUwG/1eJrc5vM//XZDdnP/yAWzxvE7gohJ3BcvvERTaLowCtJc6WnJQjbXykiaMExOQf
 6SCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777525891; x=1778130691;
 h=in-reply-to:content-disposition:mime-version:references:reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QtvHt4BhvAPCamBNHBZUWvNrFNRB5GIitFt+/jHVuMw=;
 b=A2LbX3+SzcZSQaMDPnQL5m0+9Rcg9qsXO4T50znGBbld29HRF72APR80aHF3fhO/LN
 Hp9R3d7zQlk+H7z7J/mxpDkgsGqp9+1GxCNJgsHG00+F/tHz/oAbkNf+nxCKT9JuusdS
 WxtrnJiPZ41zVqaOCha+vXsEmRyP4Vy5jFBz7k0zJ4WyptF8ep2x/zh00cYud0Ip1eeQ
 ciGtwaS8PVhwaQrzupetQBwGX6PlywKaLQ8TAZuNve1saq05EUg34q97SjiThjFJM1nT
 t+9+mPjdlRQhRapD3GLDOot8RDG2i2HA2G2EKTvhQQXMM4WQuk/FOjr/SZ1bKfCQ4PDT
 pL2Q==
X-Gm-Message-State: AOJu0Yy+7+P0zgTgwX1Qheto1yKDZ6dKSnk8zgv0NDRHjAG+aTLBfFcR
 31G2dnvJvGPTXhyrKnEQ+8Ch6E6WT21z7xdyHGQisWO5zu3ebN5UbbWBOFnGVgRCx2pYn5xC6GI
 8G5irIXbQ23aYxO5ZdB6WrMyU2CNSr/1oMHTsLpWTj7jTjmzwIeCb8V+B
X-Gm-Gg: AeBDieuusBGO+7MfeHQHChQoatYzxij8pRfpH7cJWYiWr/OgIPqfSTNmJMK52/YZLoV
 7/oXss64stheBDPvmZqGtXZXgQB6V3S6d0sfQBdFElXU+JDTSdJJK/aSSM9EUUY44YzA9vFovgs
 nCUDZeOPqkI1av4u/gUnLoQICuNQOm9kf8PIBhoWO8+md5xmcgcw00lUvOPDnLQNPIqCaeavH6Z
 VmhzuvSnPFnnI3XHIrGC/RUJRp1K302hqTRwPZiojkRvUVFdVIPz2bF2/bvGwo2G692ZmYCsDFP
 lgdg69lnPmNKBp2QnZxsC0Jmr9+bbEiu336BREhT7VWbMN93glJZfkiD8OFpKyInij1P+ke4LSP
 iJRqee13jDeM3VI8tj/dwHw==
X-Received: by 2002:a17:902:ce0c:b0:2b4:5b9e:4edd with SMTP id
 d9443c01a7336-2b9a232551cmr14377085ad.9.1777525891010; 
 Wed, 29 Apr 2026 22:11:31 -0700 (PDT)
X-Received: by 2002:a17:902:ce0c:b0:2b4:5b9e:4edd with SMTP id
 d9443c01a7336-2b9a232551cmr14376795ad.9.1777525890455; 
 Wed, 29 Apr 2026 22:11:30 -0700 (PDT)
Received: from fedora ([49.36.110.58]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b988772e6dsm39623115ad.16.2026.04.29.22.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 22:11:30 -0700 (PDT)
Date: Thu, 30 Apr 2026 10:41:21 +0530
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
Message-ID: <afLkebmMTFPEyAuK@fedora>
References: <20260422103018.123608-1-armenon@redhat.com>
 <20260422103018.123608-7-armenon@redhat.com>
 <ef476984-6a55-4654-89e3-2703d8baca25@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef476984-6a55-4654-89e3-2703d8baca25@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: armenon@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Apr 29, 2026 at 07:14:38PM -0400, Stefan Berger wrote:
> 
> 
> On 4/22/26 6:30 AM, Arun Menon wrote:
> > From: Arun Menon <armenon@redhat.com>
> > 
> > - Add subsection in VMState for TPM CRB with the newly introduced
> >    command and response buffer GByteArrays, along with a needed callback,
> >    so that newer QEMU only sends the buffers if it is necessary.
> > - Implement a migration blocker to prevent migration of the VM if the
> >    user manually enables chunking capability, cap-chunk, but the machine
> >    type does not support it, using a new hw_compat property called
> >    allow_chunk_migration.
> > - Add a post_load_errp hook so that during a migration, the buffers are
> >    validated before destination VM is started.
> > 
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >   hw/core/machine.c |  1 +
> >   hw/tpm/tpm_crb.c  | 71 +++++++++++++++++++++++++++++++++++++++++++++++
> >   2 files changed, 72 insertions(+)
> > 
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 6d27cf69a2..b590af0125 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -40,6 +40,7 @@
> > 
> >   GlobalProperty hw_compat_11_0[] = {
> >       { "tpm-crb", "cap-chunk", "off"},
> > +    { "tpm-crb", "x-allow-chunk-migration", "off"},
> >   };
> >   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> > 
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index 29370d6f49..23e6948aee 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -24,6 +24,7 @@
> >   #include "hw/pci/pci_ids.h"
> >   #include "hw/acpi/tpm.h"
> >   #include "migration/vmstate.h"
> > +#include "migration/blocker.h"
> >   #include "system/tpm_backend.h"
> >   #include "system/tpm_util.h"
> >   #include "system/reset.h"
> > @@ -51,6 +52,8 @@ struct CRBState {
> >       TPMPPI ppi;
> > 
> >       bool cap_chunk;
> > +    bool allow_chunk_migration;
> > +    Error *migration_blocker;
> >   };
> >   typedef struct CRBState CRBState;
> > 
> > @@ -353,12 +356,63 @@ static int tpm_crb_pre_save(void *opaque)
> >       return 0;
> >   }
> > 
> > +static bool tpm_crb_chunk_needed(void *opaque)
> > +{
> > +    CRBState *s = opaque;
> > +
> > +    if (!s->allow_chunk_migration) {
> > +        return false;
> > +    }
> > +
> > +    return ((s->command_buffer && s->command_buffer->len > 0) ||
> > +            (s->response_buffer && s->response_buffer->len > 0));
> > +}
> > +
> > +static bool tpm_crb_chunk_post_load(void *opaque, int version_id, Error **errp)
> > +{
> > +    CRBState *s = opaque;
> > +
> > +    if (!s->response_buffer || !s->command_buffer) {
> > +        error_setg(errp, "tpm-crb: Internal buffers are not allocated");
> 
> Could this happen that this state type is resumed but the buffers are not
> allocated?

Yes, this is not required. Its just a defense. The tpm_realize()
function should allocate the command and response buffers.

> 
> > +        return false;
> > +    }
> > +    if (s->response_offset > s->response_buffer->len) {
> > +        error_setg(errp, "tpm-crb: Invalid response "
> > +                   "offset %" PRIu32 " in migration stream",
> > +                   s->response_offset);
> > +        return false;
> > +    }
> 
> The check is correct but can this particular case occur other than through
> crafted input?

Not that I can think of. The check is indeed added to address malicious
migration stream / crafted input.

> 
> > +    if (s->response_buffer->len > s->be_buffer_size ||
> > +        s->command_buffer->len > s->be_buffer_size) {
> 
> I suppose this could happen if I was running with a PQC-enable swtpm/libtpms
> and suspended at the right moment that when a chunked command or response
> was in the buffer and now I am trying to resume with a non-PQC-enabled swtpm
> that only has 4kb buffer, while the newer PQC one had 8kb buffer.
> 

Yes. This check is for safety. We do not want to migrate to a VM that
has a tpm backend that does not support big buffers.

> > +        error_setg(errp, "tpm-crb: Buffer sizes exceed backend capacity");
> > +        return false;
> > +    }
> > +    return true;
> > +}
> > +
> > +static const VMStateDescription vmstate_tpm_crb_chunk = {
> > +    .name = "tpm-crb/chunk",
> > +    .version_id = 0,
> > +    .needed = tpm_crb_chunk_needed,
> > +    .post_load_errp = tpm_crb_chunk_post_load,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
> > +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
> > +        VMSTATE_UINT32(response_offset, CRBState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >   static const VMStateDescription vmstate_tpm_crb = {
> >       .name = "tpm-crb",
> >       .pre_save = tpm_crb_pre_save,
> >       .fields = (const VMStateField[]) {
> >           VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
> >           VMSTATE_END_OF_LIST(),
> > +    },
> > +    .subsections = (const VMStateDescription * const []) {
> > +        &vmstate_tpm_crb_chunk,
> > +        NULL,
> >       }
> >   };
> > 
> > @@ -366,6 +420,8 @@ static const Property tpm_crb_properties[] = {
> >       DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> >       DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
> >       DEFINE_PROP_BOOL("cap-chunk", CRBState, cap_chunk, true),
> > +    DEFINE_PROP_BOOL("x-allow-chunk-migration", CRBState,
> > +                     allow_chunk_migration, true),
> >   };
> > 
> >   static void tpm_crb_reset(void *dev)
> > @@ -422,6 +478,7 @@ static void tpm_crb_reset(void *dev)
> >   static void tpm_crb_realize(DeviceState *dev, Error **errp)
> >   {
> >       CRBState *s = CRB(dev);
> > +    int ret;
> > 
> >       if (!tpm_find()) {
> >           error_setg(errp, "at most one TPM device is permitted");
> > @@ -431,6 +488,15 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
> >           error_setg(errp, "'tpmdev' property is required");
> >           return;
> >       }
> > +    if (s->cap_chunk && !s->allow_chunk_migration) {
> > +        error_setg(&s->migration_blocker,
> > +                   "The tpm-crb device does not support chunk migration with "
> > +                   "machine version less than 11.1");
> > +        ret = migrate_add_blocker_normal(&s->migration_blocker, errp);
> > +        if (ret < 0) {
> > +            return;
> > +        }
> > +    }
> > 
> >       memory_region_init_io(&s->mmio, OBJECT(s), &tpm_crb_memory_ops, s,
> >           "tpm-crb-mmio", sizeof(s->regs));
> > @@ -463,6 +529,11 @@ static void tpm_crb_unrealize(DeviceState *dev)
> > 
> >       g_clear_pointer(&s->command_buffer, g_byte_array_unref);
> >       g_clear_pointer(&s->response_buffer, g_byte_array_unref);
> > +
> > +    if (s->migration_blocker) {
> > +        migrate_del_blocker(&s->migration_blocker);
> > +        error_free(s->migration_blocker);
> > +    }
> >   }
> > 
> >   static void tpm_crb_class_init(ObjectClass *klass, const void *data)
> 

Regards,
Arun Menon


