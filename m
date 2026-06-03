Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B520CD6E57
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 20:55:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUsaa-0000LA-0c; Wed, 03 Jun 2026 16:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZt-0008Cl-He
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUsZm-0004K4-8w
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 16:52:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653EbhLD1476767
 for <qemu-devel@nongnu.org>; Wed, 3 Jun 2026 20:52:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iAMw+Umamu4
 26qsiuv5WzZwhKM+xLIsnUWXk/+9vdhA=; b=M5VU71+hAF4DI1GmDcTqJ+gwRQD
 ZNd3VWSnjO/YdtpVQbmDQLwQ79uK/XS0bR4edNcCVK0MytlTsMGFfkZ0i5rE8iLi
 38JAsUbdxBRczTPO0lvEiv16N/CKpVQGq2ZOMqiMINTMCiq63tc/ctSG/tom6rRh
 1KpNqTWvkC8YMFqlS5MDAKcbmnv7/sygwXvg72L7eNV/4JY59PEqwW48nQwuf2ig
 X3fr0+FpCi912+16CkmU2GV+wwSEE6GkBLeGcuVWOelZ/bPNqXTAmenO7dzpWCKY
 M9htWAz8rlfa/Uo3PJVIH9rXYTVW8HbQcB07kpzFwxFymbyB8cSrNHKfJnA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejp6nsmyq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 20:52:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-30762d67a64so444452eec.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780519952; x=1781124752; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iAMw+Umamu426qsiuv5WzZwhKM+xLIsnUWXk/+9vdhA=;
 b=Y0QTR3+tf5ZglPXvmHCKhJBRgrYLxqnNro1RT6+3qyw0WnG7zdplqd7T20HrIqfw9z
 cufRpwgRNk9naWYipQtOUPIST0iqAgFNv15jjIPElNlP3JAxYSywACMukS5VvF3QKLOx
 fXWftpWgKqpVpz6L6bB0lciJXhINzw+OYFwV34DNxdh+Rp6yo2506EBohrKBq26AL5f2
 suKb7cC4vnFl9zVs7KwgGS/EKsaYpzDYUeL+BHfPzlWC7zyk0Ochz5zdyGdu/wxiS8te
 Lb5GC5zdx7NWO7/wGyIGUB7C5txWI7dSpK3x2ZoyRR+aLlFKSNlNUEAp0a1YtnT2AB9f
 imhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780519952; x=1781124752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iAMw+Umamu426qsiuv5WzZwhKM+xLIsnUWXk/+9vdhA=;
 b=S7Ytak8pOhWaY7vV5x7261wy1Xf45BK0M6UCWM9oOHL+ZAITF8wD+BC9pH95t4BbJX
 0Q37j3i13se/2JeiNcOC2Vr9PJkIUaHqPWUuwFTWIFbxHOHSwL351XjEJbIDtV773gUH
 OMeyvSPzed/9TJnqVGJ25q4xaiqC44G+PtV99BDkEfO9/a7juUiIz/DwAWRiUeBWo1AJ
 WyHu7qqnAt+/pQVCTttKb6vUWNhOpzsFUWQN5G7G6XksuCSzOJHTpGs7CnRooXwL8kWq
 /sUNAQmi277Co6bJKwZLq8Ohhrlv4Tqoqul/gPX9k0PSXsnRF0zwthUr1jHfQ7U8IVMD
 aSCQ==
X-Gm-Message-State: AOJu0Yz2Sp+iuBkn/g9aAH8Vt+s/PvemDallk6080ohtjO4cNdGtdmmL
 QnqqRYnSzmvvKsj1NHrZoYw7Lt+GRDopyXMo+KWnmFrpm3CPmv8F0Xk2FfwdvlKyutY7SqWJAP/
 +3R10MqEnPrntN7vyMdCDCwhYc/dmz/p8gOq42SRqX0lJy+4TUtLO1wiRQbAwRYtmRRua
