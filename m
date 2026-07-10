Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70817C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4gd-0001Fa-En; Fri, 10 Jul 2026 02:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gb-0001CI-Iq
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4gZ-00060Z-Sr
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:26:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nKNB3753018
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=tj05vcmUGeR
 yBseG0/uX2aBZcXGpWGBbMzsbvZDOMvk=; b=EYonxXqodR+yUSE13TFEIhMPRJf
 KgcfLiVICV/Y7AyWIk89I8l8jbomHTyOXFw8OC7PB3qeh950ByERW3ryHSCTFxLH
 ixfykheCFRWqONSXopRJg9HDM7C2XaWemGGSQNbzsLX98KlwZu8uOY07MgYS5/mz
 1GWPuMAwYLwbxMQpP3q2yidDo/Dk1vbFkG/I0trLmp1Ibf/44fF08s3a9DUc1Sye
 Mu/mfCnJYQE7fiX25H48ej7uH+mepCfD83arXaWsHM9fxCj8EGqbzi5uIHITD3lV
 G+zipIE9GzXz4FG4GZgbpkGeoI6NmNJ9U6ar9+NFTIIFHXLi+gq7Ka5RcDg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fadvjbaav-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c88e0f04e51so543708a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664756; x=1784269556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tj05vcmUGeRyBseG0/uX2aBZcXGpWGBbMzsbvZDOMvk=;
 b=OV8yKfd6bo8sZ/e5Et1IIEjdx1A6Q+N8Uy1KPmpNtH4IG0Azi6bbRblDT9ImogFKCD
 mgbuwFAIC5of8mNNwOt49TT+M5Kqq9auREvtAd56JzNIW4yD391jN84VgXrm6pQgp6qF
 w5fD3NpBcT90JO+UZJ9bbPPmn+d9DS1zsjReQ7v5PycXaZh/14c1977h/RXLJL63116r
 NvX+clizRYnT+/lCVvh8hxe0YLM69gpMRdm8BD/tUhHejarevs+7b3MIyL+i2IPOpGMW
 D3It844a/Lwt9sog1ZpehHDTm3rRlH3XgIB/eet3BCNfYwT/RUgStPk4bKhiPRhRdNst
 sIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664756; x=1784269556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tj05vcmUGeRyBseG0/uX2aBZcXGpWGBbMzsbvZDOMvk=;
 b=jqSC8w0xxZAwiVltlQ4yQeOQuOC0OgfYWQleLUgsOt70SBq9druCEqd8SujkI2IZ2X
 wEdE6uO+U6EhfxTtYJu+H7MqFHUodAQSaK3EEw8Wgj0UkYGS5YRTfnmD0eGWVTFHeYNf
 zVK5Ks8GUwrjhXwZyNAUYitqg/6vsST7TPxw763W6HLfsopWaQp631DZELpekWLGDnBH
 Hf3YCJCag+5ufpJYxkRODCWKNW1/v3R+9ETkO35VkPy59M+H/2rL3ZxaD1gPnCoHFZMV
 eNZVkBHchMJrr/4Zkx5f2KGRDQA0v/fqzctdV9eGwxse6j0ODMQTYEOiBL6nQ2jgBPc4
 uBfg==
X-Gm-Message-State: AOJu0YxRx68A74pCMHW86BoMkQWH5lBW8FHyUBCHxjV+D5fxdYygzBoO
 e/erFGiKb3FtVmrT1bG3/WgmKOEP25S70wajbk910vEh0T4j43iQYeq/ins0PcFCycfXDhr8ZcL
 uVu6jdX5gR8YoLxrv/fqkTIQC8Megv1tszgNDTbzKegxaNY8nfacrxBeTu404+VbRxQ==
X-Gm-Gg: AfdE7cnMdao/EhqBACGCvePhMz+zZ5PMlfXyIpZ59+P8tfOiEO80144QXPv2v3Ej+nT
 bdznA80p64Z4GvxDLzbJh8dbYBKMjSjUg3tN360/8b114s1jPRMdep5xk0aBiitBrmaQH9jA1Bv
 CSQT+ArbNAWxG6zrkD5+uqr2/nTNSYY5/JVkCRSdrR+cSha/Q+q8ImriIr9Rt2f0aCg4l+IWzPQ
 aOKUcLHRmSIh3B3e4fiw/8ODtFiA1CzADb2Lp9De5+MukumwFVSb3FaQPE8AuMbXlExHzQtKibt
 /30kvdCaWJpxlyjiHF4iF5CY2EyKp/BUo6jjodWh6OS3vRyGoikTVLaX38bPS5hv+/D4zomfjd+
 jebtumxtBS0PWiKcfoIHQeJmUVOYyCWZ6C0hzHkArQ1MQ8KTWzHDxdHrSYpS/nIUvHROjPfwOph
 +3f/6QtQ==
