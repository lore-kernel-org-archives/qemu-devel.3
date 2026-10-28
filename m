Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE38D606A322
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ILWlFRU9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BttXvwN/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM9Hn-0000n8-Nd; Wed, 28 Oct 2026 15:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Hc-0000hr-Ou
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM9Ha-0006BV-Vu
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 15:26:00 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SIPhnx400515
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FkZP24hxVjqWOs+rc1883oN2WArX52polNEuAdUJjIE=; b=ILWlFRU9eLnMkVaz
 Aj23tdxdkQLeq0TiWg1uKjNwAq6d4IgPX3tefzUyACh4bMzjim4DmX4ItV0UYD7P
 F8S1N21KstW6obXzfQrIO83hemjUN5oZ7/7YOZPf3IXK9aomUjrX2kkEM8yKe2o0
 9jfsCpgVFU92w/Dye6oKFrxRPiYKljgr3zrbtkjVVTsWlf7p7XcODb0wcnTNN0qS
 yPR/DVifa3PsigvoMb7HYpFLNYU2f7WjVwh7hAA/t9EAqu23vLphGg7wPOSDe7Ee
 +jUHCe3Au2arbp0wa5CbrSJMuyTaxB9VHS390imOIHL3Z9zo6qLXTNLMWjDRwp4U
 LS2vKg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkhtnhmnp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 19:25:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-533928ef33aso21511941cf.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 12:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793215556; x=1793820356; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FkZP24hxVjqWOs+rc1883oN2WArX52polNEuAdUJjIE=;
 b=BttXvwN/gi6zs//HRHeA+SqCHJYI5YnjsbnssbD6yo5gSeqRwX/Ajx52TZxW29qs2h
 LRfRH25W1Tu57Ak5yCPTWn7keAjFFBSu3v/ANA3R1OGPdWo/jZJKcDFcp10RmUFJ+MCA
 cS1Va9Ra07XRZEOO2V6Rn0SQ84i2RhI37uG/2ZrygFtdcpr7nRWiOY1cTeNdHT3FjTrM
 5bhRoNBXCnU3OOV6YG3vjdihilvpxeuZsXtKbsHFo9mqkBiB/3j1+dAsGFEYJDdyeGyi
 RUQAyAOsfVv3RLskHThXEdh7pVxhtSc85ZdnVcu1DTKBFbKhPwhuYyy67I2yhNd7PNSW
 u0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793215556; x=1793820356;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FkZP24hxVjqWOs+rc1883oN2WArX52polNEuAdUJjIE=;
 b=F5c+re0BJGnJ9ajDedaquJgCxdcESJgO9dkreYJE8eAns0UCkR0CZMaTxSP0CsTfPY
 NSbfUKoMjSqe3EfZG+XoATUOUSTCp0bDFeIQX1j2PHsrEo6XQyGZgqu1J2V9+vvEQotM
 BHLXOoYmquTGec6UJ9ns7bYMhEtHdoqtkR63u77mZkmWc2BAlJrpwq5YX60rXBV0y/IQ
 GMvOFGeKz8zt5alatyv88cWd274UzP8mXuw28mhrvDWhj5v/ak3PiDBcZ4Xu+zXYVfPQ
 nMijKKB85ouimsLl+XG7+XuL5LydndU2pPG1Hi82kLaZu40vKGlTs7WWPhv57LU1BvRA
 yP+w==
X-Gm-Message-State: AFq9FYLCZJ8Vvm3GiNRMvyps/ZBQmEyRY87xpdM5c+mjkzORNb73m5uf
 g5Asrb+P+bzS5fB4AvUNs6WCqNuz1D1XTpy4BA4yVU14pFiDHP4A50tO+YS+O3jeEdJOxSO6Z6D
 z+y2PENZmifYOIK8GeHPLPAOYQknytnK5oSWRj8hUDBvmBYyDCQV6jQRO2FiMhgwVWaFq
X-Gm-Gg: AYBFou1Q659LejINUFdRJVt3Ty6kj5mhODSc7/VnJiOVpHhVfyfpwwbDqTznY81fMI9
 CQL8juk270fMtO77CiqUHDz8sUOyKP2MJ793+b771FQBhfxCucIGd8AyqnNb8BwrUHqDZsdD/4/
 bZfy91Q2q+pwSl8lEwJxj/DdWUd0MYUq8EePstvqZh+2p9eN7tdPJG7/60KAm/w8/hRPTGDAYGT
 ZaJhCdM09ToTawNKEHWlLXmlXHxOHCyi+Uam87cVAej0O+iex/1irmG3ZQHxo/kf5BD8euMRaNu
 DDQDs6p/EdW6/7PbinaPRA3CLuJZ7WYoV2pWKhiAMLQTFrvAvuP6jfcTEbDVI7YbqLiBNqXi9Hi
 0+36BMpMWH3MD0s9gtputwEQoEkTp+T/5aDF2Ohxha6b+sbkBtkRx+rrkJ6RSqf9I1kvbT7T/2K
 3fglDeK6C5meq4eKcucYlULzzzSUl3Tg==
X-Received: by 2002:a05:620a:4586:b0:940:f224:5a69 with SMTP id
 af79cd13be357-94408d28c70mr548662185a.65.1793215556173; 
 Wed, 28 Oct 2026 12:25:56 -0700 (PDT)
X-Received: by 2002:a05:620a:4586:b0:940:f224:5a69 with SMTP id
 af79cd13be357-94408d28c70mr548657785a.65.1793215555671; 
 Wed, 28 Oct 2026 12:25:55 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd49afsm30395553f8f.35.2026.10.28.12.25.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 12:25:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Fredrik Noring <noring@nocrew.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/9] target/mips/tx79: Fix PCGT* (Parallel Compare for
 Greater Than)
