Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED428C61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziVP-00031a-Qn; Thu, 27 Aug 2026 18:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVJ-0002pw-Fw
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziVH-00008J-Mc
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:23:25 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJLowC235958
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4IZohBOpwHR
 /pb72vwMQaayP2xuiex39kty5a80k7G4=; b=mguGXORIVHAu6/fJ1nx8BhMEQjR
 ea6meS0H+kzeLso/iFw4LveHR5MsCpi2NSo32SfDqN8BwlfADZ25KQR7ZplSWGxT
 /cHDijLvw6Q0IiNoZ16JfKl6tkVSF406VLr98C2F+eabfLjCmp+YTNW7ggaLDpol
 0149va42x0dQG/5M+jYAkL58KaFdGGspQJMCZf0NjoWLlh+4CFBwfCOjZ3bOM3Jo
 4eXMyab0x3IGW9vVnLQXSF32o4Fq1bO4Y+3AEWIcJa3maiB5pDGhP6T8ruoLqWbL
 y4Ub105ZQrDnTDaA/HgVC5LwUFIg2MEXy0oLJNpWm3SJXR6adiwx7lNc/7g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gatkjgugv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:23:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cec4226c70so3744885ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787869401; x=1788474201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4IZohBOpwHR/pb72vwMQaayP2xuiex39kty5a80k7G4=;
 b=YRN2gu1oweAqo4ou/1ztCwSUeJGai2XhtBUgMU6CwEYSKOsUWNPzJEtWuuwgVT5g9W
 HrJKJW7Z+Yf6CiMGgZonGLSUey5lu7N72pLcGbXahB0y0fRjKQgEfARRBgIRpj2mPy7U
 daeqQvgqgO8OSRlZ11kzA9FDmieB+kneUpmiauQfGKpJndfHxuF5OBVQq0Z7/svctSsd
 rV6j+td0HTCv+g4tPIEo1qBdfIjuIkaxwhJUjl3g3ZRgJwHsQ5qPqOgra/PtVDxRwF4v
 xbPSMRNAWNnWT37LcM/HNXmSsl+ifcFXdvrG4zIJk1z0EDGS6epKn3809MM+PqSLsIqe
 Y8Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787869401; x=1788474201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4IZohBOpwHR/pb72vwMQaayP2xuiex39kty5a80k7G4=;
 b=m11Sm6NeNPDpAvsIX2gfMSIokKU5nEFwxn1WnWTKjHbQBPgYaHkwvMAuy9E9pQKg5D
 m3ZGDE9f8DllKkGngVCiK6TdqBHuPwbKWHeYdtSl0CaDTL5LOgSOitb+rmVWdjnr2YEu
 lXNY3hEHcv9OeByypYh5JUpTAQU/lG43PxgjtTQ7w7MYHGAdCqgZG93ejCD/ISOllK+g
 g5LtuJHKrMzzdmBgNeD01/Kc42dxjuCYtCVX17xnhlJgDX6U/CFUuOo/9Or83IBVQVfB
 jUTYrIk8zDSoYd8LGp/r3AG/K4YWVZXRDsXoSvTFheI+guERgEXIEyw6RIn4g7/LEwlG
 Yktg==
X-Gm-Message-State: AFuF++lzhb6K6iaGyCrM4JqEZpEn/u/32C01Wi1D0DxNJh9cY+W2I/nA
 YemQGJ5PcZnCz8nOOTnLi/iLVl9x6gdgP9hJJX+r+Exwuhvq4p6tEO615N6ydRz3KiirhppUBLI
 uO2acrDpoI8DEC2FZliEG2IvtugT7h13+H5qVcEkuOPz28nXzKgv0kZlTx/ZhoG2Cvg==
X-Gm-Gg: AR+sD11cq6WPnKBRKaj3Je6gl/zWOm6+0JhQMapUODuPQNcb9nLb/SHIHQkNShyyOmG
 useTbC8EpI5edraYStmIGjlG8Rdz/0vQdhACIt1XVTOEWaEii/xHdc3kgm6jpnDD50seKcBKG44
 Mo01R5YExuWdE/H0Qdc3ZiL0lONMymu3xi2iSTz4Z4Y2mJrumDjN5HAhG/DC3mA5I+VtQhav6MD
 J4omtJn3XOAa0l2RelrOxuCm2jhpSm26SOFchj1jWMd8W1dY+yzCdZn7LJwqa/H2No182BKeRuQ
 3Ok+AZXWfgF/mPIIX+ujvgTWwWIj8mGA2qUfwwZOp6l9Ke22VQb4aRRX33BQHB7vuUo4MXh8awo
 C0Wxo5hHuXgK5QzBVNauzzVu0Xl+ID4w/xos/byS8nNXu+AZshMUvuJqkwiE=
