Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB5CD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:35:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZVoU-0001LM-Me; Tue, 16 Jun 2026 11:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoR-0001Jc-AT
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZVoP-0004ue-Q8
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 11:34:51 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GDxbd7769696
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Rv29csQEZH85cVfCfb9eY61DceKcy2/QKf0FeFbH1qE=; b=p61+Uabe1rTYRdzW
 N2h5K2X4MRPaePmcjOZ5Qr1FrzXyLAZDmDFL21oc3/v2lwVtxM8+VTbAkrzCuEUV
 v/QRMYRoon09a7MOYFYq/DrPaMzr05/RRRSm1v0Sad4U25orqjio5UYbJAvn1z3e
 WLk433OUVZmcwbKRxbOPjomD+jeuE7z/2NU1/F5zhc7RmNEdAlk9xicT7t5trohI
 uONCmKi3Y2WqzX5skjAyj9PefVCbKmPwPBS904HrErxFB0jHG1iLxgpoHH1xiE6h
 5xZVaI4pNmzlLJItZ2znWYl/8D1+89OpmoZ2MKWN8DVu7CdmKNVUSH5yj2T1cNOQ
 lgPQXQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eu2xs9ynk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 15:34:47 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6c6dc39a6afso2024685137.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 08:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781624086; x=1782228886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rv29csQEZH85cVfCfb9eY61DceKcy2/QKf0FeFbH1qE=;
 b=EVbQM7GCK+Pg5czwhvEoi4+wrwI9kTeZqqJs51rsQrsPwK3Z0M2uTF3rX0e79xhPZq
 kffr16N/lXgkROEpxQdQyEWtsDrvJ/OtO094Anh3AtRYxuonueWr835wWEY+V7Ry0YQZ
 iVF+JEO9YwXXIYusd3wJcUSFwIiPdDpiwomS8Q3hGqcm5Ewx5wGaP96MWir408/X5/M5
 QMhyP9GyQ9/Vu6/GlBceBN4Vbif1GGyO5UDrRgnQ50dLCNjTctC+NrYQ0mDKEIJ4o0hg
 zd07fhcvLObcRN8nV9dDnqhUXyl4MNOdcyK3js2NNpsGWl37JfbVEK3TrwvUOvXhfOGA
 EOGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781624086; x=1782228886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rv29csQEZH85cVfCfb9eY61DceKcy2/QKf0FeFbH1qE=;
 b=qo8dSCNI+q6npLUn15z3AO8agHj/JZeXgTMVT/9ywwdctnXDgXTjXJvqC+67ld1y8m
 I/9f1FekXWWtT7bYt9IkJOX+1na2c6sS/Y0CTk1up/0U6yuMEezZqCkwDEppkT6/SyVK
 PgvusUVOZWKAi1CB2x2a2KLLGkKIFa95dQ0jeFPpWf++A0G6wWhNLpeN65MXJ7P8SRTQ
 teCdiiC/LVIfOaonRrX9PGF89Tlu4nEidl0jEiOrMMBBIPvjOuj83oI1vHWNjqREYXUL
 o7rMXT8CH1dFLfIND0gT7S6UyYiGMaPEIr/7GKE/fgnuSqKOUbV8HufWCIJrjXFIsrTR
 6dfQ==
X-Gm-Message-State: AOJu0YwjQaLfu0lEXw4fTtVazkauMKjYmZc4iA2ag3aE3d3ESoRV+YJO
 bhvSCXbXCKyFC7Oiy0yYWeeJ4J+ium3SQGXOOl3mk/1Dv35aqyqkdtoIkx/ZYUCRVYO3R5mwYee
 JrOn0OhjbKrO3ixBaX9+19hK9Z9/YN0icD72sKr6qSuzB98Tv8oMnL7I0zMfnum0/cg==
X-Gm-Gg: Acq92OELarlzyG66D3HO/cJq+P8K0ihRg9DaLkpkIjvxuwtcY93QBkLy18Ydwk3X+3X
 aGLRj0YCf/bqsjTYuohvfM4M6tc6KfSi/BwTst9M7BZPTTYLu2pcEf3rUz66EF1IUORXrORFQcy
 dCfBD8n0N9+kC7PD2B2q0u65wKGaee1bFO8HeCZ+64cBKAtIybWBtkMV7xNN1qEQ2nJRsQDSS7v
 Wsl4acFvK960o/qTa6HvuoHkGaoeyk5/YpRXHsrAe1Y1M/uYjKh1+d6eW5ZMcs+4A3vYDT1XWqG
 7n9/y8hRNQeu13mgTlXO9FhJ2i5y6v10GMCkCvWX7pGHzdubxQWLm6humgvFk3hSI0bKLZMmHn7
 E/PFOrHmhzBafEXIWGHsLpJPu5tdxGZmSvZZhJS6OInqrlilu+0ggRGIDMAEsF+zJ46aMiXemMH
 ALdz4=
