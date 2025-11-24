Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C86CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 02:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNLyZ-0002lB-ST; Sun, 23 Nov 2025 21:06:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vNLyT-0002jx-0g; Sun, 23 Nov 2025 21:06:41 -0500
Received: from out28-81.mail.aliyun.com ([115.124.28.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu@zevorn.cn>)
 id 1vNLyQ-0006sl-TB; Sun, 23 Nov 2025 21:06:40 -0500
Received: from 10.13.14.160(mailfrom:chao.liu@zevorn.cn
 fp:SMTPD_---.fUBa4bQ_1763949991 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 24 Nov 2025 10:06:33 +0800
Message-ID: <4968fb08-3475-444d-85dd-740de1800f12@zevorn.cn>
Date: Mon, 24 Nov 2025 10:06:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: dbarboza@ventanamicro.com
Cc: alistair.francis@wdc.com, liwei1518@gmail.com, palmer@dabbelt.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com,
 wangjingwei@iscas.ac.cn
References: <20251111182944.2895892-6-dbarboza@ventanamicro.com>
Subject: Re: [PATCH v4 5/5] docs: add rvsp-ref.rst
From: Chao Liu <chao.liu@zevorn.cn>
In-Reply-To: <20251111182944.2895892-6-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=115.124.28.81; envelope-from=chao.liu@zevorn.cn;
 helo=out28-81.mail.aliyun.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 11 Nov 2025 15:29:44 -0300, Daniel Henrique Barboza wrote:
>Add documentation on the new experimental board rvsp-ref.
>
>Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
>---
> docs/system/riscv/rvsp-ref.rst | 28 ++++++++++++++++++++++++++++
> docs/system/target-riscv.rst   |  1 +
> 2 files changed, 29 insertions(+)
> create mode 100644 docs/system/riscv/rvsp-ref.rst
>
>diff --git a/docs/system/riscv/rvsp-ref.rst b/docs/system/riscv/rvsp-ref.rst
>new file mode 100644
>index 0000000000..3889fce413
>--- /dev/null
>+++ b/docs/system/riscv/rvsp-ref.rst
>@@ -0,0 +1,28 @@
>+Experimental RISC-V Server Platform Reference board (``rvsp-ref``)
>+==================================================================
>+
>+The RISC-V Server Platform specification `spec`_ defines a standardized
>+set of hardware and software capabilities that portable system software,
>+such as OS and hypervisors, can rely on being present in a RISC-V server
>+platform. This machine aims to emulate this specification, providing
>+an environment for firmware/OS development and testing.
>+
>+The main features included in rvsp-ref are:
>+
>+*  a new CPU type rvsp-ref CPU for server platform compliance
There is an extra space before the character "a", which can be removed.

Thanks,
Chao
>+* AIA
>+* PCIe AHCI
>+* PCIe NIC
>+* No virtio mmio bus
>+* No fw_cfg device
>+* No ACPI table
>+* Minimal device tree nodes

