Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A791FC61DCD
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziO3-0005zE-D8; Thu, 27 Aug 2026 18:15:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNw-0005ot-Ho
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziNu-00066M-S8
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:15:48 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RJM71r654752
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=; b=ka8StM21faHvt0tq
 Cixqk6LuywqiMQBhO6mxqZvvqfFf0Kw4R075vqIByKACKDyV8Bxw5PmEaH6D59jw
 3eN0xFZzjfx+2IIylqr5BhLeo981z6FLh/i/t313rewNf/GHFGf1jja/x8uIFGle
 jH6aW3N3H6yfsTpEyhrsUYnmqA7fhScNw+ezCBLK9T3XTE3wAg6Ot2ZDmZ45R7F3
 6DdlyQGdO6o5PDIgTgQqTpKgVQDO3Pl5s+ZJEF5rvodri0YLmLyNl9RSQY5PQ8wN
 Tboc86A/Lf5pmecU7QetGK8Vvpt+HP2g4ataLS7d//EPU1nNBBMdrc1jyiVPtdDL
 qOLSDQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gagjfuk3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:15:35 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-84e4ef486c7so288810b3a.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787868935; x=1788473735; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=LVfYOtVNUfxNVLZwoctdIoeLpctTcUzzJVhvSEIXMNP6jT0Pupk+wKLe95MItDasUO
 TkfY2lKOV0gk2cdTKw0Nl0RvXWGtANWjDKSQFEmMudgk+St5k8ys/Ywu+3FzAbkhTdTB
 4E0fSVUrgHdRBe8T+tbJhSPBALzc5CYeSztpFe5fRVWF9QI7G2N6JGxxXuw0QoVEkES7
 maUQJeDp2UjwApKC0OWQITV55FsY49lC4lORdrXGSLqrKJDfq9rnHrhpLpbXJrjQCTke
 imdUAdmbEYsGwq5cu+olcp2Wp43kTcUq3b9QaOzSJ+hgv7AfcGV9ziSsbnyCExy7GkiE
 K3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787868935; x=1788473735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+7LmtR36iWEI7yim0n+OLqJeLcNbfYMdIcZv+IRHWko=;
 b=sXwJxFACrha1F0HYOhwQfVvvTvRIBxebXVWdwHG6g2EU1wUfGYYvI5rTLSCHYCktD8
 EjgprSVUocYJYnYSkvQ402jr7LQtVK4melVsIwPyXwSmbc6mkD2ZKMjqV+fIiPd6P4S8
 l99JB1Zw3oJSttVgtHnb/e8KAX6VOD4Kkhc5siphRX+Fn5k87G4AYyM3ro6cNH/z03V8
 FEIngvyILjCTgY4J0UXUjRLRirX8cNXlkYBpQUvV0eUHv2FCbuywKDrZlAghslePynZ6
 MNpqTZ1B0VNjb6lYH8V7gxKY78Q5kkFg83l2Et1+3+OUZqY1TYppBe5rWRSMzVle2MCH
 mTkA==
X-Gm-Message-State: AFuF++mK3QEgA5CSmyUVkyFRwGQTatjSpzRSdGCFSAORGiwBrgQA3rZP
 w6phidhf6A+iZCe8MRgm/vHgDWYYIMDWwpHQS98nXtZhOAfIRTNiYLX9ipRmshM68Wi6fHaqbhP
 DoR/UhHPiLfHRoNsOJpecMFV2BKs4Nqa+Y5MxtG1yZu2NyywRwxVc/V4zdBg4Z/M0aQ==
X-Gm-Gg: AR+sD12SeuigOyiob5/2Yc+mEtCwpQ5Tz4ZpjCOs9L4Fo6rCZI7QC0eF43hy5r3zgJd
 U7kZD+XFEMY68DAGbx44zMeN/BsWvuIgTD5zb/EVUd6bQyL8xhN4ZHBEb86nU0XnDD00qvDn5Qg
 d4bqY9U8M51oMrTi0AhqIcVsJbfnimXthUL3vTMH4hiMyfemN1jk5QI0wjLmw2We3DFljz+ZQ2o
 eknAennU3+hvyBpsQamXCgfQj8lGSFmBxcPYR2VhM9PswbhoXcvwpQ8uK89Gcbpuxa0jmGpigT7
 GaZI0KaA6DE5F3afJRAbA/lp6In/ShAh6Klk1IL8UJZ+IXnoJo+mx0TpUBgkYWXEAuYxxyH4KY8
 iStgCXeF6NiuwJp1gjFXE9W0y6hjRg76v31lJHToYwiIigdpPb4fC9fJSsWs=
