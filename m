Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194EFCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 17:43:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEA6T-0004S4-54; Wed, 29 Oct 2025 13:36:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA64-00044v-72
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:32 -0400
Received: from p-east2-cluster4-host1-snip4-6.eps.apple.com ([57.103.78.157]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vEA5b-0003UE-6J
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 13:36:31 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPS id
 36FAD18270CA; Wed, 29 Oct 2025 17:35:51 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; bh=RQfGDhZ4RUZHZEjwdTSwWBJnMpGjZt55WjAucF76QqE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Og0lpMSAMT6wNRUOD7q7KKlcN4NmvQ5VKPRconC5MGn4v2iYnIQd5SaR1eFjzPUApKfT3dHha8o5aTIwzm/bOwBuE5AbFtXnAbgvwtUeLiPLH8OktuAr7vCi78jRf5Hs8XyjHG525W9HS/jey4IlU5Y76A0hcN6KPvva2yj1Not9xIdvNBKEfiC4ZVizHWn2nPJEhzikFrdHfcW6Gj69EocZ5tTL8I3ZVR5t8XuhTnIdwGAGtH5RPbmQK2ORH7tmS6lDfXFEmfAutKctCioPzjOuukHTk8AbwesFxhK4um9QZfRMELsDIppOWSdQnjSfOKaqNZFbU46Oz13MTH2w0A==
mail-alias-created-date: 1752046281608
Received: from mac.home (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-10 (Postfix) with ESMTPSA id
 935F1182A805; Wed, 29 Oct 2025 16:56:10 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org,
	mohamed@unpredictable.fr
Cc: Pedro Barbuda <pbarbuda@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Alexander Graf <agraf@csgraf.de>, Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v10 25/28] MAINTAINERS: update maintainers for WHPX
Date: Wed, 29 Oct 2025 17:55:07 +0100
Message-ID: <20251029165510.45824-26-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251029165510.45824-1-mohamed@unpredictable.fr>
References: <20251029165510.45824-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: u_BLb492WGui8n-_TSGCe-N85hjru3_9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDE0MCBTYWx0ZWRfX01J0gTkD/B7a
 mR5aE5y2WwmYlVvBfmn2HydI3m7yWzWZvNwLk6ifNRoEL76ADQiJFnuBqe/ZIk/AYSwMpfr4yTP
 FR7WvR0OTLAoxqznPjjJVGstifjIr4Wtcfd2ZwTtin9jxajBr7RZleuLByFh2aXbvX8WdQ6iN1z
 lFP/M8wAqo5Lwtf9KSPg4Yc8kTqtfZ3Xi4pA0EG2lSfhguBxi6Q6A2mhfmrLFDo4CfrSJGc8XDg
 AwwmH3MjPp6QZXGrzN7aWHJoqaA0FykKNQgkCk2edNLRNFNPWSKdduYPr2la6ksJePDH1aPyA=
X-Proofpoint-GUID: u_BLb492WGui8n-_TSGCe-N85hjru3_9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-29_07,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1030
 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=611 malwarescore=0
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2510290140
X-JNJ: AAAAAAABhEdBocgLw5z/lTUEAjHxoDxoYPL38zcwLZuVQDTWY8jHATlSWVc0bdGyylpTpXr4DSDStAjL3Bm72OZsQi4QrhHIBqTCVyMxGAGaCbVnNLgg+YwIzHypYr7Pv5bju1z3hrmxTAFAYCXdTV2FS7bRzOYQYfxCGtsdXNxkZN0T/dRuElEcTIK25xTqqHgT/XjotWCVAeYtVGK9jodt4sxKLxq2IUXDZzAdFOOOT27ZbcWI1UIt/uAV5GgpTZEKdQpuwSKG3U3fm/9v6e0fcEOywW30VXC9tfbqvdAQiQ5PeSNiLB/ciuNspPXBdmsdsg61lFG0KD5OYrcWlt14UlyWRr6Wpr8vgzaSip5uZqgz8fUeZ92UlVJVv1rFVx2+WgsAdXuk4o7NoDXbEJfXWplXehXT2+7HQL+L8fObUksZ+MGzkePbjT3E5MPCzDDjqJl5OiREkLqHiRLpksNxXp0xjXJT+jKseM5vdjqg8aDyvczi5gL0mkZcJctTcuoBxEMpOiF8kE38warwUTagF6W+wUhSPBUQY/ZTnMACRYOuwRDUF1KddY8R77huIOlx657SongoUnxV7zJbbUTQWh4rpvzk12d4J8Fp7aRHQMCVFhVFm0Yl7ohuG1haOMe96cqDEMOGI42lMZBTPJWo2tvZX9+DcSkzHZNjwKYZ/Ys4D5UFioIu0aji6BZOQLpNVzPhsTXLiB6Jn2lzc1ACZynQvLTYOsd2En0Thahca2xrBwIVfC5nORdf
Received-SPF: pass client-ip=57.103.78.157;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

And add arm64 files.

From Pedro Barbuda (on Teams):

> we meant to have that switched a while back. you can add me as the maintainer. Pedro Barbuda (pbarbuda@microsoft.com)

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 MAINTAINERS | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6b7f45459..0e7288116f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -546,11 +546,14 @@ F: accel/stubs/hvf-stub.c
 F: include/system/hvf.h
 F: include/system/hvf_int.h
 
-WHPX CPUs
-M: Sunil Muthuswamy <sunilmut@microsoft.com>
+WHPX
+M: Pedro Barbuda <pbarbuda@microsoft.com>
+M: Mohamed Mediouni <mohamed@unpredictable.fr>
 S: Supported
 F: accel/whpx/
 F: target/i386/whpx/
+F: target/arm/whpx_arm.h
+F: target/arm/whpx/
 F: accel/stubs/whpx-stub.c
 F: include/system/whpx.h
 F: include/system/whpx-accel-ops.h
-- 
2.50.1 (Apple Git-155)


