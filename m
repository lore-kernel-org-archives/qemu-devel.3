Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D99C44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ68-0005xD-Aa; Fri, 10 Jul 2026 17:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5j-0004EE-DS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ5h-0004uu-AJ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:49:03 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3ixj1623600
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bYJ66kOwk4x
 N1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=; b=S6WkSGtg+2h9hZBf3LDjAiocs2m
 oZZJ4mD2GI91/UIWbLh3dJ4PHWcefzKY9OnyYZIIrm4HmfZOU8wdADt5mlYscAae
 ODCDoA/3tzR94ClaQ0mXdzL3uMwE2iKn3YCpGT9sQS/o0zsk5dGBXnvYTAnRiEjM
 p7tysw7XUzp72BbbGZFv8v95/5RdIzQ0P7ZGKuORmdrdGGKHnjFYjn82Pk4/8Bc8
 HW0zd1+mLbLqdnXtNPUFN/ZADVl3+Zo3jdW81G5tVfdI3poG434tHulyi7q6gChd
 9/psjLL705cyoTney+YlVteuzPFsgykiz0ilgfQgIOYKtvzeLe8v8jOJI2Q==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb4rm8v5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:48:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38869800848so2412509a91.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783720129; x=1784324929; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bYJ66kOwk4xN1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=;
 b=E+gLMA9YK7qlugzupsBGcuUPvTg6CIpKPkZy8x1PQJVspYY41Z8VZsYkRuZ/7R0QXy
 cIDlvamUgcYEdUedt/0RHsbeNYqgly3dvPJRwYKAnRkxtM9rEPIvvFybWfwQsmYgOFLi
 w6nO1qWXofqGLXYGClL1mU5w01WuX6Ez2wFp0BCLSjtQLeWYOk+MhLTdsS4W2QE3PDG+
 bea9YQnV3ZtiDmI5IVJfj5R5dPKpGFGVk7Ug4LCQDP06FuZMog3IWFGZLYJMwP/JPXkq
 pNSCLbDMO84Kp08BU4/v/cbMEIbbax1Oxu3PTaxZk7UeLmAK2LG5Dq7sqWt474Bc0fc/
 pRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783720129; x=1784324929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bYJ66kOwk4xN1+kKUGmP9nipc3lUtDEo+WT3XpRtnMc=;
 b=ngQ2AkDHNHiUNzYnWHpm+q5Mic5C6yXPReWWvwSnLe+tSdkhy3Wj4368HFowCYPJMS
 IT36mlXMnzIQm8Ge2e9k4LosXg9h5ifdW1a8ptAi8g9O/fieJjiFCX45OlIj4xPPZcpz
 Qust/J+spg8Tw8gAj2oIW7biCd4w2MFBlc3xnVbW38u/abI23qrCYuxMRsh8OPVe92WA
 yocnQv8+YZ1eV/0id85I26rMVouhUUsTj5zGMKguR5Cjp/WoN4WpqCPlUBWJMTEs3rtR
 3yiRt8n+pp0cFZjRij3ZaeKpgRT8xP3B7uKxF5sW9AwNPYSKIxDhhl4NvvCy+RYdQGXL
 9czw==
X-Gm-Message-State: AOJu0YxtfpgJ1qdyxRbfDq09lZHAotkQlOY92SGdqvmKZRj6AXYe1fuM
 Rq6X/F/nyzpVE2I9fiUxYADsfR/H3jhPMdhrVif4QAk1OAGcZgdCNuBmTyO2VcqqXr2t498SSME
 1WSr93yJWDbj2ncvB/C8Adtmm5mpR7j3u4EJwwz0GCGNKf5GE5C0RbEDsqRw5pCe4Yg==
X-Gm-Gg: AfdE7ckgUQ6W30ydARRX0HdHmt1RXp0o2y/my5gcZcphV8JV9/W6XA2igblx7SEdKCQ
 G+iQCs16deX44nK0AlHMS1JmHQ1ySY3D1+QoEPN1fagBgP4MJEpcJIEZDiJzHSq5HohSl9Wyaad
 /EaZNmorhLkSZDPsqUDnImqPzQ0JzMEkxVSCh4xQXI+3Pr1IKL03GI8SDIaG6ITVKMHpPf1tQFP
 Ba4s6q8SegcopzTo2PogdzAx2y51GPx1SAeFS/YtNpjWpX5pOO8wve5Q/kq+cQlal1uILL66e0w
 FpyQSkBOIvOqEIvmDZjwJQ1DBIj2V5u7uTZSyDBAZjkiEe8JHeVKKk3EHYygsrVQ1U/Ccl3HDbN
 OnAUZVCpsr8Dq6wy3BSMPmFoMHvSRzbtPI75UsF5MjheqIFFR+lnp+ZXUoSgRbFIsr60KzJd24s
 ms41EmZQ==
