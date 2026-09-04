Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39EB9C624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:06:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2aBD-0000Wv-BA; Fri, 04 Sep 2026 16:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aB6-0000Wg-Us
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:06:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2aB4-0000q4-W0
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:06:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684HI8sj314071
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 20:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=MNlz4pfVw0BDTraf9fgY1Gpar2ofwBnFmk5
 GZB4u5G0=; b=FxQhFR9EEp/k7KnB8HmV9MbkG6d88eqpsvj9EVf1nOt84UjcXIH
 XqaeOaUgA+KRQHJidiwALo7H1pGyOzeLwxl2EzUuR8z1rYKz57+zGlV9tIZHgMxE
 //enN2TE7uSYXAlQ6NzpRNlJTNRU95opw8DB3FyJ/KGDyEzzgorrOY7hM1k2N11F
 Tg69F9WEZ9AIoTDXBAF4e//DqGiCtEQcrXn1vfAUJ3MLCALIruV+fzv5mLBeRfBb
 /UNM1TTVLA9zNrMMSyxTthuo003DCRZTxWN0OX67TJelN+MEvBg4VFIMDIYvpYDI
 yNb3Efzqb8HaVCcSBe8p++4ygW6og3Q1fGg==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg011hsr7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 20:06:19 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6b1c1538784so1662206eaf.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 13:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788552378; x=1789157178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MNlz4pfVw0BDTraf9fgY1Gpar2ofwBnFmk5GZB4u5G0=;
 b=a9tslzMcEyE5LzcJGc8weSDZQXprxYED4woQdTP0TnfLXbXOAffexZd5vDqWiFjYAX
 bYIBceyI/0Z3Gh5ItLLOcVpkrLlSdDXAKScCqbNWBib9xlK0sTSxaxGDEAFtpVepPUIm
 w87G+A0uNETk9YxaT4ifLQIgZrKuT6t1mTqGpfZa32LMpTFBuj26pBpiZefIydaNutZ0
 RmKSDXbLK8PA+HRz49R3qyHfGTFLWaVQsvzfMXSSDkB/hlrPnZpEj9bUqyBGXk0cgt18
 UtvZ11IZ8rrtYx+BQbjrNh0kiS/qKl7iCaPHfNunBxs8jpJwj3q3hT/5Ph3GMm16Vk4C
 Ln5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788552378; x=1789157178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MNlz4pfVw0BDTraf9fgY1Gpar2ofwBnFmk5GZB4u5G0=;
 b=DRkiu2+ajuzXzoWou0dLBtZww1CID0W3t2WneBBFG4d4IdJ2cXuTgruQlKvUxjgAB3
 61iK2sl2P/FSIKUaeQHN4YFBNN7XUY8OlArxcoD9p3TR72eCQMMdO0UXYBYUpjVpAgYY
 PPh+WpveC8Bz/EllC3TRiwlh53+MzqC4MuYZgLzLbgG53IoWW0q1SmHfUdFQWVvtc9Hx
 x2iHFEw+SGrl+eza6nB+gkP11DUU+d+KkwxnOOzy9koup/tTDy/brTVyBGAiCjDJOv2S
 H+rax3yC3wkHsTFnrUSoetD1IU4rIW0E3eF1/yI3COo7EIKzH0FYQbL2l4ApR/3czLBl
 FbIQ==
X-Gm-Message-State: AFuF++k9oR3R/k93QaQ83PCZNXWB0FXoVhvRF8ICynKohtKaGct3ODR3
 TI53AjS3vhdK3b/4Hcb+rXwSHNLEQe11K3jEGzJB8pDzb/ve82c+V8in4kPLxKeyQ629E9Nf5GF
 qINZnSf7DORfkEbWIuZBE1L8Yz9P/RmKYWI+u0VxTyEnCZV4sqj/1K2QzmUGaiokU2Q==
