Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE939CD1284
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 11:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rusi0-0002ie-FC; Thu, 11 Apr 2024 07:35:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chunfu.jian@shingroup.cn>)
 id 1rushy-0002fc-Ad
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:35:10 -0400
Received: from smtpbgau2.qq.com ([54.206.34.216])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chunfu.jian@shingroup.cn>)
 id 1rushi-0006Ww-IC
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 07:35:10 -0400
X-QQ-mid: bizesmtp77t1712835254t2pj01zg
X-QQ-Originating-IP: 35nfrdd5gv3Z0cbK7zSfoar6tdxjeF3/YedJb90i93M=
Received: from localhost.localdomain ( [112.0.147.129])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Thu, 11 Apr 2024 19:34:06 +0800 (CST)
X-QQ-SSF: 0140000000000090B000000A0000000
X-QQ-FEAT: tnN4C/PdIDX9ci0/KCVZhBUlZ9bFAfqm4BdGOrMsm3PkXaCbUDM8H7CfQtQtx
 Or6+H/OZFaZxJk+47z997UUmnCqnkPBVARrLSIobUGsByd1MBitSCej9FvRDmhL4CMOcJc1
 gSRYcc2TllNdTIjZ0lELJQbg5cBxvOBRmqxRfrvIwzzzXKYYSJWBMoWwNFg27+eFGNV0Hac
 tu89HZBLuxE5rZpRNAbv8uuYCBBF/f58Vr5v4yFiRrYeZiNSN5YY3UcLnfDplz3shHkNQ1Z
 4rsly5KL2Vbej7xNCcwTUCOzAGOOqt0413IM702D/3WCkkULrza5+OuGlrz7dmQsyezYLRB
 aS111khAhhZp+rBi1ctFdp95buqE99req2Bf+hxM3ItxhBKRVu1opDb15QcMxVFbUqgwG2q
 aulCov9LfsY=
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 11069852116706908286
From: JianChunfu <chunfu.jian@shingroup.cn>
To: mst@redhat.com,
	cohuck@redhat.com,
	pbonzini@redhat.com
Cc: qemu-devel@nongnu.org,
	JianChunfu <chunfu.jian@shingroup.cn>
Subject: [PATCH] linux-headers: change the annotation of
 VFIO_IOMMU_SPAPR_REGISTER_MEMORY in vfio.h
Date: Thu, 11 Apr 2024 19:34:04 +0800
Message-Id: <20240411113404.1274855-1-chunfu.jian@shingroup.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrsz:qybglogicsvrsz4a-1
Received-SPF: pass client-ip=54.206.34.216;
 envelope-from=chunfu.jian@shingroup.cn; helo=smtpbgau2.qq.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The ioctl(VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA) won't be called
in SPAPR machine, which is replaced by VFIO_IOMMU_SPAPR_TCE_CREATE/
VFIO_IOMMU_SPAPR_TCE_REMOVE, so change the description.

Signed-off-by: JianChunfu <chunfu.jian@shingroup.cn>
---
 linux-headers/linux/vfio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index b4be37b22..20e8e6ae8 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -1764,7 +1764,7 @@ struct vfio_eeh_pe_op {
  *
  * Registers user space memory where DMA is allowed. It pins
  * user pages and does the locked memory accounting so
- * subsequent VFIO_IOMMU_MAP_DMA/VFIO_IOMMU_UNMAP_DMA calls
+ * subsequent VFIO_IOMMU_SPAPR_TCE_CREATE/VFIO_IOMMU_SPAPR_TCE_REMOVE calls
  * get faster.
  */
 struct vfio_iommu_spapr_register_memory {
-- 
2.27.0


