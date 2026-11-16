Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5323C606A322
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nb4s+OgE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QlYTn5I5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT0Xp-000108-Ny; Mon, 16 Nov 2026 12:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT0Xk-0000yb-Og
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:31:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xT0Xi-0005GI-0r
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 12:31:00 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGGIIPH1579991
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=R/Q9Y3qFoua
 OmOXVwiSfhelknx48ZpAoMrzIEvig/w0=; b=nb4s+OgE5J4ZFss/fFNP/Tf5kyq
 AQbTe9xsYmqKyUEZUv/M4R5/YlymggEaW76BZCBwH1RVkab8Wx9pgAxrijOg269M
 dWN4MVRTadevZ3TGGd/sA9RWW8sqgRcNYJHhXQGxYZpIbkuMK7MsdebRhWtd6uu6
 vMfF30/hHoWHrqqHNISIwGI+02FqIw3ec0zP6kJj2EI24vDE+I8NZV9OxPBYwb0W
 lqWwCOCCukoeoLptkm5kX75bQ92IaCRsDGisu4p8oujcZ9oiHTYoMacOGz85tvlg
 DvOb8ygJRy0t76Zn2ujhrXKGMk2Q7S1uaOfR7D3eihJ2nXtnj/OXpcBJLdA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j000g1nwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 17:30:56 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91f1b3070f2so28486116d6.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 09:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794850255; x=1795455055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=R/Q9Y3qFouaOmOXVwiSfhelknx48ZpAoMrzIEvig/w0=;
 b=QlYTn5I5wmLPMZHWr5wBT2gVKmoUTKwKSopyx0ELE4HzOGeKzKSZ37Rz43SBHAQNcF
 OFxIeOBvuqVWYVd39Or5/rFdQctgcz2KPQJhppxtkucP+kFFvADwiPdy2cObxvrTATmV
 4yfpqyDmGW9BWvnFWWPSZ658d4G9aYKUjRNIY+FBx+dDYfVjeBhjdCdoFMnbWqmgFhDs
 8L6SZDM+DFIAe9u9c2N/pEOfsrri/wxvxmEE70scoWF4HPmYeA33clY6JvY0eKrpL3O8
 57l4k7Uy+dGfSkZ2erVCyunZShA4McuH2CY2qT/HaFp9S+wFudLKvmJZcNeK7iLj2+80
 Mweg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794850255; x=1795455055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R/Q9Y3qFouaOmOXVwiSfhelknx48ZpAoMrzIEvig/w0=;
 b=bZnULEcWfl4iUhTxWwISFGWIQ47lnoaoE29R5BNmYycMUO4S5QYrxTdMaDRXO38POJ
 nr+Z2h6XboU80YRb+ngm2nPHcaHEBRUKCUC0RqtGGwJ+vTOc1F9ODJOFsNtrGJoGuyNL
 rlXHu4+n/9tpzG4clp5zzjEm9POZx0F8jQoaLcJuR7crjqeQOLZqpgsX4P/uMZsm3P53
 +VHnoIwhJx++GVY9JuIVgrb7gHBlQ+NY0MoaWRQwI3xWOqt18IGQa3/0aR1/rAFFi8gn
 4+JNqAC1Ypu1qIfdnsI78FKdQrIbQaDT9FpPSVA9WAZklRbNdp4YLWhi9BucxrLbPy+j
 bcQQ==
X-Gm-Message-State: APuU4Z+QDEgI/JofGnA45lU5mG8jMDybkgBbB5PR7tzDiNzcmN3XBprJ
 LlPtKyAEmRWp5/OzX8I0qqGrQAyJ9JHU3+QrJ1kuNnLdrR909R/Ogq0eImNJgWvZl24UxWxuZkL
 o8ovSnIJUd6cRtghOxJWXugocfuRdDQmDuLfWLa42Sok9TO2egRIOgFNf88VScs4CHw==
X-Gm-Gg: AYBFou036YwsiUcZUlLrm+kblh7LBPpbkb97cCnjIeR8HeTSW8EKd/pltexh8uT4d0g
 eTywreQauf+9qfGnmTtkke7vWQ9SzAWRClFwtfPJU/GlB3kaLpGowGwTx1hQ9TN7JvrcwQW4+3u
 qacsHNjRjVFBPLDE2tvcjCVfNvFEDel5mu6ApktjREo2X6o53JB19OHzDDk8umZZBKMI1dQr9Ox
 WgzFSaWUgh9DmbDnwnCm/IgErz8kkK1oTw6FH/oFQbq0hzzIofRa6Cs9fPJn/JgTBXgjZ/0oFby
 wPIch2DU6e5aSQd5jZ+zli9ATzLCHeXsdWTqwd0cNIDpN0a+BozMSxhamVAOtkUsdKvm/fDQrHs
 u/E0dWZuXxNgFVUcgLSIa+DA/I44zMT3jhzC77vy02JBHWdSHua5WULsv3zzzoMLM6TRzLsGa+E
 2O9L8VvxFvSd8=
