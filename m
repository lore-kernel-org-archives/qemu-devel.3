Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C583CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 11:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWY7b-0001Yb-UO; Mon, 08 Jun 2026 07:26:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wWY7X-0001Y7-LB; Mon, 08 Jun 2026 07:26:19 -0400
Received: from mxct.zte.com.cn ([183.62.165.209])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wang.yechao255@zte.com.cn>)
 id 1wWY7V-0000X7-CF; Mon, 08 Jun 2026 07:26:19 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mxct.zte.com.cn (FangMail) with ESMTPS id 4gYqVR2pKCz52SGb;
 Mon, 08 Jun 2026 19:26:07 +0800 (CST)
Received: from szxlzmapp03.zte.com.cn ([10.5.231.207])
 by mse-fl2.zte.com.cn with SMTP id 658BQ2vv011942;
 Mon, 8 Jun 2026 19:26:02 +0800 (+08)
 (envelope-from wang.yechao255@zte.com.cn)
Received: from mapi (szxlzmapp03[null]) by mapi (Zmail) with MAPI id mid12;
 Mon, 8 Jun 2026 19:26:05 +0800 (CST)
X-Zmail-TransId: 2b056a26a6cd7dc-a32c5
X-Mailer: Zmail v1.0
Message-ID: <2026060819260552486Ytu4mDZvlgP1rhRHd8j@zte.com.cn>
In-Reply-To: <20260608143458400rOXqFmoA6o1tmlztJH2gE@zte.com.cn>
References: 20260608143458400rOXqFmoA6o1tmlztJH2gE@zte.com.cn
Date: Mon, 8 Jun 2026 19:26:05 +0800 (CST)
Mime-Version: 1.0
From: <wang.yechao255@zte.com.cn>
To: <wang.yechao255@zte.com.cn>
Cc: <palmer@dabbelt.com>, <alistair.francis@wdc.com>, <liwei1518@gmail.com>,
 <daniel.barboza@oss.qualcomm.com>, <zhiwei_liu@linux.alibaba.com>,
 <chao.liu.zevorn@gmail.com>, <qemu-riscv@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gaHcvcmlzY3YvdmlydDogQWRkICJpb21tdS1tYXAiIHByb3BlcnR5IGZvciBwY2llIGJ1cw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 658BQ2vv011942
X-TLS: YES
X-ENVELOPE-SENDER: wang.yechao255@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 08 Jun 2026 19:26:07 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6A26A6CF.000/4gYqVR2pKCz52SGb
Received-SPF: pass client-ip=183.62.165.209;
 envelope-from=wang.yechao255@zte.com.cn; helo=mxct.zte.com.cn
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

> On DT system, add the "iommu-map" property for pcie bus, so the kernel
> can build the dependency between iommu and devices, to avoid the
> incorrect removal order.

Ignore this patch, cause this patch is incorrect. The "iommu-map" property is
already defined in create_fdt_iommu. 

The device is not removed before the IOMMU device because the BDF of the
device I configured is smaller than the BDF of the IOMMU device.

Thanks,
Yechao

