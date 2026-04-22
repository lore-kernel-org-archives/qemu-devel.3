Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2796F9B5F3
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 21:47:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFfMO-0000YA-P0; Wed, 22 Apr 2026 17:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMI-0000Ds-DI
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:47 -0400
Received: from p-east2-cluster5-host9-snip4-3.eps.apple.com ([57.103.79.106]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1wFfMG-0007qX-As
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 17:43:46 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPS id
 AD5A61800230; Wed, 22 Apr 2026 21:43:39 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQFIHV8DWRxBAUkdXw9LVxQEFVwFVgZXFHkNXR1FDlYZWgxSD1sOHBZLWFUJCgZdGFgVVgl3HlwASx1XBFQfUxJVHR0LRUtAEwRJAU1fDl4fBBdGGVUERx5dVkAZGQJRHFYNV0NUBF9QSQxBUGxaAEcXSB1dGVlvUF0cDhhZG0AVXRFQGVYJXhUXHkFNWgJWTQVKA18BWwZCC0oCWQVZB14LSgdfGlgKXVQXWwxaDlYwTBZDH1IPWxNNGVEBUkVUAgdYRxRHDg8TTAtHAlo0Vh9UGVoD
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1776894223; x=1779486223;
 bh=v+52HVYpW3INL47PWIYPp5HJAsIPBwIJXcoInsCco2s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=XOEMsno30+UadhseLMaCSNHJN6nm+lMKkFKF5wJgRE8e7PLB6HRWyWQye/Pw/YhdQf3hop4on2TIYn4WpN0Khb/IyTWklTIxMMbfpDHewDO2K3V8eHCpGlywwd6XlyjOLfpgh7t+cUJpZOc9Y7HrwVqVnZCQmy7TLD12JhQiJKHzlva07K9p8vWJIi23rEXd/eyKqKPDY6hIfBfELTQXOlFJWJCV4NGX87JQOFkiCX3evS1nlc+4SmnALDdFfHbzdhftgajqUeeLop1vJt8p8L1Vc/LVcFT89fqxCpGj/ewEouwGL1F3ukCRxiPXAot77oT3TdrPKcj8KAA5+W1mIw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-100-percent-1 (Postfix) with ESMTPSA id
 0752D18000C7; Wed, 22 Apr 2026 21:43:36 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 37/37] whpx: i386: documentation update
Date: Wed, 22 Apr 2026 23:42:25 +0200
Message-ID: <20260422214225.2242-38-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260422214225.2242-1-mohamed@unpredictable.fr>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=c92mgB9l c=1 sm=1 tr=0 ts=69e9410d
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ktjdnHLW_yDM15NnqX0A:9
X-Proofpoint-GUID: h1_NzvU4zbmdvpYXRrvfGPpUCTNM7nO9
X-Proofpoint-ORIG-GUID: h1_NzvU4zbmdvpYXRrvfGPpUCTNM7nO9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDIxMiBTYWx0ZWRfXzz5wZ0F/EjOv
 R5iV3DeWWu5n3MbRQm3DxOmPWBc0uqDnohJejrLnkcPQkvykSThIR5kbY0/HH09pbsNDeoEx1yv
 7dnl5DuicAvtXF1qbxNwbT0DtC/bL/CyDpR7Y2cCMsqZNn6kTNh7nefJ0nwz3EQGYJ7d2X+FjJh
 jlu8dwAZXmh/hIrAyhQdsXmWAukJFRhqVnvca8ZK6/UQp8+OYKDooo7F2eADJPIWk4tlAU3u5j3
 TyYnx3WE/egoZzlKU6423mn6OPGR4R/Zez94EJV+tK7tIqbLNg90P3uAuREpUYbWa9U25Rhh2Qw
 iZUBu6pIks97PncjwCbs00ChuUfcTITYgk3NB3cCCc4qJCcRqdTWsSQiTfTCMk=
Received-SPF: pass client-ip=57.103.79.106;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 docs/system/whpx.rst | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/docs/system/whpx.rst b/docs/system/whpx.rst
index 3e1979028c..9909e86831 100644
--- a/docs/system/whpx.rst
+++ b/docs/system/whpx.rst
@@ -63,7 +63,7 @@ additional functionality compared to ``-device ramfb``, but is
 incompatible with Windows's UEFI GOP implementation, which
 expects a linear framebuffer to be available.
 
-Some tracing options
+Accelerator options
 --------------------
 
 x86_64
@@ -75,6 +75,11 @@ to undocumented MSRs.
 ``-d invalid_mem`` allows to trace accesses to unmapped
 GPAs.
 
+``-accel whpx,ssd=off`` disables the separate security domain feature,
+as in a BTB flush when entering/exiting the guest. This results in a
+significant MMIO performance increase at the detriment of security
+mitigations.
+
 Known issues on x86_64
 ----------------------
 
@@ -96,45 +101,22 @@ MMX, SSE or AVX instructions for access to MMIO memory ranges.
 Attempts to run such guests will result in an ``Unimplemented handler``
 warning for MMX and a failure to decode for newer instructions.
 
-``-M isapc``
-^^^^^^^^^^^^
-
-``-M isapc`` doesn't disable the Hyper-V LAPIC on its own yet. To
-be able to use that machine, use ``-accel whpx,hyperv=off,kernel-irqchip=off``.
-
-However, in QEMU 11.0, the guest will still be a 64-bit x86
-ISA machine with all the corresponding CPUID leaves exposed.
-
-gdbstub
-^^^^^^^
-
-As save/restore of xsave state is not currently present, state
-exposed through GDB will be incomplete.
-
-The same also applies to ``info registers``.
-
-``-cpu type`` ignored
-^^^^^^^^^^^^^^^^^^^^^
-
-In this release, -cpu is an ignored argument. 
-
 PIC interrupts on Windows 10
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 On Windows 10, a legacy PIC interrupt injected does not wake the guest
 from an HLT when using the Hyper-V provided interrupt controller.
 
-This has been addressed in QEMU 11.0 on Windows 11 platforms but
-functionality to make it available on Windows 10 isn't present.
+As such, on Windows 10, using the Hyper-V interrupt controller is
+disabled by default. You can enable it via ``-M q35,pic=off`` which
+disables the PIC. In that configuration, using a UEFI is recommended.
 
-Workaround: for affected use cases, use ``-M kernel-irqchip=off``.
+On this release, ``-M kernel-irqchip=`` is not expected to be manually
+set during normal operation. It remains as a debugging option.
 
 Known issues on Windows 11
 ^^^^^^^^^^^^^^^^^^^^^^^^^^
 
-Nested virtualisation-specific Hyper-V enlightenments are not
-currently exposed.
-
 arm64
 -----
 
-- 
2.50.1 (Apple Git-155)


