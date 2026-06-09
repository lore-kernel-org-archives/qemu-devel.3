Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B29CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JO-0007Ia-MW; Tue, 09 Jun 2026 17:48:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JF-000704-M6
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JC-0008Fy-8A
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:33 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4e3o3683839
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t3HezfQaCDT
 Png5QkWwH4ci9dHtU/zyUdjdhLjx0o3A=; b=g+FEwW/ZtkoWkq8E7Zzhh4aBEQJ
 IL9eCIheAAJgYtqbqIcpU5Rvoz7PEOvmwak3gtlBRqRFdpZQeic23rs8U/xJb9JD
 P0um7VdYBSCLwBZK77MQcGWJ18aH5W0qwXoi4SwZo3ghelcQ4EoFug58yTSZap6j
 Ot1NycSYPH2mu0HVh0T6EbDZXyDJH/82hj4c1c8BDef84t1Nzkqt081p+v0vK/xf
 AlwhEe17n1mixn4g9xSMsWGHivOSnUdTM3hvWReb70L29L2biw0ktsOEJv/VdgSx
 yT345yJ5CzGCBk1kPCDCHw13DH5IpGEoz4K3m9n+Xstd9p+LFgogj11oEIQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v3gxa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:24 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383975f18bso53883c88.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041704; x=1781646504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3HezfQaCDTPng5QkWwH4ci9dHtU/zyUdjdhLjx0o3A=;
 b=bkGei311jkacumXeHC5m5LCaAD52VrubxQqqx4o/S/DqkWiisV49i487xrRQLIIRdO
 JXG6eTdnHchwxNTNDAkq8dKiWTIMxX1gMSUFY+UvtmykbTkvyDYjg0y3KbQBzyoNl/j1
 HI0qzJ4BJmYZyPsGowh5mZaCUcLeVFBunylvPl8zZeXfo1OG5ROsk5sHF6PUaMZdjt60
 fOT6YNzkDz2BtTTI568CP5TSUATwR84NC+vADIzsrRWgiDikwuarLLtwGGgUqXx4RTG/
 76jfLH3eanFyhT1k8ucPDKoW63I7ejHaYR2bRz8Cu/MPB2dguZQwnCq+71LfQQqfXhsj
 Kk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041704; x=1781646504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3HezfQaCDTPng5QkWwH4ci9dHtU/zyUdjdhLjx0o3A=;
 b=KYphr1mQtaRPptZ5uiRG/rVV52UvrojPs0IQc4mMHCaMzH5SByNkKp/ReOoeSOrh1p
 BQ5+JhNksIwaw7OLFEcJ7Lzqn+IAqvbfVPjOign4qgu39KWIom72TRY9BYklV6RH8THZ
 Yw9FyZHVA66ZgDduaIdgbrYHq8ew2eOq3f6M97b42HVYoE7mok1c66EdJ2Mu8lT4Fqq2
 yqNya/2CyarrwtbK4cRZXYbdHMqeKbdHli2RvRCsqdDlhmMaDeLjxE/xRxQ4Z8N/izbR
 Gsb4ZXgFJai8jLHqDh8sYH9tDJcOlOiSpctEIkOkav++SsGYWrlmleAki010/N0OaaNd
 OPxw==
X-Gm-Message-State: AOJu0Yy9BoKjLbNAlNac37OCAVZHQbC+Y1WDdpeiKbO1g3AgXeXnxJ5C
 TU4x6vimyERZVpRWZI1uqhfM5JEeRL/yuOlLu5zSpr7xr1ZqO37jIdvyZAAxcTEIje1QfGWePQJ
 cKOY3whWa6q6YvaAfC4zFAVNSaoXoJ9HxqOJ0x/sd1RwL0fGBE2lJOEWHbfgaKxB3SUCc
X-Gm-Gg: Acq92OHgi/v+L0cTCAzhXWtgc/9jE/Ct/Tw7uNj6zHIsb8oBuYRYPCZvUn8pRvtAx8+
 n8HGTlD9hETSYKWrEou3O8hEL8aj6+znh39Vmq/d313FEZrstQbvWnLxSi2kVWxG1uU811UkukY
 rkcTe6jDExUGAR+rkhlGDO5UgH1HRgCwxQKhz3VR3qY/iTGC0gpjO5Q9YVb8yfx1pA+6IYtdSao
 BSjkqeKwcFkN6YeH7y7vrEBthfFd45bcDUOlChAnVP9F0Z1rbYbZMVtV90D64P6qG7sbNKYJRJ1
 gPUFl2D1xlAantzOGOeU/OKPTXpCh3z7EASDojYm7VkfnY8PhVfGjC/sEufkzJxx3P5fkxXrY9Z
 9VFBR8aovREu7e+aTRZWztWLdLwZOcxyiEtj024rR4Sl+xr/xpwUx1mJyTmK5RjXj+huH5ol/sJ
 6TNqEHkm/nbxZecrHa
