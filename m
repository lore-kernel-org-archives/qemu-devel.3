Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D12606A896
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N1id9scS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=N6PUTkNI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtu7-0002Hh-25; Fri, 13 Nov 2026 11:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtu4-00029c-GR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:28 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtu1-0000J3-UZ
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:27 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRScH3296068
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IsB91tZEaQMNC0KjOSMFbwO2oHqe/XFTrf8C/AxK2Pc=; b=N1id9scSN8GIKQQn
 N1zjizGyWvCluWYBiQJ7bzM4iRBqJyQ06PjLkTwwFRZWv1dWEBABc0PE4huCSPD/
 JURol66RzOsfDR7Rx5o5dEh2SvhZT00lvHUMFQr0h/tpP3n50z67OEkfsetoZ0jX
 Df1uwLOXaewqK6L1O4TGDzXAepVPVH3gfMdGPlxRc0fFXPsNBs+Lr7Btmzw4bbuZ
 2Zgeo7ubH443PlTInyslN4uaoSnocloUUv+A91gN2+LSK2xVc0NvujxU/VBZ059A
 u7jMGBSneWjWHKWmszg3f9Pub5A4ZS2tVeZLHCcKrL+axJAAv1qkC8ac9PBrhQ7Y
 +VL6tA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwvu6t3sj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:23 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-7d2d60a8bf5so169963137.1
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586403; x=1795191203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IsB91tZEaQMNC0KjOSMFbwO2oHqe/XFTrf8C/AxK2Pc=;
 b=N6PUTkNIpzLqfO6Ol0SL5FX0qv5UuNUfTVn986D0MJzIUwlTAdjIO/2rgnXahZzi2n
 5GEE+4J5+99SmEDgunbNco6Y42jKpH8Q1EXjVTVDhKsCzt35S6/a6nwWHyhyNw4fMn/5
 vRnmMpPVgQxIg+kzrwFM9CJeG3cMuIVZ39creA+UqpkvfdmfxY0+GfSBWd0bJdFKYJC9
 4YsB7kCO3i/mceW9FcDuQWdwipf8h1lT4ruu7m48TM11jOroAWU2bGiBbKtocUjTXZTp
 xUYBuf8muz7MBj4IUjbT8JQB1JT5AtsPH85CRo0JpEP1l8C8FWkBs3cYkR6W84Z4KIpq
 EMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586403; x=1795191203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IsB91tZEaQMNC0KjOSMFbwO2oHqe/XFTrf8C/AxK2Pc=;
 b=j4LcmhWSZAluN1yoLMzsizVAV4pwFXXePec6OiiixOxT5IDcCdmMgpPDEUmxQTeRYG
 e/Lpzpu1nCL+Np+5trLOKU9p4QRnH1rLLyrANDNgCf3HYvNhPuNUz20+1XRs4dSB8rkr
 +QkQ0CSDrzmyOnsdtXXfqEDanjs/OY16e6g8DLpxYT9od5ewKMPdaJxugo3bGqgUhPQ0
 LNGEb7ia9w44fHGCKB0W/xe0pUrmY2BYXlkNULSMLYaeHEMYUL7MQdMiq58FC7Nc30x1
 /Bl05NjpX0+8OedaFOsUkDsX134O0849m5eHDZAURuTNvTP4IKFfzRxzpziOPtRYjETu
 VWhw==
X-Gm-Message-State: APuU4Z+LHHVsyQRL3asoH35367dIYO/Tsc0xUNRdLYZPCWor1CuW2MpX
 Xi7TVhcM3KRBZIqSHFb3seADOMBawQ6jIzsPuTJps1OyPmdEd+7JhjcRVjDyp0J5M3nnA9Adyoc
 w+eKXHGk3J41wFHB6nm7GHfiMBYAh2nVfp1fAFMwaTr+MNjHhn139WDADGs9z8vKDd64P
