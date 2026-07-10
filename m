Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DC0C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:47:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiJ27-0006E0-I5; Fri, 10 Jul 2026 17:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ22-0005ms-Il
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiJ20-0003cF-GB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 17:45:13 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AK3Z7l1752949
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=; b=M8ePrbpTzlEzucYr
 uhA51u0vJ3LnPYFoGnUyu94+11rqP4Z7XwJNCOpNgFC/LLW1IuM0izSxxT5UPPKY
 5fWukah5JxGjvhq0E/aH8vMw49fbFVJ0iPrYUIqTzxfZjBrYgggcWvXGro6gY+F4
 8m4Fmbb3r1IjDSwyhMGsOWKXLtXPo//R1Kz+UKynHt5lEXtQmKxCRzZz4wwm9OYi
 lFRdQZPXSPDLVA8ogxPCX17XfBVyPbGws2QOVUwNjJzs05k6ynyHnk2MY3T64Elm
 QjVPqRAtlQvbyOlKkWpl6NmPUZC+eJG3pyx4HZSQYlVs+cknDJvCc0OZlZrSUwKa
 /sgAzw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb2pc9gmb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 21:44:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ccafc5e82cso13575345ad.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783719899; x=1784324699; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=BH6jgjheZ5QhEgOVaT/e3o2r5Y++9hNVa0jzQpEZuaT8LeGmscMwAyYB9fkEstdCMD
 e7FXVGfZx6kMXJ2cWbcuGZ4Ge5OUdH10erKuRp40F1k3myA0AqcfeuD6RstW33f32gSb
 ag1jVRM0e7h0+Gj0kphrP9Y7Mky1KWyLsaYjd4sSyWai6RtRaYi5y1dpChh91AH1o5mD
 TGTogkJX9hfq6VZVOVjP1xrt0xnV4bp0oOuEr5mfA3KVR1z12ocRz4zHg8S18ClISmdU
 lHuL1xHcL8wvlbv7fvmtK8jcfQYDJrnTq3wf1uW/190042kUwbKyLzPXb5k4HuQNyKYB
 y2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783719899; x=1784324699;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/HW2umT7ZcCx0QfTnRS0HUUGWGI83sT6JleEDXAdh+8=;
 b=qBWcAgZZxYHYzy1SQR3oB93oOGHZLtU8IfAAVYvzFTqHE7f7GkUF5LXszvq81+Aft1
 DEWvbcQrj3Aw1HCpLaJhBpvadGq95Ckr7bjfV20TpK54w58olnkNNIzv053aLD9gi3iU
 e6H80Ruu2EjIbqQwDCGZsWT0CJ/YPiG7C2Uem0xZzD9rhxXDwuhayal60s2FMtz3Zdh0
 TahnTGolvOISv7IVtbNtQmHwZjBOfm9wqrMPFuO3hxQKSrqR5wODiS9IW3ChN9gniFs3
 UlFi7JTeAerxJsqi0XwhhiieMLXNsTwNleLFN1rYvMZ7AjxdJX8+4GpBK4Q3ymuE0Ngu
 rc4g==
X-Gm-Message-State: AOJu0YypYC0I/nQSS34YnjVKZHqFxRqNoVUujxj4wT02BeAy6hMDtbWL
 QpHFSC4UvxkO5zPLKQQ4KjcLDfZOYchvcXYefhcYsWqZLQMS5BYCafvjj2I8FfhAHDdlmwgjYg+
 gnVCHfGjJR1VQdhV7vZGq1mdrVGmiJgPNZ4JTV/+A3Epc+jQt4bSG5F3SzxeA3fOCDA==
X-Gm-Gg: AfdE7clHTehoqksfxRfBcRjG1K7ZIAk3gPWZfn6xO+5re5RU7p4hx/wFPpQSNgc7fsV
 e7WQc5zQmUbUDkFOTn+VUbLy7yRi+/3sVSRcfzNQoQCPubg0RYzlFT912Kb89/0Jsy3egxdUQns
 Z2Xcpl/JQTrK1yeHRbXIqwMpa2kClDqY10zJdhObHlm65r7FERyPROpWBvsPGYi6U/DQ20L7mS8
 mzvLqI02iz4b8BFPMncbo4aXmDlPUwlHAx3tqNRqUwlZnlP7Gi8MHOdAfax3DWYgWE1L4in0ssp
 dUZ9xnAu/AA+yGVcNEHEqYXLc0GJ5lhLmOY/wBNlhVnGcRY1qcPG0JUU3f53wBv2ET187/WPCls
 97K0r045XOPm4WqQphUyst+I0Jc9dv9noF55fRq/iXCgnP7u2N0DAWED5OHYq9JQKomEaAMuGhy
 t0TZJE3Q==
X-Received: by 2002:a05:6a21:398e:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3c110b15bd6mr711156637.37.1783719898798; 
 Fri, 10 Jul 2026 14:44:58 -0700 (PDT)
X-Received: by 2002:a05:6a21:398e:b0:39f:59c8:f302 with SMTP id
 adf61e73a8af0-3c110b15bd6mr711121637.37.1783719898372; 
 Fri, 10 Jul 2026 14:44:58 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm43539840c88.10.2026.07.10.14.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 14:44:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
Subject: [PATCH v5 39/98] tests/tcg/aarch64/system/gpc-test.c: remove unused
 variables
Date: Fri, 10 Jul 2026 14:42:43 -0700
Message-ID: <20260710214343.2065491-40-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfXwnB0UHFQELXA
 FKNUOfktjTwKKq+QHLE7WY/xQbvWtjbeh1Q9CCUJZcyxp+QIPV0FjnVdhzCHa1flG92yjoLDGk0
 IAwId1zJ9nLYcRt89KSrmOMZ8nUQaKCr7KTN9Xaa+o6tY1ryp7YldRcZG7ryiYGENLLLxhFBFFk
 wTSgyAsp9tHuQC899Rixh4bRKoHuvUnUFm0NOZLiGvInI/2spCpLyPSTIkV7ibajdthJqdp+kYF
 gXEwrN3F8SHzouVASemw6UX/8A35DsK1Vs3ksAVHe0LJsJhz1VbLEaABOfwrjN//ZsoGBRqSwc9
 T2SyZ5fcfpLAVteoaZOD6B7JrmwsXC4s6O3xD6UghunLLGPWMwrT+AkILmqWQypcVDMCE7/O3CJ
 YoJ5YTyjXRr6PNxgvVUIwgAacE2Wsa1/Kb59/IiuEd7Eng+8S4GhJgGexie40Dzxy7DtNOxP6Dr
 e+65ovX6bl2Nset9Aow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxOCBTYWx0ZWRfX93SJrET3+rEu
 951p7il4K/t318wSMc2IDZm9AZ3x8esYDC7wkP2dWw7/rbSE4r4SefHYPBWDF0jYFQE+xXVlsrS
 vkeQx8fvg6hJGeQQRMVM4MaypMNuD7Y=
X-Proofpoint-ORIG-GUID: W2MDtAr9NckCaOUEL_zclwqGXwa7tIdL
X-Authority-Analysis: v=2.4 cv=J9SaKgnS c=1 sm=1 tr=0 ts=6a5167db cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=4Gh5T0g__NNyS1BPEC0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: W2MDtAr9NckCaOUEL_zclwqGXwa7tIdL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607100218
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

Tested-by: Alex Bennée <alex.bennee@linaro.org>
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
2.47.3


