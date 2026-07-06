Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60990C44500
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:39:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxT-0000Q0-Pi; Mon, 06 Jul 2026 18:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxS-0000JV-N4
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxR-0006tX-3e
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:34 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KELVa1626824
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=teVXxLxcmAL
 4P7HGFuLvC/43cg9CWF4CMvfG7Lr7FEk=; b=V5CKinqE7vmad576aMeWPkPcpAJ
 iFR+AeHKm1WFtMZjwptFRf42ZvaZnFBnyrkcI/yTORPva7ZfNAAy3U8RMj2tGNPz
 dx1bwiXyQQh1jEw9RcmDSsqxCqTMDhGjM9i6BndIfIvyRgImGA8crQj/ck9bZcCn
 7Z5ulNKPp0BJYIKrrx/qupjgNNOo6RdSpoxg1OUGhS6IRQHDUBkMukWtaFXUFRv+
 Wh3/0nxXyZyJUYuZUjClRPKoTjrPUfMxiD38cM5p+W/YLXWflFBS933YDV4rfago
 bjSi41pduWR+1KN+sGNdBdI1dZpSHZAm20RXzaG8hstwJOSbG0Sx55r5HHw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bnmw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:32 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so4005279a12.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377511; x=1783982311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=teVXxLxcmAL4P7HGFuLvC/43cg9CWF4CMvfG7Lr7FEk=;
 b=PRHO+Nfw1pAunSNQOboAuj/iIf7btR0GNndm7ClHYsX/gHv1ZPxG5OohidlyK4Ka8P
 4mMyQB9FTaPaibErWrg9pUlo/Zs3V1VpxAwaIbJHr56b+j343+dDGGVB4CXJEuceu6DX
 csK7Ph6bfIfkkrqC3JXWnJ32arY4cmWEiKF9v5DliYtjivlz5M61DaXVDTzG4c4ZD85Z
 GtyYs6dX/n6r0dTbkjIfHlUcxMqeLwPxdtiVN6KDxOwptEHAgHTPHRJtL577nOijfZtC
 vy36yh/diSBzpKD5SM/QyzcWN0d7nH5PHkVASuy7mNvzc9WYnUt/ZQZpc+C/DQn50eRg
 Euzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377511; x=1783982311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=teVXxLxcmAL4P7HGFuLvC/43cg9CWF4CMvfG7Lr7FEk=;
 b=LqBxbYESyfypxyu2iFp3uOMoIU1wXYRT4WemYRQNMSKvkcCUlShlzm8XpdcuBSOONy
 HBm6PpADZY1yPzS1MhsX+f7ArOUI2M4umCRskoQC2MHRuG7HPsTezpuG750tRcb1xbA/
 63UuIExQE31hvXK/tL5J33WmLQJ+yS5WaZUMIem6nsgVyoV8lpUEaehPbG0sopfh21TN
 vw1Sr1Fc1qB4NDR+f0n6izBlk+XZEq8R0S/1fZILDStSszsurW0etqJI43OSg90XRE1E
 yYLHLH6rBRiyMFCaOKdxvRDAZ5rRK5Zh2gZ9xHBNzx6IPYMnFsPH5Y5aezh1akzSrk+z
 QZ8w==
X-Gm-Message-State: AOJu0YyAuyx5nb8EnsCvp5AneA468uw7mMk1zVNsUJ5uP8seJRPEgV11
 LBAt5sQEvotSZqqmCtZz5lsACq2BsCgzobDMGZSB8A2kEyp12KZ72710QRomWQ3nDpTGgE/yG+R
 I6N8Yk4WScSTq3cPVROsONk8MIYOTqsRN+X5Y0FXnpgnMJ+vKAfN6kZIMF0UJwLax9w==
