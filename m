Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156FFC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 06:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi4fq-0007Z5-Q2; Fri, 10 Jul 2026 02:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fo-0007Vn-Ly
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wi4fn-0005kU-7K
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 02:25:20 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66A3nUnF3848866
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=; b=jgePkemoIQ6tBvY4
 aCcZXXLdeeFvHMgBMwqVWK0+QHn802OOCBt6RHfGp4eyhWMllFWpOp554KPgTlet
 x2XqHZGkjIvDYzc1hQkZ8ZV5EKAjk3qx4kPdK3kSf/yWm/GmNU9Q0vNlrh9uRYs+
 W8MJrlAHAvWh82jl+5RwgsvA0L2TA/qh6EhBVpCeuZUpf09M6siKrefr0+HLALIp
 wC8NB1xTICzI7nv2AHlZ2TsAuhWJ0wj91fIRNyGzOorZ71/1qLovF4EqZiHzgAZo
 qtDP4+Q7aKRcLys2gTBDdaGZcaADCMHIl44cErOw7DWO/rLJ9u6B9K7eRxr7qb/b
 Gzkwtg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4faeesu2wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:25:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-ca124bf0189so1237344a12.0
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 23:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783664717; x=1784269517; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=SbOnDtdc61WbjIoihDb7XLXad0NxfcViMPAG8dXElMtlJ1ppeFM/Bpqr9anr7Ke63G
 mPXNTQu5lPhpZOpm/Fmg0QLosypi3NPjMryuXIlPDJcxEg4JHnaL1sXLEQE134pJDSQe
 IzQk7FGWuRR/PGkhMiPzsH4gtbH9oFkCH6dgdBeYn7zK0B08kWjSs7nfDClcM/e5HD3l
 KRj8za+KdsrEHsGjnyW/m6UI7f4l5EnK/7cqOKmlwtfPU4tH9Jnrk90Cu6fKogkdq2fP
 W2zefKXJnbffxLNrQj0ptdqnzsm3kH5rFoCThCDKuz24QVSNma12Y8uCMMVKZXPXZh1Q
 UgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783664717; x=1784269517;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kSGwiMRYDcRmg6ozYAQgmtSI9aq9HO9mUGyA7RaMKw0=;
 b=L36ymsp2Eww3yeTccudKh0SViXL038VQ6iS4G/52AnibN4Y48XkgtaMSh4suU5r7hO
 pC/GdbmhE7creQFsvngzZNui2DvjgzNx5LGx42Ey+0Oqln8QMAwU373IXCtvLvWjW1wl
 PRet6s6nUvFrX19F4iD1YrNeRq22E5NlstWE7rHut0m311ohefBE+DxH8A6H1p74qSoO
 j8wmkQJ0fJquary0U61XvPy4Z41/hNhubDUJijXi3D6a6uqkVG/dC4iwMCmznto2r65k
 tMeaWb3y7kctNmBoa2Ao/7/rPDtHRGlHLAiX3opE/zSfTVFOVJRZU5pmioL1V9V4+EOj
 Vl6g==
X-Gm-Message-State: AOJu0Ywokm3lFrFbYY3D1VVXimj62IeXjukPeiiBsnrkMtKpQ7WIZjv0
 IIjAxDS8Nj0KP1lfa2WdO0fiPglUhGTxTzx937D/bXfSyXXwyWTfUUid8sHkPBNtDXARwU//NE4
 FlHuHLZDI1m+ES154uBiSi9nLXxummyzOoB4X4Hyqfr7flaotS1dizzrhIy0GFk9bsg==
