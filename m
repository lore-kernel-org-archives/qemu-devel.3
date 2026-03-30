Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D67FB3CE2
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:09:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78cy-0004w8-9i; Mon, 30 Mar 2026 05:09:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w78cv-0004oo-Dn
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:09:41 -0400
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net ([162.243.164.118])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1w78cr-000088-R3
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:09:41 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDXj2fDPcppGOw3AA--.22250S2;
 Mon, 30 Mar 2026 17:09:23 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwwJO+PcppYm0HAA--.17633S2;
 Mon, 30 Mar 2026 17:09:18 +0800 (CST)
Message-ID: <7440519b-bc64-49f7-aa35-32b607817739@phytium.com.cn>
Date: Mon, 30 Mar 2026 17:09:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/qtest/libqos: Add Intel IOMMU helper library
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>
References: <cover.1774421649.git.15fengyuan@gmail.com>
 <c4f7bf5d7985891a2db291193669ebe15dd2ba15.1774421649.git.15fengyuan@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <c4f7bf5d7985891a2db291193669ebe15dd2ba15.1774421649.git.15fengyuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwwJO+PcppYm0HAA--.17633S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWnJfH8DswAAsd
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoW7JFWxZF15XFWUKw43uFW8tFb_yoW8JrW8pa
 y8Gryrtayvyr12kr1kWw40qFyrKay8Ka17Zw4UGwnxAwn3KrW0yr1Uta4qgayrur4rXF15
 Xa1qyr47XayktrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=162.243.164.118;
 envelope-from=tangtao1634@phytium.com.cn;
 helo=zg8tmtyylji0my4xnjqumte4.icoremail.net
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Fengyuan,

On 2026/3/25 15:09, Fengyuan Yu wrote:
> Introduce a libqos helper module for Intel IOMMU (VT-d) bare-metal
> testing via iommu-testdev. The helper provides routines to:
>
> - Build Legacy-mode structures: Root Entry Tables, Context Entry Tables,
>    and 4-level page tables for 48-bit address translation
> - Build Scalable-mode structures: Scalable Context Entries, PASID
>    Directory Entries, PASID Table Entries, and 4-level page tables for
>    both second-level and first-level translation
> - Program VT-d registers (Root Table Address, Invalidation Queue,
>    Fault Event MSI, Global Command) following the VT-d specification,
>    with GSTS read-back verification for each step
> - Execute DMA translations through iommu-testdev and verify results
>    by reading back guest memory
>
> The module supports all major VT-d translation modes through the
> QVTDTransMode enum:
> - Legacy pass-through
> - Legacy translated with 4-level paging
> - Scalable pass-through
> - Scalable Second-Level Translation
> - Scalable First-Level Translation
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


