Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8A0C10A62D2
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:52:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5l7L-000286-TS; Thu, 26 Mar 2026 09:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5l7I-00025Y-J7
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:51:20 -0400
Received: from p-west1-cluster5-host1-snip4-10.eps.apple.com ([57.103.66.181]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w5l7G-00056h-0b
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 09:51:19 -0400
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPS id
 7BE8A180027A; Thu, 26 Mar 2026 13:51:14 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1774533075; x=1777125075;
 bh=aSSOgTeQRfGOn3tHCGwqYT9ZyEZxiCnj8df7DHyniaM=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=OQewIG4vueSxhtGECjOqImcWuWjzaqje4eif7JNS9x+epP+JzDUWRTXxJo+MrU12b6f3iMQdznyEnLH2IXcE65K74rRX+EfIw1LHmsmtEJv6HF8W7L+7K3hTHj9lLLL0rmW91D1xO2PODd6qdgyfRO6xzy8MLFeQnMa0uETCaVUYckd0RwzB5m9MnsaBhBkyguJXQ0aO3r3RVSTrZ7hoNBgxKGN5vOGYusxTxwrtCKueABVTK2U97v/bYIPvp4vbZRMEySLmAr3qvUh+YaKf5eNdvXxeCep1BVI/tESebx5YVhLiT+BdqfururfNJiECbnyfnRJ9NVo2xaKssuf/cA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-100-percent-8 (Postfix) with ESMTPSA id
 E2D0D180013C; Thu, 26 Mar 2026 13:51:12 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] docs: add WHPX section with initial info
Date: Thu, 26 Mar 2026 14:51:09 +0100
Message-ID: <20260326135109.67394-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=FrEIPmrq c=1 sm=1 tr=0 ts=69c539d2
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yMhMjlubAAAA:8 a=rT9Fg11GqzwndlhJ3T4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA5NyBTYWx0ZWRfX1FpHmnOfBlBp
 vDa9G2CNgZrOnTwtnPTgT2OH9k+sD1PSqc04csKJpQ3DKSDSFurtzmzqL2fH1PEHO92gqyoGSkG
 ZQ/cOwrNEkEqSW7jdlteLVvySh3CtlcxiUwbpj/TmhaI+ChOIKEQW8WjaN8qTm6nsJPWZ24bDXC
 nAybAqQVYB768L3a/VgcTCKrr1ONesVUW++r2/I68qSG6Qk/xwM8J+Ykom8rNoF1Ax0h2SD4llP
 +h9DNSaBprWucW1csDyB5Lzi0gPGDnrQPTkKEXzvvrkYjT7hm1+GIUCUyoYXeKPX3a+vhtBU/lV
 Egrfki6k9ks5xHoBVw7P14H0HuJYHUw6iqzhkrdu+DlOpWUaVIhdvH9MSq4kcs=
X-Proofpoint-GUID: cHrx5ZHh_taN1u4-_UYABLjI3egdm9X9
X-Proofpoint-ORIG-GUID: cHrx5ZHh_taN1u4-_UYABLjI3egdm9X9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1030
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603260097
Received-SPF: pass client-ip=57.103.66.181;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS           |  1 +
 docs/system/index.rst |  1 +
 docs/system/whpx.rst  | 83 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100644 docs/system/whpx.rst

diff --git a/MAINTAINERS b/MAINTAINERS
index cd8ba14450..eb7132e39d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -582,6 +582,7 @@ F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
 F: include/system/whpx-common.h
 F: include/system/whpx-internal.h
+F: docs/system/whpx.rst
 
 MSHV
 M: Magnus Kulke <magnuskulke@linux.microsoft.com>
diff --git a/docs/system/index.rst b/docs/system/index.rst
index bb948e2993..4509630fa4 100644
--- a/docs/system/index.rst
+++ b/docs/system/index.rst
@@ -40,6 +40,7 @@ or Hypervisor.Framework.
    confidential-guest-support
    igvm
    nitro
+   whpx
    vm-templating
    sriov
    qemu-colo
diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
new file mode 100644
index 0000000000..a3a7ecd38f
--- /dev/null
+++ b/docs/system/whpx.rst
@@ -0,0 +1,83 @@
+Windows Hypervisor Platform
+===========================
+
+Common
+------
+
+Windows Hypervisor Platform is available for installation through
+Windows Features (`optionalfeatures.exe`).
+
+VM state save/restore is not implemented.
+
+Known issues on x86_64
+----------------------
+
+Guests using legacy VGA modes
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+In guests using VGA modes that QEMU doesn't pass through framebuffer
+memory for, performance will be quite suboptimal.
+
+Workaround: for affected guests, use a more modern graphics mode.
+Alternatively, use TCG to run those guests.
+
+`-M isapc`
+^^^^^^^^^^
+
+`-M isapc` doesn't disable the Hyper-V LAPIC on its own yet. To
+be able to use that machine, use `-accel whpx,hyperv=off,kernel-irqchip=off`.
+
+However, in QEMU 11.0, the guest will still be a 64-bit x86
+ISA machine with all the corresponding CPUID leaves exposed.
+
+gdbstub
+^^^^^^^
+
+As save/restore of xsave state is not currently present, state
+exposed through GDB will be incomplete.
+
+The same also applies to `info registers`.
+
+-cpu `type` ignored
+^^^^^^^^^^^^^^^^^^^
+
+In this release, -cpu is an ignored argument. 
+
+PIC interrupts on Windows 10
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+QEMU's Windows Hypervisor Platform backend is tested starting from
+Windows 10 version 2004. Earlier Windows 10 releases *might* work
+but are not tested.
+
+On Windows 10, a legacy PIC interrupt injected does not wake the guest
+from an HLT when using the Hyper-V provided interrupt controller.
+
+This has been addressed in QEMU 11.0 on Windows 11 platforms but
+functionality to make it available on Windows 10 isn't present.
+
+Workaround: for affected use cases, use -M kernel-irqchip=off.
+
+Known issues on Windows 11
+^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Nested virtualisation-specific Hyper-V enlightenments are not
+currently exposed.
+
+arm64
+-----
+
+OS baseline
+^^^^^^^^^^^
+
+On Windows 11, Windows 11 24H2 with the April 2025 optional updates
+or May 2025 security updates is the minimum required release. 
+
+Prior releases of Windows 11 version 24H2 shipped with a pre-release
+version of the Windows Hypervisor Platform API, which is not 
+supported in QEMU.
+
+ISA feature support
+^^^^^^^^^^^^^^^^^^^
+
+SVE and SME are not currently supported.
-- 
2.50.1 (Apple Git-155)


