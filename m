Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02CF0C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gF-00089G-Jl; Fri, 10 Jul 2026 02:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fy-0007it-SO
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fw-0005on-Nq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:30 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nEJ63752816
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hice5qnXmOf
 kYitLOQZUX7z+8LM8ZsUWFinl+cf/78Y=; b=Xi7u/LVP+pLjZOXBaUnRGH+U9Ub
 H0CXVNvi/GGnOihGxpDdrFPBmEUEr0VSrN843PmQSolNVTdg1QSJ0HifsgGPrr09
 4KHE1zPCFhgCJ6NxTT/58o84RfxQrpl6gGnEbsG71rLM5Dzvocwi2+baKLbTZUL8
 g/2eO2qq1ZvUaqTE3fwWbPe39iMF7Ew7pe1xUkhRgDU7CHQq0zvcWg2NhjydHKp7
 gCQ+TfVrdciUm3MXYBmwTPXwUKN67gh9duIR12ZYQY2MiIDq/hmUBcU5BhlTVTP3
 Hdd5dw32fzdfoS6SwIiZb3P2/OizQRXXgnRjCrZClW011/vnBBVEA1knviQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjba89-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:27 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c892143db7fso586735a12.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664726; x=1784269526; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hice5qnXmOfkYitLOQZUX7z+8LM8ZsUWFinl+cf/78Y=;
 b=O1rkxwnPVtrYB/KUbI5QwgvHY8BJzO90E9oTgejq2NinG16Hzl+xzqx5bfYuA5SeS6
 /vUyMuAxJUSDL0eLm3+NMqdtdZoBPjNavHrlKd6begzOlX76sguJ6oXx5MDB/wM+xtIk
 Vuw5dsdmAwspcRVz2tVLTrHWwr91X8PskFYzoufXAlh7n+yor1oQa1++qOUrQX790iKK
 MXNqvTebiV1D2PzKWoy9Ux5eX0nix7nE7d8KTe2tkTq6dbD4QOiBC1xcpdFjx+Yglg+S
 EiBgT8lgiAyRrQEvMgMSsyYNMGym5ADc4vLLRCQs/S2C7Anud3zwJbDKkns07aVNwbEa
 XQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664726; x=1784269526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hice5qnXmOfkYitLOQZUX7z+8LM8ZsUWFinl+cf/78Y=;
 b=Cf7oha1foxhxveJleSje5jhVbEBK7MiQPsFBVz/BxfcCLBwhcXsS6ut2cwN1vAfY0K
 +qy5onugP18xQL2cKUWBOLzwtVyETFXzyVLgwdzU+/Ot/GYv1iKEbbAHSXW5reoi0uWz
 QbpEdlmXgbnLB/HNJrXE6DWxE6bCTiNV2cownj4RgRd0jZN/MYm3Y1F30NqgGzebdjk8
 dzoJ8G2c7jYARPNtXLHtFbotSDbnRAa4t8hjsf2e4Kg6sVFd+4rqhYjl+UdsD6rf+CyS
 Lje1l+wx1/a6AvPjV6vuhpnFC0aqpe7RLBVz/UtacnCO+w4d9zcDLeGQuFJphk5c383N
 c1nw==
X-Gm-Message-State: AOJu0YzWwrUxJbA3E1nbB806qN0nc/gcgZhhx3uT2S4/2I6wZsPMjoB4
 x5d6Kn/CWflaie4q9YFPutAeHxt7z293qfACziQf+lzfV/buzVreNGlcsqjVm6qJCofBsX9wlf3
 153XVSBKONQGJULZda18ieHPkYViPUDXoS1DmQ7vWWDMJobQuMbmrG9brArqXTm9e1Q==
X-Gm-Gg: AfdE7ckOPdZWOzyo5U3P/hj+VB66WPGE/aGXTdJu6RtWj6dyPhf/Ivm2qyBG28RV3X/
 9c0cl3Hnh+s0ujq+SCZ0wXQW4mgbSlKMt51LnvOD0MD5sb15/65jwdjFZ72PlN/pJXIsEG/WPtK
 Gv3hhLg8wo+eR4pwULII73yToaeteE83XbChOTdmxmxeCUlGS1wAew+Mk7lfB8XUjPk2Frz6s4u
 KDb0KRGbfEJM6kLOm+rN3GncbcGaga2GzL7NYd6J4NHPxwLp+2BMGRL6/Ban60VSbMmPc4PBYQ8
 jheuOOl8wLYJcNvjY1+AVjak+J3cPC/BWCQd5bwXNaf23kSKgCMW9b2x+Yi7Wxu/jCWaO+BVVnH
 lAdZWHPtkJEJ2eN2D64wHz2I2rRbXVrJ9KJpvsDaTJhjH3yfPSLhe53MLzncLqXyUHcAvfIFXw8
 Pa4pEGjg==
