Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734ECCAC587
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 15:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqa2R-00071U-J5; Tue, 17 Sep 2024 11:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqa2O-00070o-TN
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:22:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sqa2N-0007Jh-B4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 11:22:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726586558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kVNzcPJtWdGeNQl5mUfxLbMTyPgjJZvkVqNPRnpN6Ts=;
 b=A9JhALVA124nzreCfP9JJu4pIlQsskCXqlsr53xjUUbDza51aB47emqIhjuwNTAANfkyfi
 xQPWl3evIfSPO0rpQ8LMSlMRGDyEB/kM4ncGDM9iMybM+SSMbOlUYdicmp7qmGcxqXE5b0
 4FS4njNwog8O/rVmSVmbB+E8titj3ug=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-3HtFFbscOEC0YFll4nrkqg-1; Tue, 17 Sep 2024 11:22:37 -0400
X-MC-Unique: 3HtFFbscOEC0YFll4nrkqg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7a9a32ac034so1224503485a.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 08:22:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726586556; x=1727191356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVNzcPJtWdGeNQl5mUfxLbMTyPgjJZvkVqNPRnpN6Ts=;
 b=EVoJTN8wEUCSUl/RF3dzHHHaVnngYRTaVE1eGcdhxIcpCZqy1wpzn/Mocuab0ZWs8H
 zlEBwgkiQ/KeuUkXoxhEcc+rsd0FfCZSBks03gByzwa7En8BSIS+evZyGT3Fuarj+rYj
 2iCYRbm2y8ROyYdZ8DRUMUNu/kTG7eVvyf/2y0n2ukuTFVhyd4j+7OKfDijI7xl780W6
 UpDh17zhxmI9y5X6l/MJXj1WyCX4fk6J74wdsyxBqg6Ebkuek+JKq1dUYFrLpUIbAeHz
 FSDsq+VUcRUnsLRst50OGjWdTeU3sF25ZN+KNpPONnJq157TdJpdrUZOEQHf4eHAmjtX
 sWoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL07YZmrlCCkjHfp3LfyD8h2CfdA54jV5A+EugNypyBnifxRPbW5JnXvb6EsKiGKUlJ4e38t4HeNj/@nongnu.org
X-Gm-Message-State: AOJu0Yyqn8zUV6UG9oOI3Lxlag0xKcfNJRptVp2t+zvseXjoK83NoKok
 Cl2cDn2j4Y2IlRiKIur/wfKda8m/9Xt4vStOYWXsMGEE4QGJ9+xAPyPiFkj+1hOxsn6xN5TmL+1
 zkOR8hWvdVSqH70qNeMY7VRGpWCjpyT1QerE24z5HmJ42TNHkVX5H
X-Received: by 2002:a05:620a:484:b0:7ac:a077:6a1e with SMTP id
 af79cd13be357-7aca0776ac1mr194410085a.9.1726586555837; 
 Tue, 17 Sep 2024 08:22:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4xX1n5vRQPcE2i5odLOKTy7iWO0rD+5f1yG6JD9ULO+gdNCAcyCtvfbS9/cxvUhtWHamzNw==
X-Received: by 2002:a05:620a:484:b0:7ac:a077:6a1e with SMTP id
 af79cd13be357-7aca0776ac1mr194407385a.9.1726586555449; 
 Tue, 17 Sep 2024 08:22:35 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ab3e95e99fsm367173885a.17.2024.09.17.08.22.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2024 08:22:34 -0700 (PDT)
Date: Tue, 17 Sep 2024 11:22:31 -0400
From: Peter Xu <peterx@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, linux-kernel@vger.kernel.org,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v10 02/21] acpi/generic_event_device: Update GHES
 migration to cover hest addr
Message-ID: <ZumetxyRro8RfC8h@x1n>
References: <cover.1726293808.git.mchehab+huawei@kernel.org>
 <bed4b2da51e0c894cc255f712b67e2e57295d826.1726293808.git.mchehab+huawei@kernel.org>
 <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240917111921.7e95726b@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 17, 2024 at 11:19:21AM +0200, Igor Mammedov wrote:
> On Sat, 14 Sep 2024 08:13:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The GHES migration logic at GED should now support HEST table
> > location too.
> > 
> > Increase migration version and change needed to check for both
> > ghes_addr_le and hest_addr_le
> But I don't think it will work like this (but I might be easily wrong)
> However I don't know enough to properly review this patch, CCing Peter & Fabiano
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/generic_event_device.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 15b4c3ebbf24..4e5e387ee2df 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -343,10 +343,11 @@ static const VMStateDescription vmstate_ged_state = {
> >  
> >  static const VMStateDescription vmstate_ghes = {
> >      .name = "acpi-ghes",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_UINT64(ghes_addr_le, AcpiGhesState),
> > +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> >          VMSTATE_END_OF_LIST()
> >      },
> >  };
> > @@ -354,13 +355,13 @@ static const VMStateDescription vmstate_ghes = {
> >  static bool ghes_needed(void *opaque)
> >  {
> >      AcpiGedState *s = opaque;
> > -    return s->ghes_state.ghes_addr_le;
> > +    return s->ghes_state.ghes_addr_le && s->ghes_state.hest_addr_le;
> >  }
> 
> what I would do:
>   add ghes_needed_v2(): return  s->ghes_state.hest_addr_le;
> 
> and then instead of reusing vmstate_ghes_state would add new
> vmstate_ghes_v2_state subsection that migrates only 
>   VMSTATE_UINT64(hest_addr_le, AcpiGhesState)
> field.
> 
> btw: we probably don't need ghes_addr_le for new code that
> uses HEST to lookup relevant error status block.
> but we should still keep it for 9.1 and older machine types
> as they expect/use it. Separate subsections would work with
> this req just fine.

Right, if we need bi-directional migration we need above and a compat
property (or VMSTATE_UINT64_TEST() would work too, iiuc).

OTOH VMSD versioning only works for forward migration, not backward.

> 
> >  static const VMStateDescription vmstate_ghes_state = {
> >      .name = "acpi-ged/ghes",
> > -    .version_id = 1,
> > -    .minimum_version_id = 1,
> > +    .version_id = 2,
> > +    .minimum_version_id = 2,

(and IIUC if we set min ver=2, even forward migration should fail.. better
 test it with an old binary, migrating back and forth)

> >      .needed = ghes_needed,
> >      .fields = (const VMStateField[]) {
> >          VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> 

Thanks,

-- 
Peter Xu


