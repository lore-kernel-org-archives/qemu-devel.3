Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru9-0004JP-Pl; Mon, 06 Jul 2026 18:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgru1-0003d4-FZ
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtx-0005fF-Qu
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:35:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEEfq1665540
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=e+K9PYLSzS0
 8otbTm5AobwDrMpFhGzfH908jnmnC4ag=; b=jpcenHQzfdZZViObPaDpJuqBMA+
 weTwx5krqUOxYfttDYGil7jkzsKuulG2pM/qL1ZDOybqpImvnsMPlhDCTFVGCs5n
 wwzHhzSArjwEsqlPgOo2TxK+1YC3z8Zj0W59xLHhTqcEuSX01MsqbFMO/qkpXOn2
 dBF+S7QJXEijiiFP6Dt3rf4vT1ul/JDqmFYnJbUHIlBWyCEKKt4gHWc9pqjh+imn
 5ka0VCl2yJ6XBhyU3bUxEiILFkLGtszaK0nWzdgYpTRe00DJLwKmw0j3+o6HeO75
 Owh5f3NDOdYBlu7v2sR6UrFxurw/qoOR2EYUOL57zAeZ9vxLGZs0jTko/lA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gu6gj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:45 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so5025969a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377285; x=1783982085; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e+K9PYLSzS08otbTm5AobwDrMpFhGzfH908jnmnC4ag=;
 b=TGs1KQbz7xB+m+JWWKoyxMscqyS2dyMxVcXAz/ofKprmlUY7GCLAc9BZCCd84//pIV
 O+qSpSLjZFI0Sg5VcFGMtbPNgjpithT3wyPHEbtOWJR/1c78nPqf1FTnn3iHcRu4a96+
 MppOZRl9dPLWW1SPPySasn3SHQxbE9bksj5/JwIxnq7KwuQwN9/8iBllMTZCxr6T22Gx
 eWXbqrUP0VgdBErs+fkENoL+V56BSE9feBteqCuNUxyYfRGC95n3ctOu2myTpiGjA4MN
 q3ezdFadib80nMHEfQ+8LlL7LTnJhY2NAzxu29NaQVbRAvwzqQOa91Z2R/9ELqmaMosA
 x0RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377285; x=1783982085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e+K9PYLSzS08otbTm5AobwDrMpFhGzfH908jnmnC4ag=;
 b=n+2MJPkP1wh/r/7En/YQZ6mwS5Km9cZ2lh3uiS8CJQ6ynS77t2WyyswzuvDh05J6VN
 5vXCoBbVsZPuyPcwUIvj0PSUfYD+kTI6MQfMaQK72tBzmOJzISRi0ijGeiqKmsVQgOwX
 MAqrbmAkMxgvjRUdAIkIjTK/qtI64+aZVas8UIXW6p7eZA/K0x5nwY5VjUMnhHBcG6pT
 ooII31mDt8bw/+JW0sa9cCH0VyGV3oR130189w2EkqNf9z54vL9oom/9R/iBjKbmrqY2
 cIPuf5XeDVpyL2QResqT+RdYfyVHaxiCB7KPrWBI544zu/iF/nmkbnIENTgk0hNkVik/
 y5gQ==
X-Gm-Message-State: AOJu0YxoUwIVO6tVHzWuZaeZ2zI1+OBelbC620d7oqLDTBjRmK9q0Dwo
 61f8OGU4iOVcogawA1TwEa4eaq66AOlAq0QQo4e8CHlIErROY3K/zIU2vYfR0UnIXKsST2nwki2
 lxnBj3Kxt073StLA3m/zb6mhh3656TOQKbl1C1f9NR4lu/gm+iIFirxASZSmSAwMcKw==
X-Gm-Gg: AfdE7cnS9x+hG68QMSPRpvOLXzhNuRzFtbKTWa48r/2DyuGgHXGtctRfGcSgSwnw3N0
 Wf2pGo/z4obrhqSNd+aYtwjQ7UMy3ZrzrqXx4O5k7M8MS5f3s8M9gggtGxeAHtvzRdBJVttjViN
 BvkAxg5BD13Nz2wORsekD6E2AVJo0SRLwhYlPSCvvgAknfJre3jnSN9a23f2gB1Mb93HTbSXS2o
 bZvVGeyg11u14lDbrAAbyHKS2RIR9MAomzxWCHRhkkGXvMHcFeTXzg87QHOqDm4qvw3Vaf3V97e
 F3NRlKGQbjahhDspCYLUfD01XVeeljWeXXQyD8QIEy0DoTfjlEZRDKzfVLb9vkrEH6cf7wyky+b
 wnnR60Fcf1G/L8OO4T6HG4juXMCzGMjUAr3x1sHpNEZUlBhV1GVchkFqcfYhJ8wu/6F2v1Yh9lM
 QovPjrIw==
