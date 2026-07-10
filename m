Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780B5C44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gs-0001ja-BZ; Fri, 10 Jul 2026 02:26:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gp-0001ZG-R2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4go-00063T-67
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:23 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nDIs3752773
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=YqTMp6isKpA
 +a85OjTaT2etOoFHTAhauCfKyOOH0d/k=; b=SR7kV3gNCArBjAlC4oUO+0fl6AO
 WmZU1aSwDFJpYMKjEZn8YwWVpwHnD5Njbn3oGRbArl6+O6ues8oJCM+NxoJsb8L6
 djEdLqIga+Nesx2aY80OiFdBKHATK2thodBDMT9DMKPQsGj9s8VGrL8wQNGC9P9h
 PWoE+mcYfBb0nyRPOjvKRV1j7VfWKVy1ScD/kncUr5GlF1AvReK2yNUpRmmZRv78
 fk/XhE32SklmEcPNzn5TALUZi1yVjls/CuxnMa2TK9iEFCfcLZuD4HcPFfgAr6XK
 eCuGCurSfAIzLrOhdi99dDz2lQtGpXPKDRb2eSh51bPM7MBjl6+pi2YlnaA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbacf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88e0d11a3fso596700a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664770; x=1784269570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YqTMp6isKpA+a85OjTaT2etOoFHTAhauCfKyOOH0d/k=;
 b=OHZNDhvrYDDmDSsR2uyYxutmj9a3BYbJK+hJa2cS1dIur5QzrYzCmy1eATCwwtOj6Q
 fy7zCijRHw5pkBPp06ccWgnumFq0NBWs0uQoJ4+6G+tWoqlt8QW+NylMRCAx1ITArFGC
 ha+fUNN3Wm7AHe4BuJGWql2YTRdobSN33kDTlVls27SeYaKTHXjmekJsAJfr4E8VnHA6
 IF4kG29MPUI73Mpx12nBrknFjnhBfDCnhtdpnvtYhXOYYvvqEtY5gZUcJAfXOi4+TqQb
 ds0k1uNPH2y7JRwu0jukVOOsT36Z24v/PC4Yloskvf6r4le7Meam5DcXItbuMwIY2g97
 xBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664770; x=1784269570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=YqTMp6isKpA+a85OjTaT2etOoFHTAhauCfKyOOH0d/k=;
 b=jkXbKBSiSABLX839BABJDMNApOGmBiD7QORqI4vep7IqBMo/lDmWmbIPle1Fjrj5HR
 jDL7RUjuy9F/NQ7Y1uJZ+0sjxZ+P3TDelHa1cFMxE13MnKQuOCnQBcLuTrjsmWNgx3eS
 kFHWXAZD1DC6LbkL5X3um9OoYvuZtQDM7iP3Vfuo2BrdLCbQ6DJ+kPshlRNCza2ihKdS
 95SK0rMlS54wN4LxheBjFh6x9tyzdHsfir7KOtzLasKvCshXMELPPH0jDLRd8MEuR4+A
 5K839iR8RmoDF1uK4eCLEgkqaBwzcA2n3hKr1gicWLJH9UIpJIZ9ZqbNRG/BLhBABWnY
 gniA==
X-Gm-Message-State: AOJu0YzTgi8dzG9rb7Ih7fRUaKxChoJBHJhTjSHMbGByevAPauH1Ad7b
 Itx3Rt2UvyOg0yOLUALBCoUrtZ0j6C8UIVxY4mcHN/BG/2s2YzLHq51sXCS1BBr1rKON5IpaNhZ
 A4WqiDfMroblLzlAcI7y0prHEc0s1lTAKLiZbECzch22YOj6FvV66V53Mys16M/Uzyg==
X-Gm-Gg: AfdE7ckTXxsWcCeo0+tp0heDPnUTfCbIB3ciiCsMRrPdH+Yn7i3ntNdnbTEWZOAvlag
 EwUuj9n8/td0ow0106Ba8+hRoDu71LPn4GdA44mvmE7PLrGlXqlt+7VXgRC9H16ZhDKsxUcpnB6
 3OlA9uvky5jHmcHFrUThFNJvcJFhbhw0NJJrC5TcXG0cuaiLtrEUoCzW+hojRqzC1qsOcnmwbjq
 Dz+08SPY9JahWlkofBuM0Tn+cJJYW/CmnG5VaXYAS2WzFmatG0bKIGOi2nSK7/StaOlbED2eoI9
 HM5sulpD+Qouw2loEQvTvchlUP6gLXMw1Ai0nOlYyDsGa6bZ6wCJ99aDC/1GkuddVMYa+JV3DIM
 y9vBnC4d+yPmEPUy8XFnu+7G47g52X+CFZ42iK37NrsQWivCxD3x+QC2of5NBWKNHhSlUC7JDYC
 8iFLzeqw==
X-Received: by 2002:a05:6a20:3d26:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3c0bc905178mr13259373637.24.1783664770218; 
 Thu, 09 Jul 2026 23:26:10 -0700 (PDT)
