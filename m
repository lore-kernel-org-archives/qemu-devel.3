Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7CD2CFA76A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Nov 2025 10:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMO1e-0006fb-6r; Fri, 21 Nov 2025 05:05:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzm-0004rw-GI
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:03 -0500
Received: from p-east3-cluster4-host4-snip4-10.eps.apple.com ([57.103.84.43]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vMNzc-0007xi-Or
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 05:04:00 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPS id
 1FC6218010F4; Fri, 21 Nov 2025 10:03:17 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=XGaKazcthBegM6ovKXstpN3aPPoKWtMb2v4x7eFc63s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Q/RRVo/4WKrQal1gI1O2DOaR83cpJOQh7m0u4xj1IdYuofN9/wcwpreVgfz7pe0mxhU9266LcdpTgZYd9BuJfrdEnbpo5WYe01JNv+uGpBZ/JukBmmXqN3UBE/QldeYjDbiZdH+jkyYMArraNk7ELTx/OlhqEoMU0SrAG7dDdqv6kOwwV7d9cDWFMtkgBrqsiggP/eBVqYhLxP8AXCxo+LWuFXR7KlZ+ClnRzuX3DuCR95clyAR/Kxm3N6wOe6nXX+6+sTMan1aV/qW2sq9cRP16QGeIlQVXbhByWQ+e/tWD9rhmFqXpIFTkV+Kq0eGCAo8UbWSNX5uEMHpmGO71aA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-4 (Postfix) with ESMTPSA id
 A2E92180110E; Fri, 21 Nov 2025 10:03:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Pedro Barbuda <pbarbuda@microsoft.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH v11 19/28] docs: arm: update virt machine model description
Date: Fri, 21 Nov 2025 11:02:31 +0100
Message-ID: <20251121100240.89117-20-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251121100240.89117-1-mohamed@unpredictable.fr>
References: <20251121100240.89117-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=YP+SCBGx c=1 sm=1 tr=0 ts=692038e7 cx=c_apl:c_pps
 a=bsP7O+dXZ5uKcj+dsLqiMw==:117 a=bsP7O+dXZ5uKcj+dsLqiMw==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=eeEvEDfxYroLKDhJbXEA:9
X-Proofpoint-GUID: nEqZ9mkwkf-TiJfrD0JDNSnlZPb6uHkV
X-Proofpoint-ORIG-GUID: nEqZ9mkwkf-TiJfrD0JDNSnlZPb6uHkV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDA3NiBTYWx0ZWRfX2cdDrSTZ+WC4
 yIHXYtclPn4pnzpOZvHtCkzAyyM/CH9cbc33dHFWqUvEeysQCKzcklmeVeReXSA67TnCXYaUHVh
 /KitLaeGtS4Rv/90ju0yz/aQnwLUixrM/YV3G71qHuTXi4SYdZXxQhXDrsftkHABseFhDnQXzcu
 gt0FLXYYNuYkPvpHa3p1RFR1gvSXqQ0Fq5SDj2TpKo752IubOP+F+lsuT/W4bVLA2IJwLq3i6o7
 4S4Au1gHr6aN0GRk72uawwl5Wcbx9rMYjKrLhKrdB4a33SWd8DGD6DP5cTKRGeryv+bSo2j7Tsi
 f8/2rfQe2dI9VIMeAXN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0 clxscore=1030 phishscore=0 mlxlogscore=984
 spamscore=0 malwarescore=0 suspectscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511210076
X-JNJ: AAAAAAABTVdfod3N+vXlmaYnxxll2TTjkO8HLAfslF0Vc/L3WBKU9tW9u2z32Ws7S/ROIAI9m0kmXtKm541vZPiAhRTztNsUWoiMrC0wgMxk1hkGnicw4agduZpbdgeX7zI8qTLDEhSwZ5aWckTn9y/ssyTsBSKLNX/QaVaBFIbYc2LvLcBEqI30Jgb5WKGYB6CYKhy3GZt86hbIORT8aiC4Ojsm6eJEsm+6CCdA+m/855UoFr3Xjt/muNXScxo3evHfNMDYPNu3RvNzSeFma/1maWjcAzpa3IM/Cw8Nbn4a4O1+NvcZe2TfU+l0340lgJ0PkzDx3kck5CQGFTpgp8+wBbtRkKwMNgohuuRzzSpFoxOTQUSIO33oeU3ybv6t6P5QHtLcqBuZ5+xw6OZcZ1/o4DmZ3yMCmShFlTQLBvuf4GCF6pe1ELbJjmfTI3JABioqVFxNlJGVG/2QEIf2d+WruF8jAqVdYwSKqblt2h60+4V4YO+odlwAB0YlAd8gNhQX81lZ51zM4gb6HjINOSojqtK3Vrr4tGmmpFs+D2hK8bKbjLah6FjtKS10fkuyJe8XdDsFT/UQ3aLS78F6ElSUzkmV+yAW68RRTB9ymzt6nAEtTn+qpgYVyI81sFyT+yzBEnOyQT6eUHtds7Wyqj8DQOwz+R0h3NMGhsw1QShy8W40ILj28zNPqceorjIEBQ8NqqM0hkDyf6fKOLbTWJQT1YughdvDp4kUMAtksuqKKld7oPRtgZtx6NL5yc4q
Received-SPF: pass client-ip=57.103.84.43;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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
index e5570773ba..7d20f136b1 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -41,9 +41,10 @@ The virt board supports:
 - User-creatable SMMUv3 devices (see below for example)
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
@@ -168,8 +169,7 @@ gic-version
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off``/``auto`` to control ITS instantiation. The default is ``auto``.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)


