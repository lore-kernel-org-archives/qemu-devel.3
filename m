Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524BBC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTu-0005WR-Cx; Tue, 18 Aug 2026 15:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTr-00059F-KD
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTp-0007V5-Jn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:28:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHI1Oe1872785
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=UUk/EOMms+r
 HVnuEal2ydbDj9602AOphDWcGpVltqSU=; b=d9UhNH91qGdd8q6GQD/bIX2gBRU
 MZ/1WDQQ9N4e6FMk/QmX4odOGISuzVVksZyW8Y6sFjhcW+oTtfhpeSmMFFZPjYwC
 xnSR3IQBYRIIakIdkQyBhWIH4FaMwXrAtaV1n0nHXJ53oQA+t3Dz39lPCQEjEe9t
 OZwXXlcmrzTppueLI1WBggj0Ifvuy9ZWS3GDGJbs959KUm6tU4LZjgLHyiRLoL6o
 5egAGUZUFuqrOGusB4VF5wFT1Acl4XCPcscN2UY3umhRCGMzMc8ZxrnapNpppqzN
 0zoNuvnOBus6iobwksq8LVI38weCR95VCO0AqjRuXoeJdDaER4C9fyLZnyg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4nb1agqu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:28:12 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so400297a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081291; x=1787686091; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UUk/EOMms+rHVnuEal2ydbDj9602AOphDWcGpVltqSU=;
 b=PYPFVh5PMgPFejZbrnCRRReozDAlyQoQ46YO0WkM6H93ocKJphsOQsYsZAjyppfacv
 iBd3/LJW1k+nS8vLYNb7LqQ7Tu+j1mlc8NHuGqnYPd7l4U4wb0U2Tf2PDyhnH29/iNKY
 I0EP39jAvNAZ6DdgD+742CU7R5EQ5HN5VL7ziwutfkU+8jQvjCtXw/BZ95lG+vKPVbq1
 mzqLK7cHrP3+sEsiSQLE16ZPyaod6FgB60aeK+IObXHrSzuTZPG465lkk3Jdw3SBEE6W
 WpIEn4tkGvOkXjj9rwq35JXpl1NktNA4xA7tIAOYlPmrp57a6VAXlMd0k6oS9+Bv+1lJ
 cK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081291; x=1787686091;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UUk/EOMms+rHVnuEal2ydbDj9602AOphDWcGpVltqSU=;
 b=lMWK9ZncMbk3WCaZd+KpTBdzXzzGiNzZm5zilCnZCba/jKV/j75gEQfh71w13Yvanh
 tuwb5g+RDn5808BrR3Z3oDafRPptgHp5A2c1fSNC6bfef+dX6VFdPSLqUs9kvzwYc0DN
 DAdA0cegWtmPKPTsES2k02dFypec9v2xp7A0PdP+d6twp2bprcFHozMtreazHOpvH4nX
 QMZOewLZfgma1Aev+tG4WiDGXePi77+0aESKUJGNQmTalj17oWHwOeEIzWNdx+z/Q5vO
 9Fig2UwIEIneplz45IzGK3BsnyxS10RtMNSPC71l/+RhyCEE4/bU3QSNIogXM2qq2ege
 PqqA==
X-Gm-Message-State: AOJu0YwnSWaJY10r8dLO6QURmjrNsCmJaN0kZyLRVPd00xRqRk9lCQUz
 jFyDVuk7gDSgD7Q1uFkDnyYdUhBHgMB34CNNOKNZ+63N8J6CARdncj59BITkOEzfvQEAtTBsVAt
 6avwyX6Jzp9bpfMqewjMoEMmkeDWyKkD0NCB+pe/W1JrL0B+GErVMFbLF0LPQwPiXFA==