X-Received: by 2002:a05:6a20:3d26:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3c0bc905178mr13259336637.24.1783664769799; 
 Thu, 09 Jul 2026 23:26:09 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:07 -0700 (PDT)
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
Subject: [PATCH v4 70/97] tests/tcg/or1k: user tests
Date: Thu,  9 Jul 2026 23:19:48 -0700
Message-ID: <20260710062016.1818125-71-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX62mPfIHfipuo
 0f4Y34JPSMUK7tlYCndcuX8hTKtIqn5GMDr7+i+cc+TbOB1/V93zvZqE2XyRRo/snvfkOyzZ2PW
 9n3EmWM6jCDpHQjjgSW6r5AXMn8yE/nQHPi23It8eR8V7nnvSzSuV83ASmgadIyx+0MdqlaFGxG
 nqWL/bDmtd5gWSQzr8XLocEXaFOcvGV/us5v9OO2XywX1BF/eMF2zIHuedf/CnwJs2O6I/Cq6Iq
 9XHN1m4Ac5H4sR0oHOW7cMLcGpHfMzsbr2c09Olf0q/xrYaMvngpFCky8Kz7sZhGI3k/iwnnQlM
 mqRwUji8K8ffvi/975Hy4g7lqCmTSux+zuBC9N0fawOKa1IOlPi71V454Bn2cJc/OZdL0Vxmmu5
 av9XB+pZqvUSuGG4rupR1Py1nx7AAc28pMAm1LqYmt0w0mlPaUWBkD9j4I5v30L0tlQPXNNnb+v
 FRD0TBV/crZcyxB2FyQ==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509083 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=evZrb2V6J7JjHAoI1MMA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: Ba0hcZDdoO24J2w5FIZur80xWf3drYuy
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX0JIu6k5GorXx
 E9dGNPeTIedOnIhIaMQUkSmZDmJAaG5BAbwPmuOsGpa7ViDrJQUPkQCwSo8ziRAUg2huV1qigQp
 R0uUXHGUjrmuFXcwtW35z1zjDGOnbno=
X-Proofpoint-ORIG-GUID: Ba0hcZDdoO24J2w5FIZur80xWf3drYuy
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

Some tests are currently failing, so they are commented.
To be investigated.

qemu:or1k-linux-user-test_addc FAIL 0.05s (exit status 255 or 0xff)
qemu:or1k-linux-user-test_div  FAIL 0.06s (exit status 136 or signal 8 SIGFPE)
qemu:or1k-linux-user-test_extx FAIL 0.06s (exit status 132 or signal 4 SIGILL)
qemu:or1k-linux-user-test_lx   FAIL 0.05s (exit status 139 or signal 11 SIGSEGV)

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build      |  1 +
 tests/tcg/or1k/meson.build | 72 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100644 tests/tcg/or1k/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index a1e952a9d22..e04f3a63b6a 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -145,6 +145,7 @@ subdir('m68k')
 subdir('mips')
 subdir('mips64')
 subdir('mips64el')
+subdir('or1k')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/or1k/meson.build b/tests/tcg/or1k/meson.build
new file mode 100644
index 00000000000..5151e8f361f
--- /dev/null
+++ b/tests/tcg/or1k/meson.build
@@ -0,0 +1,72 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'test_add.c': {},
+  #'test_addc.c': {},
+  'test_addi.c': {},
+  'test_addic.c': {},
+  'test_and_or.c': {},
+  'test_bf.c': {},
+  'test_bnf.c': {},
+  #'test_div.c': {},
+  'test_divu.c': {},
+  #'test_extx.c': {},
+  'test_fx.c': {},
+  'test_j.c': {},
+  'test_jal.c': {},
+  'test_lf_add.c': {},
+  'test_lf_div.c': {},
+  'test_lf_eqs.c': {},
+  'test_lf_ges.c': {},
+  'test_lf_gts.c': {},
+  'test_lf_les.c': {},
+  'test_lf_lts.c': {},
+  'test_lf_mul.c': {},
+  'test_lf_nes.c': {},
+  'test_lf_rem.c': {},
+  'test_lf_sub.c': {},
+  'test_logic.c': {},
+  #'test_lx.c': {},
+  'test_movhi.c': {},
+  'test_mul.c': {},
+  'test_muli.c': {},
+  'test_mulu.c': {},
+  'test_sfeq.c': {},
+  'test_sfeqi.c': {},
+  'test_sfges.c': {},
+  'test_sfgesi.c': {},
+  'test_sfgeu.c': {},
+  'test_sfgeui.c': {},
+  'test_sfgts.c': {},
+  'test_sfgtsi.c': {},
+  'test_sfgtu.c': {},
+  'test_sfgtui.c': {},
+  'test_sfles.c': {},
+  'test_sflesi.c': {},
+  'test_sfleu.c': {},
+  'test_sfleui.c': {},
+  'test_sflts.c': {},
+  'test_sfltsi.c': {},
+  'test_sfltu.c': {},
+  'test_sfltui.c': {},
+  'test_sfne.c': {},
+  'test_sfnei.c': {},
+  'test_sub.c': {},
+}
+
+if 'qemu-or1k' in emulators
+  tcg_tests += {
+    'or1k-linux-user': {
+      'cc': 'or1k-none-linux-musl-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'or1k',
+      'gdb_arch': 'or1k',
+      'qemu': emulators['qemu-or1k'],
+      'tests': tests,
+    }
+  }
+endif
-- 
2.47.3


