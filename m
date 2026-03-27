Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AACD10F2840
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:18:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w68xP-0003PD-7U; Fri, 27 Mar 2026 11:18:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w68xK-0003Ov-0W
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:18:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1w68xH-00055W-9X
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 11:18:37 -0400
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fj45p1HzJzJ46Bp;
 Fri, 27 Mar 2026 23:18:06 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 30FA640577;
 Fri, 27 Mar 2026 23:18:18 +0800 (CST)
Received: from localhost (10.203.177.99) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 27 Mar
 2026 15:18:17 +0000
Date: Fri, 27 Mar 2026 15:18:11 +0000
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, <anisa.su@samsung.com>, <berrange@redhat.com>,
 <eblake@redhat.com>, <jonathan.cameron@huawei.com>,
 <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>, <lizhijian@fujitsu.com>,
 <mst@redhat.com>, <pbonzini@redhat.com>, <gourry@gourry.net>,
 <nifan.cxl@gmail.com>, <me@linux.beauty>
Subject: Re: [PATCH 9/9] hw/cxl: Add QMP status query for dynamic-capacity
 extent release
Message-ID: <20260327151811.00005564.alireza.sanaee@huawei.com>
In-Reply-To: <87mrzuei5f.fsf@pond.sub.org>
References: <20260325184259.366-1-alireza.sanaee@huawei.com>
 <20260325184259.366-10-alireza.sanaee@huawei.com>
 <87mrzuei5f.fsf@pond.sub.org>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 26 Mar 2026 16:15:40 +0100
Markus Armbruster <armbru@redhat.com> wrote:

Hi Markus,

This commit adds a test command to check whether an extent (a piece of memory region) has been released or not by the guest.
The process of removal is highly asynchronous, that's why I needed to add a new command to check it.

I would be happy to drop this patch, as this is extra.

Thanks,
Ali

> I'm a near-complete CXL ignoramus, and beg your patience.
> 
> Alireza Sanaee <alireza.sanaee@huawei.com> writes:
> 
> > Add a small status query so orchestration layers can check whether a tagged
> > extent is still pending, committed, or no longer present after a release
> > request.  
> 
> Why would they want to check?
> 
> What is a "release request"?
> 
> >
> > Introduce the ExtentStatus QAPI struct and the
> > cxl-release-dynamic-capacity-status command.
> >
> > Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>  
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > index 81d6198ba0..53325ba530 100644
> > --- a/qapi/cxl.json
> > +++ b/qapi/cxl.json
> > @@ -636,3 +636,49 @@
> >             },
> >    'features': [ 'unstable' ]
> >  }
> > +
> > +##
> > +# @ExtentStatus:  
> 
> Blank line here, please.
> 
> > +# This is an object that describes the status of an extent.
> > +#
> > +# @status:   String indicating the overall result, e.g. "success".  
> 
> What are the possible values?  Are they defined in some spec?
> 
> > +# @message:  Human-readable description of the outcome.  
> 
> Intended use?
> 
> > +#
> > +# Since: 9.1  
> 
> 11.1 most likely.
> 
> > +##
> > +{ 'struct': 'ExtentStatus',
> > +      'data': { 'status': 'str', 'message': 'str' }
> > +}
> > +
> > +##
> > +# @cxl-release-dynamic-capacity-status:
> > +#
> > +# This commands checks if an extent tag has been released or not.  
> 
> Use imperative mood to describe commands: "Check whether an extent tag
> has been released."
> 
> > +#
> > +# @path: path to the CXL Dynamic Capacity Device in the QOM tree.  
> 
> We commonly call such members @qom-path.
> 
> > +#
> > +# @host-id: The "Host ID" field as defined in Compute Express Link
> > +#     (CXL) Specification, Revision 3.1, Table 7-71.
> > +#
> > +# @region: The "Region Number" field as defined in Compute Express
> > +#     Link Specification, Revision 3.1, Table 7-71.  Valid range
> > +#     is from 0-7.
> > +#
> > +# @tag: The "Tag" field as defined in Compute Express Link (CXL)
> > +#     Specification, Revision 3.1, Table 7-71.  
> 
> I guess the command interrogates something called "extent", and the
> something is related to the CXL device at @path in the QOM tree.
> Correct?
> 
> How is it related?  Is it a part of the device?
> 
> I further guess multiple extends can be so related, and @host-id,
> @region, and @tag identify select the one we want to interrogate.
> Correct?
> 
> > +#
> > +# Features:
> > +#
> > +# @unstable: For now this command is subject to change.  
> 
> The conventional language is "This command is experimental."
> 
> > +#
> > +# Since: 9.1  
> 
> 11.1 most likely.
> 
> > +##
> > +{ 'command': 'cxl-release-dynamic-capacity-status',
> > +  'data': { 'path': 'str',
> > +            'host-id': 'uint16',
> > +            'region': 'uint8',
> > +            'tag': 'str'
> > +          },
> > +  'features': [ 'unstable' ],
> > +  'returns': 'ExtentStatus'  
> 
> Swap these two lines, please.
> 
> > +}  
> 
> 


