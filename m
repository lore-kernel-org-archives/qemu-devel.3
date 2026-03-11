Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9E1104BED3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GmF-0002PZ-3J; Wed, 11 Mar 2026 06:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm5-0002IK-C0
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:45 -0400
Received: from ci-2004a-snip4-7.eps.apple.com ([57.103.89.10]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1w0Gm2-0001ml-5b
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:26:45 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPS id
 24BF01800553; Wed, 11 Mar 2026 10:26:32 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1773224795; x=1775816795;
 bh=K3brj/ASNYjHTSBXLo+q7yds8j53cFxDjP5cTMgpO0Y=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=WdKcasV48xKDMp7Yed9TMws6Nfn+bVIfqa0DoWM+e/I3wuO8Yh7fzrDZl9NMYa8QsgMeW7V3EU6a0mmddftgIhdsrYdn3UbBR4cvSjW5EA80X47n2mK71IxFVfJrLGwqeXuti8bVauZTpvM/2gCCdyaXhwxtDOWnmJqGUlTIDRTnxvOnLD1L3LVZT9OGFWi2cxFjFa52rQNlT/74854if+ziYFvniIe7hYf/JIaU+BZYicwReFsJgJXjqGdDp+Xcwneoxjir0gsbqzkJjrkx+9OVbZFhDRmcoPEkShQ7Iw0itlRs0Vrgly3jomREyeFk0kG8KdYZvibMLZ2A6b5ysA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-100-percent-0 (Postfix) with ESMTPSA id
 05CEB1800097; Wed, 11 Mar 2026 10:26:29 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH 1/3] docs: remove 64-bit only mentions for accelerators
Date: Wed, 11 Mar 2026 11:26:24 +0100
Message-ID: <20260311102626.46546-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260311102626.46546-1-mohamed@unpredictable.fr>
References: <20260311102626.46546-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDA4NyBTYWx0ZWRfX/wa8M5LoUYdN
 0EYfkGUzGw2rgsiZ/pZwx/KnImxXH5H9u4kN+4O/Q00a7OjS1gbegZKAPtpL92N2GVbXo7+fhqA
 fLMnqZVaRGBjsWvwMvZc/jFEkj/cizic24KxY50W6Q8BT8jka3meMBG7FT3Tt+GURaBTS0ioyig
 JZO5JMKYjrA4g6S/Er9PVrAyP3cBnry6qkVqggNytGOi2MqJRWqDDWLJqqU1OzlNGRmV/YbDxFD
 oiO1ZeCy44A1dEa3OoF51wPZf9wviffuHTwG9HBb3jQPK7VHSIWbCKoYrRuCPeL+DZSREQaYWsC
 6HTgroNjPJtGDAXU4hUwOFTLPY/E6irX4jCdAR8fKUfQ4dwp8yRataBZ55fE2E=
X-Authority-Info-Out: v=2.4 cv=AeK83nXG c=1 sm=1 tr=0 ts=69b14359
 cx=c_apl:c_pps:t_out a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=areVBzcA72p8uwxwuq8A:9
X-Proofpoint-ORIG-GUID: Fsxb5IePGXM-QHAKD_HgONmWLr7fo7z1
X-Proofpoint-GUID: Fsxb5IePGXM-QHAKD_HgONmWLr7fo7z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=988
 phishscore=0 spamscore=0 malwarescore=0 adultscore=0 clxscore=1030
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603110087
X-JNJ: AAAAAAABLoon0gke3E1xPUNO9P7RyQYVhMJIdELMaaFGQa9l2+1Z8IWXqr705SyJ7f9heBK355ZJ79814YVT7/5pEfeps20xZrMtt+5c14nO5fy1QWZgf8SiaNQ1ZWv24aeaJsUFGnF9QEKLen8XEgUNCyWrb+eTQxk6DG1zZEvd979KUghq3fxK5LebsNu6YflDH4vziubyxBAE9AxByjxzPUFSXaQnUwsc80aFggQ1jSomZE+9x33Q/R7ObiUSl1poU+Dzq/9MSVKWbuBl1UlSCvkm9OAhsHQtIpikWy6xW1yErL28EzRpygShdgwLbh7PPY5bEI11wAqJdizCzjUHwzF8/MHyNBJGhJN8x1cLWfgcp0p2fhqlJOE47wm2uQX5hNmJdc9dBvALT6BEf2TZ79Dk7e1Qp+VOtAOmzPklMoINSxzccpsz8R1vWTttrfGEK+Jct8k7ni/MEUEUkoL4gYjXx+hsj5ga4tQyn9OJLHvI/UvUkPH6pzs9khNvoFcuPly0Og5/1ZZeAcMnH69pHaNtw5Kvqxpy9Z5rbVo3aUhNkxtjKpT8T5XL7HugJvQhANAUiUVjWAeB433FpDiN5i/NsHbhsnWtOUGiF+URu4GMsjNBug==
Received-SPF: pass client-ip=57.103.89.10;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QEMU itself no longer supports 32-bit systems.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 docs/about/build-platforms.rst | 4 ++--
 docs/system/introduction.rst   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.rst
index e95784cdb5..ae138ff0e0 100644
--- a/docs/about/build-platforms.rst
+++ b/docs/about/build-platforms.rst
@@ -43,7 +43,7 @@ Those hosts are officially supported, with various accelerators:
    * - CPU Architecture
      - Accelerators
    * - Arm
-     - hvf (64 bit only), kvm (64 bit only), tcg, xen
+     - hvf, kvm, tcg, xen
    * - PPC
      - kvm, tcg
    * - RISC-V
@@ -53,7 +53,7 @@ Those hosts are officially supported, with various accelerators:
    * - SPARC
      - tcg
    * - x86
-     - hvf (64 bit only), mshv (64 bit only), kvm, nvmm, tcg, whpx (64 bit only), xen
+     - hvf, mshv, kvm, nvmm, tcg, whpx, xen
 
 Other host architectures are not supported. It is possible to build QEMU system
 emulation on an unsupported host architecture using the configure
diff --git a/docs/system/introduction.rst b/docs/system/introduction.rst
index 9c57523b6c..2dfa371e0f 100644
--- a/docs/system/introduction.rst
+++ b/docs/system/introduction.rst
@@ -19,7 +19,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - Host Architectures
   * - KVM
     - Linux
-    - Arm (64 bit only), MIPS, PPC, RISC-V, s390x, x86
+    - Arm, MIPS, PPC, RISC-V, s390x, x86
   * - Xen
     - Linux (as dom0)
     - Arm, x86
@@ -28,7 +28,7 @@ Tiny Code Generator (TCG) capable of emulating many CPUs.
     - x86
   * - Hypervisor Framework (hvf)
     - MacOS
-    - x86 (64 bit only), Arm (64 bit only)
+    - x86, Arm
   * - Windows Hypervisor Platform (whpx)
     - Windows
     - x86
-- 
2.50.1 (Apple Git-155)


