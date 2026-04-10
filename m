Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5BFF44873
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 14:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBD1y-0006S9-Ma; Fri, 10 Apr 2026 10:40:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wBD1x-0006RO-1T
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:40:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wBD1u-0002W4-Tm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 10:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775832011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+ErbSi1YbiIz+eNhdJc5Xvqs8bktrgmSwgg3fb1rvk=;
 b=MPx1HfU9uOCQLH3m4oV6/vfPxnORucTn7sUYdBcP+3nxOMl7rorqdCKJEVKd71c2JuL6hb
 J1QDKsuT5Wgf1lfhzfO9XXK3HbehVpyfDR1SgNDJAUGQF7K/+3baUg87rRoX5ZubvDN4zu
 QfywQysJb1GnekVdF2pnnDNTPsIB6hE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-sbCVmsRqOsuQTPSV8xa_lw-1; Fri, 10 Apr 2026 10:40:09 -0400
X-MC-Unique: sbCVmsRqOsuQTPSV8xa_lw-1
X-Mimecast-MFC-AGG-ID: sbCVmsRqOsuQTPSV8xa_lw_1775832009
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b241be0126so40039785ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 07:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775832009; x=1776436809; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z+ErbSi1YbiIz+eNhdJc5Xvqs8bktrgmSwgg3fb1rvk=;
 b=T4KhN9QU7vOXXa7MvpoftVo5W4T4/wPVAiOFik2hptX6V/6rNWZHfThO1UCiM5FHkr
 YeCaQXhEzNd+tnAJBQn2+MK/3vM2Uo0DOM/DbwjAlIhJW9emq1uu5rLC5d7roUlQvTUe
 XTaoczbKNSq1lDJ0VF+bkMOhefXk0l8s98ppKrjlKYvrRgA9sJjDzMq8rRxC6ehxbYO4
 ep4E6w7SUytiOZNfRUNaITdW/O/0++2k3hL0J9rafoagXIw7z48yTzK52Y+7qDKLt3KF
 8Yi2VMWRN4nPGMMFPx12EiswCSuloCChtTKSIs3aMB6vkk4cQ8Q/Bu4MU3NSeN61rb41
 GyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775832009; x=1776436809;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z+ErbSi1YbiIz+eNhdJc5Xvqs8bktrgmSwgg3fb1rvk=;
 b=KD2LF/AcrgiHQGX8WqTGmdqtNe132n+WF/M5Dmz7UdeisNKR+Nw5nHwdEpJJ+qqmQy
 WlR6/aaDs2p2W2DN+4qg9GMmuVN0YZMt1GzVqF4Q7rjm85dfl5/a5w449lzG2Kds2H7C
 +RsceiLpYlKapPtLWBfuibRLgYsAttRfdWGIrTravOVgfNn4oI0Yin02bhyC29ziUW/F
 ETLtestO1z0uMXmM/K91M699+C2Xe1lU98ohMVbNiJ5Y88m2CDenXBTd834gi6LuHz/f
 sIvGzL+MUIhyJrt7qieLNk5f2/DNTGf9b4QqAjTUm2WZD3IQxbpE0ebpT5iMxzAhYqIH
 e3kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF55XdVOOUjnyoIeT3d3nCtFsaKxIKTSgoy4SbDFPzfvnGpz6pgwkXmVtw+sYzeccWvkOmbsq1QCSa@nongnu.org
X-Gm-Message-State: AOJu0Yx5/sGa3iQhLhqvX4L3/BN7Bi/VbOvLVP4wkbMuJksQDLhr4Bju
 iHm/1s1STitXqRPGepp5QsgvcvQ6f5tP+Z3N2ZSBtJAJ6vNY70RDCPYPVy1TcNF19lT6lfMddsn
 ZDr2Dm0uXL3R3OjIrH0RcgiQNzvgHGoks3qhUKGUXUyuTTFHsh5LScZJS
X-Gm-Gg: AeBDieu5BikKIx3isKvUB7XEsMxEyDCeMuiZyG7yMhVOm0rapJxrAbyHL7gIHIvBP8E
 coNdKA77wA1aor+eUWHcRdzbWX8slpZev8mQsxULSANsEza/jU8ZihPpOtozVObJnHAxtcLhSKS
 Yk0+r2ZEFci/joWBE1n/lgUmFn8Rg3boG/arpww2yxnSWBiZM5sznMl2E166XdougETBHuZ4HCl
 4bGWlMUq4927nXkhV8yof0D7TbLHA+95YesykLyY5UgmFhkrP8yBcy/UTkHa83xgm/Ez3fdpZqF
 vgpF3YGML/hE6qP+KbA2u0EERqiAFKVyEzWPJwV190jFe+wTzpMnsgQI3GzKuzHFilavllYhI2B
 acQGHl5yFdch+
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b2d59adee5mr37922125ad.14.1775832008643; 
 Fri, 10 Apr 2026 07:40:08 -0700 (PDT)
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b2d59adee5mr37921655ad.14.1775832008084; 
 Fri, 10 Apr 2026 07:40:08 -0700 (PDT)
Received: from fedora ([49.36.110.202]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4e0accbsm30652295ad.33.2026.04.10.07.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 07:40:07 -0700 (PDT)
Date: Fri, 10 Apr 2026 20:09:55 +0530
From: Arun Menon <armenon@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>, qemu-devel@nongnu.org,
 Ani Sinha <anisinha@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 06/10] hw/tpm: Add support for VM migration with TPM
 CRB chunking
