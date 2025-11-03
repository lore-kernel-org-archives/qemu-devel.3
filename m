Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC2ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 14:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFvxk-00062c-8R; Mon, 03 Nov 2025 09:55:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFvxf-0005yK-0V; Mon, 03 Nov 2025 09:55:11 -0500
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1vFvxb-0007IP-M2; Mon, 03 Nov 2025 09:55:10 -0500
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d0ZK954pbz6L4wK;
 Mon,  3 Nov 2025 22:51:09 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
 by mail.maildlp.com (Postfix) with ESMTPS id 9412114033F;
 Mon,  3 Nov 2025 22:54:56 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 3 Nov
 2025 14:54:55 +0000
Date: Mon, 3 Nov 2025 14:54:54 +0000
To: Shameer Kolothum <skolothumtho@nvidia.com>
CC: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>, <eric.auger@redhat.com>,
 <peter.maydell@linaro.org>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <ddutile@redhat.com>, <berrange@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: Re: [PATCH v5 24/32] tests/qtest/bios-tables-test: Update IORT
 blobs after revision upgrade
Message-ID: <20251103145454.00004bbd@huawei.com>
In-Reply-To: <20251031105005.24618-25-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
 <20251031105005.24618-25-skolothumtho@nvidia.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.203.177.15]
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml100005.china.huawei.com (7.214.146.113)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-to:  Jonathan Cameron <jonathan.cameron@huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 31 Oct 2025 10:49:57 +0000
Shameer Kolothum <skolothumtho@nvidia.com> wrote:

> Update the reference IORT blobs after revision upgrade for RMR node
> support. This affects the aarch64 'virt' IORT tests.
> 
> IORT diff is the same for all the tests:
> 
>  /*
>   * Intel ACPI Component Architecture
>   * AML/ASL+ Disassembler version 20230628 (64-bit version)
>   * Copyright (c) 2000 - 2023 Intel Corporation
>   *
> - * Disassembly of tests/data/acpi/aarch64/virt/IORT, Mon Oct 20 14:42:41 2025
> + * Disassembly of /tmp/aml-B4ZRE3, Mon Oct 20 14:42:41 2025
>   *
>   * ACPI Data Table [IORT]
>   *
>   * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
>   */
> 
>  [000h 0000 004h]                   Signature : "IORT"    [IO Remapping Table]
>  [004h 0004 004h]                Table Length : 00000080
> -[008h 0008 001h]                    Revision : 03
> -[009h 0009 001h]                    Checksum : B3
> +[008h 0008 001h]                    Revision : 05
> +[009h 0009 001h]                    Checksum : B1
>  [00Ah 0010 006h]                      Oem ID : "BOCHS "
>  [010h 0016 008h]                Oem Table ID : "BXPC    "
>  [018h 0024 004h]                Oem Revision : 00000001
>  [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
>  [020h 0032 004h]       Asl Compiler Revision : 00000001
>  ...
> 
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
FWIW given trivial change.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

