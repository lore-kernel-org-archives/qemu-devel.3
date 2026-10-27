Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B9A606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xg4xnbx9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XvmmjcGr
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmru-0008Al-T5; Tue, 27 Oct 2026 15:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrm-0007ty-FV
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmrk-0002WH-L2
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:29:50 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHpiZ2960453
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BM32ASZC66MaXMj/nErIJMNbaVaFkoVKYSuaBNe6pSc=; b=Xg4xnbx9ijei9gWY
 alFVh9rSr1k959zNSZTQGMh1h87eZ4n033/ady9s+azdS5+CTJm5nUecZ14ypFYR
 967DcEV1Vr1VQlgG8+vtT9WRvAfZHlP48yvYmTIP38ZfZFaAGUbhvE96W67jneoN
 e2Pc2OMfnlsduIu9Xzr2fq7WfAnN3LFzREc5LK+DCUDhTqVtTsYdbW6I865of6Gs
 rt0YyyWdSRBh3dTmZagLuLIA9zmvrNj/cE0yrNElUfs9d9tcidq8S2HjlL5KiU0s
 RVVG0sqGLNRRO3UP4dEjBpPkujYmtwc5aLuyREeDXzdcNdJ+mjTJUPeyVrw9Zq20
 i53ILg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670vmp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:29:47 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb98809caso22951185a.1
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129387; x=1793734187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BM32ASZC66MaXMj/nErIJMNbaVaFkoVKYSuaBNe6pSc=;
 b=XvmmjcGrSvQqgm77caXXNC9/EB24HfoV9kyhRyr938KieGK4l3TYIt5dmJ4+AUPypV
 86ycn0Ope79Ho+0BJ00iT1lld0+Kd3/aGraSi0H/6lcA/wSH1r3c5RvH9KGbIkCs+P/h
 8Z32/nT7XQ0warKi4eltMIea3YjYjvFw15F/wQ+lexKbxG+TRlqj1sA5qj+6DFMBZo2z
 QTmwDv/nOrq5CvUgFfXPSxdDidkuhBV8SUlSWate6CVNL8/f4nsuR2UdI0Wz1xyPl5WT
 jjlUm0Rgsc+nmI1rnHGCznOdq3/Q/tmT3d750dcFiQ7v4vVlGkFhAs1JM8kfjMTxFp+o
 QpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129387; x=1793734187;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BM32ASZC66MaXMj/nErIJMNbaVaFkoVKYSuaBNe6pSc=;
 b=mbkbJOQ0+roKOYXW3MrSfEdjmtB7Ga7QUfBPCMyN3lw91Xqsq7ikVFFHfwxT2dBPgk
 CDQXRCVGGXmkqxwbNwGNWGJCZ9jp8CHISPgL1ymuyWGmkNEkR01tXp9iaa5z4r/0UEwq
 VkO0kZRxtN2EDYbF9YnDu2H+rHLUV60OqcpsuzjDiJiNxJ5/LUiDrYoAo7W4JDBARhR2
 vc5fa6EBrHiXxejhDeAMpwX2oob2/UX4twu3YOpd1c0+YU37pdaxojti/600j6GyiYCB
 gRar1agBIpSkUYTt9zSrxz+ZWphU6nNU4mGFsnqwN1t7saXeH1BH9lcJBKrVRqbGaCIl
 rSMg==
X-Gm-Message-State: AFq9FYKCadL6n9aYB6jg6eIAUB0o6k768p3c7DzFHfDTN8ydBXN35FOi
 FkMgc90n1TmyWY62vMWglGa11eyPPuHi0arsnAK08mPSdPvpDghH5vUjheiF+ZqWsNkxr5oiuhk
 svKmpFOa3mVNOYn1GUFDJBqVb/BSxco7SdLNp+/Uk6pNQ8UNbBQ+oStVwbRsZ5nDUyg==
X-Gm-Gg: AYBFou38sX2SdQGolWcJIhqqc2yfxU3xmoC9L7ffrpLKRqvgv2vDB5eLl9vqt0xtdEg
 ol8R89EYKEQY+497gYHEflvQBgkhDZUiLjO1EVlPhFxY9G8bBZcXPlDL1zdlMP/qCKj1Cm3PV8o
 whD3yEV9NFSjzBeytrjuLKseqayehi1sQF3m7U/t7EYrMi2PdL+H4BKX1Im0v/lLTgVW+/JY4MU
 CsY+XS6Wdy2YJEPJ4S49lfUdvakFnsbWIiQdNd/O0Y99M3BrUwjwSsJsIsA0Zzh+Y2r2s1tnA/3
 XjVvVdK79fIyhYQ2OwU2l78tqvlfZ8yQCDXeorU6SM97Y55rh0DQVM7UyD6THkdNX+b2mMrnFwl
 SxVFy3QvDuo+Y57PC1rIbqQ8Xg010kkWNr0aI4n0saWiV7Ynh9LV2ee4L
