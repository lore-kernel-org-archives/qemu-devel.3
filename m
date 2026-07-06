Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50EF6C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:37:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgru5-0003wU-QI; Mon, 06 Jul 2026 18:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtx-0003Mi-6v
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrtv-0005f0-9l
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:34:56 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3bd1629183
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bx+xxxS4jhN
 rtbWsaxuBIybQ6t1piLIaOjfaPXw3PCg=; b=LnLxoG6ftRqBUr2vKIfNQCBjI9N
 v+qv6jtczR1VRN2vvMXANoxaTiS+6u4zk1nc/Vwf2JRTPrSiyjywC8w0exasOmDz
 LFOadn9m9JtJ8JEf6EDVs30UOmictWkj3q8v1/0Ywxrx4simU6d9tp5+mueVE4/I
 YOVLXDvNZBQDeNIyFjympk4hUaEqozIQYTI55GOrkG8AXZjMZufKAN3Wb2+L6Or4
 ODqZHLrYx2yoeWcfRzC9I4ksSNAFIdTXBiyCXAFaFBFDv8sFU69cO+Zh0OuNtBlY
 XwNrxnp+WB5NmiXjUKBqC6Abul75ebTdh3jK1M87Y63ou9O8z/kxoQ3GQpQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8fdw1hfm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:34:43 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8482b95574dso277190b3a.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377283; x=1783982083; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bx+xxxS4jhNrtbWsaxuBIybQ6t1piLIaOjfaPXw3PCg=;
 b=EWmN9mtp6Qm7Ov2VGlLw3CuAa6GfajyimdUSwkncRWsICCWg8A9asehgrbQVHAXzuV
 jiSSXWOleoekIIhwLtfJEOYOuY/Ugbmg/JjiYdp+L9nBUVPj5KqFNIVhUrcs3ISEknFq
 8R7JubqumunS3emr32/3V7n2aVJN68PPV+rVQsddmRtVe6g75n3o10mU23rmmZO5S0wV
 Olowi9m6Yv8W4BzDABkM8mikINWtbHB1Z6VmMCwnZTbopfcWxBMFKlulUAVp63xn3Dda
 L5a+ZihwN/hoWDtVQI56EF4cNRyCfuYySL9Y8U2kJBgp3OHUeM0I4ks7FBuSU7lTPJIj
 Vy2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377283; x=1783982083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bx+xxxS4jhNrtbWsaxuBIybQ6t1piLIaOjfaPXw3PCg=;
 b=Hu3x67Ud4EIemDJm8AqTz7J2DrBeQqTPhZH0naS6m6RutcL/6KyvyJFaY1SeNfVq8j
 yXCU1BypkrPPNRLyNuZMNU9azhETeTntl/tlP87I/XBLDQsAw9aqUM/VW+BVYsIL1Sbj
 aNYiUkd0A4lSJO9PO6bPwVevxrLJrJp5k1JyP7L9G3PZWC7tobdfT3WD2btyA9CB8T8I
 wbW1SZ6I8+i9uGVTC5Bh268Y8TojhoKaZNGTSy8Ewuh9FR1Wp11IOR4pYA1g50DWW7dl
 CCDn55jQSu3jQfMi6/LESTbp2xtQVgRif+LXUrfjhvYOh8WvQteKpInDQwfjhvEqbQ5Z
 ORsQ==
X-Gm-Message-State: AOJu0YwiswOJ5xzLUGUREsE1ubVwtBVltyDU9V0cK3EhIWawRSD2moPt
 9Ahsv+MT3BsgpaALmbkGMP46W9sBS2hNpzVmvWQ6Qe2tq/wQFOytflPDlWFx1YGgx7aT0GHJKCI
 bdu7yqBmYhdZokSSV2bN6ww3P9PJelEddYGluA/CAqq4dI/7XV/tnH3tGJ6/H431FuQ==
