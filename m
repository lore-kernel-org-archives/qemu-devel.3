Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CD2C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:25:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4ff-0007Es-HU; Fri, 10 Jul 2026 02:25:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fc-0007DS-5Q
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fa-0005hZ-Ip
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:07 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3n1cT3661653
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=AzQ9L8ooMLv
 rvE02RV55VplKn3X/zgtuCuSTqzC58PU=; b=CX2RqqI3LIVTyXawI/IIVaPK5DD
 Og9d5q2mEwO2ODJsl3Q/dN7UkMgYa7txoGL+YSqn4O4aLBGYXCUsexN7MNzIDs8x
 dKUHDiqU8x67XR+n3Q6/sOLQLyPFwHR4ANAcwZFxPzyMES8+q4RFoKGIFAZ7kFNq
 K+fnphtTtBIAnbCQiZODqSEaUo48wxluHDD7X0Ievz/eMORwWArAoKdtmaEoRORV
 YkaY7foqLQoPtsds+6Vi3dYEJEv8pStQBxnY/QpQ7IqnGzE8X4u1Yay/XP1GLA8I
 SC9DvxBeq5mtot9WjPLTD/2hwx6Ivu3tEQdNmqceonYgNEg4Jjf93a8AbiA==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faf24twne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8487a20472aso200843b3a.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664704; x=1784269504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AzQ9L8ooMLvrvE02RV55VplKn3X/zgtuCuSTqzC58PU=;
 b=TlTgms7SZQ31bbJr0smu2zRfi5pcTj04Kb4Yy5fSXy0RG0c7vf0DPAqijdA3DNVnKS
 6Il4MVnTIFDS/JqugJWazghb/LgbJGUtWAX43F32J/YWRAgNmYNeL4HXWKtzKSHyT29+
 GN3t1y42kUTI15R/l9g8Iki0IZ4UnIek6iVtCA1WSu0cPAblycWZLVbGwm0f70Ng18mn
 +BEjBfbIcNBJ5BiXjSyMdzES9fv1gonkDH+fEkPKkEFEqCRyOhhIs3CR8zhOMnJBJO1W
 hi7eMNxgoC0/zcu5uYfElNoGuB4TGFrLvhJMvwtD1yWJ5Uv5hJUyQZKmJ5Mx24b4algS
 vzZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664704; x=1784269504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AzQ9L8ooMLvrvE02RV55VplKn3X/zgtuCuSTqzC58PU=;
 b=iw1MvvlwW+wi9fcOBPcnUbabYq/f9vav+p/pIvB8Gj21ztJtIsjgAxTi0rghQr6VYx
 MlVA4lG9rYRjhvPGF9Mijt+pwDKTUCgzOiz52wdyii1sXfLFL1yEhCbsWsG46mc5LE2V
 NrEPa4EOVBiccoUlxRxlhK7LAkqDJ4hnTf5eDvTBODIdAVmbaUxEEUXmGcadU25ZU2F9
 o2RKHK8FoTRIGt3YERQ3c2qOBNPhIIC1f4N4NK/71UjQiVdkpmZZTeN1oHYN7maIZ0Go
 z+1uMfbgzgMLnURs5UinkftFE9nGPp6zTsYrL1aAMXoDu6po8qMI2YBVa/5uhyaatBGE
 1NrQ==
X-Gm-Message-State: AOJu0YyAERFVf7OWEfrEOQFan17p0+NeFj510aYgbXsuADDnbRtcgdgi
 PWDx9uDVVxNm5+3IE05WWgQG16m+GsvSf8LkKKKBxwWAkvSBpJGya2b4rLk63FJX0zi17wFuoes
 ZLuMFxtXf4RQYN+ySEg13HICGDld+GrbJtEvchYbPf/qJTO93nN07KYtdZ+eH1mvrCQ==
X-Gm-Gg: AfdE7cm93SYnOA1Kc5ONJ6+wCIufv1LXMcmpFHGMZl4ETd7W3rB1tumU/89E49lf8Zj
 Q2p/3NaIbtvf5+JsUFR30XrnJfzELfLKOw42BF2GXI+3bUF2OrNArOrRbPvZrWSQ33i3Cq6TTvb
 cc2A8ZVXzbAd5TDXDwVpfwkNRZ9ZxZTkXY580rGaMd9nu66x3CPkjknA0sIUecqXk3Tb/M+cauD
 IHUOXHf1QofVh2ft4gtfizuDBgI0veHM8sx/nlcfPkxoTPNFqmOh7XlIMURpHR8AsTIH1YxakC0
 KnMEWv/00zc7c2TeG4LqypTYiC+XIzmFHGmhlnwDiTVgpvpQSUm4ZciXfaITg55XWzluAq4J6Z0
 c7W6dEDPxgYY6AcvhPXmyao9a/37+YTzxRuU1K9mALLiDe/cyk4TX5C7tkIyUAbYuJG2hgmhZig
 g9I9W8HQ==
