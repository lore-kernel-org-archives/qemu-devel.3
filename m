Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95F4BD2F353
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 17:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfigA-0005mA-Q4; Tue, 13 Jan 2026 12:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfig2-0005Zn-BS
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:59:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vfifx-0005yU-RU
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 12:59:33 -0500
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4drH7P4wT9zJ467D;
 Wed, 14 Jan 2026 01:59:13 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 124CE40086;
 Wed, 14 Jan 2026 01:59:27 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 13 Jan
 2026 17:59:26 +0000
Date: Tue, 13 Jan 2026 17:59:25 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: Michael Tsirkin <mst@redhat.com>, <qemu-devel@nongnu.org>,
 <shiju.jose@huawei.com>, <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
 "Ravi Shankar" <venkataravis@micron.com>
Subject: Re: [PATCH qemu v2 5/5] hw/cxl/events: Updates for rev3.2 memory
 module event record
Message-ID: <20260113175925.00007966@huawei.com>
In-Reply-To: <87344bf29s.fsf@pond.sub.org>
References: <20260102151512.460766-1-Jonathan.Cameron@huawei.com>
 <20260102151512.460766-6-Jonathan.Cameron@huawei.com>
 <87344bf29s.fsf@pond.sub.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, 12 Jan 2026 13:23:27 +0100
Markus Armbruster <armbru@redhat.com> wrote:

> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > From: Shiju Jose <shiju.jose@huawei.com>
> >
> > CXL spec rev3.2 section 8.2.10.2.1.3 Table 8-50, memory module
> > event record has updated with following new fields.
> > 1. Validity Flags
> > 2. Component Identifier
> > 3. Device Event Sub-Type
> >
> > Add updates for the above spec changes in the CXL memory module
> > event reporting and QMP command to inject memory module event.
> >
> > Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  qapi/cxl.json               | 12 +++++++++++-
> >  include/hw/cxl/cxl_events.h |  7 +++++--
> >  hw/mem/cxl_type3.c          | 20 ++++++++++++++++++++
> >  hw/mem/cxl_type3_stubs.c    |  4 ++++
> >  4 files changed, 40 insertions(+), 3 deletions(-)
> >
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 3e4bad4ad0..752d46cda2 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -242,6 +242,14 @@
> >  # @corrected-persistent-error-count: Total number of correctable
> >  #     errors in persistent memory
> >  #
> > +# @component-id: Device specific component identifier for the event.
> > +#     May describe a field replaceable sub-component of the device.
> > +#
> > +# @is-comp-id-pldm: This flag specifies whether the device-specific
> > +#     component identifier format follows PLDM.
> > +#
> > +# @sub-type: Device event sub-type.
> > +#  
> 
> These three seem to be the same in CXLGeneralMediaEvent, CXLDRAMEvent,
> and CXLMemModuleEvent.  Should they live in their common base type
> CXLCommonEventBase?

We have documented that base as corresponding to the spec defined
Common event record header and these aren't part of that.  We could
invent a CXLMemCommonEventBase that contains the stuff that is shared
for memory types of errors but it would probably just confuse anyone
trying to correlate this stuff with the spec.

There are a lot more event records we don't yet support, or are not
directly injected because they are responses to some other action.
(e.g. dynamic capacity add produces an event but also changes a bunch
 of device state)

I'm not sure if we will add direct injection of any of those other
events in future. Some are errors such as MLD Port Event Records,
but reporting those inband makes no sense as normal PCIe error
reporting is used for that. They are to expose what happened to
an out of band monitoring interface (see examples in patch 2
discussion).

Thanks for all your other feedback. We'll resolve that for v3.

Jonathan

> 
> >  # Since: 8.1
> >  ##
> >  { 'struct': 'CXLMemModuleEvent',
> > @@ -251,7 +259,9 @@
> >              'life-used': 'uint8', 'temperature' : 'int16',
> >              'dirty-shutdown-count': 'uint32',
> >              'corrected-volatile-error-count': 'uint32',
> > -            'corrected-persistent-error-count': 'uint32'
> > +            'corrected-persistent-error-count': 'uint32',
> > +            '*component-id': 'str', '*is-comp-id-pldm':'bool',
> > +            'sub-type':'uint8'
> >              }}
> >  
> >  ##  
> 
> [...]
> 
> 
> 


