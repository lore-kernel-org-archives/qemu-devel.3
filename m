Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C97C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrtv-0003GC-JH; Mon, 06 Jul 2026 18:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtM-0002jt-Sd
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtH-0005TT-Ut
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:19 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE7Jg1428953
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AsbZGP3a1C0
 AhyvhtjjgG61t7DxO6f5kCg+Wcc0VJNw=; b=fjIC0cv3wsfsv3qFYofJpT3wy4R
 HqcWvoF0zZ/cn5CVZEXDLyHmfSQCsPqlENN2WHWzRkAhNJkFkKQ7JXXRJ4Loiorx
 tmOyEPFA2swr+XiGwXXZ9RYcR+GZgCr0kIf8yZL/qcUdIWbWr3TOkkq1nG4ijrOU
 f5UO9/jBAf9kTAWuexKX6LenAQmonbSnmnIaoTAee6MIQ6BTKKHWnk4hCYftb2WI
 rqZ+jteeMmWbH3nTcaDQacyY/LWlL0PnZTdhvY67+FEPDd0jLPhVTpbN4rHDWw9m
 JHsp49vNAczcZoKBjfS3Y/CKiU4yFik0k9kGKc1YTvnq5w/Q8PEyLxdd2hg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxut3d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810960140eso5624759a91.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377251; x=1783982051; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsbZGP3a1C0AhyvhtjjgG61t7DxO6f5kCg+Wcc0VJNw=;
 b=hNgyMUhtPsrL+DrH9DRbMhCSytIP0ePiTjUTUsoQ6FhQk+CWEUhge7KPix98wnJ+aX
 f3wOyYKC2rKESfgUO2yRnfI0XX8WPekHPfE6yZE8UFJMNY8vJfA7u5x59maUBkDdosTd
 GWrmhcJ9cTxTM6FZ1nJhhZ+O6pXwClmVQw9wbC7ladDG1kbOEUFvnUugDqvi3wS+q/na
 UBzi8NEjwQ/Gq3utr7G6Do/OFL0UAx/x8rMpEfbPIObsq6VVTOrPvH93AyPxlQnblnra
 MWoBBYTFg2niA5jwn5FDZvCwx8qmvsPHzXsYS7YeEulXxOtI49fZqWp3xtXE/CHudiCh
 RC/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377251; x=1783982051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AsbZGP3a1C0AhyvhtjjgG61t7DxO6f5kCg+Wcc0VJNw=;
 b=nRgZhkz9Um8FyFa8XqvKBa/2obFy+xVblYxKtN8022nmqhxy2IlM/pZENEUu9MfOLE
 K6imt1gu/agUqGBZeoTT48yE1vw4n5eJjq5mCv33lSow+9dem52H7pGJm8CUOhWTUYzg
 nh6sSJHo1bWJy9GO7R11jrJbb4vgJSaljQIDcDVrRMP/JpITLUhKr3EOjhfYcRv2D8tG
 yVO3/pKTzUTEy9ctrPmrBJ7DfXgHSMNcLNEqyAr1DYmB60C9BUEo9hxDw6DOp/MXC6Wt
 BTZVQ6q8W3w+ygEZUewwll14opTAUXjFjZ4wcJmCClSUqNCooinpje5ELCV7n2hOb3s0
 LSjQ==
X-Gm-Message-State: AOJu0YzQsqXqJdXA4r1O5L6vNHnkHvVOFzxaySqHEgINDZcnM2I2Z1dx
 0auKhCxe7ajyBnZA9FYHzhfg+RGLrRR4bf4Z9Z4N4+hseULc1mamPGPv2FWGOwtoBDoliykmeuu
 d8Y3guGQ6O/7IKj69jHZa0O1rHza5MCkI77MOlOCRn6eUcNVWGmuBllbwTTj5qnoLEQ==
X-Gm-Gg: AfdE7clqsN4TWXjC8uB3vIohpSfsBLqJsrLoJBi6Ul5Ho98fU1VBQ1bT8j3bgskZwCj
 9Knf7XA4TmHHqAIxr0CDxzLRmQVahAdg5VqvAdJLprCw892/5pE6OSC/sCQpSF1cOo9lEarU6Bg
 0d8n2JWbn1WXqXXDacJC3EKSjy/0zkSWwNq5ast+KZyVYH5mAeitiikG4LPMYMJnLovnhIzUw0I
 77HL3NraabJ9NkKH0MLsOXSuzNrH6Xd/VsKn8Y0pMQUebBDXZoFMjOO3HId7K1F14bQdOwRwAEy
 +yltFEgb2lQosfiJFlJiS1v2K4ZN+qrYGFDFI3oVdWxttp17nlNSixH+/x+8ffp4ShiDipRZAWo
 5Li7RYPy0bjwptm3t8JiInRLo17FxAxLK55RviDWXxH/TKe2F9ybWanYDztjvMKpS6ty80X0Ot7
 +vL4IUpw==
