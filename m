Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84B606A881
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PMpeUxqM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KzScxmvW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtss-0008IS-SN; Fri, 13 Nov 2026 11:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtsr-0008I0-6h
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:13 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtsp-0007xW-MJ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:12:12 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR6NE552058
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6Hjt39nGuUQz6IJlKn58p2sse/3X1+ACf7Kqo6HoXHw=; b=PMpeUxqMOFMZ3d66
 7hzHMypWLqMKmIV7zu9n0XeanDKh6KIfOQyVliGVage7JHsildLmaKyqSndBUfqL
 dfQqVBsUASdJVmIv2hzri8XPIrp+N5GwqbQAeF/fClvmR/RN1NspvfZMy/44ZTuK
 sZrJ/cATi3TKW8RZ6GQSkrt6XrBelGCHzZhsif9/TaM8/HhqWLSxPudTu4BrWi2C
 /IyW2P/zov+L+5dA2GkeXT4gLze3e5wixRQv3AK53ecAxr6KUbO2jGKETfW4wuKp
 0ARO89CGFby5QdKIsXKjZ5XA/i/ZSnqlaCC6bPkTZ55DXSjwhNodrqJJpOB6SIZb
 NJJruQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbs9g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:10 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eaad8219b0so365157e0c.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586330; x=1795191130; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Hjt39nGuUQz6IJlKn58p2sse/3X1+ACf7Kqo6HoXHw=;
 b=KzScxmvWHsPNrvPvlqBMOm8bAQ6W39s6I5KrUZVtjVVPg9+G/AsPubA7/EEMT7gQs0
 IBZ1bNNG8N/QAJvTAsA0Dn21aw9LGCYXV6MZZzHzFqgMxdODNimLeuyB76XebgZpnpjf
 LYeK1eoeruqWeAVyQ4FrY8nl5E4u/G0MwhLBjYPW1RMUQjD/gCkjE6/wap0FFMLt5yVO
 cIRyQ6FsJAwrN0RPOi5ZvcYyj7WZBE5GctnWGMqB1XIA4rPldBi/WmSY0nE6aqUgCZUe
 NwJt32f4apEKbDVSwqjynLb9EdIU9Meo9IZTcg6ZWt70HOOcYKrxxZWIRA2WGhfyxuCM
 Dtkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586330; x=1795191130;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Hjt39nGuUQz6IJlKn58p2sse/3X1+ACf7Kqo6HoXHw=;
 b=PTgQb5f38shf5Mz184H/OH/82pooP2+FNzP1vHJ6rwKWOEnJTeFa2ez5mag/g3tTUW
 aw6fHLYEVYeB2FIt8Md/FaII60rOsMbgZtENfKK0c3AfMGHF9Ttyh3AWV4ATrziDCh74
 b2j7IIxmHk+d5IDRNRGgv8UYLJ/ACVeuLjFgo6QaSMbrG+0dV+v9yAA8NU7W2wk1imWB
 Bfsfd+BjFDyqin5lMF3DwxjddiUxW2+X+Gk7mcnEZtacLQ+yXeyE5yzVqq6vrDgyWVEx
 vfcDs2PgzLYyZa2me5u+39PpDFkdp1wlBN5fVsctCES23X82yXuzBJrKyredfi7LpVA/
 bG3A==
X-Gm-Message-State: APuU4Z/3zD3S1bG1BjBiPDGyjC7+tnPlrtosvYsXiY1Hz6tyzMj+hdUU
 bODYYu6ikc9eR3dFIwM/PoEXy7NP/TrR+Luq4FcFAYShmZHCg5kanA9FzMxg2+8iYbT88Y+5ywJ
 YqCfBW24ZEH4PJXn8WKxMUgm6oPkEjmbDIkUnyUI674lYeLTaNfVaMD/r5p8XTRcgftMB
