Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCC9F34C68
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 16:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCKXd-0006vI-Qq; Mon, 13 Apr 2026 12:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXc-0006v7-M4
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:40 -0400
Received: from p-west2-cluster2-host7-snip4-1.eps.apple.com ([57.103.68.244]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wCKXb-0005aI-0Q
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 12:53:40 -0400
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPS id
 B003718027C0; Mon, 13 Apr 2026 16:53:36 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776099217; x=1778691217;
 bh=zcmYD8sBYnUVL4imQw8BkyvhG03VGFAjf3wzcMF8rtM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=e3HwatzrwAfUkMVHb2lPLGe7Ghj+1S4lRDv7unfVpsm5uHDHvWTCdKvKy+eD66ZmluSKdKA5oEJA6uM3XVs0GLzkkQUlTuh21NzfjkfI6LBMdp+cM94osXz6Vdv/3o/wsFmHza0mtzOxVRk5aJ3dnDqLy6JxFrNtPWgdvY0uI/RUzYx2+inZb8uQ5Y3V5o4DWgo0MnTDD9Z1fC+FQswzGQ8D8K1hCCJU8KMHohfFbnnwGoOVipPQ0e3BgMirNZvt5q0IYvfPVMV76lReAu16b+bn2upjZKKyKEie9GidnvQiIgDIWawLG9eDkNc/m6dMOBsR2v5j6RCIr7UprzLzow==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-10-percent-1 (Postfix) with ESMTPSA id
 7426218003C1; Mon, 13 Apr 2026 16:53:31 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH v11 12/15] whpx: i386: disable enlightenments and LAPIC for
 isapc
Date: Mon, 13 Apr 2026 18:52:14 +0200
Message-ID: <20260413165217.47105-13-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260413165217.47105-1-mohamed@unpredictable.fr>
References: <20260413165217.47105-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=c4GmgB9l c=1 sm=1 tr=0 ts=69dd1f91
 cx=c_apl:c_pps:t_out a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=kaNVauZA35-AGszze7oA:9
X-Proofpoint-GUID: -IUWGaGSyUMWMfYMATEnkei19uuAPT4f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE2NiBTYWx0ZWRfX/JfzCHRh2Bnd
 2Wo114XrVYeSLEjUYzcbWVRCoORxci1ORAIILxa5pHX2/ZNPHgVxmoxKFcelkPlOR+BTaP5oTbf
 1+XCh4e8h1koXJl+ii+R8vNR5GUxcSZHdUknO95xHV5a1uztZa1A+b7WTFOlLbaTceDXOf9gNfk
 H9PYkl/k0tBHAf+Y69xwhy5oKigiY58b1SB1HwIsxajEZ3Uygqsag+FCKl5g8Z9QodCd/sEKe90
 QuRYoiOkRLr/+2NtdmydtWTNDQ96uDPo0mBznbd15aVIgqSSL3IxVJ2QmoAbv3Tx+Jdm0VGfKl2
 TnYs3L27pO1ET9BEgN1GeTVTofMABYvSuUGUrAJHHYf0CbY5z7jSwXSqYTvjhA=
X-Proofpoint-ORIG-GUID: -IUWGaGSyUMWMfYMATEnkei19uuAPT4f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1030
 malwarescore=0 lowpriorityscore=0 mlxlogscore=817 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604130166
Received-SPF: pass client-ip=57.103.68.244;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The isapc machine doesn't have an APIC. And Hyper-V enlightenments
don't sound too useful to have there so disable those.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 target/i386/whpx/whpx-all.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 61aec98e66..7a31dc6427 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -2470,6 +2470,14 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
         goto error;
     }
 
+    /* for isapc, disable Hyper-V enlightenments and LAPIC */
+    if (!strcmp(MACHINE_GET_CLASS(ms)->name, "isapc")) {
+        whpx->kernel_irqchip_allowed = false;
+        whpx->kernel_irqchip_required = false;
+        whpx->hyperv_enlightenments_allowed = false;
+        whpx->hyperv_enlightenments_required = false;
+    }
+
     whpx->mem_quota = ms->ram_size;
 
     hr = whp_dispatch.WHvGetCapability(
-- 
2.50.1 (Apple Git-155)