X-Received: by 2002:a05:6a21:3988:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c08eecc5f1mr2903223637.48.1783377284602; 
 Mon, 06 Jul 2026 15:34:44 -0700 (PDT)
X-Received: by 2002:a05:6a21:3988:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c08eecc5f1mr2903189637.48.1783377284169; 
 Mon, 06 Jul 2026 15:34:44 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:43 -0700 (PDT)
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
Subject: [PATCH v3 34/91] tests/tcg/aarch64: user tests
Date: Mon,  6 Jul 2026 15:32:46 -0700
Message-ID: <20260706223343.988769-35-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JTdMY6G8u8GQCdtfr-JTHRdiTyXT1Xjq
X-Proofpoint-ORIG-GUID: JTdMY6G8u8GQCdtfr-JTHRdiTyXT1Xjq
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c2d85 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=g1GwtVotfdDKb34erH4A:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX+yQjUVFO/Yky
 gOB70tiQs7DaZskF4L8HsyZIOLuswXAvNfe2EjZOuCePX4/B1MDUt+BnHHBYO16U/NIHOoeacWU
 jeBn7HBVbcbjiYAOnynI4WBo1n+l0NQ/0ibmIJOhYroHCbF9fs3/sOwcYUNcRKfQHILBrOIbs7f
 OepjfNIKgLU16SZR/5NSK60hnsZ6op1ZTZiVMNEwLAKQQeE6F3yNnQ3JGCNGq2huNmUrFt9JKdT
 v+szog9Qro2WHokzeKnG3ThXpjuAU9RXR+U0/ROzZum3EL6UOBSwxCKYL2f8i/w03ZHGOx1Kxnk
 vv7VXxTcxuggAvL0D2PHieYNT+05soEPbFFBJZxWoQaV5pvEeXx8U+6yv8pbMmRzYEFIQ4yvBEh
 sbIpnpEnI6Z6VutC9cmOEfhtStg0w7rVeu7pmOZ+aGWojJj7oDxMWQZ66VSygT/KBCLGOT0Wxxi
 3vIglOskdLKuz6rV32w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX6VHP3RqUYpGE
 VDulUcLtJWbucadyRt80JaS1GQl1fsjdIANS9f1Yied8l7f/a6tSKOfGPdHTQuXbeaLRUsWGMx/
 uOvXmCURkQBQ4AHmdqStwkV8R3OEp98=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build | 193 ++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |   3 +
 2 files changed, 196 insertions(+)
 create mode 100644 tests/tcg/aarch64/meson.build

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..0fa49959473
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,193 @@
+cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_arch = ['aarch64', 'x86_64']
+
+cc_feat_cflags = {
+  'aes': '-march=armv8-a+aes',
+  'sve': '-march=armv8.1-a+sve',
+  'sve2': '-march=armv8.1-a+sve2',
+  'v8.2': '-march=armv8.2-a',
+  'v8.3': '-march=armv8.3-a',
+  'v8.5': '-march=armv8.5-a',
+  'bti':  '-mbranch-protection=standard',
+  'mte':  '-march=armv8.5-a+memtag',
+  'sme':  '-Wa,-march=armv9-a+sme',
+}
+
+gdb_feat_version = {
+  'sme-tiles': '14.1',
+  'mte': '15.1',
+  'mte-baremetal': '16.0',
+}
+
+tests = []
+
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+# Base architecture tests
+tests += {
+  '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
+  'pcalign-a64.c': {},
+  'lse2-fault.c': {},
+  'test-2248.c': {},
+  'test-2150.c': {},
+}
+
+tests += {'dcpop.c': {'cc_feat': 'v8.2'}}
+tests += {'dcpodp.c': {'cc_feat': 'v8.5'}}
+
+# Pauth Tests
+cpu_max = ['-cpu', 'max']
+cpu_neoverse = ['-cpu', 'neoverse-v1']
+tests += {
+  'test-2375.c': {'cc_feat': 'v8.3'},
+  'pauth-1.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  'pauth-2.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_max},
+  # Choose a cpu with FEAT_Pauth but without FEAT_FPAC for pauth-[45].
+  'pauth-4.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+  'pauth-5.c': {'cc_feat': 'v8.3', 'qemu_args': cpu_neoverse},
+}
+
+# BTI Tests
+# bti-1 tests the elf notes, so we require special compiler support.
+f = ['-fno-stack-protector', '-nostdlib']
+tests += {
+  'bti-1.c': {'cc_feat': 'bti', 'cflags': f},
+  'bti-3.c': {'cc_feat': 'bti', 'cflags': f},
+}
+# bti-2 tests PROT_BTI, so no special compiler support required.
+tests += {'bti-2.c': {}}
+
+# MTE Tests
+tests += {
+  'mte-1.c': {'cc_feat': 'mte'},
+  'mte-2.c': {'cc_feat': 'mte'},
+  'mte-3.c': {'cc_feat': 'mte'},
+  'mte-4.c': {'cc_feat': 'mte'},
+  'mte-5.c': {'cc_feat': 'mte'},
+  'mte-6.c': {'cc_feat': 'mte'},
+  'mte-7.c': {'cc_feat': 'mte'},
+  'mte-8.c': {'cc_feat': 'mte'},
+  'mte-9.c': {'cc_feat': 'mte'},
+  'mte-10.c': {'cc_feat': 'mte'},
+}
+tests += {
+  'mte-8.c': {
+    'gdb_test': ['--test', files('gdbstub/test-mte.py'), '--', '--mode=user'],
+    'gdb_feat': 'mte',
+  }
+}
+
+# SME Tests
+tests += {
+  'sme-outprod1.c': {'cc_feat': 'sme'},
+  'sme-smopa-1.c': {'cc_feat': 'sme'},
+  'sme-smopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-1.c': {'cc_feat': 'sme'},
+  'sme-fmopa-2.c': {'cc_feat': 'sme'},
+  'sme-fmopa-3.c': {'cc_feat': 'sme'},
+}
+sysregs_sme = 'sysregs-sme'
+tests += {
+  'sysregs.c': {
+    'exe_name': sysregs_sme,
+    'cc_feat': 'sme',
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_basic_za_test'],
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme-tile-slice',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme.py'), '--',
+                 'test_sme', '--gdb_tile_slice_test'],
+    'gdb_feat': 'sme-tiles',
+  }
+}
+tests += {
+  'sysregs.c': {
+    'test_name': 'sysregs-sme2',
+    'exe_name': sysregs_sme,
+    'gdb_test': ['--test', files('gdbstub/test-sme2.py')],
+  }
+}
+
+# GCS Tests
+tests += {
+  'gcsstr.c': {},
+  'gcspushm.c': {},
+  'gcsss.c': {},
+}
+
+# System Registers Tests
+tests += {'sysregs.c': {}}
+
+# Crypto Tests
+tests += {'test-aes.c': {'cc_feat': 'aes'}}
+
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
+# SVE Tests
+tests += {
+  'sve-ioctls.c': {'cc_feat': 'sve'},
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sve',
+     'cc_feat': 'sve',
+  },
+  'sve-str.c': {'cc_feat': 'sve', 'cflags': ['-O1']},
+}
+tests += {
+  'sysregs.c': {
+    'exe_name': 'sysregs-sve',
+    'cc_feat': 'sve',
+    'gdb_test': ['--test', files('gdbstub/test-sve.py')],
+  },
+  'sve-ioctls.c': {
+    'gdb_test': ['--test', files('gdbstub/test-sve-ioctl.py')],
+  },
+}
+
+# SVE2 Tests
+tests += {'test-826.c': {'cc_feat': 'sve2'}}
+
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
+if 'qemu-aarch64' in emulators
+  tcg_tests += {
+    'aarch64-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_arch': cc_docker_arch,
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'aarch64',
+      'gdb_arch': 'aarch64',
+      'gdb_feat_version': gdb_feat_version,
+      'qemu': emulators['qemu-aarch64'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index ea81426f905..50ec5af4906 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -133,6 +133,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
   tcg_tests += {target: {'tests': tests + plugin_tests}}
 endforeach
 
+# Now let's go through all architectures
+subdir('aarch64')
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


