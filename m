Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F61C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4cE-0002aQ-Eb; Fri, 10 Jul 2026 02:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cC-0002YW-Qg
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4cA-0004q5-IU
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:21:36 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEjq3752799
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AqEEQB68oUM
 y/cPuzdzDq78nJtV3fasg/hVTRelVOdo=; b=IP0+dX0VCWN29vmm21XQzAylby1
 gl/xfZZg1FoPkTeQo3PWSy6JO+q5/s5TZt8zoXMkAljiLi6L+N3f9AxBR81E1DCn
 s0mAZbAcqAXr8+GvJHMMSL1IE29K4NTqAz3aP4C/tGyvKQlJ6pPeqlHM0ChKjh+R
 Dp7QKEjN5+XvPPjwQbW/JP07Dpl5Sve2HDOm3wduZNWcMP0rsODJF6I97SMVAw2b
 aM93bK5WSBlo+pXgHTmYycPnGJnOokYpxni73fDkZEmwTwXki5Y2ehPxFd4hHxka
 u7lGXRP6nxY/JEjR40MlJ7p6A0RU9vFc4AY+bCA3weWGVrgZAQDpia9SjUw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjb9nv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:21:33 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c892143db7fso583614a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664492; x=1784269292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AqEEQB68oUMy/cPuzdzDq78nJtV3fasg/hVTRelVOdo=;
 b=Y271psCnsk3+n1bhTR2IKeXMjVnPIQ+Izxl6OtDV33c3tW+uxeFmsBmr+OKR0vdX/l
 0dz86U7tlUTxcZ5fLtnJ/+V3+ebL4rowMio+joJ+0QKkbsAhMH6ZzhLjO1Hr2RzfShfi
 1jKek0bcSZvId/JChLm6h0F8C1jwUEAdWXCXxlcjhHHQDf99WfmLCyGOpdNkg8umoVez
 mqfgJwrRi1F5VF3ZDxubZ53xtjdl5jOvlt04bmrI4sal920I+a/5XcPQ5LrLNNjdlduE
 927oJvZefCs7HvRoli+U+uwP+TKwml16V55XZiplo0DZUET5SPSkeTqDIKI/2hMonZ7/
 3+jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664492; x=1784269292;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AqEEQB68oUMy/cPuzdzDq78nJtV3fasg/hVTRelVOdo=;
 b=EXFu8MfgqIRVgG+VCBJHeGILE2AE8dIEzojk8EqAh2i1a6L3xAzm09+ev4/CONS5ms
 TzkztPnWouaJfs11Ke0KLQtAYydP3PtN5WH9xEXhSa01LkqAId7wC/BXWe4X2LoMPtr4
 roq1mwtluQOFeVhXvPXvEVKRBmtdxSghRr20OVaYre5WnPMOs0zGtMatKr7Ef9BUdEof
 ilZKj81yAzR4+P6y0xWKJKS5sL5TFpqHd7Fch6kOUdUjjauAoqKm22Svz5xf6tzvVGlV
 skMrh563I0DgQfrKeh3uWKtO+yYyQzmB89LmutvAzu7423cGro3slO/ytcV/LoQ3P9m5
 sfQg==
X-Gm-Message-State: AOJu0YzTugYPfhQRh3FOHuam4eWt3lpwRXbrwCcOGbUzS7MmvZ+IxUVk
 ir1c36JhVVgRhPLY50hIDfDvbK5P1mdJ0Xk6K2bXphIp4pBDdFYwUmBbp6rTDOquqISlfdtypgo
 ASyowWVneO3fgFyKOntNs91GlhAtbp5mBMSQZujI8SN+HmcC6JOTnb0R+ryK1Ie6uHw==
