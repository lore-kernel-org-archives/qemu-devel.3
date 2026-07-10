Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36706C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ1D-0004v6-An; Fri, 10 Jul 2026 17:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1C-0004uY-BR
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ1A-0003RQ-Rw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:44:22 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3eiq1846381
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=; b=CabrPbpYCxSnie9L
 WRXHmcgJoUp6TwTqNhcz5Z1+Tfn/+GvuTZ0TvSRkDBLUmzX0N9rs+itZtw+f6zO8
 3UiNTnNAcxecvpxsaETCykzwBwHxGSnI3DtswimvtaWLyl4Th4/CagQALteQh5Ff
 Sx2sgj2r1HQfgE+8K4onRMN9NHyil+naS1eRjPhb1YcJkfTufyHOCEqpeWYYXUJr
 UVJyKhibNENKWk3jIu/Znupv20IC9UW63VVHEzo335fKvzDCgnMbUNSERcCjLC+R
 07nm7JhesYhzR2WID0KwGXKW8lBryowY3kBgUEIWxmuTFqYIV5LlGKuvyCQ/maJa
 f0OyDg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb649rj8h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:19 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c96b4f58ddcso1417785a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719859; x=1784324659; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=;
 b=IHENoYpbt7Qq8+BGz994h9xp+Gge3fJhCz4O0cHBuqY4ZU59SpfeEyKy76g8Dd3E0l
 rlCzO/qcxqkMqDuDh729XEpC96v3m9s/70sXj6oqNMl6YwkJ5WmtvcPjbPVS749NGt3L
 JJGk5byUtsf+rP6n1AyAI91239C6KCB1mdN0LkBfYqjZIJIyQwiDvFiajDGZ8FEaDW9i
 kA2m+F3YUZSYoZF09MlG7T6CZ8oXtdj0u/vWSL9k/j9RJyul6qyy6k/eYDxzz44oj70j
 aFAbfx065qMu1pg0wwVHIgE2YsBRVoUazQF3szPrsQKM8TKsh4S/3B2A0V5za/Ohax2a
 DtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719859; x=1784324659;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=H9GVrHpTcJmQRamduFE2CH7COe32mNk2XPsk6WVe64Q=;
 b=jR91kes9YIsx3FYQMYnTfct9rqzIwrRoeRBhMy0jG7f8eKUWM2G1EucxUmIwA4TvdG
 faiuu5MtweYlyv1F6eraKhoVbfZeTrBPzr6l8nbjL4yBxQTJIzTj3frMyTQGxKQmIjI1
 nxmJ68S4YXOXbojQjjuJznDIzfjG15ItC1cf0e+Tt/bDaGaQ1mdm/DkzuhpTiJ8OebrJ
 bsQVeDs5JxITGLwNFa9d+Fp6JPdzu+TKTwX6AfqPATYC0KnPUIzvz8hT6L1gaa66j7GG
 nybenIvkwumoiR+MuOa85yuV1z2POrQ0o3IaL0kfEveEjHhgwcS0Y7FDP3Kn5d+soJfi
 L1fQ==
X-Gm-Message-State: AOJu0Yyh3jhP+hTCnKqf0BuW0s3DFi/iAGeJZhienoPKIzE/C5DxGdEH
 5GC1Cm4dMuAT1TTqfEdiVacPrmkHR1nrIEjCh5id8lGG5wbuRGo5N1yovrT4C5FxGhgrLMexqDT
 nc/p2vJyD5j3SRjqE1G5rHE5uduiBM+3c31g3uN9lptVyuWNhYDuEwuUMK0jRnPfo+Q==
X-Gm-Gg: AfdE7cnx0lM59dcSl2ah+nWqaTKk/54OyxsjGfsUFmPuCuAcbr6Z1wKLPx7MJKdWHk7
 vJ3+IlL10QFP7SQ7KAyUFDH/uo1504wnQKF1IJvn4faYJj7R++aNUo/LT5fgjwkQX3W9Df7bJNq
 dC8x/XSKlv7fGV8SVFBIQlA1NpWZELWqn1PJHAkClvisrUQvhlIBh5bdy8p8/O7u37K8Y850Qbb
 FuuMdcJUwc805IlsBl25t37uo2KNV5XRtziTA6f6U8TIIW678ZM98cV107WgcHOfN8X2NhlCAoi
 heP6ipvtEr9F7gJJSu3MjKQhfggzjBIoyP9Mf7V7fMvLHUEEJdPBFJ7rAupZkf8qR2ZwAttZVDE
 y0KAdWi+XTzwjlje4cN6I8UZev/9XAbG+i2uH6MRII7ydxDgaLC+2I8JuTLGIrelw8JT64ZZgaO
 o9hC6L6w==
