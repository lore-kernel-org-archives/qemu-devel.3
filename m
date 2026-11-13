Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED66070225
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DI1mwy1y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FrLmpeqa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRtub-000332-QS; Fri, 13 Nov 2026 11:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtuB-0002iD-3l
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xRtu8-0000JX-Ek
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 11:13:34 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ADFRRar1725250
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eqLRChA6eJbrofQUsbJ6U6/ACqo6BISkGQAcpVAPX9I=; b=DI1mwy1y6rgjq1yE
 cnyCpEmUGt77kAWV1NoCmvXSlU9kqvqNiQKB+czkzRvNDUVaGHWCd4u3EV0VV7BQ
 yNXTLMicbrVvDhHTl0qnjfCW423/zSX0vVdUuPtOrjI0KT/vAP6voAuY4Up7XZC2
 Y+3Jfn7GQLhhS7G+z1E3/c+JDV5UxoKH+GZhG/BW7Qy8V1GgxGJV0TYYu8+fgKbe
 UOU42dwB3hZT/5mssTxQCAP1f5ZAWs1YmrpOCK7pGv5UdZFBSqL+nOY6/tfn3Tgt
 1yHQIVQZ7SZi2HWKBvk/WIykqKcNxIMqfhTj2G79tfA3g5WYc+XVHOYOWSsPfvw6
 hlKh6g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx1bp942w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 16:13:31 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9806e283b0eso1089790241.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794586411; x=1795191211; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eqLRChA6eJbrofQUsbJ6U6/ACqo6BISkGQAcpVAPX9I=;
 b=FrLmpeqaRKDYQ0BDX7XnTft5PdqHgPuwvlUz103fBrBOncpyNiJYFHPnEYj6vArA82
 QTbIxnyIqiqiLmae0OoI18r5V2kjO15NOcI3jXP0V98tYKCbidrNjCvHi2yInpQKgYpZ
 n7F1m8xBxcE/PRq51F17ucVjNDcYYjT3gnKKD+f83v4eM5M5dr/pmmQLAVfIj6gCuSFM
 rccmfaGvVTaV71OY/zjB9e8OdbwSxMM+LhSVgfmDiNCDUHAaC2/ei/bdDtqECCswpKGU
 4AYP3BPUrPBeTjiGUbTTWjA1QPpc1PM7DP2lnPZ7ABZOwZuVYg8w1oJbKg3xAC/ginGX
 zy7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794586411; x=1795191211;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eqLRChA6eJbrofQUsbJ6U6/ACqo6BISkGQAcpVAPX9I=;
 b=bgSY1+abX5Oorj1MsVLvRIVRJJff4yNN3Jme8vbLw4lJsKorMw/YSaTJMrRKFtfS6S
 Cpt/VS4ted5f4NV0Zt//HfAO7e/HcL91UMK7iEjBcGS9QfLg128ZycOj+MHyqkMNzXJQ
 7dO6L0iEzj0FdANQBhI6Xn4h2TMRdyY+p/xyEVeDTCAKPosHzEnKt+PSN+brzHzpew0F
 Yv1Uuj0cyB3dnZewQ5/Uel3k7Bpgc6jRN/FCqUX2Th6xZUKjH9yJQ/Qq1WmbAjlio6fC
 13Ymuf38qtTtLLND5ozwGHD/vrufxCNdBuheL+LUVS51peQPUbgyq2JOkYQ9754YKbrV
 Pc1Q==
X-Gm-Message-State: APuU4Z/0b58vDZh7MqHsbb4Hr9GeMsWCfheaFLSh/USKafmsirDC7SSf
 AhswV7T+lFgRcbRDYV2BwS3tkH926jg/3NyNxfYGgew04g/K0CQ0SpAeVydfrlipvQU00ECAryQ
 oYJqmXLq9k8Uv1jxoQtwdpBfK2dR1LoISDOX++HJ2CiStYiFmjfmv6CS7a3W5TYwN22uK
X-Gm-Gg: AYBFou0iPQ9bEsgpWVs6kq3cqZg4gN+XtDw18NQUaAmTKFc3h4Oz+oal7o1wjwMPD0s
 tIo/kFftVL5LAw3FBIe9+wHj+CcdutxC03HigcS4hUI7l+vojkVVqn60fxo8IaBnIwWd9LDK6LV
 FgLTT1sJVP/SU6gYINXgboppKU+NhRquI1KShLd9yRy+DR98HLk2aSmMlYARGIr02Qn8CZ7NPoi
 pyAWkKC9RiSDzd0xP//qJTlaO0nWTXT81LYTq72Q6g6+T4ERKGVBR3YKuPGD2jNfYkuaL+eI9Vj
 JKmHTsuAyzHOIwbgoz2ic+7sWweEtopoAM8eKo0p543KpLP78aHOkJD4GB3qxvtRwWlrMAVDi1M
 OD/2jsldtZkqCJIIZ2gjjZoy5/DXIQtoj1fJ07Ow+7O+/HeC106RCFrzop6a41Jb50T9s/8sNbY
 FmOZDPUm4OX33T2w==