X-Received: by 2002:a05:6102:3e1a:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-71f60c24a5amr8535448137.20.1781624081709; 
 Tue, 16 Jun 2026 08:34:41 -0700 (PDT)
X-Received: by 2002:a05:6102:3e1a:b0:6a2:cf9a:9221 with SMTP id
 ada2fe7eead31-71f60c24a5amr8535377137.20.1781624081261; 
 Tue, 16 Jun 2026 08:34:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a58fddsm69670755e9.8.2026.06.16.08.34.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jun 2026 08:34:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 1/5] tcg: Include missing 'qemu/bitops.h' header in
 tcg-gvec-desc.h
Date: Tue, 16 Jun 2026 17:34:27 +0200
Message-ID: <20260616153432.92939-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616153432.92939-1-philmd@oss.qualcomm.com>
References: <20260616153432.92939-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: yyyfsQFLj22JHdRD2lDMj6jqSbdJDACK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfX3tCnQ4S1wgt6
 MYLoKiNKDr7bjWAkfGzBOwSywvTcLMi/knVur9USXEWG1AuT+uIu4THfE1TT63EvSS2WN+d0ifD
 gcgB6ksQ5eG8T3VAwei4emoZnDt1ggcoxGSaMdu3v8dBLxcDXoGF2ymSTjVK0lvqMuXfQBSLVWy
 5xp3dVQRKpf2YDf+xUgNc4s90rG9EkxKYFcAPmJ5Paih0p+vz3NM/ANvOWrcsoWzys3KoD48t1D
 njBJaZLG22uyei8ZCmHPU1lhYNQb3+HU6v/7r6W84f7tjHMHyBkL3OaV8KCmwskacl9y/7prIV5
 m3qkdvbrIGo3m/eLMGSKEcOsg9XXlvyGkONCGOuaU4ADYkoiwxMHzDZflxr8UG+7Fmh6isYfhe0
 d16emOh6XVAUxl5oKaQeqP2N4SiRQ4O7VcA5U2+1alY9+ztlf0tEc8TO3bjJiRDMMad8k9nNsAs
 r/ZyTs/N+CDWBguqLTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDE1OSBTYWx0ZWRfXzF0YjI+dFDam
 1EMi03ILv2PPDHkqK6xWtuuwVPsyTYL9oAeW4YRRznFDqpNEZc5r7qW8NQ+P0rH2xZ7SjW713Br
 AILljrIIGoWddKBfL922ZAfR824QH2w=
X-Authority-Analysis: v=2.4 cv=MdJcfZ/f c=1 sm=1 tr=0 ts=6a316d17 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=qZliQKhbN-6Z782_CFEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=zZCYzV9kfG8A:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-GUID: yyyfsQFLj22JHdRD2lDMj6jqSbdJDACK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160159
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Include the missing 'qemu/bitops.h' header to avoid when refactoring
unrelated headers:

  In file included from target/arm/internals.h:34:
  include/tcg/tcg-gvec-desc.h:48:12: error: call to undeclared function 'extract32'
     48 |     return extract32(desc, SIMD_MAXSZ_SHIFT, SIMD_MAXSZ_BITS) * 8 + 8;
        |            ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/tcg/tcg-gvec-desc.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/tcg/tcg-gvec-desc.h b/include/tcg/tcg-gvec-desc.h
index 704bd864549..94c7d14b264 100644
--- a/include/tcg/tcg-gvec-desc.h
+++ b/include/tcg/tcg-gvec-desc.h
@@ -20,6 +20,8 @@
 #ifndef TCG_TCG_GVEC_DESC_H
 #define TCG_TCG_GVEC_DESC_H
 
+#include "qemu/bitops.h"
+
 /*
  * This configuration allows MAXSZ to represent 2048 bytes, and
  * OPRSZ to match MAXSZ, or represent the smaller values 8, 16, or 32.
-- 
2.53.0


