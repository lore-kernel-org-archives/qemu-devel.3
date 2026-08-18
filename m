Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DA4C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 19:28:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwPTS-0002yY-9t; Tue, 18 Aug 2026 15:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTP-0002Y5-NL
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwPTN-0007Ow-VQ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 15:27:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IHH11N1549043
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OvJPGWqM1Pe400O9Og3SNJe7yXJCk52GtqcZMjQIbCk=; b=njwgJtHoJXOLsShM
 gxkQiUhzoiLmW+DKUUi7SR/jDla4gGCRtWKOvOmN2Obp2a3mm1hSfNQOv+beTAtG
 XwPeqaqTtjRK64/NXxeHP3yfE5xQSUCgOtwTnWXnEabY7AMnRtVa5FUzkmXfGrqO
 iy3PAqQuwpI5dqVIR61ssjyEwfjmkYlaJs0scngyO3xJ6NK5Xl7GhOAsxjXaMi0f
 OJrP3xuPz9+BNiLxFvoJEz03upBz7+A4TCcSwyYVD/QebWaRfDSF7IkdNCEbE4MC
 gJyNaLdFBHVol3U/sE+2nGdfMZpS98e+Xp7QcA+DMYx4OkYVrj2IFU63WwdWDYJr
 HS+wSw==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4uj1gps5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 19:27:44 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-84f7002f9afso219437b3a.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787081264; x=1787686064; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OvJPGWqM1Pe400O9Og3SNJe7yXJCk52GtqcZMjQIbCk=;
 b=ZyQfrrGKGiaF1qQUEQE9W3JqqDmQl2XEfznXroW98dR3+y2q1JP5Qg5vH9cY63qzZS
 DGjDMgn12z9NgQQ366koyy3Cx/jlbKeqzP8dywcYrQ30x35lwxN8pFz/SwYDCuZ1WKmP
 MEOSfJ1yLl7IxShg+e0XJvc2egxFf73CA172y+NbkBx/wCsLRQ9vsHy15MrVDQGBDvND
 y4KKQvM4+eniIwJ+yHbAR02S0pqVMSiRKy7UT/ko18/bPcW+MIpyvLnHX69V34vKNhLo
 DV0YuByyA2pO/fcIetExiyuzXhA2a+aLuSTlqL9zs7XWKP+0vp5MA3XfVwjaDkCCywaw
 BQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787081264; x=1787686064;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OvJPGWqM1Pe400O9Og3SNJe7yXJCk52GtqcZMjQIbCk=;
 b=TfGZi2X2tIv9RfkLCHDhOnsG26D56hhqDelgShJN/FZN3RxSyakqXeA4P+QhxVQ/EN
 KlbcDaVecDxRbcMJZ+QmuHhGz477qArVFokxXli0d+I8uNxkh/rW9Zyvz09VTZuDc/LT
 dJrsYNc2cw6ekyFOuZc0rI4EHDwU2MDM24jKkobSWLwhTf6dpbdGFSp4SbSzlicyl3lw
 Ir0Ka50dmPvTQW5xXK1oX64m3N5949VaCDV0nowijstRRbKFDddCNJ4vP9ysKbQVuniv
 h25PPZTpVngzCgfZ4iqHRO62J1zcpqHhPPmPbE7RGYooookdHT2131esGzt3w5Uy8g2M
 o4iA==
X-Gm-Message-State: AOJu0YyFPj6xfK0ZrWIo5DCtWG713yWX5EBBASu4YbfjVr3vZ24IowLZ
 ZpUmJ/ppb6VncI9ycELLZ5Qe4PrFk3ary1+/YCG+RxHNCk/fGZ4aqn+J4IBbAkZB0dBXDFBPKjz
 12E080SifeEyvlxAd5V6txuUvxtbmmW74vbdb0lKuHCsqbD228e4we01fs0VYi7MZhg==
X-Gm-Gg: AR+sD12EkXJoPEqpUo1turFjX6l9s7IzbxmPRJv3c0ci/ga+xW+HexMewv8o4y7Xl+s
 trVN2E1n9XY5rdmgD18ypqFyx5Qxw5jPuT6fQDZrGv12nccnWiRdsz2aq5k3RSqdGcAhGKZnk5z
 z4/cD8wiO+5DuxvX9ll+hVPwNBQQhtPsYfzpniZM+4aW8th4Sg6gz0v1kgMTiBAG+d1gfL8TuKs
 FHH4Ka50nRhxqmh/1s0w7QQsr3t1xvFnENan/eqDlecb9nGcNkbkUmLt/oH940RgqVdcNXPV26G
 EAcyj3X49Niv/HKhpVEtkhHiezQZUw2FK3rgpltirz8w0vfEqMaR3hFI5h+3UD1BVgi5wkHA6p5
 MBFgRAUaahNo7KIM3mxfxNnVqDGXO8T9tp9ifJjbY7aTHxbGPKZHvVMtTY3o=
