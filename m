Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECBB9E95396
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 13:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vncjE-0007TV-69; Wed, 04 Feb 2026 08:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1vncj0-0007Sa-Nc
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:15:24 -0500
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1vncit-0000hH-Nn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 08:15:18 -0500
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwDX3ppLRoNphSTCBg--.1391S2;
 Wed, 04 Feb 2026 21:14:51 +0800 (CST)
Received: from [192.168.31.151] (unknown [222.244.181.122])
 by mail (Coremail) with SMTP id AQAAfwDXL+1JRoNpsQkZAA--.29212S2;
 Wed, 04 Feb 2026 21:14:49 +0800 (CST)
Message-ID: <e43203cf-58aa-4642-8a2f-94b7a4a212ec@phytium.com.cn>
Date: Wed, 4 Feb 2026 21:14:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 0/2] tests/qtest: Add Intel IOMMU bare-metal test
 using iommu-testdev
To: Fengyuan Yu <15fengyuan@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-devel@nongnu.org
References: <cover.1770172615.git.15fengyuan@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <cover.1770172615.git.15fengyuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAfwDXL+1JRoNpsQkZAA--.29212S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAQBWmCVm4FwgAAsA
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxZFyfAr17CFykGw15XFy7Wrg_yoWrZw1kpF
 y8CFyakay3Jr1xGr1xJr18tryUtrs7J3W7ZryUG3Z5Jry5AryIvr4IgrW0g34qqrW0qF1a
 qw4UtFnruw15ArUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
 DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
 UUUUU
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2026/2/4 11:06, Fengyuan Yu wrote:
> Hi,
>
> This patch series adds a bare-metal qtest for the Intel IOMMU (VT-d) using
> the iommu-testdev framework. The test exercises address translation paths
> without requiring a full guest OS boot.
>
> Motivation
> ----------
>
> The Intel IOMMU implementation in QEMU supports various translation modes
> including pass-through and translated (4-level paging) modes. Currently,
> comprehensive testing of these translation paths requires booting a full
> guest OS with appropriate drivers, which is time-consuming and makes
> regression testing difficult.
>
> This new test fills that gap by using iommu-testdev to trigger DMA
> transactions and validate the IOMMU's translation logic directly.
>
> Test Coverage
> -------------
>
> The new test provides:
> - Legacy pass-through mode (identity mapping)
> - Legacy translated mode with 4-level page table walks
> - Root Entry Table and Context Entry Table configuration
> - Complete 48-bit address space translation
> - End-to-end DMA verification with memory validation
>
> Testing
> -------
>
> QTEST_QEMU_BINARY=./build/qemu-system-x86_64 \
>    ./build/tests/qtest/iommu-intel-test --tap -k
>
> Thanks,
> Fengyuan


Thanks for working on VT-d qtests. As a first-time patch contributor, 
you’ve already done a great job with good cover letter and commit 
messages to accurately summarize your work.


It seems that your code cannot be applied to the latest master branch. 
And I also noticed multiple lines >80 columns (some > 90). QEMU style 
says try to keep lines to 80 columns, only going a bit over when 
wrapping would harm readability but never > 90 columns.

../tests/qtest/libqos/qos-intel-iommu.c: In function 
‘qvtd_build_root_entry’:
../tests/qtest/libqos/qos-intel-iommu.c:168:31: error: 
‘VTD_CONTEXT_ENTRY_SLPTPTR’ undeclared (first use in this function); did 
you mean ‘VTD_CONTEXT_ENTRY_SSPTPTR’?
   168 |     lo = (context_table_ptr & VTD_CONTEXT_ENTRY_SLPTPTR) | 
VTD_CONTEXT_ENTRY_P;
       |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
       |                               VTD_CONTEXT_ENTRY_SSPTPTR
../tests/qtest/libqos/qos-intel-iommu.c:168:31: note: each undeclared 
identifier is reported only once for each function it appears in
../tests/qtest/libqos/qos-intel-iommu.c: In function 
‘qvtd_build_context_entry’:
../tests/qtest/libqos/qos-intel-iommu.c:190:25: error: 
‘VTD_CONTEXT_ENTRY_SLPTPTR’ undeclared (first use in this function); did 
you mean ‘VTD_CONTEXT_ENTRY_SSPTPTR’?
   190 |              (slptptr & VTD_CONTEXT_ENTRY_SLPTPTR);
       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
       |                         VTD_CONTEXT_ENTRY_SSPTPTR
../tests/qtest/libqos/qos-intel-iommu.c: In function 
‘qvtd_setup_translation_tables’:
../tests/qtest/libqos/qos-intel-iommu.c:239:36: error: ‘VTD_SL_R’ 
undeclared (first use in this function); did you mean ‘VTD_SS_R’?
   239 |     pml4_entry = QVTD_PT_L3_BASE | VTD_SL_R | VTD_SL_W;
       |                                    ^~~~~~~~
       |                                    VTD_SS_R
../tests/qtest/libqos/qos-intel-iommu.c:239:47: error: ‘VTD_SL_W’ 
undeclared (first use in this function); did you mean ‘VTD_SS_W’?
   239 |     pml4_entry = QVTD_PT_L3_BASE | VTD_SL_R | VTD_SL_W;
       |                                               ^~~~~~~~
       |                                               VTD_SS_W
[92/2328] Compiling C object libblock.a.p/block.c.o



Besides when submitting patches it’s a good idea to read 
`docs/devel/submitting-a-patch.rst`. It may be a bit long, but making 
sure the code builds cleanly and running scripts/checkpatch.pl for style 
checks beforehand can help avoid many basic issues.


Finally I think CC the experts on x86 and VT-d emulation might be a more 
efficient way to review this sereis patch.

M: Paolo Bonzini <pbonzini@redhat.com>
R: Zhao Liu <zhao1.liu@intel.com>

M: Michael S. Tsirkin <mst@redhat.com>
R: Jason Wang <jasowang@redhat.com>
R: Yi Liu <yi.l.liu@intel.com>
R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>


Anyway I'm looking forward to your v2 patches.

Best regards,

Tao


