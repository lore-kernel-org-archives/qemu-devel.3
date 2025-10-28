Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0766FCCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDtQw-0001qc-SE; Tue, 28 Oct 2025 19:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQs-0001q2-TR
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:55 -0400
Received: from p-east1-cluster5-host5-snip4-2.eps.apple.com ([57.103.89.173]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vDtQd-0004lI-WE
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:48:54 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPS id
 347B718034E3; Tue, 28 Oct 2025 23:48:21 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=9vYko/DI2RK+OqhuWK0dyFWYB5OCgm45PuZW5dC4nJ8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=EbX1PKOhnZzs53BNdId6xPkyvl0UF1+3SBKtMwAsMVJGiMPRp4VVmXVL94bPZ4GOcUmXJJRY+YgcMj0KflBa4U+VuEnrZnHMhlPQVVeqkMlOdQM9i6h9A/PYptNWGheOtylqpVd+qMbOEvCAooPK59N+g9ki1Eej0Dl2ALn/o33qsi/2h/a3QChf4IpNcVYE8xmmkyZR0GbhJylpDUd66b2vOWs3kY1gbW0sptOCuRRUTQH5rU4JDfojGmPqPZy89eGKyPReTm7plENEoYsmtlPegoXdG6oQtmW17HXSuQn/7yxS3pwDBNSCHko6NSgnIj0bmB01futSUWvYWo8AWA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-20-percent-0 (Postfix) with ESMTPSA id
 099A61800E4C; Tue, 28 Oct 2025 23:48:18 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: mohamed@unpredictable.fr,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>
Subject: [PATCH v9 05/27] tests: data: update AArch64 ACPI tables
Date: Wed, 29 Oct 2025 00:47:35 +0100
Message-ID: <20251028234757.39609-6-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251028234757.39609-1-mohamed@unpredictable.fr>
References: <20251028234757.39609-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: plPXHcRqj_UOKnFUaWVyFnIklJCTa_53
X-Authority-Info: v=2.4 cv=CL0nnBrD c=1 sm=1 tr=0 ts=69015646 cx=c_apl:c_pps
 a=2G65uMN5HjSv0sBfM2Yj2w==:117 a=2G65uMN5HjSv0sBfM2Yj2w==:17
 a=x6icFKpwvdMA:10 a=CvHhVyPyXxbOnLnphYAA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: plPXHcRqj_UOKnFUaWVyFnIklJCTa_53
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDIwMiBTYWx0ZWRfX+HN6MdTAHaHw
 zyyqWg6ysi7C+DnV6XgMLTbW5f0PomS/t2qn5LHnAotJW3oYinJMzBGe5XHqR7kc+gxuJ+IcO5v
 fS+jDjm0JrZCZSnxi9d5VyzImMaHuT9cRcrqvLNohgAJ8V5OqCY5pXqT82+dGR6/YQcDXR8GwB6
 7POIiL5VbPr3K/P7dkDsOtRVyJYthrp4FFl76qEBrb+jl1j+vBVtHhnAVjcYedGxHMhWLszBzvP
 LJWwb/6csVz6JESzwKBHgbdFX08ETuoCAZrHqEMpngaqYxkOs+7vR5ze8x0zkE59CFCjQ58fol4
 UcZtMRpiOUO53hvPklX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_09,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 clxscore=1030 suspectscore=0 phishscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=857 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2509250000 definitions=main-2510280202
X-JNJ: AAAAAAABOFqoB2j1WvLvMgZDQnTIkzvKbYInnnTf/51yNrx7+sJf+Dly0HURlP3ICoH8J6KfVBKhMF+umUMyznSfAf81df6s90ikTXdGPrsrWV1/AKOW8tDOM90oWJ0K2Hr1TZPX4OVUGMtSHdbZFo6wHj/jJt/bTsQXZr84/p+gruEiWQMcbXhNQ2rn+rTxXi0Y/kC1nk/XVom8wsTx+s2nF4eb/xvmOXxmU5DuwU1DMwRcSmEhofMKAjdcwjMPKP6cBHv2X+59FTqpLN0a+oBcQV4gSfZWJyeNwksiuD8cVMuXP1y6mx/JtRXjYXMGtI1qb+pkSFuRD8a0fjlQiK8kHyDqE3beGEzlCDRfuP1WX33/veNfzgCtXQNLy2ml2IBFLMKGVR/WR+fp3SlNyQDURhPa8z/fv3aTdnmtksS7zICMo7z0TCAmZ2wK46u9iNCWtYkTg1HizgrGAV9W4JCMbuMywI3uzwdMYQ8EN4F1vU4PyM0l0lgYTS5GTGEEh5iTivzS0v2F6DecstTO/JR79hWHLPzKOHBOciSodx0OtkrsL7QsZ60R6NTBXKJb57XRTIEkkStEhh93SJoWa908ORuGe/Ob3SQRavWu55y4v9OB1poQ+GFmzFAvd1SSTd4guTevsNpoFmL1R/XuEbfeh3BxGIFPYiIx2jlQ0IICqUK2EkOCzPUFw1G1HrIJsWXpsE80wRAdSZIr4I5R+V1E6YJeZZ/0/X8OcPshEhvJhtk7C5cgmWkBISORl7/Y
Received-SPF: pass client-ip=57.103.89.173;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ci.icloud.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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


