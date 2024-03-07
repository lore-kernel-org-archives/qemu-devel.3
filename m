Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3B0C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAH6-0003qT-NA; Thu, 07 Mar 2024 04:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riAH5-0003py-2Q; Thu, 07 Mar 2024 04:42:51 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1riAH3-0002XV-7S; Thu, 07 Mar 2024 04:42:50 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tr48z6fjbz6D8c3;
 Thu,  7 Mar 2024 17:42:43 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 86853140B2A;
 Thu,  7 Mar 2024 17:42:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 09:42:46 +0000
Date: Thu, 7 Mar 2024 09:42:45 +0000
To: Alistair Francis <alistair23@gmail.com>, <marcel.apfelbaum@gmail.com>,
 <its@irrelevant.dk>, <mst@redhat.com>
CC: <hchkuo@avery-design.com.tw>, <wilfred.mallawa@wdc.com>,
 <cbrowy@avery-design.com>, <kbusch@kernel.org>, <lukas@wunner.de>,
 <jiewen.yao@intel.com>, <qemu-devel@nongnu.org>, Alistair Francis
 <alistair.francis@wdc.com>, <qemu-block@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v5 0/3] Initial support for SPDM Responders
Message-ID: <20240307094245.00006490@Huawei.com>
In-Reply-To: <20240307005859.356555-1-alistair.francis@wdc.com>
References: <20240307005859.356555-1-alistair.francis@wdc.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu,  7 Mar 2024 10:58:56 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> The Security Protocol and Data Model (SPDM) Specification defines
> messages, data objects, and sequences for performing message exchanges
> over a variety of transport and physical media.
>  - https://www.dmtf.org/sites/default/files/standards/documents/DSP0274_1.3.0.pdf
> 
> SPDM currently supports PCIe DOE and MCTP transports, but it can be
> extended to support others in the future. This series adds
> support to QEMU to connect to an external SPDM instance.
> 
> SPDM support can be added to any QEMU device by exposing a
> TCP socket to a SPDM server. The server can then implement the SPDM
> decoding/encoding support, generally using libspdm [1].
> 
> This is similar to how the current TPM implementation works and means
> that the heavy lifting of setting up certificate chains, capabilities,
> measurements and complex crypto can be done outside QEMU by a well
> supported and tested library.
> 
> This series implements socket support and exposes SPDM for a NVMe device.

Thanks Alastair,

I'm really keen to seen this land soon as I have the CXL infrastructure
for this backed up behind it.  Also will be needed for PCI (IDE) and CXL link
encryption emulation and most if not all of the confidential computing stacks
with QEMU emulating the host system + peripherals.

I believe it's just waiting for a PCI Maintainer Ack at this point? Klaus said he
was happy to take it through NVME but wanted a PCI Ack first.

Michael / Marcel, if you have time to look at it that would be great.

Thanks,

Jonathan


> 
> 1: https://github.com/DMTF/libspdm
> 
> v5:
>  - Update MAINTAINERS
> v4:
>  - Rebase
> v3:
>  - Spelling fixes
>  - Support for SPDM-Utils
> v2:
>  - Add cover letter
>  - A few code fixes based on comments
>  - Document SPDM-Utils
>  - A few tweaks and clarifications to the documentation
> 
> Alistair Francis (1):
>   hw/pci: Add all Data Object Types defined in PCIe r6.0
> 
> Huai-Cheng Kuo (1):
>   backends: Initial support for SPDM socket support
> 
> Wilfred Mallawa (1):
>   hw/nvme: Add SPDM over DOE support
> 
>  MAINTAINERS                  |   6 +
>  docs/specs/index.rst         |   1 +
>  docs/specs/spdm.rst          | 122 ++++++++++++++++++++
>  include/hw/pci/pci_device.h  |   5 +
>  include/hw/pci/pcie_doe.h    |   5 +
>  include/sysemu/spdm-socket.h |  44 +++++++
>  backends/spdm-socket.c       | 216 +++++++++++++++++++++++++++++++++++
>  hw/nvme/ctrl.c               |  53 +++++++++
>  backends/Kconfig             |   4 +
>  backends/meson.build         |   2 +
>  10 files changed, 458 insertions(+)
>  create mode 100644 docs/specs/spdm.rst
>  create mode 100644 include/sysemu/spdm-socket.h
>  create mode 100644 backends/spdm-socket.c
> 


