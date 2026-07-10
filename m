Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D679FC44506
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4bM-00014T-94; Fri, 10 Jul 2026 02:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bJ-000137-H2
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4bH-0004UN-NG
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:20:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3miGe3721099
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JqM/CpbinxCaLgY9DJamTDPYeIzdHY5q7+dhg27x3B8=; b=ZulDTLlYlKJvoUzb
 IvoioBGBQ9WBxh36d+8/kV6V75LHIVMAtWZqbxjOAdDyuOCNddPnGDnIXIWMPrzz
 pjfHZuSu6bkuX9xPh+iGvQEXlw9OdfKWS9QVv9tdD/AO4GgxgDV61sFEPKDiDbrK
 2UId8aoKo1wjRLn+TNER6zzOZpLX0anJr3ohtcZ4EmMnE4eU+oQt+9dlwsuohN4d
 7sJm3Fj9kjE24b+KtCJdwrayb7Vzi8VyzRjO1NO6IhQ7tti1vbrpuQdmQdyyNV78
 Lofl8d1baM8PWsoq+akXBapMZveUbzDyY2GKQcEowb8sx1uR7f1yasZoZnbh1/b6
 B1MPSw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fajwt9nht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:20:38 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85798977dcso937230a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664437; x=1784269237; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JqM/CpbinxCaLgY9DJamTDPYeIzdHY5q7+dhg27x3B8=;
 b=L1Gjq08UYa+x+OOOfVOb/eT3WD//7aaNhufDwDVMWJE5Q7fwHeR3bboGDNUFRhNHeN
 IQbAm36ahOAyyN3A3fCX8+oHytjicWWBMORZGB3MumCVc9/F+YNK8Rsa3bkodXiqVXMB
 OZA6wuE3tkgSFcugdszTA0J6Co9cFstWo77+0b/0cOW8fQkDPyhshX7ngW4HWLuJIqI7
 abv/Yrz+EWWUK4HoIE6Co9ETtvT8jWzfxApgvtPG8v2O4/lEKs9IrcXPKeuLQfMOr0iv
 RH88yE+4ja+OYx1hUz/uSloqUpo1mMuJLAUW/JOT0Rgey3jFm4sTnhzNnu92dJ1pAgt3
 cyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664437; x=1784269237;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JqM/CpbinxCaLgY9DJamTDPYeIzdHY5q7+dhg27x3B8=;
 b=odN2HClsVP0ZRAqNZKVkr23JBLqXvThENqkRq1v7nEDbJxySgILRiK6uMlBPaBXg9P
 4Q+b73lCFscE9ku4No/dx0EUHQo2zpnUyJjQNVq6z4J/1qpRHjP6Ka1ETC361tM/S2XC
 3r2N9dIe2qaUC4HKC3BnDktXaMxIImLPcPKni9SXB+VEHwzcKbt2d21ojvcU6Ku3B0P2
 UOKkk0VRGKvnYZzv9a1z9Vu3/EBVvu+XHNDOBw94kx5Y3AhmhmssaK5yYJQCeIrjO9Oh
 WnCQKdbYbbGyv9BJRVG28tnL/vgqZcaB9Q6ZNwXcrgHx1XjFkjE/z2vFe42oG6PnSd6I
 YMYw==
X-Gm-Message-State: AOJu0Ywc4ycvYWkc8kxad8vlSqqUwGfNgKy0MubtbA1g5hc+hJFRhZVq
 KsQvSazNQLhWsXP3lZKa0un211XOs4zXoFYVCVPNqHdzw0MIJw4MWKlL9FOTMY8eYD+2GX1TyKq
 JuDXma2yWZIoMh3r3/ZmPZKreyrMRkjuYUgKkcV9pbw4P6TR+n4DrniNQGKPUXlqiPg==
X-Gm-Gg: AfdE7clvihYBsmzBRhxVH+6F5Uezagpsu/lrOnrcEqXPZCTktkNbY0/SytM5/Vysgd8
 LYSGKgCGJ9R6jBOLXiQLIx+Bse8ELCJ0Z1vW+heH3p47+P7v2sIB+xegz0K014WKCfPHOby4OG3
 0HBSv0OBqL6h8DYtR/uCD+xOJtXunakZmmturAlZqE7oSiVD7wJUR63ynHApyn+440MsCOFWYJf
 R2S228RSKZ21X0T5+nzvyefa3YiU4ktL5iHqYUkjox8CjdZKftni0514JTF8v0DvkSAwcryWJoj
 rCHPrSzfNzXjSFgKcX/hhQwsnPZcVW6lIn0+LVb0htMH91uGO68izxG56dRZ+o55W2jHScOTjpW
 BjgCqfxUaJnV2sqdT4I7iASGIQK3pB8HIXBTcVpGDneA5Q/LYf6cWLyNvsKs+xevNcf9PEPnprI
 k5QhQg4A==