X-Gm-Gg: Acq92OEOajZyPdaq5ExepR7Qlj5WQI2wFWAu9XxOttJ9ifmxXK+HoM48FnmIl7zWvSK
 rBAAUP61dkpXitMBX6d/f4w4qoZLbMKiTW2Fy3HBVgt/QDn99tTnZMCs9u3zjIw4edhQgUW5OhH
 bnzaMxwGxHKpBBtsSOyuobIBLMvlkHBRKEfOd2YU8+MJhy+YYfXTYgF16BrcgSBu4gRi0HkHMAw
 YgZixT84ya7zEmgRPT8bCQrd70N1EyLVmG6C/cryI3PGtBE1T7Rc9dC6Or3xgkhJSoCCJ1TzsZH
 lPK4esvzLPLlnElsjBL9mw1bh+8VmEZRAYzb0tm8CWqXfe7FPyYcXoAhQbz/G3PiaCc/bQLdQN+
 bcH2vWtkPL7OGRHLAtoI35V+y6sypg33OEqv1MVSG7QAaT0WQnhDXNum15wJvRrlt0OxDqCeRf4
 vFmyo595BykkjpL38V
X-Received: by 2002:a05:7301:1f0d:b0:304:2e9b:8f57 with SMTP id
 5a478bee46e88-3074fca0bf8mr2701801eec.34.1780519952169; 
 Wed, 03 Jun 2026 13:52:32 -0700 (PDT)
X-Received: by 2002:a05:7301:1f0d:b0:304:2e9b:8f57 with SMTP id
 5a478bee46e88-3074fca0bf8mr2701788eec.34.1780519951670; 
 Wed, 03 Jun 2026 13:52:31 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074db85f60sm4586333eec.8.2026.06.03.13.52.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 13:52:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 24/25] scripts/checkpatch: remove check on forbidden space
 before '[' in C++
Date: Wed,  3 Jun 2026 13:51:51 -0700
Message-ID: <20260603205152.1440291-25-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9UT1r-aLr0ZRUdvwGZpboDZ4xLg1T7uS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDIwMyBTYWx0ZWRfX48o67Vbnk2bm
 M2kc0IIAkrNbGEicXQ4Gi/+T0aOoEePKFo8a1l+719vtlLxEo5pz+GuvydJR60sLXr9r0vP4uOy
 zM0yigk2+QpE1v/V5O8SoRpQjJrpb68uK8IuHCwKgaKihNHbylhabI4OZZiAQquuQg/FkA6MT04
 T1rxkJ4cq/Rzu2b5beZL2x170M5KVejitQpXvFI0EdptMM1WVWCc5Ztkrezw6wVQcMF2vlvmPvX
 e6TWREOCIRXHGUvmz/OAEqpHtajFaYOwvX3QJpS/OrcsmInwrVIPAo7azpLq5DGU37whOgYJluI
 vCPhXdouVcB2/C2QsuRD63nb2CIU3/weMN3PDy6H0WquwqGFHgCTDmF4CKQBsWDtU+D8Y/fqKLC
 8uvmAXbdHkX37dF23mgMy6KhESu3wB+vZhtBFJnRX7o3UtEk8ZXHI4AQHs9mL+RxvUO2qdUKqa2
 2zMJ2fb86cQNrM4kBAA==
X-Authority-Analysis: v=2.4 cv=DbcnbPtW c=1 sm=1 tr=0 ts=6a209410 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=AevLI7NHNFxaMMikSDMA:9 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 9UT1r-aLr0ZRUdvwGZpboDZ4xLg1T7uS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030203
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

Lambdas are very confusing for checkpatch, so just relax this check.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c74ec070c53..d90aca6fcbf 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2423,7 +2423,8 @@ sub process {
 #  3. inside a curly brace -- = { [0...10] = 5 }
 #  4. after a comma -- [1] = 5, [2] = 6
 #  5. in a macro definition -- #define abc(x) [x] = y
-		while ($line =~ /(.*?\s)\[/g) {
+		my $cpp = $realfile =~ /(\.cpp)$/;
+		while (!$cpp && $line =~ /(.*?\s)\[/g) {
 			my ($where, $prefix) = ($-[1], $1);
 			if ($prefix !~ /$Type\s+$/ &&
 			    ($where != 0 || $prefix !~ /^.\s+$/) &&
-- 
2.43.0


