Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B466D358D6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:40:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlV4E-0007yE-CK; Thu, 29 Jan 2026 11:40:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlV46-0007xP-94
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:19 -0500
Received: from p-west1-cluster1-host8-snip4-5.eps.apple.com ([57.103.64.38]
 helo=outbound.pv.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vlV41-00056B-Ps
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:40:16 -0500
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-13 (Postfix) with ESMTPS id
 314EB18001C2; Thu, 29 Jan 2026 16:40:09 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1769704811; x=1772296811;
 bh=+qvT7gB+SXrQ2xpwOJMPzvbLeotxZkOd8s8m9SD1ihY=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=UAYkNghFndsYw5PNiTP8WyfZoM/IM1p+rwM0+WyHsQc28FzIiUyqAe2tAMdQkKimXTrE1vB+elrPWA1V7zdCNjl53HfLkFVvIah40R7cwQ3aPaQ/1L9vLUdS0v0sy1htnw/cx6GG3BAgK1cUwZ9N3cJ31DcjnUEu78MX5K/47zDtv78ddvFWlx2uRvrmVZGiETS1Fsg8Qzr3mUgW/WCq3OTlnYRix569Dvd9SmP2V72ugXriFNOzQVDsDBY9Xi7x1MAPcS1veFLBoAFPBp4SKBukvjzq3vsX+8lpWwZPIYacqZ3YY4PDpCLG+xGZ9Ag+0ixBSCl+THKSMADKIn16/g==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.56.9.36])
 by p00-icloudmta-asmtp-us-west-1a-60-percent-13 (Postfix) with ESMTPSA id
 9ADEE1800B41; Thu, 29 Jan 2026 16:40:07 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH] tests/data/acpi: disassemble-aml: rename and change
 interpreter line
Date: Thu, 29 Jan 2026 17:40:04 +0100
Message-ID: <20260129164004.222-1-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDExNiBTYWx0ZWRfX5Q2g7V1Pn9//
 8iRQ1faqu8L37vIkPohGu7HvCPRxinoy20DC80O88vbUVSTmY1BJGiQ2vk916KyBxV1V7PTvqvi
 dryAuUPo4FGPJNCGDqiFtTmfEdw8by2a4Ww3anhMhrprUeqxyvpbnYRly+Ghm2J+5TPmnDo9xI4
 1HSy3GpIh1IzNcwoGPAs69K36eyIvyFZ5eJY7XPK61laDzgpxxT8ZqkH+QrfYrUnkUVG53n7xfs
 Ftvo9BWsM/tiU9sJzQKDvFyeQigbQXUF8WcRN7Zkd+xB9N/C6iMsO3Yvyc1NO71ilw0/LF3+RJi
 EJm9vMjaJ9S+5ft0JG0/frrCJjNj8j/u6j0JlbGFRMBYgEFuAFQ8QYvAxu4+c8=
X-Proofpoint-GUID: SxIx2cx9wlHXgDNyeFJTYJgtP7EBlICM
X-Authority-Info-Out: v=2.4 cv=R8kO2NRX c=1 sm=1 tr=0 ts=697b8d6a
 cx=c_apl:c_apl_out:c_pps a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=zjuBxnCyfwlsZT70hpQA:9
X-Proofpoint-ORIG-GUID: SxIx2cx9wlHXgDNyeFJTYJgtP7EBlICM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 clxscore=1030 mlxlogscore=999
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601290116
X-JNJ: AAAAAAABZUznHii2GEzjWyZzQDM2GAjtSwO3qyTU4GW6ju6co+TQHWMZhqNQT67DI5loLoRKwFEClE37iEvIb6VwZb9aEMCaRqEOBIvBd3p2s0DE32CM6egyH/5PYy+/zPmE8p0SUySOSajAP2NzN3zTh1O2P5GS/uPo+Dn+eSP6zDKFTNq2zBpkWrY9mvGTqqbw56yf6QjIUww5XnchvF0AAOVPduJ6/LPuqB/zRbeSh/xPi1KRz8D15fFQKPbAQ+Qq1mioOL6S7dmF/fbQNYxnMU6gbDVmwSxXWtL9FIXllaDYc09c7Ufu2njXGToNK3UxXd1viB16cCfxiNQUzfCE8UYQJMlnuxrzUz9JdeOC/HETJ1POrjOY9mHS79rj0rFZbN17GGSJtST+67K2vmElwqFGppaEPt4nJsxFg3AD0IEJoq1ieeYmw2Bh7oZ2tRcq8KRwUPY6c1XBKc8cfCQdrtV1+PC8dloDcTLAYeXEI4gv5HDWTsdFVvpsS9c5D/7Ea+G2Zy+s5saxwjJ43AEXrJA97s3HIQYr6/SwNRA9mhpXrNR38KWhPC8e/VvRKQ2zPG0suoft685pawyqG3gjsyGS1L9Mz4F6MquhvTDJSg==
Received-SPF: pass client-ip=57.103.64.38;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.pv.icloud.com
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
 tests/data/acpi/disassemle-aml.sh       | 4 ++--
 tests/data/acpi/rebuild-expected-aml.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/data/acpi/disassemle-aml.sh b/tests/data/acpi/disassemle-aml.sh
index 89561d233d..62e1991ace 100755
--- a/tests/data/acpi/disassemle-aml.sh
+++ b/tests/data/acpi/disassemle-aml.sh
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


