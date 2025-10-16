Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E7FCCCD19F
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9UTH-0005cQ-9P; Thu, 16 Oct 2025 16:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT9-0005YX-Sm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:05 -0400
Received: from npq-east2-cluster1-host3-snip4-5.eps.apple.com ([57.103.77.8]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1v9UT7-0000xN-SI
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:21:03 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPS id
 DBF4D18005CF; Thu, 16 Oct 2025 20:20:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=lE935EhSo6eiiRGBTf1TCzdO8HBh375WWDyS664DB/c=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=VI+QKRY7tTRBbfHlDHbsS/qeVSlFz9XFpdpqGTtxrz+J3nANUWS++XLHsy+NejuOHKDf/IQ2oxYG1Jiwq77/uqAUXPdRI6jbm4QmRoZyvbZ9B20CeZwWhcc+2RhwIzPPMEWyq589CiaHNVbNtA6LGuP4dvtuzJNyyWIX0AoY+UB2p3V/32A2cM8gJDWHe1MBPrk6sfBDrE5jftX098BuzMqlj13Ati+v4IJGzLbsWdlMGb+4tZZR/oSKiro1b2zF+J/GkYxCBNgsvB/1jDGO+V0bIgUf960lWTberEtfmVydDQNc5jRfqO0eXFad/JFehOKTFOftAaCDBzBVwTwdpw==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-2 (Postfix) with ESMTPSA id
 E4DA318003B7; Thu, 16 Oct 2025 20:20:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v9 03/24] qtest: hw/arm: virt: skip ACPI test for ITS off
Date: Thu, 16 Oct 2025 22:20:23 +0200
Message-ID: <20251016202044.75261-4-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251016202044.75261-1-mohamed@unpredictable.fr>
References: <20251016202044.75261-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE1MSBTYWx0ZWRfXw32Lqs5USGIF
 dzxGdtEQsy5ycIGxSceUtisxCaszzSvysBfZy14gBG7r92d+hnOq9S6Ri07T1r5qO4qsW9fjcvG
 5m40ZNl+uo0+QClyQ6PrO5aay9zR8ayg3kQ0+44//cDNUFbDm4X3Dfxbjm//XxYu53a09hrn6v0
 oDb/H5NMvzIAIMECyU109qaC8bGCg7DdAg2SuxJ+20/VceCqRlX4pace4fmRfn6uRMVy7bp4lu1
 tRHfSNZEDBwJWCDGlvdk/blsVu2Dj8NpXBSd8WckeO2c9eBwH2TYwUr6rT6oDNC+EY7CnB+is=
X-Proofpoint-ORIG-GUID: TiHeTPe14Ik7JfW84-HoT2vCubwP_vV8
X-Proofpoint-GUID: TiHeTPe14Ik7JfW84-HoT2vCubwP_vV8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 clxscore=1030 malwarescore=0
 mlxlogscore=804 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510160151
X-JNJ: AAAAAAABvjPx+7wfHR7qENoe+28Be5v3sqBRDSrFeWD2uTtOt1HH+lIGuzzMvwPY+O1ALGeDosLm3IV9ddujoPhWhUlK8p9GqehMtAWfBqq8rxvk73jbFjbp/qLzqCc0o5nyWCANofLfYZjvc1TXKYxEMJ3g4nR3WuFqBq8tSq+jNC7h4jtLqe2jVN342bVjWc8QYr/A9zZnnyZV+VAh0W3XDeEjrvr5DrsWkSyv8FL1y1itpS0/b4dLEpGG+UItSH68oJ8CqYEztTJU8oYD9PP4OmnBqDkElNoj98avW2K3bq5/ijmV9PmBvO0NSw7llbNZsyVq++C2c01ZWkoILuHyLRywYuAkSigVrHV1O7eEXgiu6venhWDiu2QLRDo/zW/xqpGaQ2BNPC4M7oNMWMNq7SBXG0EIaMc0j5XkeHjpfuS30/ldGS/Eyr8yAw0QWXKLgRRv2zOM5sh7pD2ctCpGKxi4HX1NWQ4q/ZIS/ZOrN+udvVAny1tOwY5x1PGRex6I6UueLAnitFdWFip8l7fB7Yhc09iJMTLV2VH3vmcYkyfoecrWw05FRne52fLTUVx8WCtR6y3Yly3YzFPleor44FTumyeH76qsXUfRm4pYaTBwsrOVhMRhS8Bu/2Ius7UOA+F9IL4HhPVsiMbo1cLN+DgGu25DLN9RumxbSSZ4L6AuVet8lsTRG0+TcM4=
Received-SPF: pass client-ip=57.103.77.8;
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


