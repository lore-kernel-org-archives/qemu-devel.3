Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20811C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4lN-00067P-MY; Fri, 10 Jul 2026 02:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lL-00065h-KT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4lK-00074h-0C
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:31:03 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nDA93752782
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CQeLz0XxYpG
 03i9a5xZbeQJJ+hV0CYQmYg7vFSmbQPM=; b=DyTRCDNj2ypUV7tKyXEmroxL1+W
 WZISA/9Y0cYSxCE0+apxzVbyaNM5QV/nW7ooriyuFm4nRcrNneHC8z0pW8CgjXe2
 7qvcG05J0SCsfaH81XYDeiSNO4VqLcsXxXNeG5ZH3cMKV6dKjvG09c9dloCKYEnO
 4q7TH+bQ7KUtc6x+gA1KUMl43xd6t5RBv/hfhhOi5JQCHaAuMUD4mCW1tLYShovd
 R++MEa8oNrikNsLykyTggZoWljc/mMSLMzlWYMQtTBWVwq9nfXVOh2gdVRMXhEZu
 hNKxFwPhAL67yvAXJAECvGCvgTPuGH9rAUOM5Ln0g2dS24WIlJg0rNsu0Gw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbb17-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:31:01 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-381250979d5so809091a91.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783665060; x=1784269860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CQeLz0XxYpG03i9a5xZbeQJJ+hV0CYQmYg7vFSmbQPM=;
 b=QCRGnTScXl8H94SYmNZY7rkbOn6FMy6O1D1SaWWYXJ04rjyJLQhSpP/esurpSo6n1E
 TqSo81YTzyDI7xH76oO5Pm0socyN0rmR8z15ArtnLagI0nDXSqkhn7tSSLbx72c+cM9C
 CBRFxE5Yh/Q6IotwkCbSbO8BTob3IjaG3+RJv9zwDwpI4ty4+aSPMI775Nt1vIyFhOjm
 fvc7FCSy1yBTqgxqeiN7M9+5qR7cW7Jn8crmmDtLShnq3UjCtpR2mItz8NoBOJHMg6Rw
 5iLZH+CBPVmTcGhQAve6usyJeQvzN8W4bD1vvIe0rg0Z2H7njWbx9Mz/LTasidwI2/XZ
 Lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783665060; x=1784269860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CQeLz0XxYpG03i9a5xZbeQJJ+hV0CYQmYg7vFSmbQPM=;
 b=mj8lWtPr8zDejQ0l0GUc8Jjxcfs/IovlcHYFd3n/cvpc0U1K15iJ30TWlu/SDno3dk
 2PoKSRbOk3QuW+BYNxXO/hkOfmxxffrgt9VvefpAjmYlr5zgmX84Qupe0anUgZnL0u6A
 jmK1tc2x55I0SoMwVgYtzXRNu9/JyFTW3gHrTE0at6TgeFshekUgYh9Pq95ggsuvcMmc
 eQiG7qAN7eC+nRthw5dc7qSKeFUrXVBEw62InH6RE/v5nXKJ2WHqDvlkF/fCF8gEU0GD
 GiytuTdPRbUH4t3bpeS1hrcbtNCoLQlsoaxhxw+qtqpDPkFN3N8bzflWcsqt4PehEH+O
 cmHA==
X-Gm-Message-State: AOJu0YylcvRoYUpPdnMwrw80vJkcOqLWwoHwiBwlvXQHkky/pWN+k7ZC
 40D8SEUKL8XnywvsgwMYm7yxGItpkLt8KU1OVR6eIYTrXl5N3GAPpVp8/LEuzaXqX0yFukclgPg
 dK+MUs2KkWS4M5xMrjuzr3h7F05SiDjwX6hUTVn+fMJQW+hnApbRhoaWTdhnHZHr2TA==
X-Gm-Gg: AfdE7cmcDaU5tc+Y4YZeR9wfupozovubag20eUz0GJsVWewIFOZ3010V6ASgwCs7ARS
 nURfRarZiTX9qBAQD8zq3LDSLP6OBM6r4O+RV7CfKPlCFBQWsuw0erdGw/sW+VPX4Q8nn0oHccI
 z1vtMDsiqCzi83dkzRMeoxrnEckhPpAXHxr3ZKD5x+sndK9tyGMBmIo7iGEeZP9LuRgMfzfAWIC
 7tLjf8rOBDIXbdpdhJZKCp84Z72aXjgqNPejv0wX32cHN3sv+shlc70eI1OMwmVOTtZEbDsQvt8
 QsyxtRl9IgPCdUQgttnxLd+/Ikv0PQAq+upG2th79pGcu0Xj6vkNemWFHgMUrdUIMkMqV56CcBE
 7Tr40tCdltq1XBRKdaZbAByAy6nCEGmHDDoDkyR5bRxcxyni+GVhZHQDFlJeqGUgdO6RkZTLcMo
 ApBA5SDw==
