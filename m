Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941A5C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4h3-00025J-OW; Fri, 10 Jul 2026 02:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4h1-00022q-7e
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gz-00064j-GT
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:34 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3pEgF3856035
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WTILCmuvAUE
 jf0Az0FPgCxBMomx+ax58oo5XYj7nbw4=; b=A64qWDagnVlcMDwDVpned3fI+Qx
 fiPMJrr6LrfeDpKlTLRzfqM6BYZsUHQ/PBJ7fQiJ7pvCqe/gAg+vMWJ3CEAls/Vc
 Td2168khbzWNXUGFuKTl3U1EgW5DXHT8LdoSx+CfCM9Bk9cQmJBA7LE8lL67KZW0
 JyT0zu1hK3gmZ/dpkakwJpZI/9s9ARbyXObfT9QaLGdW7PuBVL4SYjyTu4bYID/v
 /bnICk1P8aSVwglrL0uic3WS1aDbcnljcjkdTPML1ZUhuH6a1/2HcFD2BWhj19il
 hKMuPZSP7ZrlWSOxmfhaa2IWGoIGsluNx1kityTXXWyzwVXalrEcZIUj3/g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fas6n0hy9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:26:22 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c88aab7c1fcso1043250a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664781; x=1784269581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WTILCmuvAUEjf0Az0FPgCxBMomx+ax58oo5XYj7nbw4=;
 b=HcA24kz96Mq41sxLM/GX5xQNskK/mxi7a9YCUE3YYR1wE3cRxjXONSuUmiyXkxqZMb
 sihxPhQI1O1bH6sgqApzoIYFcjFNdVJXcejUd3buvBrG83k/a+EWIBxrlScpe0ioLUmE
 Ca7sTIHWgnDrrQlvRC+aglUDV3qgoS53InJoNTn6BIz9mQlnUpmTYw6pAdlx3AvMZh2w
 SVnwLWTEiC5p5rmxs59040yu8tv6FYjCPaQHTTlxCc59uR1UtrEyQAPq2H1iB725bkvF
 n4CYWwwSQQOQ8SYTLyR7qJLMiQRsCNvinDJRHDVR5lsJGgVyuaTv1zdgZOWbo58avnEP
 uO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664781; x=1784269581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WTILCmuvAUEjf0Az0FPgCxBMomx+ax58oo5XYj7nbw4=;
 b=OK8kkPIPTaoT/GCLijMYCMDM/XXtW/W8E+df5DBr8jMXLSLr5ZcciFRa0YWY1zfTND
 qQHblvlzZn7GqJ1VvkTTN+zXekPySq3FFSRm8bjAOA2/bDALdNiRALKv66Q+eSXMF76p
 U0dIKY+AshSEhqxSZScaBw6WqvZn+06gyUbGUV33Q6kgZiRQMSbSY3kR4n1rfIizjWzu
 GO0dzTM3/Vqr8cYNH0wmdvBb3OjG+YZ/OOSxvGQ4WP2nVqp3tHpHViBROOT8vyQZ8WIB
 23ZGwnM2ULiDIbH8cVR5hEk0ulP0iNZ3pXNtuv3kS2iMzqLfEaUfJoapATzPRz0+jGYj
 Rkzg==
X-Gm-Message-State: AOJu0YwdwVi+WJo6yZcQWQjP1rpCvkPQdNQjcIvwRiDBzoVupAlplZ7h
 2dzf7zm2cRHiH4IJoauWrKNYqreEf3C9Ux4DKHgRNIoPL0XAdg/cEoHHoC0jyk5r6Xue0eTvvkX
 v1bwW2qXHUn6WjPEjr1G/3KHav9uSpHIJcgC0xbaWJusc+tvzeaRIST6ljI3n+c2qyA==
