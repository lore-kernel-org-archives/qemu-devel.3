Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5C46CCF9F1
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5z-0003sK-1r; Wed, 29 Oct 2025 13:36:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5k-0003ic-Er
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:12 -0400
Received: from p-east2-cluster4-host3-snip4-2.eps.apple.com ([57.103.78.133]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5O-0003QL-Q6
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:11 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 CF1C91819DFB; Wed, 29 Oct 2025 17:35:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6QHLe7sI/ta/TpnlofGbhZSXfY72nxkqv2tu61id1Xw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ACmYPaOK3wlGjvAw7EvZwc3GPi9M6yUHeduX0TArOzYayJqx2WN4hhQ1/eVEcUhDWN68CUoIQ/jJqCsbIt86WyMpwAJtWCE1qoBlRsVGUXgMBEj4TrC/bWmhdWXGKbXR+xdI2v4IIjLwXqFV1VevdimfPuBRwc+0Tipz530Xe/vVlXoCq8bMVwbhDmH7VaUvjdnKIvtBERUN9lcrdl760Y4r+Ywfbjm6tnuOsBLq/fB0JzWMszv8fXnArahqScbWZwmJjZMJbGYFmpji386OZ76DfXlTDwEac6WBOTmfQ9YDK+AXyQXdMrYGPOUS+yz3tLoeXE22wJ+1s6iH46E5Mw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 8FB58185FF7E; Wed, 29 Oct 2025 16:55:49 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 18/28] docs: arm: update virt machine model description
Date: Wed, 29 Oct 2025 17:55:00 +0100
Message-ID: <20251029165510.45824-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 09__zpetjAVAmnjb9JSUTN-KIG__7UPg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX6ZnYYUI/zEGM
 ZqSFf7B4pEv9lGkP/n1Eu4fWwRx7qUq+3m2bbWDY9X0yhU9aBXFvV83CYjWgB8BQFn33tfKZbmi
 0JJ7GHoia9Sq6Lw7gry0rW1ZdHahRQxBdmI+NwMIusBcWhV4IvW+hqx2IFF2gEo524gJzRTdG4y
 xjVeofpCTOOCqKwE8/FXMJ9n7EbMmvk5Ku2Ir305Z+Lzx7BDkE5Iv1Y8a9z7fT28ahYLwhuNJ11
 c7qXzCuHivM4IEaYt0bKV7KKaNHYbt0f2hQ3V8Q1S6ApiDOZTdYm03O4rIqxvHN7+wGFseu24=
X-Proofpoint-ORIG-GUID: 09__zpetjAVAmnjb9JSUTN-KIG__7UPg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 phishscore=0 clxscore=1030 mlxscore=0
 mlxlogscore=810
 bulkscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABO9Iz7HPx/694WUVTKGEvYK73zyEiPiyWIZNVWm+usUBa6BbBQcBTidc3q8tycRfv/30ARlc/rcAA4I7ECnr3/48tVGCw732HwktasRgComaY19RftBVJ1r0qDcoZdA7Nd5554jggJLJZkVxqHdv2kWgLOjM671vzQfA2NOyIw/CBgyxGirNT/2iyoVFoGEjN157w7J5GRUE3A+8DOvOAfhHHf8B0jsXKmm8vAcWLNXpCmYAtq9tD0MVKaCp4b/fDcyqBSL4HsdueJu2SREZb/o44d1aPsEWXOoQO7kT81R7IxTWPDfqDduZrowhL5Pi/VSseXN+ZBnXh/Ynd0njdwFYCjDA0FSOCaL4+OXfpMDfRaZcCf36NiGHDZnlhDVrZerubvJwADRzW7xR1imDxnsu/CMoWEwCtO/u36FXRErcZJWib6YMjcUds5unX076OA9yBtfkiN/Wpst2QuWZqyC01ZnmpZUZge53j0EMIDcBaM+31eqG1wqXxHBbQE2AxouNQeyBdr4W2m32/wc3QPZllit9bjtM+fve3C9e2W9jHvXFYtbZEgcNjx+1WScV+zzikbdtLbZzOZ+lmJDnbUiQr1sIadenzdnNeWe4A7DvDGxfQP5l/yE0Ed7ms3GRG0w0Ji1P1fVBi56fsuFaLsFfnLysacMLmjehnsFLsNbRQj9Ujn3tbXkSkHnHWWf0nxG7xIO7+s5x1TDME7omVVgJIt28AADsu3gNs/6WFgfZFqYFdBkFoqo8=
Received-SPF: pass client-ip=57.103.78.133;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


