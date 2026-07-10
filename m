Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9648EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gI-0008U4-F9; Fri, 10 Jul 2026 02:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gG-0008H4-Iv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gE-0005qi-PG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nCRA3752749
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kjjzVgtz9q1
 fkhroWJbVZfpeSpiDg4qsXtindJewMCs=; b=UC0/fu8ms7zFqn8vRN1J/8D9Qxr
 O7vHPqg2J2+eowtNEwZSfvuq8XA+c37j0wlJjzm3xm24bPLYiTYDYhvNk9Wej2tr
 qvs7G6RjBBwWIAvR/uqJxuJkB1KdT/xfmPWLRWGsvLOqqGEiutG2yOFispuCH3pw
 QhaFBYwSe0i5PrDOdZMfKj8/A5gVhcWBzuH52fjzKpxsyeO//4On2eIH7AoBCK/5
 RpihgegEXYCd146Uwb4pKHw/AB4F2DINETwqvVhRrf6/EC1REs9PLyCqxHFTk87s
 Kxc4GJPf/fwBoAzvfXmy+TzvHYu/O6svEH64nHVGP7Yq2lm9ossRh4pCoIw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjba96-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:35 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c88cfe287e1so608865a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664734; x=1784269534; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kjjzVgtz9q1fkhroWJbVZfpeSpiDg4qsXtindJewMCs=;
 b=VGewta07UMlwz1Tx/ClwInMH08x3UPJL/csiY0FFWNvZ5ri+DHDeZbOnE40kYZ5AlL
 ZIRBQObErh9m79wqWGyoKYwyNzd49WWVpzg07JBpY2CBFi2Lw79p1zMRJio1Q0cALCU7
 5G7lkDsOa+WGKuTpzScIcV79yPKAv9v+ciY9+DgpyWKj15qltJhUJQoRyf7fsLcDm2jr
 Bcer6Ff+QN30yfy5TmLibw8c0iZkJwhKcL2od7MmTd01iRIfti61/Jfv94syOaQRWtNm
 7Ldv+eIdkByCPwBzqynAs2xKckoetvYSAoDW9OYV/M2fGWdn4gT/YeEX61759ohuTpmZ
 A+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664734; x=1784269534;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kjjzVgtz9q1fkhroWJbVZfpeSpiDg4qsXtindJewMCs=;
 b=bWBnEVy6NojsZYawH4CaUfC15qt2vavCNlgOGAIb9rczA0PQtZ21BdZKGMrw0DMMmk
 pfzw9iOJRJYhx/+yHlyb5yj5J3+Fg8KIFBa+S6VAU3dQT7upQ732YWPJPJl9k/w57oUI
 x+almCw8A21UkxrW1aYAweLjimYbQs+x4cUdV+QW76BZ5jvCApbnTWoi1vj1T0FZGdiX
 gsZM7sD/b1qI/arvgpjw8TzBhONOmYWx5FMFE6DKiOf3To0SAG7aiX++ketZ2PhGjgM7
 tY5zK7u+HQw1cjped6YF1h3wW9JFYHlRm7ZdbL/+5f3UScQs75pNFZfUBYpWPnDOIDre
 PsnA==
X-Gm-Message-State: AOJu0YydOzvYQTeFGTZCJY9p2jBhHtlCutT/19Ygi5EbSm1fQduzBj+A
 aRelxId/g1cCihCgraIiJptnTWHkx6+GV0/MF1RCz6CbuNs+mYB5iG/bjmzjhOgx13+d1RoCeDi
 bQd88BsgM0Y4kRNOZ+dk6VR+NunkPCjwgksUzxDGbdWTMQo70bTH6jXzx8e6ed5lI4Q==
X-Gm-Gg: AfdE7cmFHivrEcH1AgEFzj7FDeIHAbpqSFVAJNnrvQ3lTbCJkYFVP026VbW46hGMggA
 pJmyms61ONymWLj0jsxSdwS0fCg7T1cb6BPCO6TDqZKUA9iqkw4LuTUlm5JfjWEbRHlo5a9drpA
 JfmkSQdwHKVbAyTK3vHZ+KfGzja9+SxQQcKTef1UhfTSv1COA3PvAwrdP92FiW//ElgroAlZFdh
 6NXpHXn8f2wg3b+T++fRzGjvvyFlf4KrOidHlz1Ln/tiWRj63jkkkIpPJUnkSVzWQN4oEgGTKeC
 a4Vt/N4DcOZt0bEj35QnIBTujtluoM8J7p7DTnhG+8nD8bMf8E20bT5qJvPm+iS3nsIFd1Q4kKV
 AVKjI/gb4oZDEU6pkF+Yvo2Tbr9O6DWMWhEY1jA24BgMIddr6uvjbXhjD8xh7T08TdzQLitSLrx
 WRESO58Q==