X-Gm-Gg: AfdE7cldoswB3KdlBD2DH9wsbvo95NBXDkY8a5RMJlu2uxXnUK4HXZhb8SncH4s/g1a
 /K2dwSJT5x5jaEMS/iM4TWwkPau/ERY+HUrKPBseVaaxVwAfGa/leK1WHHngcpt/Agf5j3QP427
 3ArNeVyNOsixQ4yJ8iI26W+hBP3GCzOGVNZK+H/W8UnIALHrXQxmxW5nF8+fahmb+S2+0EXjq6+
 wrsQx7JOyMPoRYlsiUmuhswxG5i12xqJehxSUk3H1j5YyMnzzzGEROOFyicQ8wg5o2j8SIF1MAi
 wZn33mBhURHLgaKann4ebj708zhvKuG7BFRdYkxhgAnd9csbGDDGQzYUcrtOH9wTpxcr+nVfQG9
 1o2RpAPFT4JcNWqvvVKuG31vzD1cTt4Ak2Awli5tzw85zCBPjAS310Jl/PvSTgZ10AVkKilacvJ
 2Et0l4RA==
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr2873286637.5.1783664717116; 
 Thu, 09 Jul 2026 23:25:17 -0700 (PDT)
X-Received: by 2002:a05:6a21:4516:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3c0f085a7fcmr2873240637.5.1783664716664; 
 Thu, 09 Jul 2026 23:25:16 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b6593c4ddsm40606060c88.1.2026.07.09.23.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 23:25:15 -0700 (PDT)
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
Subject: [PATCH v4 48/97] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Thu,  9 Jul 2026 23:19:26 -0700
Message-ID: <20260710062016.1818125-49-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260710062016.1818125-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 4p2r3iqBbSjrOBTIa-zVqC-dE7NPePPd
X-Authority-Analysis: v=2.4 cv=bbpbluPB c=1 sm=1 tr=0 ts=6a50904e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0eg9nERfSt1gVPs494UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX2YKmZuP/S9nq
 UbSBnHhk+U8C3Itww8lmoGnzF0LjlcsRQUsA/IKC+wlvmtJoC+KhOWghwVeoSnrn6C678rERj8m
 dMhM6gIQWk7E5Gon01Ry3HManbsY3bY=
X-Proofpoint-ORIG-GUID: 4p2r3iqBbSjrOBTIa-zVqC-dE7NPePPd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA1OSBTYWx0ZWRfX3lBrtIe3feXf
 xcjZJLBSYIp28s5avcBhZivGfn8Al7srWZIp8s1vwo7koyYI7J3U7BKJ4nS/TFDNhkLFQ6ezO85
 tb6k4oqIA5q5IjcWk8R6zF7TBUFXIDOgHQLaZBaYyG/LujFk+rT7qWkMqzQ8xRBZ21U0R+Bfkpl
 r6VnAJw7jjnbe9mLzcjxR1DhxEmPN5tc6PoF3sJRcu5HSvHieQfNScHMhLO//SyGXljaciNEX2z
 BP5MSHdDVOD7iBfKSezhcz8+dYexF3TO7P1UXW27O+G2bhz8nkWbEq0N6NN+852HPSa9UgmlGis
 aK5DM+uAPcq7zcwHWURGpMrgZhqXWUCdYLWuqPumkzg6vi/pLvg5j/uqcO5LhwQHuaM3i/I61d8
 eOxjAOWSeI20b3ruQ8yIyfAvDSdMyeixiu7lkl6C0mHFqb7GYBu03KF1RW71+e+ZqF6KSutzoy1
 ZG9yligapj9eA0Da4zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_01,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100059
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

All big endian targets were returning a wrong value due to this.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/sha1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/tcg/multiarch/sha1.c b/tests/tcg/multiarch/sha1.c
index 0081bd76577..6cebad2951d 100644
--- a/tests/tcg/multiarch/sha1.c
+++ b/tests/tcg/multiarch/sha1.c
@@ -48,10 +48,10 @@ void SHA1Final(unsigned char digest[20], SHA1_CTX* context);
 
 /* blk0() and blk() perform the initial expand. */
 /* I got the idea of expanding during the round function from SSLeay */
-#if BYTE_ORDER == LITTLE_ENDIAN
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
 #define blk0(i) (block->l[i] = (rol(block->l[i],24)&0xFF00FF00) \
     |(rol(block->l[i],8)&0x00FF00FF))
-#elif BYTE_ORDER == BIG_ENDIAN
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 #define blk0(i) block->l[i]
 #else
 #error "Endianness not defined!"
-- 
2.47.3