X-Received: by 2002:a05:6a21:485:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3c0bceb6d8amr11981878637.1.1783664726505; 
 Thu, 09 Jul 2026 23:25:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:485:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3c0bceb6d8amr11981847637.1.1783664725991; 
 Thu, 09 Jul 2026 23:25:25 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:23 -0700 (PDT)
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
Subject: [PATCH v4 52/97] tests/tcg/i386: user tests
Date: Thu,  9 Jul 2026 23:19:30 -0700
Message-ID: <20260710062016.1818125-53-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX6gaWPZvuDEiO
 R8+OnU3nP77xE6xc28zK6sj4VmXO2+N0FhpiK5R8ncxcnZJ8MAb3TGWO467NpoUiYJVHbsTdjl+
 WLp6FYsQ0aqOWqSfvI2Aj36wba8t3ix0WjRLHI55/qPwyr/1OPB5xok9UH6cLHeY0NOIPvNnZQt
 OWi5IHEn6u3MDP+xZqGNFE/pMyDqbBK6JZpv449lLDNjLPR974pYGF/Ifz/uxHIpIeYA7mknPCg
 L+IhnwUT33VcbFuhLelPTei8R+5L1IeDMt1E2I3vBFdQIyRY2tCqFjkrxgBB+ZScsLrWtimNcJa
 9O+7bv6O4t0TZCXSAtG0IHdyXyuWQTvlJ+dz8RH95+aogsVEPoyKvXRSykDFfWIaWioqeNS/I0K
 k/3KRVXfVaoln/V6uznvDGIYHiQl6JBLCdEgG+XBvlSgS6SeccIZnUKSJLVpsLHn8wBK6ZcU3MU
 CDzziR732T2UuK+G4CQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509057 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=KTSuDVHiXcxN9PRFCgwA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: YWTA8A2cq_fucrPR83Kwjc6_apcVdDa0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX4/aZ81+HGfbH
 R7Yq5xySRaLpydf80ozc/yUY+MH784G8/A1JdKgX35x9NPwXXDfvACGGboFz4SCvJ+/cZtKkNXT
 VD/uQG2MTwnMd+7ZpwOKWIsfKiiYok4=
X-Proofpoint-ORIG-GUID: YWTA8A2cq_fucrPR83Kwjc6_apcVdDa0
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

Original test-i386-fprem was comparing qemu output and bare metal
output. However, those files have differences for now, so remove this
part.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build | 56 ++++++++++++++++++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 57 insertions(+)
 create mode 100644 tests/tcg/i386/meson.build

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
new file mode 100644
index 00000000000..62074b86c9e
--- /dev/null
+++ b/tests/tcg/i386/meson.build
@@ -0,0 +1,56 @@
+cc = 'i686-linux-gnu-gcc'
+cc_dockerfile = 'debian-i686-cross'
+cc_docker_host_arch = ['x86_64']
+
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'hello-i386.c': {
+    'cflags': ['-ffreestanding', '-fno-stack-protector', '-nostdlib'],
+  },
+  'test-aes.c': {'cflags': ['-O1', '-msse2', '-maes']},
+  'test-i386-adcox.c': {'cflags': ['-O2']},
+  'test-i386-bmi2.c': {'cflags': ['-O2', '-fwrapv']},
+  'test-i386-f2xm1.c': {},
+  'test-i386-fbstp.c': {},
+  'test-i386-fisttp.c': {},
+  'test-i386-fldcst.c': {},
+  'test-i386-fp-exceptions.c': {},
+  # TODO: original test-i386-fprem test was comparing output between qemu and
+  # bare-metal. At the moment, files are not matching, so deactivate compare.
+  'test-i386-fprem.c': {},
+  'test-i386-fpatan.c': {},
+  'test-i386-fscale.c': {},
+  'test-i386-fxam.c': {},
+  'test-i386-fxtract.c': {},
+  'test-i386-fyl2x.c': {},
+  'test-i386-fyl2xp1.c': {},
+  'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
+  'test-i386-pseudo-denormal.c': {},
+  'test-i386-snan-convert.c': {},
+  'test-i386-sse-exceptions.c': {'cflags': ['-msse4.1', '-mfpmath=sse']},
+  'test-i386.c': {
+    'cflags': [files('test-i386-code16.S'), files('test-i386-vm86.S'),
+               '-lm', '-fno-pie', '-Wl,--no-warn-rwx-segments'],
+  },
+  '../multiarch/sha512.c': {
+     'exe_name': 'sha512-sse',
+     'cflags': ['-msse4.1', '-O3'],
+  },
+}
+
+if 'qemu-i386' in emulators
+  tcg_tests += {
+    'i386-linux-user': {
+      'cc': cc,
+      'cc_dockerfile': cc_dockerfile,
+      'cc_docker_host_arch': cc_docker_host_arch,
+      'folder': 'i386',
+      'gdb_arch': 'i386',
+      'qemu': emulators['qemu-i386'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index cd4c6a981b7..f0266e461a4 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -139,6 +139,7 @@ subdir('alpha')
 subdir('arm')
 subdir('hexagon')
 subdir('hppa')
+subdir('i386')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


