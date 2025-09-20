Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6BBCAC5A5
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 14:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzyBV-0007E7-6r; Sat, 20 Sep 2025 10:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBO-0006yC-PV
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:22 -0400
Received: from p-east3-cluster5-host7-snip4-6.eps.apple.com ([57.103.86.197]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1uzyBN-0008Aw-7d
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 10:03:22 -0400
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPS id
 DEA2918170A5; Sat, 20 Sep 2025 14:03:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=6QHLe7sI/ta/TpnlofGbhZSXfY72nxkqv2tu61id1Xw=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Yal54Mo2j/1B9TAxD6hgWtXOuoivd6GsUp5UlECkI1Ozv6iPJNFfADPRumTtZ4CvlZlpNBa1DET98Z1YPij8W9En4/7tLwoyzKm/3oZgMqL2AHz9jkzox23eECMKGJ7F2UmKfV5mdLG3MdyxwpilYwdXGGL76A7iGv/TI2fYzQ0RPBUyRFKwNfHW4PMmuhR7xOIEAkNSXIy0x2NJHaL2zuR7sC3cacvEv4TTrSDy4grI6U15t6zqxGi03uS/EkAu8biN+MrQv5SOtAUoopjT8gGqB8UEupvRPilCp5lLwaqG52/EXMSknMJM05sROdNcbH1z0NrXh3JIAyMzwCYEoA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (qs-asmtp-me-k8s.p00.prod.me.com
 [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-100-percent-3 (Postfix) with ESMTPSA id
 691F71817268; Sat, 20 Sep 2025 14:02:32 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Shannon Zhao <shannon.zhaosl@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 kvm@vger.kernel.org, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v6 22/23] docs: arm: update virt machine model description
Date: Sat, 20 Sep 2025 16:01:23 +0200
Message-ID: <20250920140124.63046-23-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250920140124.63046-1-mohamed@unpredictable.fr>
References: <20250920140124.63046-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ojLL6QodVQ17wDK9HHqj0FwWgh6Q8daA
X-Proofpoint-GUID: ojLL6QodVQ17wDK9HHqj0FwWgh6Q8daA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDEzNiBTYWx0ZWRfX25h+Oy3H7yiS
 yt9rk8Wty6XF48La1pCM3v9VeSEHWEXpAp6eHstyw2qPEoBHEJWJkJukxeJ8RL5rzBtm4jhgvlb
 mNFsLe3F15Y1SHee+YZhYBzAGp37q+yIthkM8R07Swf+Z4Lsm/Dx35pGEOB4whFhYaErp3ALYR2
 0rFLvXXIBAipso3jrQO7F/k2CmaZj616P0JfpjfWjl/vq9ecLKt0YXw/EpNK+4hxByYZ83HLpch
 mC2gS7VlTQE8LW+fqcWJn2M0ayboU33aZwYE7vlKQohTjNFUYYIY8TZrQsEyEA6jgv0tcdQWQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_05,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1030 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2506270000 definitions=main-2509200136
X-JNJ: AAAAAAABzBXNo6aD0xhHNo9zDDLKtbsGIdEu9Jzv0TkCWRLkBC7HbJwcYHwcB7cJdKBi6rFM4zCP286YCrzFBoQDYCRGYSCIS5FuHpcLeFsu5aLATorotIsTuv3e3aDWeuoKokRJw1AZ7e2Ae/8eBbp2YMJE5De1oidpSO3aB4DtyXUGcfsiUaB2ULR1DJ1d94E2ieHzNeTYJW1/KtsA/aaPRTJS8ifZewz+Q5i+WZaw1qHmGsWumTQVWwkR/lNJSX8O6nPrkZWW4M5R0fUJXUshLJ7sFwRjaI4KhrkfrFtLIovtPJG0VoKb7xXFHX2xS0ylGm1pk0zXQ2YeJ0q2qiCq0SFIeivSn6Sti3KnXDXj6igcFy9iirRMe4j1AChxwd5MqXVxsRHnd9rvteZft2kZk0NzFH5WpRsY6/Z7+X4/htMXkaTgi73+/B6pHZZacyS8cEj4fUO5strUtRYL9Ldz6PGyAxYWHUAZSVC8yuCQO/KXEs/dZ0kPF4uLq+0bCXxLFkOy7NDFOp2Xd4+IaVF1fLz4OP77W9BEumjILfNkIehV3b0pbqiZr0i+4D+MTVagYA1Jnd/2loyQsx/b4CmNvpZbvx0vGxTbqc0ztFwDDRlExj2hjlMyoWVeTS6M7BbJxuJHbtXJ2WlPajKEEaBt6vQUIaLeJbX3QiTmThqyH3QkpdWP5/rSDmHeH9RBL9I8flt8Z+zubrVh6s6ZhB7TQ50bk08XEYDig3+zjUd5g5zSlODKPUIkVzWEnhM7ETyf8ye9/YM1A01hWlJok4LiJYicG2jYZi/xJShXP0jJkkV4DSKoZTSDfap3iqUkY8Waf7p6vJSfJiGq6PVGGBB6OvMovwfCJvlq/VYNt/hn72/tAvzzb8oDBcprBl1ESg==
Received-SPF: pass client-ip=57.103.86.197;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


