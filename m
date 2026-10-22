Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70268606A31B
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=R6CSgM/i;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ftrV3cex
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzES-0004WJ-0a; Thu, 22 Oct 2026 16:17:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEP-0004Vs-Jz
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzEN-0006Zv-Rq
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:17:45 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHBmq3741653
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=S2ymBCamd+5
 T5B+NhGOKZD9Q0Loyi1lb1HEPe6UZN/4=; b=R6CSgM/iyWFdTYcC8zWT0G4RJog
 a4jdVeYJquAL1z9eoCV1S/aqojdwnAI41FZFrSoSRz+EODQLwoI6RzAk4SBwcH0G
 YBpnzGO6NNEc/A1xotm7q/PWq70j1jScxj0VD4ztm6xaL81m01AzxVyI6WWN01zo
 4RykYzdGiuuoAoGzuuWkqImPsDJoUOilEMzMMXdY3OpphAD++At+AUWY3VJUx6fC
 sVJhfL8CWgb5vPViEsnI8E/kN1i4GGkaPWrZJv8AqxDJng2FgLYvvI06biMGTz20
 8Dnb+Rm54KLYnl3QXN/K+unsOOSPQ59nIiGK4Dq+L1ZE4rSajXt6LcQsNBQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqms0ddu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:17:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a01ea9e318so296945b3a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700261; x=1793305061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S2ymBCamd+5T5B+NhGOKZD9Q0Loyi1lb1HEPe6UZN/4=;
 b=ftrV3cexD+6PJHKMqW7rTjwg/KD/eYF72vSzw4eK1H27uksgPAgPP/dZRXQ1L+cGE2
 /UpCOD0xpbVxYLQ+GJoi4TJdEfp8olNx1NLa+bmRlRR3c6bm78Usaz71bocCnN24jR00
 dMJZj/jw7RjsODnpmMY4HPBfASdgfjlAqruHudCgIB35z5cbx9xvste3A4TMdipBiy4l
 HMJbdQnjn3n+8Ub68bhNUu270ucxyMMzqaMwQr3SbauuImzMZBozZSS0oKax0H2Lip2g
 OSxhF3GFeD5kB8q9ljCu9pJ0WVGn6AoYIFrj68LkRJ/F0D8EfMYtLlrgffoPKcijshoX
 uLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700261; x=1793305061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S2ymBCamd+5T5B+NhGOKZD9Q0Loyi1lb1HEPe6UZN/4=;
 b=BhO2CvJwc5rPTr9AQV5ZY+lFYG5V8Vqml6FB2L49k7Po0BhDV/CPk3PUtbJGHlW8uf
 q5XsE8zpGRim1ml891tZ5PtKyY33sz2Hxv9W/345BA4Hy5SYkDTkea6etukxQS8d2U+X
 OVcw2DHMZKKKw5UT6+jdDuKzoSVlCmr/7ttesL4EtLo0QrOWSXRUB0Nm6f1mnLcxaFdH
 HGX9rD2JNEUJviN7L+zArfR+mOKvvMO3U5K02ExrougDJKEi4T8J5OzDvjLMTLveXo8/
 JAsemlEPOY9kr5lH9CKe9CY6HWiDOjFU+VDeWez/kLdcQqPCmvvOe6lxLCsH0412nYVn
 Ltyg==
X-Gm-Message-State: AFq9FYLMGNwJHG240XuSUGa98dD71T37vMlecgtsnNRSruXzqU+EfTDz
 dQWk/FECLA3sB+4l09MJdE76zgpHth7X/I9bnUUfbwaDT1Jg1f+jFMlV1f8PWn5JTAJOJk5pW06
 x6GaXGMdui1Dw/lUsA+IS27biwYAgnO97ewYjgQrfO0njk350GjGW6ILQ/xHcMUuoqg==
X-Gm-Gg: AYBFou3az04bygPM0dNgn0+uvtIK8q63EHItTs977hXu6fBNX/hRAQtxvF4Ml4h8IEe
 XLx/ZUTJSQyRLGPC7Dg40UNa7x3F11p+HI+1LHqRe/1KMzM1hEwGlsGP0jjruY5AsdhlpaNzAU5
 QD6zklQ0DoqTimPfsCkgZuPUEfgYdIZkeEhYtklFPdSfKrIowagb+oQKalHalWk5COVu13B7co+
 IJgb+pnGztLbuwbhgpfugx37e2OQGGLx96egJJNUbTuvMQQWkRSIDm7L/Up98kmmrXIxJut9X1U
 84lAP+lwS0HH3+aJywqq6g/02zYQr6UmfMfUJy3O9x16q3wJ2DCk6Eey9KSkBgCRxMu2NjJZARH
 V2fSoHohAh1vDKSklc4yXDv17MV2Wc1D+XZvB/eYp/jnVsyfderT9dhuCVslGk/U=
