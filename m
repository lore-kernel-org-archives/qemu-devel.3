Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99461C7115A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Jun 2025 11:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRr16-0005hM-UX; Wed, 18 Jun 2025 07:31:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uRr0r-0005Mi-CS
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:31:37 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1uRr0m-00037g-1H
 for qemu-devel@nongnu.org; Wed, 18 Jun 2025 07:31:28 -0400
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bMhMg2FbPz6K9F4;
 Wed, 18 Jun 2025 19:29:03 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id 41A0C140371;
 Wed, 18 Jun 2025 19:31:16 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 18 Jun
 2025 13:31:15 +0200
Date: Wed, 18 Jun 2025 12:31:14 +0100
To: Arpit Kumar <arpit1.kumar@samsung.com>
CC: <qemu-devel@nongnu.org>, <gost.dev@samsung.com>,
 <linux-cxl@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
 <vishak.g@samsung.com>, <krish.reddy@samsung.com>,
 <a.manzanares@samsung.com>, <alok.rathore@samsung.com>
Subject: Re: [PATCH 1/3] hw/cxl: Storing physical ports info during enumeration
Message-ID: <20250618123114.00002b98@huawei.com>
In-Reply-To: <20250617094625.i2j7ewin7fy2b2nj@test-PowerEdge-R740xd>
References: <20250602135942.2773823-1-arpit1.kumar@samsung.com>
 <CGME20250602140018epcas5p2de38473dfcc0369193dd826c6e0e3fac@epcas5p2.samsung.com>
 <20250602135942.2773823-2-arpit1.kumar@samsung.com>
 <20250610152121.00004dda@huawei.com>
 <20250617094625.i2j7ewin7fy2b2nj@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


> >> +#define LINK_STATE_FLAG_PERST_ASSERTED   (1 << 1)
> >> +#define LINK_STATE_FLAG_PRSNT            (1 << 2)
> >> +#define LINK_STATE_FLAG_POWER_OFF        (1 << 3)
> >> +
> >> +/* physical port control info - CXL r3.2 table 7-19 */
> >> +typedef enum {
> >> +    PORT_DISABLED = 0,
> >> +    BIND_IN_PROGRESS = 1,
> >> +    UNBIND_IN_PROGRESS = 2,
> >> +    DSP = 3,
> >> +    USP = 4,
> >> +    FABRIC_PORT = 5,
> >> +    INVALID_PORT_ID = 15
> >> +} current_port_config_state;  
> >
> >These aren't used as types really but more as defines.
> >Hence I'd be tempted to make them defines. Also provide
> >defines for the masks.
> >
> >Namespace the defines so it is obvious which field
> >they are in.
> >  
> Will the below changes be the right way to proceed?
> #define CXL_PORT_CONFIG_STATE_DISABLED           0x0
> #define CXL_PORT_CONFIG_STATE_BIND_IN_PROGRESS   0x1 etc.

Yes


...

> >For similar things we do have firmware update in there which
> >is a mixture of device side stuff and CCI specific handling.
> >That might ideally be split up.  Obviously not something for
> >this patch, but maybe we can avoid making CCI more bloated?
> >
> >To me it seems reasonable to store this in the port and set
> >it up whether or not the cci is connected.
> >  
> got it, will try the implementation accordingly. It will be helpful if could share some
> reference on handling the same.

+    /*physical ports information */
+    struct phy_port pports;
+

Move this stuff to the CXLUpstreamPort.
Query the data to fill it in will need to be late enough that
everything is there to query. cxl_usp_reset() might work similar to how
we fill in link registers etc there. 

Then when you handle any of the CCI calls, use CXL_USP(cci->d) to
get to that USP structure.  Check that you have the right type if necessary
first though. 

Jonathan




> >> +
> >>      /* background command handling (times in ms) */
> >>      struct {
> >>          uint16_t opcode;  
> >  
> 