Message-ID: <adkLu8uBy_Lkfrop@fedora>
References: <20260406141735.25844-1-armenon@redhat.com>
 <20260406141735.25844-7-armenon@redhat.com>
 <CAMxuvaw1Zaui2mSw2o6M6OzC7vnwN8CW1hgnZEtz1BiZmsT1kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvaw1Zaui2mSw2o6M6OzC7vnwN8CW1hgnZEtz1BiZmsT1kg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Apr 07, 2026 at 03:00:27PM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Apr 6, 2026 at 6:18 PM Arun Menon <armenon@redhat.com> wrote:
> >
> > From: Arun Menon <armenon@redhat.com>
> >
> > - Add subsection in VMState for TPM CRB with the newly introduced
> >   command and response buffers, along with a needed callback, so that
> >   newer QEMU only sends the buffers if it is necessary.
> > - Add hw_compat blocker because the feature is only supported for
> >   machine type 11.1 and higher.
> > - If the VM has no pending chunked TPM commands in the internal buffers
> >   during a VM migration, or if the machine type does not support newly
> >   introduced buffers, then the needed callback will return false, as it
> >   checks the hw_compat blocker and thus the subsection will not be sent
> >   to the destination host.
> >
> > Signed-off-by: Arun Menon <armenon@redhat.com>
> > ---
> >  hw/core/machine.c |  4 +++-
> >  hw/tpm/tpm_crb.c  | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > index 1abc8ae737..fb290c6c53 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -38,7 +38,9 @@
> >  #include "hw/acpi/generic_event_device.h"
> >  #include "qemu/audio.h"
> >
> > -GlobalProperty hw_compat_11_0[] = {};
> > +GlobalProperty hw_compat_11_0[] = {
> > +    { "tpm-crb", "migrate-buffers", "off"},
> 
> If this is not intended to be user visible, we should use x- prefix

Yes, I will add x- prefix.

> 
> The problem is that the previous code changes expose CapChunk to the
> guest unconditionally.
> 
> If running with <=11.0 we should not enable chunk transfer by default
> - or we need to prevent/block migration... otherwise we may lose
> VM/device state, expose a differente device etc.
> 
> What about having a "cap-chunk" property? Enable it by default with >=11.1.
> 
> If enabled when <=11.0, then also disable migration.

This is really good insight. Similar to migrate-buffers, I need to make
sure that the CapCRBChunk bit is set only when we are running the newer
machine type.

I shall introduce a new entry in hw_compat array called x-cap-chunk.
That means, we should not unconditionally set the CapCRBChunk bit to 1.
We should set the bit based on cap_chunk property.

However, I am a bit confused on the order of precedence of this variable.
From what I understand, the device initialization happens first ->
followed by the compat properties

So,
"DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true)"
gets executed first setting it to true by default and then, the compat
property is applied,
"GlobalProperty hw_compat_11_0[] = {
    { "tpm-crb", "migrate-buffers", "off"},
}"
setting it to false.

When is the user provided command line argument parsed?
For example launching qemu using:
    -machine pc-11.0 
    -device tpm-crb,tpmdev=tpm0,cap-chunk=on

Is it set in the end? In the above example, the user explicitly set
cap-chunk to true whereas the migrate-buffers default value is false.

Therefore we end up with the following scenario.
Since chunking is supported, the guest writes a large command in the
buffer. The user then decides to migrate the VM. QEMU sees that
migrate-buffer is off, so it does not migrate the buffers. When the VM
resumes on the destination host, it will find the buffers empty.

Therefore, we need to stop migration if cap-chunk is enabled but
migrate-buffers is disabled. Please guide.

> 
> > +};
> >  const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
> >
> >  GlobalProperty hw_compat_10_2[] = {
> > diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
> > index b9f295db7a..81471dd9f8 100644
> > --- a/hw/tpm/tpm_crb.c
> > +++ b/hw/tpm/tpm_crb.c
> > @@ -49,6 +49,8 @@ struct CRBState {
> >
> >      bool ppi_enabled;
> >      TPMPPI ppi;
> > +
> > +    bool migrate_buffers;
> >  };
> >  typedef struct CRBState CRBState;
> >
> > @@ -345,18 +347,47 @@ static int tpm_crb_pre_save(void *opaque)
> >      return 0;
> >  }
> >
> > +static bool tpm_crb_chunk_needed(void *opaque)
> > +{
> > +    CRBState *s = opaque;
> > +
> > +    if (!s->migrate_buffers) {
> > +        return false;
> > +    }
> > +
> > +    return ((s->command_buffer && s->command_buffer->len > 0) ||
> > +            (s->response_buffer && s->response_buffer->len > 0));
> > +}
> > +
> > +static const VMStateDescription vmstate_tpm_crb_chunk = {
> > +    .name = "tpm-crb/chunk",
> > +    .version_id = 0,
> > +    .needed = tpm_crb_chunk_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_GBYTEARRAY(command_buffer, CRBState, 0),
> > +        VMSTATE_GBYTEARRAY(response_buffer, CRBState, 0),
> > +        VMSTATE_UINT32(response_offset, CRBState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_tpm_crb = {
> >      .name = "tpm-crb",
> >      .pre_save = tpm_crb_pre_save,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT32_ARRAY(regs, CRBState, TPM_CRB_R_MAX),
> >          VMSTATE_END_OF_LIST(),
> > +    },
> > +    .subsections = (const VMStateDescription * const []) {
> > +        &vmstate_tpm_crb_chunk,
> > +        NULL,
> >      }
> >  };
> >
> >  static const Property tpm_crb_properties[] = {
> >      DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
> >      DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
> > +    DEFINE_PROP_BOOL("migrate-buffers", CRBState, migrate_buffers, true),
> >  };
> >
> >  static void tpm_crb_reset(void *dev)
> > --
> > 2.53.0
> >
>

Regards,
Arun Menon


