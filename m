Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E7F5C44501
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgryO-0005Bd-DK; Mon, 06 Jul 2026 18:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryM-0004uM-Pa
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgryL-0007FU-4D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:39:30 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3pp1478201
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=C9PQ435xkTv
 gFnrBLMjxB7FmYg0m1ctDmIIhrRE5Qzs=; b=jJpLCD+aKyLYFOQH7MPZiW6w8du
 KlxrqsiIAYa1HoG08nKM2rfWjYMwD+sSAaxXMk8mOHIuPrpBg0lfTiA+MZNJdHEi
 8wbOXYB+CLIu7z9KnnQ2hH53gCVoc/ZYsnsK06nxYyzSXRv8A07ihPvXxfCWIp8l
 dcYkoHpGk/GOl+A1DIvAWQC5Q7F4CRXcHxF/Ynwb0l1ov6CdL4Q8eOqEAbRBIyys
 GG1fRPKP2fFMocI5Z0DCS/+7jioZX+thz0LF8gSvb843YYqnmrVSNVSHGPG5uuYe
 7jn8rax+f43zH7cPCAZ7OXm/xIOnM9dnFpMDelnaGabfniruY4iMg7hW7pA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88hsbmjm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:39:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so5030068a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377556; x=1783982356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C9PQ435xkTvgFnrBLMjxB7FmYg0m1ctDmIIhrRE5Qzs=;
 b=hOu8m0cSQ6XBP8niSNgeqvFrgurRKHp0N50QgMO6HbIcWTrnt/DbJWMwJOVma8wU6G
 vNNTMtHvGy0dtIxL1bom9C83S17sCotlIDF5mJcqKUHRgle6YxlhZcPKLxDsvsZVbZE3
 Lhe7fHj9HXH5zG0zmoBkC8baFPWZnyfMFTnhI8qbK33bnntbw/70Utfr8utylibWkyaY
 7NapQ8Ab/DGq2QkJcU7+SACBUP/KOuc9MkFWfxCWPcxNoPS6YxUN7pNZMahospaSoeRt
 sOFKLwM4Z+FgBmyD0VXC0AaWyxmSSyx8oqJM+rFw/r6YCjNPAd3RbON+Bw2jCfeDNay/
 2r3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377556; x=1783982356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C9PQ435xkTvgFnrBLMjxB7FmYg0m1ctDmIIhrRE5Qzs=;
 b=XIfZpxznd37H9Ec0gFbp1ljio1yLSfBPwUI+KwB5I5Qp91wWAUIIhONJ4WBq05it+F
 2kEMgcgV30w4zJ0LVCX75Uqd1BfKMkZvx+COyDYEDj52nNPKidTOVt2Cb/Y+H10VZ7X2
 Tf3rSwNfRWuarnE4nZ1SDwGJjhluMEyK4quWfr8UUnYHg4gYNP16U3+GQ94AkJ7lFviw
 QYebIY1/oKBTSSFb9QPxllqF3a2CFoguX+fLXRqv/zSHEIitwzUvxq3za9yV7qM499yG
 yFbz7Hs2D1+Elnu0kMtBz5a5fuIlMuEl6PlmA7t0ZPn2pYa9ygc8WPuoUvbZUnocJzwt
 inzA==
X-Gm-Message-State: AOJu0YyE5WExh6ad7gM54GCkEp4nN3W/iNR1Ps70oLe6wmJpAbQIxUnH
 YRkAzkPQ4hYfsy19vjK9ugZuM8z6xvxwfsj7+mawU/Vum32tJ+DkBXwGIQa6QmAbZmEwS1YynfS
 LE9qIWgxGG+q2jp8SEc3j7MtU8V7+m4KZwpp8iDF1DoWoVYOxILEsPQgxXIxZp+AnaQ==
