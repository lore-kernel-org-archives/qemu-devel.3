Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95389C43211
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9d-0003xW-Gn; Fri, 26 Jun 2026 19:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9c-0003w3-9H
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9Z-00046Z-Q9
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:12 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxhlt796799
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R2IU8MfhF/R
 hCzV9v2CDkbBg8lt/rKIy+8UFTlWs2kA=; b=phXzdE3mNdqCQPE3BfZvIz2k6uV
 LwCwQvXnZ5A/R3Q10qZMCk6xlAip97GLpJyBAYOkItcAw22Bat8Lp/GSiPtA7505
 4Az6glhzimThotLQfW4L3tdvJznqYszqu5BSL5hjkfoMlzZ4kwjjSJ2xEYTZyZzJ
 6kV7ujG3UOLzRRtMVTgxTr+rb3kMkRdu1P0/awXR9sSZIppOq8TJEx9Vn+Akgj3n
 grpyIAoWf5Wj2Qzjj/jbUR+ovsURFWbpdlBRNKA4YIiqc2KSVEpv+W004UlfwFUD
 Ym7lER7ISbtkobximS9x8YdZ8cRKFFTVo2QB/ANR0YZoBeLoBcLj0cArf5A==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1ups9km0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:39:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0a27ad86so661200eec.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517198; x=1783121998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2IU8MfhF/RhCzV9v2CDkbBg8lt/rKIy+8UFTlWs2kA=;
 b=OUtDLAXCgnj7rNVfKaYM3XjhvJWaD8srCJxm9W902zjYg7pQMHvTMv4JrW0IT4oot3
 BEviP+8Zo82b/R9U5MUolbyaRAcoEFxEGp4aCX6wMoe4fTJQTYPqj6xhk/SfCBOQy8eV
 q0TmbYIzBPcOEonGTAdFzj0Sxuwa03G+1HtjrWKt7dpQn0rSzftDCTkFGaB9+mvhardL
 L7TDFjf87MmW4tY9I9hsv2XXMCI0X0SnC6Ci/vbnAXnD6u2u5sw0JtfUf8tncKCudALY
 7k2oBfW2ZsHcXWexcUOizviwlcb1G4lLWS139crWTNdoynMplYEDp7wMZxTsBSdRIHTD
 br/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517198; x=1783121998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R2IU8MfhF/RhCzV9v2CDkbBg8lt/rKIy+8UFTlWs2kA=;
 b=Jfrghrlji3djYM8bndtXEGseclwDbNQjtTNLLO1GWmcvbeRBHBGRViRKjR+y62qEEj
 4sf4HrlJlVnZmZfX2K+9TNucy8EIArG/EjSDwTQEkDy6DttdWbE27TnpTn2Cgyf62HRT
 Ycnjo1fMNarnZcLT5K5kYzL9mKqxFLxg1BGo1TQTHhFYQ59jLyRB8smgtz44pBIase+Q
 ZlkhosrDpWedvt3yBpKNHocIXO8RvJi/XI8YOGborjf09MvwUu+FHYVTuzR7h3j615Rx
 pHvVxGzQ5uOE9o4t5jRrpEUxKkKm1lI7wKjcyF/vAarfrUrksu0K+AZT/JVs7ottSAsT
 5cQQ==
X-Gm-Message-State: AOJu0Yy0hG/gn3LYJst2W+FYHY6wcAVF7/EwPmDbRSAKPmopYdZKyZb7
 eQKKfbLbN3kDfZqND/sumbhYlu+Sdk15Vh9sMuo0snx7nDDuTBI4fuF/pP+p7U2OrURgF9aZrT9
 20+TSGHVDOOPikuLzodnzAYt8M+N44rbTOOrwFaEYbEFZvh7d3HmibtGWCpdN0npjVA==
X-Gm-Gg: AfdE7ckhoufDfnNHmjLjFrlXUs6fs0+Vwe6wK5727InLPUCAXpV0vWJjbFSjeoNvcyr
 DpTnMHLZqaGn6b4sM+LC+KVqZ6G5HuXAaZ+CswzQzi276vPQQ4rSteDikp/gU254O1ivblG6LMG
 5eeMcCrK5GPPTZ6S1PKJJWG0IVjdMIqbfNiiu0bftERprXiTrsr2W0hZrJnQNmNaJgsHGQkjnNj
 ctpKIzRoqhQzUaRfwROrS6SXLEpDhUMOoZYy308KZa8xF2csxLrFIPA0arKC4e/AQ+NSX2LNzku
 9gEq+za2IwZK8zudgWa5d+/NId7t8D6dWAFfDL859XYX1p2ncon10FLeY82Ph+sB/swTISohZOn
 XgAdlszgOv1uJoqHc1MdlJgVLFitx3C5yNSWeJJlEqZEa/TfqzICyJqyDhRXDdqpxDbk0C54GkS
 KHEdVQng==