X-Received: by 2002:a17:90b:3a4c:b0:381:c7f2:f312 with SMTP id
 98e67ed59e1d1-3875576864cmr2726847a91.2.1783377250875; 
 Mon, 06 Jul 2026 15:34:10 -0700 (PDT)
X-Received: by 2002:a17:90b:3a4c:b0:381:c7f2:f312 with SMTP id
 98e67ed59e1d1-3875576864cmr2726815a91.2.1783377250361; 
 Mon, 06 Jul 2026 15:34:10 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:09 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 12/91] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Mon,  6 Jul 2026 15:32:24 -0700
Message-ID: <20260706223343.988769-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MGL0Q-v0bOtNxl37RBnzPRc_o9hEksf0
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c2d63 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX4J2mwOgl6fcM
 dQAu/JdJEHf5RkFGQ6HctUp0FhFdkN5dY2Imb9Pte3XeQncyABJzZaBGl2m/nhM7Pr4IMk5dNYx
 TBLiILlm2miF/XyFFr8IdMSKIFv+tk8=
X-Proofpoint-GUID: MGL0Q-v0bOtNxl37RBnzPRc_o9hEksf0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX0Ym0v+cseZAd
 LUuOJUOKsakEWTK7xZ/LRWFC3xyP01PMbA0fF2gHP+UUXQXEoE6tYqR5+MuixPn3qejY/7L7X9T
 uCRQQFZSuj0798NiNcQI+fXXamsR3EdX3wPf879nyvffw9yOxRUqIrn6vNIJOA53UzSxclx0GI3
 VolFAWYbky3NrvtU9HdzwKhUUhpxnK2nMNB8HvUTu15LMeXtmKOhCvIDydS0qFf3i6SkhJ0d3Hp
 p5qM4Top4y/hDYUchSLQBmSwh/WEf69Z1+vwMglUh/YwgXpbWSGvyo/gVScYmB3B9zVVNUGH0L4
 8r3U9RvDTAmiQDpqxpJI1woTbLaplSiQGBWj2/n8145Hj9nBbdf24AZ+2mb9Zl71Oy8vBPNVo7H
 fXA+qOH7WQDH2Sk5v3yrBcIO6XtKMaVqqfE9o1H3VWNPLFjisA/kwlPWLw57HRcFzXBaek7JQsa
 pk+PhElFZzYV7AxXh5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

A given target can now declare which gdb architecture it requires.
Also, we add the code to check gdb capabilities, and version.
Tests can use gdb_version.version_compare('>=X.Y') to test this.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 9b29669977f..b1655f5200b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,5 +1,11 @@
 env = find_program('env')
 
+gdb_progs = ['gdb-multiarch', 'gdb']
+if config_host.has_key('GDB')
+  gdb_progs = [config_host['GDB'], gdb_progs]
+endif
+gdb = find_program(gdb_progs, required: false)
+
 tcg_tests = {}
 # tcg_tests is a dictionary with following structure:
 #
@@ -7,6 +13,7 @@ tcg_tests = {}
 #   'name_of_target': {
 #     'cc': cross_compiler,
 #     'folder': 'folder_for_test_src_files',
+#     'gdb_arch': 'gdb architecture requirement',
 #     'qemu': emulators['qemu-...'],
 #     'tests': [
 #       {
@@ -34,6 +41,18 @@ tcg_tests = {}
 # declared using 'test_name'.
 # Default name is derived from src if 'exe_name' and 'test_name' are omitted.
 
+gdb_arch_supported = {}
+gdb_version = '0'
+if gdb.found()
+  gdb_version = gdb.version()
+  gdb_arch = run_command(python, files('../../scripts/probe-gdb-support.py'),
+                           gdb,
+                           check: true)
+  foreach arch: gdb_arch.stdout().split()
+    gdb_arch_supported += {arch: true}
+  endforeach
+endif
+
 # plugins come first, as we need to build the list
 test_plugins = {}
 subdir('plugins')
@@ -47,7 +66,7 @@ foreach target, plan: tcg_tests
 
   # return a clear error if user misspell a target entry
   foreach key, _ : plan
-    allowed = ['cc', 'folder', 'qemu', 'tests']
+    allowed = ['cc', 'folder', 'gdb_arch', 'qemu', 'tests']
     if key not in allowed
       error('unknown tcg test plan entry \'' + key + '\' for target ' + target +
             ' (possible: [' + ', '.join(allowed) + '])')
@@ -56,6 +75,7 @@ foreach target, plan: tcg_tests
 
   cc = plan['cc']
   folder = plan['folder']
+  gdb_arch = plan['gdb_arch']
   qemu = plan['qemu']
   tests = plan['tests']
 
-- 
2.47.3