X-Received: by 2002:a17:90b:1645:b0:380:873:49cb with SMTP id
 98e67ed59e1d1-38dc774d582mr608248a91.21.1783720128965; 
 Fri, 10 Jul 2026 14:48:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1645:b0:380:873:49cb with SMTP id
 98e67ed59e1d1-38dc774d582mr608222a91.21.1783720128483; 
 Fri, 10 Jul 2026 14:48:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311838c9235sm39886355eec.21.2026.07.10.14.48.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:48:43 -0700 (PDT)
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
Subject: [PATCH v5 54/98] tests/tcg/i386: system tests
Date: Fri, 10 Jul 2026 14:42:58 -0700
Message-ID: <20260710214343.2065491-55-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FzOaGJq9QTRVbRS3-cKODWCAS_5L8sRm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfXzcDrPQ2SDsX3
 BepRTyADJwbyxjt1lHXQL0eb7BzTsmh+dnrS1UpRMuCZuPziQOhJiRSfVQk4RF7NQXxvVQ2Ie9i
 fBcPtHfwa6lgu8Uku2oxk/9ZAZvApqzKgaW1MeYjWSescVjzl9lwBhB0JkrrhLwLnPkkrY/ldEr
 WjCUhE23KJVDMl9PCQuGUPh0tluK1+LUk0vYZc9tkfOpfbnVR3xtNu1qOGQdi2qA3kr74BLGX0V
 f+StAnPTky9c/IBgJROAGiJ6QCeHQ1xFelz7jkjum/aQcOzpdxHJn20sNSpVFUlLWrtAnfnmYWO
 0MC/m120OIqIdBGBrpSgNMVpOt2WjAaoZG8n/7GLHHeM04Mq/9UTCS5bF0UM4BKm58EFTe79H0B
 zkRquqUKEgwYYPsa+L2Ii6EnGbglG3W4++V2Y/9nxGsHLmsdwjaKDWCREXXuQKyHuSvEF0rBC+V
 /MUkCastbI0iTjyxIsQ==
X-Authority-Analysis: v=2.4 cv=JIYLdcKb c=1 sm=1 tr=0 ts=6a5168c1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=YfLzPEwJW_iPccEctz8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: FzOaGJq9QTRVbRS3-cKODWCAS_5L8sRm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOSBTYWx0ZWRfX4UE/TXAB/YS6
 xguWBHCDLs0RnHG5q8DXOTYDpawgqI2Pmj5H/BVj3xbpVzy02NsV9gvxKTuQZVdQruPgmgaLqB0
 iuBgi7y+CUqopxFlVaZdlSJyR6pAi3I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100219
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/Makefile.softmmu-target | 37 --------------------
 tests/tcg/i386/meson.build             |  2 ++
 tests/tcg/i386/system/meson.build      | 48 ++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 37 deletions(-)
 delete mode 100644 tests/tcg/i386/Makefile.softmmu-target
 create mode 100644 tests/tcg/i386/system/meson.build

diff --git a/tests/tcg/i386/Makefile.softmmu-target b/tests/tcg/i386/Makefile.softmmu-target
deleted file mode 100644
index 4096a1cf31f..00000000000
--- a/tests/tcg/i386/Makefile.softmmu-target
+++ /dev/null
@@ -1,37 +0,0 @@
-#
-# x86 system tests
-#
-# This currently builds only for i386. The common C code is built
-# with standard compiler flags however so we can support both by
-# adding additional boot files for x86_64.
-#
-
-I386_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/i386/system
-X64_SYSTEM_SRC=$(SRC_PATH)/tests/tcg/x86_64/system
-
-# These objects provide the basic boot code and helper functions for all tests
-CRT_OBJS=boot.o
-
-CRT_PATH=$(I386_SYSTEM_SRC)
-LINK_SCRIPT=$(I386_SYSTEM_SRC)/kernel.ld
-LDFLAGS=-Wl,-T$(LINK_SCRIPT) -Wl,-melf_i386
-CFLAGS+=-nostdlib -ggdb -O0 $(MINILIB_INC)
-LDFLAGS+=-static -nostdlib $(CRT_OBJS) $(MINILIB_OBJS) -lgcc
-
-TESTS+=$(MULTIARCH_TESTS)
-EXTRA_RUNS+=$(MULTIARCH_RUNS)
-
-# building head blobs
-.PRECIOUS: $(CRT_OBJS)
-
-%.o: $(CRT_PATH)/%.S
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) -Wa,--noexecstack -c $< -o $@
-
-# Build and link the tests
-%: %.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
-	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
-
-memory: CFLAGS+=-DCHECK_UNALIGNED=1
-
-# Running
-QEMU_OPTS+=-device isa-debugcon,chardev=output -device isa-debug-exit,iobase=0xf4,iosize=0x4 -kernel
diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 62074b86c9e..5cda03655fa 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -2,6 +2,8 @@ cc = 'i686-linux-gnu-gcc'
 cc_dockerfile = 'debian-i686-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
new file mode 100644
index 00000000000..482a400555e
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,48 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-Wa,--noexecstack',
+          '-I', minilib_dir, minilib_printf, boot,
+          '-Wl,-T', link_script,
+          '-Wl,-melf_i386',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-device', 'isa-debugcon,chardev=stdio',
+                 '-chardev', 'stdio,id=stdio',
+                 '-device', 'isa-debug-exit,iobase=0xf4,iosize=0x4',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += '-DCHECK_UNALIGNED=1'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-i386' in emulators
+  tcg_tests += {
+    'i386-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'i386/system',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-system-i386'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


