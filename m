Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C27C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1Z-0004zH-HF; Fri, 10 Jul 2026 17:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1X-0004yW-UT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:43 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1W-0003Tv-G1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:43 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3mCc1648715
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=; b=WDNy5Qd5HuLPkCGq
 7aizldUL9ClkUUwWE/E+Qg335gnDRqElM9ZX6jM+pYmEnVYSH3mWTw3xFxzVRC6h
 UvL6/vKaXUA5hhpOAyrI/iwHXxwv0p4Hb5D3pAn0xsKISEjCi7u2v/IZYjNdoRR9
 tyUt6wwtXSZisOqzDCHXojeH89o6YaqU3yktztzG2iFb2WmYqg+P/DiNi8xp7u5t
 aHdsrJ4lYukh/9lIUGrmEW8yWibKH6AIJStYSU71cjlr2DrdsMfAHR/jsJtcwXuT
 z/NtO0qeKP2A5m4RunIfXmpSJjDYoI6iKGP9gzZJii8C/MnabbcSX6X9oFtTL4LH
 gyNzmQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2txhd21-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:31 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso1223056a12.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719870; x=1784324670; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=;
 b=U8HBSa7mN3SIl3ZFPfp1Kl21++8Wec3ihqCbLf0tuhF2vsjWLfTFqWehEM6JAq90d5
 otw5LhUI9TCXV2TBVMXyTVutleUe2moy90PiAYOyTxLcpBfkMPuyZcGbys5SRtLIaCrd
 CiVb8mnRkXTpHDgn6k7iBdFzOX7wuUty+gbymBGcwmH+7IGzSkO4oDlTX/1deQIya+eY
 qHktMPANW7o7mKpIsBun1pOPjb16C3wgpNYiMVuMZaE726T86XCBV3MNb/aLaTvxU3y9
 3IXyHIDu1UYt5IctChhhdUqSs6UmYqzIOUz7T5nM71NAWi2t1cS7gbcYKQedPkzAJLAC
 S1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719870; x=1784324670;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EkTG3C60HMApQK78sgZZ3vT1FYPGe2586k2i/gjcWiQ=;
 b=bnIxbmhcEwDMcrGrXnHMCCMXJKgDBPG+2cZMhg69Ns8gVIl80PRGpsJjuKUkU0MV8F
 P51G52RJafNr8jQKWtD8K4J9JYLwcCbxe875iADFt7rGqiwib66q2oKqBffGsfieZyfZ
 gKuHwvr11U1mj5nmuOYOOnQDfnTPQptLZV6V8LNNoPbgkR14jub1hu0O2ZNIibfaiL4H
 +kB8MFfvhCshFxtTGf2hB1xsWZUQf3mzb9cGrMZiozmv5gnodBHsaWfV7aYfpTEDqEAN
 NzgHAc1ag5PtQU7OLjRKExtsj16l8S+KArJMBPnXSDZbyg607q9PSwZMIalTEM+yhVHC
 jnVw==
X-Gm-Message-State: AOJu0YzRslI6X89p/jbLmzjUPoR4Jopf4u1fZNIgR10Uej++hSqhdzTd
 n48hzJWNG//B+hE5fG+0+dHDpOEjtequPTy0LYO/b8yVELR/pPrDl0dkCp1WeDag++VWXBtQm4+
 w/YSaAoQ4v1van5rj26qMjraN/E3JYLuXpFH+t9hACT0tjNRp0jQJk0fFWc9oFp+mcw==
X-Gm-Gg: AfdE7cn71jWPTHz3wZO+GIKw9Bvsj2Fr4z2nYQhOzOPGYJkPX0+9vCuUhBf0Ni9xK4M
 qEEdDBP70xxanMjCev+GTUuLzyNumca6eJxuDUH+6KDSMeaCUvAiyUPfD9kd8FFBErV/tfzjmIX
 Zg9yGAh3Yq6ZLjVSNBB+VBw9UW6LVP54qu97tCD/EPr+k4ymOmwuW8ehJkqLBiojRGeW4a+lSBd
 JKAYHRCUcnwtyQQSZLJ30Z7GA2+yNy2hSHqGj0Cq2CtXwUSRPUqbXfjVMN97SqhmmbVlQVKX/Xp
 QkeSBx795z8ptKXQgUxVd2rsjWJ65cYDuKscpr5bYf3FOhPAPjIMOS0phC9GC4I3+ZRf6oUUGpk
 ckDZgCysg0jGCmIfNS40Kye1zCl8Tm0EfuaeM+COTi35C2pEEHSEMhgRBdjNeT3BiD2rWm6l+wV
 KSbkxtlg==
X-Received: by 2002:a05:6300:2290:b0:3bf:a624:decb with SMTP id
 adf61e73a8af0-3c11063e3c8mr644908637.27.1783719870517; 
 Fri, 10 Jul 2026 14:44:30 -0700 (PDT)
X-Received: by 2002:a05:6300:2290:b0:3bf:a624:decb with SMTP id
 adf61e73a8af0-3c11063e3c8mr644882637.27.1783719870078; 
 Fri, 10 Jul 2026 14:44:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:29 -0700 (PDT)
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
Subject: [PATCH v5 19/98] tests/tcg/meson.build: add wrapper record_replay
Date: Fri, 10 Jul 2026 14:42:23 -0700
Message-ID: <20260710214343.2065491-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ELM2FVZC c=1 sm=1 tr=0 ts=6a5167bf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=YUi3GN9lKCUlzkXueeIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: s51rRXqdaB-YWA1cOzJP5IQxUnOVO7Wl
X-Proofpoint-GUID: s51rRXqdaB-YWA1cOzJP5IQxUnOVO7Wl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX05YvNm945Vy3
 96i1dtE/P16k3i72LWefUTMxe9ykOLHoNkw+GT1BDfZYynyYpl5qm8peSRUiiHT99uli4Jz2BaS
 G3olmAPIFbt8RKNjxbkkMGczCLPOBRRe4bHHjYS7FfgIHcGXeHhwxofQQGc1rB1Me7gfnsHokb2
 4RNZ0NPFvlEdWg49dwuWkvD+KgQTeHN7jJ7MtxGc95XY5IkwztkiOAXUp/3o36i1rHfSl27TiBd
 cJxnzvJQArgV5xtNUgi5Rr07viIM9NRRoogY9OiYpsQkzRrNmTUa0jpMQR06mxtcc62yqArPsDE
 2+nLqj4KPeoM7yQw01pVgHxKtwjVAUtNjlYdq7LQeaAmb8057ezmuGHB3/vqKnfWEm0wKCqHHLO
 GjDVmauqkGfwbsSGF7Ah8L8jaPp8EkWyZ+JgleV2urz+ASutcKgOytAgo9GJ23ZX7R9PUWaojOJ
 dRPh8s3eaFjlwHpKtQw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX2F39v0hhz5/O
 KMUdrtKmpOJHaPjZhww6yyr7RqTq9o3/KIk1XftiibCLv7aBAUlrrZkj1kWZjxNj8bLzk+E4l0D
 vicaWtMtQb7osaF2+QKunPd/HLyaH4o=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100218
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


