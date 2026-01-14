Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC334D37E37
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:45:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg18h-0007s2-Ua; Wed, 14 Jan 2026 08:42:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18g-0007qv-77
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:22 -0500
Received: from p-east2-cluster3-host11-snip4-4.eps.apple.com ([57.103.77.175]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vg18e-0006gA-Ly
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:42:21 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 3BD081800095; Wed, 14 Jan 2026 13:42:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WIhlnxgxBCyc+dWCY0SbNhn5OBvUHdUcvG79a1EP0Gg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Xiojs3k8JQMHlCLCDA6pxUzdJ1ZluU63oKaoIfsAEo4DIUUo9wNqWv9nlsfffXNPlXOEfUAB3OGEf3seEMRtfrjW2YI8j86Xo+17DvKgLpPn74G5GgNr5CW6rVV9w+OIOjV6/FnCb9JvioGSUHzzXduAfVJsvXfe7MU6FQtqG/e1wARlwHxGO0AHgDrqpmak1pl2g8fGFDKDREoopbDPv3+YXYqi+aCFTsY8q/pX/u3zN7sChHYywNs6ACDI/ylfkhg+C1NYa25E+wBD8x0BJ5TOM5wiP0Pu8RuEwb9ZtzGfC5Aex2AsOFTAu8ABLMlj3zriqgB1ndcUO6jVs9MwTw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 17EED1800160; Wed, 14 Jan 2026 13:42:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Igor Mammedov <imammedo@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cameron Esfahani <dirty@apple.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v14 08/26] docs: arm: update virt machine model description
Date: Wed, 14 Jan 2026 14:41:25 +0100
Message-ID: <20260114134143.26198-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260114134143.26198-1-mohamed@unpredictable.fr>
References: <20260114134143.26198-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=HdAZjyE8 c=1 sm=1 tr=0 ts=69679d3b
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=UWX6RoDBcPCHCN3xbnsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: wRI2fb7AVvun-G6ayGQWsTaOApP5Sd1Q
X-Proofpoint-GUID: wRI2fb7AVvun-G6ayGQWsTaOApP5Sd1Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDExNCBTYWx0ZWRfX1EIp58u+zmPf
 Ct5dhJDegK0QieLq3pNoSOIVbgoDykROXUmFqfMsos1DcEuF9tPMaup4Ioe3bdq7maxDq9QkKeQ
 GF/Ys93DqKGdTR4thU1+Al4UikoW2WPtebRBD3lqxdbB9i/cgsZf5Gaf4ecF/m+Epx7YLoi2pdL
 w1ZBC9Fl1gveSqxFfbWsaj5PiYnEvaGVQ9tTu8YEOPcmC0HSi3cA61qJ7bB6cPS1+lxElIFrLMS
 iMH99ys2pf/HYkHFVhWsnCP4nZV/CjCNgd0dz70BsBQQo2BjtPV7vB84jlzheNun1Q1ggr60nuW
 uUWJxskr21G8ujn8khb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 adultscore=0
 clxscore=1030 mlxscore=0 suspectscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601140114
X-JNJ: AAAAAAABuRW2xaS+RPXiDaqx9IdH6dbqOCN7FbK1oYlHhVLbnwlkrOD89KNu0IZTA0rJX+tz4UPUuwWoSRX56+y3caEpjqT7fuHFB8rfczopJj2fMasMhrwDuG/Q5sydOqeRV9qhzqcWBafq0RmdQBwAM7Pa0WdoQeNSgJPc+PdbFPZ4ma4S7XZsbNXm9ThV/oVSo61HYlW+dJ4lbcmpLC4jtUt8BNi5eN7OKHpqlVm14OSCVy0B8rYuscbVXRsUtA7/jazDb9bRUcXKw4N5VRMvRdoQzgqTGFvZVcig4ByaqIQLK8sUf+joWv51xGWMisJxMqPAWpgd3hwx5L2KU3nRpOvNyG+ZUtMzgoIGhign11U+hKHuUaW3SNqf7NTwahNxYJWA6iDhXXwSU1O/WPNCPJhuMDG5Nx9TJjLlUM3G6PDwuGsIecbvQ5hofco5lHPojGyG9M8H7M4sTqrcnjkFLKkCJv0rdc3527C1+7E7uG/srhyIZMbXkBNBSkubOjxiUQdXo1Dw4/8fKqa4V+OWk1T4Z/Z1xSArNB4RkpIlasdMDD7lk5XadZmZOobVvuRyz0fCZKEANMW4sSSJ0uJwLJXBWF8+NC9iXyw+Zp0vx9TnJJkCfzg2Ijz6k3ootAQVeUEgaFm1m47amcoHJ+n53Md73yABxTgw4hhbYfQQ1BvbMwSGFMfbfrnST9OM9ynjayFvxC9zu2W8kRp3dMl47JHX6p8EjPQZ3yB6YSvzjxDUbZsXBUVl+i/pLGDY+3ff4X+qtLgKhQydpQ7f3OfGBd4940ZURVfOfkssWm6dFkbmIX1eIQDY9b6r+yLMcyYqULIfkyjHT2pcSIvy5UWMP5ddnUNT6zBpTIS8oRKtelMicLvesOxRVqiJ2Gj5gRPKvz2ooNE12WaFIar3mTIVLtP/esTIFBdettsNrrov8dF4Pw==
Received-SPF: pass client-ip=57.103.77.175;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
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

Update the documentation to match current QEMU.

Remove the mention of pre-2.7 machine models as those aren't provided
anymore.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/system/arm/virt.rst | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..b6e88c4f13 100644
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
+  - If using a GICv2 or when ITS is not available or disabled, a GICv2m is provided by default instead.
+  - Before virt-11.0, when using a GICv3 without the ITS, a GICv2m is not provided.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,9 +168,11 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Set ``auto``/``gicv2m``/``its``/``none`` to control MSI controller configuration. The default is ``auto``.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off``/``auto`` to control ITS instantiation. The default is ``auto``.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)


