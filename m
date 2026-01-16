Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD5BDC2A06C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 13:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkG3-0002zk-BE; Fri, 16 Jan 2026 08:52:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFy-0002vc-HW
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:55 -0500
Received: from ci-2003i-snip4-1.eps.apple.com ([57.103.91.212]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vgkFx-00025G-4y
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 08:52:54 -0500
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPS id
 1B7EF18007F2; Fri, 16 Jan 2026 13:52:49 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=btG7LVF4FVUlY/WG1R/l44bepPF3fEaEZCxuJMp9FR57ff0s2dT2WqD3I66cwK9d8LfRcgPrkejwVYud7id7ib/f3mYKe7nVIf6y9y7ZXUTdP+iU5JS5qXw1WBA2E0S1mmq7R7MhbsTND6otbxnm1e6SIfWsBPbwnwPdICgyJ5yqpxAEPT5GDyk5kBaBE58c56JTepjP8PA8wZrzSKc1N7qgTXlV+zr+GMsuI+nYdBeQXCuxKXffp/bZf9DkRZb7EURPP+1G5KbejnuVUXgTKxgmpt/ADe45SMPuzfijCRGlN+h+g0L41nVNAmTcOk3oi2zp1mGvLqcL7vEES00t2w==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-15 (Postfix) with ESMTPSA id
 0B22E1800135; Fri, 16 Jan 2026 13:52:44 +0000 (UTC)
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
Subject: [PATCH v16 03/26] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Fri, 16 Jan 2026 14:52:12 +0100
Message-ID: <20260116135235.38092-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260116135235.38092-1-mohamed@unpredictable.fr>
References: <20260116135235.38092-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA5NyBTYWx0ZWRfX6GBeL6hc2Gvx
 kXvxcCL0aKHnOoMYwZMXgREYEjCit+W0A7aTNzgwKAPOB5ST2PXVwJXGIeUGNU/HKyCZ+nIl8Nj
 rjB7Kzqf8m9fP1tc9U96Gq7yEq3xs32ZN9RLim4YW8yUhCcVW5+kdbGXiSs3f3fvIws4Z9bADeK
 M3uWcS0J+2lq6pDVKZ4yIheHPetGYlu2QMWbv8kB8RXeMHBGKVZFJcymopJd0fBfC/FX7IYLslD
 yJzI1N80Ngg7eLqUl+QPDobaBHqGwnEBXU3+a+J5+vFak+/+yn1ENJ1Wh6QMkHbZl+cBheZqLyW
 z8BnBlLmRFcDIRQVF1t
X-Proofpoint-ORIG-GUID: miGxH8NC2HMg8Ve4b4-v4a0_hOw6CKLC
X-Proofpoint-GUID: miGxH8NC2HMg8Ve4b4-v4a0_hOw6CKLC
X-Authority-Info: v=2.4 cv=QrRTHFyd c=1 sm=1 tr=0 ts=696a42b3
 cx=c_apl:c_apl_out:c_pps a=2G65uMN5HjSv0sBfM2Yj2w==:117
 a=2G65uMN5HjSv0sBfM2Yj2w==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=1t8nasy7xzbR8br5Zw8A:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_05,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=923 bulkscore=0 phishscore=0 malwarescore=0 clxscore=1030
 suspectscore=0 adultscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2601160097
X-JNJ: AAAAAAABtozFUpXpe5Thb+0CDg1zjDkTOsfn7OvPoZrkFr7l6M4Huxds+h+KN4sPwOlJ+RRKnuufrlAhKGnN7WMB4LV53SdON+1BljphTKF2YQIiQFQumdZ7JgP+XRUnSunAIxoeI0T/gdSYHlmfxALs3csMOcr1R6J/4eIlWF3M0f8QMDubCArDAnyotR2c8jfXGucgN8WxgKiO+NBA0++MK16MFTxApLbzUnbCDcjgmG4/72LDG4jpKvmY9OIjc8VGaNB/QJfhpx3xLoyXbcdbaZWF7exEtvmrauB+Q2Lhb7l7htmxH8f1C/thOXew0mAcRxYlq59ZF5rhutCKVswcZ6QRdKiaW/YcdUyjzMN+eFjwJxaG7jmzZnMkLsLIXFq0rtpA1k6sTfC4buevsu6iNdMNrh2f/ZCTljBZM1D+b5k6e31wrYlANvzwkhZAsFtFhG4248m0tqFRHyKCF8IU3iWLeakc1u6YRE/wHUAGAVmGidkhJpsVUdmwISnoHA8kk54IXj9KHZjSf1nWoiKkQPI5eLPI3j0mV76fuQtJ6AqpTCiXzamq2AbEQrbuvgiu21WiJzcTJNsXLaJz6wXQbP4kMRLXJbfRxRxvGaOG8aBv0fglhotwr2+UoyuHRQVxXL5+1oPRvtIPQLc3itP0VNZQ8LYKnZNSda0ivfEfLCPRMZSEdtX3ssrDZbb7PMZnO7XPOu4M+qeDIG5xBDHnyreYUtk3XectmmmZEfUqYj7+CvB1lCPnkTtJXeKtUGoeU+SspJNoK72SvT7y8cROsrFAEW7TU7Rakwp686opHlPfYrU=
Received-SPF: pass client-ip=57.103.91.212;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..bfc4d60124 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,2 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/APIC.its_off",
-- 
2.50.1 (Apple Git-155)


