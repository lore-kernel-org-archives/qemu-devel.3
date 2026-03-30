Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24774FB3CE4
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 09:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w78es-0008Qp-Fn; Mon, 30 Mar 2026 05:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tangtao1634@phytium.com.cn>)
 id 1w78eq-0008MD-0m
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:11:40 -0400
Received: from sgoci-sdnproxy-4.icoremail.net ([129.150.39.64])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tangtao1634@phytium.com.cn>) id 1w78en-0000UB-RL
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 05:11:39 -0400
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
 by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwDnn2dEPspp1u83AA--.22301S2;
 Mon, 30 Mar 2026 17:11:32 +0800 (CST)
Received: from [10.31.91.158] (unknown [218.76.62.144])
 by mail (Coremail) with SMTP id AQAAf8DwsJJCPsppcm0HAA--.15710S2;
 Mon, 30 Mar 2026 17:11:31 +0800 (CST)
Message-ID: <a4cf8666-ac3e-4821-9b8d-251d66848e30@phytium.com.cn>
Date: Mon, 30 Mar 2026 17:11:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] tests/qtest: Add Intel IOMMU bare-metal test
To: Fengyuan Yu <15fengyuan@gmail.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>
References: <cover.1774421649.git.15fengyuan@gmail.com>
 <ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com>
From: Tao Tang <tangtao1634@phytium.com.cn>
In-Reply-To: <ce3c44f3b07734a4f0ee43f55b21c856034af1b1.1774421649.git.15fengyuan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf8DwsJJCPsppcm0HAA--.15710S2
X-CM-SenderInfo: pwdqw3tdrrljuu6sx5pwlxzhxfrphubq/1tbiAQAKBWnJfH8DuwAAsV
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=tangtao163
 4@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7JFW7Kr4kKF4xXrW3XF4fXwb_yoWfCrg_ur
 1rCrykZw4DXr4fJw45KFsxXrW0kr4vgw4Igr1Ikry5Aas7KrsrJrn7XFnYvrZavrZxGFya
 krn8Ca15Crs7XjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
 Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
 UUUU=
Received-SPF: pass client-ip=129.150.39.64;
 envelope-from=tangtao1634@phytium.com.cn; helo=sgoci-sdnproxy-4.icoremail.net
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9,
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
> Add a qtest suite for the Intel IOMMU (VT-d) device on the Q35 machine.
> The test exercises both Legacy and Scalable translation modes using
> iommu-testdev and the qos-intel-iommu helpers, without requiring any
> guest kernel or firmware.
>
> The test validates:
> - Legacy-mode Root Entry Table and Context Entry Table configuration
> - Scalable-mode Context Entry, PASID Directory, and PASID Table setup
> - Legacy-mode 4-level page table walks for 48-bit address translation
> - Scalable-mode second-level and first-level 4-level page table walks
> - Pass-through mode in both Legacy and Scalable modes
> - DMA transaction execution with memory content verification
>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Fengyuan Yu <15fengyuan@gmail.com>

Reviewed-by: Tao Tang <tangtao1634@phytium.com.cn>


