Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6AD7C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfO-0004l3-7P; Tue, 28 Jul 2026 00:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfM-0004kR-NO
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfL-0001bg-4B
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:44 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3acFh1527475
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=; b=mJaFgzFWeI+ZwhMZ
 hk+0ZoOKe+8n6TtjM6qxqUoY/D90V9SE+tMSbmyCm9MDQ72aINsQNpd7oCB5lhuV
 Ox6zgm1Y0yHmKqTZdHHzQTd+dEnUbuSY2tjV/tEy18DptImkPNJ88AydT1xTINFK
 WFIzoTfsgeJOixSazT4eUJYJBRvt5WWGgybvvCe4/BmAnnLhmCXtOZPih8zLiScO
 EmN6f55rBgPqMKHcsPRZG5sMltUz8ytFf7fLGpsh0q5whzHqID5NptAN2TuMWDS3
 kiczEWzpWgyFqigDofV/epdohtb7nbixBQYVjGyDAkUSnqNV9+8TkE27X2zVju3A
 YOpkWA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpbn8acv1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:32 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb7d6ba548eso4321398a12.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213811; x=1785818611; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=;
 b=UCvZStvEauoGDnjX57dmmvdT4tl+hl5Yzj+1JsGeu27NClMBAwsdKZ0uiq48qqGyVs
 MeDfDds5N1GxHPLsSAw3fRfLrmxhx3m3/G+MGYkoBhGaUcMR3b3Ia/nBn5VsEKWnOlWz
 Ct9YNzlBrEdwCAAzCSXH3hejNkgqIb0iqSwyaGQ8n8MTdvJOdPYfVLG8T1dpY7LYNTWi
 OQW5Nue69SqjWWt4LzvdX1fxt7s+26UDzMI70xLpxQQYhSwlguI0Wqa6UHZYevjtkFNb
 VNB3/onjspHnLnd+WWhfVCpKvnEKM0RrJ+Km3XeIycFmPSUEoiOn6WFbJ5GqNYypePm5
 RgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213811; x=1785818611;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=;
 b=m/XjcwvREz5xO+Z9A6rmfzLgz7VWdK/xLZNdS+p+oHbrbc6WxVN7MncIur85rVN2mE
 uSMR8hy/PoVY/c0B1Fk/qjQH5syHM64m1b70HsmSPSjzNDwlprOhiWkZvsgutO4oUXrn
 sdCi7VWgH0J7H+L7e2FXzKm5gfMeqYcKxAXwgnxzTDFCtNB24rOwLzGC4dwm7m3OwaRr
 hFRgukhPkRsUc5VvFNnTJHnUBRCs0iHZqY0khWxeCjbI8j09lGOvtVBICLKeJlFaHJEe
 f2KTAs/aV6T2jHbZZeqGnhCgllXFvi3DplD8lmcQNIQBaVYc1B1ql1wTgM1fZiqLI0FW
 0cjw==
X-Gm-Message-State: AOJu0Ywm/T79eErNyYzNswzllTKtiRsw7UdHuIzR26femmeon66UoaTG
 EZ8+6mlHC5VWe64mBgawSFkLKHsJSBHchEvs5GXUBI0RfsFtMJ/JPkgmB5COfxKS6qWEk5ecaMR
 IhguGsyD2YNT92RxcJDA6ZwPpHx21g9IAg2PXLog+fmH9cWhj1T84z7Ivgu9Y67OisQ==
X-Gm-Gg: AR+sD13IatXxdYIxdVwdUvRLyQb/UGT623bJFwhD+faD5IKB9jWLVZ/gpNGQt2dEeDQ
 Yinzrl8845e6mhBjN8kG6eD/STLcFAzE/6H303gRR+5S/MEkL9gzV99S+WP5f5lng4MQmslOxoz
 ++IYS1b7lHpIbA5O8QGMKm1EN1MR69ox5Jadwq47Mf3/HTw0pesbb6sFCcdoefU5aFKlGChE5Bf
 iVTLWiAhBDEDoRPInHzw9XMOSKVoyAy93dlwFGiuSrIajhM5OlkhTl/mTTVpW/VbN56erwIg5Py
 pjdHB+dwQga/EWoweKTOYmwW/T1cW5eeSeYnnxHvUwakSnxUhHSvUI7I68DwqgdzlkKOvbqywvO
 42tIyYWXbCrtk26Ck0m69/9wVssBaOLTB1i54mx9g/gUg0UwKOajc6yPrxUZICxCJGi7D8e4=
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c8ba5b7f3fmr1095603637.46.1785213811144; 
 Mon, 27 Jul 2026 21:43:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:1fc3:b0:3aa:c964:3c27 with SMTP id
 adf61e73a8af0-3c8ba5b7f3fmr1095589637.46.1785213810764; 
 Mon, 27 Jul 2026 21:43:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:30 -0700 (PDT)
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
Subject: [PATCH v6 019/103] tests/tcg/meson.build: add wrapper record_replay
Date: Mon, 27 Jul 2026 21:41:23 -0700
Message-ID: <20260728044248.137626-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXzJWgcNK62R3K
 BRuHAonVWf7k1NnfHdAhpCItwzalO3oGaVq07lEbByMtthJOEW1f7IMFEJhVCQJu7yLl6R2YzTd
 FrrRPl6lWsUP97BZnREFhAuIh9YqeJv9Dpls3+G7q7k4n+FFeNb/5ktFYS8XtTbxknDHEHXcuuU
 JzxnALLWDAFoibZpATo5TGnzjogM1LuOQK4S6o3NxlZVqMt7ir6D7URlYVuMYfEk6h3sESgtYTq
 CrwzQW4cf94YUdZz3QN2YWs4PwvgIOdszhSE3hpz58YlC//WUB2RqV+XDgzhHeAOkZFApACkzoM
 sHjwLiXHClcCnCKwnvssJuvM/3w+NR72pgtfP4fF5raxbXIrqYjKsI6iZcVSaq1fW+ivR0HoXVR
 8R1ta9wZOU3i6z+Gw4jElk8cMh/aBM0Z2ML7pwD/f6tk+kgDzhICrcle1eA1p9Rq6TIoCMUB4GG
 9sV4LbOtmJWePNcx5fA==
X-Authority-Analysis: v=2.4 cv=RO+D2Yi+ c=1 sm=1 tr=0 ts=6a683374 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LV0xTpp8xgrAVabqzY_qvTvSJqOWXXVA
X-Proofpoint-GUID: LV0xTpp8xgrAVabqzY_qvTvSJqOWXXVA
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXwrit62wlBhqc
 L/rtF8JWS8ZlsgvGY9OsoZMySyuyMNMEYfQFvoHjlePcxtHxIptG6uj9SW04otP+dJHLXaXAV53
 ozSQB/n1DQIXlmg/a+OgvFVtWgTzjRk=
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
index f2c5d77bfe0..328592b28bc 100644
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