X-Received: by 2002:a05:6a21:3382:b0:3cb:c1f8:5722 with SMTP id
 adf61e73a8af0-3ccfef7b66emr226552637.10.1787081263817; 
 Tue, 18 Aug 2026 12:27:43 -0700 (PDT)
X-Received: by 2002:a05:6a21:3382:b0:3cb:c1f8:5722 with SMTP id
 adf61e73a8af0-3ccfef7b66emr226476637.10.1787081263381; 
 Tue, 18 Aug 2026 12:27:43 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-326794c0c94sm36782451eec.9.2026.08.18.12.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 12:27:42 -0700 (PDT)
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
Subject: [PATCH v7 041/104] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Tue, 18 Aug 2026 19:22:05 +0000
Message-ID: <20260818192309.22169-42-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I6oUh-PX6rafQzUooRMnPN1h9ONff9Va
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfXyPXVIMsXaAob
 tEgfjKBEn6DjkoqrTTZeUt9rccJZBegPThyGH9IcvvlIiEKRIYbWwZerCQ8S0DIUm3C8ea6afy7
 xOOyjvykmdZlXOLl0Tc+g9Ro2MzBVtU=
X-Proofpoint-ORIG-GUID: I6oUh-PX6rafQzUooRMnPN1h9ONff9Va
X-Authority-Analysis: v=2.4 cv=VNLtWdPX c=1 sm=1 tr=0 ts=6a84b230 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=EHQcJYNh60CgIu77JDAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0MiBTYWx0ZWRfX4Vlty2ThogPf
 P6DNupMBsl93Z+BVltbqau4M1eQrOrGkGatVM6RNIKFuTfOYQf5Fi8GNkFf7JXbfPmhyYWpCO26
 5C9Zx4wOo0TJpuVWcXJboqbcoo7gVfcNHPyH2HaUkNyxCDrzPA+4CBToBh/KXNXNy8yxGc1n+/6
 XDUZ65PSaFBRhQLx2k7UrjhmAnr8J2bKCJtlXSmWfDamPS55LQXBpa8ts659WBolU//JdIRTVDf
 aXsrRu5Ov0X18Fmcfui/0BJDSQNtQqd6bKnpUmYmI3cgU2aeoW5ptDrq3l91SP7tjQY+/xqrsk8
 6k1ucixC1tTdsNosYiELugLnn3P4Lzple9LLmMhZuWFjCMuSF35iDTj+J6BQFvDl9BjRSu9DaEt
 q4RHNQgBJY9WIU1FBAyRO1hULjxh6or4RkEOq35Up0deHW17ouc23ONes5oAXm9dLzzCZD61p9G
 L9Up3kViCpdEK3hpp1g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180142
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/aarch64/system/gpc-test.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/tcg/aarch64/system/gpc-test.c b/tests/tcg/aarch64/system/gpc-test.c
index f26b23efafe..0ce0ffea277 100644
--- a/tests/tcg/aarch64/system/gpc-test.c
+++ b/tests/tcg/aarch64/system/gpc-test.c
@@ -28,7 +28,6 @@ const uint32_t gpis_per_64_bits = 16;
 
 int main(uint64_t sp)
 {
-    uint64_t out;
     uint64_t pfr0;
     uint64_t gpt_base;
     uint64_t rme_status;
@@ -38,10 +37,6 @@ int main(uint64_t sp)
     uint64_t gpt_table0_addr = (uint64_t) realms_gpt0;
     uint64_t gpt_table1_addr = (uint64_t) realms_gpt1;
 
-    /* Mask is FNG1, FNG0, and A2 */
-    const uint64_t feature_mask = (1ULL << 18 | 1ULL << 17 | 1ULL << 16);
-    const uint64_t in = feature_mask;
-
     get_sys_reg("CurrentEL", currentel_raw);
     currentel = (currentel_raw >> 2) & 0x3;
 
-- 
2.43.0