X-Received: by 2002:a05:6a00:4145:b0:853:ffd0:93f3 with SMTP id
 d2e1a72fcca58-854c8334b4bmr12811870b3a.11.1787868934967; 
 Thu, 27 Aug 2026 15:15:34 -0700 (PDT)
X-Received: by 2002:a05:6a00:4145:b0:853:ffd0:93f3 with SMTP id
 d2e1a72fcca58-854c8334b4bmr12811766b3a.11.1787868934327; 
 Thu, 27 Aug 2026 15:15:34 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8535cf4b213sm2524104b3a.55.2026.08.27.15.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 15:15:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 pierrick.bouvier@oss.qualcomm.com, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bibo Mao <maobibo@loongson.cn>, Helge Deller <deller@gmx.de>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <17746591750@163.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v8 021/105] tests/tcg/meson.build: add logic to skip tests
Date: Thu, 27 Aug 2026 22:13:42 +0000
Message-ID: <20260827221506.91574-22-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260827221506.91574-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tucLcymBWPDCbxrUM_RVblDpXr6Jg6GR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfXwFl9g8yQc5Pt
 aeCAHqpuK7uuJ2caZlTu/r/0ofGTpdzf0GKtxylYlPvHiFzwKvTDxCYHMLyIG7+abVmCC3bkExH
 nxptzpdLZxgciApeU0OgPkqO/s25JSjjoFjCbzATYssq2HmSE3/wh3Q3rv18/MZb3DdghZq9BxW
 6dUiolmrvEZrIMwno/60RUby6xr8+PZtxw4R/dr+CYWtmS3dFmJEfBT/CkODEjWLZDe3lCUbKFu
 i4+1zFR9rzo3n7USkIQk1y5E/9ICE3Mw5AYgSWxe2LP3iYUc3EYPgsw3Rbq80WI4V5jOLCQkYdn
 QxWaMc1iskK6XFmCiwXgiY5DEHGZiBQTRnaro97cRRyTklo5xTYAaE18sffY5faGfMF7ZoyM5Yk
 fY2XWKVkHGs2fL4Nq7rMXPmMNm9/ew+5MG+RYg6aUKM2IQ4QfEbHk5qbhUcUPPpjtQ87tDWQml7
 MyCA9cfjLHOQ3FU8JTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE4OCBTYWx0ZWRfX6VibAeb72rn1
 OqieY2GINj6MGv9V6jIaNcYR+xHw9624s+dnZQZxG1Y6ST6OVyZ6jacVZC+d39lMIjfmR3cm9dQ
 euI9HfaQ44v6oRZM3v/1/FgRP3ABBdY=
X-Proofpoint-GUID: tucLcymBWPDCbxrUM_RVblDpXr6Jg6GR
X-Authority-Analysis: v=2.4 cv=dd+wG3Xe c=1 sm=1 tr=0 ts=6a90b707 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=VnNF1IyMAAAA:8 a=vz2bFB4F5KyvM8IiXWkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_08,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270188
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

Instead of skipping tests and not declare them, always declare them and
simply return an exit code 77 (SKIPPED for meson) and print reason why
test is skipped.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 779f9043abb..7b60ea53825 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -114,11 +114,15 @@ foreach target, plan: tcg_tests
         endforeach
       endif
 
+      # if set, we'll skip test and print the reason
+      skip_test = ''
+
       if 'gdb_test' in setup and gdb_arch not in gdb_arch_supported
         continue
       endif
 
       if 'plugin_test' in setup and not get_option('plugins')
+        # do not use the skip_test logic, and simply ignore the test
         continue
       endif
 
@@ -226,6 +230,11 @@ foreach target, plan: tcg_tests
         cmd = [setup['env_var'], cmd]
       endif
 
+      if skip_test != ''
+        # still declare test, but skip it and print reason
+        cmd = ['sh', '-c', 'echo "' + skip_test + '" && exit 77']
+      endif
+
       test(test_name, env, args: cmd,
            depends: depends,
            timeout: 120,
-- 
2.43.0