X-Gm-Gg: AfdE7cm+3FqEO+6//pE8aD2pT94xlpG7mrYEywADkeQp/Bjb3u+TOvVz7/U5/A6Kvmm
 q1JIOJ+z2obcKKufMWp6D1dmiYhbApkPk7UN2f2RQrv9K7VgFvgQftndNQOcCMfDK2B8LcEz05d
 rMczvR+T1rESFFzNLyG7VFtdakK6cevOd3Tw6tkYQIY8WwON1orqEKWHZ09iUjJ/HhQ/p8X5AEB
 BqZgDgDV3VPw0UAtP0lpY9T1cA0NC2ArTrzybdKcih7Hj/uI3xTHPuS6L/8ka7W57/91y3IJBNO
 SaAFXVw7PHoBxq1ZpGwyMa+tsimpqePRJzaQ0p9q6ggBPvyJVwmN30uHocrF5i6HMrJOai0vrQD
 0FbRzy/hkOj/zxffAkHgmrlfJfXoKSdlt5Ca1wAOlAbDShdqLh8jhqzUN1eRSz0apmuvv8zYfQ4
 P8xlmICA==
X-Received: by 2002:a05:6a20:d490:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c08ee6d060mr2916779637.37.1783377283220; 
 Mon, 06 Jul 2026 15:34:43 -0700 (PDT)
X-Received: by 2002:a05:6a20:d490:b0:3bf:5539:f8f with SMTP id
 adf61e73a8af0-3c08ee6d060mr2916745637.37.1783377282811; 
 Mon, 06 Jul 2026 15:34:42 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174ac0557sm977244eec.26.2026.07.06.15.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:34:42 -0700 (PDT)
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
Subject: [PATCH v3 33/91] tests/tcg/meson.build: add generic plugin tests
Date: Mon,  6 Jul 2026 15:32:45 -0700
Message-ID: <20260706223343.988769-34-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX0KvgUmg8yOwf
 EK80TBX2eBXsivUA82SIHUYflSZVklCDS0H5fPxrNNe3l/VpKphuEptlEv+phvDDhuyLGoveKUU
 0AUs26i73yf+4ufJKYXcpu6muZwjvy8=
X-Proofpoint-ORIG-GUID: Ux6EevPl_HgpqdeVufpZIGmRONxzQM-f
X-Authority-Analysis: v=2.4 cv=EtziaycA c=1 sm=1 tr=0 ts=6a4c2d83 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=xtj1cMhkIxZ3aAi8tasA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyNyBTYWx0ZWRfX+LlNGIQAlcU8
 Siie0aEz0SyZJU3ZAhGvVjMpEi8sVOFymShtjNFst3osKnUinPHPTK/aP5K7l8iDuW3kKfJnPlN
 ETXtRxZzmVYcmZG3phf+Hd0uhNviyyJ35ruNBLW7NRKqexq+LaOkfWy5XPtDYY/oIhdE4hxrpcl
 q6VHOzRtLN+GTi4GiaDKWx3C3QK4oa5n8t+g3vPXdZcHf0wx4YXcQ/RAqhQiDM/85ymj8YYg1uo
 EjdE4KmXgVgVJfoOuj1sCrEB7MoiVUmzWco6PhDf6OI8SywdLx9nZv0852v2cMbP7q54s//0dkV
 md85zXKTOQSCzK4dJs3HukfmWYBjP+sye4RURCAy6t0uF8HH3J0IfIJx4wFleLw6JtsuxbxDkYE
 JJbWb7eoWQ4zcbbtibgxp/Gy7URMOdyBfCHg7dsk0GrTsyn50mOVv1JT3OL/bm81LYkRx9LZsIO
 D5VCJGZeB1oSeaUkvPQ==
X-Proofpoint-GUID: Ux6EevPl_HgpqdeVufpZIGmRONxzQM-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060227
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

We add one test for each plugin by picking a different user and system
multiarch test.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 45 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0dd0efb92dc..ea81426f905 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -88,6 +88,51 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests
+# add a single test for each plugin in user/system multiarch set
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+  normal_tests = []
+
+  # filter tests that are not plugin or gdb tests
+  foreach t: tests
+    foreach src, setup: t
+      if 'plugin_test' in setup or 'gdb_test' in setup
+        continue
+      endif
+      normal_tests += {src: setup}
+    endforeach
+  endforeach
+
+  idx = 0
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    # pick one different test for each plugin
+    foreach src, setup: normal_tests[idx % normal_tests.length()]
+      # copy existing setup and remove existing cflags
+      new_setup = {}
+      foreach key, val: setup
+        if key == 'cflags'
+          continue
+        endif
+        new_setup += {key: val}
+      endforeach
+      new_setup += {'plugin_test': {'plugin': plugin_name}}
+      plugin_tests += {src: new_setup}
+    endforeach
+
+    idx += 1
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 image_targets = {}
 exe_targets = []
 # Finally, we can create all test executables and test targets
-- 
2.47.3


