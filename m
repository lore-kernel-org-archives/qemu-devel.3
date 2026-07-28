Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE98C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:46:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZfE-0004f0-MJ; Tue, 28 Jul 2026 00:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf5-0004Nt-5r
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZf2-0001aV-FL
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:43:25 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3aXbC1714737
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=; b=KhsXdbkMh7MKYhxH
 VAhacSxFDimaQWAHwHsX5KmTZ4IPrHGlmDFc5RU60nGi0Y1TSia1BM0ZTyxSN+em
 kEw3TVWkK5XJCtsBWuZMMd38hFtkwsAzDQb1QTchDQhO5fxHgrm6AIENm8kKkVuA
 H9WkcjiCvf34Q4Jzn3solc0WAOSc5/+DqJkjDBDei9kaPf7z6ctLAm/rBi83VObZ
 StweJNezJLkCBr2UV586B8IBMv99YQA24aWFMOvDvftA8AORX9z+GRgcXDKGsGm3
 kZlLvQucbK5re1Hc2slTR0npYcJqftPmHSM3uGZ96n3LmVTu0RHoNgM6GUSaq+Mu
 XL+Org==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpadkjxxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:43:23 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso7791498a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785213802; x=1785818602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=;
 b=EUdhPQsmlXtNBljcCM8ZWYopl6ncLPXlUKMVMAxTsTfDUIw06cIe/bDwsk5+YF9xOK
 8Z6g43+8/7dUBzIVCwnqmOkxqno4lVWH8grXP2D6/KyJ+7rDMyzCZngCTTp+Rrq6O/Nk
 wYT4cLc0G3iDvEsANdVtveVH1M/F/2ObXk4PkoEhKmPaYPs/Y6BD/XCAYztLneOPU3lC
 8COBWlqUhAFapUoxggNRkPcK35S/OHGW+wnms03qOGgU1fxDBQfshm+uTDnpuKXNefuY
 ZjqKl8N28U6cwfUJPG2qH5xc1vhJwJmuZ4yHhA2oBYMlhTq379q2junw1p0JwX76Juo9
 77dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785213802; x=1785818602;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dKpwp5oBkJ/y8AJ3LGje1zJDIDU0n3NEAYgUvWg2iAo=;
 b=rb96iUY6412t8+XNvMNkfwapJoa+0hGPvMRugq93j/3DtMPFufBerJOIM1wY1umgb8
 6Yo//Q/Lisq0s+BjG8cZwB11JcYatLVXbsivOhJwnL1miq+WIp4pR8cSOvBAPRxSEIit
 v3VUTh7f/Fmx4nU04tt3GkKI5h82b4gj4Y9tKnop/s5tuA8FGp17OlstMnxeIH7oABLz
 rKGDX7SkPEH+hejVAxUhZlZmLUXErpN4qA6oz6SZ/fS6xdVs4lEhLt1ZmEK8tIgIhO46
 Gu91G0z5yR7MYZxtQAGBH/bABT/SfshfAsMpE5QfYw0ZouyxeC/LMukK8bc6CBDks+fD
 cIKg==
X-Gm-Message-State: AOJu0YyyYwnEJ1b5QcDBp8hKB2vGLNch1gJOK+wqik0PsyA+5LqRozrX
 +P88R2EDqEczWaP2UfqcgyqZoP5r4bkHaMW6D+/D5E9sW4mHOA3rJDfYktvxF+HUUXe0wrcw5sP
 GZ/P7O8SkgmUik4abMeDSW123gmxuYc3fKsxG/hdlqgEzyeZNIc7ibtcEx8yDsSWRJA==
X-Gm-Gg: AR+sD12ReUtFXSC+rQ4Jxw8p3JNj+Feo5jKzC8lWZwYG05of7BMyzGedEMt2upCVGPc
 j8LOh382r8qSqlzz9SuUJhxSpxW5n/+te+ST1gaH0cACqvz77mx+LZ1jBE86CBskf4gvny0Op7c
 2S29rinYfdk/gDZ7eDmStUsjDBZOSgc1MyxtEVzT+o7caSnog4FiWOYjfcdfMYoxkCwgAAHld6C
 CC688DIGrMcDri3Xr0MLMl5egr/OriKajA4pROdX6nqxbeRz+VJeJ9NZCJeLGtsD+gfud6Tg6TG
 41qE313b3XJQchGoDzk2zqbsBhIiWdsxPizbzf29Q+nCgsJrNgcuRemDcSfKH849wUPb5Y2CeLe
 3lHQ6z1p/0I7DpvkD+FTNpGccstB9CAN5dWR+yW0h5rLKg5N1+ohPcikeLA5Dt9UlPdMf3sY=
X-Received: by 2002:a05:6a21:4d06:b0:3b4:7e2d:a3bc with SMTP id
 adf61e73a8af0-3c89ed58943mr1248367637.0.1785213802502; 
 Mon, 27 Jul 2026 21:43:22 -0700 (PDT)
X-Received: by 2002:a05:6a21:4d06:b0:3b4:7e2d:a3bc with SMTP id
 adf61e73a8af0-3c89ed58943mr1248342637.0.1785213802079; 
 Mon, 27 Jul 2026 21:43:22 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38795784eec.3.2026.07.27.21.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:43:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 013/103] tests/tcg/meson.build: test gdb support and
 introduce gdb_arch
Date: Mon, 27 Jul 2026 21:41:17 -0700
Message-ID: <20260728044248.137626-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YmptnyLF9CwHrZm3VkjvbQb-sW3fBUNQ
X-Proofpoint-GUID: YmptnyLF9CwHrZm3VkjvbQb-sW3fBUNQ
X-Authority-Analysis: v=2.4 cv=Ns7htcdJ c=1 sm=1 tr=0 ts=6a68336b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=EVhyENkjGFIjn4asmzEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfX4F5hRQsGf3Y6
 b1jLXrQ/B3319gaXN8UpipB8Xm596u2rzo1gOXz//5AOXCv78xdoLoabFnU+H+qWIkeH94f6giP
 /mhY4OKS+x0lc9Un9xNPkM0UO4XCCc4Q08wktUBz5DC0ITB2/a90njIBYNo10OViuR5t3a/eP09
 ZEtt5+yhpI4um7h0fWyBa5bK0s+uRgHUbyHKN0SLioDOAl0K3Faaxw62KW4fXB4MgBlAgkvmd8B
 wPTh+R/bT50Nqq8niUnM2b4qMSkRMTi1qJGVRN0PtsDOc9JxyVdykfLNKXf77vPJfdZkFc55j1L
 YxNUuSnsO7oB6ruals2ieVa1DjsMdY/g480nkHCdfDAfQwWmGofLkB2NITkHS4C8jDeE3vTVKct
 Hv864wMEIxrEnzvEiPHiBj8WAdSorYEQJYyOzo2CToXZxXxLwF74Ejp4mV5oFqEqnEa9Y4mWK8r
 71r/eFnxlJzQhcMX7RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MCBTYWx0ZWRfXyqZY8ErTQBmf
 0q/KNe7TkWk0RW1izx6zu2Dg5XOiik12C5NZ1V+dTAbjkj2eHplxbB33KRYRVwlCKoqx89KnRGu
 rcw6EB2Zvy4aOvHannGUVhqjpbideBU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280040
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
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 7b51750b016..3714fe4dc0d 100644
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


