Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C7C5DF89
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:27:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPPC-0006YN-IV; Tue, 18 Aug 2026 15:23:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPPB-0006Xl-9X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPP9-0006XL-Gs
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:23:25 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH87d2494684
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=; b=Tv0JJXhPCcxoPGy1
 zX+OPjy2vR0YyezCn1UL1UpcK7U9g4M+u+knravHXb79OJZ7QzYrQS1H7jelwvdh
 8S0iO43w9Ex4smZ5QnexcqDBFf/it8k607ivC2G/d+yvRXUkIQUT2vhE2JLVeL9Q
 e3Qrkep+Mw9bxGtMSUsQZakewp/meaWV2MYMT0DwAAAspcVX+8ENYKJI/JXqkHBQ
 1eYR8zp0z+ZH/rSRewxWkmi/+VFyA0JTDS5b8BSmHXU/bh9Ke3Dje6CkevxIvxUE
 hjd1zk6H9EwrtOHE/r+m0+6i1oGoUmwFpzCLgdaywb1Yn2pL44CyTlPCksDQfYgj
 OHp0WQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfnha3f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:23:22 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d001671a54so3583975ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081001; x=1787685801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=P5i5aH0gpmD4zJRZICkS9IkXGDnC9MuBkhb/gT2wG+rW89maI5gPwyyw6m8R+ykLia
 rV5eU9a4Ob8RA+w9VVAn62+toA3cyd9Z36Eo9X8eh/AxI0Dv4EG29azLqrOk3z+AuS60
 GFxAa9KiVsI29GLUryCtbaXyUN1kspQBijQ57V6rLjkXFVFdrb9u2hqCJZCvleJD19tJ
 MW+ndrO/51rgKnKwfRlx4nZZ4WL5c+D1jebuNiqaaoje1MSS0xcx+iq0atX6rt4ZNTg3
 kU6NZolhwIeMpvQEZLzv7TrN9ksRN2uMCoRjYofYXqSCd7jwjYWDUhYvu/s4ejZ5nSqd
 Kb7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081001; x=1787685801;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hEJ9V7qDjk1xG7hpLKfjAHeMfMNJCcr8KAl3zdNPby0=;
 b=KEfNWtyL60iG2hkc43xHnWSDafPeO7c/Hm1fTF6KpDkfY7FidID41fS3bwnax/ZfXZ
 o72ENGDe5iv0Yp3PrX6QqJ1ZL1bUGxiSdtdG09xjaiNR8ufD3ZFjBK7JeAtcHVOy1DQM
 SEccRUCzx6Zbv7bVEeKGGNT3n5nP19gdmBcm5J+QZry6k/sWZGXg+H+YPBJuGm0fIZ94
 3moG7ZbYvGGCc2rM8fWh9tf4RoTPalP9mBYHbZ1oJKKDbTCSA74E40Yt8qqZcrBH8PmZ
 wHJeZE7et5Ib3sBNVikUYIFb340O4wBpYTuQKuMMWfaDmES+WMcRClHvQCh+sgBx09wX
 t0cA==
X-Gm-Message-State: AOJu0Yw5sytmEZ01x55462HAaIXQBoeAlSiP6Cog1LwrF6pOTRl1hcY8
 lYTud98+Qf3FeFzJgQoJXtjYBRMWZzrSz+G58ojW6YwE7I4SR0MhI+9D9mriC2n12hHHRc5oDox
 oUPwSJ/No0QjH6ir14sn1sA+3xhc8ZEU84Z6cQcyzvfWAzN1wCKSZIVi7dAJHVk3WVQ==
X-Gm-Gg: AR+sD13r4SZzn6u4+F70wd58+c8TzwCrYiXwBXBmMNSIMAhE1401yhLLWfUZMOTPIC7
 20DMpM5m2TFL3zIxwC6sR90ucEsfrqdqv3YL0A1/ARHP3iMngovSmt/GcPJ7m8397u5QDF6sND/
 3yjrE5wRE35uUO+OAG1q4E89TUegu/fOB59HVhmSpJZPZf+S1jbvSmP4RksA7mTKcE50v/7loNs
 cBJgjgqsur0wWQcxRcWfMpGN135EnL8nARJDdJcSOYDxVA48xvPHOa5g2elStlFfZrADQAWvWZT
 3edcxM+jt5pSOTP04YhrI3NfUu2yIwuB/UMINr+jT5ER2CC/SnCMmuaDTeoubWjcMcppiwNzCHu
 lZFf4+8fPHuFJRx8FBC7hFt6HXjC0PGo8uVZE7I+OKQ2TkL0BiazkS31oLaE=
