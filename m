Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557FD60703DC
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 17:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rsg.ci.i.u-tokyo.ac.jp header.i=@rsg.ci.i.u-tokyo.ac.jp header.a=rsa-sha256 header.s=rs20250326 header.b=I4Ml9MCt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvGQ-00016J-DV; Fri, 13 Nov 2026 12:40:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xRvGF-000143-6X
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:40:29 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xRvGC-0006c8-KX
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 12:40:26 -0500
Received: from [172.31.11.120] (m85.aaa.bbb.ccc.bctel.net [209.52.143.85] (may
 be forged)) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6ADHe9OP067280
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 14 Nov 2026 02:40:10 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=jCsllBbRPFjJGrztePYKq6/YfBKasZZTGDgK8hr3Azo=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1794591611; v=1;
 b=I4Ml9MCtVV+52QIBL2SR1k/ZUmdR4CbPEkVeSKOsuUx83nCFOBYgiI3d3VkduXcl
 hbATLcCrkOZmxRNqb9E49meWUhnjSfNz235A7+LlGYM2Yrz4xoUOZPvFRDOCG7wL
 ped9iwK/rAy7xXd0tjo8eTyPq0KrtynBAGBrAk9gxu7NAf0H2uob7gytvtyEo/jM
 qG8ye+wpXDSd4EuiaWGCofI/YQWj58kO6+UWCAWD+/oavoiGvgMgUzrCWGz8CchP
 TRD+hNy84o6cZfa4o/2FW3ZTjhLcPLAM4d2OF7WVxqI4+GcYB0iHnFU9FzfnoUQk
 e6NDj5jDSsq8Iv/nfWMYHw==
Message-ID: <377309c9-65ef-4a80-8938-1781287110f0@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 13 Nov 2026 10:40:08 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] docs/specs/pci-ids: Reserve IDs for Cnuas vfio-user
 devices
To: Weqaar Janjua <weqaar.janjua@packetfive.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261113113939.3687534-1-weqaar.janjua@packetfive.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20261113113939.3687534-1-weqaar.janjua@packetfive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026/11/13 6:39, Weqaar Janjua wrote:
> Reserve 1b36:0017 for the Cnuas virtual RDMA network adapter and
> 1b36:0018 for the CnuasGPU virtual accelerator. Both are PCIe devices
> implemented outside QEMU as vfio-user servers and attached with
> "-device vfio-user-pci". Their register interfaces are documented at
> the links in the table.
> 
> Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>

Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> ---
> v4:
> - Dropped the CnuasNIC and CnuasGPU device models and their qtests
>    (v3 patches 2, 3, 5 and 6). As Akihiko suggested, the devices move
>    out of tree as vfio-user servers in the Cnuas project.
> - Merged the two ID patches (v3 patches 1 and 4) into this one
>    documentation patch and dropped the include/hw/pci/pci.h defines,
>    since no QEMU code uses them now.
> - Linked the device specifications instead of in-tree docs.
> 
> v3: https://lore.kernel.org/qemu-devel/20260929202358.725310-1-weqaar.janjua@packetfive.com/
> 
>   docs/specs/pci-ids.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
> index 74460bb19e..26137b11bf 100644
> --- a/docs/specs/pci-ids.rst
> +++ b/docs/specs/pci-ids.rst
> @@ -109,6 +109,12 @@ PCI devices (other than virtio):
>     PCIe Upstream Switch Port (``-device pcie-upstream-port``)
>   1b36:0016
>     PCIe Downstream Switch Port (``-device pcie-downstream-port``)
> +1b36:0017
> +  Cnuas virtual RDMA network adapter (vfio-user device, out of tree),
> +  https://cnuas.io/cnuas/docs/datasheets/CnuasNIC_Datasheet/
> +1b36:0018
> +  CnuasGPU virtual accelerator (vfio-user device, out of tree),
> +  https://cnuas.io/cnuas/docs/datasheets/CnuasGPU_Datasheet/
>   
>   All these devices are documented in :doc:`index`.
>   


