Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7A2C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfN-0004kq-Cg; Tue, 28 Jul 2026 00:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfL-0004jv-Da
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZfJ-0001bW-VW
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3b25v1424076
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=; b=duW/MGljU3wSzQrE
 RKn/Z/kmCfRqnRY1H58sB+BrnLXaPknvA/fkGd5d7/GWbt9Diw56CpLYBBlKf+qT
 oslH8AysLD3GVL9I6Qu7LGn5+hGHaR/xJpBXira4mnStCQusVn47B+MyggGTr+Hr
 l8JF6vXdkh4fwaHnpoD/tWADTC0H2N1RwI5SRh5hjXthIV5WY9XXXBdddD2TwUGS
 oj1OPdSCS6H/sJfEF6h4/Kye9PGEeEv6OrKouSHjnH4+4xplxpfFn6x6hDhN0FVw
 kQkubr+ETXtJfnZS7FPM7vpRApHmJhEGWetprjggckErw/NIbYo8FwdvEes19EIL
 BHGp7A==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mpdk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cb835525b10so3965995a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213810; x=1785818610; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=;
 b=PmGCZ5aNS7UXZttjOGs/1/Te4PldvxhZveCKiLTVqBmUhRm06NvNH5wIjmg/Z9Auug
 W35LFMfi+qNnhSdmrl7yFbbwlT2LRJk7d6EC2RF4D9rM4r6lbrSnQtodyO3CS1z9AqqX
 uLFfYVXHtgghxqUM/embqppDIN9zpPRrc8F5Fq18l4qLnovAEPtbZiZE218x8/Ydwr/X
 NHBT0RASfbyhkuNLNb6ajGfTZ4S+hvXmjJOTXKaTzX51ZH4tJGoUaFWopdj+rNi2Sh4k
 VN+GKIcn4Xrjvfh+BSCS06Sw8yPwBr4rUbooOHaGROAMQHupHmgjgZfY5fUscFRhYabC
 LLiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213810; x=1785818610;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n3GlskP7gz1ftiiFxpDdGRHEshjFFqhq2RLK/eS4qVE=;
 b=nqmVbsKTU5QEa6qDTKZsmfeamT5K52nqepCXkDUPgZHEKezIuTTbLq55pmxApTDjMs
 ZSJrjlNTBGqm2AQlBhxojYl1NduYJIV2NyJhtc4tGSdL8bvAacwA42WXw+Nr2mKbdXVA
 jyBVfxWjuR15HRh6rcNPlIwBMgta5uzGs8QSoA5lR3zGpK1JHj6O11h1A8l/2pEROwqw
 jAXkoDle9DWjtzSZpgUsulevvNSTr5hs+DQ+muGAVfzEv7fA0njbvZfs31uEAbXNqNjB
 seiYTjcnxiGwEKwmzyred9SfcGyPn+FKi70z+GLOTqBLIw7wFqzhR/H6ry7iy9Kpzktl
 C/XA==
X-Gm-Message-State: AOJu0YyWxcwe/S1JbDzCJdr1dO3/HVo1O1XjJUPXb/NLEGHlGFu/cfir
 Pc3/4VhNoZbvGOwiXJS37dvAVbAx6dac3bQnh/FiqWngS2P1tmdU+bTSnsKzOAClsY1jtXOJyRp
 eS6qAbHYT0hAlfHsX1phaJ9zo20eEEmiOQalJiiwLGiOlTD8iOg48mdxcEkaeZ8NGjQ==
X-Gm-Gg: AR+sD13ryxACxN7+0fvQi+fRjNU2hROfCg1TKETXZRo50CxF2qLlz6K/mSDjQY/24Iq
 6GxrLNiic3vtMWYlcTC+07YsFoCqIyQeQFoZGgPZm0YCut6xKrp6DnG4ssEEZ4fwW5ucWOiH3V6
 Oh003AECgjezr3YhOTjpPD4KOVVbYUUwdO+R8M2Zi7czfCgJ9mOkNjriYvaX8meUEvO90QFTUZO
 DbmbvL7G9k+paP8GzfJU63PBJKkhLzqMBlthA5ACQIM0Xh72B+b9aSvZS8KK6cW56c4DXq+u7T/
 hdp4KiII4dsdHINcKR+d4XJvNMXErsd2lzhvGfbFtmoNQqVzVvW8V0srv2yPgPg78eUEd2I4JDP
 HdWHULxctoSGuKH1ZWcmioZ5iNNH2sdS4NN1NKLafSxWuEozaCxpTkbb/9xdgbz67OQRbR28=
X-Received: by 2002:a05:6a21:a8f:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3c8aaf7b095mr1141867637.7.1785213809798; 
 Mon, 27 Jul 2026 21:43:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:a8f:b0:3c4:1c9f:d81 with SMTP id
 adf61e73a8af0-3c8aaf7b095mr1141843637.7.1785213809378; 
 Mon, 27 Jul 2026 21:43:29 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:28 -0700 (PDT)
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
Subject: [PATCH v6 018/103] tests/tcg/meson.build: add wrapper run_with_input
Date: Mon, 27 Jul 2026 21:41:22 -0700
Message-ID: <20260728044248.137626-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXyObwJCi/gIXd
 Dbxizfvqq0kVMEQKICmLXo+OSm4QiWFL46Twl4AjuiyYeD0RUWvEMDP3Drz+d1Q1ysmBt2QCfhU
 RcUcLdpbt5gIKSiBg1gUhWlfMkco+FQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXzqlYjUV3W+PK
 HZUfd2erJK8cvrStUVxr0CGRtnVSQKR+IpTRtuh8WzeYynzDoGL6vfyBWG16cZRN6CqyD5gh4Lz
 TJwUOzS/FN6ziz602kPc4KqVwWKoANP6mbkaPPgZ7S8LwuAOKEQ8WViXSsjjJk63NqzxQZ1bqV+
 AeOCMrNU6zFEMGM09iUKY/2vebe3l9ezW2uH7QAsprYAQlITHsiKGGGITVfx7IUkzbph6K1RyDL
 lsrs+c3Tp9pZZifbuzllumWNxFpmHIGpp1eszA7OAqmysJJvXck8FBPQEzbpRFTpRvOlrr7ZXcV
 bNI89olJoKMafLBgkGVokKfjAm/DfafSacTkLewoAavUOfpbl8dQnpWc6+YLXtvn+Fjf1w7BuC9
 wPpKAALOQ0HY74jvVlEMCd9ruDYFx6M81l+VN4Gm5WhFqbt7eb5HclN7D7jCG24mWaDw0VsWMS3
 BG1yCTiM1fva3wiVRQg==
X-Proofpoint-GUID: iu5stKoqXioCiRJ8P1KOS2XFwJCdZVAt
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a683372 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=RTlGP_lOJ6CgmFeI9PgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: iu5stKoqXioCiRJ8P1KOS2XFwJCdZVAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
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


