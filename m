Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D761606C570
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lDwXBVtY;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LgNu1I7w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtth-0001RA-Ty; Fri, 13 Nov 2026 11:13:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtte-0001HR-33
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRttb-00081J-UU
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:01 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRc7D2638635
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OAlKAiD6193RFZGaoBMkGFmPfLgFw4tIRI2bzGNVdIw=; b=lDwXBVtYAlzQf8mI
 oIwhxZgbVUPTzk7kESI1fiXvOjQ0NbFFxaUyVv6/nRpOABgaWxkA1zG8N6deZ1cw
 /Xg/Ahedtaq8CU5EOsDpvU2FadjZ4aXd1F4aWiJjoOAMC4TNI92nXA7Jb++wH2cv
 56cE0q3TkDfLWNDmtEwXZDSZ56xiOsYwt8oR/ChrKtLH/9oI9LwdQD4ZQTH4yaSv
 9acS/35dZ3RknusFzpuuSBRHH7NZ9lewY7Xn4v4wwoyECTkJFHkg7fV+LF5Ai0l1
 OWQSHY7a3QIOOUPbwyrWVKntM4ngko2PomzowKYzAfQ+kNKApZ7xNjNbCcWCZaqk
 9H9wVA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hww5ra0n5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:12:58 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7d64f59c80aso1029621137.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586378; x=1795191178; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OAlKAiD6193RFZGaoBMkGFmPfLgFw4tIRI2bzGNVdIw=;
 b=LgNu1I7w/BSTMsGi4EYjGN4Nn5RLfdq231/ZwLTVbCHTKEcS+90y2x4J67r4Ubwerg
 dXHcFOOw1i+cXjXMx8t+liSHp7EkUdCevrKveK7jVSt9D0EgYxcPW75Lw9U6oyJW/O8v
 O2cUrt23ZP6cleC3STnLGeU/45/94RaEvvTBUbOdLmFt2K9QJYftIOmornLfRKlJnRud
 Q4vmQG64aT+PZTWpriKFQpjXThrg7vtGhN+5J9E8XWtQud0fwNvfm2g2XcJ+N/nBod1x
 frIWouJ7RVyA6mxfyI/thYQy3E3D25UDfMOUK7SmcmMipxrpoSlKRMzoMhfX3eqdzeqc
 ny5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586378; x=1795191178;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OAlKAiD6193RFZGaoBMkGFmPfLgFw4tIRI2bzGNVdIw=;
 b=aF7byDp7i2w26dGFxtQ/vDblWXbHLDA63cM5/ET8C8YSXTOMc3yX48xDUF4kaZwwMY
 VV7JbiINu22eXtcxJdoG/KQeaISXj8HyFpMI5WmPeHLUMZypztwqmXcukbSrwosDNe13
 cn8MOZbzuI0tT4w09QMjidcErHxBYyWlfLRngUdjGL+DedumwSX5YFc89hCtVwciznTt
 bs4rUM4Y0IpcJuxO5xOGnTdRePiUarYp8Ww8qLNpeQxfT4hnOOh0mK0GCATUk29fNL9W
 11+2r3WXIDwYkfD6Dp8j/LaWMSMra+Dn9WRsxmmpioW9xTB18TuvIgUG0SEMkxY3t1Tp
 o6Ew==
X-Gm-Message-State: APuU4Z8SmvY440q3SSAFnn1tb5zkkvBL6olZ1npb924/IsitWUOqzKgy
 fxMXUOSXyjvYGAph78B6gf7kwAlI5LjLJTl02msF15ic5qNvf6wO3nMTDThMj6AO/UguId8baGP
 DGmza7ibFcudSisdPDnT/gp23tLaWG9Gt26QOqhwx+P6BeHooXBCNajXoz12WUy9Yjx/r
X-Gm-Gg: AYBFou1XQRX7T3j5el8NDulqVdqMdqVU329tedOIWmThqnDp70wizvo5MhDSTeDhvql
 SOXB02wX9tslf5IolaVmJHbNoQrG0J6ONaRV51xw2otbyWsVxCxPJ+11Vtn3GUb9D+lEZsctlig
 VIU99wrqsT/sEbu2uwOGGZuUV/w2UIFnFBgOhhN24jDRBTETp9rs29nsOBDRuMbYfc1CiPCPbCn
 gaOyEtM0XQOdyiDOSAyp/OUzgBQzSZWq0wch3mTiI0/022Sf4ZdvmPUIqSORnZfE7VBxIkRdbuJ
 EXQSOMThgJa2NyWnQzDt3oC9TDaoyDg5Q/MrprFjGq9bH29IA46ciZP9189MTlHmZkFC5iKqWpQ
 HHcKCoNxsdXJx7ZYqmYL62nl3/AhclErDRl0gXbIJkAOaaW3JkVRWvxxgWl+PhIUv4aOxYy1Oxs
 cLdBmjw/VOIPySZQ==