X-Gm-Gg: AYBFou0dx1tTM9luQ8CI3+NsFNu3g7KCvuThY/sRAvQqNGqZFWViZ1whIcynKB9yugP
 kCBDVmovYQjJrbLXtb7LzBoCUd/jndxi5oFTBSlryONy+5VN6acQtYbIl8etEtM1qyTD5BTgmwn
 JbwZKJTa6/o288j7zKL5ozf5TqCv5An6UbHFP1XSzRRFZE8/61pSy+5/4IpI23fNuLJS2dexMdX
 pPFn26+JhPBx/skTua6/71Ee2I4ryIxeIXj+bZoRU65Y4b8D09PWWYb8lQ/25L+YdLY5+exZwv2
 oEdK60wuXtiHGfgzBjiG+DLH0XmKSDN3x4HGlCKBJLkSzKHtfeijb8ouoZ5oIZDFmyIxS+wGbbH
 XfSRGUSTfxeOvny7tCIGiXVJ0GbypoNOqLdtw9jriPZvMb1at6XmHZlOwPBNOHv5bj3HjvGcib3
 tMvw8W9nS2WphtxA==
X-Received: by 2002:a05:6122:2493:b0:5db:4749:1737 with SMTP id
 71dfb90a1353d-5ee34925c51mr1079946e0c.4.1794586330028; 
 Fri, 13 Nov 2026 08:12:10 -0800 (PST)
X-Received: by 2002:a05:6122:2493:b0:5db:4749:1737 with SMTP id
 71dfb90a1353d-5ee34925c51mr1079914e0c.4.1794586329458; 
 Fri, 13 Nov 2026 08:12:09 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55a0ffcdsm69150885e9.0.2026.11.13.08.12.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:08 -0800 (PST)
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
Subject: [PATCH 01/19] target/mips: Check for MIPS II when decoding BLEZL/BGTZL
Date: Fri, 13 Nov 2026 17:11:39 +0100
Message-ID: <20261113161158.25811-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af736da cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=4L-gAl4iwDZZ7NynZboA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: ElbiyyXabSy_rz-7vz2slKxAOo_TyhLu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXy2fygB3ljj7Q
 nJzaA3xbxhOc5TQ+OmdUkZBirwTiBmzsM1tjemu5E5XSvYdN3FD1sydKn6Sw1LNjGOT8o6l1hSQ
 arAghcFlRGPm3sVcbI62hiHKA9cVFhrbD16G3ezSfHIu4v2osq/ari7C+RdHrWBKbaEvVx4zfB7
 4ySv3U2U0A9YazWxoziPHzOwxfT3LnNC8sEE3Go+RWFx8AqgWN0j6+1z4OsRK0ohkzT0VtBcPT/
 HpJSXEXH0oMDJDe+oaBrsWLjgB0ieaqOnQEYfmUsL6Ita89Lw/1nfqH5tVJpOqtfsuorU2y88ky
 8QJswyHx+PR0UCKIDgOQZBVGs7hZfbgdg3PLlik10kAJixbR6WaP7XU043msYlAdK+vIxP4El/Y
 1LNjQCBpod4SM5HQANLXIeV7dlSPYHL6IvT0dpaXjUlqvxIHzEhh9QQ74RDZIdI+ie/fvhYBWFC
 sUVoOxSTz8X6HF3fuTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXybRKS9Ii2rTF
 eOtDrwIXY6KboEwN2PnEISH3ZiItNZeM69BQKRSaMXrjt3vz10HrcZL2NhVRSXqyTNv8O9MhOPB
 skbzhbtMWu4klTUB+QUSfQoMAwxYvus=
X-Proofpoint-GUID: ElbiyyXabSy_rz-7vz2slKxAOo_TyhLu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
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

Branch-likely instructions were introduced in MIPS II; on MIPS I
they signal Reserved Instruction. BEQL/BNEL and the REGIMM likely
forms already check ISA_MIPS2, but BLEZL and BGTZL (non-R6) did not.

Fixes: d9224450208e ("target-mips: Tighten ISA level checks")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/translate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/mips/tcg/translate.c b/target/mips/tcg/translate.c
index 10811db827c9..f521e0ec5bd0 100644
--- a/target/mips/tcg/translate.c
+++ b/target/mips/tcg/translate.c
@@ -14621,6 +14621,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BLEZL */
+            check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
@@ -14634,6 +14635,7 @@ static bool decode_opc_legacy(CPUMIPSState *env, DisasContext *ctx)
             gen_compute_compact_branch(ctx, op, rs, rt, imm << 2);
         } else {
             /* OPC_BGTZL */
+            check_insn(ctx, ISA_MIPS2);
             gen_compute_branch(ctx, op, 4, rs, rt, imm << 2, 4);
         }
         break;
-- 
2.55.0


