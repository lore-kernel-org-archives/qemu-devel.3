Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C99606A881
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bDQLAXP/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aWMDARNW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtt9-0000Ml-6c; Fri, 13 Nov 2026 11:12:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtt7-0000Jq-GT
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:29 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtt6-0007ye-1T
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:29 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFQtvl1075626
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FUQZj0L9xwuSZUdfW7nBBmtLlTWZEQ1vLGqSJ5HS6dI=; b=bDQLAXP/9eRJgnBB
 ILkkcQrlvRWQpdFE2KwEYF+/vefeQ252gy1VsgW5KYAoInkButI9MU1XVGCiE8uK
 lN2KEzQX76cqgpXhhmLWY4QglaDB/9XnlHt2OO244PT88tvxHyiq9PhIJ+Wb20n3
 gB0P8Exyu5PK6v7G43CaOGEOYSJdQGI0u3Kas82dOVK2utFyS4fJXc8UrXSeW3Qs
 hEJ+9fLSMkO2QOCkSWGOfusINlz0u3Yc6a7ESrPa5fcQsQms0jWa0fyUr29aahZr
 NQFkMLsMxf92vpKSYor/TA8B0+k5Y+i3CSyKJWLM1P3lK9+U4BmFAzsnFd2yTT8S
 y/IdIw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwh0amhne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:26 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-99081ea787eso387948241.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586346; x=1795191146; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FUQZj0L9xwuSZUdfW7nBBmtLlTWZEQ1vLGqSJ5HS6dI=;
 b=aWMDARNWtidz/5P0F9a8l5wwQ4x8lkuGL6OeigOs41PCBSiuRIZHkCugBLLJXXXVjA
 Cd2nh5/E2vN0lsgmNr3wtYgaxfczpw5HhMM6ISuErCD775PyiwxcX8RMPOV96le6wMhc
 hmlkuzVKHY0CH3Ea/6m4b9TKhY+EuMkQvjqGifH6EyeUZVUX8OyKlubzBOWKvbl4Jsy/
 6XlWX4v/OIiFBntP74RXH2bMgC0cdKaPC5b6vgDQfY0qi7ATl7VXWq9HYQuIF1WyLStE
 oPSxuLIrVQzDPQ/Wql0U85I71HQp6hTfDaKFgq4RgkCFKY3sitgW6bqecNLOaTuR+vnf
 iXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586346; x=1795191146;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FUQZj0L9xwuSZUdfW7nBBmtLlTWZEQ1vLGqSJ5HS6dI=;
 b=pte7ZTF4uPZlmNUtqiMns/Vu+/iIFcZH03iDW4T6GUhziEHAPWkURbq8EyNGHEQPJq
 BPoSZml/VmsUphLPa6q+Dutdt9oriv2ihu/KbJrStAjetLyW2BEDGl7RsdD4/d8ocha4
 e2Nguz1JHnb3KmiHAGvaQQRuh8/IJ9D5Xv9O9tvJOt1mY941TuUJ4/6ZHuV3dbNfJYqh
 DEdaS8xR61Vhgl7Xj78c/zn4M3v+VUYzkKqAIBeUqzzhngyBQvdAwguIcz0qOhJMMkGh
 /NRitN+4vJuRtMPoiQxdhIgIv3FyeYcHd5BLVdvvVGT4kgqf+KlrB4PHn+6X82qYTdmh
 07ew==
X-Gm-Message-State: APuU4Z9pjyW+1JBkm9EhU/b6rjjoa+tshu8eiclhk1G36tTn85ESf0kv
 8RI3mFjwdWJppt8KJy5xX5doX8hJTF4aCGbAAkihwFWVW7wc4IMYeQOui9M7ZsuIZszlErcqeix
 P4fVz4pZ52YD/NIjA06NJHQtw6XqeetsAWAOezul0aufuVdF7U7DxSgDRFVOU+HYIiHXr
X-Gm-Gg: AYBFou2AHodliSKyDA8VT9sDKOT5hEvv0ynmfFmsWLsd9OK1Vc3lx5G9ylulzaDvS2X
 J38kizin3wH+TFNKIm5ylycZqgzR+i3NvHpTcy9ly9SLzUtPJKlre5b4db9TjKEGR09Y2gBVSQT
 da10Me8BzADtvezPo4ANaPTEPkULF5+YxOXilJmMlzswDMC0QpNfiNT0JWSxamkp+lLkbuDAzbT
 k7F3wAg4mZC2ujg/gNE+6qavqNxXN1Xk6T8zN/T/KiAwSwqXRfjsNPVcVGa1+hgtgK9SK+zySyB
 ucw4E+MTnw+X2vXEeG1iLBbpAMLtL2RWh69BHEqHZc7C+c85Phu4sNm4lwZv2NkovX+mO5QQGgr
 8beYKVWiktx6qGKTzzElf+5DdDT0BExS7LMqZe/3xXGxDMtxg76XzS22B2uQEf1VOFmSEgPUil5
 LJ0UmXYuF27An1Sw==
