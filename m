Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF0CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fh-0007Hh-MV; Fri, 10 Jul 2026 02:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fg-0007F5-1t
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fd-0005iE-J7
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:11 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEIw3752816
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=szDTt+wHbgK
 xe29RQlES3YoZId/u/XLc5XPLDsQEs+I=; b=e08L8a7aXc6IWJHLhkAflNoGdr6
 G0YXFwLQoVKwl0vsjlWKzWqIzPPkwnSAueKZQ90FpCIixopIRh4uI4LjxQqpONa1
 k95PighSZuLznxVlVzHVH2woGylh25+5rE137HYddH8PgOVBCTNIwMt/W2TmXw7m
 einzHLOuJFwmSWUDEyJdHYJ23edsSVahKrXQ5CwJGFShIlDlLUVaWHdQKu5aGSmu
 Ixo/WRLWfxS0P+799IABG93GjGllDKFzGlLSqPwBQHjw61XT8jf7pgO6w9wRc67I
 JJwdVVH70yksl9lsCRC84xXCnAVARpAQOi6GgwplbVJNSJjMPGY+BZ2no+Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjba6m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:07 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-ca860baea9fso1298159a12.2
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664707; x=1784269507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=szDTt+wHbgKxe29RQlES3YoZId/u/XLc5XPLDsQEs+I=;
 b=O/uk+DQttXaLlAcQZczfTvwX1QXiB4TjLCwilUAhj89wVAPyhLAJUjNJUbDQbcJeN8
 ebWqNdn+xQaweAGgvz3FDQvE3DCv/blnzVZs3bPRvoHrXWuMAtO1GUEdkyDWXf2XdcRB
 GTlnP08uhp3Keja8f51BKj+Ut9U/dmumCtiRw3wGjoeuC1Ad/mhUwliREgiWlG0egzJ+
 eF+eIUKnWBQCEWh/DfayefeaginJjhS0z6VfGyZ41m9UvWZreXxn/vwJRmucGFuimOVm
 5ZoGb8hQdtnhabeHE5J9KzUqIhdiTa6YH+1Xe2lN5sqXmMILJeQfLosC2vKBW4gnvlD8
 6jKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664707; x=1784269507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=szDTt+wHbgKxe29RQlES3YoZId/u/XLc5XPLDsQEs+I=;
 b=RNNBttuDRoJEV9lNSMEyBQwtjcJHHXzXO1EjXx7DfftWqNtP8Llrckq5FKmazBfaiQ
 sabUYkH5izaZ0mibWnq5ePJqGwBq4Ov3lPr78Ezd2Gf3ylw51BPTrKI03OGXOFG76Qg7
 0oCGR/cv1o+4PbXbIhmarDb5qBHckupOK+6ONGOSwjnz2ZITs9mDKfbfsMCJyHMU/Gto
 7MvkU8keg14+jFmUwk2jo6xG60HoEqFdtUGisdbjFjq2/tVEOouLDLle9uSPWggkZxUt
 DkCku0RNYzpBQHZSM4TBpfGOhkr2BMOyktdh4VwUdips4ScUn6SuqWkGgCOm5HvXHlZO
 rFOA==
X-Gm-Message-State: AOJu0YyGpibltKYQXSAmmk2LADj9DWgPtHADHzFa39OYyGHaNix649hF
 YabdGxsHLIaXZW5Os8gRBR0VWJ5Q3t36rps5Tev9TFdn1def0iiqIWpYil28J++3gFpWjVe8nAf
 JLSTPiaqu0BbWUACCVlXLMdSkxbQp01JKighVN0rDFh26LHDMSZCUtWTjeeoo6yxrpA==
X-Gm-Gg: AfdE7cl0IK2BE+L4O9CcVu0Fo8UXj1MEaa/73N8wLvEQH3XKdbNvaR/VvYZOI+6Ijzk
 Db0YX6NQz1ZGuQPddFPgfRBUDGwj6yBKdVma7us9UQ9VcHMctgk19pUPNmWOBHodvdk+pLmpUag
 Pq9aAxoZ3vd3+9OcW2KmRvFA8iZxHJIJ+gE46aIhikPj3V08k0S+vDFymtGPujN6mzN74aI7b4c
 QBtja7prht6WrSFdz5Y5G/nvSYQ6+QBdt1/iCMvh3UiNQpW6cEu93cedyUXotE0TXHtYCPyyOoJ
 5haiG0QtF4021EiOXr6lPblP2zDyNSeCi217Y7NeAyr9VuX4j6QRK/iiUl0Y7P9QtxeG7HM8hmJ
 +fBWhz25Oat4U/egUXviK1ecOreNisAqROkHc40XZgSk/3GPM1AmvJmflPmQDe8NRzyhcVhki0l
 Prl1wFEQ==
