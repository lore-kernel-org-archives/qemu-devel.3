Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97FD75E21
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 10:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tER62-0008C5-0p; Fri, 22 Nov 2024 05:41:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tER5w-0008Bh-Vv
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:41:01 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tER5u-0001ck-RE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 05:41:00 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 99B715C4D9B;
 Fri, 22 Nov 2024 10:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61BD1C4CECE;
 Fri, 22 Nov 2024 10:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1732272055;
 bh=lIcErWtDG7meN2uYFd1HD/oKJHuNqmctc/9BNxKL5cQ=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=j6ts14M+QIv0FkNQUbj66UZvBHV29ph/wHAUtDaqkCVxYmMl5uOPScwOp43O4NXEP
 9zTbsx9+rZQVS4oDHkNe50X3zpYP52eLun2b+1Rp/Uk0HqmHYKLcEdRPxEo7dQZeCq
 UcvOfrHRI4RsnAgANHTP2Xafr4J6TsaAGqRZvZ9J5P+P/UsUK2JXf/UuPhRqGq/GSB
 SmIBX3+YxCzLo9X93pr7LH/T/1W/SQjvW/+PlgWx9w0KqftT4N0EUVlcSwGdk6pQ25
 QJop9WM221HzxLQQ6UcJWVnIFNMzrDRSbLOPiz7sDLx9FsIyGqHFKPt6ihkZ1iZEq4
 MwsA0q3iX8bmw==
Date: Fri, 22 Nov 2024 11:40:50 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH 5/6] acpi/generic_event_device: Update GHES migration to
 cover hest addr
Message-ID: <20241122114050.51b60f1a@foz.lan>
In-Reply-To: <20241120150119.00007d3d@huawei.com>
References: <cover.1731486604.git.mchehab+huawei@kernel.org>
 <6391dfec0a26b83641c2b2062115b839490cc902.1731486604.git.mchehab+huawei@kernel.org>
 <20241120150119.00007d3d@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=mchehab+huawei@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
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

Em Wed, 20 Nov 2024 15:01:19 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Wed, 13 Nov 2024 09:37:02 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The GHES migration logic at GED should now support HEST table
> > location too.
> > 
> > Increase migration version and change needed to check for both
> > ghes_addr_le and hest_addr_le.  
> 
> Where is the migration version increased?  Maybe I'm misunderstanding
> the comment.

Legacy comment. We dropped migration version increase, as this is not
needed anymore.

Comment dropped.

> 
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/generic_event_device.c | 29 +++++++++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> > 
> > diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> > index 17baf36132a8..c1116dd8d7ae 100644
> > --- a/hw/acpi/generic_event_device.c
> > +++ b/hw/acpi/generic_event_device.c
> > @@ -387,6 +387,34 @@ static const VMStateDescription vmstate_ghes_state = {
> >      }
> >  };
> >  
> > +static const VMStateDescription vmstate_hest = {
> > +    .name = "acpi-hest",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_UINT64(hest_addr_le, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    },
> > +};
> > +
> > +static bool hest_needed(void *opaque)
> > +{
> > +    AcpiGedState *s = opaque;
> > +    return s->ghes_state.hest_addr_le;
> > +}
> > +
> > +static const VMStateDescription vmstate_hest_state = {
> > +    .name = "acpi-ged/hest",
> > +    .version_id = 1,
> > +    .minimum_version_id = 1,
> > +    .needed = hest_needed,
> > +    .fields = (const VMStateField[]) {
> > +        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
> > +                       vmstate_hest, AcpiGhesState),
> > +        VMSTATE_END_OF_LIST()
> > +    }
> > +};
> > +
> >  static const VMStateDescription vmstate_acpi_ged = {
> >      .name = "acpi-ged",
> >      .version_id = 1,
> > @@ -399,6 +427,7 @@ static const VMStateDescription vmstate_acpi_ged = {
> >          &vmstate_memhp_state,
> >          &vmstate_cpuhp_state,
> >          &vmstate_ghes_state,
> > +        &vmstate_hest_state,
> >          NULL
> >      }
> >  };  
> 



Thanks,
Mauro

