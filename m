Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CC2CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE43-0002Mv-VO; Mon, 15 Jun 2026 16:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE42-0002MD-NT
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE40-00026p-Vv
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:46 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIwxsg881740
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=04I9RWgZccE
 RuEgf2h0Q8DCPFbbYni8O78bwBXOtlT0=; b=dKwLEA9whl1Qtedge5oIkhKSZuN
 1Cr+9pqRnG6jcHLg8a5GqaVUoRax/YlvF9IsyBTkP5zJfYuvod92Jd2s41Xp/V60
 lE7vM4PynZQ9U9EcKlEa/mLgadKQxZ6wK3gk4H4IfYYbs/GGm8FGQ2QZebzeBWMS
 Kfi+aIiIet4SEpEm2cACEuVfrXsspYKjAsyghTogMSzqz0Yh0xOTnE+TeeSt96oq
 NJFgZZ6eszS1BSwqcHzhAT3X/xF7tzJYJcKLu/ZwisBMXoEVcFp6KV9PkT8Y/cKo
 fk1E/FlI1p6rye7Guwk4w0RUj5lfKEygD6OdEDgY2WxL4xJsTsm6lLkqrAg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0jx1m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:43 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-91931144870so411160685a.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555862; x=1782160662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=04I9RWgZccERuEgf2h0Q8DCPFbbYni8O78bwBXOtlT0=;
 b=BdF8d2eNhmvHB0ooUZWP+Z6IRhNBPZap6/4Tf8BURWyOmwEqFBUR7ZG7xE/qhI13qh
 PZesC6vPcYWfkj1FJVXOPfc11UKn+LepLUJOo0dp3JvihPaZUJW+vCsLKX6jES4DWCk7
 MbYGdvh6M05432nOnBm3ZU48jSrGy+Izknl6c8gj5sgGckxuaaMfeHKsBTBEF5vh8UjE
 NJxnlC7HNrMQjMFUgLSfsCqHhSQw1jxT3ZXFNSJOLI9Vbl17Y1IMVkWSjAdduvrkHPSz
 XPEe/vpUsH2sAL6QNPkXMxkthZq3NK/Dg/UA2ieZm+qLRFn4bmHuoPsvDa57bFWr5Vvq
 M+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555862; x=1782160662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=04I9RWgZccERuEgf2h0Q8DCPFbbYni8O78bwBXOtlT0=;
 b=P0+ScxDPAW+WWF8OJY/Zo5morsPZ6pbZ/R1rE4zo44pG55BF7YyFaIbPTXexuRpriP
 A608qfHYS5Y2QU3SBVcEzUS9qnxsSnkNJsPi/yMXniufPFtxSphm6E2O+CAmNPoCuQVP
 4wULaqVM8cMKgkbJjgZtgd0x4i0Ul6CflSTIjZNtwcxG8IQh65Bv7NU1hB65MRFTASca
 01MXc3pJz3JQ4r+LbIxSSOgu2G3P6i3IQ5vGeLVttQlQTjMapu3l+m489HCdCiF94Cfd
 TACCeQbLdvmHhCB+S9xpjFeTatc81MOz1zeVEPCs23GNCi8I+9fPtCd9g+EVRjJ3jDjd
 D4zw==
X-Gm-Message-State: AOJu0YzjG0X6enacA1LRQu4xL5w772v62Mjn+FokbcQH7blhkyDI+/jH
 JwD97hA+S8cqqGHYwlbk3J7+Qtwd9NYjaxYxApjylHQ77bwxLtgt9hk13tPNg1eOcFcFQFmgYCc
 Z/xx7pwkV0ExJqoFG5ZYqWSOKXE09vnoFf9U8Yv4njgbwJ7XPDNtNFQnE3QMg/MSMhg==
X-Gm-Gg: Acq92OENpWj28Ti/PDJj/sk1bSm5sEcy49Epuco2BKiDHeti/uMWlq5MVcEm3L7NDdZ
 vAGTTdkGNJwJGuYwrzHwPaJuXSKgceSGDpIoB0KToQcVPUbdGpeRaB0uNcsbndZt73PwLvSfksH
 B3DXZ19wLUZukByZ3xrfoFAJ1kDb8Lyn4NGVLX+Nr1PHWAC9eA0ZGf5a1qqdelbSjvHJBrreDIO
 LBoX5RQJDGW85YyYs/aNrCrJXS0pXEal9DYYBoFR/KkHxOrBRi7khALHdfuXbe7v15Ln+ofz1pE
 APQnzqySWgupGWXPJ3kKReenyiAUrFFs82Gn0yYpYCh9NtmOHeaxVnEdxMopBJyBEoXmMBfcuhe
 iYUESsrl77Y1MNaAq2DPqFfpcME4M67GP4cfFqHCXm+Rkpik2Ko0zS4dvcwI=
X-Received: by 2002:a05:620a:27d2:b0:915:d443:e6db with SMTP id
 af79cd13be357-9161bc2337fmr2313822685a.20.1781555862040; 
 Mon, 15 Jun 2026 13:37:42 -0700 (PDT)
X-Received: by 2002:a05:620a:27d2:b0:915:d443:e6db with SMTP id
 af79cd13be357-9161bc2337fmr2313818585a.20.1781555861564; 
 Mon, 15 Jun 2026 13:37:41 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:41 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 01/13] hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
Date: Mon, 15 Jun 2026 17:37:21 -0300
Message-ID: <20260615203734.954428-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX8a/wLl9Owknb
 7GnnYBfL/zG06/57o4/xusr0yZszaCDKz/Nc3Ks9LcNWR7sxus+L27gfGrIWPPSx2rfInHpn0H3
 sdyz721ghzKyv1QF/dPUTwRYjSgYAh4=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a306297 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=G410GlaaS0drJ4fCzjAA:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX4DGimnS8mmqM
 Fl9pXMrJm3xse2GbQvnqDRJNRRwYpX65tdwffRIZdC2cVSx+jVIGHlGVX8OGlzkjSMPwJA9XgdY
 hJysIalPrP7SbFweaUIxMsa/e96ejoa9xsaUgh8rJjB73NZ4bcX5AjV04N/JcHWfJhn+BeFJiLl
 mRE1qIpfCzw5VXkmtHj4P9bElA4bGzkNVBNimMPJfuCKCUXrMPx3QbIbFklknTf/tXC+OB9swSp
 ekxnZ97DxD09HPteFTOU2/vZv6R7twmnLkwabY1Uq/MT9E5Fbc9Rna7BHBg5XQ5/ayIy2m9t8Hu
 CSGI3j4UUpmzc1NGXEmC6QdKBEHhDn1tPsinSLXp/PSI2eb527kYQ+wMtMy7oJn9HxGa5A7UMBB
 w6NLtItCHTN+SoXNdmyuAtssNtE+5krPUjS2yRY8iySWXnPdkB7ZzgHg9CkXYo5TmXvF9Cpxdt/
 cMxBjZQM8Nk85fRpPGQ==
X-Proofpoint-GUID: UU-KHSa_oT84V2Pl9ld3nPxC6IDQO6Sy
X-Proofpoint-ORIG-GUID: UU-KHSa_oT84V2Pl9ld3nPxC6IDQO6Sy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150218
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We're assigning a 'cpu_phandle' phandle to the cpu-intc phandle field.
Make it more in line with the other boards by assigning both a
cpu_phandle and a intc phandle.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 6a637e3b86..3abbd6c823 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -187,8 +187,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
         qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
+        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
+
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", cpu_phandle);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", phandle++);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
-- 
2.43.0


