Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3319CC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 06:06:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZ2TH-0004XI-HW; Wed, 31 Jul 2024 02:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ2TE-0004V5-LK; Wed, 31 Jul 2024 02:05:56 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1sZ2TC-00013q-KU; Wed, 31 Jul 2024 02:05:56 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 114F8CE1251;
 Wed, 31 Jul 2024 06:05:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BF0C116B1;
 Wed, 31 Jul 2024 06:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722405950;
 bh=K4cH+7VCD6e3VyLaYkP+2c/JqPrRcmLYWXVHy/HV82U=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=H4afLWhJS8R/dW6CabjXEeTVbKhhnxODQ7ygwxzyJzgnactWW7rkADN5YaX+/wtmY
 OoPJA8wapzWBgt7Oy3e/9yYxCaWhfwsgGOH2/WYR0pib6wrl2TIMMpuMij0ABMos7I
 r2ObwHJBQuSLTgA6MV+IuNyGY0j3frV2rYkmfIYMLKx2sR1ulIf/05b3Wiye1zZodO
 BE8eLipiHYRiJZxlHhqQpiOkTKukTs84ucYBmKmmgwQeHKyQIQ7UwMVO5ARg4g6lfr
 MYeytj/eRqToLRc0ikHlQR05k1KLYK6v5vRdHXmHZcizsIDKm+DOMQzyAuKzBKL10E
 VQXDVNUktaQjw==
Date: Wed, 31 Jul 2024 08:05:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>, Ani
 Sinha <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/7] acpi/ghes: update comments to point to newer
 ACPI specs
Message-ID: <20240731080545.7c0dbed7@foz.lan>
In-Reply-To: <20240730073447-mutt-send-email-mst@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <66c1ab4988589be99ae925c6361548f55fea58b0.1721630625.git.mchehab+huawei@kernel.org>
 <20240730132430.44d9e4ae@imammedo.users.ipa.redhat.com>
 <20240730073447-mutt-send-email-mst@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=mchehab+huawei@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Em Tue, 30 Jul 2024 07:36:32 -0400
"Michael S. Tsirkin" <mst@redhat.com> escreveu:

> On Tue, Jul 30, 2024 at 01:24:30PM +0200, Igor Mammedov wrote:
> > On Mon, 22 Jul 2024 08:45:58 +0200
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > There is one reference to ACPI 4.0 and several references
> > > to ACPI 6.x versions.
> > > 
> > > Update them to point to ACPI 6.5 whenever possible.  
> > 
> > when it comes to APCI doc comments, they should point to
> > the 1st (earliest) revision that provides given feature/value/field/table.  
> 
> Yes. And the motivation is twofold.
> First, guests are built against
> old acpi versions. knowing in which version things appeared
> helps us know which guests support a feature.

Good point, but IMO, a comment like "since: ACPI 4.0" would
be better, as the comment may not reflect the first version
supporting such features, but, instead, when someone added
support to a particular feature set.

> Second, acpi guys keep churning out new versions.
> It makes no sense to try and update to latest one,
> it will soon get out of date again.

True, but having it updated helps people adding new code to
get things right.

Anyway, I got your point, I'll drop this patch.

> > >  void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
> > >                       const char *oem_id, const char *oem_table_id)
> > >  {
> > > -    AcpiTable table = { .sig = "HEST", .rev = 1,
> > > +    AcpiTable table = { .sig = "HEST",
> > > +                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
> > >                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> > >  
> > >      acpi_table_begin(&table, table_data);  

This hunk might still make sense, though. When double-checking the links
against ACPI 6.5, I noticed that HEST now requires .rev = 2.

There are some future incompatibilities, but the current
implementation of acpi/ghes satisfies both rev 1 and ref 2 of HEST.

Also, this is not relevant on Linux, as the revision is not checked 
there.

So, currently this is not a problem.

Thanks,
Mauro

