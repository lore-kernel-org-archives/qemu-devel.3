Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776F5CD98EC
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 00:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZdhX-00024C-1b; Tue, 16 Jun 2026 20:00:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhI-00021i-AU
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 20:00:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZdhF-00084m-3z
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 19:59:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65GLTHTU198289
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=WqDMeKheitM
 gA2PlOARFdVAHfl6rsSJccdZUs0l87dc=; b=HMxJMvgitO7dcr+ZIPKNGv5vjYZ
 CxIL/sX9xNl9YjR7ZHEi+eZn2d70lZT/bN28gaSIcazfYlXdhu0G2tAXlRI9vDJX
 Tp236QJ0pBW+F2zFcsH8k4MzcCpusur4SYzB2s0kP34hOj4LBiH5ffwhBCN/CKLS
 f5ryTTVP9vkn9Qgm7VJGCmdR82i0zpMRzYGfZ+vtCSe1tx0dxOkbKkUN4TxVWzFW
 HgWFgu0kLreTymL6lJhElgrDwmCDHhyT/Rzs2PD2lNi3YeoDwemQHXU3WB3Zy4p3
 lErDF6NbbLwSlY5Rr08bxQYqATrKk75Cl4Rbo+g6OhAM63RcNbKfyJjWwsA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer0dxy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 23:59:53 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd3213beaso99973306d6.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 16:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781654392; x=1782259192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WqDMeKheitMgA2PlOARFdVAHfl6rsSJccdZUs0l87dc=;
 b=eohT6R7DR7rMCUp6QmVTgMJUVgSsFz5So4X5Wh86RQBEFz6WCEIziEwbRR+I/Fkbsb
 LdY5R3+DNiWy3INukGJ572ebeI/ynRMD6IXbSrbxvy6JKKIOqLB4rOD8OxVSLVi1ET3V
 kqFx1l/u2k9yJ827l6KHQj1oBnahLzd8I0EGi76nTFnSUeFbgUX1FNaYmD8xQApqWk/F
 594FBDPOiHuhHYny+4vr8dr+N08lc5d+OuaZsrhUQJPOuh9aOaGJbxYSUuYbWpz4S7nC
 OPtLdEjY5JyK25F3qgfm5/s2PBf0nnrWadJUYY43sITYzRYdMBOCJlXfvKqdKqlon5C3
 Jbqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781654392; x=1782259192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WqDMeKheitMgA2PlOARFdVAHfl6rsSJccdZUs0l87dc=;
 b=fIRYy3m6o4VG3AOe8wx3NZ7xh3qOIPUg9O0oQjQiNTAV/r2BqjCaA6ApebbPm+i9hl
 CU3HB9VtVg3KtsNrg4+E9E5cGpR4N65NgPnonA/enK/7WyX1Dh7rovwVX/oiI8Edonf3
 lQSIbzlTI9QgQq0dTATfwkTL5NdHCPBX1yAtqtpjitlVhk5my8KuCXrMPsPevapcHLDD
 XcAuyfZP8D59So4GBz8ZSSyB+8p4o3Svi4G8Ncy6YFPtLcT4jQkDvxVJsY4IVHnbCd4m
 VNPwk+e931RjCVtcXClD7QzyiHECfGq+tJCysosdSFlZCE//xSZNk2DWK/fE0fdl/B1U
 fsMQ==
X-Gm-Message-State: AOJu0YwrXtFX9Qkypx4UePlub//cKVJpV2qtFoAEi4aM+VtIgz+V1e/G
 CzMsJD+8iwgp7KtWQ9EqCrfk7qVUvnPY84drEWNAw04VdQrnArwQIWM0eORJ+wQVVT+Z1BQ/0WT
 CHlzDDsBDO3goVmzksFYFs9nTOnuqteVx7+h5mGjE09VXITtAAGyh+i85jgRUbbi1tA==
X-Gm-Gg: AfdE7cnPhixCuwBD8b63NBXJfW5AIW50av5LTprJW1rvA5MUUdi4+aw5uzeSN9oJhyG
 hhfIL6+LYi5EDakuK+hIwUwgLCsxnE2e1zGwL2MWD5+yq2+HlfFTOdZ4SePEV20/S+t11YT61mv
 x1KoX8rv622NFSP3pTYZuyZ3nXpXIiW3Vh0Rl8Dm9oKbdqAlsXThFgJpnzobE2LKFYiZeFQlO6F
 wIRgCZ9PRixtMKiJ8sYOT9GFHki6CUmeHaRK4cFFo0mWsB7dsHlI12pdypYJ183dpwtUX7+q95C
 n0Wdh+CW7eswzYGdf40p98exjPl2+cH5fgeUXRvxBYOj3TnRmtdkMIxT4UUV0qRMT3q7lOdDhtq
 h0svruzn0g7BV3Yi/0CSbTsy5KCn6WFPk4Hs+GFPIUxm/AXWv1xfES0TNFPU=
