Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC27CD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 20:38:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZE4D-0002n8-PM; Mon, 15 Jun 2026 16:37:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE4C-0002mQ-Is
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZE49-00029n-Pj
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 16:37:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIxISY781702
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=D882KEthOvY
 2rIi3k7Eye2n7i4NMV5sVrKHmsFH48ww=; b=Wuoh+c1etz9ZoSfgPtDtHSQwtWa
 Aeul7vCSrYDPG5p902wqf8x0XPAPVYvmhb7eGzrcVw26/Eef/rj67OXlwUgZXANn
 t2Ww5N+hIp1SSLGTrtc9F//pVkd6I1BbtiBvNDs1Nm+RvBu709cEJX5rhyDguWd3
 TzIAZRbhtDFmiVshftDr1hhOWrpy6Z4AYWGlvSOuDSzp86vT+PxKcmeqAnPuzeFJ
 iDU3GfiivFwVU4n4wcxVbmqXIqGpCc5HYIlVrnc19D8riawjYGUOLLVO79ePd0eI
 IrD0fK/1vn0ToBSX60wIVLTFHm1ATBPsZkSzKSpJfA3EaRJZylhyTdEdV6Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjtxta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:37:52 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9156ceb551eso581963685a.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 13:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781555871; x=1782160671; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D882KEthOvY2rIi3k7Eye2n7i4NMV5sVrKHmsFH48ww=;
 b=SZtOS950PZ/Z+uSWTSGqeIPgE5c53UDahfTRarmj93AMXSXm1gxyQO2gQonCjo/Dhh
 TJQ/qyQL9+0PXCottg27RQGSQ5TVRBz0lleeYuUwLDv4g0ildzDQKDpXlXBppc7ebEpb
 xz2LJuMR0NFN7ZquYvLOA1ARTDZUmxu0Ih0HwZmq/CnEtL4w1XhnXCikx2qWTNCTsyb1
 nZ9h0aWRDXz6PRkht/TiThmzeU7oXWIZjtwZFn2l8gz4cJ9tpQ7s/IHO+YtB4Z49qNe7
 1m2KLi27tNjbGgSdH81+j7A7X6EWrZg4WS9kWoroNhzT6GjPAAhzYzkLiIZxYPsOuvGG
 i+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781555871; x=1782160671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=D882KEthOvY2rIi3k7Eye2n7i4NMV5sVrKHmsFH48ww=;
 b=Rut2ZUjFpyr+5UIk8uY1H4BgnXUJzr70uNKnDCq2yUCr2XcHxza1ochvpQTohRQrra
 zNJ1czm/k7V5MXL4/B3slDRSZoaoN2wFrBuIo+sVGlSWiOhY6zJvHAzVkYrN8cfCDl8/
 S5dntBqJr/98MN0Mi0GVpex5Jvv6VwzBAge0oJ9JPtJxo2QHqrZetiS6aoK5XWCcTT2F
 MgQNBrTdlESZ561Kbfol4GtCqnqTSH1kLXz+cJHPAjL4gOl8Lc6MjLY+LzI0rRlHqPjI
 D8/PmVfb+Ydv0gJwZJgscmOF/yXsVjc21n0UmwvXW79UGL9cDrKyloQRgN28jc5Ya4mf
 PUhw==
X-Gm-Message-State: AOJu0Yxu1PcQucHLWpPharT6EpnB2lN1+S06BXbmEx+4x7+5eAui/EQG
 +U3EXC9h7N5ba3ShPrr/kONPl8bBxtIR3mWvK+5x2ma4oYx96R1yyDeJY3S7ijye7CijT39Rh5e
 m+o0VX0PGpWjNGlPLX67Q+6tC6blWGiGckm6iQWlhtCiD+hqot9LSEGtjSho5+1aJzQ==
X-Gm-Gg: Acq92OEt2+bet7ka1twIxjYwH76sr8Gyswvtwy8lPShcRH8HcNnDcSeg0IaGYrQQHod
 5oHMhHb3vl8aEcsbObrUU1D06QRvxWhxqEr/nj7INrtj5sGNfUi2z9lI4SFxzeZ5SLJYsDy1ntg
 Yh1LibatVo7AT+Dk/X3yEY0BbXTNJBSFu7SHoNU6EHg5weurVKI0ytaoYNMzjQEKFjhV9qUVGzQ
 6gf4I06MAIhCaW1iD6gGw35PwZrw1iRDuc4FurtC6wLBe1UM1GZyhmChJM2gnWHwCdnW7QoYIPS
 IQzL0x5PD/9xCJAfbKEpZNooPID6D7JOeq7cniOKVDae1PLOWWE1hZeOuWScE/0GkDWl1UDT0qm
 vOpFf6s0QZinl3ZIsTqawmc5NR7nEdWXtUBI9krvGB4U7/KXhlW6oKnu4ewk=
