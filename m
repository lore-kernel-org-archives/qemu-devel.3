Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20BD0C2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 19:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJefG-0002cI-PQ; Tue, 18 Jun 2024 15:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJefE-0002bx-SR
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 15:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sJefC-00020r-RL
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 15:38:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718739520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xDIvXruFFAQhC7ysQALY4i+N4Zu53we2qMuBlMkoAmQ=;
 b=hFIsiMoCNbmmpFzIVXIx59Q2BuGEKAvLttK44UZLeYNhxEPPC0ie4A3Og/78svmUhNJPRw
 2bsdmbd0AqFU8m+8nHPyy3+1zcha2gTwiugicLOeJKmldc4RZ53Qb6qRm42vykszfegl5J
 aFM/ht52f3e1Qpcl2QG/H9sbHyE1OlQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-1FoxpZo8O5SIis6MjZJ5Og-1; Tue, 18 Jun 2024 15:38:39 -0400
X-MC-Unique: 1FoxpZo8O5SIis6MjZJ5Og-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ebd6b87ff5so45240891fa.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 12:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718739518; x=1719344318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDIvXruFFAQhC7ysQALY4i+N4Zu53we2qMuBlMkoAmQ=;
 b=PKwX5J24wks6tQz2hJfKqmnu5IZpMnxFTQyyqySy4GFOTgkDBXeE/H8i2YNw4sfjAN
 N4QQuEod/VeiAMgZIdwCjQsCLpGgoYeYwN8meSXTxqzQkEZucoedcnETGNu3YvqpCFUQ
 uHopt2+4u++mGhtMBZl0DUxaLALhdADeNdoDi7YPkKgLHPuBZ7ZwhpGjd3tpdaiRnPNz
 Q2XmIzyDHYX3btVgMqZ7jIGwdTO32vxcbE63C2xkTQZeOSYgnvDKATtpzM5S/+9QIy8F
 Ha7uf2TVrr4qp5tm57aTNU33UCZEPOg9L1gAFRExBAAjy4LyIQOhZ668Te76pLhG/k9h
 Hfzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/5k/thBbR4EVl3bfGZ74onPQvzWRZR+7bd8YwQcQ3pZpWBAJS+leXRBHv2Wo7iLkt0ez5DTWOpd23nmk4iS4bb0HExYQ=
X-Gm-Message-State: AOJu0YwjDX8TfmdxqCetv1NRoXG8z8fBMtxtqNpdfzkTMDyXetZi/6Et
 PTH02aZ/XAoZdl91i7sJlUFpH6BlU1RcZlEVefDkE/fPd1d/gfcWaas88DHb48JTJ3wW9Pq63mK
 KLl6GzFyU3+h3qYm5OdKeZRet4XfEpbcGGLRNnwbgyXW+GGQyl7c+
X-Received: by 2002:ac2:5317:0:b0:52c:896b:c1f3 with SMTP id
 2adb3069b0e04-52ccaaa9049mr287002e87.65.1718739517579; 
 Tue, 18 Jun 2024 12:38:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKHjgm7cTTVcdRwUFoJ2RbTv0wWWU5Q/R++aya6ivpKMnUzLOBUncsME0x0kMqBEAWK/yEsw==
X-Received: by 2002:ac2:5317:0:b0:52c:896b:c1f3 with SMTP id
 2adb3069b0e04-52ccaaa9049mr286987e87.65.1718739516302; 
 Tue, 18 Jun 2024 12:38:36 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:441:67bf:ebbb:9f62:dc29:2bdc])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f9e2b306sm198117915e9.16.2024.06.18.12.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 12:38:35 -0700 (PDT)
Date: Tue, 18 Jun 2024 15:38:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: peter.maydell@linaro.org, wangxingang5@huawei.com,
 shannon.zhaosl@gmail.com, imammedo@redhat.com, anisinha@redhat.com,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] hw/arm/virt-acpi-build: Fix IORT id_count
Message-ID: <20240618153725-mutt-send-email-mst@kernel.org>
References: <20240617223945.906996-1-nicolinc@nvidia.com>
 <20240618054729-mutt-send-email-mst@kernel.org>
 <ZnHaNMNlFjhn5Jjb@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnHaNMNlFjhn5Jjb@Asurada-Nvidia>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Tue, Jun 18, 2024 at 12:04:20PM -0700, Nicolin Chen wrote:
> On Tue, Jun 18, 2024 at 05:49:58AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Jun 17, 2024 at 03:39:45PM -0700, Nicolin Chen wrote:
> > > The IORT doc defines "Number of IDs" ("id_count" in the virt-acpi-build)
> > > to be "the number of IDs in the range minus one". Otherwise, Linux kernel
> > > reports "conflicting mapping for input ID" FW_BUG at the overlapped ID.
> > >
> > > Fixes: 42e0f050e3a5 ("hw/arm/virt-acpi-build: Add IORT support to bypass SMMUv3")
> > > Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> > > ---
> > > Changelog
> > > v2:
> > >  * Moved "-1" to the same line of id_count calculation
> > >  * Added "+1" to the next_range.input_base calculation
> > > v1:
> > >  https://lore.kernel.org/all/20240613234802.828265-1-nicolinc@nvidia.com/
> > >
> > >  hw/arm/virt-acpi-build.c | 9 ++++++---
> > >  1 file changed, 6 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> > > index c3ccfef026..631f2c6d04 100644
> > > --- a/hw/arm/virt-acpi-build.c
> > > +++ b/hw/arm/virt-acpi-build.c
> > > @@ -243,7 +243,8 @@ iort_host_bridges(Object *obj, void *opaque)
> > >
> > >              AcpiIortIdMapping idmap = {
> > >                  .input_base = min_bus << 8,
> > > -                .id_count = (max_bus - min_bus + 1) << 8,
> > > +                /* id_count is the number of IDs in the range minus one */
> > > +                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
> > >              };
> > >              g_array_append_val(idmap_blob, idmap);
> > >          }
> > > @@ -298,11 +299,13 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
> > >              idmap = &g_array_index(smmu_idmaps, AcpiIortIdMapping, i);
> > >
> > >              if (next_range.input_base < idmap->input_base) {
> > > -                next_range.id_count = idmap->input_base - next_range.input_base;
> > > +                /* id_count is the number of IDs in the range minus one */
> > > +                next_range.id_count = idmap->input_base -
> > > +                                      next_range.input_base - 1;
> > >                  g_array_append_val(its_idmaps, next_range);
> > 
> > 
> > What about other places where id_count is set?
> 
> There are only three places where id_count could be set:
> hw/arm/virt-acpi-build.c:296:                .id_count = ((max_bus - min_bus + 1) << 8) - 1,
> hw/arm/virt-acpi-build.c:422:                next_range.id_count = idmap->input_base -
> hw/arm/virt-acpi-build.c:435:            next_range.id_count = 0xFFFF - next_range.input_base;
> 
> This patch fixes two, while the last one is correct using 0xFFFF.
> 
> > >              }
> > >
> > > -            next_range.input_base = idmap->input_base + idmap->id_count;
> > > +            next_range.input_base = idmap->input_base + idmap->id_count + 1;
> > >          }
> > >
> > 
> > Given this was different previously, did you actually test with multiple ranges?
> 
> Tested by creating 5 buses: input_base increases by 0x400 while
> id_count=0x2ff (0x300 - 1). ITS results look correct to me:
> --------------build_iort: smmu_idmaps
> DEBUG: build_iort_id_mapping: input_base=0xec00, id_count=0x2ff, out_ref=0x48, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xf000, id_count=0x2ff, out_ref=0xa0, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xf400, id_count=0x2ff, out_ref=0xf8, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xf800, id_count=0x2ff, out_ref=0x150, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xfc00, id_count=0x2ff, out_ref=0x1a8, flags=0
> --------------build_iort: its_idmaps
> DEBUG: build_iort_id_mapping: input_base=0x0, id_count=0xebff, out_ref=0x30, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xef00, id_count=0xff, out_ref=0x30, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xf300, id_count=0xff, out_ref=0x30, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xf700, id_count=0xff, out_ref=0x30, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xfb00, id_count=0xff, out_ref=0x30, flags=0
> DEBUG: build_iort_id_mapping: input_base=0xff00, id_count=0xff, out_ref=0x30, flags=0
> 
> Thanks
> Nicolin

Okay. Is it the case that none of these effect the IORT in
./tests/data/acpi/virt/IORT then?

-- 
MST