X-Gm-Gg: AfdE7cn8Z3r+eba8WYbU43JTNaG1rAULB5qRo2f02vzRv5rPiPw4/vWgU6W00sEwfKC
 DGLWVKo1R/MKrdKYxdVrB2lnl+F4pQEzPwdTM3ko22bcs1XJ24ROioKpbMMERxYuNAH28oA2XcL
 cosdtewiadMCHPKZiSGPw1VKp5i4+HrhCOSCcg8KsG6Wn48ll+YuTZAQz00QbKqBivfQW62DX8j
 njd0A929RI8RfFYGx2t16cLXQRcP9MGMxLGTww8SvBZaRaYKtG5IzyFrGUtTWGIA9yBhAYaq2sS
 S6qrjEhhOBNkYRcetSw6EioNCuS/jXBpccP3PQMkkbeQOTJ6hPfYlGurBToMGIsySFEIH1Aydt5
 OYCMsHWuwKDQxVziEjnsurJEpH+j3h7aqtsM7big/OuQ/aVUUhA9QIleRFguCYbFVyHeA1BTHyC
 9l8DJpkg==
X-Received: by 2002:a05:6a21:6b12:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3c08eddf527mr3396643637.21.1783377511070; 
 Mon, 06 Jul 2026 15:38:31 -0700 (PDT)
X-Received: by 2002:a05:6a21:6b12:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3c08eddf527mr3396613637.21.1783377510639; 
 Mon, 06 Jul 2026 15:38:30 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:30 -0700 (PDT)
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
Subject: [PATCH v3 54/91] tests/tcg/m68k: user tests
Date: Mon,  6 Jul 2026 15:33:06 -0700
Message-ID: <20260706223343.988769-55-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NzHuAv2zxFSDDZwJ9nL7gjg9jVhO7oz3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXzbxKSqC7+Pgu
 kl820Gfk2AhiGDVUtuCZFFffyNQb9lhQBvR07mHNzpPi6i7u/hMnNpFRYFEqAFRKJBTAYxAsMhv
 bfvTkd8cX3exDAK7V859Unv9X5j8DuI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX69x2RRn30T/N
 vYAA88uVPszDWWGyu7DyjyDxKpuhX0CCTh+ni4KohL3gRP4I+CuZYMAznhEJ6HPYNF4sVOTQ+qN
 o64O/Tk0dRF1ojVCf732oF4KcMYefoV7LagUIrfU97iOk1AyCt6x27sY+nIEA+3u1/5j19xkd6L
 s5cUXJCjTDxHergeHsZqE3TaZ4yXl53t/nXuMpigbyvGJdjuSJpsmBnt9/5dmfpsjH/Qt5fnbJz
 ylL7UOD/QEarwDpEOAHk/Vl3KJbZigFQJ0CQDPUBSP/VixerdhTOaqEDMqyPbegoz2/sHVFah2j
 PE0G1jJR8lgq03v2slpJ2RBoqwWdipzzZigO0KxJDkyMZ8oNj40YyeVEuryBV927bVun6ohBWpx
 sPg7PnwsyeNss4jmShfqi7CAEA5FfLKjnz+sq63dBJbjOLAvTpmWANtH4LSdxQQ2B7duDIpx+Dk
 obLb7xSQ8Yplp8Ty6PA==
X-Proofpoint-GUID: NzHuAv2zxFSDDZwJ9nL7gjg9jVhO7oz3
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2e68 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=nWFgFrBpDVO3lh5CPioA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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
 tests/tcg/m68k/meson.build | 23 +++++++++++++++++++++++
 tests/tcg/meson.build      |  1 +
 2 files changed, 24 insertions(+)
 create mode 100644 tests/tcg/m68k/meson.build

diff --git a/tests/tcg/m68k/meson.build b/tests/tcg/m68k/meson.build
new file mode 100644
index 00000000000..8c6cfde7f10
--- /dev/null
+++ b/tests/tcg/m68k/meson.build
@@ -0,0 +1,23 @@
+tests = []
+
+tests += tcg_tests['multiarch-linux-user']['tests']
+
+tests += {
+  'denormal.c': {},
+  'trap.c': {},
+}
+
+if 'qemu-m68k' in emulators
+  tcg_tests += {
+    'm68k-linux-user': {
+      'cc': 'm68k-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'm68k',
+      'gdb_arch': 'm68k',
+      'qemu': emulators['qemu-m68k'],
+      'tests': tests,
+    }
+  }
+endif
diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 28a5b50eea4..a6bc12922cc 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -142,6 +142,7 @@ subdir('hexagon')
 subdir('hppa')
 subdir('i386')
 subdir('loongarch64')
+subdir('m68k')
 
 image_targets = {}
 exe_targets = []
-- 
2.47.3