X-Received: by 2002:a05:6a20:d10f:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c110b2d858mr685495637.64.1783719858943; 
 Fri, 10 Jul 2026 14:44:18 -0700 (PDT)
X-Received: by 2002:a05:6a20:d10f:b0:3c0:9c1a:8948 with SMTP id
 adf61e73a8af0-3c110b2d858mr685473637.64.1783719858512; 
 Fri, 10 Jul 2026 14:44:18 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:18 -0700 (PDT)
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
Subject: [PATCH v5 11/98] tests/tcg/plugins: build list of test_plugins
Date: Fri, 10 Jul 2026 14:42:15 -0700
Message-ID: <20260710214343.2065491-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nySFJUld5jC2pbYQq1zchNiTRY0WypXj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX+YpFEJIuHLnG
 9WRRPk4r0RSd8DGgL0xEGax9ZONpMxK65Gv5K/6etLCKNQFWNz/9ZMzNZdc4O3C2v+WUzdl1FHT
 uP/px8ZvUb+80DOE1twP8vcOMiuPr/7DAij64UpTgUd/sJN90PhhY4+U8rzXHCtpz5MIB/T0BEk
 5thXjDPs4oJOGAOv+qgPwIsRsSLQklAF+xUVEwcqL3Kfqc+51QYgDBDk+FLSMfmT28rq/kZh9xf
 sOsxiwdNUyPIecpOxM1AU3jiWc2eQjWUU1CUVCglauRHJ2JJAGeDem9dzQxJ81si5vbZCnVRur2
 TPGiQb2D1SgJes819fCU5HhZOecwePmWEHaVTISighxli+yP/SUEOROOeNiAZHMdFqKYfKgceRs
 6ke9bNJwyrMoDMCgx7XLde0MzCjD9fQ9bpLk5YIV6rm7nz6FMmzA5lMx0nmUSWrwGK/F195fEwa
 BOUCsQlR+oB3HBafCqQ==
X-Proofpoint-GUID: nySFJUld5jC2pbYQq1zchNiTRY0WypXj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX5zzgtIrrpbm2
 1wxC+x2Dnq+TqCUnrjYfhynbW1HYTrTaus7Eb9Lc+ibqumWgZ0I4KMyfJTN3ob7UHB0W5tq3ryk
 aAvUiDDM61U7NEjCRF15EgeMOSU/J6s=
X-Authority-Analysis: v=2.4 cv=VZfH+lp9 c=1 sm=1 tr=0 ts=6a5167b3 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=mwllZrKobXNPg8A7wcwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 phishscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

We previously had list of test_plugins sources, but not the target
themselves. Create this list, so tests can then reference a plugin by
its name from there.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/plugins/meson.build | 11 +++++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index fbee86e6b4b..9940bae80a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -31,6 +31,7 @@ tcg_tests = {}
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
 # plugins come first, as we need to build the list
+test_plugins = {}
 subdir('plugins')
 
 # Finally, we can create all test executables and test targets
diff --git a/tests/tcg/plugins/meson.build b/tests/tcg/plugins/meson.build
index d7f8f0ae0ad..2abc317d1e7 100644
--- a/tests/tcg/plugins/meson.build
+++ b/tests/tcg/plugins/meson.build
@@ -1,4 +1,4 @@
-test_plugins = [
+test_plugins_src = [
 'bb.c',
 'discons.c',
 'empty.c',
@@ -14,9 +14,12 @@ test_plugins = [
 
 t = []
 if get_option('plugins')
-  foreach i : test_plugins
-    t += shared_module(fs.stem(i), files(i),
-                       dependencies: plugins_deps)
+  foreach i : test_plugins_src
+    name = fs.stem(i)
+    plugin = shared_module(name, files(i),
+                           dependencies: plugins_deps)
+    t += plugin
+    test_plugins += {name: plugin}
   endforeach
 endif
 if t.length() > 0
-- 
2.47.3