X-Received: by 2002:a05:6a20:258d:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c0bcfc669cmr13034324637.24.1783664755969; 
 Thu, 09 Jul 2026 23:25:55 -0700 (PDT)
X-Received: by 2002:a05:6a20:258d:b0:3c0:b55a:80ff with SMTP id
 adf61e73a8af0-3c0bcfc669cmr13034288637.24.1783664755493; 
 Thu, 09 Jul 2026 23:25:55 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:55 -0700 (PDT)
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
Subject: [PATCH v4 64/97] tests/tcg/mips64el: user tests
Date: Thu,  9 Jul 2026 23:19:42 -0700
Message-ID: <20260710062016.1818125-65-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfXwr/HfjsVA5hR
 cWjEPhbqXK0Jj/aY4p0+TUDNdua0B2YQW0WiOtt+SKXpBuXQ0BZPR5TqC0ddPQFtfnqoMTVPec+
 T6OqcXXnFDqxaIqYO4uao80jtu002+WDJKrg8CAZCVRIQVc3AZ8a++CYNkNPrYYBvU4H5YWjxJS
 ayJe4mmZGTuxU0aYt9+nxousSScgzb3n4ji8++U4LQMJu61ZhtadCHy+/DbjZEldlUPYtrKQ60m
 nV5UpA9w2i/6rqLZyOeG3wIjX5VumyhTDBu8v1YRY2o9ptPag0XBrsOuSWKpR/ATl6hYxsrM7mb
 Ro8Z3/0IuMD8x3foKFaiCqLncBo/9FEY+/Do/ehsVDivox5UbSshJHqYKp+OvWHTZ8VbeUiEyCR
 xl7bHM9yJkNM9V06VdFrJLvJ9jJ9WWI9FVgXseADnIQsxi21v8Phppz+B3e6+dj0jEd6bOK4PgK
 yE+qy6RQ3W1gr1lAujA==
X-Authority-Analysis: v=2.4 cv=WpIb99fv c=1 sm=1 tr=0 ts=6a509074 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=ur67-VmdWgoDRuCcqcEA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: weiHwirWk4KbjoXYXaj4-onExobOREJV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX5v3EqH9umlGj
 FgaDeelqxi8rH4k7YsLHeDZJdCxwYjJSLIIe0VjzdJrdWWKtY0+P9O06jfCStdLqbd5wkCZ/bL7
 3UrCbEP2+b4NfqrL/Hk3+ysigm5RD98=
X-Proofpoint-ORIG-GUID: weiHwirWk4KbjoXYXaj4-onExobOREJV
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
 tests/tcg/meson.build          |  1 +
 tests/tcg/mips64el/meson.build | 14 ++++++++++++++
 2 files changed, 15 insertions(+)
 create mode 100644 tests/tcg/mips64el/meson.build

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index c3dbd8871e9..a1e952a9d22 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -144,6 +144,7 @@ subdir('loongarch64')
 subdir('m68k')
 subdir('mips')
 subdir('mips64')
+subdir('mips64el')
 
 image_targets = {}
 exe_targets = []
diff --git a/tests/tcg/mips64el/meson.build b/tests/tcg/mips64el/meson.build
new file mode 100644
index 00000000000..f6c0fae7981
--- /dev/null
+++ b/tests/tcg/mips64el/meson.build
@@ -0,0 +1,14 @@
+if 'qemu-mips64el' in emulators
+  tcg_tests += {
+    'mips64el-linux-user': {
+      'cc': 'mips64el-linux-gnuabi64-gcc',
+      'cc_dockerfile': 'debian-all-test-cross',
+      'cc_docker_host_arch': ['aarch64', 'x86_64'],
+      'cc_feat_cflags': cc_feat_cflags,
+      'folder': 'mips64el',
+      'gdb_arch': 'mips64el',
+      'qemu': emulators['qemu-mips64el'],
+      'tests': tcg_tests_mips64,
+    }
+  }
+endif
-- 
2.47.3