Date: Wed, 28 Oct 2026 20:25:30 +0100
Message-ID: <20261028192538.31600-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028192538.31600-1-philmd@oss.qualcomm.com>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MPAkA-0dxmNFWBIq7RaLR4qwhDl43EnB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX10IhSXK0Foik
 lQXh9QsDQCr5LbelwF0gf982eukKqdIBmV3ydI1/3WB1xe/AcYPWZj1n7SbwyHTS44mH9CQlyIi
 SKtvYS3S0S4zrtJBdmNvWXqTv3PNjMjh1N2V07Y2xOJRhBpE+HhiLMxGPQBlUtjK3JVDCa+6QcA
 bTT52SrJO7KfffhELVoKi76ZlPNwoJD/aHxNUAg8ntKko+Zc/jWrxRfr+pNXwtGO+XYydm9+KAk
 P9FWFVfVnqhIUEB6kvQggUE6Mh77ESQA3rupa/5+dUuCpij3He+F/pHzh4qkhj1tOyEgIsPmmEj
 QthAM5xgAXea/1U1ABY5WSMVu8VR29ZI8Nx/1DHc78E9lMUNZqsfR02u8nU2YspTeEbgLuwhNE4
 6ibOYTC2eQAVq+PJG2XVBh3w0nqkHsI6N7SF0yJ+egzx8cejd3qAOMBG1l3UQkuSaes7eTw//Vr
 g0uhx6nXW8CrrX08cmQ==
X-Authority-Analysis: v=2.4 cv=c/A+0h9l c=1 sm=1 tr=0 ts=6ae24c45 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=zL3gZbcvU7LtqsjzNTkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MPAkA-0dxmNFWBIq7RaLR4qwhDl43EnB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NyBTYWx0ZWRfX8OGGmhozov8N
 kXt7ZEmvAqrs/75bUV/1X9ZAWGw6sMfPq01r4mIIZIBa3W8scXY5XC9pcjUNiCBmYUDCJI9BmO+
 Yj53GPFbBehyF/c6CQCseQJKYLFBue4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280077
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

PCGT* set each lane of rd when rs is greater than rt. We compared
rt >= rs, returning the opposite result.

Fixes: 8bd42c00f284 ("target/mips/tx79: Introduce PCGT ...")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/tx79_translate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/mips/tcg/tx79_translate.c b/target/mips/tcg/tx79_translate.c
index e071c867631e..3b413846c8d0 100644
--- a/target/mips/tcg/tx79_translate.c
+++ b/target/mips/tcg/tx79_translate.c
@@ -255,7 +255,7 @@ static bool trans_parallel_compare(DisasContext *ctx, arg_r *a,
     for (int i = 0; i < (64 / wlen); i++) {
         tcg_gen_sextract_i64(t0, ax, wlen * i, wlen);
         tcg_gen_sextract_i64(t1, bx, wlen * i, wlen);
-        tcg_gen_movcond_i64(cond, t2, t1, t0, c1, c0);
+        tcg_gen_movcond_i64(cond, t2, t0, t1, c1, c0);
         tcg_gen_deposit_i64(cpu_gpr[a->rd], cpu_gpr[a->rd], t2, wlen * i, wlen);
     }
     /* Upper half */
@@ -264,7 +264,7 @@ static bool trans_parallel_compare(DisasContext *ctx, arg_r *a,
     for (int i = 0; i < (64 / wlen); i++) {
         tcg_gen_sextract_i64(t0, ax, wlen * i, wlen);
         tcg_gen_sextract_i64(t1, bx, wlen * i, wlen);
-        tcg_gen_movcond_i64(cond, t2, t1, t0, c1, c0);
+        tcg_gen_movcond_i64(cond, t2, t0, t1, c1, c0);
         tcg_gen_deposit_i64(cpu_gpr_hi[a->rd], cpu_gpr_hi[a->rd], t2, wlen * i, wlen);
     }
     return true;
@@ -273,7 +273,7 @@ static bool trans_parallel_compare(DisasContext *ctx, arg_r *a,
 /* Parallel Compare for Greater Than Byte */
 static bool trans_PCGTB(DisasContext *ctx, arg_r *a)
 {
-    return trans_parallel_compare(ctx, a, TCG_COND_GE, 8);
+    return trans_parallel_compare(ctx, a, TCG_COND_GT, 8);
 }
 
 /* Parallel Compare for Equal Byte */
@@ -285,7 +285,7 @@ static bool trans_PCEQB(DisasContext *ctx, arg_r *a)
 /* Parallel Compare for Greater Than Halfword */
 static bool trans_PCGTH(DisasContext *ctx, arg_r *a)
 {
-    return trans_parallel_compare(ctx, a, TCG_COND_GE, 16);
+    return trans_parallel_compare(ctx, a, TCG_COND_GT, 16);
 }
 
 /* Parallel Compare for Equal Halfword */
@@ -297,7 +297,7 @@ static bool trans_PCEQH(DisasContext *ctx, arg_r *a)
 /* Parallel Compare for Greater Than Word */
 static bool trans_PCGTW(DisasContext *ctx, arg_r *a)
 {
-    return trans_parallel_compare(ctx, a, TCG_COND_GE, 32);
+    return trans_parallel_compare(ctx, a, TCG_COND_GT, 32);
 }
 
 /* Parallel Compare for Equal Word */
-- 
2.55.0


