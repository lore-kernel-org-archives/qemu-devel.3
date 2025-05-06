Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41712C3ABBE
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:11:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLpG-0001w9-1O; Tue, 06 May 2025 13:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uCLpB-0001u5-99
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:11:22 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uCLp8-0006Tf-PE
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:11:20 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZsPb80pLYz6K998;
 Wed,  7 May 2025 00:52:52 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 4DAD11400D3;
 Wed,  7 May 2025 00:53:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 6 May
 2025 18:53:02 +0200
Date: Tue, 6 May 2025 17:53:01 +0100
To: Fan Ni <nifan.cxl@gmail.com>
CC: <anisa.su887@gmail.com>, <qemu-devel@nongnu.org>, <dave@stgolabs.net>,
 <linux-cxl@vger.kernel.org>, Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH 3/9] cxl/type3: Add dsmas_flags to CXLDCRegion struct
Message-ID: <20250506175301.00005f1b@huawei.com>
In-Reply-To: <aBTrcAa9yt8lGHJO@debian>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-4-anisa.su887@gmail.com>
 <20250424114259.000000a0@huawei.com>
 <aBPV80J9TULzRslk@fanair.local>
 <20250502100155.00003bfa@huawei.com> <aBTrcAa9yt8lGHJO@debian>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 2 May 2025 08:57:36 -0700
Fan Ni <nifan.cxl@gmail.com> wrote:

> On Fri, May 02, 2025 at 10:01:55AM +0100, Jonathan Cameron wrote:
> > On Thu, 1 May 2025 20:21:56 +0000
> > Fan Ni <nifan.cxl@gmail.com> wrote:
> >   
> > > On Thu, Apr 24, 2025 at 11:42:59AM +0100, Jonathan Cameron wrote:  
> > > > On Mon, 17 Mar 2025 16:31:30 +0000
> > > > anisa.su887@gmail.com wrote:
> > > >     
> > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > 
> > > > > Add dsmas_flags field to DC Region struct in preparation for next
> > > > > command, which returns the dsmas flags in the response.
> > > > > 
> > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > ---
> > > > >  hw/mem/cxl_type3.c          | 2 ++
> > > > >  include/hw/cxl/cxl_device.h | 1 +
> > > > >  2 files changed, 3 insertions(+)
> > > > > 
> > > > > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > > > > index 731497ebda..452a0c101a 100644
> > > > > --- a/hw/mem/cxl_type3.c
> > > > > +++ b/hw/mem/cxl_type3.c
> > > > > @@ -237,6 +237,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
> > > > >                                            ct3d->dc.regions[i].len,
> > > > >                                            false, true, region_base);
> > > > >              ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> > > > > +            CDATDsmas *dsmas = (CDATDsmas *) table[cur_ent + CT3_CDAT_DSMAS];
> > > > > +            ct3d->dc.regions[i].dsmas_flags = dsmas->flags;    
> > > >     
> > > Hi Jonathan,
> > > Thanks for the feedback.  
> > > > This is relying to much on the ordering of creating fields in
> > > > ct3_build_cdat_entries_for_mr().    
> > > I am not sure whether I understand this clearly.
> > > In current qemu implemtation, each mr (ram,pmem or dc region) will have the
> > > whole set of cdat table entries (dsmas, dslbis0-3, etc), so as long as we point
> > > to the right table entry, we can get the table correctly.
> > > What do you mean "the ordering of creating fields"?  
> > 
> > It is an implementation detail only that the first bit of that table is
> > the DSMAS entry.  I think we shouldn't rely on that.
> >   
> > > > 
> > > > I'd rather you just stored the information flags is built from in CXLDCRegion
> > > > and then built the field that is wonderfully called 'Note' in the DC region    
> > I got distracted by the spec oddity :)
> >   
> > > This sentence is kind of broken for me, not totally clear what you are
> > > suggesting :-(. Can you explain more?
> > > Are you suggesting not directly take dsmas->flags as dsmas_flags, but
> > > use bit op to generate the value used in Table 7-66 in cxl spec 3.2?  
> > 
> > No. Just store the various  bools etc that become dsmas->flags in the
> > CXLDCRegion structure directly rather than reading back from dsmas->flags.
> > Probably as explicit bools etc not a single value.
> > 
> > Then pass those in to  ct3_build_cdat_entries_for_mr() .  Mostly they overlap
> > with current true / false parameters that are hard coded.  
> 
> OK. Since some flags are not support yet, can we hard coded them for now?

Sure. Add some breadcrumbs / comments for later though if that makes sense.

> 
> Fan
> > 
> >   
> > > > configuration in 6.2 spec.   I've sent a mail to see if we can clean that    
> > > 6.2 spec???  
> > > > 'what is the field called' question for future spec releases.
> > > > 
> > > > Whilst the flag definitions cross refer the CDAT spec, the actual locations
> > > > of those flags matches, but doesn't cross refer so maybe in the future
> > > > we will have other flags in here and locations might not match.    
> > > For the flags stored in dsmas table, do we expect there can be more than those
> > > defined in Table 7-66 in spec 3.2?  
> > 
> > Not for now. Though I'm sure something will come along at some point.
> > The comment is about there being particular reason the flag locations should match
> > between CDAT and what we report via the commands being added here.  The definitions
> > of individual bits cross refer between specs, the register as a whole does not.
> > 
> > Jonathan
> >   
> > > 
> > > Fan
> > >   
> > > >     
> > > > >  
> > > > >              cur_ent += CT3_CDAT_NUM_ENTRIES;
> > > > >              region_base += ct3d->dc.regions[i].len;
> > > > > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > > > > index bebed04085..81b826f570 100644
> > > > > --- a/include/hw/cxl/cxl_device.h
> > > > > +++ b/include/hw/cxl/cxl_device.h
> > > > > @@ -609,6 +609,7 @@ typedef struct CXLDCRegion {
> > > > >      uint8_t flags;
> > > > >      unsigned long *blk_bitmap;
> > > > >      uint64_t supported_blk_size_bitmask;
> > > > > +    uint8_t dsmas_flags;
> > > > >  } CXLDCRegion;
> > > > >  
> > > > >  typedef struct CXLSetFeatureInfo {    
> > > >     
> >   


