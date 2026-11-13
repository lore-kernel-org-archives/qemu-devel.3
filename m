Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E29606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=irYOw9Qj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ek6VsbKs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtvU-00040I-8R; Fri, 13 Nov 2026 11:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtue-00038Y-Bx
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:07 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuc-0000M6-IN
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:14:04 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFR6DX1189971
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pbifW3vH4+U5fc9kCbHfQK1xafsimJPqa/qvfpICViU=; b=irYOw9Qji7HnqODK
 Hgh4UyyJ1PlbpQQzyUq6FuN9hdz0Ky9QoAIcwbqAFX0lT1FfQEvdcgd84NtkOJks
 E1CkXgHk5ODDiWyRR8USllVsYADMU8+4gomOkaYM28aZBUEn92KMV7q+TqObjrMM
 I/keOu2J2wbYnrRp01jxNnV6L1+GMBfPzvdst51KZNUR71Fr0l4oJTD/ZgHBU3ii
 1lmgWPW6bp0mROF8Ittljym6APEV0j7q1hfAH7j5glRfmf9XVg8+aXPsB0E+MNnB
 0ZP9yVqrhFYVk06UcOfgWEr84sRO7N/uo/6douvf4YNzCzdQ6f8QITqUjolT2LG3
 LksVjA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwqufk4xd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:14:01 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9997828d6c2so114301241.2
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586440; x=1795191240; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pbifW3vH4+U5fc9kCbHfQK1xafsimJPqa/qvfpICViU=;
 b=ek6VsbKsk8m+vjD67nS/NP2UNclKOWkP7XWoVBmZi/YvnJMtgxPShZDsQa97tLUQml
 oH6snYWyz5HdnhXWHg70ZlK1RjrMBzZ2fqBFpbKPC0p9KR7rK4chA0mW+m1RVsIDjkKS
 xAlXwZkBAKXZvXiV9St+Kp9lDfkvphD8OQmG5QRvz7lRL1piE2mUzaOVAI8Vz/syv055
 X3ooAKd53YF3mEKygKbVSB/W2gdDPYqQU5j/vUvBucF+H5jnzazdyJdNk+to4bk927uV
 98vYYC+dLNqm6pLXxEzR0YIo6kFZ+TCFJrCfdL3FV32PrE+y5L18sR8KTsXwhdJZWTDX
 VhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586440; x=1795191240;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pbifW3vH4+U5fc9kCbHfQK1xafsimJPqa/qvfpICViU=;
 b=n++CjNZpoFU9Hvl7Y+1Ini2r8jUFVFpEwR+Z/OTI9UHjrs/5UftHRNpRxB5Mh9MKT+
 4mZyW9Kaiiy0FQAZ/gL9rmFuVh3QMjJt+6XBh1th4NmmYgrDjg6dAmNAJ/oBgnIy5Yft
 WTnXYTUtE79uuu055o8QPrKZeHIitfOy1BihoRiPSScRE7sCM64CYKI4HBQH5qY0cwrZ
 GLgOaByrXayHEAa+YJsREZVr15bL/wpSSEF2UiV1BxC5fgnGCP+JJsBa2JXv00s0XCpX
 K+V7MDpMIIH/oIC434/e4Q3OOzQNyTTU1r+pJIliBfQDSaMmDmQwuGksoGpr+fBJt9MB
 VYmw==
X-Gm-Message-State: APuU4Z/2QQgO6E1DI7SQavQxpx83P6UmOgUxuH7/kSOf0BSvyXQ8RsRx
 Ajz2nvWIPSwV14P3Q0wY+U3cMvFBZuKgWMy0PiBC0FSwl56rAf4uosuj1SX9ufDqQw9tEESX5qU
 c+OxAG2qT2/G0nVgHjAyIvAhHUx3v2mel8VDEjWNbQ6Vh8FZm6iVkWNX9njY4Ag3gL+jT
X-Gm-Gg: AYBFou39ku4ZibbeZ+ewYNjo3eitCxHddFS2vzyBPgVRsDZirrnLG0kemwdctruqWD6
 y7015HXOgN1OjhBOuMkWy0H/keaHyRQgp6kk9SYAFMwi3U37zxgpP4zR9mn8BTN4LCqp0VT9mbM
 AJerYedqffDnH9aMOEmc1GLiK7dxk+PQ0V190TlyKdCpYeF2WCjTCC96EDLxG/ab+EpTGIU/1FC
 4T81i9oDBtYVdhT1jkjhborVYPB7d+kMAEe/K+cnmGwBQyJPdCe9tJiFJo99I5dZ+pa1h1gzisz
 6RQNF/pB8gtHQcrJ6v9k7ykcnsL/Z6mGTk1AbPIvXS9N+0mU6BhGSc2uB/nuBw5DPX3pINb7AjZ
 Rq6W43kw42p+0llsbNMuLdrAnx2TyaRLVp0cvicN7+lavCQcl5x6jemRcGVJP5Ayl87w9Rmo98l
 EgU/Ff2wSJO8NFFA==