X-Received: by 2002:a05:620a:370b:b0:93f:31bb:e3c with SMTP id
 af79cd13be357-940ef939f5emr1728373085a.68.1793129386781; 
 Tue, 27 Oct 2026 12:29:46 -0700 (PDT)
X-Received: by 2002:a05:620a:370b:b0:93f:31bb:e3c with SMTP id
 af79cd13be357-940ef939f5emr1728369485a.68.1793129386150; 
 Tue, 27 Oct 2026 12:29:46 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94ed7b33esm3109745e9.14.2026.10.27.12.29.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:29:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 53/59] hw/net/can/flexcan: Fix FLEXCAN_CRCR_MBCRC definition
Date: Tue, 27 Oct 2026 20:23:34 +0100
Message-ID: <20261027192341.9197-54-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: kCb0fqOSeZ57daFgLbABEvu75U8fmkl9
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fbab cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=KKAkSRfTAAAA:8 a=69wJf7TsAAAA:8 a=pGLkceISAAAA:8 a=zd2uoN0lAAAA:8
 a=EUspDBNiAAAA:8 a=oiMVlQNTWfm3mpZXvQsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX9dPbJcYYIi5A
 K4xZGjU2qyM7sv2NWf7qtP7WLIIgQNt91VXXbdmfKbbVjWXCWwsTM59FsNAm2xTwQot7HZimVEf
 3YH0Xr//5UQkoqP3YXyPTNBGUOqezcY=
X-Proofpoint-GUID: kCb0fqOSeZ57daFgLbABEvu75U8fmkl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4agU1uPDhEJn
 TbLY/095OQYVNoXjo3ek5CAw82zgAmkg2aDdEU0iSarGvwTtStDm8yHC7V3jt32ZuE3H3hVPmj3
 JH784H883CYX91oWkoGpFgBQmuT+Mnu/CsNFqlqjQWZsAjPL2zoSxBqwaTZb6Iyp7u8RqHbVff2
 oRxUOauZKrNQ49Q/rv5/czBhaZ0mnEtcaW3Acb8v0gBdAafC3frk6ZYHcukSNfO5usRz8j0VQxz
 ru8vomsSCJu6A/p4uPllgJzCJnEwad4/7adP1d2tQGfJJu85ty1ED/7w5s8cvzqDt0vEQf72I2u
 XvM9l0WI8xMHgZaxpeG1/7ScY8yaOCJUTi3BqH+yOQquZ/+tHsJOgzqCKTLW+51hLMJLUDANnnj
 bh/E52NLYTfRAC92PvpgEffUPJ1rfojkZ5IeNxFSbJ6/UHDwEEMk9bqANbGoJDSiEddfs1XZG2n
 3cSdwKEn7L2GouVsxPQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

From: Peter Maydell <peter.maydell@linaro.org>

FLEXCAN_CRC_MBCRC is defined as
  (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
but FLEXCAN_CRCRC_MBCRC_MASK is (like the other _MASK values
in this header) defined to be an in-place mask
 FLEXCAN_GENMASK(22, 16)
(a value with bits set from 16 to 22).  The mask and shift operations
are done in the wrong order, and so the result of the macro can only
ever be zero.

Fix the macro to shift first and mask second.

Cc: qemu-stable@nongnu.org
Fixes: 3c4e23cbb597 ("hw/net/can/flexcan: NXP FlexCAN core emulation")
Resolves: Coverity CID 1662973
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Matyas Bobek <matyas.bobek@gmail.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-ID: <20261022195924.672606-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/can/flexcan_regs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/can/flexcan_regs.h b/hw/net/can/flexcan_regs.h
index c18bc4736e5b..7923bf836ff8 100644
--- a/hw/net/can/flexcan_regs.h
+++ b/hw/net/can/flexcan_regs.h
@@ -150,7 +150,7 @@
 
 /* FLEXCAN CRC Register (CRCR) bits */
 #define FLEXCAN_CRCR_MBCRC_MASK         FLEXCAN_GENMASK(22, 16)
-#define FLEXCAN_CRCR_MBCRC(x)           (((x) & FLEXCAN_CRCR_MBCRC_MASK) << 16)
+#define FLEXCAN_CRCR_MBCRC(x)           (((x) << 16) & FLEXCAN_CRCR_MBCRC_MASK)
 #define FLEXCAN_CRCR_TXCRC_MASK         FLEXCAN_GENMASK(14, 0)
 #define FLEXCAN_CRCR_TXCRC(x)           ((x) & FLEXCAN_CRCR_TXCRC_MASK)
 
-- 
2.55.0