X-Gm-Gg: AYBFou2zebv7pCgvEFX7fgIPKp+tioqrm2fTeq6rR/8tz56byVCBaeO56iZbkxGxmRV
 WX/DB5p8qTib8m0OPUtjJyXWqKMNSmA2dqkd08Wqud4Zeko67S7lEi91eGSGnSIK0xTP7OKdhnh
 X1eoMYINH5LDztE5uljZnVMWdwl1G15DeHEYaKUOeKkUv7TUjIVwf7wxqWxJtg2a5unz/SZfwyN
 F3iBhhqIfBZuKLHPcl2Clg+R8xeMJo7U8eVxtgaRS3n50Rl4I5WPxh/P1DlyDhJdm+P4Qm58Ovp
 IRXmpXxZeaoXSUzF1uhU471YDc5jkL2HWkWhDNHBuM/1zF4pRyOAlRQxmwcPaNuYye8T6B8sdzW
 09hvn/gnm1ScNkvLoXUBZ4tGk9r+fjSGeN/LT6YsP6VMtKOn1iYqK7adRcoe62FEk+j5hBrt3kg
 IRfU8SUXpPLYBy7g==
X-Received: by 2002:a67:e111:0:b0:7cc:2152:4f72 with SMTP id
 ada2fe7eead31-7d64d47dc72mr806908137.1.1794586403240; 
 Fri, 13 Nov 2026 08:13:23 -0800 (PST)
X-Received: by 2002:a67:e111:0:b0:7cc:2152:4f72 with SMTP id
 ada2fe7eead31-7d64d47dc72mr806901137.1.1794586402718; 
 Fri, 13 Nov 2026 08:13:22 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f1c0e31sm5192779f8f.19.2026.11.13.08.13.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:21 -0800 (PST)
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
Subject: [PATCH 10/19] target/mips: Fix nanoMIPS BPOSGE32C branch offset sign
 extension
Date: Fri, 13 Nov 2026 17:11:48 +0100
Message-ID: <20261113161158.25811-11-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfXwwjigV37eOuD
 25l0WjxbeSOzvLbU3bs9oLG2GK7mfvhwZ48Y7rlcdW3HYItnpa+VDjnILWgZ6C0LGEtfP8HAVF6
 9D2X0T7RVq0DYDG7XQmxsN0b4uj1RulX40AS243/BxkwHHdQpL7nMrhgQQd2u7QSJQ4d8phE9ur
 r50lreQI4etDxY4rtUGdHhZ3JK/A/eqctBF37XC4quhnFcvX0lYu36rLuEswNdtsu4MQsA1V+ru
 nVWDi5OLJyIV5YVRa5VaLqAnOw2iw+Wx6tSYTs5MWgHZO8WZrshRu5bW+2O+d3KghRd1i0BK3Zw
 ToBEIwz4E2SKRCzB3MNK/yOIMnvENjbtpC+OeWcySxU52O+285JWvxKWLVAF5h5oOB1sqWUZykB
 ml3yrGZ4P8seDNUm9Xgm5+pLzrkOuaivzLR0c3+80FlHS4MX/lOO+9Z9hZuyf7ObxoofLW53s1p
 Yfx2yHAd+2aFFWGRJhQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX87NGMajUomF5
 55gJUhnMTd76pJsblf9Gbj3jWCnCwg3Kn6OYlE/ynVI/qc4wlbJgHEoDMWo69o4HDEj7dNMZj2V
 ryCS0ZHQEQ+s/bte8ojaZ0pjzEWlsU0=
X-Proofpoint-GUID: iRx8XeBhVQVDmD9BmKnBfjUC8g3dIzNQ
X-Proofpoint-ORIG-GUID: iRx8XeBhVQVDmD9BmKnBfjUC8g3dIzNQ
X-Authority-Analysis: v=2.4 cv=JfcpPkKV c=1 sm=1 tr=0 ts=6af73723 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
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

The BPOSGE32C offset is a signed value s[14:1], with s[14] stored in
instruction bit 0 (MD01249 rev 0.04, "BPOSGE32C", printed page 88).
The decoder zero-extended it, so backward branches went to the wrong
target.

Reuse the sign-extended offset already computed by the P.BR3A pool.

Fixes: 6d033ca7513d ("target/mips: Add emulation of DSP ASE for nanoMIPS")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 20e96f2ad9be..3e326afd0827 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -4365,13 +4365,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                     break;
                 case NM_BPOSGE32C:
                     check_dsp_r3(ctx);
-                    {
-                        imm = extract32(ctx->opcode, 1, 13)
-                            | extract32(ctx->opcode, 0, 1) << 13;
-
-                        gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2,
-                                              imm << 1);
-                    }
+                    gen_compute_branch_nm(ctx, OPC_BPOSGE32, 4, -1, -2, s);
                     break;
                 default:
                     gen_reserved_instruction(ctx);
-- 
2.55.0


