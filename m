Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E61D9C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bt-0001K1-Aq; Fri, 10 Jul 2026 02:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bf-00019S-KI
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4be-0004ep-1L
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:03 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nAb73899089
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xaN04hbFhW/LwC6WA+Tu0oZiweb4wp36A681ZJ1SDPA=; b=mDv+OwVGIYdlOtKM
 pk6HViL30d9Nf+TQ606bF3d/4gvrMASGPiOaE13FOBKx6lGWRYSscN7U5cFdyL44
 gLPkTvNqi3bivbrrqLaYoMMBOEw3vyD+HyVJrrNlCD9yxa+RLIB10eiZFlwUA3Eb
 C9swQSY8M/UlqQ3DeryUmg1PEhLkVZWV5EJfCJMPzDGb6P0XDaoErDH6H7zVEqGg
 Dl4VxMGzODmTUueTLz0iNFpyIAGQdZeFuOdJyfe0ucKwdoKIurpG7hnC0fxB5pXG
 ZmDqkPTQIx2Gxwz0yYcO4yJOo/Zf8WCc84svEzBJRyPffGq8jEnR1sJxZv1Rhn4L
 YvItLA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeg3k3rp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9c26587e67so639300a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664460; x=1784269260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xaN04hbFhW/LwC6WA+Tu0oZiweb4wp36A681ZJ1SDPA=;
 b=YqjE+il3REanZbDWa29CLwpapJ1Bs3tdksqpgHrbAqBFC2FRo0azs56IF6qQK5bXIX
 6kg2757X2MgDXBx1r27LA/Jfxf1uEIOyV2Am/q4PDxe0hTIZVrxA7PszQti2H3fXSfGo
 mYaWhy8e65T4N4qP19tsVJ5wY9RTmNsZFSaKvea74VvQLPIfB948nxKgpXIgjIZztBRF
 fxTNMgBTVtX0AUCQUgLduFFS58a8HTTzmFbyO/hf12v0/5sUvNqbeVyF0wYyqoW2LxZ0
 YnxfcvJj9uypqhcdWdy3v+h4xsxRHXOHub9IhFVt4EzA14xveHYqnMybixgQryu3sGPJ
 WqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664460; x=1784269260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xaN04hbFhW/LwC6WA+Tu0oZiweb4wp36A681ZJ1SDPA=;
 b=QSEyxPo1x8Q9DPQ9qOmL8aLQtv3595abLbHhc91FOh3mQfCq2XRioTKBRrNT99PE05
 79N3C9yms2+vcWxXAmFAqQqV0QKsxWrzi1egJxJ1WZ77/uwdaBr8+rhzFvlMaogHHeiQ
 YuSnZZfaHyJmF0rMjUrF0JHG/zLRUv8IV/imNCNDVqSM5sv14kL8C0s/3Q6/InYIKHci
 q77JN2baD5oFhvYJznKXdzdSkbJqH8AcpN9CphXchEcu1JZgZ1vuhRE+s5jrf1btm1fC
 felktuYfMDetXmmrOXAqVI4qZQNXbg5t9z3xW3WMBNH0y41s3uQ9Kp4u135ZOYvCqR0t
 KRug==
X-Gm-Message-State: AOJu0YxthzH0nZwd2Ija0Aw1AMq6QT3iZ2IO/FzQTjIa21DZRab7xNDB
 pk2odKmaQqfOP7/7mhTME3B7kve+O8zTMQMBTZzUt8Zkz6ML+LhiguGudl35CnJ+obm7Ata/QVu
 sr1lD8rdrEDdm+EhtP2PcHlluKZDhRyzEYNlettvy2qmM7nbW7aseEdY52KPCRLR4QQ==
X-Gm-Gg: AfdE7cmTZzZA/v28NXz7vxqWrg2BUao1CzqI0UsL1lR8oQhdyreA8Ctc15Dq21xtHUQ
 sbjDZueUpH9zBuPYjvOnxWiqY5gaU0vAIvhs6NuzkrVKWIGP3ILYJQSRDzfMitc2oYK133CpEOo
 46dXt4e/dVIKUxlzqexJYxXStaVGs9RJvETedttlsGvUi+T7Y27wHMZ61jE5nWWRsoUreaDMSLn
 biNnOQToQk+orIdvQqQ1/FSmQF3D4YqVV21hVb4kqvhUnxQpWzM9cygJfb9Bari9Y/N/eZkbGEf
 UilA56zCTJrcgK1UzBDpoFPHJZ9D0QAmBJpQrJ7hn7f6cVafn0/dWYQcfF3D6v8wIwlFAdOK6P4
 F26TJ0NOsBaiWycPNSe5LHJvLP8rc46/aEsI9DbtbC0jwFjaC3vaZjS43egSF4j+kXMdDMD0w8d
 Hw3RV+aA==
X-Received: by 2002:a05:6a21:490:b0:3bf:b625:5bd0 with SMTP id
 adf61e73a8af0-3c0f08efe2bmr2487879637.9.1783664459871; 
 Thu, 09 Jul 2026 23:20:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:490:b0:3bf:b625:5bd0 with SMTP id
 adf61e73a8af0-3c0f08efe2bmr2487860637.9.1783664459388; 
 Thu, 09 Jul 2026 23:20:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gustavo Romero <gustavo.romero@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 18/97] tests/tcg/meson.build: add wrapper run_with_input
Date: Thu,  9 Jul 2026 23:18:56 -0700
Message-ID: <20260710062016.1818125-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXw9c+usFlePdO
 rpOo6xU+aLnfbI0/H80nQyLVPm7qrQRunR082yQ0qF8RTsB1jnk4sy5Y6eHPtYf54myKi/deVMZ
 u0FbJnnjHLEBltk3frCDF96vsglsN64xF78ub/rZXLkcP1sNaBOZ8KahnJ3nn9WhlatnlOsMGFX
 BhfaztqteEqfIrm3k18DRny6JAP8lTj3ZrHtGKBgIl5O2keszgVC9IoTKEX+9dskmkX57bKNYSc
 ZOwd4bE1nyJvvQQqHbsr+Mj8Xcrhg27AbUcOoTrpSyeVNUr3Em6GlrQFVhSvl6ZzKZf+hRW3Ikk
 2bWpeRMPtgpdJfGJhxfRFfrrljDWkK6EmbQ9efGHeKvy3qvJOOVvEAELA3Vh+yBA20N3eESJnFM
 JTRWugjJE8UQeLulNpCADE55h9C4Emt/gks1geBUyVeMfmf9l/rxrBG+MwDVWcgHk34QB9cgIrw
 1NzzjUG39bUJxMnIkqA==
X-Authority-Analysis: v=2.4 cv=ZcMt8MVA c=1 sm=1 tr=0 ts=6a508f4c cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX9KZBZPNnW0xi
 PnwMIvYL9opSR6unnSdwZiXSz1gw//rbbN8P9DKzKFr+y3AWQ/FTpmouYJB4BM3mDA8+jTFKtlP
 qSYmkx4X6Xq37vFjXhMbjOHm4E7/gZk=
X-Proofpoint-GUID: 3qNB_Cles5Zb-sf8n57eppvb5p9UmtxU
X-Proofpoint-ORIG-GUID: 3qNB_Cles5Zb-sf8n57eppvb5p9UmtxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
index 92b148e9d18..8205673b310 100644
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