X-Received: by 2002:a05:6a20:6a21:b0:3c0:9c19:b271 with SMTP id
 adf61e73a8af0-3c0bcc1a759mr12163264637.63.1783664734298; 
 Thu, 09 Jul 2026 23:25:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a21:b0:3c0:9c19:b271 with SMTP id
 adf61e73a8af0-3c0bcc1a759mr12163236637.63.1783664733833; 
 Thu, 09 Jul 2026 23:25:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:32 -0700 (PDT)
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
Subject: [PATCH v4 55/97] tests/tcg/loongarch64: system tests
Date: Thu,  9 Jul 2026 23:19:33 -0700
Message-ID: <20260710062016.1818125-56-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX726LrSzAYAzb
 iA4Z+HLi9G+59uUYsdCpNlr0rNr3bUwvf4TfRdVyuxcYixTQlBcEgNRx3lmQcsNXyJjqhuO3UUP
 SfI2V+ByXr2jnl8mgBxtV8srQwIAAM0P4WXIQsrO3J+drTwEjmoMsD1DO06cOFrWEQVd4s+Vl3D
 AP0hO4yqBFBmVON6GBSqRpbvySuvuE9lBZm5KWsVfRiguH9mVqvRm8zX1l42HAD9dwZMpYTR9Yh
 oTLjeinoecaKExahuu66C87qdHDeulOK+3B9xQUBfvqGW/B8gNLscn/ISBRrUH4O4V0LOr222XC
 JXAvwZoRlalgi7thmi+CvvqARQnA8R4lifLFzq48PNHDVixJiWV1xM+m8bzh/mE+Xk88gGDQxqH
 p2IZ56YrKwmM37fvxlF1LivCNxNfnCtOktHKBE9jt23/jQzk0ywlFhm6oqbsMdQPatEGs1nZVDP
 eSwXaIs77XqEqx++46w==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a50905f cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4F7OrdlOo6ohLtspjYMA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: PGBdG4de7xZtzZsWiy-gzt_sm6GTKNqu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXygOSPAYrOmBk
 /l/QABSYhH+TAJtbxdfp7XuQul1coXm8cdvRZFV9sMrMBzRdYJCNwZk1tyeimpjuoXDwXhoXckK
 Lca+9YiyAd40kdST8EdBI1+k6ybygPQ=
X-Proofpoint-ORIG-GUID: PGBdG4de7xZtzZsWiy-gzt_sm6GTKNqu
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
 tests/tcg/loongarch64/meson.build        |  2 +
 tests/tcg/loongarch64/system/meson.build | 47 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 tests/tcg/loongarch64/system/meson.build

diff --git a/tests/tcg/loongarch64/meson.build b/tests/tcg/loongarch64/meson.build
index 209179fd96c..1d62de64ed6 100644
--- a/tests/tcg/loongarch64/meson.build
+++ b/tests/tcg/loongarch64/meson.build
@@ -2,6 +2,8 @@ cc = 'loongarch64-unknown-linux-gnu-gcc'
 cc_dockerfile = 'debian-loongarch-cross'
 cc_docker_host_arch = ['x86_64']
 
+subdir('system')
+
 tests = []
 
 tests += tcg_tests['multiarch-linux-user']['tests']
diff --git a/tests/tcg/loongarch64/system/meson.build b/tests/tcg/loongarch64/system/meson.build
new file mode 100644
index 00000000000..b46d2234032
--- /dev/null
+++ b/tests/tcg/loongarch64/system/meson.build
@@ -0,0 +1,47 @@
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
+          '-march=loongarch64',
+          '-mabi=lp64d',
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
+      new_cflags += '-DCHECK_UNALIGNED=0'
+    endif
+    if src not in multi_src
+      setup += {'cflags': [new_cflags]}
+      multi_src += src
+    endif
+    tests += {src: setup + {'qemu_args': qemu_def_args}}
+  endforeach
+endforeach
+
+if 'qemu-system-loongarch64' in emulators
+  tcg_tests += {
+    'loongarch64-softmmu': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'loongarch64/system',
+      'gdb_arch': 'loongarch64',
+      'qemu': emulators['qemu-system-loongarch64'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