X-Received: by 2002:a05:7022:ea4d:b0:137:f995:df25 with SMTP id
 a92af1059eb24-13831a63a3amr2233107c88.13.1781041701651; 
 Tue, 09 Jun 2026 14:48:21 -0700 (PDT)
X-Received: by 2002:a05:7022:ea4d:b0:137:f995:df25 with SMTP id
 a92af1059eb24-13831a63a3amr2233031c88.13.1781041698192; 
 Tue, 09 Jun 2026 14:48:18 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 24/27] tests/tcg/aarch64: add multiarch user tests
Date: Tue,  9 Jun 2026 14:47:42 -0700
Message-ID: <20260609214745.772536-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a288a28 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=sYsyHSaelrBW26qggMEA:9 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-ORIG-GUID: IQaQCxowic9XWZGPTJHXdmw-zXnfXiqK
X-Proofpoint-GUID: IQaQCxowic9XWZGPTJHXdmw-zXnfXiqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX9nUHoGRGxJm5
 3sqhQPLY0M+/HEvDsp/KOUINZ+iridIPaVCRtlIdNjnjdQ1y30O57YaV4QlNauyrtuHSvb0unT6
 kMA2XCLfM76xWMf36NaFVkDKU9v+GBNS9loyklfztYceL8HuRomX97iH9Gzh0tPq4s+9fza9eVU
 k7uZoHRCWb6gf62UJ+XqpWFBN2j+SY20WzSX69tHsbJ/BoH0cY2ns1qB3As/3rDXoEWSHih1I7i
 CfsWOok48dJFNk3VocudOzFRoi2oy8D+cy51HXAB/t6Un+ZrywzT8PsGcs9Pw9ACvcZ49Clvl7P
 pq2vHCtEu+cElCCJWDnzcyQdZdAn0FSJNp0yFXUXNTdtECMaggAI1/6wxqS/ZVFmWS2R4XlzgH8
 TOiKSf6QS44a5yieMtnRqN2BxI+tH+yh8yFcv9MxsDF3TGcYULC4NV25v/nzSt+4OuMEJLsb5Gd
 K7z3cCRF4/7apGIA6Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We can now add multiarch tests. We also take care of semihosting tests
here, by including them explicitly, instead of relying on any kind of
"per-target" config.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/meson.build | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tests/tcg/aarch64/meson.build b/tests/tcg/aarch64/meson.build
index e6cf5309649..53085278155 100644
--- a/tests/tcg/aarch64/meson.build
+++ b/tests/tcg/aarch64/meson.build
@@ -51,6 +51,9 @@ endif
 
 tests = []
 
+# Multi arch tests
+tests += tcg_tests['multiarch-linux-user']['tests']
+
 # Base architecture tests
 tests += {
   '../arm/fcvt.c': {'cflags': '-lm', 'expected_output': 'fcvt.ref'},
@@ -136,11 +139,29 @@ tests += {'sysregs.c': {}}
 # Crypto Tests
 tests += {'test-aes.c': {'cflags': feat_cflags['aes']}}
 
+# Vector SHA1
+# Work around compiler false-positive warning, as we do for the 'sha1' test
+tests += {'../multiarch/sha1.c': {
+            'exe_name': 'sha1-vector',
+            'cflags': ['-O3', '-Wno-stringop-overread'],
+            'expected_output': '../multiarch/sha1.ref',
+         }}
+
+# Vector versions of sha512 (-O3 triggers vectorisation)
+tests += {'../multiarch/sha512.c': {
+            'exe_name': 'sha512-vector',
+            'cflags': ['-O3'],
+         }}
+
 # SVE Tests
 if cc_has_feat['sve']
   f = feat_cflags['sve']
   tests += {
     'sve-ioctls.c': {'cflags': f},
+    '../multiarch/sha512.c': {
+       'exe_name': 'sha512-sve',
+       'cflags': f,
+    },
     'sve-str.c': {'cflags': [f, '-O1']},
   }
 endif
@@ -204,6 +225,18 @@ if cc_has_feat['mte'] and gdb_has_feat['mte']
   }
 endif
 
+# Semihosting tests
+# Add -I path for semicall.h
+semihosting_cflags = ['-I', meson.current_source_dir()]
+
+tests += {
+  '../multiarch/arm-compat-semi/semiconsole.c': {
+    'cflags': semihosting_cflags,
+    'wrapper': [prog_run_with_input, 'X'],
+  },
+  '../multiarch/arm-compat-semi/semihosting.c': {'cflags': semihosting_cflags},
+}
+
 tcg_tests += {
   'aarch64-linux-user': {
     'cc': cc,
-- 
2.43.0


