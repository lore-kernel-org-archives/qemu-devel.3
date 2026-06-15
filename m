Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55216CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4m-0003BH-2u; Mon, 15 Jun 2026 16:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4k-0003AO-6M
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4i-0002Fz-Jj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:38:29 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx7M9861025
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ga8OQGNFMkS
 /l/cgG0yBv7NXDhBd/6OoyfA2/6gi4Fc=; b=OQhuaKKjti+vSZYR+Lp8iJO9JA3
 48Y05XvLQHqDYyhNgs+Phxwvc+PzF7NeD9HJMY+6lu0sl19BMD9mGqrL8NDKz4rC
 2j25kT4UEqgRFkZ8nwdmrlHbMhvUz2WXAncnUfOmqXhYEqLlr+HP2B8DTCyBVCOm
 29ZrJpB4rV1Br+nWgpyDG16gKw8UDBQ3hCAYjwQNQg4iblEh6Ufd8z/j+2U7Ey+1
 kjAnf6D0jZwatpNyEUhQcDR08JG+CkVCn0l9XJjbLB8O8THt+R9bOAXGfVskYB2H
 evswYPPWn3XQJDQudUWEiqTXEcv6zqAr+xfqLXoNY4mlzi8FdCzg81xHl6g==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eteydavm8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:38:17 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-517e0cdf99fso104128271cf.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555896; x=1782160696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ga8OQGNFMkS/l/cgG0yBv7NXDhBd/6OoyfA2/6gi4Fc=;
 b=F78x7FphR5C/959MJ79ZbnetAuQjudtASEJZyDXZNFTVvkgBEVxen8yupvL6RZZnf8
 Mx10K9pA59/HWUynCArnwrf8D6u/DApm8DLx+QaTdjpD+WNWxtPsfOz1XfxDaoNn6mfo
 gBTyiwOZg4aMJpGnCVOAKMW2uA3hafca/pm4A+Gyj1JlzgIveEDFyHhftue5riQ7NatI
 YNnFGu5fxp0+LXzYV0KGmqsumPrrPuzY0J7bABohaPyH9+VtWD2JMOa98n4Mm5k3sm5k
 5ZN0aXaPTVtXFSKS1PefwBWbwmyD5we8olffM5MulLOrrJO78VmfA142DCtPwbuFJ/lg
 u33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555896; x=1782160696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ga8OQGNFMkS/l/cgG0yBv7NXDhBd/6OoyfA2/6gi4Fc=;
 b=bDYxBtVnr14d7On3W8S7dcP4YQd5jwZmxb7tJeMPivlfHFrxVtpH2A23tQRGx6SyqY
 xdBtxos31QITLNmCddbrtPgjPzlcfMYvqaBMZiuKeON2BiL15GK6cO+5uL7e4RWnUxrX
 s2PvRcAb7ilSbtf+UtDBtU0xZNeKonsaI8kEt/KqmD+ysAzvFdF2qQUAOouJO0D2S8of
 acAIae/un5SiF2suBPAZn8jXJ41isF1SAvWGip7DH02UdglBA5hYHtejjREbprSLv6r8
 PGMgzTjqMY7oumOOSCuHrqASnWX66j71P1xMbclgF2LhOeDrGjM3HaXO7osBNs1V8tES
 Uzcw==
X-Gm-Message-State: AOJu0YyVd5UkJhM/uBADOshA9suo7KIkzNygLwZs/9ZQatcTd9Hx2MvR
 +/2MHA1/Rl6lX+cGtDq71GO3mRRzutXSPnOe5WHs8/BgpLHzmzx7fGz12vvDBdO8PLzoTkwnvk3
 gwcQx9ENVAJeJa8pcRGy+AIwQM2Wn7rLQLc5HJsq4gGPxTR6E6gC/uxjpp0ENVtW5/Q==
X-Gm-Gg: Acq92OEWdxKD+9dqpU+bZzCVxZKOgwtnJ/imCUNWnjsizjOHHdGY4Hwlag3OJRrmsrv
 0W9V/pM7KAaEi2cOuL+xDrPtYyaRBN109UnUKLq92aNk8we7eSAr3PblOJ9gy3uOCqLnriBgLxr
 ZElladKXf9/YOo3Y3vHxwmb6JdHdWDvjrpbF0tB7uIgqpXx/6cXmmF9ArvTatjD8LPvZQatKE8P
 4Dyj8DR5KZaMSIynYVx88hcgQX2opf4DxYH8d/LUArzEIIohmBHAUud5SD86LDcBsUXZEIkhEnw
 lDxHkwGFP1bCVr3FP8ukEf8JKxKngPDp9Yd6JuAICYFTlxFF9Tpz7Yfg+dkItw+x8PsWz+KZCTx
 F+pBo9xmt6oGqXrKEdgXS8V3rtgkyLjnfKThHJNcDh2B0k5Hnl6Funwo1vWE=
X-Received: by 2002:a05:622a:1814:b0:517:9095:c31b with SMTP id
 d75a77b69052e-5195354cab2mr187343661cf.42.1781555891152; 
 Mon, 15 Jun 2026 13:38:11 -0700 (PDT)
