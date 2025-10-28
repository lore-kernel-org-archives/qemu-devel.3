Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1DDCCF9EA
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 00:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtRV-00029g-0i; Tue, 28 Oct 2025 19:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtRN-000268-Rw
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:31 -0400
Received: from p-east1-cluster6-host2-snip4-3.eps.apple.com ([57.103.90.144]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQu-0004oL-Fv
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:49:25 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 94AA718034FA; Tue, 28 Oct 2025 23:48:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6QHLe7sI/ta/TpnlofGbhZSXfY72nxkqv2tu61id1Xw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=SVZDKv5z21ywtBN541WMS5YN0L1KgOlvMAQ36tWhEe27lSmt9EdoJFPFXyffkW0nqlrRoDSR5k/dSen8UkYfBPGcxLkcRO0+PwwkQN2ZJhvcP3NmH/IkMH8lfowUBMZZj4tUWy1WxWzcku1R4JtdsRo57vz6h6sB/xbNB4EoIGCN/LK5JbbQ3KLp+U/7GyBM+3Cdnav+Cy0G6BAwvqk5q2TDKx/gvc6GxJI8fhEMgvj/M49sy/cxvcmdfXRP36xJpaKBU8X0cG9HstIBshPp/guL4Dp2zf+Bn+PAT8b3ANxu/BXtldE9n/TE+OPJd+PEfUhUMjR53e9dPWWp4bhGhQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 C35FD18007D2; Tue, 28 Oct 2025 23:48:43 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 18/27] docs: arm: update virt machine model description
Date: Wed, 29 Oct 2025 00:47:48 +0100
Message-ID: <20251028234757.39609-19-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX4tS/wLZOPeI+
 acUnl8G7QGgJapkrig4LWMC7hlxRlB5yiYopTMmifzjJhzeGbRWnAMJbT8ojDqxr74tuL4gInF/
 hOYvoDbnrRzrOog/bAOVW0xQRXgaXngxguwUdvWFIEet2/sIoKY+PZ8pbyI8T0YaMNex4knvoFl
 gXQq0Nv05RFAUVMnHkQw9N0gJ8uGaxa4Z4ok5P/L4bayZj5CSRNLoopr1i+LaFufyvUHcs9AZYw
 66vTn9ol+pGUA81UEOd716lGPnMioC2DoUmhK30sLYvSNpQ5PJmu9puErcbsCvsOrpsHaAuRI=
X-Proofpoint-ORIG-GUID: 0IPLxkpzKZC6JpEU0BBfUH_M51XXEA1Z
X-Proofpoint-GUID: 0IPLxkpzKZC6JpEU0BBfUH_M51XXEA1Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 mlxlogscore=944 malwarescore=0 mlxscore=0
 suspectscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510280202
X-JNJ: AAAAAAABQPdRHlrbN18tr0EgtFz7qu1mJQiQbNvC2czdhlNIjy7OMcpFbn0hI2ndlyfZMfJUfvGHcVynLnPAOSXjWc9uX0GyrOxSVmDhAMYuE6Zeeu5rEl/RFr0UdiwZvFg4mCA5Gizg5FCrmg5pYGOz639SeJMRdO9HWvK3jXDxK8xq/HyTmprQngdO6RW/0m5vIEVOTsEWjQskogD4dcFujWr6BVKdJqeBqhNVMWkR0WWw0hnt7JjhF95QZsWlIB1Oua63bdZziRV6eDw5GqaPNs+VjmfECRsQ7CqgfN5wv48mG+qYxPNppINYEDZdiuZgDpm/eLeHobod/fZaeWcgXhaKgkpnPvXZL0XDPPdrwIBasUCzoZfCc6a4+doBaZtLZOWy5JfWqqjiWviogICs9eb4iNPK0H3IILl/+8u0BPHn8BTDakvbGjsZu2o0sxREoZJ9qIWYUWPq2FEy72eauZMLucwJXCC3vBOoJd/E/bcW9j+6Y63B0FzyzCcwrlGbt8BacrRUQPEuJuR4ra8JZV38CKINZtV4n39wu++SL7PeqZ70q2bCiGSci35VqxZ5pg+XJfZ+NM9qDpw8isnjDHaTSNaG10sRW0YL/mq3oESENZs582Mh3lYQ34OXho85j7DvR1AM1m83HRT47CT/qg2ZWsV887US7T9zZC3u3rNDoLBywIYwdWEQ5SCeH2bTwJ4lEOBMJbkigRirFgFacO7u0P8+2DlMMle3bkRaaBZE36yvW4d1tW4=
Received-SPF: pass client-ip=57.103.90.144;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


