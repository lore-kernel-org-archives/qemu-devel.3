Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A20C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:33:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPY1-00039a-Ds; Tue, 18 Aug 2026 15:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXx-00030q-UJ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPXv-0000GS-S1
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:32:29 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHIo9t1971968
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Wv/+MaWt//M
 7LLqxbek6XFpPoaHPnLFT1jzdU5PM+P4=; b=EffQxajB653Or6mmcRMhXRrZDGP
 kDiyayaNJpTxGT2rKUMC22NWKm55H7NzgKEufUPe09HUR55+49cNfBBaHfKGZhr8
 tlNwzSwXf9P8ZYRu6oq79HpzO2Wn1puaSGQ9412YGb2Cc2v43nTnG+E0baFE9suG
 498vs3MPDATpLeP7ILeokYZhOHlrbn/iuI2N2Mv7dJQA4vqKwriYBkGdeeozHJo7
 x3Px7Ilh60iVua+FNkapzejJHggVe+NqrMlPLQZMxMY47YXQMW1aVwsKio7s1rSN
 +43yiYL/y4l0DqRLfPqVa6uxFDMTdm7bGhUUtcmmUhHk70eJtxMmfQb+mVw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4qyx1tdd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:32:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dbe39ce62so97792a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081545; x=1787686345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wv/+MaWt//M7LLqxbek6XFpPoaHPnLFT1jzdU5PM+P4=;
 b=W0adUdYy9HwoHuqscZyJMQQkNBENCEgCcp3d0cnRCCxKwLvVDgOjuAD5UrNg3kVbYw
 YuCn1UZv2G02FKyhONSQFtyn9xRx+66vDEnF4syus7kzfcr6mvrD0RHam/t5XM7J5U5n
 mhb+tHXweUjn6T1C0tqGQgSg6GEhB2OiPbJCxwgjg8znXUldeOrEviAPMBNWVtGHEU+p
 Cs9laIVt3cjtpevVPE8/VlxqnCUmMVOeJykR9qEflkZmYlNXwQw0qddPMkZbYtCYI0OB
 bk0yQuYfgv5GhuGGLcQee1+2QLMyVtou9KW3ar+3lTe22o+Wv6WPO0vFI6Co7wgwYV83
 RGaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081545; x=1787686345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wv/+MaWt//M7LLqxbek6XFpPoaHPnLFT1jzdU5PM+P4=;
 b=RE9I9VbOuequFVTybR39UIu9zoPcoLDKOD0AoU1G2TlGu0I8xkByZWiXmhDLATX+TG
 n109qmsRINSejeoLVu3nZU/koFqiXgzuLU6g+QGIWI+jScgPvsP6A+WDp2NzDgcPjLs4
 mt7tIUccTQJgaGve4rKZcbxYWA05o4AL/ezlM+b6T+77Mrb92cgznjUCAVgow+0PTbmX
 aP4jnKtYHhPcr8cCeWOh6R1Q6rMZFWqfKkzsUIjbjWmzwPlHJ4bcLd7FDWsTREw0o9T8
 /pY+8GjQWZ4EbLJgIbwVp27kydSbapTsKmsAYoKnjCuuVQRB50x6kjEMK7zdqzhdMFVh
 GnrA==
X-Gm-Message-State: AOJu0Yx189TGY1kqgtMfcP+hmeeSDG0cMsaNT3P51FVaeaBYKgH1kaXu
 s39Ii96C1jgotvkkrky9vcjlrymmnWoKZv4kpmcrCipIMNe2PcvTab0ndOK9idKYATE5OJDXqdf
 YkmeCruqYnIQqy5+XKeyBsFI+1UCfyot7IgyieeBoAqagsK0s42xUMEzvIZ27mzJJmw==
X-Gm-Gg: AR+sD11Sz+IWAnTxLEy8cKN3DIp6+L4r6eFi6Vg+NuK7nyc4mmXGBea/zxTMxBKLJkl
 CebXFox9C4tLo0IcmTSrLroiEJFELSC9VJn3dErlDDllrjv0USMZ93MyMPefbTvtVdf7MQCH76m
 poLIEmVykpSzVm+bLrLz7RzgSkQoUH/fNZCwUs8cHCd0mulTSY08m6f6ZWVyp4uUW23OE2HZuGe
 l8sO3Huaut2+ALTlUe0+0gI+8ez9ECC0+MRSKamKhKeqmWVQfVszZzRF7yPclbgA+jk1Q3WjSO6
 /ErCpa9KMl0ps93qMJ6JRRUmnKBgRDAgQMIOZ/pDnP4LpJFZ0jKe7LWLWiWA9/6buRbdLfYctj1
 JkzBFcZ/wtfM3mF9T2YWv7Cwd/J5cAPDFDNXg3S5aGRPlAULeUVHRS3vXzr8=
X-Received: by 2002:a17:90b:3c4d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-39579831e43mr582035a91.5.1787081544414; 
 Tue, 18 Aug 2026 12:32:24 -0700 (PDT)
