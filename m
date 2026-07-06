Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D645C43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:43:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgs1d-0005dn-IS; Mon, 06 Jul 2026 18:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1b-0005db-U5
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgs1Y-0000As-Rf
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:42:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE4Iv1428809
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:42:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=EHNCe780dCW
 4cgG7+ZFoxdzYd4IEkiiZXjgZ9Qfb3u4=; b=JZISdOPBnj1nYsI0k0o1MXbFOdH
 hJKpB6lUch6t3AflJvMumOrMZtRfvEU9VDRepFj4hAqDXrIz8Y/u0hH9czE3P4rk
 Dx/GvY7HIbYoY0Chmt7fv23tbalp5dtD/oi1HGlu36NeXox+aQ/k+BCjp6GrBdDi
 h9kIkYZURBwjvK5Sze6Q20giFxfcSEMnhy4vN/bdm/7Oym6FF2BGTw8ppnGPJwup
 tv4gagyLvSL2e+PZmxkBirLkht7ORZxG1M3NbzcC/zZSB1LgjiBDjDHpFOdi9PJR
 1TJLx6L4pPKWHOcyBCudtVode/ocjgscyidQ7qvP/TsSDQ0ondG5rrBdprg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxutvn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:42:47 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2caf4173b1cso67818355ad.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377766; x=1783982566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EHNCe780dCW4cgG7+ZFoxdzYd4IEkiiZXjgZ9Qfb3u4=;
 b=SQLNI3uPei1nqxT36IGcvBciLBVqjP/axPoG4l8RKTkoMWOqTB3E2GGsQnGtIF7/mO
 dpLl7MsfHXg9+L+0QwDwYZVyOaEET9PAQieB/LI/No7HRYkZeDbUFLGpN3R0+wt4nhxg
 GoTKOsyTxiTFcUI5H/f9muO1JAfNrOcyNsDhsPDlgDqHh1EijntFAaUQnw6g7KdkFI70
 k/JL68W15whyftfsuEKVOjdpmjqWWj4cy7DRktZdUac2Z3ctqLFbCd3fd07FrTxtlFRb
 PEF5w5u96iz17BnsU187wv3e0YXz5L+tRypqkrt62ky4fbuku3H3wkl/FOtun/k8xWwn
 xxMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377766; x=1783982566;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EHNCe780dCW4cgG7+ZFoxdzYd4IEkiiZXjgZ9Qfb3u4=;
 b=rIdephGZxX2Yx2+3BkbFDece68NrA1S0L19Ki1ou9iagqBN3JLdE2YqwomPCp1H9y8
 qSYKf++GZHlk3y1mWMYxqn6a1qJckfmGogcgl5TojIDXIZfezM+gwIR2zFo+suJtvRH/
 VzyJX2PtMLsZs2KRqQ3kSvSoZvsqGR4SW9xIWMXdeIeo0pCVOHnWmWZzgHB3rHHwkP6x
 oprwagnvxZut3fF1AHtm9yQn82dPu8W+5Bw9mH/mq3P4YhsJE3aBEkfZXYzhpusLqqqr
 bGIsNriR58JjpblyI455V/AcS4xNX/cLtIQZIW9qgnJeeqD+PtWwf41yF3V22OOeP7I3
 OABw==
X-Gm-Message-State: AOJu0YxaejvrXPRdhBdxtuuM8GpIJlO413LNbeKiKvzwE24whjcRxn/L
 /pJ9DA3ML4YKM1igNncdGsNU1R7OKzMd3oGyed0GbhWX2lkkCf4qDaIIDrx6SuGdv3C30sKXJNB
 NYXjYpN9r+ssV79hpyCrcx2bdb1U+MzXJ4Y4xqyNq1nAegwd0lmpjrIDvvIN7wHu13A==
