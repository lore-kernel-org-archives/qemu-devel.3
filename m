Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B89C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 17:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubMbg-0008Ft-5o; Mon, 14 Jul 2025 13:04:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLYd-0000L6-63
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:57:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubLYZ-0007eF-5v
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 11:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752508648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fdD1uEU9rRj7FsWsr9hAfgMbXPD7uT6cumWjS30i9rg=;
 b=NcDNfRk6I8lgWC278X0cldpFBSMEnH/rWcGG8nlOLVA2lLisSd6ftvZtz5z52nZgDukgvg
 DpfOzHVAQq+Q0bcW5KPJAE5NFMosX7g4vbQXjohVMoKahS2OD4W54kaGbLTL5tTyTpYgrp
 8K3zK8Ygb/7hyVSt3OopNaUtOQf84NM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-I49sGKmqMhCI2ULLXkJtqw-1; Mon, 14 Jul 2025 11:57:26 -0400
X-MC-Unique: I49sGKmqMhCI2ULLXkJtqw-1
X-Mimecast-MFC-AGG-ID: I49sGKmqMhCI2ULLXkJtqw_1752508646
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-455e9daab1cso6146595e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 08:57:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752508646; x=1753113446;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fdD1uEU9rRj7FsWsr9hAfgMbXPD7uT6cumWjS30i9rg=;
 b=EtPCQkfl8YPr0fRsEUkG4TDs3LHL5oYJRcj09mvu+cs00SzTfMZ1MyWtzPd/8ZGwHz
 Z+SZFMUIfUGUR1JLBSuKwffxJlyjTEOhQlEjtEMkf2+C1zBDn6LemEofkIxhP5uxU38t
 fivlGPS4J+nlty3dig6xUcI0jZD+Za5LRb55xpWUoCf1UdRkSodNQSByjIBn14NTY4V8
 afTCJ+EDxjGxicTT7y2Ct2xw53QNh314M0F/bJ48diAc3aZvUNc0pFTDLfuDjAh5mMIe
 z20ZuPIqSzEyaFq7EII0GFzStUSz7FUmtD+/tEZp2RnCv+yq2L4dFm8k73Cz5Y07nSYs
 Ly5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1/HdLOT5oDvDZa0/2dT7pyNBPI0avUad78eA5CoCuQ5/qJ9gF+mp/U9xIrRBAnb18//SRW8QppJ/n@nongnu.org
X-Gm-Message-State: AOJu0YxWm7WnBTM0Kd63pXOcnK7hN0HJFE7LLeV+b2g7VJocSgu25fvE
 LNs36lzGV5zCpDEQySc2kr8406IOhVApnVT21dpqvgUDDmF9vdu4E6jnkf9cj9hisW7t+rIHfhl
 5KQplQntn7+5Ao/I/fFZ72T+O0wMsh4N0JeS22VInkkfh1Y2a9REZkfiW
X-Gm-Gg: ASbGncscFLgC4zQVQ9GuvEgg7z0a6apUOncMRX+p1joos/V3p5XmcG+qYWES9/lX5Ez
 JAzKfXNuQEtT2T5sXxLMKrrkeNjcplBJTuOcLHN5zW3eKRxwKh5HrDdbfI4icyps8tOZLx3O2yb
 05VscApTjnYczids4SqVXB4FQLkEHnL0XLIMD4UZLvnjtm3bW80WB//67UoHxKwy5ksCFhrjTIp
 8yNfo2YUmhKfo/W3mRQ88dDQQs+r0gGEynAbZBVhB0qPzqQ22L2kk/b3vDyepjpayCR/I6pqT86
 QYU2l5oI1yheR/Rifu8YkXlOWTJVrpkk
X-Received: by 2002:a05:600c:1d25:b0:456:1ac8:cace with SMTP id
 5b1f17b1804b1-4561ac8ce5emr48933585e9.12.1752508645530; 
 Mon, 14 Jul 2025 08:57:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ5tm3OaAtDETPu3iRIbWSfLIX/aUvSy493duiY3vjm8G0lc0KGGdXU4HstqEmoJ6x+gjYGg==
X-Received: by 2002:a05:600c:1d25:b0:456:1ac8:cace with SMTP id
 5b1f17b1804b1-4561ac8ce5emr48933215e9.12.1752508645064; 
 Mon, 14 Jul 2025 08:57:25 -0700 (PDT)
