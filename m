Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA55C2A08F
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkGC-00037X-CE; Fri, 16 Jan 2026 08:53:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkG3-00030a-7l
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:59 -0500
Received: from ci-2003a-snip4-3.eps.apple.com ([57.103.91.134]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkG1-00025u-Tp
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:58 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 9545118007C8; Fri, 16 Jan 2026 13:52:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=hV2Yybxjg6na+16RP+CDNexXZ22gE/2/GrNlo4/7dxE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=goA/VrHNJqtb0hPhjjJ9bid4L7ThJWQ4dFPg0CLJ8DSG5+H8iUNBxrWwv2NpxVVvh2CLuEzzfrJ5gt4CboDvJe9vY2lMc669Mz0kezoz3WylXiTkXK370Acv7I1uyjCap+J7mZIoPVqQs3e/rP8RD6eGpQJ2mlM4bGiYbS3fPgPA7OUOXF+eQ7dyKEVsJYuXRkbXNYqM1WJnEDJ9Wavzcj0NyVJlpyGK9eQZ6lQeqfU/K21h0jluCjv5Ydwwgu+e5hV0IBIs1HDAA89OpD7nTOts/MovdTYOOEoepQS3/2vSwTMIvsq6kCzLPF4sORPYsz5ya0r65tOsPMBJoISW5w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 E5C93180F919; Fri, 16 Jan 2026 13:52:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v16 05/26] tests: data: update AArch64 ACPI tables
Date: Fri, 16 Jan 2026 14:52:14 +0100
Message-ID: <20260116135235.38092-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=CcEFJbrl c=1 sm=1 tr=0 ts=696a42b7
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=CvHhVyPyXxbOnLnphYAA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: hzy6tkvpEy03wEEz8foc-GlIQmQnRivM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfXwdWLn31HOdMc
 HkNIkTdGd8vAFIu26ExPTkxmBGuNMJpTfnZG8yZOdJVoS6lXGOuJVPyD46HU2B8nRI6L8zGX3b4
 9hjG7M79GBEG9vNs5v7hMFOFTICkDYcuG7DxsAy1ev37fqsPHi/Ng75OalUNHqqArwY4ZUZw+IR
 5EZ6dioZe//bednEkqQUBvMlbvDQRqhoij1iUJv0m71xB0OWice4gNU1iQM5lVzks7gGjgLFfo4
 QSlPcwb+aaOj6V+yiaS2Beuj2NI8ZE8rIln6fg3m2w4wvgCgHoMgFjHIz0ekwZZVvEwKPUVSq5y
 uV4hcLLCebb7csUYAj3
X-Proofpoint-ORIG-GUID: hzy6tkvpEy03wEEz8foc-GlIQmQnRivM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1030 adultscore=0
 mlxlogscore=940 mlxscore=0 malwarescore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2601160097
X-JNJ: AAAAAAABu9enEF+Qt7j9jJxZSqqo88jIIb8cyXo1sV9VkN2qXdMKuE8n0ebgwxVsFQ1RsZChWflRVxOcbQ7ygMM36K0WffoHyndeAOJX6SK7XP3jfK33chAnK8didcr92VGLMGMMcWSHrYpdvsNqzBnO9nf3IsdVErJXnmRdKC/BODSzL7GYDmPvOGWloWsVLY8pPBXeYWxn1v0Lg8YDRmqiCA6x+xmfP0+OQgaGtAMW6nd6PXjlU9DQaqo9HEmhzTF+ttG2Ks4muW01ITV3RYCaL6eNoKJ81q65YilalQUlXxV6L1l1ZM1OdhoGyCpYv9E5SS97xgD0JbUiWXvpkUOB+SBlKGnRlZbBuBybALfJ5utpk2QUWEQKpv6BUs0WehBXQeoW5mwS/v6BMbkOInLrvPkBRiXKG8PTERcIVlkaZmf2tx1io+ZVHyREufSu+h3PNzndj24EMJn8rEtWf/HsxhTXJd/nhWvd/Kc/NMeJmuE6dXvKbtLoyXVniVLVeuogfv7WgMNEPzdV4rTbVwZVyvPmTF/LiLGU1nlmEgzJQaaBIeOSDJ5NtlVeWD6iTjgJhZyOwlhWMo4c3A6jbOp0h+uBpKpuIoRnXcuVnhWTB2ZI/4lXaGJ482AvLmEn0jcRBbTdhC8pQAIAPycuEFFFY111nejFCG3SKVyvT2xbfYg61NgIfl+dpNU9pF4HMQocN13pa/Ijk8SBUgLoyEYzdis37k6VrirSM7CayWBhRnNsm+HjsEbk4L4UcdZMRJBsP1IkF/nC+8RmFMyjT5Wo8cpS6yCgBxioSyPxbFJtUytV0LiT2OyNvVrgwF//u+Q=
Received-SPF: pass client-ip=57.103.91.134;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI table for the its=off case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/data/acpi/aarch64/virt/APIC.its_off   | Bin 164 -> 188 bytes
 tests/qtest/bios-tables-test-allowed-diff.h |   1 -
 2 files changed, 1 deletion(-)

diff --git a/tests/data/acpi/aarch64/virt/APIC.its_off b/tests/data/acpi/aarch64/virt/APIC.its_off
index 6130cb7d07103b326feb4dcd7034f85808bebadf..16a01a17c0af605daf64f3cd2de3572be9e60cab 100644
GIT binary patch
delta 43
qcmZ3&xQCI;F~HM#4+8@Oi@`*$SrWVwKqeS4aeydBAa-B~U;qHCpaq8j

delta 18
ZcmdnPxP+0*F~HM#2?GNI3&%vRSpY3v1aANU

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index bfc4d60124..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,2 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