X-Received: by 2002:a05:7301:e8d:b0:30c:ab4d:3833 with SMTP id
 5a478bee46e88-30cab4d3cb4mr1733166eec.42.1782517197656; 
 Fri, 26 Jun 2026 16:39:57 -0700 (PDT)
X-Received: by 2002:a05:7301:e8d:b0:30c:ab4d:3833 with SMTP id
 5a478bee46e88-30cab4d3cb4mr1733130eec.42.1782517197112; 
 Fri, 26 Jun 2026 16:39:57 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:39:56 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 24/37] tests/tcg/aarch64: add multiarch user tests
Date: Fri, 26 Jun 2026 16:39:05 -0700
Message-ID: <20260626233918.158740-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX/EJU0/DyafOk
 4HVlayqWAVVt4zEqtodLNg9M6mDzE1/sYWn3pnWopIw4IG/iXv7c+x++wrxLtiz0+BQ3kASP+p4
 ey5btLEVJCDJBjwk+nLPD5KE773jO4e3PIT9q5Hzs7sWf8PpeXS0qoR1lZN50j1qyE+Gap5Xb6h
 tmIrUMbZZAnW6KKNV/OO3Qs/1hSRNBjt3mWYANNQfT2llDfTZiG5PqnIJrI1KOvjMsVjn3qeQdP
 jOGQfojihYNxxima8lWqw/jjy3M/dDWF40v9pmtkXWPmBWAgyphfWoMdresMZ8PdOLv1JrtpUU3
 DsLdy1oRdgnWXPeLfvax6asYX5dqcW+XiEGUBG9cEubUzgn+gZjdimvYyLxAcv+lFbdYrnywLtE
 hNt+UkP7y6yLdLWqY2n0/QDBbkt1jByxSIEuC/kZbTxf6eNmOqemCN74wmVrmYxeeDdFb8WnRqN
 0OoNVUjcF85RCxbgm2w==
X-Proofpoint-GUID: hcADTbU9UVFIK01-xWwYtFiVFWRlPMJt
X-Proofpoint-ORIG-GUID: hcADTbU9UVFIK01-xWwYtFiVFWRlPMJt
X-Authority-Analysis: v=2.4 cv=R6kz39RX c=1 sm=1 tr=0 ts=6a3f0dce cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=sYsyHSaelrBW26qggMEA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXyUeVTUw9HaVT
 9xEz7a6FfS4B3s0okThCDIAzVqJIABT9eCsDniz9UsJ3vQa7mGpRE7DoDOimfwFHW9/VBFs2Zka
 pixR+0ionxDnkoMjKn2+HHJrPMAww5I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can now add multiarch tests. We also take care of semihosting tests
here, by including them explicitly, instead of relying on any kind of
"per-target" config.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index e6cf5309649..53085278155 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -51,6 +51,9 @@ endif
 
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 # Base architecture tests
 tests += {
   '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
@@ -136,11 +139,29 @@ tests += {'sysregs.c': {}}
 # Crypto Tests
 tests += {'test-aes.c': {'cflags': feat_cflags['aes']}}
 
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
 # SVE Tests
 if cc_has_feat['sve']
   f = feat_cflags['sve']
   tests += {
     'sve-ioctls.c': {'cflags': f},
+    '../multiarch/sha512.c': {
+       'exe_name': 'sha512-sve',
+       'cflags': f,
+    },
     'sve-str.c': {'cflags': [f, '-O1']},
   }
 endif
@@ -204,6 +225,18 @@ if cc_has_feat['mte'] and gdb_has_feat['mte']
   }
 endif
 
+# Semihosting tests
+# Add -I path for semicall.h
+semihosting_cflags = ['-I', meson.current_source_dir()]
+
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
 tcg_tests += {
   'aarch64-linux-user': {
     'cc': cc,
-- 
2.47.3


