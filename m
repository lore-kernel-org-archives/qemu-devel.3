Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D33C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 10:53:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1visIm-00009y-Rz; Thu, 22 Jan 2026 05:52:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1visIk-00006M-81
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:52:34 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1visIh-0004LB-0y
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 05:52:34 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dxdCx2k7gzHnH8N;
 Thu, 22 Jan 2026 18:51:41 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id E367440569;
 Thu, 22 Jan 2026 18:52:16 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 22 Jan
 2026 10:52:16 +0000
Date: Thu, 22 Jan 2026 10:52:14 +0000
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC: Michael S Tsirkin <mst@redhat.com>, Shiju Jose <shiju.jose@huawei.com>,
 <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, Cleber Rosa
 <crosa@redhat.com>, John Snow <jsnow@redhat.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 02/13] scripts/qmp_helper: add missing CXL UEFI GUID
Message-ID: <20260122105214.00001cca@huawei.com>
In-Reply-To: <aXDx_N3YRACBmC4I@foz.lan>
References: <cover.1768993993.git.mchehab+huawei@kernel.org>
 <f229d756fe76c34e6dfa48a98f1ee46f4325fc76.1768993993.git.mchehab+huawei@kernel.org>
 <20260121122604.00001609@huawei.com> <aXDx_N3YRACBmC4I@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 16:45:58 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> On Wed, Jan 21, 2026 at 12:26:04PM +0000, Jonathan Cameron wrote:
> > On Wed, 21 Jan 2026 12:25:10 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > The UEFI 2.11 - N.2.14. CXL Component Events Section states that
> > > XL events are described at CXL specification 3.2:  
> > CXL
> >   
> > >         8.2.10.2.1 Event Records
> > > 
> > > Add the GUIDs defined here to fuzzy logic error injection code.  
> > 
> > +CC linux-cxl as more folk there who will be familiar with this
> > stuff.
> > 
> > Some of these won't be seen on a host. The same event
> > infrastructure is used for reporting on out of band interfaces
> > and some in band ones, but not ones that will turn up on the
> > mailboxes that firmware will be using to get info.  
> 
> Good to know, but UEFI 2.11 still mentions all of them as
> possible GUIDs:
> 
>     https://uefi.org/specs/UEFI/2.11/Apx_N_Common_Platform_Error_Record.html#cxl-component-events-section
> 
> So, the UEFI 2.11 doesn't explicitly state they won't de delivered
> to OSPM. Quite contrary, they're listed as valid values for CPER,
> even if, in practice, they won't.
> 
> This is just a small set of variables, that won't bring any major
> impact on the code. So, I prefer to keep them in sync with the spec.
> If they end removing the unused ones, we can update it in the future.
> 
> If you want, I can add a note at the next version with your
> comments about them.
> 
A note works for me.

As I understand it CPER records are getting adopted in other specs
so it may make sense to document them, even if they  aren't a possibility
via ACPI.

However I'm not seeing them in the spec link you point at.  
All I'm seeing is a cross reference the CXL spec Events Record Format.

> >   
> > > 
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  scripts/qmp_helper.py | 25 +++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/scripts/qmp_helper.py b/scripts/qmp_helper.py
> > > index 249a8c7187d1..7e786c4adfd9 100755
> > > --- a/scripts/qmp_helper.py
> > > +++ b/scripts/qmp_helper.py
> > > @@ -711,3 +711,28 @@ class cper_guid:
> > >      CPER_CXL_PROT_ERR = guid(0x80B9EFB4, 0x52B5, 0x4DE3,
> > >                               [0xA7, 0x77, 0x68, 0x78,
> > >                                0x4B, 0x77, 0x10, 0x48])
> > > +
> > > +    CPER_CXL_EVT_GEN_MEDIA = guid(0xFBCD0A77, 0xC260, 0x417F,
> > > +                                  [0x85, 0xA9, 0x08, 0x8B,
> > > +                                   0x16, 0x21, 0xEB, 0xA6])
> > > +    CPER_CXL_EVT_DRAM = guid(0x601DCBB3, 0x9C06, 0x4EAB,
> > > +                             [0xB8, 0xAF, 0x4E, 0x9B,
> > > +                              0xFB, 0x5C, 0x96, 0x24])
> > > +    CPER_CXL_EVT_MEM_MODULE = guid(0xFE927475, 0xDD59, 0x4339,
> > > +                                   [0xA5, 0x86, 0x79, 0xBA,
> > > +                                    0xB1, 0x13, 0xBC, 0x74])
> > > +    CPER_CXL_EVT_MEM_SPARING = guid(0xE71F3A40, 0x2D29, 0x4092,
> > > +                                    [0x8A, 0x39, 0x4D, 0x1C,
> > > +                                     0x96, 0x6C, 0x7C, 0x65])  
> > 
> > The above are all fine I think.
> > 
> > From here on I think they will never come via a CPER record.
> >   
> > > +    CPER_CXL_EVT_PHY_SW = guid(0x77CF9271, 0x9C02, 0x470B,
> > > +                               [0x9F, 0xE4, 0xBC, 0x7B,
> > > +                                0x75, 0xF2, 0xDA, 0x97])  
> > 
> > This is only going to surface over either out of band or switch CCI
> > I'd be very surprised to see a firmware anywhere near these.
> > More specifically they are only defined in the Fabric management
> > section of the spec, which strongly hints we'd not expect host firmware
> > to know anything about them. 
> > The events reported may well span bits of the topology currently
> > assigned to different hosts.
> >   
> > > +    CPER_CXL_EVT_VIRT_SW = guid(0x40D26425, 0x3396, 0x4C4D,
> > > +                                [0xA5, 0xDA, 0x3D, 0x47,
> > > +                                  0x2A, 0x63, 0xAF, 0x25])  
> > 
> > Also a fabric management event.
> >   
> > > +    CPER_CXL_EVT_MLD_PORT = guid(0x8DC44363, 0x0C96, 0x4710,
> > > +                                 [0xB7, 0xBF, 0x04, 0xBB,
> > > +                                  0x99, 0x53, 0x4C, 0x3F])  
> > 
> > Also a fabric management event.
> >   
> > > +    CPER_CXL_EVT_DYNA_CAP = guid(0xCA95AFA7, 0xF183, 0x4018,
> > > +                                 [0x8C, 0x2F, 0x95, 0x26,
> > > +                                  0x8E, 0x10, 0x1A, 0x2A])  
> > These are never routed to firmware. They are part of the OS only
> > managed flows for dynamic capacity.
> > They have their own event log on the hardware and for this particular
> > set most relevant thing is in
> > CXL 4.0 Table 8-235 Set Event Interrupt Policy Input Payload
> > which controls whether a firmware interrupt or MSIX is used signal
> > the Dynamic Capacity Event Log Interrupt Settings only allows
> > for MSI/MSI-X, not FW interrupt (EFN VDM) like the other logs.
> > 
> > 
> > Jonathan
> > 
> >   
> 


