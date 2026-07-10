Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB5C2C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:22:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bs-0001IG-PK; Fri, 10 Jul 2026 02:21:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bg-00019b-Vz
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bf-0004f8-9s
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3mZ5R3838057
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kuVBG8nNmL4LA4Iq/UjoE/bdMb0Yjb4eAKARmRZ9zaQ=; b=Dg7e+iVK+wsD3V1M
 cVrtrtfYqyzSOyGPmkYPWQLVwEof0JIqSU0Iv9kATdY/4JgoDKdaGKCkJGSx8eh8
 bml1EMYQIm6mqNewJNpucva6i71GgDzxxZbcJrTn/XGXgympdivPfOHxvH0WIMiI
 urmFa3X8kslqjx6K8PqIQSHCZsw0LCUq8iY0KwiKLR0ZbASR6gJZoS+5FPE3jFIX
 iSME9JAdZsYXk1yQ51IoHW77tvq/QZpsZs54/sLHSDzMDL7cBSOXAR8f9K5MMTO7
 qUi9+uRxYdopl/u3ncqBM/TnSJkoZ8E+8oKMCDwOffO2BmgJeRxECKsMMOQYcVjI
 EE4IkQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fanwe93xe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:01 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8484ba00601so575713b3a.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664461; x=1784269261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuVBG8nNmL4LA4Iq/UjoE/bdMb0Yjb4eAKARmRZ9zaQ=;
 b=jZFxW0Z4QUZ7xelLrXkZr0wdNIHKyzpOK2Yk/uHFHW4G80wHqJayLyMkv5ZG7swQRy
 DpVJYT2vFmO5bTlcEqOFum/u+pe148V+t9KUcrvLsrQ7nTIAv92wkHowJ4DEt9R/JIf2
 bPOHynYxiYFVowGASIRfUOa0S8sM6zmwSym7qRt5+taBnqfkWpO7DuX3sYKkFlEUflUO
 +YCOxGoe1kdnzetgivYcLE8HC4KPrZ6RH6UpTGEZIQ7LFChZ4KLVSo/WUdS7HIFSjzRJ
 P5rHb+AoNCJysEOkfZ/MJWd1CSWkKscRNCdChSrqKEglwUUOG/PodhV4c+fmZQbFfBd1
 VCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664461; x=1784269261;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kuVBG8nNmL4LA4Iq/UjoE/bdMb0Yjb4eAKARmRZ9zaQ=;
 b=pSPga/VpJKB9huMTVvYB9WYRV+BHJ+dsr3UaKFul+QFnvQVFDqdattg/6UVsAfgGWE
 550WYmMuhLYqeayn84w0PaHS/YhGIlEJkTl38Tm/YAWvyUq7rQIIjUlKdD9ZQF6nSajj
 rIAlUhp1sxph1Rwfp8ooDm4/ZUcGzV+dovi4uWQH+veR66mk5ZBUllA3reAcfRkXV/jO
 GRPy2Fn8nFHLg037ylYZRCEQJGp23PtysbYC3dDrUe2qJaiRstwel6SLLPB6eCPVaAHE
 bzbNGYtVU9Hhn+6sapohprsivMtKok3g/gJbMM/vJs/+f5ZdMv29q0rkcYxF59EfnHjN
 XQMg==
X-Gm-Message-State: AOJu0YytvNsCyaEgocg7gHJk7BLabbcyI97FW23JKEbq71RHZ+xGJHhK
 8mRmSPfwOTRxJACeNhuCh9WWAD6MPB/WeOR3RnaQKzhYNDNQPAi3VukCTylzBSyf9PutpnbeXhv
 3xAFdVFj92QJ5y6IiD9HTx1iD2cGGIvABMLTGSeOzbYwDVUXIlr4KPlzr+lk+6QDa/A==
X-Gm-Gg: AfdE7cl52qZtOerAR34qOkHoUEDwIYQ15bWoYuAaAP3o/ban7FPJtZ7M728UVxhPEhV
 lQz6RYpUw7wutVCmZ9WpNNNtxuwrRzANUyxfthE3RNS9JB98ITgOaIPMa35DJXHDni4tpFR+Qme
 Six5yPh1HTBDaS8wM8nvcAEld3U4n7GK+hPRfdgx8cUv7MDjjAJxvVzdhuD8QPy4gFkb/pGqEx/
 cIl93dSWVpEFMG/Ac/prEpq/m6GLdy77+PDbITTiboArL5zdqw/WL48JAsQ6tf4/1DvuvjxjXR6
 v8JEsEPkkgXR8mqV1OsRb2DcBspqJI9khr4V1Ee59aN0xtmY/ChGTfEVkQj/9mI6gN+AlxXqsFw
 6pESa5jEdJ+E3bUwmxMoDZ+1OuOF7LftafjyeC1ZjSvDa5zfm5oWh2j0FeAziJs4A6YBpRoBJN3
 fpvyiCSg==