X-Received: by 2002:a17:90b:3c4d:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-39579831e43mr581985a91.5.1787081543925; 
 Tue, 18 Aug 2026 12:32:23 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326798c566asm21877135eec.11.2026.08.18.12.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:32:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 086/104] tests/tcg/s390x: system tests
Date: Tue, 18 Aug 2026 19:22:50 +0000
Message-ID: <20260818192309.22169-87-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXzoiNE4C0vA5N
 11eW+rXbR6AJln4fgfe8g3ErBt7T44B1W1j5Kg8i71CyQF6Kq7cbzxeP6y28100ANwLzlRtJDVU
 pA0E9mqbQjbeOjcm0RaRcwl0QEGnuL8=
X-Proofpoint-GUID: xlFm_erw6dH6Xa3KPtq0cnHK8lRSDyeT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX67hNyF7Db4wW
 qk7xFsRLCfnvBynpJ8tRFD9utMbzLZx9GD8vvoPwd1dMVlgrCOQ9j0jA56deZE/1JWBL+yfyzp2
 gR1YamIVN2xQG2aibPon4YDXcYxrctC6LVvpjv1wbO/j7iuJguR8R7BT8sgqi0NE2qWjBXYyMoU
 LNBN1qAgyNzKl35daOdlfBKDJGjqutM/ezMmn3NGDlesPy79BMVr8q8lLjvedEAOTCvxzvwG+vS
 O/S8GVeK17czbiF9fUSHTGfMk4uyuhMsbnJ/Ui9pRoJhdUU1cGFQ6Xaw9V+y/0YqJjv8lwQYot9
 qLv0gfcZNk43AnjOygWG5OJ+M/4pqDUKKjcgjTl/he0qbcvPb7U81YxXoAL+YbKdMjDAOepx7pm
 fdJwtYhY9Y6yYFxGWLvLfPo4XR+0bkTPXIkl5f1jU5ep4LyIjkftTTOFD5JsdV/zdxTAHBMXiZI
 jEUvnzVUvbMUrM9AATg==
X-Authority-Analysis: v=2.4 cv=Ad+B2XXG c=1 sm=1 tr=0 ts=6a84b349 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=SUcGKMR0j6ugdtI7A98A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: xlFm_erw6dH6Xa3KPtq0cnHK8lRSDyeT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/Makefile.softmmu-target | 57 ---------------
 tests/tcg/s390x/meson.build             |  2 +
 tests/tcg/s390x/pgm-specification.mak   | 15 ----
 tests/tcg/s390x/system/meson.build      | 92 +++++++++++++++++++++++++
 4 files changed, 94 insertions(+), 72 deletions(-)
 delete mode 100644 tests/tcg/s390x/Makefile.softmmu-target
 delete mode 100644 tests/tcg/s390x/pgm-specification.mak
 create mode 100644 tests/tcg/s390x/system/meson.build

