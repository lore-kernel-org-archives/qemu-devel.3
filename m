Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6068C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 18:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4jR8-0002it-K7; Thu, 10 Sep 2026 14:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jR7-0002fN-47
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:23:49 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shrihari.s@samsung.com>)
 id 1x4jR3-0000M1-TS
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 14:23:48 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260910181803epoutp02876b7bb5f14ee44ea5c3da71f9e78a95~UCHyWbVQr1353113531epoutp02b
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 18:18:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260910181803epoutp02876b7bb5f14ee44ea5c3da71f9e78a95~UCHyWbVQr1353113531epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1789064283;
 bh=ifj7NBYy8ZOjRfnFiyFaFprv/HS2+jVyx6f/KhJhVHY=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XqY2xRtx/mqPtzkdzdt5gxQnoHW6MlyIot1r6m7aaO5Ue7zwii+7Kqy8jDa8riiCV
 fq7h86r6gw0eDm8ngmfGNAwqykm1DYkJTpg6+8GDseCiMXMIaf/FENERcUwz5epSPv
 CA9WTtx8k+BNa6/QGqQVHlM0ePYC3uk0MDlZNI7Q=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20260910181802epcas5p3f74f3f8ed0aec165b291ad07b0d56c0e~UCHx9I7yq2701127011epcas5p3o;
 Thu, 10 Sep 2026 18:18:02 +0000 (GMT)
Received: from epcpadp2new (unknown [182.195.40.142]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4hgmBL4hXTz6B9m5; Thu, 10 Sep
 2026 18:18:02 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
 20260910084057epcas5p3035baa4d94172108ad8e044c123c491c~T6P7JOwUX0789307893epcas5p3c;
 Thu, 10 Sep 2026 08:40:57 +0000 (GMT)
Received: from test-PowerEdge-R740xd (unknown [107.99.41.79]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260910084055epsmtip181d83adf80fc9c8bb901adb7991c9824~T6P5Jkhtm2315923159epsmtip1k;
 Thu, 10 Sep 2026 08:40:55 +0000 (GMT)
Date: Thu, 10 Sep 2026 14:10:52 +0530
From: Shrihari E S <shrihari.s@samsung.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: jic23@kernel.org, mst@redhat.com, marcel.apfelbaum@gmail.com,
 dave@stgolabs.net, arun.george@samsung.com, dongjoo.seo1@samsung.com,
 s.neeraj@samsung.com, vikash.k5@samsung.com, cpgs@samsung.com,
 gost.dev@samsung.com, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
 qemu-devel@nongnu.org, shrihari.s@samsung.com
Subject: Re: [RFC V2 06/10] hw/pci: Add PCIe Streamlined Virtual Channel
 (SVC) capability.
Message-ID: <973576304.21789064282642.JavaMail.epsvc@epcpadp2new>
MIME-Version: 1.0
In-Reply-To: <20260830072144.399508-1-junjie.cao@intel.com>
X-CMS-MailID: 20260910084057epcas5p3035baa4d94172108ad8e044c123c491c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
 boundary="----SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_"
CMS-TYPE: 105P
X-CPGSPASS: Y
X-Hop-Count: 3
X-CMS-RootMailID: 20260910084057epcas5p3035baa4d94172108ad8e044c123c491c
References: <1212772528.01787732282387.JavaMail.epsvc@epcpadp2new>
 <20260830072144.399508-1-junjie.cao@intel.com>
 <CGME20260910084057epcas5p3035baa4d94172108ad8e044c123c491c@epcas5p3.samsung.com>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=shrihari.s@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On 30/08/26 03:21PM, Junjie Cao wrote:
>On the register defines: v1 ended with routing these through
>pci_regs.h plus a note on when the kernel header picks them up; they
>went into QEMU's pcie_regs.h instead.  Still the plan for a later
>spin, or intentional?
>
>Many thanks,
>Junjie

Hi Junjie,

The register definitions are intentionally placed in QEMU's
include/hw/pci/pci_regs.h for now. Once The corresponding macros are
merged into Linux Kernel's include/uapi/linux/pci_regs.h, will sync
them through include/standard headers/linux/pci_regs.h in a follow-up
patch.

Thanks and regards,
Shrihari

------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_
Content-Type: text/plain; charset="utf-8"


------SSW395WYaxe49lwLPbcWHEEKUIW3_c_Q3XTd.OaaloguMMey=_1c4db_--