X-Gm-Gg: AfdE7cnLruoT5Bz9rycuWSpV1Gtq1GWf3bunyxCdOt6etc9A4gTL/9421XO4K8Tk37D
 tS22MR31SeTdMVs40kXSnc/OEIVPWd6/Kqev9vh/kairmx35pQBi7XFU/Gkm++QKrN6pTv8o3tl
 K8NBRMvU9pGCpsGfibB1tR5t98geRjwkGQUf+KjYEDmLC0Oil/YtHgkDLmaGL/b+uP62f4a3rSV
 8SxUpTkCeVBD31o5BCiyxN8/aw+6gNE8uuB+WUclbFne+kyfevnq1q8vHFZApR1NPtQY0TZMN4l
 mqD0Q2A9uQuTnJKAIrL5Ks9X9hS/81unfKimBXJRYIRWFx9qlDSSlQqvHCeKo+OMMRz3GRvc61g
 Gq39290DIdcuWNT5tcKsvEvTsfzLxiibn2QKbXx96zrEdVKnwcpdsXgG99cYwsRA4ug1UGCGY46
 EE07H+cg==
X-Received: by 2002:a05:6300:6715:b0:3c0:9c1b:d0b4 with SMTP id
 adf61e73a8af0-3c09c1bd4c3mr108812637.63.1783377766500; 
 Mon, 06 Jul 2026 15:42:46 -0700 (PDT)
X-Received: by 2002:a05:6300:6715:b0:3c0:9c1b:d0b4 with SMTP id
 adf61e73a8af0-3c09c1bd4c3mr108764637.63.1783377766013; 
 Mon, 06 Jul 2026 15:42:46 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1439200c88.14.2026.07.06.15.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:42:45 -0700 (PDT)
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
Subject: [PATCH v3 82/91] tests/tcg/tricore: system tests
Date: Mon,  6 Jul 2026 15:33:34 -0700
Message-ID: <20260706223343.988769-83-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yovTA1v6resU8_tdq0rfW6g4I0BmWu8m
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c2f67 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=iSAnQysEVfHONktP1iMA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4LWUXbEQ48lt
 iS/dnPUpOd567BqYEiQAqUGeZ33laR8TOdxGNmPLDdP2fPfNY+eyUyUJML1FKCz2+BBv04WPLQm
 2al6XAcn/GL19BhqYVsCfXpn899j3UU=
X-Proofpoint-GUID: yovTA1v6resU8_tdq0rfW6g4I0BmWu8m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4xrzGk866I7p
 8GsIOoJ1bQqcog78zggrorRmLQh4uMl5oUZOoHONpaaNFCfGLjjoHO1NeXf8tjvNS6jak1DoiFC
 AzBedd3zVjBZUJFJeuHKNp+Vjv3naknCEM2LslBR3w60AqjMuNWpCMNK8JoleaspEmUon3eZD98
 7/YRM6CeCBfahvaLSMLD2IUON4YhERmGZUv15gTVCFK9Cuc2Squ0ziFYFt39Fk8Z5QCL/Ni+KeH
 /MgUzKKnLmqDvgXW+szBAJjcYTa/Ev6ppe79aq91oEgzWNcti9f1dGkbUV9+xyxk9VRGsPzEx0o
 xBVGMYK8Y5ZkxrkWemRlQGezUG3tsY4RGLKjEV5r/268hHkY390Jfy/+5XyJA7XO5rWJDmGd2sh
 ozdEygV9LT4lSuqBLSrIp/cSrsFe+RKuWNVpGbSRMPIcHaEev/On/gGmtorslmgN6yY6nLZNK02
 SHdZ5KNV6+eIMclHu6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
 tests/tcg/meson.build         |  1 +
 tests/tcg/tricore/meson.build | 56 +++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/tricore/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 59e71d82c99..b2630176b7f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -152,6 +152,7 @@ subdir('ppc64le')
 subdir('riscv64')
 subdir('s390x')
 subdir('sh4')
+subdir('tricore')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/tricore/meson.build b/tests/tcg/tricore/meson.build
new file mode 100644
index 00000000000..6303d6a912c
--- /dev/null
+++ b/tests/tcg/tricore/meson.build
@@ -0,0 +1,56 @@
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
+             '-cpu', 'tc37x']
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
+      'cc_docker_arch': ['x86_64'],
+      'folder': 'tricore',
+      'gdb_arch': 'tricore',
+      'qemu': emulators['qemu-system-tricore'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


