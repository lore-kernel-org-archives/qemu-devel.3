Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF01E9D414
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 15:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo1EZ-000407-Ez; Thu, 05 Feb 2026 10:25:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1ET-0003xY-Fk
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:25 -0500
Received: from p-west2-cluster4-host4-snip4-5.eps.apple.com ([57.103.69.246]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo1ER-0001qZ-RL
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 10:25:25 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPS id
 F075918003C8; Thu,  5 Feb 2026 15:25:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770305122; x=1772897122;
 bh=uYfGepuvX25YdvzNM/DFH7a6wkIX8tO0xW4cMIOnmXY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=ejkE5aJPAzLnw0mhjgoSSbh0jgqsvPYS5U791kzzcfdCSvPuB6qV7twtlXNIlEXmTRbwneQw3X34ACEdy7gGRT4vWhYA2aqyp2WbYnpHfzXjWxlylfJ3VgyvFxMX20U6m3TD/FJCAse5LHJaNSzEVUHp+J5aVEAzrbcqTiQM0g3DM3keX3CBp0FiUip+J0GHmAqgC9mMG4p99uToxzZA93ENYgNPWjGiHy3uLETLpMroejfSwf+f6ZxbvwEGJMo2Xa9sWUVmjVkR9Ka/Nd1Ipon3jWQS1Opw6Dw2b3ODULpkn3th19nHQMBfC1lEOnSJDJmmSSdhrVSwEQDvvHa73w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-60-percent-8 (Postfix) with ESMTPSA id
 30E66180076A; Thu,  5 Feb 2026 15:25:15 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Shannon Zhao <shannon.zhaosl@gmail.com>
Subject: [PATCH v22 08/22] docs: arm: update virt machine model description
Date: Thu,  5 Feb 2026 16:24:11 +0100
Message-ID: <20260205152432.78208-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205152432.78208-1-mohamed@unpredictable.fr>
References: <20260205152432.78208-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 3mdlIkr73-Wcm0lPY_he4BAuCeFw1WOn
X-Authority-Info-Out: v=2.4 cv=fpnRpV4f c=1 sm=1 tr=0 ts=6984b662
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=yTMYbjrfWCcMMitk-bsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDExNiBTYWx0ZWRfX/nP1pN5CfC+N
 LBh0u5vBdDU4AdUmq+IHUgChrViR6fwTaAg4RAmjhO6WdYJ36iI6IDg1dLv05pagqXgq69d637L
 C81gdqzEd5Hbf5W2X10k/Z23oBUZ4Vrq9BnqVTFCDO94MfJ1bfUKlw2EQOP4/1mqWJCkA8tpKwZ
 GWoyjLy7AmsAP0qXx0Jc/oFTjVNScUG6peMgNpETjHztGnbaJPN4EyFTT7i23ggnxvzp3ZbpPsH
 XGlT1Eg7sKpsM1XzqRED/1KlKgrWpV6tdxsZQnygKURvjp9v+cFWWfNQfsbMqqbwcDRUm5ZG0f5
 p+8oxfrIZ9Cr7R0N0s/Jm1OdHn/hRyN6ZyHMCa6huCHR5Fz1XGwnejU9BEsV9w=
X-Proofpoint-GUID: 3mdlIkr73-Wcm0lPY_he4BAuCeFw1WOn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0
 bulkscore=0 mlxscore=0 malwarescore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050116
X-JNJ: AAAAAAABtNrbyr7uNGCzdv2WDk19QYa9b5I6ZJ9S1nbgI44DgwgAUuOoHbO+48gyRUVTvqX5LFK8K78GCWrla2+tboXkm3mebvzUjqKT/c6TOmxRTSRcTGSjnEgaNGDZwh0RdxE0uhlqaKQ1QoxA5rWY2iqRkL/3ZftNteZKBNMErEddcMo9Tzs2I/JfO0C/IM/KYOVxqJ1gM66XkFlK62XGcZHOMYgdnEpInUerJVGPIbbyXiosrhlksUyTNSKut5WCBRZ9BlElrfGncuikGUppOt4orM7temKqwFlnU8cVk4ZqupvOmLJUJNLb5jHno5OfQbKXEqmcWGHDb9ELFQYiJBjn4Kx8biOl684hdxIg9HpzYwB9w6HoTmBiunmAhWmWumQSGQEal78sxEuNCjkrV1VaQ9B9Kfk970irrMJxGMX1oNaLt1RLFNRxiEaZpEO1xvQoSa8HI28+EPyRFtC9wr+Z35gv5l+WdUgaGNH3Mj135MoVoCoBy76r1SbvfbfzRwwTAOq2Wm6gHrb/c2m5bUQ5HETmcYbxdQtuZ0jLG+iRVTWYk9mlxfG+O43qHzO8EGY7AzrE+aIGS26HcbTufyb0KJWs+oQc2gm6G350JI5WjghQ49shSUQChD/6/nZ87QKwwh5G+EGAap/k2SJlyqj9FCNswZsszFadsz4WLUsa0wBHM+BRWxArqXrI1dOV2xaS1TbDy4QoVW8SvRkKLxxuxRQA0RObWeSvinlDTEFTRtkiqEeOKmIVSucaoa/qHbQ4CKuAKlZefMp0S039yFqkqUPX8H60/EVvEZyCRhN7jUxjluJHVWy4RwaaNTcfJH8+Bgf0rsb3u9PROF4yYRaZABCL4bXzrPsH8HwgPRt/awJ2FmXLFCEKxFssvDVJLhJoac6Olj7Jn3eiRwUwgqtnUt1wSnMtG2haGzYuf+aPA5apiCwidNlvms9ILg80ecfJQA==
Received-SPF: pass client-ip=57.103.69.246;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/virt.rst | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index e5570773ba..f8148b5dcf 100644
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
+  - When using GICv3, ITS is selected by default when available on the platform.
+  - If using GICv2, a GICv2m is provided by default instead.
+  - When ITS is not available on a GICv3 platform, a GICv2m is provided by default.
 - 32 virtio-mmio transport devices
 - running guests using the KVM accelerator on aarch64 hardware
 - large amounts of RAM (at least 255GB, and more if using highmem)
@@ -167,9 +168,22 @@ gic-version
     with TCG this is currently ``3`` if ``virtualization`` is ``off`` and
     ``4`` if ``virtualization`` is ``on``, but this may change in future)
 
+msi
+  Specify the MSI and MSI-X controller (GIC) to provide.
+  Valid values are:
+
+  ``auto``
+    Use the best available MSI-X controller option. ITS when supported, GICv2m otherwise.
+  ``gicv2m``
+    GICv2m. Typically used with a GICv2. Also available with a newer GIC.
+  ``its``
+    GICv3 ITS. This is the default option when using a GICv3 or GICv4 with a supported
+    accelerator.
+  ``off``
+    Disable support for MSI/MSI-X interrupts.
+
 its
-  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
-  for machine types later than ``virt-2.7``.
+  Set ``on``/``off`` to control ITS instantiation. This is a deprecated option, use ``msi`` instead.
 
 iommu
   Set the IOMMU type to create for the guest. Valid values are:
-- 
2.50.1 (Apple Git-155)


