Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C14D606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Zfjce5IL;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVlDs4kF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzxV-0004MW-Sp; Tue, 24 Nov 2026 18:29:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzx5-00045u-4m
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:40 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzx3-00085W-CP
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:29:30 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMaYMA1654121
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1VHaOXeSuDJl8rk6kHs0KcyP9uUnsQi8aD1Uqitj6Qc=; b=Zfjce5ILmPkdApBv
 M7wwFA62dFxVmoC5NTCTrFK6e2YhfWfg+oReV4yRU0Ep+GFdNGF06a1LkFIOwY93
 fELvNNrlphZAKblAFmGa3owR4m5RhT4MLmlDBO95KChxbUyFDTIT0K34reGZ3xmw
 bQNm+pp8Io5hqmxDehoCfOROLYnNj6vajRBvCe9h+zd08zvi8ufa9sGn5ZCzq6AC
 GZBXQThEwQi1inwVNZuFcPazZumibc1i3QTyVcMjK/HxN2XkOApB4B9q1zkmsGBO
 B7CZoG+SGxL+yog3WKfRg+gzOwjH7FFjqGc3QS2kwZa9pUz5w/iWnMYwgd0jyObp
 LYlmgg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5eyd9abd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:29:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5363763b556so100491071cf.3
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562967; x=1796167767; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1VHaOXeSuDJl8rk6kHs0KcyP9uUnsQi8aD1Uqitj6Qc=;
 b=OVlDs4kFxmxj/LCd7UnuRsOw6/4XH6sRtp25Gahx1cJE6szw8L+w4k/J4eNbgEY1sv
 R7t3XYYsQKUDHFf+gJ2hQFY6vH2E6fYw3YkBYQz7HK6MBCMYNUzjuPZAVaWBsR7vy57M
 IeESAIwh6Kv7RUC1YuLytXSYveRtDz7InKuPtwR5ZONAbUM9Wo6T18K7o1F973VNtYJg
 c5N+uj8y7QTNkhSu5oLm5+nPl2Fnm9Mq+5oGPzko8EVzsP0o1KoBGHy0kYgpCKDS8Bgt
 MxMOBEmujQimWYjCuJkUKTwcamUBf28MfOdEm5so9HFMiF6jd90wcTvujDIcWoCtohv9
 JvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562967; x=1796167767;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1VHaOXeSuDJl8rk6kHs0KcyP9uUnsQi8aD1Uqitj6Qc=;
 b=002oFzMU1v8JWsSgap+PdPeO02LNlNEfTexnLZaTRXsdo9d8DR3IAP4INpjXHb+H4v
 5KI5/a9Q78BUTHOJbW7a24kD3UvYbUrIHv5eg3cHYrOTWytS+F17W/F18A0z91z+opeW
 7nSfqDEeNeAHzvHz/ZdNo4jftaBt3lFGAW7MQshF9JZ+fayeiCXmlyuMZQxh/z2bFH9k
 C3WHzSp4McbGzXeVkRgC9xlvBlR6TMmNSEsyamZcDgxS4c2L/pXLpq4gucO0XTBFrM7T
 NuUek1xBkjyqCXapnnNsKL2/ngaEJHDommBGyfbGPZPfunpltS5dfvJKoSwKI/KPAqwN
 brlQ==
X-Gm-Message-State: APuU4Z/UpEnyey1U8QaeIZ2eIqBHVJz9pCpT93ymgwJK5heBUSP+h6Z2
 4T/thhTyAwsTh+r7hix4kQunpWSV4f+ZpplWZXyZVr54yO9nmXgTe6RKEv10FXznrrO9hhVld0w
 TrWjXOPX3iGWI6oScvzIbNxhjagnrYxqLVOGAZALrivTxP0CPzO2yu/6CPkod1su/rg5j
X-Gm-Gg: AZFdTZdV6IkmGJm66inuMkZZK7BRiLK8hZs8Zxk6kzTtyRdTQwY0pMWkG3iLMR6DdD0
 aQ5Gl95WS77v9vZt/31UwrgWcwzdRm3Cs8bIVqKyH2KQJAc4NcuBviejiTKtMUAGhKZ/mD2rxFy
 gwqHVraqB96SfvqLl9ELwBNFsaG2NlQml86MNFWFVN/hdqukHLFYW4Uxbji0rHYmLQVkYkTcQ17
 DChrSCfryYLoaVW4H5LMFOisOS/vGMczs8DR+nd4nGrr86Oue8Gcx3D4c4+Mm/zHkHetM0yylN9
 nPQmmef6nr+cbiIXEAsolUxeyKPPJqkOo7IncVsGSlhxoZr3IXlhaQm+Lnt5crJ/uitlPhUA9gw
 Z4r9uaB1PIDsqbUAAN9SebsIkmtnpiZKFpYC/YT0AoOw1cd/p942SUmTHtBib+zRA0aUZgz0ZAK
 D3GSWNZWOvcnXEpQ==
