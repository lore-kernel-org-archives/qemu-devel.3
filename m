Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44104C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 23:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdG9i-0004Ef-Ko; Fri, 26 Jun 2026 19:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9f-00041U-W1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wdG9d-00049G-Qs
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 19:40:15 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QMxFYw2746526
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4ndpoSG5Nga
 9sr7YmOj+/6sTHm2sWyCZeTKhqLNmxL0=; b=ilxXrsb9brfHldgb/KuxPRQBrZP
 SzpP0u8x3icvyCLvt6MOWTEfxBFzuPFJ+t6wfrfStNuLPhVwONOR/8TtuOYeQbDa
 avv/ZTfYHu1nxWQVs4oK8UR6UX1QBLg84NtaIjVAna/oK+srru0vVaqfyC2p/G/W
 kRN8UkQA1yEKVGTV7PgCQ7/50ysr0VSmk30M0ndPSjeXXAzYU1DXCqLjneumVJgD
 /EMVE8+8tVTILfER0nsYDue5pczf/317cLjD63XSvan3TxWVHSBomUS254/o/Ak3
 bFTUuMsacanLWn2bjpq42gUxbGp3NCDW1ZgEVzMvgQa+CjkAFZ8CMUyrptg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1yqv0myg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 23:40:02 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c0d568830so6488431eec.1
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 16:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782517202; x=1783122002; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4ndpoSG5Nga9sr7YmOj+/6sTHm2sWyCZeTKhqLNmxL0=;
 b=IuHiY0vTzpZGQmR2pi7CVL/n6PmzbvJewzur1R/72dCeWrOOBfhWxF36+MUd5O8+kq
 /IwggeM+Z+2657Y1Xl/POpeUxox9BrBHlSTO5aThzU4bdn/CCf9q1HAJTZBOQwfMdcPI
 vdMzQZ6D5YolDyWZfPeoVcQuV+sgDTNBAJsISKfej+WvEtIv7wuyQ/B3ICllyD7syAZn
 xQ1/UU5uy0saKtya5zLHb7DYHR9Gaw8FL4HcfXXefYqvRirCLpGr4gQ9jirL7Ovk2RXJ
 eEyyHKX6RwonO1tYJrXmonO2Dy7Ev2hlaF0kqjlj6g85ZChYH/sSamY71MD0LcayjlDY
 O+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782517202; x=1783122002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4ndpoSG5Nga9sr7YmOj+/6sTHm2sWyCZeTKhqLNmxL0=;
 b=HvPW9zzD3Q3Dfnkjpq0NB9V1YwRI4DI3EYRtA3kJ+b1aC/iEsKFiLF3dsoZDKNlgY1
 CrBFul5iLAlkSYrlhefKCYBt8w6MBtxw8sIshXimPdarzUeJPPMtb7/HQ+Uyxt+/EAUw
 6d3fhqb4bCHsl5mrYDhv77EmXTKJcPoakZtSjoMi2EL05FVPvRYrZ8yPYHbb4o0O5jdu
 Yea5gB2BQiny2DWloxNT3mNrP8TWgEk/gm74+QTXJ7i2iSA7HJsIFMixNFHsA5zcITth
 y0aZf7YqOBzz3UeXRo6VBfY8647eb0tD93Rf0eDifyb51sk6ZyRsNxhYv4/J3zxysatk
 b3lg==
X-Gm-Message-State: AOJu0YwvocA9Dc7wPUXl8ey1pHLdYj9gyhv9HsEZydr2y0fuJFUYVg3v
 bgOMpTvxj27+JFO4zqnHM/vIT36qEIx5BmQSuIewji84kWd/XexA4RS0H1CxFshT9uM7H48v5NT
 RdQnvWIqimhUDaEZQ1yLdyT1CZe7GVABIl53oZmTdi5q+C93wxMpuCo9Kej0/XmvHDw==
X-Gm-Gg: AfdE7cnf2QNQiwWgIITCHKc2dNuQhpxTpD1J2BzF1M51gm2fr04/goh913Q2IJUk7zX
 ergfXrpghmhi57xhHtu7SUCYy7yfL/MjDwgNEhWjtOj7GOdUpQnbr9mpaLVOqRK4V4QIJ0IzOck
 2gyuSIDADSbEpUnlta9J3ypcXwiW//TWOLroQOuPgNJVO/MbNAC8dr0JW/xPVnO5eWYGIRAGlkB
 /4Cf7meyEXFB9NWl3+hi7+h+JRczebvePXHWjO0zUPOMBv16AQLQpBS4EgV2cIKYMwWXuAwS3b5
 jca3WvABkrNeaPYkumyU/9HlYRrDjJ9TSiU4JBsCLb7hqeCch3yAN15yi8/OjN3rYfBesS6jStA
 f0pwseHxpNEktzqAukdFoKJofl7s+A46IFspQTtmSpo3YHAvIy6QsC+t7jfmL8e0TYFthm6R9eK
 F0FCFc0g==