X-Received: by 2002:a05:6102:6e88:b0:7b4:879c:bb8d with SMTP id
 ada2fe7eead31-7d64d8ab91amr777588137.37.1794586410599; 
 Fri, 13 Nov 2026 08:13:30 -0800 (PST)
X-Received: by 2002:a05:6102:6e88:b0:7b4:879c:bb8d with SMTP id
 ada2fe7eead31-7d64d8ab91amr777581137.37.1794586410090; 
 Fri, 13 Nov 2026 08:13:30 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb55ae501bsm77163225e9.10.2026.11.13.08.13.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Nov 2026 08:13:29 -0800 (PST)
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
Subject: [PATCH 11/19] target/mips: Pass the right instruction size for
 nanoMIPS RESTORE.JRC
Date: Fri, 13 Nov 2026 17:11:49 +0100
Message-ID: <20261113161158.25811-12-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113161158.25811-1-philmd@oss.qualcomm.com>
References: <20261113161158.25811-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=W9ytxhWk c=1 sm=1 tr=0 ts=6af7372b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=M4u4gXv3FWbnTiq_ZVkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: G2iTRbZ_2pJsOrExBGJtUmwcuNxIp-yf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX4zpmC08KRKEN
 mwljMuxDXtUPgm20YYj10PKBeH3xX6ZEIe6vVdpOOouv13Y7pXqUrFZZ6NsGCkpTmwYMiUarMuH
 Zm5FFiY9OmLbL7V4OWNBmwMF99ZlHJA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX7/xDnLRKH770
 BLzZ3rpwJ7dPOuwrKeiFj56140oEmBxpCMn7Dji8BFcisQm4wPA38OugPoFSs4g0pH8U6215Bdk
 bM9ezb00anKMe8VQU5YH+04KywA08FnHO3KDK5iAT+IRTk2ChNVi2VYXEQe1TjKOsEV+4F0TO3M
 9GKAXkzvaaWVE6bfIBZxYG1egQKkTbcu+ir4i3XtTC8Jvi3soW97u5rh1kNPGe6auaCQ4FUFWLs
 Loso/RBS+ATvtULcLuL/Wo9HjZLK+c/I4DI2qt0Z31sm7BPQTujM3RrexBzo33ZDxaPk0j6QWb2
 /L0/meKI1nC5Jt4/ijSpeQ/vhgV2anTzGdy/xXGnXzyX9oQlfHnJyOhqF2162hFVQC7oeclHbkf
 AqzLr4vdqWFHnNe8SXhZduDH+xvIQLNHnH1uPAPG1wboTSgcUj2up7XfHun4tN4CRm/+n0oV/a1
 PqLWcuNBso7v1DrkFgw==
X-Proofpoint-ORIG-GUID: G2iTRbZ_2pJsOrExBGJtUmwcuNxIp-yf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 impostorscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
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

RESTORE.JRC[32] is a 32-bit instruction (MD01247, printed page 155),
but gen_compute_branch_nm() was called with an instruction size of 2
(copy/paste from the 16-bit form), which wrongly set MIPS_HFLAG_B16.

No functional effect: gen_branch() clears MIPS_HFLAG_B16 before
anything reads it.

Fixes: c02809830346 ("target/mips: Add emulation of some nanoMIPS 32-bit instr")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/tcg/nanomips_translate.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/tcg/nanomips_translate.c.inc b/target/mips/tcg/nanomips_translate.c.inc
index 3e326afd0827..5941889b617b 100644
--- a/target/mips/tcg/nanomips_translate.c.inc
+++ b/target/mips/tcg/nanomips_translate.c.inc
@@ -3745,7 +3745,7 @@ static int decode_nanomips_32_48_opc(CPUMIPSState *env, DisasContext *ctx)
                                 extract32(ctx->opcode, 2, 1),
                                 extract32(ctx->opcode, 3, 9) << 3);
                     if ((ctx->opcode & 3) == NM_RESTORE_JRC) {
-                        gen_compute_branch_nm(ctx, OPC_JR, 2, 31, 0, 0);
+                        gen_compute_branch_nm(ctx, OPC_JR, 4, 31, 0, 0);
                     }
                     break;
                 default:
-- 
2.55.0


