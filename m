Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1376070FC6
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pSm5PjZA;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZjRMVI5p
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtui-0003Hx-JJ; Fri, 13 Nov 2026 11:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuI-0002vG-4d
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuG-0000KD-Jc
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:41 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFQxMB2022395
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qlZIbtnXxFnmctj3zY+hueRynjoyYOlYTCZHfsRzkMo=; b=pSm5PjZAeRB7XEVm
 ywi1wOnuNNnjnWmOwvUbDTLzpZ465eMsnQPxqHzamsD43ZtlsSaoATmMCttYdSpW
 ltOle8+Y8oiE+PvLQLSSgWqdrOzmX/AXzuxghudgMmCUIO0hbZ+ujsLB8/EYL0SL
 q+fDP54gjKPVvHedKXNfDlCCBeTnC/8X7D6NzohYBxqStiLBnVyV0NzEhVWzZiGz
 +NnJ/fOp4bCaW2iWVpSfYFL+XH0ZhVtDkBUpMJZ41iZ5+Q5+a87dL7VxzjsfErTX
 Be+jt8hiMLhRSXWJ81d0YgY3Vl0eqX2qPQSwqaiEpIwBQxj0x3LHUtn1kl7Ulvyi
 8/HmJg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g219n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:39 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-99939c0007cso211070241.0
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586418; x=1795191218; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qlZIbtnXxFnmctj3zY+hueRynjoyYOlYTCZHfsRzkMo=;
 b=ZjRMVI5pUZ3NNiT7snCJ3kVofSEtyFHcQU2m7nSwV40x9MD8UhaNEbw2wQvd7sZuL2
 oKTa7oUTiFMwdp2yGavw+NMUNzljuFQTXawQbIvMk7DcINQKQcMCUtKJHk6XgRD+xFSw
 2M+jzSEt8SgfaXOzVt+Laazo+r29JNJpott0B1bXTqucYcnI5zbKSmYQFlaX8X12T9pk
 o+iPUkyjs5wpH9s2EutwBkOduypoisLrDI24NhiKSTBfFd3p5k0BdFK92t1q3CVhIa5N
 wmlRmr64e7sluImwdmE6Srfhz58N+nDQzZ6sPE7QQs+7lmRcpEyTm9DolxIBOYkEok/z
 BpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586418; x=1795191218;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qlZIbtnXxFnmctj3zY+hueRynjoyYOlYTCZHfsRzkMo=;
 b=uuQKVy92WSFn6ddw8reVeBq50xncXwiKEd+Sp9uYXZCtQo453Rv0mAjR+wDgwroYuT
 S0VCGKWLAO5nu4OuhzFos+ilhm6Oy3XF0p08k6g/BXxmLcXWBoFdwtnjH2E6afKdfwmt
 r0DxHvGeJUooN6aee5nCshlouekGSDlI+n5x/KBuRVsR7GOZ5wjfQ1AIfhulC1pHujRP
 jeSznZDW4OFQkX3krKzCUx6bCAQnDd7j9/AodZvIbnUtj04a4I5Yx0t5Sfz1GikkpmoW
 Hc0yHQHZ4v4X+8lnc6xwFecpIfupntNenIGbZjMS1m5Z7wdPqhBnucNUcqshM5leGJJu
 L3Kg==
X-Gm-Message-State: APuU4Z9gqDAebgY/4O8xA2WZQlFzvin8mcsWbELDroNUn09TVfukpz+7
 s8waC1OgcQDNnORIDGhclxGhjk1botTfrRljIjmsnnErFO2ejxiGGqsRZvC81QLm6RGj5AAVrwz
 Nm1jY6dbWnO2rMYsEr0yx+DHmRZc29xU1agTg/mTNO7ck5UoEkCXbKMRayGl4m4aA822K
X-Gm-Gg: AYBFou0JFD15Yef30tKH+5AL6tQoVoUKJFfpo5Hrfat5IPWf9korEk01zLOVcR65z8x
 DUx/Mv6k7obHZ5tS3wsyFXdfI+aUqGw0UUOy77UDDI+dunbbe0PixIUBHrkLG6eBtxxgXfQdAPP
 HOcW1cqShiiuDdNorKt6m+LHWLKh0gvxQgWbgC5aK+jjKpyQpuWeQzYVf2wuCekKGCoq0Insdfn
 Eh578ImZc1dNqMI3K7LKuBkF4CDqRc7hxozjZ9Sxr7D7kFrpzq0rpAC/JM1JnpgrHD0HqhZV5pd
 hJcZ31hf3HZkQY7yO8EfenFfhl4IHfdhc2P1k6zrtALMBDOmHSaKa4Xugq79OBdaR10M8+xyFQp
 O+iAXU2V7RFU7zc7//l5eZmmJTmji781r76FWt0Bzt5kTogxaDE1L1Y8fXNOYaRFMEwyLvz7BoQ
 Su5EbPOIDrrS31OA==