X-Received: by 2002:a05:7301:9c82:b0:30c:ab4d:da33 with SMTP id
 5a478bee46e88-30cab4ddba6mr1811649eec.37.1782517201613; 
 Fri, 26 Jun 2026 16:40:01 -0700 (PDT)
X-Received: by 2002:a05:7301:9c82:b0:30c:ab4d:da33 with SMTP id
 5a478bee46e88-30cab4ddba6mr1811618eec.37.1782517201077; 
 Fri, 26 Jun 2026 16:40:01 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52c591sm29369756eec.7.2026.06.26.16.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 16:40:00 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH v2 27/37] tests/tcg/meson.build: add generic plugin tests
Date: Fri, 26 Jun 2026 16:39:08 -0700
Message-ID: <20260626233918.158740-28-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260626233918.158740-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aoiCzyZV c=1 sm=1 tr=0 ts=6a3f0dd2 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=x_fzxmjp72ZQhEP1AxgA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: DQqUqkQnek5IuswvRv6UwejirQkJ0Tgb
X-Proofpoint-ORIG-GUID: DQqUqkQnek5IuswvRv6UwejirQkJ0Tgb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfXyuFiLVECOl8M
 8j17TcbcjNoro2MFbJMMLFxqwLnnrUkFjfcZasdEOaUvjgkpaphrNoJmX/R3T9EWLRzY+9XiUad
 BkfOJvTWgGIGvM8bYclMSjmvsehLOOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE5NyBTYWx0ZWRfX4sofxtOQ85lw
 ql5s+Z/SimHqSc1e8LTm/7m32vaps4OTJMD68zRMFqcNTMZ/VQ2xZNQxBz5QQzJa5VD4YBHINBP
 GeM3MgOstscgeDLp4QQbv0RXxBpLUp1FaHHdmiXzPE+Iz9sq8YWjcnNyaxuzS6g4OaTeDu3GKGA
 TgFuMfZzAxz4v5qvQ3S11fUItV1ueNGEpSBy7udO3nGiiHIqcvhRr5KLJSPMTu6mEfFUVoXB+LQ
 5NA77TtSpCu2VaUg7GRSAQibg8qQO/CuL4dohxAgIvc17t/SqQyw0H1hb9vVN4T6ZSCeGzOCwDx
 N0snLIGQJobSGMP+xEUG8AVniJguIYLK3/xCmp7Qj98rDbJX+5IX5+ODoMIE7dfTns04I8POggQ
 sDwGJTMlpnTnRA2lpRhwz6yVt/Z5EXE/v87cyEqWJoaqdD1r4tY5QCk3C+BnGMb802x8OcBXhHN
 h/3QsfLZMhm/ULd3rWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606260197
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

We finally run every multiarch test (user & system) with every plugin we
have. We can implement another strategy easily, the point here is just
to show how we can do this without impacting test definitions files.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index f8234ccf393..0f0a2b578af 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -71,6 +71,42 @@ subdir('plugins')
 # multiarch comes second, so it can be referenced by other arch after
 subdir('multiarch')
 
+# Generic Plugin tests - add plugin for every user/system multiarch test
+plugin_tests_exclude = ['patch']
+foreach target: ['multiarch-linux-user', 'multiarch-softmmu']
+  plugin_tests = []
+  tests = tcg_tests[target]['tests']
+
+  foreach plugin_name, _: test_plugins
+    if plugin_name in plugin_tests_exclude
+      continue
+    endif
+
+    foreach t: tests
+      foreach src, setup: t
+        if 'plugin_test' in setup or 'gdb_test' in setup
+          continue
+        endif
+
+        # copy existing setup and remove existing cflags
+        new_setup = {}
+        foreach key, val: setup
+          if key == 'cflags'
+            continue
+          endif
+          new_setup += {key: val}
+        endforeach
+
+        new_setup += {'plugin_test': {'plugin': plugin_name}}
+        plugin_tests += {src: new_setup}
+      endforeach
+    endforeach
+  endforeach
+
+  # replace list of tests with old and new ones
+  tcg_tests += {target: {'tests': tests + plugin_tests}}
+endforeach
+
 # Now let's go through all architectures
 subdir('aarch64')
 
-- 
2.47.3


