Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 427F9E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 23:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va0cy-0005RV-An; Sun, 28 Dec 2025 18:56:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cw-0005Gx-D0
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:46 -0500
Received: from p-west1-cluster4-host4-snip4-10.eps.apple.com ([57.103.65.211]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1va0cu-0007FC-8v
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 18:56:45 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPS id
 827461800744; Sun, 28 Dec 2025 23:56:40 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9dZ0bIRQfVZYIGGuhzKfcBpJ5dwbdg2lwsrZICRf3mY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=TA6dNCEYGCcH0VOu8eJBSrw8c8EO+WqT96BfmHI7Cv3vIsu3zR5xDilA3+tEbrPDuKlcAOSUx19hzA6kjpzZIP+ZHMFKTnUJdGL8XW5nO9KLzVyOQauuW/gZdjMHHx2ZtNoGvwEiQ+iEXOP/wvc70ib7RTEysxCowUIaBiAeVoYDXYtI4qhHThvskXcLXWrRuXHi9IudpCr+g9x+4ruWPJk4v8g7oVeqyPdIVqh8Xwr3MlMhg+ioz+TnujLhuPAd5BxAsYqlvoYEkKaGNwsDOEZQXZEkMh1V/Mcv0nJRHEcZUidzI9EBJvB6nHuZiEASukCEuh0yu9ynDSIB8ux6jQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-5 (Postfix) with ESMTPSA id
 BC0E2180074E; Sun, 28 Dec 2025 23:56:33 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Alexander Graf <agraf@csgraf.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 kvm@vger.kernel.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>
Subject: [PATCH v12 09/28] docs: arm: update virt machine model description
Date: Mon, 29 Dec 2025 00:54:03 +0100
Message-ID: <20251228235422.30383-10-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251228235422.30383-1-mohamed@unpredictable.fr>
References: <20251228235422.30383-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=YYKwJgRf c=1 sm=1 tr=0 ts=6951c3ba cx=c_apl:c_pps
 a=azHRBMxVc17uSn+fyuI/eg==:117 a=azHRBMxVc17uSn+fyuI/eg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=UWX6RoDBcPCHCN3xbnsA:9
X-Proofpoint-GUID: EtxjQywVbxc3nE96Rj7CmIafWux5kYLL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI4MDIyMyBTYWx0ZWRfXzjNmEipZwqVg
 PMgPx/XF4NwWggXrLdc74Aksqyxjloxll6KJZpSnquRXmhfKO6Iv3s0meQvURoXGxSHxry4dorU
 G3YBkzqt3mVXhqhYdwGZGeeZRGNyj22XGvOIq/u656bMBb6H0HHZTgs4mvgCXJZiDyp0qeeCyvW
 JKpKAxs+MowLyKFqkwRQhPHTkPe/qDtWA2uiuUi4OmlwMlFq+7ZaznIZ2e70V9Ub0n4fpN0HaSi
 oOf/iRtxTNl9AJls9SevXyA0ycPYfCV5qCdvXU0gpwHVRlVHGIS0r6qY1zX5PIVPYj8H+eK5gdw
 4AZkcarplqMZvLZKjLc
X-Proofpoint-ORIG-GUID: EtxjQywVbxc3nE96Rj7CmIafWux5kYLL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-28_07,2025-12-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1030
 adultscore=0 spamscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512280223
X-JNJ: AAAAAAABMrBUqk1HogRBIFKO7KFoGZLlIHnJ5goFC0HZDvLyIENksuNF9H2PPzdO4GJKku4Z249JQLpF5fwdymciuYHxwYosuKHy9fc8NE9QT3518ppMPZfCfn59t0wiywj+F9wv0ju6jAmQjYk0TXoE+HoahNFz16JCakWGFq+rbEMLnEKYviOkpcm2eOomtcEb7n07aZowZ6Ggo3mpi81XJ3f3CE3DzeGtKRxYMyw2upnQn428P83vNvfKRt9794x6aERlOVEKouzdGF49M1lZQUEKDM5PIDx9PKcSXmUtBeaVEwadGPXUtVqZgTw6nSkYNZDTnnGH4MLy1jWssewrB2EvgNAfcHPpkuq/lWq4yJ7+xZgTAPaiP7k24GG+iqgbq7nSlrCklxmkoSZGp9wbZn08MWwkgG1vRJ/oMsSHNOcLrb0V78VQhNVJwyOj2A2WfubZx/aIkCWXEOU0SF7Ri7XpwLGB/BqZiPTni/Mc75tHgm7qOqGIcnt7956dwfSD0bfw+NqeiZVOLJpDdFoNrwlMjwSI4pXmCRRjuvxwdxuwiDr0WIPiqcoGo3Hy6kaJEkP6oEFqYWETucnO52/5d+ZciP86Ag2NqaDomMP06vWbozWXpJOjbV+kC8Ovsq9olujP9o4IGIKw3PVZoTN1rqmO/FRqQy2US3CMrbx6zG4AWCoUAhbNbpXVaWkRXAwXWPUTuUGygB8KTiAUXlO/zgwtW6Ve3HcyBMaUfM+pWypi4u4Jgl8KMSi7SHPIkEc4iHTLfKPbJE3o07WlQxssn/X/ADKulcMRZquuslcMKKB2vU1LeCyRVWih0oop2Bmjbj5xOHMP8jECSg1i+6r8aVpsy8U61x1jhMCVhnhpI2KBSTXF/cKJZ/54TWtozQWCD61+PvGkTUw6efH2q/jKllZceT9zPiVPyPeJmWMCjif8/iq6ne7YGfTeyIHRA7V0N/g9cKsFDSBT
Received-SPF: pass client-ip=57.103.65.211;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