X-Gm-Gg: AYBFou2M8ubKOJjV+2/RJpcvy6/syj7fovtZD8wnFqAD14sedRXg7vi1Cc+zRVu3a0a
 VGAtXojQ0s6vyDdy0W+uJ8yIE56ybdvkifeaPmEgLlLtXpJb4a63wbcS5oZFOY4BqAxdJY2aOdZ
 T+rdHc6gLwy7D1Kaj0MLCvTxqOZ1P18SAmxbSzXD0j3jcbxEy+UJz6p5rsEgQnPtwfxLV0EgEPi
 5neZ5hZVrr8RWzAZQjbuATlqpLCsEsZ8CEUzh3soKtdQYjgLBIlWM3bJ3bB+ewB+uMLYZ+0errA
 caAzFSSyEwwabUx332GFi+AGdBekD1iAsa3TdD/TJTdtifl/AqGZmr0qtHwT/KRIdxQVakHJZLy
 LZVeut6MUeqxqAHvlTrwMIKeSB5dGnk90UICGBCcPE2wEwc6Or9cJbvXW4gI=
X-Received: by 2002:a05:6820:f034:b0:6b7:46fa:16a0 with SMTP id
 006d021491bc7-6b746fa1a27mr4504517eaf.53.1788552378452; 
 Fri, 04 Sep 2026 13:06:18 -0700 (PDT)
X-Received: by 2002:a05:6820:f034:b0:6b7:46fa:16a0 with SMTP id
 006d021491bc7-6b746fa1a27mr4504487eaf.53.1788552378042; 
 Fri, 04 Sep 2026 13:06:18 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339befdefcsm7483479eec.29.2026.09.04.13.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 13:06:17 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH] tests/tcg/meson.build: fix build_test_depends
Date: Fri,  4 Sep 2026 13:06:14 -0700
Message-ID: <20260904200614.2808877-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX0Y1L1uz3dIc0
 eU+hx4mizDQpEF6vL0/PBUZJyDiNyarT/SkfeiDbccUF58wEc9FD99qJIZYTryzjjQ5CGsapjGv
 h2Tf7gF9jwKxLYirMs5UEl3jhpwMDno6flWvWclsiuU7qjQ1cAe6vr72fP9oeo2lx7c75TM81Z1
 GmyAXGiQ9wFxCur0f1+zbVvq17vekwPVNw8CM801ImUn5zrG6Q9rfLxkfipku8KUBv/Miin023n
 MCOos3ZcVEXfTQS3cqOWIN+kFKAUPo/dne61A8p2ww4uGyMiDarkOh5NYQFheX0lO2JPyXhCj/c
 72aT7di3jttWlxKMLaOovs5mpolyv9Nl3eMAfW0tp+2gDlw0JyTn6C/fmKZh8JYhQxXPoM/2f+I
 x9TmiAjlRgvaov2Wb2r8iwAWHdjdwgWe16K4xU3Ykp8II747q0jwixdMR3rRjVaMifHEGnlRtMb
 w6gJ518d48yqR4+7JgA==
X-Proofpoint-GUID: KsxxyylrbEK2M-ATSNJ2TyFt2Iozmdts
X-Proofpoint-ORIG-GUID: KsxxyylrbEK2M-ATSNJ2TyFt2Iozmdts
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDE4NCBTYWx0ZWRfX6RxNQQe6gE+N
 Qh587M90pBPhSGyVKKgLu+I5UpgnYeTLzZNIZ3uG8KD6KtRfRvAcgMFFj+Ptx+98kn25zDtE5pa
 68lTIg/GtX+5fcZrEof9D18pMa+gwpo=
X-Authority-Analysis: v=2.4 cv=Ibi3n2qa c=1 sm=1 tr=0 ts=6a9b24bb cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qGe-MntRKviEIDiUTp4A:9 a=WZGXeFmKUf7gPmL3hEjn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040184
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

build_test_depends is supposed to be an array, not a custom target. In
case we go through this path, we have an error with following lines:

      exe_depends = build_test_depends
      if 'depends' in setup
        exe_depends += setup['depends']
      endif

where meson complains that custom target has no += operator.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index 243cdb5fc8c..d41a228fb3d 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -263,8 +263,8 @@ foreach target, plan: tcg_tests
     endif
 
     if not has_cc and has_docker
-      build_test_depends = image_targets[cc_dockerfile]
-      build_test_depend_files = dockerfile
+      build_test_depends += image_targets[cc_dockerfile]
+      build_test_depend_files += dockerfile
       mount = meson.project_source_root()
       mount = mount + ':' + mount
       here = meson.project_build_root()
-- 
2.47.3


