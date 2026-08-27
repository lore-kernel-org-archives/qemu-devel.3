Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B8C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziNy-0005r1-2N; Thu, 27 Aug 2026 18:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNv-0005kF-AP
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNt-000664-Gu
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:47 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLmpe795069
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=; b=Q+FIEKorjM11QskB
 5ydBlYUwaoRxo8TR6MzVWgSr0wPqNCLC2Tz/lZanW0H9f/6/8DtGS+WFhzOYb0AX
 B2AMhD6/DpeLHZKIyVXX8gNzMDWkcmGjL6NuPOC495e//sutYux7DBLNwW/Tl47x
 dPekfPYQDmKQrd4dIAsuSSRaa2c9VjsJsQY4ioazuqpFTLvVti5qytGdrKflTNBD
 0+XUM41wakg3JOKiD2bPWeMaaThFkXIF/wl0vWB/Cfk4K0373P0YNKSMXeq4+pPj
 +QrdSj23+NCHemreIDvl1nhi3vR0UbuUgdKsO7I0MaQOxFSyDneYMvQbJ81718ly
 P5SGmw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjn52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:34 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso313286a12.2
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868933; x=1788473733; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=cYQOd0uAFmAvvy95k79IEPVGzLcmASduAhiezmiUjioTVbagou1Ez0MjG9l1jWUTUs
 NvWKMvYtj1Hk7x/VinTJtAVF0a0wYWlfs6MjTJYrhJJ98qU4etl5Vs17fj8sY6SH65Ti
 zkA9QsvDQJAJVPH7GWhhtfnx7vj/QjwAtS47qLrf/nyly03P9oZFBJvqHXhzcsXLaHpa
 CPQzkEFZm5MvdTbVJDFFfWPrBbvQdTiXD6iSUx7Xzils8PbfURjYicti836rBJsb+5Yy
 XfPyhS7QFRR2yS2m6oFtrYpB9gujeHGFgRwwVWy6vp7OOpJDGDUYAfqmYxQTTlfBLB+X
 CtYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868933; x=1788473733;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tGqB8ijy59omiou3b8Kd22SidkzAm0vy86ethjzCLSk=;
 b=i8n3rtCizSSn4T7zVYntLLj3UZXsqVxauDfz4MVZDd6s897SbZDsRr7Kmlbo7EYnla
 gDzUIFNSIeTT3hnqCV8sCZKBLqAdHK+6VqV1vWHwvhLSs6jRMLweNe9AOD3qiDQ8XiWV
 oIZR5epsza0891ttVFvw9FJAKK3yOFEuwsDWmu2mzpIzOOPiyYxlx+a8kdf25rr8GeV9
 hmlM6Yc18pV7TpglyNL5bp6b0O5Brfs01yB6ZBQ/XFlpedK/ykgaYkJBtVLLa0iOFxkI
 VWK8y0RUveD15iB/UQ/zHqH6kxd+6oNEBQva+A+xnIx7HyUyANWrKrxPlWPv0SOy4RA/
 R8xg==
X-Gm-Message-State: AFuF++k3Rei4q5gGc7WL+gHJ9PWPMLVXErJ30P0mFE8PdyhTTiBcvBOD
 QBXcRpd+WikSEYm27nGjT5hnJVs6UUL8Z11a64nDiYSHUVNiUYE5LOH3L8MztJIBf0jACB8O/9e
 gGiYLcaCV6Y8b6caeK0zow07F4tebZauG6RkUU9ylGfoglFayKir4rWkEprHbQKAgeQ==
X-Gm-Gg: AR+sD11klfvGmRoy+bgTLSXDOFZyCYCeEogaLnZKSaqOc80TE/c2tpVmLbJjpJYBXD5
 VO4b94trdhz5vVNB4vAV4QAUzCaKuK9B2c07o5TkQop11niS+q0aHpenRdWr5sSQxSh6DZJ4O9z
 R8b4BBwrqB5cMHCnUlT+txCWDY7HU0KwO92gG6r4pzgUNmB9DWLj3wfSmspR5PXx6JDwVpsDvTh
 PeAtvXbADbgq+jW9g0DQM0MWTE1ruM030UmN1sNfkKzCqsiIyiJn2MrO363V8tUhqF2AQX+fY4P
 7d/5KoBvBYQDM/Hhh29dI+kShGYwOzR3yv+RwtTN8K54xFv16ppf4euS4im78g8RBHEm1P86rVL
 ayTiQGzzmJyGvuF7VsPLFOZhR+IqnDpmZ/mWWSWz/+wppxZcVRpMdVbmNEOI=