X-Gm-Gg: AfdE7ck4bw4Iadox3ZNAHpsAf9nuN1DZQ6K2Hky//g9G1/R9KlckeiMpshx+NJd7Kwb
 /K0xnZYvzbwQ3yqBzG384PnPbZ0xg6GRcYlBiBNh5d/Uldt7jPhOOL56GXECvkfTMmfa/+/po7V
 +scT/rWJgwl6232FGa9dY6kcdY0NAOzLbE4Z61v6xZNdNU+uEdQ/SpgRQPvhTCQYvBcmXVtcm3D
 /TmRdk1mglvZ1pN/Yx6Nl1MS35JKveBwTgDnvPr739NrUE/TSCJ7Mbwo7h/Exd4XUmx3V6k5XrE
 MrzqYg+pd1WNbFadT8yR4p7Fuf2vOhNH7WLag8qR+LtbNcPvqB1IaZGwtmfNACxamret3bKYV7J
 qrLiwEfOmuxahjRPvzRasIzRfw8ENCyq0Im9+iK0UKqpI/vqEa0yQAYIAZ9yuxmbosnwn0cbUPJ
 vRJE2kew==
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:7bf7:7903 with SMTP id
 adf61e73a8af0-3c0bceb7c03mr12363360637.15.1783664492380; 
 Thu, 09 Jul 2026 23:21:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d0c:b0:3bf:7bf7:7903 with SMTP id
 adf61e73a8af0-3c0bceb7c03mr12363311637.15.1783664491760; 
 Thu, 09 Jul 2026 23:21:31 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.21.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:21:30 -0700 (PDT)
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
Subject: [PATCH v4 37/97] tests/tcg/aarch64: user tests
Date: Thu,  9 Jul 2026 23:19:15 -0700
Message-ID: <20260710062016.1818125-38-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX5MCROs1YYFzB
 HAYmxLTdCjWFJ14++2ZDhN8loPp4cDBeCF6YGSW/U3Cp0nbnfuEbZ2f1pkRgCYe8JW+RAraAxny
 1UF2es9Y9f+pAWNWsPD2++kGJ+DFV74/L7D32aCNQfZEpJRK2juz2UaXi0P9SVfOeb0Ds8hb4hd
 Hxck0jeqtQK706oyyCrd/WogQ6EFBgE3apryzKvuKg9rGbaTUNQb8lixvUfuyAUssoUDTKHooA9
 Xp/en+KohMpv+buoyuJdbDpztKgjNNxY9OnWW878YYHbcFLXNXSn89yiQmlluHafofEzsXqXJiW
 yX9RqKzyJb4lwWbl5780YZskmef5N+1phBGf3P6iZyignSzi0IR5iZ7KcqnnFxiX6+7MJvGHYlc
 IfH+tLlNLDQV+gjKp6SpXXPxA37abW2vOPmoxe8/uNCsOPs4SHpOAsEamjZfNcZe+SHki6O4nc6
 znpMnlqpQOkz0AynaCg==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a508f6d cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=g1GwtVotfdDKb34erH4A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: pICllaKYDrTgl34yGaXFT-MoOlLZ-gqc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX4uKhxgw0447W
 NR8Kkjl0UlvZK5h8fGkMzlMmXyCsq5Hd8vc7dsj8DA3vxahqtKf+tBM2Uii7yEcK2vJvs+XcQOA
 F6sSiYc7JwU3Kti+lte2kQZ9PWNUn6o=
X-Proofpoint-ORIG-GUID: pICllaKYDrTgl34yGaXFT-MoOlLZ-gqc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100058
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
 tests/tcg/aarch64/meson.build | 205 ++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build         |   3 +
 2 files changed, 208 insertions(+)
 create mode 100644 tests/tcg/aarch64/meson.build

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
new file mode 100644
index 00000000000..959d1cf698f
--- /dev/null
+++ b/tests/tcg/aarch64/meson.build
@@ -0,0 +1,205 @@
+cc = 'aarch64-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
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
+  'fprcvt': '-march=armv9-a+fprcvt',
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
+# FPRCVT test
+tests += {
+  '../arm/fcvt.c': {
+    'exe_name': 'fcvt-fprcvt',
+    'cflags': ['-DFPRCVT', '-lm'],
+    # fprcvt is available only from gcc-16.
+    # Use raw opcode until it's available in cross container.
+    # 'cc_feat': 'fprcvt',
+    'expected_output': 'fcvt.ref'},
+}
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
+      'cc_docker_host_arch': cc_docker_host_arch,
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
index 8e07bfca69e..05f2487428b 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -132,6 +132,9 @@ foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
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


