Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B3E606A338
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 14:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J8cz1F8h;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iQg7X39e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM4kD-0005Fc-AP; Wed, 28 Oct 2026 10:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4ip-0004vv-SX
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM4il-0004S6-Ly
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 10:33:44 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SBe6Yv4154790
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JrpxIoMHu80juwCYv64Cdd+JGCNn6vrwIlylVgcVrqU=; b=J8cz1F8hcKJYrb6V
 Pd5o+PFGzNnY89hMsrvAy3PAykDqFyyQi42Ewb61AGaw+ctyJCilf1ztcpsWtkFT
 rFi4mO2BiVvNTRqqAX2sLYY/OfJQvi9xdTif9dRGk9GAyrbX5GfJeOyEHnjyT6LA
 Pc+oF7KkfgQdHJsmoQeT1Oz2bFgjDXWGslaMQtlGkrX0G7tCtik5h5DTwF8StBJY
 kGCTWJr1gusnzbR2wsSKaHXCWvdW3IcRF9zGvCSKJHIyDsEITjSlJpcxY8eAzoYL
 SjZskYUz2Bk7MgNxEOi0syOc/YNAPKc761V+nb2DUaU7D+S67k6h+QnObLSMJP+5
 uy85ng==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkdsp19u5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 14:33:42 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91c71966998so15062156d6.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 07:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793198022; x=1793802822; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JrpxIoMHu80juwCYv64Cdd+JGCNn6vrwIlylVgcVrqU=;
 b=iQg7X39eX54SYosvk89NWCvqoiAFQp1L7JqDHVkYmm+/xkvF8nlhgyhvNIZmaY/Oo6
 0ypMFeTv0pfKMYotBR5U7PUJZbBX//eWXE/ot79Mo2XVd/3KHpuiGwkC7pwxJfIOfbE1
 8lHRDvTXzWU6f1QlqeZUG1R219TNz6iYlGpUv+uLGlbbYYgYVpIrdAIIEn/NdGoRvcb2
 Xc4rZOAYEt0DI8tqQ0HXMAolMjAKZkNyIc4ulqw4J4ls/FQ3IIpSgZC8aRW7L0+UDl69
 HwtHJvhmp3EGoftNFYyZBhoxToKcR/0PPR9JIdVq4ui70jNfHMHuartMW3LkUj8sRIsP
 0tKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793198022; x=1793802822;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JrpxIoMHu80juwCYv64Cdd+JGCNn6vrwIlylVgcVrqU=;
 b=x/a0WVo0wy2KnULpfH1LxJ5N4AZaKDHjr+vl1dTBMWLkkYvZwX78VgwNkLp0yBn/DG
 5mt94WsoZNTpY7ooDMprJytFfUf9zuJt+W4xGWIDZhgBEDMBiLL5SvHzDasvmJFg2LJl
 mvUNDGYf8Uz0w6I2t6jSvoouuO/6n9psu2bjvEyhAGNU6nJdS9OH/ZYmYvfs8XJip5Bs
 NIdddUZ41AYxEb923HpXJ8SQxQLqAygz7c0iu6OItoD2TTX3PsxzTKIwfnUPcZcZL6TV
 HfrXH/WPYHt9Glcor9V4sSgbJD/zO8TPdaub/c/6jiHkTc4Zb0P9aqrUuuK05RiH/VPM
 N9bg==
X-Gm-Message-State: AFq9FYJx+LpZZUo4dHawV3IPAnQe3YUIJMWjkIsLkH89Vc7A1gje5mIT
 3/6/IInwLpoQhdeL/MNfI0ZaI3jJj0JAYFiYJ7Fg2DD4uXydX+orulFeeRJ0dK8vq1ybkZRG9PQ
 gMZDD+8EFHbTWKxuGzDrdK53dAsyNUC10PhxHuewFLvdeWMvUng/7BH0XVe+eCZDXHHIK