X-Received: by 2002:a17:903:3c46:b0:2d6:e401:9676 with SMTP id
 d9443c01a7336-2d74dc1cd6amr42601535ad.1.1787869401493; 
 Thu, 27 Aug 2026 15:23:21 -0700 (PDT)
X-Received: by 2002:a17:903:3c46:b0:2d6:e401:9676 with SMTP id
 d9443c01a7336-2d74dc1cd6amr42600335ad.1.1787869401061; 
 Thu, 27 Aug 2026 15:23:21 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d70493f729sm20776155ad.2.2026.08.27.15.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:23:20 -0700 (PDT)
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
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 081/105] tests/tcg/riscv64: system tests
Date: Thu, 27 Aug 2026 22:14:42 +0000
Message-ID: <20260827221506.91574-82-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: K_EDENXuDZK7MgTffu7sIYByRe9aKeAs
X-Proofpoint-ORIG-GUID: K_EDENXuDZK7MgTffu7sIYByRe9aKeAs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfX8JCWHcCD0ecb
 +SK+s8ePEIZK2XrHJ6L6ENkwmbdW/aJD4qsaP3xER9hc4BdnPC2mQ+hRkbaK3Lr2Q5+/DrKNr3R
 suhekTa4LeiWROMyfad+jygIySisDL7G2ldNHWbC1Up2HrewglX3cAAEmtI8i9ceixDyhXkklMx
 wQ2GAKRjxD9459UKoX7O1BqIGGTsQV37X3LCe3dyuaT3qZuSl1Pl/643qADF32e2hFwXISNJcvF
 KGiNBipPYzk2ALTs9HvPm4kxQNOKYEP2nAM+VsymJw75+gecscrmdUkwYdpsOQvF4tmZqr8xvzl
 8uph/JcMOSqJBCPSkb8wOmkCeIGQWsF357TJQ8Ztl39ho3tMu5y3VZIicFwCp+4RT/1SuUYQCmD
 zn4vDsJDaPFICAi1j1Tp1fGCpmbPwWC315RmUSG0ZN8ZPgRcKyL09GeCHzZHuNF0FF62cBLSUgu
 hRE7WEJ9PUn/W79pNqw==
X-Authority-Analysis: v=2.4 cv=Rsn16imK c=1 sm=1 tr=0 ts=6a90b8da cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=0o8ZFmnFDSeAlu9J7_oA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MCBTYWx0ZWRfXzYGWABRa7ZO1
 fxMGd46Xpe8gwnJU4qE4NgsahqiC4Mf7ViaKSqLnrT0hj7aImFPnJitWArzqJGm6xPQetkiqykr
 CDev1uWqbtrqrD8oQMZbl7soExt8FKw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270190
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/riscv64/meson.build        |  2 +
 tests/tcg/riscv64/system/meson.build | 55 ++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/riscv64/system/meson.build

diff --git a/tests/tcg/riscv64/meson.build b/tests/tcg/riscv64/meson.build
index b5f574c1377..2292bf8ed1b 100644
--- a/tests/tcg/riscv64/meson.build
+++ b/tests/tcg/riscv64/meson.build
@@ -2,6 +2,8 @@ cc = 'riscv64-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
new file mode 100644
index 00000000000..80b4fdb91e4
--- /dev/null
+++ b/tests/tcg/riscv64/system/meson.build
@@ -0,0 +1,55 @@
+tests = []
+
+# Multi arch tests are not supported
+# tests += tcg_tests['multiarch-softmmu']['tests']
+
+link_script = files('../semihost.ld')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
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
+  'interruptedmemory.S': setup + {'plugin_test': {'plugin': 'discons'}},
+  'issue1060.S': setup,
+  'test-mepc-masking.S': setup,
+  'test-crc32.S': setup + {'qemu_args': ['-cpu', 'rv64,xlrbr=true', qemu_args]},
+  'test-minstret-ecall.S': setup + {'qemu_args': ['-icount', 'shift=1', qemu_args]},
+  'test-misa-w.S': setup + {'qemu_args': ['-cpu', 'rv64,x-misa-w=true,c=true,v=true', qemu_args]},
+}
+
+tests += {
+  'test-zicclsm.S': {
+    'cflags': cflags + ['-march=rv64gcv_zfh'],
+    'qemu_args': ['-cpu', 'rv64,v=true,zfh=true,zicclsm=true', qemu_args],
+  }
+}
+tests += {
+  'test-zicclsm.S': {
+    'exe_name': 'test-zicclsm-off',
+    'cflags': cflags + ['-march=rv64gcv_zfh', '-DZICCLSM_DISABLED'],
+    'qemu_args': ['-cpu', 'rv64,v=true,zfh=true,zicclsm=false', qemu_args],
+  }
+}
+
+if 'qemu-system-riscv64' in emulators
+  tcg_tests += {
+    'riscv64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'riscv64',
+      'gdb_arch': 'riscv64',
+      'qemu': emulators['qemu-system-riscv64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