X-Received: by 2002:a05:620a:6cc5:b0:947:9217:67c8 with SMTP id
 af79cd13be357-9494bb8799fmr1908889785a.72.1794850255374; 
 Mon, 16 Nov 2026 09:30:55 -0800 (PST)
X-Received: by 2002:a05:620a:6cc5:b0:947:9217:67c8 with SMTP id
 af79cd13be357-9494bb8799fmr1908885685a.72.1794850254828; 
 Mon, 16 Nov 2026 09:30:54 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.227.223])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8b5c1dsm898530385a.33.2026.11.16.09.30.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 09:30:54 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/3] target/riscv/tcg/pmp.c: remove no-op in
 mseccfg_csr_write()
Date: Mon, 16 Nov 2026 14:30:45 -0300
Message-ID: <20261116173047.812886-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261116173047.812886-1-daniel.barboza@oss.qualcomm.com>
References: <20261116173047.812886-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfX1cdCiQBjCT1v
 gzKGxoClYDl8O0/RrqZ2eSVcec53aCL8av/GIK2dyQz6lE8IzRoXKOL/A68TxKqIXb0vpVkRTzJ
 8m+j4NLoOmR20pxsj/zM9y/6mXDIhAWSjd3WKHXlmecwZXwFdZugiy9MvK58bsb80tz/jfPz15W
 QTUszkdFfN/EiRL1mhMNxSTYz4WU/YFh3zJ5vGAcyLjEq29JWrstzI+ZH9bkLHvCfflQhjhMxgs
 Ri080rGtDBJpkDwJtFGfGEkDejE8bojVsdKkiZywW5pU4LPUqwVCIa/hm1XdL1K5kPloHbKEkKS
 Vi9Ix2OI+yyOJERHraBtL+H0JHCRaNhRZSUUIJ8jFhClGRQPur1ZnyeHwI1CThUkdR9cZrl2Roo
 Oo9pHYDI5yJMTj7+8+jdCbxYIYFiI0Emf67mG8uGxgWkj1YA9p/pVRHsh9zCS3Z06Iyst6gyHfO
 F1aH6X8gazxhnxr3YKA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA2OSBTYWx0ZWRfXyQLCrbsezXW6
 8nCUsG+tGkFdQ/8CVVdh17LqeVVLUfrsjpYxtRJazWP/LZmXx+0xkSXIwlbg1kc6AAJU8FzRY63
 nzDUrSudPcjSCOgTsqp9ieDQXvFNFAw=
X-Proofpoint-GUID: RzQUiscCOlw_cXQPFHD6g1Ag9gbtAFhc
X-Proofpoint-ORIG-GUID: RzQUiscCOlw_cXQPFHD6g1Ag9gbtAFhc
X-Authority-Analysis: v=2.4 cv=Vdtir1p9 c=1 sm=1 tr=0 ts=6afb3dd0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=WERq1Tg1Nl5IKGfG0e6imA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=sd8IT5uBP3HpCvPSugYA:9 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is a no-op:

  val |= (val & MSECCFG_MLPE);

Doing an IOR with 'val' and a bit from 'val' and storing it in 'val'
does nothing. 'val' is unchanged.

If we analyze the commit that introduced it we might have a hint on what
was the original intent of this line (a bit clear ... maybe).  We're
going to rework mseccfg_csr_write() in the next patch though, so instead
of trying to figure it out we'll just remove it.

Fixes: 4923f672e3d7 ("target/riscv: Introduce elp state and enabling controls for zicfilp")
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/pmp.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/target/riscv/tcg/pmp.c b/target/riscv/tcg/pmp.c
index 04df53c234..7b41c628f3 100644
--- a/target/riscv/tcg/pmp.c
+++ b/target/riscv/tcg/pmp.c
@@ -712,11 +712,6 @@ void mseccfg_csr_write(CPURISCVState *env, uint64_t val)
         val &= ~(mask);
     }
 
-    /* M-mode forward cfi to be enabled if cfi extension is implemented */
-    if (env_archcpu(env)->cfg.ext_zicfilp) {
-        val |= (val & MSECCFG_MLPE);
-    }
-
     env->mseccfg = val;
 }
 
-- 
2.43.0


