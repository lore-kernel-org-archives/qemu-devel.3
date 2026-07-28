Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD12C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfF-0004hK-B7; Tue, 28 Jul 2026 00:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf9-0004VP-VF
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf8-0001bH-9y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3acPG1527520
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=; b=kO3/DOB0y0Qqlgm9
 JwOOL/JCEI3BK0MGUi2VGH4u3YILGCirSfs+BsgK7h48Qvw5FqwwPI/gnnvDw08/
 ghb2R3EUvw1nXzAenU8VFiBsCrnhLdzjzfu4o5OE1bMnhZm14C0w/iNQRPDb2VdM
 rKRjArNojmdG1UCoEYwR+k1lNnSSvDwKm/W0GVpXpziup08tpl676ET4cdXXbU/G
 KTinkUJuNqepIkIAP1m3d9cOl3Stkkapk+dNkqr4uOnd1SY8s2DFG4IEZHrBg/7L
 pnpPg1/saPIVwDRydWeocMCLJLEbwsOrLVBtIGU8IFGNBXTbQt4xRnjsTVOorZUG
 NBhBOA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acuv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so528150a12.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213808; x=1785818608; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=;
 b=E9vS7CNX+EUNWXj8osoFuFBkTVc2miDdMUA90YsDXWk9M5o6v0jaW9rH38O9r1QKJb
 MWcLvB5OYCT79QVovsEr2/B9UXwxypIHtARfscNmSnPlCGTa66a1JG5oKBXbcxL88DXM
 swTOyuEUIgHyqLt2iqIcsCxmEoPOhYCW8i+HNKQCUIRo2vdPT0fv9ZZq7kzI/UYrdku2
 iMO9NkdXa95AIuA/WRKMrcV11U0pQIFSYIN5mnQwy9AvWx4PuMPCRwIyFBfKGkEJl9Iz
 NIz+dTa2Y7B/mva79RnmALHCnR7K6fnmmihQFqUel4JpoPSpYoOiAdpPHHAKY7yd913Q
 GKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213808; x=1785818608;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sr6Kr8KOVgldgQT/Cp/NDRYkVE9COGPiUTjyvPYRF9U=;
 b=KIMLtfQnHfTwRMHfMCYrbriKxEZWer4v+diapqB25km/oWIe9UF8hIDCYxsNL85kj0
 N01CYfwGuNZo05wTnOG67J30kZ+aodneGCxLftjEhsGfyPBfCknM9SuvkV0fBEDfg/5p
 6AhWjx9SG758CRyv7s3ofGs0jCDNGxvMbpQlPhSptYKQ/wp8ehOVSyxz7TqQDXdQUtlV
 muMp+jImprzOWkyPu/89SgVQeIkXtNni6M1Wie5YdazUbqvkHy6jFwhY/m5jQaqGVqLB
 Qv0RG+3S9RdjRWmx2wFxdKcaRDcPCCEEGDHAVZHlzjswU8sidzFjw5JPSqUyz0e3o0J4
 6rMg==
X-Gm-Message-State: AOJu0Yxz3JZNXX4qavWrHcgjMc1xS+jE6Fng9LcYNzaGFMUR0iVN29ET
 xGob3JEhG5xU/gQ3v9W0FaiPHZMfqW7Y79wwPBlmV+XrqmH24cWETK+16mPYGLsmm7vJQrwc+4n
 WxKfp3CxaYcYvciUbkTijIW8nLbEHs44AoYvjAWZZ7DDAJkXTjhHRd+aesVfRXatzag==
X-Gm-Gg: AR+sD10cH5vi+xmHIJT7TKf7jThCFTyRmUzP9QWpfX0CzZjI6RntbRavSar6qKu3Nfd
 pqILDyGn63f+DwtsyENFGAnbZFVSN8Mbh7kV4DU6PzEy1uU0+wxhgNhPTfRSU9tvKKhmPe8nsrD
 2yhDbZbc0tEuN6jg5AweWpPBApG2iA8Y7aZz/4NID/TNcqpJ0vX/llR+m+sR/igJp/aYwr5NMNH
 OmMMY/eYmGQuBdymMEaqa/34BNIeVh4027f+kMu6SoDYj7a4MemdikqgaZJTGKLEdf+h/2/SyiH
 Dy2nGanxCp7f5PKcbp7lVswBHObCWQKFxvfwVP8vgSb0QGRwlgs9+NZTVsF26SevRXetvw92clP
 m01+DHFpLscEAyniSlmm5i8hee5gjxWwQ4rcaIZwPLIIZ5KSHEIQsjnHszikrcvYuYjG578I=