X-Gm-Gg: AYBFou30QoF6NX162hNChphjQa5lJTaOak+5jRj8v4YgpXomQiWIptjs/K9b1Y/9bBl
 HyYP+T74LkQsY6h+zcnPi8ckJM13feFLtx9oJtumwGTz6lr0DXj1xgsPB9CzkmJMy7ynvVt/fyg
 38tKKIaCknIhRC3+GHeb89yXQoupYnKlIkLCkhfUIiE4GMoH1yA9/HUBLBOnlgJTXC9BLGspsxZ
 uC79O4GNvvcGoKRAsdvC+GHyU1KRvdHPTqtM9n98x+/vlR5AmilMRELtu3TryLmsCbjUK2fULLt
 SO2NPlkMhO3rKy4110nTI16IJkxVbnB+o5h1rnUfNIXRmiNK6Hfg3vi6KBm2htxWMsmNXay/6E2
 QjNQ2Xz7V1pvnNh+Jx3FybKVWDSrhWIMaJRW6ATcL2/h3Ke+A1kHN6AZHLVDHT/cH7p6En9VNRW
 vhXLB6pfdM18WG7eStkFRdq1A9mKwv8g==
X-Received: by 2002:a05:620a:2806:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-94408c9a598mr346101985a.37.1793198021783; 
 Wed, 28 Oct 2026 07:33:41 -0700 (PDT)
X-Received: by 2002:a05:620a:2806:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-94408c9a598mr346094385a.37.1793198021066; 
 Wed, 28 Oct 2026 07:33:41 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ece13aasm26814438f8f.58.2026.10.28.07.33.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 07:33:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 1/6] tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
Date: Wed, 28 Oct 2026 15:33:25 +0100
Message-ID: <20261028143330.6518-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028143330.6518-1-philmd@oss.qualcomm.com>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: BRD3sbGg1ox_isjwuEYdRg2sNUExIs_H
X-Proofpoint-ORIG-GUID: BRD3sbGg1ox_isjwuEYdRg2sNUExIs_H
X-Authority-Analysis: v=2.4 cv=Cssq4X4D c=1 sm=1 tr=0 ts=6ae207c6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Cvy6jmBRAY_LntWzTOEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfXydDQjjfShAzx
 y5Sevfq5BtEqJoTcJJXobgROy8u6CUFxCw5WzjX/0A70yKnLI8HJNyx4Rai0ns28Y3Uzk6zOAGL
 hT4JOpflSdKsum+PHq42cUufqsbtVQNYQ1i8uJVl+3hAXiAd9DuqQVfAGORjwTRdZMEo72y+yYZ
 +woT1+i08fqqK7h4Gjr+DO2Pfx5QW8FfdV7zIIJqoB8clwZJWIEGXNDU1F/wgKoVosKOCBDhhN8
 QzQCbV2EqWlXD2tkF5QyK5C2iZctZN99iAKfnGk732DtRbzQmJCNh/BJ/IQLBzqO6j7okmExQw0
 /4tP1oZ5biawF6ImM+QdL67WAR0jVeBRdtKeRhohHbqeJ6zZakbfeypfapNi3OZOknzOKHzkp9L
 FL9eSYJ9uFCwp+Yb93agN3ASlRD6dBmncq6Kej3OO2FK5yl1p2damS6W1R4ickVSq0sxAr9SHli
 Id4XUkRE3UgPXSfwgqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1NyBTYWx0ZWRfX7Exlr+Lw8vRp
 O6a2Qg3r8cLxE0k+ijb4GIcsWlxy503XIdYsnqT8DwxKlckaqIjX8l9s8INXzzsKvcl0X3GRWoR
 WAXT1gW4ZFY5v/s1Epq8v9Gs+M7WBKo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280057
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move the OPIVI field layout into encode_vi_raw(), keeping the
simm5 check in encode_vi(). The next commit adds a uimm5 variant
for the vector shift instructions. No functional change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tcg/riscv64/tcg-target.c.inc | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv64/tcg-target.c.inc b/tcg/riscv64/tcg-target.c.inc
index 03f32c5819f3..712170c1203e 100644
--- a/tcg/riscv64/tcg-target.c.inc
+++ b/tcg/riscv64/tcg-target.c.inc
@@ -534,12 +534,18 @@ static tcg_insn_unit encode_j(RISCVInsn opc, TCGReg rd, tcg_target_long imm)
 
 /* Type-OPIVI */
 
+static tcg_insn_unit encode_vi_raw(RISCVInsn opc, TCGReg rd, unsigned imm5,
+                                   TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm5 & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
 static tcg_insn_unit encode_vi(RISCVInsn opc, TCGReg rd, tcg_target_long imm,
                                TCGReg vs2, bool vm)
 {
     tcg_debug_assert(imm == sextract32(imm, 0, 5));
-    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
-           (vs2 & 0x1f) << 20 | (vm << 25);
+    return encode_vi_raw(opc, rd, imm, vs2, vm);
 }
 
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
-- 
2.55.0


