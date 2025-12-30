Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F75E94100
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 00:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaNFC-0006vB-NC; Mon, 29 Dec 2025 19:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEb-0006PC-KH
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:12 -0500
Received: from p-east2-cluster2-host8-snip4-10.eps.apple.com ([57.103.78.63]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vaNEY-0003rd-TT
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 19:05:08 -0500
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 490EE18010C4; Tue, 30 Dec 2025 00:04:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=WIhlnxgxBCyc+dWCY0SbNhn5OBvUHdUcvG79a1EP0Gg=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UBNYkkGSZexyJNHS56OQthdth8yyuz0wIK6ZOdVDEi0svCf5aJhDS0Ar4QqUaGo5wXLpZUqLQuMHCMZe73YyUCPZahL+sntNLiuuk9dnOzPm6Tb4RynvA6X0QwtevOev95eFh668vYu181YrjxQf92zjbLBW1xn/aSV3WIXR/lxKinp/94g9m0nnOATiXGKvXZLQ/SOzXyHd1mshH43Qj00p1zpP7xmCVwfk17jVnTTbaOrArcCeHXKRa1+B1XEBYPc5GJj1FZQU4R3Vkkyf9o1gpgqvMBcS1gV0FqojlLqi2C8EOfiMkvOPHQ+rEzIkywiBiYyUHBP4MpsSW8O5nw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 5E49E1800104; Tue, 30 Dec 2025 00:04:53 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Peter Xu <peterx@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v13 09/28] docs: arm: update virt machine model description
Date: Tue, 30 Dec 2025 01:03:41 +0100
Message-ID: <20251230000401.72124-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251230000401.72124-1-mohamed@unpredictable.fr>
References: <20251230000401.72124-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDIyMiBTYWx0ZWRfXwm7WRUxXjWCq
 QJqOn9olXPpKs0VTs8idWkBl6C6wKisLcnd5xMLDb3PhUQnrC2WT4KMZeHMAfVqoOuEj9lhjO+2
 H93XPeTVt5FXgGgJsSctNrP1O03XctlfYiMYn7i97/iMbczMt5mr4LGn1S18RGz/yFtQXoinKfs
 e++tIUwfzejLIJOxJtn7uvd1EgcHFPSVPK1fIqb1ls94vjCXEi9Yb3VquWxrpXikpHaPTjaD6SW
 FHp4kLvkRNYjw6cVm0Y5LR5HRppDySK+hkkhHhOZx/VkBzQkjdLQRLMgtLOSOqnAjKpNnMZUWEY
 w3IhBoft2aTKR6DviKi
X-Proofpoint-ORIG-GUID: 5-XdhjX4JAVUB39Av82NK9ccJ8-teQSs
X-Proofpoint-GUID: 5-XdhjX4JAVUB39Av82NK9ccJ8-teQSs
X-Authority-Info: v=2.4 cv=YI2SCBGx c=1 sm=1 tr=0 ts=6953172e cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8
 a=UWX6RoDBcPCHCN3xbnsA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290222
X-JNJ: AAAAAAABPEIWVMqwsbN9XfNH7HvB+4d2fxRctpxHpMZ5cPfmdgM26jnF4cAZO+caRkJHsHxUq9ogpyHIcMVr0pljrwtuzM2EiDB+gyRfeke8CFDrk/9m6vLdMj9NyCPp5JxIpMNl+Qa08W9xxTMVvZrAhBrt8UbUorw2vPTZQB8lujL2yGPvB+lvNWje0Usx0AzGT8qYJQUI8z5CHCue+vYLyNFrWoqyshsLw/kBiMKsls26El+G7LWOAiPrjX/HpudoyijE/XGrSdw/W93jIpjYkGYsyFC4m5dDRWN+pb6TQAyIKuDlHyIQ4f/C1d7bDF1UCKtbF7AdsNJoYJEtvfUbIhsah3ctRtZsA+UnNv97fuqCNkZHKriQacBEW4rMp9lJgaU+5X3O5Xdrq1ltfFt0zqf6DGZt1QHq5PK8W1SfUDUIAKZ2Xp2YvlwwmY8x6de6mjWYs0xxosgZx0wbeSDb8/XtvHWlS6El/FE5GdWVnNW/LIiRjDkZjALUZUjsr1EywbFan6xnRA6HpnqIJwcG3UpnusxipJ8iQ+Kh3IoFJcybdiiSCm4gceP0ZLTJXUcSEoJpb/Q01UPSk5ponQhZ/luF5Ks3+pOrTq7tV4yhiCNU1gCFuimGJ6n4kUOoinXk1r5KZkdnXrQnsdHzukJbccjp1ZsgBCGjsTHJC6enUD9Uhsg8wOFqsBigk1Ki+hGQ+Tax/y8ZuEMuIQwN0U5nhok3n53y4XgaCS6w+unDJP0/zIC8fwfoivGN2u22jJOg8yHT30KjFt/C0Hk8i80FQ057qPBCuFrw4z3HAkpEbOv3EQ05tYFlkV40DdA/JDcPbAuHjthLcV7b1cr51CVvlDRE7bonxLMbBTp6+q8oopy1hExPWu+hc7MhgeaNShsKlLOyqaSf13Oi3gmeBbO8LsOh6Xuh1zIVS1yxbS3IeITvWNbUEWF6mEJZwm/278FEGQSeI0eCSRc=
Received-SPF: pass client-ip=57.103.78.63;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


