Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA76CC71133
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 15:57:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPNow-0000wR-R4; Wed, 11 Jun 2025 11:56:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNov-0000wF-Fj; Wed, 11 Jun 2025 11:56:57 -0400
Received: from [185.176.79.56] (helo=frasgout.his.huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alireza.sanaee@huawei.com>)
 id 1uPNot-0008On-Lf; Wed, 11 Jun 2025 11:56:57 -0400
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bHVXx5ZTbz6L5ZF;
 Wed, 11 Jun 2025 23:52:33 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 8585B140370;
 Wed, 11 Jun 2025 23:56:52 +0800 (CST)
Received: from a2303103017.china.huawei.com (10.203.177.99) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Jun 2025 17:56:51 +0200
To: <qemu-devel@nongnu.org>, <mst@redhat.com>
CC: <anisinha@redhat.com>, <armbru@redhat.com>, <berrange@redhat.com>,
 <dapeng1.mi@linux.intel.com>, <eric.auger@redhat.com>,
 <farman@linux.ibm.com>, <gustavo.romero@linaro.org>, <imammedo@redhat.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <linuxarm@huawei.com>, <maobibo@loongson.cn>, <mtosatti@redhat.com>,
 <peter.maydell@linaro.org>, <philmd@linaro.org>, <qemu-arm@nongnu.org>,
 <richard.henderson@linaro.org>, <shameerali.kolothum.thodi@huawei.com>,
 <shannon.zhaosl@gmail.com>, <yangyicong@hisilicon.com>, <zhao1.liu@intel.com>
Subject: [PATCH v13 1/7] target/arm/tcg: increase cache level for cpu=max
Date: Wed, 11 Jun 2025 16:56:12 +0100
Message-ID: <20250611155618.351-2-alireza.sanaee@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250611155618.351-1-alireza.sanaee@huawei.com>
References: <20250611155618.351-1-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.203.177.99]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500003.china.huawei.com (7.182.85.28)
X-Host-Lookup-Failed: Reverse DNS lookup failed for 185.176.79.56 (deferred)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=alireza.sanaee@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-to:  Alireza Sanaee <alireza.sanaee@huawei.com>
From:  Alireza Sanaee via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This patch addresses cache description in the `aarch64_max_tcg_initfn`
function for cpu=max. It introduces three layers of caches and modifies
the cache description registers accordingly.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
---
 target/arm/tcg/cpu64.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 5d8ed2794d..87e68b10c3 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -1086,6 +1086,19 @@ void aarch64_max_tcg_initfn(Object *obj)
     uint64_t t;
     uint32_t u;
 
+    /*
+     * Expanded cache set
+     */
+    cpu->clidr = 0x8200123; /* 4 4 3 in 3 bit fields */
+    /* 64KB L1 dcache */
+    cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 7);
+    /* 64KB L1 icache */
+    cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 64 * KiB, 2);
+    /* 1MB L2 unified cache */
+    cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 1 * MiB, 7);
+    /* 2MB L3 unified cache */
+    cpu->ccsidr[4] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 8, 64, 2 * MiB, 7);
+
     /*
      * Unset ARM_FEATURE_BACKCOMPAT_CNTFRQ, which we would otherwise default
      * to because we started with aarch64_a57_initfn(). A 'max' CPU might
-- 
2.43.0