X-Received: by 2002:a05:6102:441c:b0:7d2:8cb8:dbea with SMTP id
 ada2fe7eead31-7d64d865a22mr800692137.36.1794586440094; 
 Fri, 13 Nov 2026 08:14:00 -0800 (PST)
X-Received: by 2002:a05:6102:441c:b0:7d2:8cb8:dbea with SMTP id
 ada2fe7eead31-7d64d865a22mr800685137.36.1794586439623; 
 Fri, 13 Nov 2026 08:13:59 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5720f6basm32051135e9.4.2026.11.13.08.13.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:58 -0800 (PST)
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
Subject: [PATCH 15/19] target/mips: Pass the nanoMIPS BREAK code to
 generate_exception_break()
Date: Fri, 13 Nov 2026 17:11:53 +0100
Message-ID: <20261113161158.25811-16-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: rpkZTzK_E3F7IDyMvxoYQ43EI6abDG3H
X-Proofpoint-ORIG-GUID: rpkZTzK_E3F7IDyMvxoYQ43EI6abDG3H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX1qGbN7vJK9tO
 gk33VYB/V5oVKCsITMhBLWQE/MfzFh4BatvwqkjicXB7qoSiPgU1i/gF8Sj1RAymlH7lCYzkWP+
 hB712xuvNhPIOmKhmySB3goge5EbxC5ouJtuMvLqJQvSeM1XeFTMiMHqBiqx+DISxh4h60BXn6R
 8EtrE0d8I4gHfaS51V7yud9FPV0rE7GF5u+0fiVix2YpGHOq6/+pWu5vHqzl3Yn+40A8TgeF+VA
 Oy6b7ByDi/Xi0MuSVPmtM74W7DCcc2ixmzLRd5aw0ISR64D72q9NM5JE7dyPiK/n9GmwPYN3oq5
 GZEqcIy9HWgRQJmcysoMvGoQY74ZIrD2SADm3KbPO5Z3pPmoID3KCA/KyRsiwI9I166NjTUC5nU
 Ye9pSBLeQtVK/Ba1z0uVPE5EgbqI6c5bELpvsiZ7yI/q4qXtJkoJWTXVYGvRfMOmDlxBrwh24SJ
 Zqn/jAhc56+1INTZAtg==
X-Authority-Analysis: v=2.4 cv=XZocX455 c=1 sm=1 tr=0 ts=6af73749 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=8IlIMGR4T542jAIm1n4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX4Wx8Ag/XC2Yi
 4HgBz1Tauvi05IuhSWJtJTqpGpNI+pqMBsEoae1Xzx3LF5Ce9xfWkZXRaUpcTxvdLvlU/zwInTk
 x83bg3T3bln7GX1fn69FR9+uSDYn59A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064
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

The nanoMIPS BREAK[32] and BREAK[16] decoders call
generate_exception_end() and drop the break code, leaving a
stale env->error_code for linux-user. Pass the encoded 'code'
19 bits for BREAK[32], 3 bits for BREAK[16] (MD01247 rev 01.01,
p.59).

Complete 6f3533dd1b6a ("target/mips: Extract break code into
env->error_code").

Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit")
Fixes: 8869ad02bfd9 ("target/mips: Add emulation of nanoMIPS 16-bit misc")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 524972b24a98..3612c68561fd 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3545,7 +3545,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_BREAK:
-                generate_exception_end(ctx, EXCP_BREAK);
+                generate_exception_break(ctx, extract32(ctx->opcode, 0, 19));
                 break;
             case NM_SDBBP:
                 if (is_uhi(ctx, extract32(ctx->opcode, 0, 19))) {
@@ -4481,7 +4481,7 @@ static int decode_isa_nanomips(CPUMIPSState *env, DisasContext *ctx)
                 }
                 break;
             case NM_BREAK16:
-                generate_exception_end(ctx, EXCP_BREAK);
+                generate_exception_break(ctx, extract32(ctx->opcode, 0, 3));
                 break;
             case NM_SDBBP16:
                 if (is_uhi(ctx, extract32(ctx->opcode, 0, 3))) {
-- 
2.55.0


