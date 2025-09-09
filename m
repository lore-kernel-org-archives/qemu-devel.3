Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD008CAC583
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:09:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvzxW-00013S-Hu; Tue, 09 Sep 2025 11:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uvzxR-00012P-H9
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:08:34 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uvzxN-0001eH-3b
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:08:32 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cLnC53YBDz6FH48;
 Tue,  9 Sep 2025 23:03:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 106E6140279;
 Tue,  9 Sep 2025 23:07:53 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 9 Sep
 2025 17:07:52 +0200
Date: Tue, 9 Sep 2025 16:07:51 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>, <vishak.g@samsung.com>,
 <krish.reddy@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <cpgs@samsung.com>
Subject: Re: [PATCH v3 1/2] hw/cxl: Refactored Identify Switch Device & Get
 Physical Port State
Message-ID: <20250909160751.000025e3@huawei.com>
In-Reply-To: <20250908134856.2fexpkb2m4ztxwcn@test-PowerEdge-R740xd>
References: <20250904131904.725758-1-arpit1.kumar@samsung.com>
 <CGME20250904131933epcas5p2ab29fa060d8a7df32a222aad740fedc6@epcas5p2.samsung.com>
 <20250904131904.725758-2-arpit1.kumar@samsung.com>
 <20250905165953.00006c3c@huawei.com>
 <20250908134856.2fexpkb2m4ztxwcn@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 8 Sep 2025 19:18:56 +0530
Arpit Kumar <arpit1.kumar@samsung.com> wrote:

> On 05/09/25 04:59PM, Jonathan Cameron wrote:
> >On Thu,  4 Sep 2025 18:49:03 +0530
> >Arpit Kumar <arpit1.kumar@samsung.com> wrote:
> >  
> >> -Storing physical ports info during enumeration.
> >> -Refactored changes using physical ports info for
> >>  Identify Switch Device (Opcode 5100h) & Get Physical Port State
> >>  (Opcode 5101h) physical switch FM-API command set.
> >>
> >> Signed-off-by: Arpit Kumar <arpit1.kumar@samsung.com>  
> >Hi Arpit,
> >
> >A few minor things inline.   Biggest one is making sure
> >to namespace the defines which is quite challenging to do
> >here without a really long name.
> >
> >Jonathan
> >  
> Hi Jonathan,
> Thanks for the review! Will update the changes in next 
> iteration v4 of the patch-set.

> >> -        port->connected_device_cxl_version = 0x2;
> >> +        memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
> >> +               sizeof(CXLPhyPortInfo));
> >>      }
> >> -  
> >
> >That's a stray change that shouldn't be here.

I wasn't clear enough. I just meant that final line removal, not the rest
of the code! Sorry for confusion.

> >  
> Correct me if I am wrong but the current initializations for the ports are
> moved to cxl_set_port_type(), hence this might appear stray in this case due
> to eliminations but this is with respect to the response payload of
> cmd_get_physical_port_state() so seems apt.
> However, one change required would be to move: out->num_ports = in->num_ports; after
> the below for loop as it validates the port_id's:
>      for (i = 0; i < in->num_ports; i++) {
>          int pn = in->ports[i];
> 
>          if (pp->pports.pport_info[pn].port_id != pn) {
>              return CXL_MBOX_INVALID_INPUT;
>          }
>          memcpy(&out->ports[i], &(pp->pports.pport_info[pn]),
>                 sizeof(CXLPhyPortInfo));
>      }



