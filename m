Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B139CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 18:47:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Sxm-0001dP-M8; Thu, 16 Oct 2025 14:44:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxk-0001d1-Tl
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:32 -0400
Received: from p-east3-cluster6-host1-snip4-5.eps.apple.com ([57.103.85.136]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9Sxa-00025j-3E
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 14:44:32 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPS id
 CC6CC18003BC; Thu, 16 Oct 2025 18:44:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6QHLe7sI/ta/TpnlofGbhZSXfY72nxkqv2tu61id1Xw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=PxhxC3Z8IAuI5QSeEt4QEpSzpUpz8TLaWfAbsnFxMwfk8Jg0xR1TGsw7WrCnQdJMvYRUSXd1aq7eQrLfdagXb9bPw4JA4YQmNQdrcW1hhlkIguhSSakQC5PJEEx+O+k/X91owBVK6IAVTnW8J/225U5iY/hJR1hjlpaVTNpNbZcw9eYZzb/fbb+Xple11u/RmCEBWWhElg/1cMd/HGFP6D+auamky8a5AFgklRQkZeww91RnUzUvXrADenx1njr8MLA77dDTM95Ys6D2s+wlJjAvaM3hmBwJ/2EozdZjJ3gXXQZq4/SLwA0tBm9FU5VtfF8RlHmI72sWTIX0h20/OA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-9 (Postfix) with ESMTPSA id
 1EE8A18004E3; Thu, 16 Oct 2025 18:44:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Cameron Esfahani <dirty@apple.com>, Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, Mads Ynddal <mads@ynddal.dk>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v8 16/24] docs: arm: update virt machine model description
Date: Thu, 16 Oct 2025 20:44:05 +0200
Message-ID: <20251016184413.69870-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016184413.69870-1-mohamed@unpredictable.fr>
References: <20251016184413.69870-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _cjDYhu_9pi6ADUSlvX5u2xKcWUNV2fE
X-Proofpoint-GUID: _cjDYhu_9pi6ADUSlvX5u2xKcWUNV2fE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEzNyBTYWx0ZWRfX4kmr28EVszsW
 +KU6TD6X7BSCO3JxAOOZey+4egaibpcdowyencSbZKVDDMVvqkF5po5Rcw+TECinHRD3rl+/Ywv
 S54W9s1rGKAcM3YLaVMsgULNpgHP5iV6pXKzgb1IkiKGi0U2pHe8vOq99jXsMf2XsK744255UKl
 AXeM7LFS0uMvj6O+yxR8CLSPAZC3ZPKFo/dBWhqM9oNmg/ltZBXgYfSHMPNSSz7HhJ9LJCzoM+9
 YeiEXsb0de6/nfx0PyKhJEWDqAYKxYvwU2XZVkSF8ffYR6/h4Sl0JZ6eBZsiXxfXi2iOojflI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=984 mlxscore=0 suspectscore=0
 clxscore=1030 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160137
X-JNJ: AAAAAAABz3as9KHlgXv1iBH7JzggIZxi4BmA5L4obTortuPxQBaoC1C2FjuM1CEXp8sV7h68zudSPt9YS/klgzM5hGEEQnytBPtdU9OfrIVOzmOsyX7YKqBdK0hWTXcnkrpNPQ1hKN4S+3k5wxjWdbFrnmoEe5Qd4bcTe078e5W99elOQRHzPAwQebdrCiZXd7EVxs1n2IMTwE3IIub//C1LqJPBbW2oT7LQkMHLUsd74luZjjvSgibI3+u+uOEhGTGTLTDDuOhtaGtH9F8xOEB5KBVGbumhw4APmuO4/C0P+zq85K+UZ97S66KJULSzOGxXg8GA00mlucJhCDCpNNqmdQOccVik4Grq8ANvnCq4miIXd5mDnUKYrV7yQD8d2DaZJvHEz6bmleFLQEFb6xQ0OFKuIKvE4JfNjFTnSMQLyMDDdFCcRJ6NLguk97rsURy7xWf6e4iVhScrcRnkRMmVsXkiSMbre11hhnc7TBEvPO0wPoP+oSo+hhSkwealzSSgT+v1ZutdMbsXlmpRpO85dQsiY5kwgThuMnX/JvwSpMl/mXSkaHgbDqGhYnHjNDENFhySoupUJAp9ZMmk3HzNJo0sNKnmQ/zr4F33hQYYG+vns8loHm4gp0+RnqX4FdCnQ4rttZxgC5sBphKbCMLGNNuHRomAl0q7Jn0ivTYWYwGzuObm8qPYPWj6O+4qOnJoTIWl
Received-SPF: pass client-ip=57.103.85.136;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Update the documentation to match current QEMU.

Remove the mention of pre-2.7 machine models as those aren't provided
anymore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 docs/system/arm/virt.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 10cbffc8a7..fe95be991e 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -40,9 +40,10 @@ The virt board supports:
 - An optional SMMUv3 IOMMU
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
-- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
-  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
-  that ITS is not modeled in TCG mode.
+- An MSI controller (GICv2m or ITS).
+  - When using a GICv3, ITS is selected by default when available on the platform.
+  - If using a GICv2 or when ITS is not available, a GICv2m is provided by default instead.
+  - Before virt-10.2, a GICv2m is not provided when the ITS is disabled.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,8 +168,7 @@ gic-version
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off``/``auto`` to control ITS instantiation. The default is ``auto``.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)


