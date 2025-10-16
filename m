Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48722CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 16:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9RId-000181-Si; Thu, 16 Oct 2025 12:57:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIZ-00016r-PF
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:56 -0400
Received: from p-east2-cluster1-host1-snip4-8.eps.apple.com ([57.103.76.31]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9RIC-0001dF-DK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 12:57:55 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id
 6EE9218011EE; Thu, 16 Oct 2025 16:57:23 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6QHLe7sI/ta/TpnlofGbhZSXfY72nxkqv2tu61id1Xw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=DwBnAmoZpheRLuk8rQ+itPmRpEjS6uw8/08j0r+hgPNjG3mUcpMPfvr2i2VW9SLT3RZAcqwlCmmrXe4BBcq9GRLVPnUJ9SoOaa5gdMWtabgMFq4votqca2Q7BW62jodcE2HrQEh7FrIBAqkyXq2/zc04xy6W+Ef27sMyL8IU1Jl/i2WYwyRYILmfqFscZUaRG4HpVO5WcuFNZj0ac7WEme/Tz7UR4jhEW7x9MgkEV8xjsPstRWSMDm2ygwDRYM17osn7EBnekCVH9LgA/6RDjnxPFkp74kvBda8y6UIShaYnX0+CfJLRkahKTmza3SnZSx28rxrHUpfM6DOsCWuVwA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id
 C2E7918000B1; Thu, 16 Oct 2025 16:56:17 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mads Ynddal <mads@ynddal.dk>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Eduardo Habkost <eduardo@habkost.net>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 Roman Bolshakov <rbolshakov@ddn.com>
Subject: [PATCH v7 16/24] docs: arm: update virt machine model description
Date: Thu, 16 Oct 2025 18:55:12 +0200
Message-ID: <20251016165520.62532-17-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016165520.62532-1-mohamed@unpredictable.fr>
References: <20251016165520.62532-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2VXZH75XKZT9jAzttdmyyJwzeEHNfDHa
X-Proofpoint-GUID: 2VXZH75XKZT9jAzttdmyyJwzeEHNfDHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDEyMiBTYWx0ZWRfXzpYjYO8p3ePJ
 K0/rRlNsQEkZrAgp+DFHF7BvmhTCCAHZ0dz/F7+RXskkXz3QVfRx/dQLgty+PlL+u82aMtHCCQz
 0vGh3oDovb42Ux0qxZWD3xesKIEbeC2ufRIZ3KM68bdj/nJRiOpxg9kpyPlKMpgHT0wZFUTUaMy
 k0ENtmyOJP/ouoSKV+hzLmgcJT22LB1eRz7ZgxggiZPtbvXlJKnYB369Rg8wiaduS7XLaE40NAU
 55D/OLzaDvAMo8HA7PaAPW8OQdhxTWGQE1pLagPudS7/ppSpnqgBzP9Inb1G5GtgaCWKahRVM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 clxscore=1030 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160122
X-JNJ: AAAAAAABa9U4fBV+CjKowirirDzCSK5ju6pVXYXq7M+2rbuc+mmuhAP/AVBJnh0wq26he1tnSxZYmyvI/jKe7Jz4w9tpvW2DDld2y7xzrzasXEA9Jh09xBayCyOveaaDDPflsEiMIkffaq6W8aO1MrgwcSIv9doGXXoCxRdH6uFaee1hLlG7IgHcjMiPyOGXSKO9JHr/nyMfBptqpR/6S0rLFwQC/rV+6cub5DKWkEC4r4hBztRIwrHBZczl206Ka+pfPa0gx3r/VMdfQ1RKVXUnxGKsZSFP+0xC36HLI3lMN019sPj0vkOlKQtPzxH2u79jHs5zfciKPbSb9rTKUjTgzR9qprqd7TjOBfc6XO/vra+zWTnwahFF6qs5zMQ2I40rFPx8VZkYmd4qYvZQwtTS+YekIeHeIzR1lW6o/wpx1ypLsEH4umNV+uTvsNzImmAU+HnoP7/O0jcle3Ir3kCZXjLXmluCoEFtIewG12WUv87Oh+pD/M6MPcJjTjkIT2Ap7qLffe/kP2Vr6vLEEx4mYhQFkuzkjq3KpuaGqmu7F85XOsHIXJs8mnZ8j3/W34WoUvvObea0173qbq/GrYiZbmpZcIzX2ZoeCZ7FjigkpLrJdeCurLLrrwMJm0RgkQ2EQ/OUH1tE62YnYE7OJ4DhRFvF1LvMKcDcommhh2vRy5t6dErzZKgauXia2XUwr9T80yvdzoMwQUIWIcUyMDTnxsJgPl97zS23PVcvEjU79pAYi/FVAiKhCBHgOdjCVMbqFoaG2dIyFZu+dTVN/rFTJH1t+qU1U+axosqNXKzte9dWNS4/45lpQuJtCg6OoX8BMShjcW+ZbeusUZsgUYGQ26E1ylLQJEfnA0ZOm96y4T1VfqphhCSvYVaqnyOl35JqBWa994TIpJhcZ0RrzYNHJQ==
Received-SPF: pass client-ip=57.103.76.31;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