X-Received: by 2002:a05:6a21:6e86:b0:3a8:9dd:75d5 with SMTP id
 adf61e73a8af0-3c0bcfea3demr13892362637.24.1783664706499; 
 Thu, 09 Jul 2026 23:25:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e86:b0:3a8:9dd:75d5 with SMTP id
 adf61e73a8af0-3c0bcfea3demr13892319637.24.1783664706018; 
 Thu, 09 Jul 2026 23:25:06 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:05 -0700 (PDT)
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
Subject: [PATCH v4 43/97] tests/tcg/alpha: system tests
Date: Thu,  9 Jul 2026 23:19:21 -0700
Message-ID: <20260710062016.1818125-44-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX3+/LbxbipEo8
 GZwUqjH3trVGg44OFp6DzZIYAEkZgRPQden4SuLD9+hdlyHzPp9KX0UIMUXDFtZApo5dTN7s3IH
 kFcZNNsuRq1tZLOX1KPkv8sfUTcKJfM5uXFzRkHZnMm5MfqZVq7AyPQfeSvkYl7yP8RnpvkTqq7
 CMf4OZtfOK0R4jDA7MFux4YMb83Bf3Vpe6lKI/HVwFMVsym9F3rCSQOS4pmeEluo0wGWCTVSlhG
 I22zzA7B1p3BPso+M1rCrsVKrPZmqiGqjBVrXEqrweYoxvvsK2l0ddfklDdJwTnvphiUEElJ1Sy
 QJn3BFzKZC8ZYA0j8+IdaltxzWfml2W3c76PRPH2Dwzoy06tWhbPAMWy5e3bTKT7bGBId8LeKeO
 +Y0RF7XVZ2U52AALv+4q498HMomuSV1O1lYge8Y5iBWtrosMLWnZTCLsrlZW9LGF1iXiUS+W0N0
 N9Ww1qlEYtzDGb3r1Cw==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509043 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=c4cJLtc-M2xr-Rx9CbYA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: UoU-LwrlExF_qnNgJOnQUDtY-jCJ3gZx
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX4xjFwa8mm7bp
 CNuC72J3mVWSVkFmuR2z23tWbuGXLfJ4SphH70A9muRrQ/LoCXJKKkX0EIfHi+Or2s6RmV3YRTh
 WedInATIG2hoqoFF/Fgfuogs2cKvw/o=
X-Proofpoint-ORIG-GUID: UoU-LwrlExF_qnNgJOnQUDtY-jCJ3gZx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100059
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
 tests/tcg/alpha/meson.build        |  2 ++
 tests/tcg/alpha/system/meson.build | 46 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)
 create mode 100644 tests/tcg/alpha/system/meson.build

diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
index 08e371116c3..fe60ce2496a 100644
--- a/tests/tcg/alpha/meson.build
+++ b/tests/tcg/alpha/meson.build
@@ -2,6 +2,8 @@ cc = 'alpha-linux-gnu-gcc'
 cc_dockerfile = 'debian-all-test-cross'
 cc_docker_host_arch = ['aarch64', 'x86_64']
 
+subdir('system')
+
 tests = []
 
 # Multi arch tests
diff --git a/tests/tcg/alpha/system/meson.build b/tests/tcg/alpha/system/meson.build
new file mode 100644
index 00000000000..06558e4a9f6
--- /dev/null
+++ b/tests/tcg/alpha/system/meson.build
@@ -0,0 +1,46 @@
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
+          '-mcpu=ev6',
+          '-Wl,--no-warn-rwx-segments',
+          '-lgcc']
+qemu_def_args = ['-display', 'none',
+                 '-serial', 'stdio',
+                 '-kernel']
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-softmmu']['tests']
+  foreach src, setup: t
+    new_cflags = cflags
+    if fs.stem(src) == 'memory'
+      new_cflags += ['-DCHECK_UNALIGNED=0', '-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-alpha' in emulators
+  tcg_tests += {
+    'alpha-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha/system',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-system-alpha'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