X-Received: by 2002:a05:6a21:e083:b0:3bf:a489:1483 with SMTP id
 adf61e73a8af0-3c0bd048ae1mr12322817637.33.1783664461327; 
 Thu, 09 Jul 2026 23:21:01 -0700 (PDT)
X-Received: by 2002:a05:6a21:e083:b0:3bf:a489:1483 with SMTP id
 adf61e73a8af0-3c0bd048ae1mr12322785637.33.1783664460853; 
 Thu, 09 Jul 2026 23:21:00 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:00 -0700 (PDT)
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
Subject: [PATCH v4 19/97] tests/tcg/meson.build: add wrapper record_replay
Date: Thu,  9 Jul 2026 23:18:57 -0700
Message-ID: <20260710062016.1818125-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LbIMLDfi c=1 sm=1 tr=0 ts=6a508f4d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=zc0IvFSfCIW2DFIPzwfm:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfXz1kIHUea8RbM
 X/uALPRdxPv+/xfRovSdo5WSOFssIEsgc0Fun4IGpiUQLjbL7BVf0HhyByEE9dahiRft4F6KA0h
 PTbqCGVIrZp5dkp4SnyxRp/b+U6MrIkgVo0Xhm0RI+XuwiVcEmqs/edfmxT4TSWwLOrMu5HCYQt
 ANyZOzkGSgfTA3cr6V0RYSLgTpNfCxBcDe5oawceG/Ws20UvvUaSmQahuyGgTZKb6ZIjpzR8vKI
 GUJQy253WbD6c3yDM5HJk9iIMV5tyss/jzG1DN0v2EXCyub9/zFMKPQJi5UdFvB8rb0upMoRP9v
 0kHp9AzWVrjlmMj0nJ/qAMtHcpvVhRPM/RUyfJNxfocVOv9OVcjMq1Q1d7Qa30HDu90j8fgmGvf
 uwBE6r2H90U5RnojwwneGXCVFqLyAmS8FOOqvDWSolpnvu+zvccdCh5MMEBA2lJnl2iC9Xyorpe
 Qopz1/ujUedTOrD6ELQ==
X-Proofpoint-ORIG-GUID: Y0QyCLMXeAkThIWSmeQRnOe3Q80vtV0g
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX6QEroKm4Onoz
 WyPFv07SfC/g9lIUmgHjOnLvre3bSsV3esJLoEan1otqUHH4kMCPQdOe7+C7UuHdul+HcC7T1/a
 eVFVkZnHJEW7XJkXKMdrmyM22yq+iyU=
X-Proofpoint-GUID: Y0QyCLMXeAkThIWSmeQRnOe3Q80vtV0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0
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

Runs a record and replay test, and make sure the output produced by
both runs is the same.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build              |  1 +
 tests/tcg/scripts/record_replay.sh | 16 ++++++++++++++++
 2 files changed, 17 insertions(+)
 create mode 100755 tests/tcg/scripts/record_replay.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 8205673b310..92f8fe97649 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -6,6 +6,7 @@ if config_host.has_key('GDB')
 endif
 gdb = find_program(gdb_progs, required: false)
 prog_gdb_test = find_program('../guest-debug/run-test.py')
+prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
 prog_run_with_input = find_program('./scripts/run_with_input.sh')
 prog_run_and_check_forbidden_output = find_program(
diff --git a/tests/tcg/scripts/record_replay.sh b/tests/tcg/scripts/record_replay.sh
new file mode 100755
index 00000000000..57775a2d4c1
--- /dev/null
+++ b/tests/tcg/scripts/record_replay.sh
@@ -0,0 +1,16 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 2 ]; then
+    echo "record_replay: qemu_bin [args]..." 1>&2
+    exit 1
+fi
+qemu="$1";shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+set -x
+$qemu -icount shift=5,rr=record,rrfile=$tmp/rr.bin "$@" |& tee $tmp/record
+$qemu -icount shift=5,rr=replay,rrfile=$tmp/rr.bin "$@" |& tee $tmp/replay
+diff $tmp/record $tmp/replay
-- 
2.47.3