X-Received: by 2002:a05:622a:1814:b0:517:9095:c31b with SMTP id
 d75a77b69052e-5195354cab2mr187343291cf.42.1781555890635; 
 Mon, 15 Jun 2026 13:38:10 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:38:10 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 13/13] hw/riscv: add create_fdt_socket_cpu_sifive()
Date: Mon, 15 Jun 2026 17:37:33 -0300
Message-ID: <20260615203734.954428-14-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EpI4IGgZK9l7pZNr_6Cb7XpU4ptDpW7T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOSBTYWx0ZWRfX0PG2ThwsMcSs
 J4Hcsjzpe4LpKxayi7K4YtplJ3s3R5fAmSMEIkBChiyTKNvHet/I8gXrDF2/t+vvCCsKTavw3wr
 +1hwIqxU+VjzGW4jDGf2a2X5vz+m9mg=
X-Authority-Analysis: v=2.4 cv=QrJuG1yd c=1 sm=1 tr=0 ts=6a3062b9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=PC6YXwtoWIEWxpKgCUMA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: EpI4IGgZK9l7pZNr_6Cb7XpU4ptDpW7T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOSBTYWx0ZWRfX8bnHTF96N0EW
 sYGCZXaDMNLSyagIo3OYEJn/QClI/q8HiG6Fz3ZVO/VDI0o+HEH5/wfAGVH15XbwDtwrQs241+1
 dmyAmaet1bUl4Riv4GzHFoaIjc1qj89aroqe8v/z1jThJt+ENr6BBmST3ylvj+t3KNRpyLe3rOb
 wJuBc7yQAoekDmIpTV5vD3JMKux/emXvSi+EnRfrZIWZ6lz1pLdz9w+exFToI4Zt+KcHg3i7Fbc
 Wuk44/+M8Vpd4nBU4LcZ0guSH0Pz2BnNwAmlI+khMkYld9PrLpkKGNYcx1tUKLli5OxtxGOlD/0
 jUVBDd2CwK5HNyWOhu7e/9jTpb/PhbCobcAIV+iRTpPqJ/PKTNFAoKObANEa30a78Z7UJHMdYhl
 BSd3vuj0tZHVXclOTOoRanqBoU1p4W4X8d1OzwM50GnLM7znu2x2COfEsUmr5O6n33qPRBWfFru
 enOHmmnk7//Hrb/3pZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150219
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This sifive_u only helper shares DT code with other boards.  The idea is
to reduce code repetition while keeping sifive_u characteristics in
place.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 11 +++++++++++
 hw/riscv/sifive_u.c           | 24 +++---------------------
 include/hw/riscv/fdt-common.h |  4 ++++
 3 files changed, 18 insertions(+), 21 deletions(-)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index 70168ad657..b27ff13bca 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -189,3 +189,14 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
                                        is_32_bit);
     }
 }
+
+void
+create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                             int cpu_id, int socket_id,
+                             int socket_hartid_base, uint32_t *phandle,
+                             uint32_t *intc_phandles)
+{
+    create_fdt_socket_cpu_internal(fdt, clust_name, NULL, cpu_id,
+                                   socket_id, socket_hartid_base,
+                                   phandle, intc_phandles, false, false);
+}
diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index 27c1a74d99..0c6e4204cb 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -145,12 +145,9 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     qemu_fdt_add_subnode(fdt, clust_name);
 
     for (cpu = ms->smp.cpus - 1; cpu >= 0; cpu--) {
-        int cpu_phandle = phandle++;
         nodename = g_strdup_printf("/cpus/cpu@%d", cpu);
-        char *intc = g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        g_autofree char *core_name = NULL;
-
         qemu_fdt_add_subnode(fdt, nodename);
+
         /* cpu 0 is the management hart that does not have mmu */
         if (cpu != 0) {
             if (is_32_bit) {
@@ -162,25 +159,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         } else {
             riscv_isa_write_fdt(&s->soc.e_cpus.harts[0], fdt, nodename);
         }
-        qemu_fdt_setprop_string(fdt, nodename, "compatible", "riscv");
-        qemu_fdt_setprop_string(fdt, nodename, "status", "okay");
-        qemu_fdt_setprop_cell(fdt, nodename, "reg", cpu);
-        qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
-        qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
-
-        intc_phandles[cpu] = phandle++;
-
-        qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandles[cpu]);
-        qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
-        qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
-        qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
 
-        core_name = g_strdup_printf("%s/core%d", clust_name, cpu);
-        qemu_fdt_add_subnode(fdt, core_name);
-        qemu_fdt_setprop_cell(fdt, core_name, "cpu", cpu_phandle);
+        create_fdt_socket_cpu_sifive(fdt, clust_name, cpu, 0, 0,
+                                     &phandle, intc_phandles);
 
-        g_free(intc);
         g_free(nodename);
     }
 
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index 3af9d5c3fd..2d6b9a5d03 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -26,4 +26,8 @@ void create_fdt_socket_cpus(void *fdt, RISCVCPU *socket_harts,
                             int socket_hartid_base, uint32_t *phandle,
                             uint32_t *intc_phandles, bool numa_enabled,
                             bool is_32_bit);
+void create_fdt_socket_cpu_sifive(void *fdt, char *clust_name,
+                                  int cpu_id, int socket_id,
+                                  int socket_hartid_base, uint32_t *phandle,
+                                  uint32_t *intc_phandles);
 #endif
-- 
2.43.0


