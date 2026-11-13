Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E487606A89B
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FIwGMqOe;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=clx4Ar+W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtu4-000258-0J; Fri, 13 Nov 2026 11:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttn-0001hV-OO
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:14 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttm-00082F-0u
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:11 -0500
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFQqC5074657
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mYGoX92Whs5OL0e5J/OnGOBrciH3SVbsQ/jViGJ1poE=; b=FIwGMqOekHRFQGDS
 WqmDOxAmD4/uT25mNxhmExn+uf2yfZ++bAw0ksJ9vx7W/SKn/qEF6wUk7BPPeeZq
 ExRcn4Iq2hqYROd82PWQ9OS0XpgAYMy6nqmiUeUuUfkgBA0b+b8K9aM+fIVLSL96
 gSgTJwdii6z+GdKl7gQHunpZJKX8KHLk+qAlRd7M2ZGLQjFbVThY2Joc2VIdEKXo
 tO5lRYxw2xETjlLS75S8DQVtD3tsIeetCNHVbM0TGREQkuGw+L8BDtu7PfuGpAEg
 Oes251jsiYv+vR7MNW8U5N6xOsa6JSarbzd3ENX6oYrvz+45tADmx22tgYj0/Tdb
 AprSWg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwu2mtgx9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:08 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-9806e283b0eso1089420241.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586387; x=1795191187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mYGoX92Whs5OL0e5J/OnGOBrciH3SVbsQ/jViGJ1poE=;
 b=clx4Ar+WFGse7lWkFkG+a2mF6rXt6l0cxqFsulavTEWSqSjgm8EfblXklXw8xKeu3Y
 z/QqCcfklaZAaflaXw6Let4i70dzoctAm5FoUjtBViP07IIyq3e421mAB3ObgHp50wWo
 myf0Mkf0Ol4ZvrmEzvcJC9pUxVfE3AN6PusaAEm5kuS6WocLdvR0yCXcNpBFO601hUV2
 WpPZKUayZsw9sXDQ2N3HllH5LdnJQ09L2sNJLFyC7DZz86c73Dd99TyWYNlt24fKgnjO
 mUsEd88CC8MP0wY0rnilYzOSdcW79cybTmsLtd78zjbTpOBDUL9iyK+ThcKKsA7mBJag
 sLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586387; x=1795191187;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mYGoX92Whs5OL0e5J/OnGOBrciH3SVbsQ/jViGJ1poE=;
 b=pdqo7IrDEZtpeunFUAnFViEhef2mexI6P3NLqdmx9DhFHebQwrvWmmG+Ik6j8JVUci
 Is+ChYRmSS8O6sBhIjcdWxC6nSRrH38GZ+R3egmuVZ6Zt2P5A2DiolJzAp8KpF/0JS0W
 wQgfdKCvtrVt2xLdHLCbrYO0ikj3OPHJ3AFgANgxc9baLIUKFS/CqjkkWU1G/n4fMIOK
 SY7LxsYiWWcpFmOzD8K31XiN+L/+UWyAftBkptYsPvkbAKMYKFAbUclCOF5Vt+UCptnO
 HrwViISbVjC9Pcj2U51tkBW0TcU6BChPCWE8ObQelPePzV0U2MoDIu3ZgLpyqOXzqadp
 O9bQ==
X-Gm-Message-State: APuU4Z/3mnVUGjNmdxb+Wz3eq2B2huxGvkhiVttKpPSOXAOHG44IwBhq
 yUmRmjpf0mdVZ9TyaUYbVRLj9dvA4ynL/qKCndb/+3FESopsEfU2/usX8sQwAxhJrxYqIt8Ccf1
 DyfX+b+sUk0yCz4LYzLBY1YPnTrBLSYwNl6eHbWGtc0H2DFS8gwM0NTsdjEX0ARHQSbem
