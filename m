Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47EC8C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 08:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbyF0-0000dm-05; Thu, 08 Aug 2024 04:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbyEy-0000ZK-Sj
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sbyEu-0001sj-7P
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 04:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723104673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SNHI/L4vlvGksF8p9K8eTN2Ci20cAuoEW6eGCMZ9ao4=;
 b=DNUCfgqvVOt2ZhPV+4xa4wvQ6M6TQV717Yt+7ODKD5p1bSkla8NSZlB6zZtvrVsyMpFuG5
 cqIwa+4kx1sCEC+BC33u6vLZGoWpqrHggAn4E32TthPMYSVrJnHVVrdmh7HeFHiKhmg8Zz
 zdB88wxg88LIEKl5Bvv7c8lKubZnGfU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-ap2zL0_UMAu7QC9vlB5YRQ-1; Thu, 08 Aug 2024 04:11:12 -0400
X-MC-Unique: ap2zL0_UMAu7QC9vlB5YRQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42820c29a76so5109465e9.2
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 01:11:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723104671; x=1723709471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SNHI/L4vlvGksF8p9K8eTN2Ci20cAuoEW6eGCMZ9ao4=;
 b=laIFUYel/xWrKZfejvUZPamqb44FQRSu56rLz9Kmhi5ECoDPLODzI0C9QnKGHfd4TB
 mMjrcTOgEZ3D/EUKTKrD3O4IX7wm2GM3RANha4M8jRTJNJsWhdPK/HgMp8/ZBZl3TZ0w
 l8joii2CtlqukAz8qDa2we6CPD/XDRaw64wjmis1dZYSxoYs+ShDu6HSMTlmOS12ac86
 VOsC3k7V+40+M4wisGKOWRjUkyJXy/b5/TenF3N7VgUDQKhfBwPvI9rhaakks9FRpvz1
 kX5EsKcu6q7WkI5d1KmzSYEAvVE3Z0au5lfvkHTIdxfPuxUTPUW5/cYsLSV9xmq06ZU3
 6gLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWF2unwNPQJiR/Oo/OECA8B82EwIg7lTWgmZeZI2vWq1EXa5bktbrJMRsTg44FDOJa6sUl2WypcwyaO//Y/r4dbdin4ad8=
X-Gm-Message-State: AOJu0YxiNcK7dFC105q77knu15ss2Wo53wjeYSoEW18IA1B59NJ6PGyj
 uFmeeW6G7KRugNXtciFYPBC7NRTeF+7vtkibTLBPvimDzMxF/4tCHLA1GlxTSHsAHmmRBiTpE0I
 OFhpurKq01XxyGsZeoB8cJTOtOHXbu/Ui/mmhjANTfJ2Dg2GhDXT+
X-Received: by 2002:a05:600c:4689:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-4290af0ff08mr7220035e9.30.1723104670896; 
 Thu, 08 Aug 2024 01:11:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOeNai7tCrc/Ff3wEyME20VmRZuQbs+TYp64T/yY6ucAE9oqlwBRMxH7c7oo//sgO5I2OXrQ==
X-Received: by 2002:a05:600c:4689:b0:426:647b:1bfc with SMTP id
 5b1f17b1804b1-4290af0ff08mr7219785e9.30.1723104670279; 
 Thu, 08 Aug 2024 01:11:10 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36d2724c72asm1047259f8f.113.2024.08.08.01.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 01:11:09 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:11:07 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 6/7] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240808101107.105a124f@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240807152547.000058fd@Huawei.com>