X-Received: by 2002:a05:620a:46a5:b0:93f:6c76:215 with SMTP id
 af79cd13be357-949bab157e4mr2879507285a.50.1795562966912; 
 Tue, 24 Nov 2026 15:29:26 -0800 (PST)
X-Received: by 2002:a05:620a:46a5:b0:93f:6c76:215 with SMTP id
 af79cd13be357-949bab157e4mr2879504785a.50.1795562966446; 
 Tue, 24 Nov 2026 15:29:26 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm565820195e9.6.2026.11.24.15.29.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:29:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/18] target/mips: Decode 6-bit bit number of nanoMIPS
 BBEQZC/BBNEZC
Date: Wed, 25 Nov 2026 00:27:21 +0100
Message-ID: <20261124232722.90234-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX58K7OvRc2R5U
 sM9NrJpuFI8JAJVFhEsAQlDvQVWO+V7DcLtZSTpAp1DmNQ8rR+V6BEdRN58mKxV6cvf18OLdU/n
 blMA83Ab98fVU8TKYeoiUbfmBFqwtQc=
X-Proofpoint-ORIG-GUID: S7KZvAF1-Ov-UVRzHzkg2qN-CrONc4gM
X-Proofpoint-GUID: S7KZvAF1-Ov-UVRzHzkg2qN-CrONc4gM
X-Authority-Analysis: v=2.4 cv=GIGdgeNK c=1 sm=1 tr=0 ts=6b061dd7 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=snbnvTbt-5-dSQZ-83gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX5lmBQg6C8TJm
 SLNDET8FeFnt3e+Vzqrne1IZvOdR5Sj9ph077eFrQ5t9f94DNJnmhup4sKGtFtH1r0WK1Z3r23Z
 prdupOsG6Vmo2t1D3/E2W0A+OLb6xgUN3nWdsrPqLjJLtoL7eCbVsKz1cFWhkhOYiaTmpBwz5f4
 /gQjvR+QekFB70JDloa1p6tfKDJi+Puy1lrrQKJcQnv0ApJMN/Z3eT/hVdvEGiK8XDfSSr0rko8
 Bg+dWMxXkD3bFs9Kmu9AEq3o3FUUtZEwACztM0w6N1wc1hA/we2TCCihjVXwmCOhG5z4faPhYrO
 GRJdlPxsMIeteuNIxR43iS7zqKzBjXlH9luuoi2L9N3zab+HYTE5yY/mKEeoarMX+kRviovGipt
 KcM9uB+82Qj6SIiYBfSQtkmASWk7C8Hrrf38jmGisxZmqVI7MeK1c3d94Y+Nnt8y1hndfeEwQi1
 jSMw9UqF2rISYj3iyMQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240092
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

BBEQZC (MD01247 p.38) and BBNEZC (p.39) encode the bit number in
bits 16:11; bit 17 is 'x' (don't care). The decoder used the 7-bit
immediate (17:11) of the other P.BRI branches, so a set bit 17 gave
a bit number >= 64 and raised Reserved Instruction on cores without
64-bit operations. Decode only 6 bits for these two; BEQIC and the
other P.BRI branches really have a 7-bit u field.

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20261113161158.25811-17-philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 19cca9463de4..f9ebfe54b4ba 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4430,10 +4430,12 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
         {
             int32_t s = sextract32(ctx->opcode, 0, 1) << 11 |
                         extract32(ctx->opcode, 1, 10) << 1;
-            uint32_t u = extract32(ctx->opcode, 11, 7);
+            uint32_t opc = extract32(ctx->opcode, 18, 3);
+            uint32_t u = extract32(ctx->opcode, 11,
+                                   (opc == NM_BBEQZC ||
+                                    opc == NM_BBNEZC) ? 6 : 7);
 
-            gen_compute_imm_branch(ctx, extract32(ctx->opcode, 18, 3),
-                                   rt, u, s);
+            gen_compute_imm_branch(ctx, opc, rt, u, s);
         }
         break;
     default:
-- 
2.55.0