X-Received: by 2002:a05:6102:6882:b0:7ce:78f9:ae13 with SMTP id
 ada2fe7eead31-7d6317565f5mr1935281137.10.1794586378174; 
 Fri, 13 Nov 2026 08:12:58 -0800 (PST)
X-Received: by 2002:a05:6102:6882:b0:7ce:78f9:ae13 with SMTP id
 ada2fe7eead31-7d6317565f5mr1935273137.10.1794586377640; 
 Fri, 13 Nov 2026 08:12:57 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c0e0dsm5877751f8f.15.2026.11.13.08.12.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:12:56 -0800 (PST)
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
Subject: [PATCH 07/19] target/mips: Fix microMIPS BC2NEZC POOL32I minor opcode
Date: Fri, 13 Nov 2026 17:11:45 +0100
Message-ID: <20261113161158.25811-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXw1jIJSsfNRlD
 TS0bnXaEO7D/+NFRqzoP9ezY6owiu3zIPF5Qii6vvYINXy0fNLGFbH4Hvx5ZOIrufcoRLc0nUav
 SHxLXObyXGq9vKYC0OD2+X3yNPhH+Q+OBTQ7/tohD0Kab4QTs1hGN8qcL/1rbdRA1bVtsn0w+0Z
 u5UDfHbkPh6JX+58aVLRdlR56vKOwtFBlTw/iePBw2no3+HPDYTL+LgJ8bt5mmpdnBGdRlaiuCc
 /0cwJDkbVYen7Af7Q5Ag3Y4QD0Ajd7CNxl8M8zwrztF4urKw0yH2vpsME1+E7k1kG+zYD1JSjls
 lUeMwwdMPe09HvbLaIV7yH0TDHt/ke3PiNeo5lBV1sphhF6zGaglc/CZC3GwTcchNHtmL5VDjr3
 RxsDg1dJNW8H0L0M91gtWfLR7JIZ8JlK4U7T2pGKXpUlqdvaMWpKbUW/E2k9TPKSuvR89owasan
 vf5zN9O2RtFOqHaVN3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXyHccrxdfYQCY
 lDXVKB+1qnzZM1j2J7mMRKWUgVAhUNSwLrnU+owzG4yiw15kX3lHhSCRsyf06l5fxQNk63iUPf6
 39d8KZOSAGGAKOrGh/ygSf9RCWRgScI=
X-Proofpoint-ORIG-GUID: QNIkR-H_KBygLqqc3MMiCMeHXkI_3QGA
X-Authority-Analysis: v=2.4 cv=Vqq2kO2n c=1 sm=1 tr=0 ts=6af7370b cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=WFrJT7Q6A0Mo6TPDIPEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: QNIkR-H_KBygLqqc3MMiCMeHXkI_3QGA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 impostorscore=0 phishscore=0 malwarescore=0
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

BC2NEZC is POOL32I minor opcode 0x0b (bits 25:21 = 01011);
0x0a is BC2EQZC. See MD00582 rev 6.04 p. 131 and MD00594
rev 6.04 p. 145.

Both constants are unreferenced, so there is no functional change.

Fixes: 3a1f426828cd ("target-mips: add microMIPS32 R6 opcode enum")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/micromips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/micromips_translate.c.inc b/target/mips/tcg/micromips_translate.c.inc
index d6a5c2263b56..4ad2b699615e 100644
--- a/target/mips/tcg/micromips_translate.c.inc
+++ b/target/mips/tcg/micromips_translate.c.inc
@@ -513,7 +513,7 @@ enum {
     TLTIU = 0x0a,
     BC2EQZC = 0x0a,
     TGEIU = 0x0b,
-    BC2NEZC = 0x0a,
+    BC2NEZC = 0x0b,
     TNEI = 0x0c,
     R6_SYNCI = 0x0c,
     LUI = 0x0d,
-- 
2.55.0