X-Gm-Gg: AfdE7cnpzvswZxbmWgqwGWJr8eSpFRqUCkp5r1FliGlUXrjZBTnmi6hTf6+JaYPSaF5
 9CivYE/o+O12/M3ohjImSk+rH/xrUFK+b/rz3znneLngPuHby4j3Auzhk8i44cCXXap+XR7fvmG
 xKJtmrAQr7GuQcaSnfRk4u7haFr1S90BQ+zC+K0UBCpNs7jRdemKeqWZjMnHKe2yozo/y4xGQ6v
 QcDkh4AO0QYHcbN/rj5qe2eX8Nc3wJhbIfxmlEZnfkRz/t7eGjbAGCyT64tfO/tCanKfmf+LLdl
 k0ggZFy9MNe8qURkYEoWy/nfeXiGprqLlKC242ody4BGCjhe4jtku83yOHpt4949nMj8a2c2Rpr
 LB1Ohlr9PyVBID4xIZ1d1WyCsgalzeXsjNju0uciaxsgfuo5b3UlWShSIqE0Yua+cPG5PQ/3AhU
 NwUSi3cQ==
X-Received: by 2002:a05:6a21:6b12:b0:3bf:6c08:fb93 with SMTP id
 adf61e73a8af0-3c08ef18325mr3331381637.53.1783377556435; 
 Mon, 06 Jul 2026 15:39:16 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b12:b0:3bf:6c08:fb93 with SMTP id
 adf61e73a8af0-3c08ef18325mr3331346637.53.1783377555878; 
 Mon, 06 Jul 2026 15:39:15 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:39:15 -0700 (PDT)
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
Subject: [PATCH v3 75/91] tests/tcg/riscv64: system tests
Date: Mon,  6 Jul 2026 15:33:27 -0700
Message-ID: <20260706223343.988769-76-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: C7aHweVP8IeNhX68PjH_yCHtZ7L6Hwme
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzggZtuIkizcP
 pjcksjncXZd4VDT5MQD6zNvbFSv+jqEQHHNU+dfbSJWDU9LYQvddiKrBGKY1w7SJQRxS2Kui+rD
 gpwjkSNKHhcJ0TH3Ux+2WwKLk0qsqZomqkv0JuiYG2ojKBdn9TTHKhICJ8hjluIkisEJP5WZL2C
 LDeh8p9SJqR8f5A5tYLLMVqQ4oBXge5FYVdXiuW8mU+G04otVJUpWp0Zd7xLc6lUFZNb9GV+b3L
 hzhPJj0U7YeqglhgNDTLbfb8cJ0afTOHxT8GovLeZjuXJfvGXbEgvHeGk+ZGyR44LlQHQF8D0B6
 nG6+tAp4z3h+S0fq/mRx/vN6qr4/Ge/NBvwueipU/r9eGEdrpBzJC9o2FZIVG6vmTzO78LCxc85
 YAEZbx5Cm45CW2/LcP3ehi3wCiylQrxQ5E9rF+T+YOAO7341b47609hWfb3NfqlJrEgJjiCc598
 /UiDLemK0Of4RPMtnKw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX8BE+PtG5oQwK
 wuOHHNLk/W78NjnbYmEjnkB5rT4gdxMr38pdKNZk0qs9i9gakqpaFD2Zq0tNPYuG88IZQRnkELA
 cwTuv0G8CYnXN68xuL+RS6/kD5YP+6A=
X-Authority-Analysis: v=2.4 cv=XIwAjwhE c=1 sm=1 tr=0 ts=6a4c2e95 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=5OnOcaDEccV2vxpikNEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: C7aHweVP8IeNhX68PjH_yCHtZ7L6Hwme
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
 tests/tcg/riscv64/meson.build        |  2 ++
 tests/tcg/riscv64/system/meson.build | 38 ++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 tests/tcg/riscv64/system/meson.build

diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index 393cd51d71a..fabafa92261 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..0be20982df3
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,38 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-Wl,-T', link_script]
+qemu_args = ['-M', 'virt',
+             '-display', 'none',
+             '-serial', 'stdio',
+             '-semihosting',
+             '-bios']
+
+setup = {'cflags': cflags, 'qemu_args': qemu_args}
+
+tests += {
+  'doubletrap.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  #'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