diff --git a/tests/tcg/s390x/Makefile.softmmu-target b/tests/tcg/s390x/Makefile.softmmu-target
deleted file mode 100644
index a4425d3184a..00000000000
--- a/tests/tcg/s390x/Makefile.softmmu-target
+++ /dev/null
@@ -1,57 +0,0 @@
-S390X_SRC=$(SRC_PATH)/tests/tcg/s390x
-VPATH+=$(S390X_SRC)
-# EXTFLAGS can be passed by the user, e.g. to override the --accel
-QEMU_OPTS+=-action panic=exit-failure -nographic -serial chardev:output $(EXTFLAGS) -kernel
-LINK_SCRIPT=$(S390X_SRC)/softmmu.ld
-CFLAGS+=-ggdb -O0 -I$(SRC_PATH)/include/hw/s390x/ipl/
-LDFLAGS=-nostdlib -static
-
-%.o: %.S
-	$(CC) -march=z13 -m64 -Wa,--noexecstack -c $< -o $@
-
-%.o: %.c
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -march=z13 -m64 -c $< -o $@
-
-%: %.o
-	$(CC) $< -o $@ $(LDFLAGS)
-
-ASM_TESTS =                                                                    \
-    bal                                                                        \
-    cksm                                                                       \
-    clm                                                                        \
-    exrl-ssm-early                                                             \
-    icm                                                                        \
-    sam                                                                        \
-    lpsw                                                                       \
-    lpswe-early                                                                \
-    lra                                                                        \
-    mc                                                                         \
-    per                                                                        \
-    precise-smc-softmmu                                                        \
-    sckc                                                                       \
-    ssm-early                                                                  \
-    stosm-early                                                                \
-    stpq                                                                       \
-    unaligned-lowcore
-
-include $(S390X_SRC)/pgm-specification.mak
-$(PGM_SPECIFICATION_TESTS): pgm-specification-softmmu.o
-$(PGM_SPECIFICATION_TESTS): LDFLAGS+=pgm-specification-softmmu.o
-ASM_TESTS += $(PGM_SPECIFICATION_TESTS)
-
-$(ASM_TESTS): LDFLAGS += -Wl,-T$(LINK_SCRIPT) -Wl,--build-id=none
-$(ASM_TESTS): $(LINK_SCRIPT)
-TESTS += $(ASM_TESTS)
-
-MULTIARCH_TESTS += mvc-smc
-S390X_MULTIARCH_RUNTIME_OBJS = head64.o console.o $(MINILIB_OBJS)
-$(MULTIARCH_TESTS): $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): LDFLAGS += $(S390X_MULTIARCH_RUNTIME_OBJS)
-$(MULTIARCH_TESTS): CFLAGS += $(MINILIB_INC) \
-			      -I$(SRC_PATH)/roms/SLOF/lib/libc/include/
-memory: CFLAGS += -DCHECK_UNALIGNED=0
-
-# s390x clears the BSS section so we need to account for that
-run-plugin-memory-with-libmem.so: 		\
-	CHECK_PLUGIN_OUTPUT_COMMAND=$(MULTIARCH_SYSTEM_SRC)/validate-memory-counts.py \
-		--bss-cleared $@.out
diff --git a/tests/tcg/s390x/meson.build b/tests/tcg/s390x/meson.build
index c8a8e550e67..9eb4a42df45 100644
--- a/tests/tcg/s390x/meson.build
+++ b/tests/tcg/s390x/meson.build
@@ -21,6 +21,8 @@ tests_s390x_pgm = [
   'strl-unaligned.S',
 ]
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/s390x/pgm-specification.mak b/tests/tcg/s390x/pgm-specification.mak
deleted file mode 100644
index 73dc47af0d2..00000000000
--- a/tests/tcg/s390x/pgm-specification.mak
+++ /dev/null
@@ -1,15 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-or-later
-# List of specification exception tests.
-# Shared between the system and the user makefiles.
-PGM_SPECIFICATION_TESTS = \
-	br-odd \
-	cgrl-unaligned \
-	clrl-unaligned \
-	crl-unaligned \
-	ex-odd \
-	lgrl-unaligned \
-	llgfrl-unaligned \
-	lpswe-unaligned \
-	lrl-unaligned \
-	stgrl-unaligned \
-	strl-unaligned
diff --git a/tests/tcg/s390x/system/meson.build b/tests/tcg/s390x/system/meson.build
new file mode 100644
index 00000000000..ca07f503058
--- /dev/null
+++ b/tests/tcg/s390x/system/meson.build
@@ -0,0 +1,92 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('../softmmu.ld')[0]
+head64 = files('../head64.S')[0]
+console = files('../console.c')[0]
+ipl_inc = meson.project_source_root()/'include'/'hw'/'s390x'/'ipl'
+cflags = ['-nostdlib',
+          '-ffreestanding',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf,
+          '-I', ipl_inc,
+          '-march=z13',
+          head64, console]
+asmflags = ['-nostdlib',
+            '-Wl,-T', link_script, '-Wl,--build-id=none',
+            '-march=z13', '-Wa,--noexecstack']
+qemu_args = ['-display', 'none',
+             '-action', 'panic=exit-failure',
+             '-serial', 'stdio',
+             '-kernel']
+
+# Multi arch tests - add cflags only once per src
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if 'test_name' in setup and setup['test_name'] == 'memory-access'
+      # s390x clears the BSS section so we need to account for that
+      # ./validate-memory-counts.py --bss-cleared
+      setup += {'wrapper': setup['wrapper'] + '--bss-cleared'}
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_args}}
+  endforeach
+endforeach
+
+tests += {
+  'mvc-smc.c': {'cflags': [cflags], 'qemu_args': qemu_args},
+}
+
+setup_asm = {'cflags': [asmflags], 'qemu_args': qemu_args}
+tests += {
+  'bal.S': setup_asm,
+  'cksm.S': setup_asm,
+  'clm.S': setup_asm,
+  'exrl-ssm-early.S': setup_asm,
+  'icm.S': setup_asm,
+  'sam.S': setup_asm,
+  'lpsw.S': setup_asm,
+  'lpswe-early.S': setup_asm,
+  'lra.S': setup_asm,
+  'mc.S': setup_asm,
+  'per.S': setup_asm,
+  'precise-smc-softmmu.S': setup_asm,
+  'sckc.S': setup_asm,
+  'ssm-early.S': setup_asm,
+  'stosm-early.S': setup_asm,
+  'stpq.S': setup_asm,
+  'unaligned-lowcore.S': setup_asm,
+}
+
+foreach src: tests_s390x_pgm
+  tests += {
+    src: {
+      'cflags': [asmflags, files('../pgm-specification-softmmu.S')],
+      'qemu_args': qemu_args,
+    }
+  }
+endforeach
+
+if 'qemu-system-s390x' in emulators
+  tcg_tests += {
+    's390x-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 's390x',
+      'gdb_arch': 's390x',
+      'qemu': emulators['qemu-system-s390x'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.43.0