X-Received: by 2002:a05:6122:6081:b0:5ea:cc3c:9449 with SMTP id
 71dfb90a1353d-5ee34adfc55mr1317414e0c.19.1794586346220; 
 Fri, 13 Nov 2026 08:12:26 -0800 (PST)
X-Received: by 2002:a05:6122:6081:b0:5ea:cc3c:9449 with SMTP id
 71dfb90a1353d-5ee34adfc55mr1317380e0c.19.1794586345854; 
 Fri, 13 Nov 2026 08:12:25 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c1797sm6733778f8f.11.2026.11.13.08.12.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Vince Del Vecchio <Vince.DelVecchio@mediatek.com>,
 Faraz Shahbazker <faraz.shahbazker@mediatek.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Milica Lazarevic <Milica.Lazarevic@Syrmia.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>
Subject: [PATCH 03/19] target/mips: Require the MT module for MFTR/MTTR
Date: Fri, 13 Nov 2026 17:11:41 +0100
Message-ID: <20261113161158.25811-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX+p2KOAwiT7oW
 v6IZydU1p+EHV2Mqh8la/1Dxe0kZ2IEwmcC0q9MRiJ0PKMLIzbkXviWWmyh5I28gwq2jMsuE92V
 OmsjrY7VvPN+s8YcEUV2ZtAOwne2zIA=
X-Proofpoint-GUID: Hoaw46b8auzX6aHFPuJ5HHbdc-u0u3W6
X-Authority-Analysis: v=2.4 cv=N+e8hG9B c=1 sm=1 tr=0 ts=6af736ea cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=EE5N-t3p5bZ9LH_ndV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX88MhfMK2j6VW
 URf12VV5foq1Y4Mo+MSf7kS19YZmtPbsIruChlaJ8Ha8zGiWOpwdfuZIJCKRZnIxu/wIaX0M6Rd
 jPqwNJkVNhWnAC5JdHfl1GF0iXyV32r9/46AQz7QZs9c1CN/E1CFB4/hTFlft4t8ifvTw3U4npb
 Ah4jgi/RDO5zyK1YR2bbTgiOpo+BWd3FIoCOcYBhbSwIC3OIYEHe717/c6qpz07RdVEigXq00Sa
 gaKKCkOi96sNLfxPXQr8oFxRd09WM53hWTll3SQCw8bugTmfTd0uMjnjBz1f6bCyJza/wyrczFK
 b+BDDlDXwfoaHJvmuvBDUlc3tgxgD6/btZahICCF9DmhU6lTtwLclwT+u5mYV/FOjiwerXqOjmH
 uUPNoJeM/Lse3fyLs/ZukdTUpKGOkWFCNG8uBnJl1gccUUKYzSQO/IzPywDJRgD+7w5146EMzbK
 t0EKCpmTkgZBhOLjjtA==
X-Proofpoint-ORIG-GUID: Hoaw46b8auzX6aHFPuJ5HHbdc-u0u3W6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

MFTR/MTTR must raise Reserved Instruction on processors not
implementing the MT module (MD00378 pp.46/50, Config3.MT:
table 6.21). Use check_cp0_mt(), as done for the other MT
instructions, instead of only check_cp0_enabled().

Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 6e7e1a0f758e..c434da714b0c 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -8588,7 +8588,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         opn = "mthc0";
         break;
     case OPC_MFTR:
-        check_cp0_enabled(ctx);
+        check_cp0_mt(ctx);
         if (rd == 0) {
             /* Treat as NOP. */
             return;
@@ -8598,7 +8598,7 @@ static void gen_cp0(CPUMIPSState *env, DisasContext *ctx, uint32_t opc,
         opn = "mftr";
         break;
     case OPC_MTTR:
-        check_cp0_enabled(ctx);
+        check_cp0_mt(ctx);
         gen_mttr(env, ctx, rd, rt, (ctx->opcode >> 5) & 1,
                  ctx->opcode & 0x7, (ctx->opcode >> 4) & 1);
         opn = "mttr";
-- 
2.55.0