X-Received: by 2002:a05:6a20:6f8d:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c0bcf48f6emr12126589637.3.1783664437399; 
 Thu, 09 Jul 2026 23:20:37 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f8d:b0:3b2:a809:1000 with SMTP id
 adf61e73a8af0-3c0bcf48f6emr12126549637.3.1783664436820; 
 Thu, 09 Jul 2026 23:20:36 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659fa13bsm35428126c88.15.2026.07.09.23.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:20:33 -0700 (PDT)
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
Subject: [PATCH v4 06/97] tests/tcg/meson.build: introduce exe_name
Date: Thu,  9 Jul 2026 23:18:44 -0700
Message-ID: <20260710062016.1818125-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XOYAjwhE c=1 sm=1 tr=0 ts=6a508f36 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=xYeKZKBo3MRtsS0M5EUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: zlZuYNZoX7MuId8C91j9SoNEaknj42w5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX/ad0zUHZ4eUC
 MzmhYAkXxdhzW7R5r6TaI6AL08KAy9pfLS1Ri9Rd6wZvA5GNmw2KjbjdmjsI7L6DSg9TN7yya5T
 2vkKseoyV105RGfFdWsHju5QhGjTHfQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OCBTYWx0ZWRfX0zguCsJ4D1+6
 n+bM3oTJmd3lzRy8zk+6VmTw+Le84c2/VtYZruIXczkFrS1s4Nop6Sd4I96etOG1C3pyPYPb+AN
 IPJKd6+gGj7HdWnmlq73lByBqdDgPDdAy8+7SbiudjfPV/NsexaspPShy2lOmYwB7OWYibLvKg9
 GViZIHrhvxIwl+pggIxciCNZ6ulttZSHqRgCDUCTY2g+uBd/nnyyZmmbOvkQBemlf+bdvPHDHaf
 KyeuHysverw0WyxQ4zE2f9cQ972IzBKWfKSRd+OGqObQnzRpdQLtwscfJ1NIhONJigFqgA+oDBB
 Ck63xXTTpAs7lZGH7ZSEXoGctYTPM8325huDHUPg0sHaJNoF0YZHq4vzDrqr+mxRPL161VLBWi7
 oPOZfrt0aS9g6McUeyNDTihgSQ7IFRrQuI/KqFHKXfs3qvSQA81C7Dt0dGODrfZ3raAzLs2A66p
 B0KvWb0A6AeZltfj7/A==
X-Proofpoint-ORIG-GUID: zlZuYNZoX7MuId8C91j9SoNEaknj42w5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100058
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

We add possibility to duplicate a test executable for a given source
file. This is needed when different cflags need to be used (like
vectorized vs non-vectorized for instance, like sve tests in aarch64).

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 0cfb39b0902..1719eac0d51 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -11,6 +11,7 @@ tcg_tests = {}
 #     'tests': [
 #       {
 #         'src_file': {
+#           'exe_name': ['provide an alternative binary name'],
 #         }
 #       },
 #       ...
@@ -18,10 +19,10 @@ tcg_tests = {}
 #   }
 # }
 #
-# Every test executable, is built only once.
+# Every test executable, identified by 'exe_name' is built only once.
 # Tests for a given src use the same executable by default, and their definition
 # is guaranteed to be unique also.
-# Default name is derived from src.
+# Default name is derived from src if 'exe_name' is omitted.
 
 # plugins come first, as we need to build the list
 subdir('plugins')
@@ -49,10 +50,22 @@ foreach target, plan: tcg_tests
 
   foreach t : tests
     foreach src, setup: t
+      # return a clear error if user misspell a setup entry
+      foreach key, _ : setup
+        allowed = ['exe_name']
+        if key not in allowed
+          error('unknown tcg setup entry \'' + key + '\' for test ' + src +
+                ' (possible: [' + ', '.join(allowed) + '])')
+        endif
+      endforeach
+
       # meson '/' operator drops left operand if right is an absolute path
       src = folder / src
       file = files(src)
       exe_name = fs.stem(src)
+      if 'exe_name' in setup
+        exe_name = setup['exe_name']
+      endif
 
       exe_name = target + '-' + exe_name
       test_name = exe_name
-- 
2.47.3