X-Received: by 2002:a17:903:1aa6:b0:2cf:47c4:3d1a with SMTP id
 d9443c01a7336-2d5f6c98655mr803775ad.3.1787081001336; 
 Tue, 18 Aug 2026 12:23:21 -0700 (PDT)
X-Received: by 2002:a17:903:1aa6:b0:2cf:47c4:3d1a with SMTP id
 d9443c01a7336-2d5f6c98655mr802605ad.3.1787081000835; 
 Tue, 18 Aug 2026 12:23:20 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3267c897e37sm21879429eec.28.2026.08.18.12.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:23:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Aniket Sahu <asahu1x@linux.ibm.com>
Subject: [PATCH v7 003/104] tests/tcg/multiarch/plugin: rename
 check-plugin-output to regex-compare
Date: Tue, 18 Aug 2026 19:21:27 +0000
Message-ID: <20260818192309.22169-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXy9gdEvREEATB
 kKN6oSKLee5s9qTRCPVuytgSG/Nf/la+Qkfq2YovmBZC2Yl8/7TZSxRqUwtmUaW2RjmXXrsrJKT
 ZfV9uGaAvFjhbNpUrEVP5aVyXxQ+QPY=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a84b12a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=Fu-9CGv2gRfvjT4HfT8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 0f1Klmwu_MInISW39dRWauqSgEknx4ek
X-Proofpoint-GUID: 0f1Klmwu_MInISW39dRWauqSgEknx4ek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX5pIoFqRHhquM
 VtUDeBwS1PiHAbftOK8FDh33BTGq7WL9msmYurBfM7Mp4O7QCqnRVvrL1JoT1n4BX8Fr9H8DHgB
 3cNyd2pYThvMQnEZOlJzJQ+g1Y43znBcGZTaLlMzkvs6e2wwYCFW1b/LCxPXg9UdiUZszTS00AA
 fFPORH4EsEqjpBiyDZ/4ulhmdZl9zDOlDFk/5RvRYBFH/3VZFqziJlar+FNiABNwmJ9rz/U6cBb
 vP/EHt6yAftH2fYVHZYlUTEOmnjRwSmQ7L/MVTlR0rJF3O5JGywpHnX/kVzEjd1sFer+wfT1zRY
 M2lYw7SmfMgeQlT7gu548AVxKY8YquCGhyHRpYFYPE8nqUWQO+WXAQkdeMyKUJU7NHnkGbWzgzO
 QjwxEO64acyoaERoY4c1OXO02h38k7Vp9QP1ut6TYSvl9JRuCoEMfVnzk0tQGfsichouJ+oasaJ
 I4KZku+6BNtvFpv6ETg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
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

We'll reuse this name later in the series, so change existing script.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/Makefile.target                             | 2 +-
 .../plugin/{check-plugin-output.sh => regex-compare.sh}         | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tests/tcg/multiarch/plugin/{check-plugin-output.sh => regex-compare.sh} (100%)

diff --git a/tests/tcg/multiarch/Makefile.target b/tests/tcg/multiarch/Makefile.target
index 9bcbbb11286..35050acedc9 100644
--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -202,7 +202,7 @@ run-plugin-test-plugin-mem-access-with-libmem.so: \
 	PLUGIN_ARGS=$(COMMA)print-accesses=true
 run-plugin-test-plugin-mem-access-with-libmem.so: \
 	CHECK_PLUGIN_OUTPUT_COMMAND= \
-	$(SRC_PATH)/tests/tcg/multiarch/plugin/check-plugin-output.sh $@.out
+	$(SRC_PATH)/tests/tcg/multiarch/plugin/regex-compare.sh $@.out
 run-plugin-test-plugin-syscall-filter-with-libsyscall.so:
 run-plugin-test-plugin-set-pc-with-libsetpc.so:
 
diff --git a/tests/tcg/multiarch/plugin/check-plugin-output.sh b/tests/tcg/multiarch/plugin/regex-compare.sh
similarity index 100%
rename from tests/tcg/multiarch/plugin/check-plugin-output.sh
rename to tests/tcg/multiarch/plugin/regex-compare.sh
-- 
2.43.0