X-Received: by 2002:a05:6a00:928f:b0:845:e7ee:eae7 with SMTP id
 d2e1a72fcca58-85627cc7befmr4143172b3a.5.1787868933424; 
 Thu, 27 Aug 2026 15:15:33 -0700 (PDT)
X-Received: by 2002:a05:6a00:928f:b0:845:e7ee:eae7 with SMTP id
 d2e1a72fcca58-85627cc7befmr4143078b3a.5.1787868932966; 
 Thu, 27 Aug 2026 15:15:32 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:32 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 020/105] tests/tcg/meson.build: add wrapper
 check_plugin_output
Date: Thu, 27 Aug 2026 22:13:41 +0000
Message-ID: <20260827221506.91574-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXyYW9WE2Lca6U
 VzCa7fxWsV85BGUY4SOsbySwQdp0ktgFVmlL2qkXB3mNgNNp81kaIHP62jT6dozqvkbNwPQuJHE
 oMnS87E8k4yfpr6QRaHMi3A1zgU5sY8=
X-Proofpoint-GUID: ye1jDHRfcxcxawQgyWjJpNjutfTuHIPs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX0cEXGUIaqYk5
 qZ+wDlgFGWhmCadcgybFQjp29VVDLIKtYTo/We0Ka7ARUs+ec8y/Wxt1ho4cmgVIMBV+5YK3hOX
 pwiUXCmuq2UocG4e9/Njqe10E7VEcvynlFn7NymGfcwtoivIKIMn+T5GJ2gPTuxtdQsVT2I4u1s
 Isj0QUtRC7NPUi6z9woGqXy0B3rWZsxsJHGlkt8AFNBiUT5DXIB8AOUHCne99pes2KLu2LxbEYd
 P83hHwNCPoPXMkqUYQVMtCKOU6aMECPd0wIKy5yaFbMH+IPoCs5xCkEoQKQQDGfOWmFYRYhAHzz
 pq+DtPOSeUnJuGPvrBOynW2ExOrSBPT5j194OZptRxADw+b50zQWa8nGklDm2ULm6hxaAhGI+d4
 jNXHeZswb9zgPLQaw2c6bLROfP90xUh6kU0+3woZi6Ui9xFM4R6lqidx7HqgeulW9W8en+9OEqO
 jyZSkq8cmSBwTZZSEBg==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90b706 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=YJ5_JRR3wJtdSSnXqCYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: ye1jDHRfcxcxawQgyWjJpNjutfTuHIPs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

This wrapper runs a qemu command, record command output and plugin
output, and forward both to a check script.
We use this pattern in several plugin tests (for instance, with
validate-memory-counts.py).

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build                    |  1 +
 tests/tcg/scripts/check_plugin_output.sh | 25 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100755 tests/tcg/scripts/check_plugin_output.sh

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 328592b28bc..779f9043abb 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -5,6 +5,7 @@ if config_host.has_key('GDB')
   gdb_progs = [config_host['GDB'], gdb_progs]
 endif
 gdb = find_program(gdb_progs, required: false)
+prog_check_plugin_output = find_program('./scripts/check_plugin_output.sh')
 prog_gdb_test = find_program('../guest-debug/run-test.py')
 prog_record_replay = find_program('./scripts/record_replay.sh')
 prog_run_and_diff = find_program('./scripts/run_and_diff.sh')
diff --git a/tests/tcg/scripts/check_plugin_output.sh b/tests/tcg/scripts/check_plugin_output.sh
new file mode 100755
index 00000000000..d942082ad86
--- /dev/null
+++ b/tests/tcg/scripts/check_plugin_output.sh
@@ -0,0 +1,25 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -euo pipefail
+
+if [ $# -lt 3 ]; then
+    echo "check_plugin_output: check_cmd qemu_bin [args]..." 1>&2
+    exit 1
+fi
+check_cmd="$1"; shift
+check_cmd_args=""
+while [[ "$1" == "-"* ]]; do
+    check_cmd_args="$check_cmd_args $1"
+    shift
+done
+
+qemu="$1"; shift
+tmp=$(mktemp -d)
+trap "rm -rf $tmp" EXIT
+
+set -x
+
+$qemu -d plugin -D $tmp/plugin "$@" |& tee $tmp/output
+cat $tmp/plugin
+$check_cmd $check_cmd_args $tmp/output $tmp/plugin
-- 
2.43.0