X-Received: by 2002:a05:6102:2c85:b0:7cc:232b:f5a9 with SMTP id
 ada2fe7eead31-7d64d80d3b9mr880327137.24.1794586417794; 
 Fri, 13 Nov 2026 08:13:37 -0800 (PST)
X-Received: by 2002:a05:6102:2c85:b0:7cc:232b:f5a9 with SMTP id
 ada2fe7eead31-7d64d80d3b9mr880317137.24.1794586417301; 
 Fri, 13 Nov 2026 08:13:37 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae4414sm74772085e9.9.2026.11.13.08.13.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:36 -0800 (PST)
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
Subject: [PATCH 12/19] target/mips: Fix nanoMIPS BC1EQZC/BC1NEZC always
 raising RI
Date: Fri, 13 Nov 2026 17:11:50 +0100
Message-ID: <20261113161158.25811-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXyx5cJI1uXPWK
 3pJAIHSnMbmsDZwjc8DTEKcF1n24GdgDvIECtrE9VSV49Ok3TBAIUvygSz2WbtNUMRzsrbBzsGd
 xdZpA2G8qQgcoEG6IfJsEg+tyIlYYPB81uQZaUqnILlAF2EWa30QqtPvPamp7yhxs/2S8XY+PgW
 TLBmjPAeGg8g4AvAhS4kHgP+tLgumRnP4mGwfVDJYvh1XQnkvu+Dcy9SnlNUwMjU1X71nxz0zzn
 hXFpbh9xUfIB6NEJDF2D824q9QjXibNHk/eEjpHPmHZrmUj3SLZEfe9js524rEtjel2kOf9ZELV
 WK+Xg6GhaPwcnPnuYHdxOcOaoIvwFjUkuY7TDeEbCzMSdFBXLC8OPXQgUjO9BErBGql+DZJsPcO
 8asgQ1Rj5UFciT2kca7s4rTaWlhzLrXKEsLZzCyRilNVfIBcLS5Yekcd/1M/WikAt/emuPVcmtc
 3USV0Dz0EruYTLIR4VA==
X-Proofpoint-ORIG-GUID: 3tjI9aaK8hM9X23pydRg_KlIXXGwhE_Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX/YgWNEGiWIo9
 r747Q3g1dJYJDb0WrbmsEchEVr2IlG3aic6TeB0xg/7LwLHFZ6TM8wE8rYHOSMtKq9M/9XGgzOT
 vnMqgNbTnOtMx5dSqayrCWnHqgzw2N0=
X-Proofpoint-GUID: 3tjI9aaK8hM9X23pydRg_KlIXXGwhE_Y
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af73733 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130064
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

The P.BR3A decoder passes OPC_BC1EQZ / OPC_BC1NEZ (the MIPS CP1
opcodes) to gen_compute_branch_cp1_nm(), but the function switches
on the nanoMIPS pool values NM_BC1EQZC (0) and NM_BC1NEZC (1). No
call could match, so both instructions raised Reserved Instruction.

The P.BR3A encoding is in MD01247 rev 01.01, printed page 288.
Switch on the values the callers pass.

Fixes: 11d0fc10b7ef ("target/mips: Add emulation of nanoMIPS 32-bit branch")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 5941889b617b..f9dc573dbb01 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -2558,11 +2558,11 @@ static void gen_compute_branch_cp1_nm(DisasContext *ctx, uint32_t op,
     btarget = addr_add(ctx, ctx->base.pc_next + 4, offset);
 
     switch (op) {
-    case NM_BC1EQZC:
+    case OPC_BC1EQZ:
         tcg_gen_xori_i64(t0, t0, 1);
         ctx->hflags |= MIPS_HFLAG_BC;
         break;
-    case NM_BC1NEZC:
+    case OPC_BC1NEZ:
         /* t0 already set */
         ctx->hflags |= MIPS_HFLAG_BC;
         break;
-- 
2.55.0


