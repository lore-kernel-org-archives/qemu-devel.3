Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6EFC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1X-0004yV-RE; Fri, 10 Jul 2026 17:44:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1W-0004y1-IB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1V-0003Ti-3f
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:42 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Wqu1752888
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=; b=lGpkXrAPChowr/Mu
 6XANM4s+Fo/amtbQn2OlDQrX/MAsMYgaHplPeoIYPQq76KYBn0S02FHf3BCikOl2
 P9ayTRHGvYDQ+DstoK22m1JiJkDAgJaCO0YJwSzx6JiRZ/KvfEwFTaHQiCMWnm+V
 Rjn58KIHdjHLjf6YhUK8rqKcMzMnt3XRFGILdEnNr0kE6iiYACiW5jWB2BNRd/he
 RxwCtG+8A4hW61H2dLj1BeTliDbZehdYCIUzRCQUsOLR1x8IPgqFpQvh4c4Mfn+5
 VFPZT2s+NZjU87FfedE0qlNVH0rEBpqK7WKYi0HiVfTC2/iqDOxAYeSi+OrSNkO0
 1jASSg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:30 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so1675252a12.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719869; x=1784324669; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=;
 b=LmPWwJPvtyHmNktfH5RgoQT21vScbFGYWHyrhkrHYjEcuFrVxS0RJjixjoRFoOkrpt
 PX2Q1wNinsN18Mi1EoUvahSHHXkTvRMUGkA3k3ue2xRY033hHzENFd6/2tkUAhO3tHNG
 fFVdVTe16OzWBB1GV5zC9f8Dpb9/YpKDgok0Fd088A0V6ngy3vk79epusz6gnHvGJjPq
 RYrL2vAPM3cE2k1qeCSqVeb8X6hLJYkEkeDKjZbeieDJ0+K+lYBr4uRe7+/G618KybF1
 eL836YxoRRN0ZYOiDTDCUbZY7Y+E4+JoNOTSZ+JNPdugzFW+X5ZTX2ZuTVhbvEbwzs0G
 UyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719869; x=1784324669;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=;
 b=cqmj0ASSAjq/uLTwkQuwXpGpI/HOUq7fvfRkWDOVXZnr6g6WYgBoxgYS9O0/H0Uut+
 ZJ9LrG+aNy5GD/o+TcY1o4fg7TFqpfPc2CaGPkjIvWdHhlXtAglXLUrkjj2rGccPZRKR
 z5jy0Xy4cDBYa3ul1dSo+vmn6K6NXsF7OJq/skjdoqy5g5KX8D6li2fVOz7CHXN5eSFi
 nrHNxTEhRHVQ29+O49q2/w4/2xJCvdxY3ZsYiho1N7elMF0EtmmMsTk8uf0LBvNWOpwp
 0pYIubskEwOrRmWzKx3FYSv9EVjOq0+snE6/ovXjpbKRw+fQSlXC5TxrRhw9A6UQ7+61
 s46g==
X-Gm-Message-State: AOJu0YyMkXerHRBcuYZf1+MhVraF/Ysbun+BWf2MFQ0xI2a3A/tXDKI9
 N7B2/gcBgqkYT31ugI2lOoLh3XMnTbnCSrjbOa8Cfg+zgR8Gjbuqu9BO2QQxa4qPxnz21j9od+W
 JVrMQ/mZb0S5HyVpoUsxCHZKGuiv8/fD61iFsI9GMNuoBtzPARKBZ+/n3LxiocBSILQ==
X-Gm-Gg: AfdE7clxQcRrbONIAO5/jioZPobRDKjhl2oiW5bxDU/IxAsNiiKnDNPJkDom+wE+p7P
 NEXbWHhesZMjtCxKiNem8OrTyW7HPf62pNIt47e2Zmd5unDYvP4d1Kno4O7/l8m6c+reVt73N84
 dIDBhJTiJkQnCOTcxPnfN8P8BxLww2mjYDgq788pP1VIXFKghrC+s81YWfIpzIhO/niNqEYBLFd
 Yp5TNjx6dWDSN5tBwpk4AeLbeC7HFK0a51IQVIKgEaqTdIWoMmaPkjYeBtttDzOEWPIk0eKghGE
 kfoDO16FU/sfPYJi0Ur3Qgb97Zd1jhL/raM2y7Nsu79rOMZufqyZIc6lDzjQrbMUFeo8fMM9Jzu
 1vHfNU73UgIT83ZpvZ9Qitta2Ta1xEnn6Nt6BU158hN/8UxPxwdzAybMZBzh9/MdjEZwuLYjq2V
 BNYLC59A==
X-Received: by 2002:a05:6a20:12d1:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c0f093fb96mr6117434637.14.1783719869167; 
 Fri, 10 Jul 2026 14:44:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d1:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c0f093fb96mr6117397637.14.1783719868728; 
 Fri, 10 Jul 2026 14:44:28 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 18/98] tests/tcg/meson.build: add wrapper run_with_input
Date: Fri, 10 Jul 2026 14:42:22 -0700
Message-ID: <20260710214343.2065491-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX1YKSm1tEcPOr
 TS3xcOmK7zXvuBkPZl1zW/Pcn5h5W619w1T/7Kb0C0GQLkXIz/8z3lZxxK0kFEvJL8Q8szo6ExN
 bIus65TkDTOjhjmDbtqbTH7ylki7l+ktO6kYXy4eKSdy5MM3avjpmWmCW+yFCvtbcRI00NEwP+4
 7PPdFLEEH9I4UeM0zgxJXs4eMCLCZvtogPmxYFQcZI8/lS5gogijMf2dyljz8aAj3u6dWX8+KEE
 ZJBxqhy02Tfl8n8HR0QILDiobss8xKm5/5pfolEQJPXymQh3qoZcyQjTRvPOnZzV9htabcBXWj4
 6CiaSv7+foxMNgTULIZV2/d9ghUdYaF/E9B6P38v3HWYusA/enx09YadlKBhcN4v3am4TsA5V/5
 tdsH9Hr4jATbo7bFrCw1sFRTLdiNIHKrwxXYvHR2A9rpxbm+GqcLRlKOovjJKkHLzdlRdXVikIr
 ZKQyqbCyuS2y5Kx6vMQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXxQ7tnULDthRV
 at46CfoT79vfqgeqMSr8ME3IN17qMXe3JoqwjfYVKndbCKhlX9GUMQNuxaIzaSgZWe7ujtIkkV5
 NqzQ8j7M0lafKiMaDNIFOKz8BAPiKLo=
X-Proofpoint-ORIG-GUID: ZzViCsc5gHna3RZ9kGpLG92HG1Vd6CBb
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167be cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ZzViCsc5gHna3RZ9kGpLG92HG1Vd6CBb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Semihosting console tests require console interaction, and were flagged
as manual because of this. This wrapper automates interaction, by
sending a specific string on stdin.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build               |  1 +
 tests/tcg/scripts/run_with_input.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+)
 create mode 100755 tests/tcg/scripts/run_with_input.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c718555d257..f2c5d77bfe0 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,7 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
   './scripts/run_and_check_forbidden_output.sh'
 )
diff --git a/tests/tcg/scripts/run_with_input.sh b/tests/tcg/scripts/run_with_input.sh
new file mode 100755
index 00000000000..3d280547c3a
--- /dev/null
+++ b/tests/tcg/scripts/run_with_input.sh
@@ -0,0 +1,12 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_with_input: input_string cmd [args]..." 1>&2
+    exit 1
+fi
+input="$1";shift
+set -x
+echo "$input" | "$@"
-- 
2.47.3