X-Received: by 2002:a05:6a20:3d26:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3c0bc905178mr13255202637.24.1783664704539; 
 Thu, 09 Jul 2026 23:25:04 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d26:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3c0bc905178mr13255154637.24.1783664703926; 
 Thu, 09 Jul 2026 23:25:03 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:03 -0700 (PDT)
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
Subject: [PATCH v4 42/97] tests/tcg/alpha: user tests
Date: Thu,  9 Jul 2026 23:19:20 -0700
Message-ID: <20260710062016.1818125-43-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: gMD11ck5u7oc5HewmMMwQP9OYwsVbaC8
X-Proofpoint-ORIG-GUID: gMD11ck5u7oc5HewmMMwQP9OYwsVbaC8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX5I0fmhTsUUVx
 K1QuK7R0YGs2baP+UZtFSemVi2N92T0uQ90mMyqYUfyEWiSe/Zn7SiU3JK1Zf0QSiKga6T63r6b
 GIZtPlXqG6mKHG+ffpNtlwupq3kHaJY=
X-Authority-Analysis: v=2.4 cv=daKwG3Xe c=1 sm=1 tr=0 ts=6a509041 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=KwDHnCMQy87TepIpjtgA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX4fThi0xFT6ZN
 9IgPcYvybrPGpIbl/OWkl5P8bbFxwo5PPtcqLEChqVACKGs8lyDlhdZ58rDoK/a+D0N+FuhtLkT
 YsdHbB5FC6R8phIgY53lgOjfigXIWZCNUXpFFetXJu95UfqXkSUg2HDha+Hz4zhARBMyftgvutU
 M3yzNgxjJ4zkHpdlSqJkficR++4Z7wwmYUuf904NMJ0thxQlORLoP1qkJTGw8/nIAkd9EnppqA7
 E/kv7sqbvAXL5hSO84V020iSoFmpcwdv9dBQP9TCQUmY/ebxkb2tilb/rRYgplZoTPGbXRSrmPX
 y1tQVDJ9xk0/k5LoTlV6gWfkifPqdhJukgb+2u1zrz18ncVsmPVr/n5olcEPFC+dfisbmwBSauB
 2TFqtX14rR9HNi7nqHN/r3KUwYTaxql0p6S7/3S617Vmf1Z7iWN96XWIJm4W5CvjHYqM4CGfN3a
 TiM1Se9bWIK1LE6kRAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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
 tests/tcg/alpha/meson.build | 53 +++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build       |  1 +
 2 files changed, 54 insertions(+)
 create mode 100644 tests/tcg/alpha/meson.build

diff --git a/tests/tcg/alpha/meson.build b/tests/tcg/alpha/meson.build
new file mode 100644
index 00000000000..08e371116c3
--- /dev/null
+++ b/tests/tcg/alpha/meson.build
@@ -0,0 +1,53 @@
+cc = 'alpha-linux-gnu-gcc'
+cc_dockerfile = 'debian-all-test-cross'
+cc_docker_host_arch = ['aarch64', 'x86_64']
+
+tests = []
+
+# Multi arch tests
+multi_src = []
+foreach t: tcg_tests['multiarch-linux-user']['tests']
+  foreach src, setup: t
+    new_cflags = []
+    if 'cflags' in setup
+      new_cflags = setup['cflags']
+    endif
+    # Force generation of byte read/write
+    if fs.stem(src) == 'test-plugin-mem-access'
+      new_cflags += ['-mbwx']
+    endif
+    if src not in multi_src
+      setup += {'cflags': new_cflags}
+      multi_src += src
+    endif
+    tests += {src: setup}
+  endforeach
+endforeach
+
+tests += {
+  'hello-alpha.c': {},
+  'test-cond.c': {},
+  'test-cvttq.c': {},
+  'test-ovf.c': {},
+}
+
+tests += {
+  'test-cond.c': {
+    'cflags': ['-DTEST_CMOV'],
+    'exe_name': 'test-cmov'
+  },
+}
+
+if 'qemu-alpha' in emulators
+  tcg_tests += {
+    'alpha-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'alpha',
+      'gdb_arch': 'alpha',
+      'qemu': emulators['qemu-alpha'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a17195c3b9b..05e2078505f 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -135,6 +135,7 @@ endforeach
 # Now let's go through all architectures
 subdir('aarch64')
 subdir('aarch64_be')
+subdir('alpha')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