X-Received: by 2002:a05:620a:1a18:b0:8cf:f1d9:ba20 with SMTP id
 af79cd13be357-91c23c7c7e6mr194568485a.8.1781555871465; 
 Mon, 15 Jun 2026 13:37:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1a18:b0:8cf:f1d9:ba20 with SMTP id
 af79cd13be357-91c23c7c7e6mr194563585a.8.1781555871038; 
 Mon, 15 Jun 2026 13:37:51 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f4740fbasm9749906d6.29.2026.06.15.13.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 13:37:50 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 05/13] hw/riscv/sifive_u.c: add intc_phandles array
Date: Mon, 15 Jun 2026 17:37:25 -0300
Message-ID: <20260615203734.954428-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX7rh6x+8hE8dF
 iEZ31NHZKDjfZd38TLXui5t36P3bm6KMIGn5rdrY9Ot/tZYIcuoyq610991MXiHgZAlEVsLf1Z/
 jYeOi/w/lbBT7siYgWxR6pLXOSxOBBZ41wUAy3ajqBy1yZl96BMYcK9oLzCt7yfm1zO5h2B/rX7
 8KwFXl4k43EOdeyICv/+505I0UZj35EMAGmjBTmmY9fBUzh2EJIDsF3n7gzg0o8wJ3iazkhprVi
 vv3AKQOLOtjl+4Z96poZo1X3OaeinaZ3RK5RDcMOmwifdITfIrIY2TN58WLC/HVUOeJX8457u/M
 Tj/IvZA/RcgqtvqXuSRIJ26Q3vFEikHkNG9KY6OAENS7CZ5G7hJTvtLLMVamnttHaJ9qVQfBFye
 d5twNZ19e/iUuxTiWnSgLuVZzbHuipYz/uzThHMqsAdGHlPEcdTVtTwkinisQAdjNLnxwD7KLv0
 q9SKkftLCwKAJVzaeMQ==
X-Proofpoint-ORIG-GUID: YomEtPOb7BmRQ1T_2DxQArMkG_US8V4F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIxOCBTYWx0ZWRfX+wbgQTKLkJCA
 6m53F/L1Bw4ihqVTWS7a1wEkwf2LoNxQM374zwsLXVfqGfNm+Pgc9Xj+MSVOot3MR31qpGoZk1L
 jHDD2Bd9HcSPgz3NtICZ1I4azKDALKE=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a3062a0 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=KCrPqT59WbVjnSvmJHsA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: YomEtPOb7BmRQ1T_2DxQArMkG_US8V4F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
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

Store the intc phandles in an 'intc_phandles' array, like the 'virt'
board does, instead of re-creating the interrupt-controller FDT string
and using qemu_fdt_get_phandle() to fetch it.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/sifive_u.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
index a00cfd08a7..ce86989bc8 100644
--- a/hw/riscv/sifive_u.c
+++ b/hw/riscv/sifive_u.c
@@ -111,6 +111,7 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
     static const char * const plic_compat[2] = {
         "sifive,plic-1.0.0", "riscv,plic0"
     };
+    g_autofree uint32_t *intc_phandles = g_new0(uint32_t, ms->smp.cpus);
 
     fdt = ms->fdt = create_board_device_tree("SiFive HiFive Unleashed A00",
         "sifive,hifive-unleashed-a00", &s->fdt_size);
@@ -168,8 +169,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
         qemu_fdt_setprop_string(fdt, nodename, "device_type", "cpu");
         qemu_fdt_setprop_cell(fdt, nodename, "phandle", cpu_phandle);
 
+        intc_phandles[cpu] = phandle++;
+
         qemu_fdt_add_subnode(fdt, intc);
-        qemu_fdt_setprop_cell(fdt, intc, "phandle", phandle++);
+        qemu_fdt_setprop_cell(fdt, intc, "phandle", intc_phandles[cpu]);
         qemu_fdt_setprop_string(fdt, intc, "compatible", "riscv,cpu-intc");
         qemu_fdt_setprop(fdt, intc, "interrupt-controller", NULL, 0);
         qemu_fdt_setprop_cell(fdt, intc, "#interrupt-cells", 1);
@@ -179,14 +182,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
 
     cells =  g_new0(uint32_t, ms->smp.cpus * 4);
     for (cpu = 0; cpu < ms->smp.cpus; cpu++) {
-        nodename =
-            g_strdup_printf("/cpus/cpu@%d/interrupt-controller", cpu);
-        uint32_t intc_phandle = qemu_fdt_get_phandle(fdt, nodename);
-        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 0] = cpu_to_be32(intc_phandles[cpu]);
         cells[cpu * 4 + 1] = cpu_to_be32(IRQ_M_SOFT);
-        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandle);
+        cells[cpu * 4 + 2] = cpu_to_be32(intc_phandles[cpu]);
         cells[cpu * 4 + 3] = cpu_to_be32(IRQ_M_TIMER);
-        g_free(nodename);
     }
     nodename = g_strdup_printf("/soc/clint@%lx",
         (long)memmap[SIFIVE_U_DEV_CLINT].base);
-- 
2.43.0