X-Received: by 2002:a05:6214:258d:b0:8ce:e409:22d8 with SMTP id
 6a1803df08f44-8db83519ca5mr23749946d6.28.1781654392569; 
 Tue, 16 Jun 2026 16:59:52 -0700 (PDT)
X-Received: by 2002:a05:6214:258d:b0:8ce:e409:22d8 with SMTP id
 6a1803df08f44-8db83519ca5mr23749636d6.28.1781654392126; 
 Tue, 16 Jun 2026 16:59:52 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f132178csm50191986d6.7.2026.06.16.16.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 16:59:51 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 3/5] hw/riscv/sifive_u: add #address-cells in PLIC FDT
Date: Tue, 16 Jun 2026 20:59:37 -0300
Message-ID: <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5vUOwyHfZUcRVkZPxlTKZA_AlNpShv69
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a31e379 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XZ4Qgz962IF3wEqZkZEA:9 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-GUID: 5vUOwyHfZUcRVkZPxlTKZA_AlNpShv69
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX1aMgFJQFMd/n
 TmixEfbP/B73XjLi2Ml0/AEmgfsktd9LoI/4crprMp7DIUr5/KigB7L5aF3cxPxgNeCMB8UbpyY
 Xsj1wU3bimHzSF7e0j9bjLy0uLheILg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDI0MiBTYWx0ZWRfX+oUz6/JxTOnk
 7z1irz8v1/O5wo0D1bBsg1Yn/wdmJ6UnFzNSByHWh683yv0bh5nEO4J6olYVsfgnC31EJyKxamw
 lbHGxLuPEIAFwysveW57JM9psJv7xkE3flOsvAE0k67C+LCF2zBtVC84kv+xF2SvRqDZBox6Dpt
 DKzFUYEE5iLUjmjlK7xL1w1+N72MhB6D0038y7GR/1u0re+7YcXHEcgXmqhtT51cp5rGnDmL9Vz
 XGNyBTR54XknoinR1RWxF5qKGTQVSaP9/t3Vd33RLVevRRUewTCp8GX5Qc1+JrvFKrFVQaVBX0/
 ne763SfO4PerMGyVk7XfbHpiNDyi1q9dTJ+/SvILXD9t+gRgXmaeKPgdg41zQzI5tggV3tqFB22
 AA6wFQFWWg5PJyEjXyI9SbMkx+djCQiwdTfbDR6QLsjFjHHsflzt2z9E97TuF9vo7EW9dZnulXZ
 xPNdaEEWGBALzKAZ1+w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_05,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606160242
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

By Linux FDT docs in [1] the "address-cells" property is mandatory.  Set
it to zero.

While we're at it let's also put this new value and the interrupt-cells
value in macros, like the 'virt' board is doing.

[1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c         | 5 ++++-
 include/hw/riscv/sifive_u.h | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index b3468254f5..7dfc18d3ec 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -213,7 +213,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
         (long)memmap[SIFIVE_U_DEV_PLIC].base);
     qemu_fdt_add_subnode(fdt, nodename);
-    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
+    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
+                          SIFIVE_U_PLIC_INT_CELLS);
+    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
+                          SIFIVE_U_PLIC_ADDR_CELLS);
     qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
         (char **)&plic_compat, ARRAY_SIZE(plic_compat));
     qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
index e4c9860d50..aed966a62d 100644
--- a/include/hw/riscv/sifive_u.h
+++ b/include/hw/riscv/sifive_u.h
@@ -156,6 +156,8 @@ enum {
 #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
 #define SIFIVE_U_COMPUTE_CPU_COUNT      4
 
+#define SIFIVE_U_PLIC_ADDR_CELLS   0
+#define SIFIVE_U_PLIC_INT_CELLS    1
 #define SIFIVE_U_PLIC_NUM_SOURCES 54
 #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
 #define SIFIVE_U_PLIC_PRIORITY_BASE 0x00
-- 
2.43.0