Received: from redhat.com ([2a02:14f:23:49e3:7a5d:209f:1dfc:d594])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e332sm12842644f8f.79.2025.07.14.08.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 08:57:24 -0700 (PDT)
Date: Mon, 14 Jul 2025 11:57:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: anisinha@redhat.com, imammedo@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, peter.maydell@linaro.org,
 prime.zeng@hisilicon.com, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com, maobibo@loongson.cn, gaosong@loongson.cn,
 jiaxun.yang@flygoat.com
Subject: Re: [PATCH v6 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250714115603-mutt-send-email-mst@kernel.org>
References: <20250604115233.1234-1-alireza.sanaee@huawei.com>
 <20250604115233.1234-4-alireza.sanaee@huawei.com>
 <20250714090807-mutt-send-email-mst@kernel.org>
 <20250714151041.0000599d.alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714151041.0000599d.alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Jul 14, 2025 at 03:10:41PM +0100, Alireza Sanaee wrote:
> On Mon, 14 Jul 2025 09:09:10 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Jun 04, 2025 at 12:52:32PM +0100, Alireza Sanaee wrote:
> > > From: Yicong Yang <yangyicong@hisilicon.com>
> > > 
> > > Currently we build the PPTT starting from the socket node and each
> > > socket will be a separate tree. For a multi-socket system it'll
> > > be hard for the OS to know the whole system is homogeneous or not
> > > (actually we're in the current implementation) since no parent node
> > > to telling the identical implementation informentation. Add a
> > > root node for indicating this.
> > > 
> > > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> > > ---
> > >  hw/acpi/aml-build.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> > > index 560cee12a2..76a4157a18 100644
> > > --- a/hw/acpi/aml-build.c
> > > +++ b/hw/acpi/aml-build.c
> > > @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data,
> > > BIOSLinker *linker, MachineState *ms, int64_t socket_id = -1,
> > > cluster_id = -1, core_id = -1; uint32_t socket_offset = 0,
> > > cluster_offset = 0, core_offset = 0; uint32_t pptt_start =
> > > table_data->len;
> > > +    uint32_t root_offset;
> > >      int n;
> > >      AcpiTable table = { .sig = "PPTT", .rev = 2,
> > >                          .oem_id = oem_id, .oem_table_id =
> > > oem_table_id }; 
> > >      acpi_table_begin(&table, table_data);
> > >  
> > > +    /*
> > > +     * Build a root node for all the processor nodes. Otherwise
> > > when
> > > +     * building a multi-socket system each socket tree is separated
> > > +     * and will be hard for the OS like Linux to know whether the
> > > +     * system is homogeneous.
> > > +     */
> > > +    root_offset = table_data->len - pptt_start;
> > > +    build_processor_hierarchy_node(table_data,
> > > +        (1 << 0) | /* Physical package */
> > > +        (1 << 4), /* Identical Implementation */
> > > +        0, 0, NULL, 0);
> > > +
> > >      /*
> > >       * This works with the assumption that cpus[n].props.*_id has
> > > been
> > >       * sorted from top to down levels in
> > > mc->possible_cpu_arch_ids(). @@ -2175,7 +2188,7 @@ void
> > > build_pptt(GArray *table_data, BIOSLinker *linker, MachineState
> > > *ms, build_processor_hierarchy_node(table_data, (1 << 0) | /*
> > > Physical package */ (1 << 4), /* Identical Implementation */
> > > -                0, socket_id, NULL, 0);
> > > +                root_offset, socket_id, NULL, 0);
> > >          }
> > >  
> > >          if (mc->smp_props.clusters_supported &&
> > > mc->smp_props.has_clusters) {  
> > 
> > 
> > This function is also used by loongarch64, but you do not update the
> > loongarch64 expected files:
> > https://gitlab.com/mstredhat/qemu/-/jobs/10672661860
> 
> Hi Michael,
> 
> There are new tests you have brought in the
> tree after mine. 
> https://gitlab.com/mstredhat/qemu/-/commit/9e4f80654cefd051f8f5c220d5447201b6cf1810
> 
> I can try to fix this and resend with updated PPTT files for
> loongarch64. WDYT?

That commit is in master though, right?
Sounds good, pls do.

> > 
> > > -- 
> > > 2.43.0  
> > 
> > 