X-Gm-Gg: AYBFou2CLGDCIV/Ta09RAIaAdx265pkkgOvhsC2hkpFsu/kQ33hnCsXvCKU2R+4XyRu
 YbtljbGuBaFrqlCD1OR+BwqczKDP3U3bNA1o7tOub0HF93xJoLEIrmQKUM/Jf1t7dhU7EtAVggb
 v0jxjanID/TuOHsA8M83XuTuNBfZOlPmUiLgEZ+2u4Edd6nUlhFELGh44us/p6sELhaa1ebW5X6
 hmOFuIVVReXNz7A40Gz+OdH8ADbZeF4Jk7QFcc9pxmNwFxi9SRQd4zdJbvP/CpWR+dVsuC9VsG5
 JsekAZZWssKiP6txGGZ239+Uf3YiTNZ4m+bk9bdcKspNVpt1UkpR1aIllUU0/w4oISlSr9XBBdD
 o9fWz3t3dysnyJlw/SwOZmGvQdWS3x0Ig7Ijz+tnVPTD+cKTg8CalNCjxstqGCcxfNQmaSUlZnD
 B6LE8Vv8B8/xFm6g==
X-Received: by 2002:a05:6122:469d:b0:5c9:c60e:5cf5 with SMTP id
 71dfb90a1353d-5ee34af963cmr1357072e0c.19.1794586387205; 
 Fri, 13 Nov 2026 08:13:07 -0800 (PST)
X-Received: by 2002:a05:6122:469d:b0:5c9:c60e:5cf5 with SMTP id
 71dfb90a1353d-5ee34af963cmr1357033e0c.19.1794586386592; 
 Fri, 13 Nov 2026 08:13:06 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5a32d336sm6962739f8f.0.2026.11.13.08.13.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:04 -0800 (PST)
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
Subject: [PATCH 08/19] target/mips: Fix microMIPS CACHE offset used for ITC
 tag access
Date: Fri, 13 Nov 2026 17:11:46 +0100
Message-ID: <20261113161158.25811-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8cr1JD4iYyL57pKVH_pvcQB9XVciLEgj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX728Q56b9GJ0W
 R/gXoSxiEd7sfyMu7gWvW9it90RVmQTGAqnnChs4MVQ2GO1M7STxjww3xgmcwvLgTQ9OZIHoG+u
 5jVhWz+sUE2bix4IrVtdi0gO2l/6voSdPNVsvudfPOiYpwEzh0a7qYfeojFVxo6LlFLRpVImnE7
 6qJMoapu+30KgVkLW0oVLAbOOhJjrQPaSkVRGGiZzXgH4JPDiT4NQoGgp0A+NI2VcETwpbUw1VQ
 HuR65ILn9oaqKGXFcUb8cvUPtzXpIyHEDT2dwXHYH+gvpHP16hlUwZPMvkcGUCD0E7++wKlsN9n
 dFIOLdPEGPs9BasLoFU4XYvtuFCMp/w5fEfeWUcsZQBFPFR8/+fhrubK7zs7vRrdh7pOCZ3s8Ob
 hDmP2gCKQkmt7e1tEOqUXV+9UxLcRihGCskvMsv6xoCppJFpGjc3yV4RIJ2pBLdn6J5+Bj7vijo
 XMWBBRHN+rD7FMzoeOQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXxF5HvyXxlgJV
 R0ucbcISS1+W64AmhugTh2gXctqtygdwqcAMHqfOuiTb+CJDwPqmhepFZXVBHMJqDIxZuuAmgaD
 vgrIffNX0kcrCt0vYr7LnVczqkFdXQg=
X-Authority-Analysis: v=2.4 cv=ddQVTnXe c=1 sm=1 tr=0 ts=6af73714 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XhDUckIsx3SLW6361QYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 8cr1JD4iYyL57pKVH_pvcQB9XVciLEgj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
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

CACHE is encoded in POOL32B with a 9-bit signed offset in bits 8:0
(MD00582 rev 6.04, p. 144).  The decoder passed the generic 'imm'
(the low 16 bits of the opcode), which also holds the minor opcode
and reserved bits 15:9, so the ITC tag access used a wrong effective
address.  Extract the 9-bit offset, as done for CACHEE.

Fixes: 0d74a222c27e ("target-mips: make ITC Configuration Tags accessible")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index 4ad2b699615e..21374e3ec60f 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -1820,7 +1820,7 @@ static void decode_micromips32_opc(CPUMIPSState *env, DisasContext *ctx)
         case CACHE:
             check_cp0_enabled(ctx);
             if (ctx->hflags & MIPS_HFLAG_ITC_CACHE) {
-                gen_cache_operation(ctx, rt, rs, imm);
+                gen_cache_operation(ctx, rt, rs, SIMM(ctx->opcode, 0, 9));
             }
             break;
         case LWC2:
-- 
2.55.0


