Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7516AC02196
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 13:46:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg2CQ-0004Rs-J8; Thu, 06 Feb 2025 08:45:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tg2CK-0004Ov-0n
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:45:41 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1tg2CH-00036L-Qk
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 08:45:39 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YpdbT54rZz6H8G3;
 Thu,  6 Feb 2025 21:43:17 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
 by mail.maildlp.com (Postfix) with ESMTPS id E691C140520;
 Thu,  6 Feb 2025 21:45:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 6 Feb
 2025 14:45:34 +0100
Date: Thu, 6 Feb 2025 13:45:33 +0000
To: Vinayak Holikatti <vinayak.kh@samsung.com>
CC: <qemu-devel@nongnu.org>, <krish.reddy@samsung.com>,
 <vishak.g@samsung.com>, <a.manzanares@samsung.com>,
 <alok.rathore@samsung.com>, <s5.kumari@samsung.com>,
 <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl/cxl-mailbox-utils: Add support for Media
 operations Sanitize and Write Zeros commands (8.2.9.9.5.3)
Message-ID: <20250206134533.00003e62@huawei.com>
In-Reply-To: <20250206092714.zdwd6lddw64d5j3b@test-PowerEdge-R740xd>
References: <20250123050903.92336-1-vinayak.kh@samsung.com>
 <CGME20250123050913epcas5p45fb9a638e62f436076da283e86e54ea2@epcas5p4.samsung.com>
 <20250123050903.92336-3-vinayak.kh@samsung.com>
 <20250124151946.0000134f@huawei.com>
 <20250206092714.zdwd6lddw64d5j3b@test-PowerEdge-R740xd>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.66]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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


> >> +static int sanitize_range(CXLType3Dev *ct3d, uint64_t dpa_addr, size_t length,
> >> +                          uint8_t fill_value)
> >> +{
> >> +
> >> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> >> +    uint64_t vmr_size = 0, pmr_size = 0;
> >> +    AddressSpace *as = NULL;
> >> +    MemTxAttrs mem_attrs = {0};
> >> +
> >> +    if (ct3d->hostvmem) {
> >> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> >> +        vmr_size = memory_region_size(vmr);
> >> +    }
> >> +    if (ct3d->hostpmem) {
> >> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> >> +        pmr_size = memory_region_size(pmr);
> >> +    }
> >> +
> >> +    if (dpa_addr < vmr_size) {
> >> +        as = &ct3d->hostvmem_as;
> >> +    } else if (dpa_addr < vmr_size + pmr_size) {
> >> +        as = &ct3d->hostpmem_as;
> >> +    } else {
> >> +        if (!ct3_test_region_block_backed(ct3d, dpa_addr, length)) {
> >> +            return -ENODEV;
> >> +        }
> >> +        as = &ct3d->dc.host_dc_as;
> >> +    }  
> >
> >You could factor out everything down to here and then use that
> >for the validate_dpa_addr() as finding an address space means
> >we also checked the address is valid. Otherwise it does not match.  
> 
> Didnt get what you meant, validate_dpa_addr is meant for 
> checking valid dpa address and sanitize_range is 
> get the address space handle to do actual sanitize
> of dpa address, so two are different purposes, 

Different purposes but the actual checks mostly
overlap.  If we can find the address space then there
are only a few extra checks on alignment with granual
size etc needed.  I'd just like to avoid that duplication
so factor out the shared code to a helper called in both
functions.


> 
> >  
> >> +
> >> +    return  address_space_set(as, dpa_addr,  