X-Gm-Gg: AR+sD13n7jm/JNIDRDx7ihDjzyHG/49XG2teqmwi1dvRcGq2RJ7h5TMX4ucoaal8Y+R
 qu3rcQeKeN3Mvq564Ir0bQrQNPyXpZF+3hgikoH3RWsepxjj3fgauhYAprMyeNHJjBgRgcgvYzC
 JUh8kiwNM0lALFx6/Z19rlanLtWgWukc9ccNOJ7toHFIgRyWXHXYFWYWUg4st73tCku/6br09l5
 p+3AQFYlHVumdoEIEtiq90R+wAmiezpe/bAOJ8IYj/dEbiizLP4DGskIqv5MP6g+6+rPziAdnZ+
 2KNRegDVPGzT7mDuuFH/Rjq4JxXNTHYGaE/FxjR2SfXi+aVAG+Hi3gkQBvFyqS2swZX1gDvLiOK
 cwH3IWWFILqzUtOzO89le3OTUIPwqVYb2DdR+cwR1m594HOPd7WIqh+BSk94=
X-Received: by 2002:a17:90b:180e:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-3957b1c2415mr115409a91.3.1787081291380; 
 Tue, 18 Aug 2026 12:28:11 -0700 (PDT)
X-Received: by 2002:a17:90b:180e:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-3957b1c2415mr115329a91.3.1787081290901; 
 Tue, 18 Aug 2026 12:28:10 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.28.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:28:05 -0700 (PDT)
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
Subject: [PATCH v7 056/104] tests/tcg/i386: system tests
Date: Tue, 18 Aug 2026 19:22:20 +0000
Message-ID: <20260818192309.22169-57-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX01rTadz1xqR7
 T4PoY2INcQbK29mu2POzWUxZhhhhLAMaC/KBpDsF4RBwVXTyEakSt2elOpkSh5ZhlmhUv3pLs0h
 yftfhIgVSQAfmzxbOD4WY11qjIPtLqxf7H/IMh/PdieOdQSLTELUJjKYH24fdaFjddDJspSaGYN
 a+7/kT6v/cuJlwf7Dm2S4TsX0bmrcwLaEzSHRzlMTgx7WwyzMO0YQ0p87ZFhusQYePIS45V4rWS
 9DdMqCpXPV0aHmWboWSKzzhlZ6/ZwjRQ1UsfY4T4ORwGf/Hl41ywtDH1HWveiwC1TvCAIe3c2M+
 VYkZ4TnxZ3vzCZLIUev9EaiAp+14LhtBCurw/C2i7JPSNBB8XpcWjRmExxOISVF4OpVALaJqtee
 Hwq3Pej/5ToqeSij314yfwUPaGL7RuviYrjNipPbPYrvffC6XY4r7zEuxLGdfWX5xiaX9bNSTwY
 3pEMRDfo81ug8jfbn1w==
X-Proofpoint-GUID: ajf3yK9rTllWYOo6qRRbp2XEyymWQXmB
X-Authority-Analysis: v=2.4 cv=Ze4t8MVA c=1 sm=1 tr=0 ts=6a84b24c cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=YfLzPEwJW_iPccEctz8A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: ajf3yK9rTllWYOo6qRRbp2XEyymWQXmB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXwRr3KJWBfop2
 TISrK7DPQY8AchbtHAIJbM6Ajp8Yu3ZRQXkL06gFT0kl/csoNVANtedF7EWkBsV+UQ4JAffis59
 N4ffA0Beaz2SeEI+6/kO/xJCCuwKlY0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
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

Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/Makefile.softmmu-target | 37 -------------------
 tests/tcg/i386/meson.build             |  2 ++
 tests/tcg/i386/system/meson.build      | 49 ++++++++++++++++++++++++++
 3 files changed, 51 insertions(+), 37 deletions(-)
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
index 00000000000..d3f73997c7f
--- /dev/null
+++ b/tests/tcg/i386/system/meson.build
@@ -0,0 +1,49 @@
+tests = []
+
+minilib_dir = meson.current_source_dir() / '..' / '..' / 'minilib'
+minilib_printf = files(minilib_dir / 'printf.c')[0]
+link_script = files('kernel.ld')[0]
+boot = files('boot.S')[0]
+cflags = ['-nostdlib',
+          '-ffreestanding',
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
2.43.0


