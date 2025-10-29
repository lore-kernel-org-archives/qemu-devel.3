Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D575DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA5U-0003ZH-G4; Wed, 29 Oct 2025 13:35:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5Q-0003Wu-3P
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:52 -0400
Received: from p-east2-cluster1-host10-snip4-10.eps.apple.com ([57.103.76.123]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5E-0003JY-Bc
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:35:51 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 323C71821F70; Wed, 29 Oct 2025 17:35:20 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=RXA040iNMR9mhe6xWo+BYg3EsWEgVsAscx3Np9uc90SMa/wXzxaQWnrNH8Ucusoi1D09pSQ5NAwrjr0nd90IB368L8/Jqt1bm4uQm7X66HvsHx114mV3oULhxFTG6lEOkBgv3Tsva8Z87px21AvBJiNf5ELnKUFUDRhV52ddms0zpNRPoX1nESmcCv4i+i0bSeawWkwtl9qaukl0eQvjCGLtRyLQM71n9hGvKoJD3Nu1zzcMNAymPhwMy8LrxPBZThMgqSMmpM0cP7pKKX6BBr6gfOtbvPVWrAu9SGe2U6bWDI6dw5YLWzBk3iqUL9A1lrZlZHA63M+mRGmr/qJEhw==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 CAE8E180C460; Wed, 29 Oct 2025 16:55:24 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 05/28] tests: data: update AArch64 ACPI tables
Date: Wed, 29 Oct 2025 17:54:47 +0100
Message-ID: <20251029165510.45824-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UcrQvaXpqse_96mAUSlS8lDmIMMyg1aB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX+S8CLRJeU8fp
 E6vJTQBT/h3KLOxb6jQNETL2EzEnkg31t8uJT3Mut5+J+XIH/qsVsZlmMex5e6NTWZIZejhFalc
 FEv5LdNW/fGjrPDvNcpGfbtmkxloH7rOYVKMsIskhqttJ7mTOyslXlabMlwFwyejLGcjqwEh+3I
 IIIh0PCriaYJNQe7b8eDSVshH5OkncVvK1s+JLSm/nur84CRYoSvpFuLp1/mqCVVe7tEWuDbykv
 qwAMzARu1lSOzfx4mTqro+iBjcWEMrgSmYeWtQVvDwILE7BZBg91wwlNa2duS+UHuqrSTFKYI=
X-Proofpoint-ORIG-GUID: UcrQvaXpqse_96mAUSlS8lDmIMMyg1aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1030 phishscore=0
 mlxlogscore=723 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABhw7wmrWWSVFddaSHDKGI3UZK4G6cM3DURXcUk+XcP8h34Dvlw2oNkO1uW9qh4BwKHim7/0ORJjkVbgbPAwmcJBew9kFLxfFVfBxQPSSVjC8tL0zU09wj758OP5hhEzZGvJQ2s69h+kw2QyI19UxrVCNx1M0PmEplAbYocHHG5xQJ8JxNwT6lv+1vEFJJFU2OqAIYRmI7Vv3ECO6Wzdng+bnLxLqvKTOtz+wGlasFpguYxKVr08bfTSoaSUmAd5bPsHR9TOd4yTXU1IjJmpfq6yBw+xQ8YLH1LqP/2uXSOmkjFkSs6YqAgpSMrHkVKUdcpOoR+iIS8p8BiXP/xBxdVcYGS76w5faeMikNa19xcBC3a7YlYPFxiKa0vfBOPb2uYJFXBfAVUk7vPxbsu4n1wCGqq8+xb/ZF7xEdlE3Sugs7QWUcb4dp68EBezETX3tYI+jPyrlqGrWV9VDh42Y+9hN2Y+CaeFN+ufOeAMXr/fqZVanS5V8Ni9xZ3kCtNot0naHqMvrq7eDJ/lpqmxN+9TbBGI2SiwjrpSBRbbLbyqYIKOH0qp4I2CymCBjLLVzCFx/RpuaaxwWjziFpLFY62eLjzR8mdyk5PZpIqQzQimeqeOT7VHkyIkZjjQESdLrAOG71QFyGz75XVK6Kqz3mlkkigFZNPLf+AlmsvVnDHuwKZRAy/2fuvWpTLrZw/V5BA5sUG4/k+lX5mJK6T798sqek0uRPjlXIZv+zLZB3oEnW2vmZVl1kVrT/XbU=
Received-SPF: pass client-ip=57.103.76.123;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


