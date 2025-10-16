Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFC2CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTE-0005b8-84; Thu, 16 Oct 2025 16:21:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UTB-0005Yq-AJ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:05 -0400
Received: from p-east2-cluster5-host6-snip4-10.eps.apple.com ([57.103.79.103]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT9-0000yL-LK
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:05 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 E55201800114; Thu, 16 Oct 2025 20:21:01 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JHs9tgo93eATWNsHn+YI668vpltR9xHudkA+Ock8FsP0/7fZHFCN+T0Tu2XesnTFVBxZdcN7L9N5DuUrrnJ5zAMT1zmdp+sqD2fSPDyNQJQYQvqdpvB/m0cu6BPf4SZhCMY0fdOtUN5rZDFew2DJra6anEzFdyv9wdyjrDibDjSAiwEhDRS1s2+A/qFyIBXI7nh+zs/Et+/pWGslgYgD7HOn9rhovgV7Ae9yZknItJyf5dWcGlNk6Ksw86dYmv/tOG1UrxuoI6AAEpWAOvJ6jd9cAbB6gRwQ8iEY2I0xg0OZ5UeA1tasO9zXK31aNJhvDNPeWEH/Ohz9sq8cxSlaAg==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 ACE2218005F8; Thu, 16 Oct 2025 20:20:55 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v9 05/24] tests: data: update AArch64 ACPI tables
Date: Thu, 16 Oct 2025 22:20:25 +0200
Message-ID: <20251016202044.75261-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BsFx9VL8Fhk6eZmul_YoxKktVTe4jaDK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfX7DpYKe8yQF3f
 JhH7cyKSWrBEZ46iI5KSH4rsl6xNuY+EL2gkFo95j3JrhCzTG70gmSTCh5tdPLAbZcAZ9AYSByi
 YRc7kYmqr3sAzf+ULJbOHaPMhGyAUgqmbR/w1+0tx83IkWaMbZpAIqpwaI9FEmuvODeDhqiLW1Q
 1apNtWeslmSrgPeprLlnCKiJvGfB927UX2si6wCw88mu5MpYJpopIvuz9g+5qMffpOTSYna/nD5
 MvXqOW6aHLzafW35kgP2dYgLqnmnsNEGyxUjCARb3Krsm4bcx6Ld3Rg6LbbrkakPyjwfIVhqE=
X-Proofpoint-GUID: BsFx9VL8Fhk6eZmul_YoxKktVTe4jaDK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxlogscore=822 spamscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABXWIgRRieynIFGXKNUnFacfjDWooqKrVokwXhv7uU7tpkHUoYdACcNHItXCie1sS4Aub7DnGGcXU9OPlyDT4RN+FSpcn3fcy/jOYDze8lqJw2e8Xhf4sWcHDE2L6kGs/AxHJ1TWZK4JPoLUKOmISJ5OMzSWjixlOPPABUZQYaRAnpC63wBOBxIiDp5PSsHQDQAdvRC0sZhWpYU9dxtzmedEy0g9s6Z/UO3c6uLolvyLotna/bWSQrmzTpYZHyLNgMoJwgo9EGNcQ5Wnnzk5RsDvzq7f8PAM420Ly30HbyjgaYDeJ4JPH8ZsrI/SOJZTiPU3Zxb7n0x2ZjawDcj69BTYXeIkCzaGmuSTlPjdiHL5IYWf//4YjJkxXltApgFqcmLSkoDx2+5nLZ1wxhCbYlNzYXaUPP4ro0vyT1WXuxd6IWrGydAloKQrEPajOgjdQGL3GsdM9ipeRV4VmVZA64TmNQyk9NLdXwzgAqETDNzB0vGF8T8PI9or49e0QzOs+AoiYDAmIEXZ+iVQ5JQclzy3Y8Un1pheqr3474JHTdLUz7NwV3R45jCNtqWrgxYROWgv/B9GFCPnzZJAfd9ym7CVUpKGv8qLLkFJqr+baKg6YtCD3VY218h7wtbQy48f/g82VXedfjA4gu5G/kL2bzugtotqqMD181I9ikHHc3yigEsQ==
Received-SPF: pass client-ip=57.103.79.103;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

After the previous commit introducing GICv3 + GICv2m configurations,
update the AArch64 ACPI table for the its=off case.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
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