X-Received: by 2002:a05:6a00:3398:b0:882:905d:aa05 with SMTP id
 d2e1a72fcca58-8a2c665c21dmr241082b3a.50.1792700260630; 
 Thu, 22 Oct 2026 13:17:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:3398:b0:882:905d:aa05 with SMTP id
 d2e1a72fcca58-8a2c665c21dmr241067b3a.50.1792700260122; 
 Thu, 22 Oct 2026 13:17:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a2c89d8138sm55163b3a.18.2026.10.22.13.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 13:17:39 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 1/3] tests/tcg/loongarch64: restrict gdb tests to gdb >= 16.1
Date: Thu, 22 Oct 2026 13:17:31 -0700
Message-ID: <20261022201733.1941651-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX8Jbsmns5cAVh
 +NT/efKjYY3JtkoOudAA9++RVRjamxjNr7jkVrGGjYG0S1qnAh5s9jwzKlV+cve9SA1j0VYWvKa
 rL+vXEAJNCbB21pXjWBxjXODxb55M8MnKWtYqbRnwNl5mjvmWWbMP7t9eD12Dc4tW1t02al1i1L
 Es/6TSdLJ2eGZhN1JG/wdE3F0kWJniPkjbPiVw/uB2FaLys+TjCZpOmaj06mn2tCeibPTG1gg4k
 89RXfDVwjZGXYexskYNjpr3s4rO26Bf+vgvSzRnXEfpQFCkTWpoWuoBaqw7SkiBiVtrIG6q2byt
 Njd2yMONAp+FwHVpjjRC4m9cB77WMxtxuZ2Cyj2HHghDjvAZkzGkrMHH7mKvd3j6ixyO3ZOlE4u
 XyyubzjYtOtj/bKVvGfC3XXuAmEyhuMYTwD238YE65bhHp7JkuFCmpBA+cFCD3WI9ECPNNDDMNk
 D6QA99uNbTGyFtiZmUA==
X-Proofpoint-GUID: STgwVWZ7qWTtdgzxjo4LT7dBvV3itjZl
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MCBTYWx0ZWRfX3b0oLgFkWf8l
 sJsNYYLVHDcwPn5KgsUCMzm0AbXJfTwlNZZ6tvyWySfdrcOHDf9a0Ypk8DhQzrOlPMhP+OFigl3
 ZrpBnbfV1WFmKwaSx3TL3b30GtxKlms=
X-Authority-Analysis: v=2.4 cv=UdbE26SN c=1 sm=1 tr=0 ts=6ada6f65 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=e1-sUNc-TyRcsT6M2wEA:9 a=2VI0MkxyNR6bbpdq8BZq:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: STgwVWZ7qWTtdgzxjo4LT7dBvV3itjZl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220080
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On gdb < 16.1, there is a mismatch between our gdbstub and gdb target
definition, visible with gdb message:
warning: Architecture rejected target-supplied description

As a result, loongarch64-softmmu-gdb-memory hangs due to gdb not
completing a requested operation. To be safe, let's restrict all gdb
test to this minimal version.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/loongarch64/meson.build        | 16 +++++++++++++++-
 tests/tcg/loongarch64/system/meson.build |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 4dd64f16d87..bff30cb49c8 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -1,11 +1,24 @@
 cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 
+gdb_feat_version = {
+  # previous version report "Architecture rejected target-supplied
+  # description", exposing a mismatch between our gdbstub and gdb.
+  'loongarch64': '16.1',
+}
+
 subdir('system')
 
 tests = []
 
-tests += tcg_tests['multiarch-linux-user']['tests']
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    if 'gdb_test' in setup
+      setup += {'gdb_feat': 'loongarch64'}
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
 
 tests += {
   'test_bit.c': {},
@@ -23,6 +36,7 @@ if 'qemu-loongarch64' in emulators
       'cc_dockerfile': cc_dockerfile,
       'folder': 'loongarch64',
       'gdb_arch': 'loongarch64',
+      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-loongarch64'],
       'tests': tests,
     }
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
index d1ee3986b62..0f81ef9cfe3 100644
--- a/tests/tcg/loongarch64/system/meson.build
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -30,6 +30,9 @@ foreach t: tcg_tests['multiarch-softmmu']['tests']
         continue
       endif
     endif
+    if 'gdb_test' in setup
+      setup += {'gdb_feat': 'loongarch64'}
+    endif
     if src not in multi_src
       setup += {'cflags': [new_cflags]}
       multi_src += src
@@ -45,6 +48,7 @@ if 'qemu-system-loongarch64' in emulators
       'cc_dockerfile': cc_dockerfile,
       'folder': 'loongarch64/system',
       'gdb_arch': 'loongarch64',
+      'gdb_feat_version': gdb_feat_version,
       'qemu': emulators['qemu-system-loongarch64'],
       'tests': tests,
     }
-- 
2.47.3


