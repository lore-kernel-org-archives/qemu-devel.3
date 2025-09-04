Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC71CA1002
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 08:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uu5av-0003lT-Ay; Thu, 04 Sep 2025 04:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uu5at-0003ko-8f
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:45:23 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uu5ap-0004PY-9d
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 04:45:23 -0400
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cHY1J54Xxz6GDP4;
 Thu,  4 Sep 2025 16:44:04 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 19F0E1402EF;
 Thu,  4 Sep 2025 16:45:00 +0800 (CST)
Received: from localhost (10.203.177.99) by frapeml500003.china.huawei.com
 (7.182.85.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 4 Sep
 2025 10:44:59 +0200
Date: Thu, 4 Sep 2025 09:44:55 +0100
To: Ira Weiny <ira.weiny@intel.com>
CC: <nifan.cxl@gmail.com>, <qemu-devel@nongnu.org>,
 <jonathan.cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
 <gregory.price@memverge.com>, <dan.j.williams@intel.com>,
 <a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>, 
 <jim.harris@samsung.com>, <Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>,
 <armbru@redhat.com>, <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>, Svetly
 Todorov <svetly.todorov@memverge.com>
Subject: Re: [PATCH v8 11/14] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <20250904094455.0000194b.alireza.sanaee@huawei.com>
In-Reply-To: <68b71467b850a_4bae529418@iweiny-mobl.notmuch>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
 <20240523174651.1089554-12-nifan.cxl@gmail.com>
 <20250902113915.00001fbd.alireza.sanaee@huawei.com>
 <68b71467b850a_4bae529418@iweiny-mobl.notmuch>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 2 Sep 2025 10:59:35 -0500
Ira Weiny <ira.weiny@intel.com> wrote:

> Alireza Sanaee wrote:
> > On Thu, 23 May 2024 10:44:51 -0700
> > nifan.cxl@gmail.com wrote:
> >   
> > > From: Fan Ni <fan.ni@samsung.com>
> > > 
> > > To simulate FM functionalities for initiating Dynamic Capacity Add
> > > (Opcode 5604h) and Dynamic Capacity Release (Opcode 5605h) as in
> > > CXL spec r3.1 7.6.7.6.5 and 7.6.7.6.6, we implemented two QMP
> > > interfaces to issue add/release dynamic capacity extents requests.
> > > 
> > > With the change, we allow to release an extent only when its DPA
> > > range is contained by a single accepted extent in the device.
> > > That is to say, extent superset release is not supported yet.
> > > 
> > > 1. Add dynamic capacity extents:
> > > 
> > > For example, the command to add two continuous extents (each
> > > 128MiB long) to region 0 (starting at DPA offset 0) looks like
> > > below:
> > > 
> > > { "execute": "qmp_capabilities" }
> > > 
> > > { "execute": "cxl-add-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "selection-policy": "prescriptive",
> > >       "region": 0,
> > >       "extents": [
> > >       {
> > >           "offset": 0,
> > >           "len": 134217728
> > >       },
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > 2. Release dynamic capacity extents:
> > > 
> > > For example, the command to release an extent of size 128MiB from
> > > region 0 (DPA offset 128MiB) looks like below:
> > > 
> > > { "execute": "cxl-release-dynamic-capacity",
> > >   "arguments": {
> > >       "path": "/machine/peripheral/cxl-dcd0",
> > >       "host-id": 0,
> > >       "removal-policy":"prescriptive",
> > >       "region": 0,
> > >       "extents": [
> > >       {
> > >           "offset": 134217728,
> > >           "len": 134217728
> > >       }
> > >       ]
> > >   }
> > > }
> > > 
> > > Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
> > > Reviewed-by: Gregory Price <gregory.price@memverge.com>
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>  
> 
> [snip]
> 
> > > +##
> > > +# @cxl-release-dynamic-capacity:
> > > +#
> > > +# Command to initiate to release dynamic capacity extents from a
> > > +# host.  It simulates operations defined in cxl spec r3.1
> > > 7.6.7.6.6. +#
> > > +# @path: CXL DCD canonical QOM path.
> > > +#
> > > +# @host-id: The "Host ID" field as defined in cxl spec r3.1
> > > +#     Table 7-71.
> > > +#
> > > +# @removal-policy: Bit[3:0] of the "Flags" field as defined in
> > > cxl +#     spec r3.1 Table 7-71.
> > > +#
> > > +# @forced-removal: Bit[4] of the "Flags" field in cxl spec r3.1
> > > +#     Table 7-71.  When set, device does not wait for a Release
> > > +#     Dynamic Capacity command from the host.  Host immediately
> > > +#     loses access to released capacity.
> > > +#
> > > +# @sanitize-on-release: Bit[5] of the "Flags" field in cxl spec
> > > r3.1 +#     Table 7-71.  When set, device should sanitize all
> > > released +#     capacity as a result of this request.
> > > +#
> > > +# @region: The "Region Number" field as defined in cxl spec r3.1
> > > +#     Table 7-71.  The dynamic capacity region where the capacity
> > > +#     is being added.  Valid range is from 0-7.
> > > +#
> > > +# @tag: The "Tag" field as defined in cxl spec r3.1 Table 7-71.
> > > +#
> > > +# @extents: The "Extent List" field as defined in cxl spec r3.1
> > > +#     Table 7-71.
> > > +#
> > > +# Since : 9.1
> > > +##
> > > +{ 'command': 'cxl-release-dynamic-capacity',
> > > +  'data': { 'path': 'str',
> > > +            'host-id': 'uint16',
> > > +            'removal-policy': 'CXLExtRemovalPolicy',
> > > +            '*forced-removal': 'bool',
> > > +            '*sanitize-on-release': 'bool',
> > > +            'region': 'uint8',
> > > +            '*tag': 'str',
> > > +            'extents': [ 'CXLDynamicCapacityExtent' ]
> > > +           }
> > > +}  
> > 
> > Although tag-based removal is not implemented yet, but still just
> > wanted to leave a comment here that exact extents are not needed
> > for tag-based removal and `extents` should be an optional parameter
> > here; this is my understanding reading the spec, so I still might
> > be wrong, shout if you think it does not make sense.  
> 
> It's been a while but I think this allows the removal of non-tagged
> extents as well(?)  If so the tag would be NULL (or empty-string) and
> one can remove a regular extent.
> 
> But I could be miss-remembering something,
> Ira
> 

Yes non-tagged is working completely.


