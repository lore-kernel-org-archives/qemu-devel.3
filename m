Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7678BE91297
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 14:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo0JO-00010R-Tc; Thu, 05 Feb 2026 09:26:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JL-0000zF-6u
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:23 -0500
Received: from qs-2003a-snip4-5.eps.apple.com ([57.103.86.8]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vo0JJ-0007x0-N9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 09:26:22 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPS id
 016981800DAB; Thu,  5 Feb 2026 14:26:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770301581; x=1772893581;
 bh=uYfGepuvX25YdvzNM/DFH7a6wkIX8tO0xW4cMIOnmXY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Rn2xkguwXxGqPLq+ysV9G8KPyg24mPo6SKWlnxxGf5f9VFygOeNZUA76/WVBjV9gQrIT82g4nQiXvBJBceS4SnVCmuSKh6sk4fohtfPkCoQDLbzTeYMifp3Te4dV1HgIIYv3DQ/Gk8wwcg6JYJJtyf7OniSGKmTY0qhn+ExfDhYl6J3HRifAs8TZRtqGCRAWs90nH4tjHF4b9rY+AnrnqMEIaS2SjwGpcgBsr0YTCXi600AkVYuRQplGICbFAO+lQpDndkfNo7E1J1sj+dgNyf4/0eIlWGQvnZfRNULowZqkiiMNd08eyrQ8ws1lUJvSw1xzjFuG6TFizK0AHxL3lg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-2 (Postfix) with ESMTPSA id
 974B61800DA8; Thu,  5 Feb 2026 14:26:08 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Yanan Wang <wangyanan55@huawei.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v21 08/22] docs: arm: update virt machine model description
Date: Thu,  5 Feb 2026 15:25:26 +0100
Message-ID: <20260205142543.64818-9-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260205142543.64818-1-mohamed@unpredictable.fr>
References: <20260205142543.64818-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9K5bBl9T5O6QfMFsqJEZLrDfWX-hFr-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEwOCBTYWx0ZWRfX48C/rVM8Wbng
 3nmOvALitNsdIQNaPYwZwNmSzuPjqfwOG4yqDaAIbxllsLvWHRO0+orocXepX6TwEGxYAuxV+J4
 8ihurj3jWzFYw8DKzKoK+/alk+hNdZ5HkYWUK/B0eNyKq0b5985D9bX0jVVL8ChSIa7nAhfbGaW
 4L8t7vlwqsKDtOlgPl6PVjE2f2lpa4uLo+K2Y5nAzfpebT0udt+Pzvj3tPDrYhpythvd+a/pn02
 xFcBBLnwlrwxelnDR8LyzisA+R/SRsmg4wXWBiJlEv/Kb9+XnbBriukIH1h7XIGhTmcB0+uO3jy
 CCAhmhWzNHjI68s72crrXZsJd8HR3BQ66LUWSuC9Qf8TkITHu2BFEDfoROKRj0=
X-Proofpoint-ORIG-GUID: 9K5bBl9T5O6QfMFsqJEZLrDfWX-hFr-G
X-Authority-Info-Out: v=2.4 cv=bv5BxUai c=1 sm=1 tr=0 ts=6984a88b
 cx=c_apl:c_apl_out:c_pps a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=yTMYbjrfWCcMMitk-bsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_03,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 spamscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602050108
X-JNJ: AAAAAAABifD3pZpvTdrjU/esJfBzYy2k/jpR97YjJtoMR05TxIo5KFLlpPlb11hWBIwlBLCmXok1hKYAQ4GEcOq/6SddT4RgaHBrTinNftw3ZAPHpqPwat+qJq8ug1Snpr7ZaMEBy/Z74Nmhil/Jy3KDTtsXGZtgTUgCXryZhYT9uaAOYu21W0zcUbtWavAm/Iyl6QJ7M3JZmWxjllAmZ9/zf304SkYu9GranwSlpvT1KfygKOD9uCCLkhidlaqAtnBGSD5BXbFaOLPoQCBoII5DWsZ+Knqh4y0RJM6QoUz1e0C6r0408G0+tsJn4dZ7p4GKOxfa60cBOZ71qiebq6bdb8wJ6PQU6UwFcKKgnpfKpSHTOu96+gQULeUB+V4VWaPyb5NT0NJIuqzYrFsuicrEkz73ZF6B5xSW6tN4+I7sa9S2gxYJF9/4lW5tWZeomnah5I9dynw8n+G81w/LEENhy9KHH9hltFig9D37beP9kVKfMd7glu5DbXJBmmzA/eNtyCVzvozt28uTmtpDpI+kMGZTwsLNMLDQzX1slVoZnjMUqb6lJB+2nlHALOf5Yfam0BLIt/mnAdBqjk/Xyw6B8ovS7cHsHJ0MtBWpvhv0FYyxPysWkApGb2vz4pGJYj+slN6RDM12nHuby4M2PrJfBXWD1YdFKO/YU5hdSzc9AvFpGUPMMBVJyBY1zNU9jHl3bjxScu9pAHbePKLDyY8VFGpF868qYPtJQYTlkGdR6zoqnoa9Su8A38/cu4LWwViJFtRRgpxqwxWUm0pw9Xe+7m/HhRHjPFUOwwQRzDuRI/AbHVZ+UrbAZomS6jWjj1I77UunQh+B4FhRtMQq2rs5rq7XQ91gqPsmlV/nssUBiiSmsjFSAX0IIdqw4nxa7nIe0Qmq4ykdKwbSa3QeH4CskRNx3UrpWwKGJtp1ungx2YeboREWAJbmMf3i2AdXBty8LpTgN6Y=
Received-SPF: pass client-ip=57.103.86.8;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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


