Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D17EB28F7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 04:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpf7S-0000wt-Qw; Mon, 09 Feb 2026 23:12:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpf7Q-0000wV-UT
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 23:12:56 -0500
Received: from p-west2-cluster2-host8-snip4-5.eps.apple.com ([57.103.68.136]
 helo=outbound.mr.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vpf7P-0003NA-FI
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 23:12:56 -0500
Received: from outbound.mr.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPS id
 78C3F180012E; Tue, 10 Feb 2026 04:12:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1770696774; x=1773288774;
 bh=njzJ9wUHAPg1tBSZalgmmVeq+LjKUODnPNIHHRfC+OE=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=JH6YFYqp3b9IK6+2ywYbheEdnOcjY+C0CEdRxAhjHZEQfJ77GSp866hiY6DhHxQnd1lcWg+P5nUYqTB2uHsir0KSsJ6+bMAzLczLuGoWQ2jR7TJ/buN8et7CI+/cCN2vPA3u8nVTjsrrgJaLpiQANSg+cSqgdRZ3RwVD13Kub0UvW7QFdFTM7gJBNEBKl79S0lU4KC7PTiBcFtTTcz6kFLn7gbcDFL6nVYm8ROsEHn/Exfm566IPuj4V4PiDH0f8oCohNbtYYzxolnGfE3uefxsX6B8kRctBdSSzD/WGamzikmA1rLR2+nZOIYrmjyKEC1s89viSzCGfaF4hksG7DA==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.152.38])
 by p00-icloudmta-asmtp-us-west-2a-100-percent-4 (Postfix) with ESMTPSA id
 6DC4918000BF; Tue, 10 Feb 2026 04:12:51 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v2 1/1] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
Date: Tue, 10 Feb 2026 05:12:48 +0100
Message-ID: <20260210041248.14701-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDAzMiBTYWx0ZWRfXwoeJyFc1Eqj9
 Z8CQeJb73onDewS0xK0Eq9r+OU0JO73M9dm53lUQPVpPyh6rMQuIVueL6H3HDBtG+YqCtOFOSGc
 N25GiVTBit5G7uG+OAOwzrvue00EksDwuUL8CzQTcOLInLZdzLbyBIRxnB5tOOYpa8QwrXeFCSr
 XFx5GmFv5dVg/LO+QR7qZN2Hv1kFpaixiUzNIiLwy4DE9QQBYSa5qj5ywkd4F9XeiPjfuGlpWXw
 OmOHrNBSPrV9JJaI+Lr4WwWNb99oxLqM0Bk7SH6euV5Z+7ALQc3WeYuJ1oEHp9IZDGsmytHu/yG
 Vxp1Zp9TeLmL+RlU6UV72jKhLk7QiMu6tHc+yIUJSLCU+ep8KpGklkvCZnLPWI=
X-Proofpoint-GUID: KmMtNCcW1dPo63cQF4aHBwu7pbZKVYIL
X-Proofpoint-ORIG-GUID: KmMtNCcW1dPo63cQF4aHBwu7pbZKVYIL
X-Authority-Info-Out: v=2.4 cv=UbtciaSN c=1 sm=1 tr=0 ts=698ab045
 cx=c_apl:c_apl_out:c_pps a=9OgfyREA4BUYbbCgc0Y0oA==:117
 a=9OgfyREA4BUYbbCgc0Y0oA==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=K2bY9NqGHFJrVadhDOsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-09_01,2026-02-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 clxscore=1030 adultscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602100032
X-JNJ: AAAAAAABfY1JzoZZ/oGidbSU8KUycHoAkmKk79pv6omfalPS6+JVAqwiYOpZJXDruNpTJ43nKRfJ4JBym7zfBVNx1YJDKVn5bCrIhinaWy5nEUQiKPHUt5sdZ4iOW6R8NLEFpucWfccP2ILZ1WJBGwvwnS9BtL87UM5Jn+PCwtyjohJGemJhn+D1rqa7i7GRYrdHQyK0oO/ilCZYXkWGHlzj9yJRHEqfGL/L+JPxqtdPfoanZ7bUHNYELQr1maeyZBwilGcpp++IAermwOYgeV80piqyw7kCG2eNIWderB16VuqDDd0RMP/BbkRUzRWxwY3Dy6GER39HxZzxGVlUfSSlgQJdpdngeL/jUQ4wF3xd/zZe1d/Z2zkTJVFzdvXidgriHM9lyD72+lEuudaeDM+0zddXaDKz8sPLtBozbSO9mAbwjYajDaMjOFE0JVq7ldhNISwUiyrgtNaPA0RYt7vUBVEX4OkYU/IAHK/0aM5YCbOCefu6iBGI4RPXlXV2clCh0tT/KbtUApyyX2jopmzKLD8M39JJdVcAvLef67lNLoqZpYd88S0+BvyKhPKMC7W/bXYxbvxFcdxoV8PI54YTiYXH94H3zgCbG6QtVSRpZxSB5px5/dRURQNsFlTPl7Epy2/VmNHGVjaQjv1kRViUJTqt7ySsgRzSZkunX9JQaOQwuKDukzQTpSJ67zp3uEMt1Et29wrsfw==
Received-SPF: pass client-ip=57.103.68.136;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.mr.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

/usr/bin/bash isn't guaranteed to be present. Switch
to /usr/bin/env bash.

Rename disassemle to disassemble in the same commit.

Adapt the correponding message in rebuild-expected-aml.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 tests/data/acpi/{disassemle-aml.sh => disassemble-aml.sh} | 4 ++--
 tests/data/acpi/rebuild-expected-aml.sh                   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename tests/data/acpi/{disassemle-aml.sh => disassemble-aml.sh} (92%)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemble-aml.sh
similarity index 92%
rename from tests/data/acpi/disassemle-aml.sh
rename to tests/data/acpi/disassemble-aml.sh
index 89561d233d..62e1991ace 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemble-aml.sh
@@ -1,4 +1,4 @@
-#!/usr/bin/bash
+#!/usr/bin/env bash
 
 outdir=
 while getopts "o:" arg; do
@@ -7,7 +7,7 @@ while getopts "o:" arg; do
         outdir=$OPTARG
         ;;
     \? )
-        echo "Usage: ./tests/data/acpi/disassemle-aml.sh [-o <output-directory>]"
+        echo "Usage: ./tests/data/acpi/disassemble-aml.sh [-o <output-directory>]"
         exit 1
         ;;
 
diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
index cbf9ffe0dd..af45cf3007 100755
--- a/tests/data/acpi/rebuild-expected-aml.sh
+++ b/tests/data/acpi/rebuild-expected-aml.sh
@@ -57,7 +57,7 @@ old_allowed_dif=`grep -v -e 'List of comma-separated changed AML files to ignore
 echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
 
 echo "The files were rebuilt and can be added to git."
-echo "You can use ${SRC_PATH}/tests/data/acpi/disassemle-aml.sh to disassemble them to ASL."
+echo "You can use ${SRC_PATH}/tests/data/acpi/disassemble-aml.sh to disassemble them to ASL."
 
 if [ -z "$old_allowed_dif" ]; then
     echo "Note! Please do not commit expected files with source changes"
-- 
2.50.1 (Apple Git-155)


