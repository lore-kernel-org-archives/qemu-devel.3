Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1974AF30955
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 12:33:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy7sJ-0004h4-MF; Thu, 05 Mar 2026 07:32:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vy7sH-0004gh-II
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:32:17 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vy7sE-0001yP-Sn
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 07:32:17 -0500
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4fRTRk6B4gzJ46mH;
 Thu,  5 Mar 2026 20:31:30 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
 by mail.maildlp.com (Postfix) with ESMTPS id 3701F4056A;
 Thu,  5 Mar 2026 20:32:07 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 12:32:06 +0000
Date: Thu, 5 Mar 2026 12:32:05 +0000
To: fanhuang <FangSheng.Huang@amd.com>
CC: <qemu-devel@nongnu.org>, <david@redhat.com>, <imammedo@redhat.com>,
 <gourry@gourry.net>, <apopple@nvidia.com>, <dan.j.williams@intel.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>
Subject: Re: [PATCH v6 0/1] numa: add 'memmap-type' option for memory type
 configuration
Message-ID: <20260305123205.00006ac0@huawei.com>
In-Reply-To: <20260226105023.256568-1-FangSheng.Huang@amd.com>
References: <20260226105023.256568-1-FangSheng.Huang@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 dubpeml500005.china.huawei.com (7.214.145.207)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

On Thu, 26 Feb 2026 18:50:22 +0800
fanhuang <FangSheng.Huang@amd.com> wrote:

> Hi all,
> 
> This is v6 of the SPM (Specific Purpose Memory) patch. Thank you for
> the feedback on v5, especially Gregory's review.
> 
> Changes in v6:
> - Added validation: memmap-type now requires memdev to be specified,
>   to avoid misconfiguration on memory-less NUMA nodes
> - Simplified pc_update_numa_memory_types() by replacing switch/goto
>   with a direct conditional expression
> - Reserved memory nodes are now excluded from SRAT memory affinity
>   entries, since E820 already marks them as reserved and SRAT should
>   not report them as enabled memory affinity
> 
> Use case:
> This feature allows marking NUMA node memory as Specific Purpose Memory
> (SPM) or reserved in the E820 table. SPM serves as a hint to the guest
> that this memory might be managed by device drivers based on guest policy
> 
> Example usage:
>   -object memory-backend-ram,size=8G,id=m0
>   -object memory-backend-memfd,size=8G,id=m1
>   -numa node,nodeid=0,memdev=m0
>   -numa node,nodeid=1,memdev=m1,memmap-type=spm
> 
> Supported memmap-type values:
>   - normal:   Regular system RAM (E820 type 1, default)
>   - spm:      Specific Purpose Memory (E820 type 0xEFFFFFFF), a hint
>               that this memory might be managed by device drivers
>   - reserved: Reserved memory (E820 type 2), not usable as RAM
Interface looks good to me.  I'm not familiar enough to confirm the
x86 specific elements without more time than I have today though so
no tags from me.

Thanks for doing this! 

Jonathan

