Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12AEEB28F8
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 09:28:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voI7c-00082P-SJ; Fri, 06 Feb 2026 04:27:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1voI7a-00082G-V5
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:27:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1voI7Y-0004Oz-73
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 04:27:26 -0500
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f6pdN4XkQzHnHGx;
 Fri,  6 Feb 2026 17:27:04 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id C223140570;
 Fri,  6 Feb 2026 17:27:08 +0800 (CST)
Received: from localhost (10.47.70.160) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 6 Feb
 2026 09:27:07 +0000
Date: Fri, 6 Feb 2026 09:27:00 +0000
To: Gregory Price <gourry@gourry.net>
CC: <qemu-devel@nongnu.org>, <linuxarm@huawei.com>,
 <jonathan.cameron@huawei.com>, <nifan.cxl@gmail.com>,
 <anisa.su887@gmail.com>, <mst@redhat.com>, <armbru@redhat.com>,
 <lizhijian@fujitsu.com>, <ppbonzini@redhat.com>, <peterx@redhat.com>,
 <philmd@linaro.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <xiaoguangrong.eric@gmail.com>, <venkataravis@micron.com>
Subject: Re: [PATCH v2 0/2] Performant CXL type 3 non-interleaved regions
Message-ID: <20260206092700.0000028f.alireza.sanaee@huawei.com>
In-Reply-To: <aYTcR4mfYbCiewTI@gourry-fedora-PF4VCD3F>
References: <20260204150002.669-1-alireza.sanaee@huawei.com>
 <aYTcR4mfYbCiewTI@gourry-fedora-PF4VCD3F>
Organization: Huawei
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.70.160]
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

On Thu, 5 Feb 2026 13:07:03 -0500
Gregory Price <gourry@gourry.net> wrote:

> On Wed, Feb 04, 2026 at 02:59:59PM +0000, Alireza Sanaee via qemu development wrote:
> > The CXL address to device decoding logic is complex because of the need
> > to correctly decode fine grained interleave. The current implementation
> > prevents use with KVM where executed instructions may reside in that
> > memory and gives very slow performance even in TCG.
> >   
> 
> what was the base-commit of this set? I'm having trouble trying to get
> it applied.
> 
> ~Gregory

Hi Gregory,

It is on top of bunch of patches Jonathan's sending to be picked up. Not sure which one is picked up but here is my tree here including Jonathan's patches.

https://github.com/sarsanaee/qemu-lab/commits/performant-v2-E/

Thanks,
Ali