References: <cover.1722634602.git.mchehab+huawei@kernel.org>
 <20c491e357340e0062b6ff09867c1661ed4d2479.1722634602.git.mchehab+huawei@kernel.org>
 <20240806163113.3bdc260a@imammedo.users.ipa.redhat.com>
 <20240807152547.000058fd@Huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Wed, 7 Aug 2024 15:25:47 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 6 Aug 2024 16:31:13 +0200
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
> > On Fri,  2 Aug 2024 23:44:01 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Provide a generic interface for error injection via GHESv2.
> > > 
> > > This patch is co-authored:
> > >     - original ghes logic to inject a simple ARM record by Shiju Jose;
> > >     - generic logic to handle block addresses by Jonathan Cameron;
> > >     - generic GHESv2 error inject by Mauro Carvalho Chehab;
> > > 
> > > Co-authored-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Co-authored-by: Shiju Jose <shiju.jose@huawei.com>
> > > Co-authored-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Cc: Shiju Jose <shiju.jose@huawei.com>
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  hw/acpi/ghes.c         | 159 ++++++++++++++++++++++++++++++++++++++---
> > >  hw/acpi/ghes_cper.c    |   2 +-
> > >  include/hw/acpi/ghes.h |   3 +
> > >  3 files changed, 152 insertions(+), 12 deletions(-)
> > > 
> > > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > > index a745dcc7be5e..e125c9475773 100644
> > > --- a/hw/acpi/ghes.c
> > > +++ b/hw/acpi/ghes.c
> > > @@ -395,23 +395,22 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> > >      ags->present = true;
> > >  }
> > >  
> > > +static uint64_t ghes_get_state_start_address(void)    
> > 
> > ghes_get_hardware_errors_address() might better reflect what address it will return
> >   
> > > +{
> > > +    AcpiGedState *acpi_ged_state =
> > > +        ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED, NULL));
> > > +    AcpiGhesState *ags = &acpi_ged_state->ghes_state;
> > > +
> > > +    return le64_to_cpu(ags->ghes_addr_le);
> > > +}
> > > +
> > >  int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > >  {
> > >      uint64_t error_block_addr, read_ack_register_addr, read_ack_register = 0;
> > > -    uint64_t start_addr;
> > > +    uint64_t start_addr = ghes_get_state_start_address();
> > >      bool ret = -1;
> > > -    AcpiGedState *acpi_ged_state;
> > > -    AcpiGhesState *ags;
> > > -
> > >      assert(source_id < ACPI_HEST_SRC_ID_RESERVED);
> > >  
> > > -    acpi_ged_state = ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
> > > -                                                       NULL));
> > > -    g_assert(acpi_ged_state);
> > > -    ags = &acpi_ged_state->ghes_state;
> > > -
> > > -    start_addr = le64_to_cpu(ags->ghes_addr_le);
> > > -
> > >      if (physical_address) {
> > >          start_addr += source_id * sizeof(uint64_t);    
> > 
> > above should be a separate patch
> >   
> > >  
> > > @@ -448,9 +447,147 @@ int acpi_ghes_record_errors(uint8_t source_id, uint64_t physical_address)
> > >      return ret;
> > >  }
> > >  
> > > +/*
> > > + * Error register block data layout
> > > + *
> > > + * | +---------------------+ ges.ghes_addr_le
> > > + * | |error_block_address0 |
> > > + * | +---------------------+
> > > + * | |error_block_address1 |
> > > + * | +---------------------+ --+--
> > > + * | |    .............    | GHES_ADDRESS_SIZE
> > > + * | +---------------------+ --+--
> > > + * | |error_block_addressN |
> > > + * | +---------------------+
> > > + * | | read_ack0           |
> > > + * | +---------------------+ --+--
> > > + * | | read_ack1           | GHES_ADDRESS_SIZE
> > > + * | +---------------------+ --+--
> > > + * | |   .............     |
> > > + * | +---------------------+
> > > + * | | read_ackN           |
> > > + * | +---------------------+ --+--
> > > + * | |      CPER           |   |
> > > + * | |      ....           | GHES_MAX_RAW_DATA_LENGT
> > > + * | |      CPER           |   |
> > > + * | +---------------------+ --+--
> > > + * | |    ..........       |
> > > + * | +---------------------+
> > > + * | |      CPER           |
> > > + * | |      ....           |
> > > + * | |      CPER           |
> > > + * | +---------------------+
> > > + */    
> > 
> > no need to duplicate docs/specs/acpi_hest_ghes.rst,
> > I'd just reffer to it and maybe add short comment as to why it's mentioned.
> >   
> > > +/* Map from uint32_t notify to entry offset in GHES */
> > > +static const uint8_t error_source_to_index[] = { 0xff, 0xff, 0xff, 0xff,
> > > +                                                 0xff, 0xff, 0xff, 1, 0};
> > > +
> > > +static bool ghes_get_addr(uint32_t notify, uint64_t *error_block_addr,
> > > +                          uint64_t *read_ack_addr)
> > > +{
> > > +    uint64_t base;
> > > +
> > > +    if (notify >= ACPI_GHES_NOTIFY_RESERVED) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Find and check the source id for this new CPER */
> > > +    if (error_source_to_index[notify] == 0xff) {
> > > +        return false;
> > > +    }
> > > +
> > > +    base = ghes_get_state_start_address();
> > > +
> > > +    *read_ack_addr = base +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        error_source_to_index[notify] * sizeof(uint64_t);
> > > +
> > > +    /* Could also be read back from the error_block_address register */
> > > +    *error_block_addr = base +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        ACPI_GHES_ERROR_SOURCE_COUNT * sizeof(uint64_t) +
> > > +        error_source_to_index[notify] * ACPI_GHES_MAX_RAW_DATA_LENGTH;
> > > +
> > > +    return true;
> > > +}    
> > 
> > I don't like all this pointer math, which is basically a reverse engineered
> > QEMU actions on startup + guest provided etc/hardware_errors address.
> > 
> > For once, it assumes error_source_to_index[] matches order in which HEST
> > error sources were described, which is fragile.
> > 
> > 2nd: migration-wive it's disaster, since old/new HEST/hardware_errors tables
> > in RAM migrated from older version might not match above assumptions
> > of target QEMU. 
> > 
> > I see 2 ways to rectify it:
> >   1st: preferred/cleanest would be to tell QEMU (via fw_cfg) address of HEST table
> >        in guest RAM, like we do with etc/hardware_errors, see
> >             build_ghes_error_table()
> >                ...
> >                tell firmware to write hardware_errors GPA into
> >        and then fetch from HEST table in RAM, the guest patched error/ack addresses
> >        for given source_id
> > 
> >        code-wise: relatively simple once one wraps their own head over
> >                  how this whole APEI thing works in QEMU
> >                  workflow  is described in docs/specs/acpi_hest_ghes.rst
> >                  look to me as sufficient to grasp it.
> >                  (but my view is very biased given my prior knowledge,
> >                   aka: docs/comments/examples wrt acpi patching are good enough)
> >                  (if it's not clear how to do it, ask me for pointers)  
> 
> Hi Igor, I think I follow what you mean but maybe this question will reveal
> otherwise.  HEST is currently in ACPI_BUILD_TABLE_FILE.
> Would you suggest splitting it to it's own file, or using table_offsets
> to get the offset in ACPI_BUILD_TABLE_FILE GPA?
yep, offset taken right before HEST is to be created
doc comment for bios_linker_loader_write_pointer() explains how it works

we need something like:
       bios_linker_loader_write_pointer(linker,
           ACPI_HEST_TABLE_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
           ACPI_BUILD_TABLE_FILE, hest_offset_within_ACPI_BUILD_TABLE_FILE); 

to register new file see:
   a08a64627 ACPI: Record the Generic Error Status Block address
   and to avoid copy past error maybe
   136fc6aa2 ACPI: Avoid infinite recursion when dump-vmstat
for this needs to be limited to new machine types and keep
old ones without this new feature. (I'd use hw_compat_ machinery for that)

while at it we should rename
  ACPI_GHES_DATA_ADDR_FW_CFG_FILE -> ACPI_GHES_ERRORS_ADDR_FW_CFG_FILE