X-Gm-Gg: AfdE7cm3W+P/ZvWpxDEbUz1lingVw8vxKixKI8wv9j6SjcSwMpmsXoe8rvZoYXPhgRV
 0hRzhMlo4LogVIzYQtIfuYHsZftwPnl3k7DPrFm0kN+sHZrRAcTeGvnIyt2EpWIzlKo347RR0pA
 fAjykkLwYmq05oSeDy02whRzhZhxEQ2xggMoFB5CvcsPtiuyQBBm70rF2CPqiDPTWxtDOVwK0Nw
 Ls2zzqEj2zim8lAGKOfTRS0C/t7vV/CrsPwxDPeJ7eNGAJL+5wjRxCiInitdkC/7LPz4q1Pa5Bg
 cbCLh3j8B7v8e9xoYGAGetinV7VWN+YzqNs+b1tfRMLub+cWcBhKIniCT204qgwYScM6XdBYYZ5
 ngDdYx5iM5R9fhD3j2GseIygj44m6hBghEsDMY9YEFGViiwekji++I/DXNfXvJZoga6kJETr4tQ
 3xt90yKA==
X-Received: by 2002:a05:6a20:da1b:b0:3bf:9795:ac0a with SMTP id
 adf61e73a8af0-3c0bce18a74mr12477107637.4.1783664781501; 
 Thu, 09 Jul 2026 23:26:21 -0700 (PDT)
X-Received: by 2002:a05:6a20:da1b:b0:3bf:9795:ac0a with SMTP id
 adf61e73a8af0-3c0bce18a74mr12477071637.4.1783664781024; 
 Thu, 09 Jul 2026 23:26:21 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.26.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:26:20 -0700 (PDT)
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
Subject: [PATCH v4 75/97] tests/tcg/ppc64le: user tests
Date: Thu,  9 Jul 2026 23:19:53 -0700
Message-ID: <20260710062016.1818125-76-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX+PA9M73QvsRr
 CACRFHFBZVyds5Ts0rkiFcAictBm43dNsgoca7t50XIi24DjW4hZAUdK5NAZZv7DyyUzPeokhnH
 +xqWRykmYslmi24qtOLUY6m722MCUi0=
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a50908e cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=29g3_fvkp8nbTr7Nl2YA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: oomJ8-Rrhm3VpyhAssEqV0b6Qh7SKGG3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXz6kMIjRIxUEg
 1ZcNT8KauDUqmM9lQ6jHxjuadc305XCx7JXH6jkPa3Gz62+XcknLiM75sspdtKFkahAdRoEuze2
 Mz2W1CnYig5tfqUW/9ak7nV/Wwa5hi2Zq025Y84QHFD/unVYt1rXzpQBVp17E0Fu8c0AJoeWr/x
 3W5tLx5aHI5Tso/xQ4qrhLQHYw+41YHzjigNkJzQz3gAVmUCeL7EEe6WZe3Xzl1Bw44yme8GQbx
 jCHgKLR8uAYb0nuv0sswk5NuICKj38vbZ2nh4gIfqNpYHQ4Tl2dqgd3P4LqCJDiWPVD7ZgTVbAH
 aQGqt4re2/gEi0Ybs+gogeI5PFKKn1DnstgHmYEEbHYQqtsavoJrQTYO3UgfKTKRbf5KySN8Ibj
 iMr6tTiHXjh3avVrMpjd8oS+WqPLkqga8F/HhsYPJla3JVDdo6i6FuMJ9/HhYDnp4z3R6cdrVHg
 tmAZ8ZiE97Q4lNHiw6Q==
X-Proofpoint-GUID: oomJ8-Rrhm3VpyhAssEqV0b6Qh7SKGG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
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
 tests/tcg/meson.build         |  1 +
 tests/tcg/ppc64le/meson.build | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/ppc64le/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 1926a7e38fe..ad8b40661e8 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -147,6 +147,7 @@ subdir('mips64')
 subdir('mips64el')
 subdir('or1k')
 subdir('ppc64')
+subdir('ppc64le')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/ppc64le/meson.build b/tests/tcg/ppc64le/meson.build
new file mode 100644
index 00000000000..720aa167f23
--- /dev/null
+++ b/tests/tcg/ppc64le/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-ppc64le' in emulators
+  tcg_tests += {
+    'ppc64le-linux-user': {
+      'cc': 'powerpc64le-linux-gnu-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'ppc64le',
+      'gdb_arch': 'ppc64le',
+      'qemu': emulators['qemu-ppc64le'],
+      'tests': tcg_tests_ppc64,
+    }
+  }
+endif
-- 
2.47.3