X-Received: by 2002:a05:6a20:2d26:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c8ba472d07mr1201175637.14.1785213808381; 
 Mon, 27 Jul 2026 21:43:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d26:b0:3b2:8674:9830 with SMTP id
 adf61e73a8af0-3c8ba472d07mr1201139637.14.1785213807980; 
 Mon, 27 Jul 2026 21:43:27 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 017/103] tests/tcg/meson.build: add wrapper
 run_and_check_forbidden_output
Date: Mon, 27 Jul 2026 21:41:21 -0700
Message-ID: <20260728044248.137626-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX8sjTYCofVbYW
 R/Q5sFn9XrCA7cwLuFlG8WdpEeJ0Lwjj8Cib0pb4ihtZEpYtD04XSRP+VES2M1yLxnC9LLs6nRg
 LJqQGBPmtK8LcqD6fOOwK8muj0Por28Mpt4E+W9oyhfOx93IjhdfjRtyxCyKl0Wuu1kcVmJzmV3
 4GSM2RtOrP5+aIXm1HvD39tIAYiPACSYuiBCZhC3dpWRWPU0GMydQXqQpWgnh0NCxRRwYqhVt8f
 pBoP5NU31OeP84YHJmuCcUxOTA4mrgQ64/Hgk0HLeCi8zeuvHHc3aTB0lWUyjat/ujw7i+RDO9u
 x12wanKlAeX2JFXJxYdVUeiogfgqElvDZQxFMJktEIA8mPne0zBI+fQbzYIiSPmjA39MDsOVK63
 oQnJ6QOhsEtFN0f1EJI6jsV0lF439nbCb5nGbxpNJCCZdmK16wpCFwZ7D6Iu0526iWMMdSm8DHJ
 IIBRgK7nuH9xbjDPNIw==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683371 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=fCjPhq1eeATGNm5uL08A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: N-wiOqPDbTERSWiktcBJiEx_npnn6AT6
X-Proofpoint-GUID: N-wiOqPDbTERSWiktcBJiEx_npnn6AT6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX+pitk19iFNqr
 6Q3UExk+/OMJrKbzPOBUTo8ub4n9TxROXq8Ex24zaY03I47bHnbIVp/Ih4w3jG4dZQo6kuqhTiv
 tlw5JfD5pPDm2fE1O+Uv4rPANocGE1w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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

One of our test requires to make sure output does not contain a specific
string. An example is system multiarch test run-gdbstub-untimely-packet.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                         |  3 +++
 .../scripts/run_and_check_forbidden_output.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)
 create mode 100755 tests/tcg/scripts/run_and_check_forbidden_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f5fd9bee7bc..c718555d257 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -7,6 +7,9 @@ endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
+prog_run_and_check_forbidden_output = find_program(
+  './scripts/run_and_check_forbidden_output.sh'
+)
 
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
diff --git a/tests/tcg/scripts/run_and_check_forbidden_output.sh b/tests/tcg/scripts/run_and_check_forbidden_output.sh
new file mode 100755
index 00000000000..4486ca8ef83
--- /dev/null
+++ b/tests/tcg/scripts/run_and_check_forbidden_output.sh
@@ -0,0 +1,19 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "run_and_check_forbidden_output: 'forbidden string' cmd [args]..." 1>&2
+    exit 1
+fi
+forbidden="$1";shift
+output=$("$@" 2>&1)
+set -x
+if ! echo "$output" | grep -Fi "$forbidden"
+then
+    echo "output does not contain forbidden string: $forbidden"
+    exit 0
+fi
+echo "found forbidden string: $forbidden" 1>&2
+exit 1
-- 
2.47.3


