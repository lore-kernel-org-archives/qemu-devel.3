Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B68B606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Me3NjJms;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W4im/8Ll
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzwW-00027K-3p; Tue, 24 Nov 2026 18:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzw5-0001Ph-Mr
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xVzw4-0007hT-1r
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:28:29 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOMat9C2558269
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ZVwtMcUcsWAfZknu/N3fZPmnjyDLRyzmYtf7P1fMDfM=; b=Me3NjJmsJsyLN+8k
 IrNOjaO4V9IMKR0EJ0yuGF1xFpj0/7e954LT6UOSt2sSfOnyv8sY0SmNpIt03Gmo
 JKoAnXHf4kydjM+xdzmHQ2Dh+lcGSUxEOTLGtR+nMaM9YlvSeIaRKN/Q82Xfm1OP
 r7PdZzxugXGf/bk/I99PpTcYIKQsIKq41pauqmfWTFM1rbQpxDgiQntPabiqmfAE
 tEhAfORorFQcaR9Vu3lRxJFvUfFOyc20zLF2BmWFGqH1UnZokwErlJA2fjCkizgH
 VoVsCzHzhFy21cLHSOpV4bVPCslzmQ/8Z70mFL5mBoL2IxCXFLR8Kn0Ij0yptkit
 3A3T0A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnghr1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 23:28:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-9210357af78so88812036d6.1
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 15:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795562905; x=1796167705; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZVwtMcUcsWAfZknu/N3fZPmnjyDLRyzmYtf7P1fMDfM=;
 b=W4im/8Llh5racszgHexzdS6mR48LmVo7/JlyhRWfVOJJrYGfHdrDudq5O4qac3sd+h
 mKM9mbJYmXQVlnWe8it2RoY4Sy6pdRYYBWX3aOSrEnRNu0kHBXh7bGFTXgadVTjMRa4X
 MPuok/ws/qMB926yVpe90QYyAn1ZrvAkCjFChvvFn+gk8I8gbccpXOEBwGsM5RfSP2B3
 YFYWvkjHOQKejRzXv9hOHlZVbUAwr+4pwtoc+xW340nti8THT72SLdu8ZIYFFt6MxgvE
 Z7jY9u3DOWRNHZbtG0xouwQ0XDyt85ZgroJ5nzGhnFllvZnNNTOxCE7F0xvPA7tk9Ydk
 dbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795562905; x=1796167705;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZVwtMcUcsWAfZknu/N3fZPmnjyDLRyzmYtf7P1fMDfM=;
 b=zQiXRlDbkOV+vPtLdgBlvb7uvjHOVcSnC0xbL8nY/kr3cT9lY7aifDn5z9mdHQlBX8
 WnEiLA+1z12GPZ8elBbrMZLv55MS+dPuzL6ZFaoF9urvMXoSLdLYaC4BneErF5V6qxiO
 8JtFnKKMcVLdBv3VOltE40qsbLXJeQVkn+EEildE0PBsqUD9p3/vGMc389754unyGTZC
 7n9TyhtYmbbUWPz/nnboUVMhnaDwi8C1L3tJZ2qNMo7CbJN8usEAXTlkkKOhUZsqfKIK
 FxR9997uUoZ3rEEw33uaREw33Ekbh6H5U6u5Hdvn10MMr11IwhQXUyjRtuUaaSCcexOS
 kQnw==
X-Gm-Message-State: APuU4Z/xigiA03WyVHINDwwPAZPz4Ub9s83iJS7shV0vdOcR+H/Rx/rD
 wtlFTViTbgxCLR7oh2Q4ljJBUzAoDfFeRFD3UytebZm4/u+PjJDfqWHIEKamTKWNEd3WF9HFIlN
 QAwPPkDWEvI8TH+EfMSp6H3QhdTdmR5BWqDkBI6OMVagMThuOTp4vmk7GlvY9IUMApXmq
