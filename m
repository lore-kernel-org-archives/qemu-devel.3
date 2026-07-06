Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E763C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgrxG-00076H-Mt; Mon, 06 Jul 2026 18:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxC-0006T4-06
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:18 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxA-0006oE-Cl
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:17 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE3iP1626296
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PL1tmjXQJaH
 Yi9rntN5Kduzn4R+hBPgU4Jwf2jlR6Pk=; b=pNhtRYe8IlbLEGkoO+QFQDU7rkb
 lhH4P2fo4YYUGC6oMLL0uRqzvFCUsdsfQPFLeP4/4Oo8oJKzPl0PP9j1BzMuurMG
 F41qwRFt/LuDY46py/ckGc6m8jbXbqTcCzZkp9+lvGI5A3xpmmP1EKaC9022xCwD
 R/NBCuKNxNe1D+0kPDky6+OT4CEMb5YtYLPPOhqo2+kbhvXu9VfhF7yWRNP8JhhS
 QEocelboEL+9LGtp/o+04kzXtHp9dx5hWwkhF3mlGwLGx/0Ru9xj9+yTqhlrTxnW
 KeCNXSnk1AqXmmmm5RfiPrdIKrzdULNtUs3LJLuxDPPtFWduDXUemy/aa3w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h9bnkf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso5449948a12.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377494; x=1783982294; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PL1tmjXQJaHYi9rntN5Kduzn4R+hBPgU4Jwf2jlR6Pk=;
 b=PEf17Yo4ZW6RM5s4ZzmY/lReUdROvg6yCc75Av5FmJsMMDMi6S/YkYarljJDlaQ4m+
 6wvNjuBBw4CY33gRaPdc77alceIv6rL2uqWIeYQlk2nOF9A3NuuCWZru7XOlT4gOfjKG
 CcI6rYckcxmwVUy3+XkKlwpt8ESLe3MyspN/HEczLD32C9Ho2+Q19WBijuFMWcQaWfyv
 lZZxsB12EP4vZat3MYLTJeLRHCLCix3WgeKFow68B4Mkah9CAu1ALgbgLnkrr/lnCW//
 4L0UzmcUJtbqkyHtPIy5ut2JBN1U0wKMlOkCqcbeogFs4pWk/7wDJdM71huTfzqEey47
 4bVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377494; x=1783982294;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PL1tmjXQJaHYi9rntN5Kduzn4R+hBPgU4Jwf2jlR6Pk=;
 b=Wf9lr3wEHro0pqCg5O7CMtIe+mNIKdE1kEeV2b8pgHsChXufW7zAoFaN0nyRTXW8Rm
 Gc6xEzUcAcPt9Cx23bwgZKj6KtpEr1UqVzaQjLtYQrXKUj0pM258Nya68rhctHXCj/qx
 4ybaDEjgfqoz5WCqlQYkckMDVoHykg0+78FIJI8YZNo/6lnCj0PuebaSgcyjQv5bgcOu
 V/Z0M38mviZO6wh/MCjzt7DSm0pnIhYZZ74GDyvTCjTUD04qL8FkdJiBTIvhDClfJ4FS
 S6Ng6PzUcWz2t3hCH0GRbnwdbVtJ4EEtepInkFX7ioZTvRtaYacnkhfciL4YCbbrBMtz
 1HPw==
X-Gm-Message-State: AOJu0YyN6mJZYS8yEGD8M6UdHkNjkALbLFiiUCs8ZBp9Jt/2ZOM/eAx5
 KiT7Fm9ZBxRT4HOHLp+DwFKZyzPEaCcMIN/HL2MntjQKV8kC8EkviGxTeCx4PLE+gI8YMm4O4/A
 aS7jtR1/0T+xsxBLCasjDp363Kn9d5Ro1DfFJNoSoqITk5kWArh3V9j7QDvMwH1HQuw==
X-Gm-Gg: AfdE7cnCURSoi2rsQYbMjBOe2RMl6Nk3RDqnDUWhFwLt48B4guntJ+atlMhOeOyZVIO
 iuiucGCY4Qawwae7n0I5Mf4DcmKvEaP2OGDnBOnLjpto42gTYIgIlanIxvUAeFmZuzV6d/sqxOk
 qKTnF45CbwxA24IeAcfiJ/Ysta12NtSsNHUiPUvpDK0Swlb+IlbOSyuLnPUy2GRWOy6udVBEVUy
 chiwqxuyrHoxMYRNQ0stWm/1ACNAZDnSXam3K/f7Bt6nNS+sdqKa3kLsQU3obd4hDgcjOtAatGa
 csLrPRpLhKtfFjOxtx/TF1CgsiBSBYMKQLGdveypCQ5wfID2DK01UiggjND8dzAN85dlk+KQtLe
 XEyRdKZ31fgMLO9aRmJkmmzNfKNepAeIWhwQuxjW4eynJW2Fq3eaY+8RZekBP9nGNUQy1LMrrNg
 JU+dEXMw==
X-Received: by 2002:a05:6a21:e097:b0:3b4:888f:b3f7 with SMTP id
 adf61e73a8af0-3c08eebaaf5mr2872702637.42.1783377494411; 
 Mon, 06 Jul 2026 15:38:14 -0700 (PDT)
X-Received: by 2002:a05:6a21:e097:b0:3b4:888f:b3f7 with SMTP id
 adf61e73a8af0-3c08eebaaf5mr2872675637.42.1783377493947; 
 Mon, 06 Jul 2026 15:38:13 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:13 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 45/91] tests/tcg/multiarch/sha1.c: fix big endian
 implementation
Date: Mon,  6 Jul 2026 15:32:57 -0700
Message-ID: <20260706223343.988769-46-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: p1iCU4CU0JWJm1ZEu-qTdHxxyPONGays
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfXyNqBnxmgrqg3
 j4LE0CSTqeP6CbTIeSMW8PLILQ3sc3caj64uijq+hT4qhMkxVqvrpdhnHXwo6/9fgf0OCMxRUJh
 Qsl+231g+Ko0Bz5mIM6gqV0OeHfzHMs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX6kb5Pt9/GxfJ
 Z8hWRfeNtnhihur1EZMBixZl+/jCrvCDSdSPtfd6DnR9RYsJ4apwJVVB6SvXbdhqcaGTgncMdLZ
 +hAdKyPRelAsxOfvexCl8Nb/yeSvxP4UwBrYXFDedeAd/TTc0608Mojo4dJsRANnZssZsqZdaGk
 hd9JbgB9kW5p5AEG4dywgIFUi+ZQht1zEND5cOotLf4/SsuZL1UCgha1eWQUF6rh41XoCg2SiIn
 /TaPztjq4ZDjuQtr0F1qkiB28HZvsUV1d81j133o5d1M7sy26oLeqxxSCfI0/kCSVMQp6UBFypz
 NVLpZPB/lDpZB9lT6W9rcX8t7ZvCthC0iJrZoNQTAypptQOAv9vk9lcaHUw1c79akkybXNPjqe4
 kGemu8v7Ia6gAhlO1wDC6Bw9cURLVD99ml4XA4KyTIuxB9SxJ8fKgH6cnz7MOkk7IyMKhr+tECy
 hvQHTjgLW96+Dl+ttlA==
X-Proofpoint-GUID: p1iCU4CU0JWJm1ZEu-qTdHxxyPONGays
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4c2e57 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=0eg9nERfSt1gVPs494UA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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