X-Received: by 2002:a17:90b:3d87:b0:382:3dcc:1487 with SMTP id
 98e67ed59e1d1-389417e521emr10268228a91.25.1783665059911; 
 Thu, 09 Jul 2026 23:30:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3d87:b0:382:3dcc:1487 with SMTP id
 98e67ed59e1d1-389417e521emr10268184a91.25.1783665059414; 
 Thu, 09 Jul 2026 23:30:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3120c8e41fcsm6258960eec.15.2026.07.09.23.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:30:56 -0700 (PDT)
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
Subject: [PATCH v4 86/97] tests/tcg/tricore: system tests
Date: Thu,  9 Jul 2026 23:20:04 -0700
Message-ID: <20260710062016.1818125-87-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfX502OeTsvvrrG
 YUUmjkzxyj5DKvMWXxVW+wuEkaY9CwQ6WRjURyoaQF2anIN8/tbS8wh7Y9vkhNIbnd0AM4rT8Lv
 cxtIbPmInxyaqeZpLZoSyD7phkMg0vwL4w7fwyZxylBjKWwpUmiHiACjMDsv6g/lZ3yIQlOFif/
 1j3ExqyxhgktHmKCxAFzZyfwlU1QwTUA/U9rMkorrNcwmXfsijHuf5pvdcPZgSYTQ1bQOOFX+pP
 gtCb3ADZhGigEP4IhYk/1sIfe3zKA1p/1ZFa6wtnVbhNOpmFlbxL+q3Yd4/kkWPpUP+4SSKxtkh
 mKCEYNGWBurwoXXkWutgJGGa7BqYemAwADlFyD0/n0ZPfAo3b8PAnnl9ZH+J1+JucXnCdeWHsg7
 LlTD4w8EFVyLpMKn9ZsBEh0/0EyPaB3pESmm1Yz0b44/5PTh7Ic/iTbx0zQXMu9lkdwTYAYAqYR
 N1CZmZUUwEBVMWwx3Jw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a5091a5 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=WCfeKl26imQaTshtMjIA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: 2B58aFkMNtAdM6Bc0paL5bj95pUEPuT_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA2MCBTYWx0ZWRfXwqSKAZNSSSBa
 f5yzUG12OcAGjcppv3sDwSa9hwThqlg3vy0qfvYJr/4YFfHtchoVp+Jv0zqJKOHVkH1bvr6XSXs
 nL/GPoLN/F/ZTzx+jnHU8C0azfaSNr4=
X-Proofpoint-ORIG-GUID: 2B58aFkMNtAdM6Bc0paL5bj95pUEPuT_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100060
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build         |  1 +
 tests/tcg/tricore/meson.build | 57 +++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 834c3aeea81..4e81091cb6a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -151,6 +151,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..d0bf55dedce
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,57 @@
+tests = []
+
+link_script = files('link.ld')[0]
+crt0 = files('c'/'crt0-tc2x.S')
+asmflags = ['-Wl,--mcpu=tc162',
+            '-Wl,-T', link_script,
+            '-mtc162',
+            '-nostartfiles']
+cflags = [asmflags, crt0]
+qemu_args = ['-display', 'none',
+             '-M', 'tricore_testboard',
+             '-cpu', 'tc37x',
+             '-kernel']
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+setup_asm = {'cflags': asmflags, 'qemu_args': qemu_args}
+setup_c = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'asm/test_abs.S': setup_asm,
+  'asm/test_bmerge.S': setup_asm,
+  'asm/test_clz.S': setup_asm,
+  'asm/test_crcn.S': setup_asm,
+  'asm/test_dextr.S': setup_asm,
+  'asm/test_dvstep.S': setup_asm,
+  'asm/test_fadd.S': setup_asm,
+  'asm/test_fmul.S': setup_asm,
+  'asm/test_ftohp.S': setup_asm,
+  'asm/test_ftoi.S': setup_asm,
+  'asm/test_ftou.S': setup_asm,
+  'asm/test_hptof.S': setup_asm,
+  'asm/test_imask.S': setup_asm,
+  'asm/test_insert.S': setup_asm,
+  'asm/test_ld_bu.S': setup_asm,
+  'asm/test_ld_h.S': setup_asm,
+  'asm/test_madd.S': setup_asm,
+  'asm/test_msub.S': setup_asm,
+  'asm/test_muls.S': setup_asm,
+  'c/test_boot_to_main.c': setup_c,
+  'c/test_context_save_areas.c': setup_c,
+}
+
+if 'qemu-system-tricore' in emulators
+  tcg_tests += {
+    'tricore-softmmu': {
+      'cc': 'tricore-gcc',
+      'cc_dockerfile': 'debian-tricore-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