X-Gm-Gg: AZFdTZcKQzitC4wxQ0z5WDDWRWK7DVLp+nIr0OXb6wQ3gjiNojwcVn+hTNfzMvB2IPE
 C4YdslXEpolVd9zB5r30zhDKiQC1nfEBj4us+iIM8VkaqschxoMLj4aQw7b/tOpsw3sV+saWzJ3
 6cxqeBOkZTr9rfxNFmKm6qnj9t/9emzO0a7HXzbQfdX3XxnIHh7iyfCaosBxkJ/suiavM169W79
 cJfoOITDcusQ8Cby+3BlHWcwtGHETA38Hn5JZxhWuPySZcrMeyhGpm16zPEGKr4nbGm4r7wnxrA
 taTjdrSa9UOnYiIjMjpLMBty2rZDEMpe28ROSWp6fs2nqhFSwFCg7pK8WeuiDpArywXQGUlb0b7
 KeFMluWM34uBblPhJRzDDarQeK67B4ZKXKFhrSPHI8QNK+bV4z4a7o7ynNUxxVRCvriSzK8FM3x
 EKfE0HQtJufTyByw==
X-Received: by 2002:a05:620a:2b41:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-949b35ef613mr2775412085a.26.1795562905262; 
 Tue, 24 Nov 2026 15:28:25 -0800 (PST)
X-Received: by 2002:a05:620a:2b41:b0:93c:891b:90f1 with SMTP id
 af79cd13be357-949b35ef613mr2775409585a.26.1795562904855; 
 Tue, 24 Nov 2026 15:28:24 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm459082195e9.10.2026.11.24.15.28.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 15:28:24 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/18] target/mips: Require the MT module for MFTR/MTTR
Date: Wed, 25 Nov 2026 00:27:12 +0100
Message-ID: <20261124232722.90234-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232722.90234-1-philmd@oss.qualcomm.com>
References: <20261124232722.90234-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX61123WYY7zMr
 vCfEiUZzYhYQFTxpxPOWCEZisUKpiAJL+Fyx9GE6KKU4QSAFfKLjm5ToTar8Umizc0BXpnf0m7C
 dl/HBwVkaOOu5moMR6EN+doFR1wP29E=
X-Proofpoint-ORIG-GUID: vGFnM6RQ_8fHA60805mm0KyqTVditwVb
X-Proofpoint-GUID: vGFnM6RQ_8fHA60805mm0KyqTVditwVb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA5MiBTYWx0ZWRfX0ciCQJyMbSsm
 QTa/uF1+idKLBFagU1nlbA9Tt7tv2yuRdLVMYMH3/0d2+oKu2NLmWVOMgdfu/9Cxn4K1jas78/5
 sCWXLxboiPp/V2yMiSXC7SCeKthAdvSatRjXAfOAbpXkCpaLpo4EkwLLL3hgfwlHiBTZRZtmMVj
 47opJN70sS4SV9QCckHdtXuWUoniwYm1RyuyPfxbBuWFPpKE91arZcQxTQ5IeabgLSFShVngJiE
 2OZ4h9MGmbfKLYi0fy/dpKOD5+faUARGP06YdVTQpEwogDF7/Cyr7hohKx6ZfIO8JkDjh7AMeEP
 2pHWEoT5hcv94sWW+MBHo7qq8sYYyFNZ6vLhNr+49VJ+MJ8nLFnUPgbUwuimHJWFz73zDM5jYoe
 f/mDxJe9dtJJiCdA+WiZ/hfVEVDiqnvW5vW7De4Co62obJF8kY638q/TrHm2ix1E5isG8qV5dnX
 BfERkV6CBGHJw1vUzjg==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b061d9a cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=EE5N-t3p5bZ9LH_ndV4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_06,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
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

MFTR/MTTR must raise Reserved Instruction on processors not
implementing the MT module (MD00378 pp.46/50, Config3.MT:
table 6.21). Use check_cp0_mt(), as done for the other MT
instructions, instead of only check_cp0_enabled().

Fixes: ead9360e2fbc ("Partial support for 34K multithreading")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20261113161158.25811-4-philmd@oss.qualcomm.com>
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


