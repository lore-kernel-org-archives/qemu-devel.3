Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04A2606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oHd7rfjf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BooGWYqm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVj-0007Uz-7u; Wed, 21 Oct 2026 19:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVh-0007Uj-OT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVf-0004ya-Jg
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:17 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKeJHQ2160543
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=aZTPn3dLfVQ
 QbusORahx+nzRUWSRdq1k8r7nhB7U/pA=; b=oHd7rfjfnZoTy3fF8Ldj/7P+hvW
 Qp5YLxd1cMpgdjncoURIe4pbu6MrsJ4pvgxvSYBZrmMQktIC9mZD4VrJRfyK/Iv8
 6vKh5zWn8eFcK0Yy/GE8FVjVYr+W3rGCORnri0nU2pKif3w0rvSsVesk774eerar
 Ow/vV2sL+4pR05DSQa04dmb3Uzr+dOOqxN4rkzT83HEPyPBXiZFM00gtm8maBM4m
 ClvWfhkruvc66mfbvWQqZrn12CA0Wp5nll4kKdAGm21RhMrfx7D1irpfEpXZDO/X
 ESxtY9TM8ljKBtNUWZM3hLbDJDTp2eXAq3fFZiHUjWg62PtzA4jxLPjyptg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3h348-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:14 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-532f343a55bso23569631cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624454; x=1793229254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aZTPn3dLfVQQbusORahx+nzRUWSRdq1k8r7nhB7U/pA=;
 b=BooGWYqmUeZn3Vls7ws3zTk7wNSdtFbn2h1UOHITf26GljpDTo23epqkJStg+5NozD
 pgLnzYpZZHOT1qflOoJwGOSQVVGtFWJ1huvI4nNJzFMV5IxUmt/bkvclAtNjDSLNF4oe
 oiAqa+Q5+WF5BfeZSnV3w1YMK9ollRmSNzD9Hk5HPTDIVa5GdhfAkojvtZwG3WiaXKfK
 DZ6w7l64dtChQsDAsBTi1oyoYf3Y1egUBEmyy+0CfPyF5mu6P8U3m7lo00UMe/FB68J5
 OGJYdUAsLbCKdXF1xQu33fggKXI3mPSCIP5y/qZrfEKwoRqSU4GOAAz/SFkqBk+1shRG
 1Aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624454; x=1793229254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aZTPn3dLfVQQbusORahx+nzRUWSRdq1k8r7nhB7U/pA=;
 b=BYs3Ljx5Qw8oI9nciWmNCyPNfNIRBGlAqVhzCr57JnY/9ml53rV6TXtb5Q6lnsNFz5
 LdauI/GwBbsI+MI+zpweBlzqRcD/31v7C8oulJJ9B9Rd3sCmdVZwJcSUZT3U19QDVi7Z
 7fn2SNhBdEJ1taBueX4nES8hB3WA8TQMcPeqAQaabgBKxjcIgZD0OEajOkwUe5B+/8We
 KCSYTwdaRmXSu6Wm9yGXXbD+YY9u1EHhlWKM+tZQ8Z9rIJad/FFdnUS0MQSKI4Z0Iybm
 9TK2X+tW6DpnizdSwmn9PhbIp8Gqu0ja7vIR7RRw1Y9q/mUPCFPiInluEYdAZU7PPDIq
 rFmg==
X-Gm-Message-State: AFq9FYIAClUuzlr4X0DmhR75XM3dtEoB7CGVBWHfN7xaYIbZf7KPsXNP
 VQfAOvJnpxAkSdxtPGKO9x1Zds5XoUzw7kQbexfMFwPLyFKXqYwOaerjpX4DejF1NfQ85NEQpA5
 4vUJQSDewrldjoac1Pt6erknU7eHccoiK3dhQIrR2v8q3Z9gszfAoWW3bmNeIhOoQLQ==
X-Gm-Gg: AYBFou0KL8aOQM2UKpoHbhVmyAzbfsnjfTmSgzxq4mmN5MpgFl55j1l4ohoBXGvMkM/
 xMneQBgZjDZkF8ho6PqqIznTDfEwgPX+tGWIZer5WAKerPEuyutJ4jRkrkHe2XCn6jEq0Mg+1ng
 Eyy+9WDQk+KNCcaw6JshTgujots65O6SUv4kdU63ozD1uTlllExNxes7Mp+gg5yE6oIH0ivR4jp
 DzfF5BR1gptKDVvchUJskhyESJp0CCSGtmF4Y+XIwvGR/VcUORJtMZdXo8Wm0cekC1zYe00uYYR
 8BhkNIgka6Zta5TsDNEcjNAhIZRimEXrVowOvnSOlVfHac944Brt/hmLZ7EYBeqkZw0Bl486gH2
 Pf2XGqUjl9Qt+NMxvlHEurFivQi41C/xFjVwqG/MP63u0+maKY68rKleOR+O6NM978ocCyqZA/Q
 ==
X-Received: by 2002:ac8:5f0b:0:b0:536:66ec:1b06 with SMTP id
 d75a77b69052e-5369b89c2e8mr55336741cf.50.1792624453876; 
 Wed, 21 Oct 2026 16:14:13 -0700 (PDT)
X-Received: by 2002:ac8:5f0b:0:b0:536:66ec:1b06 with SMTP id
 d75a77b69052e-5369b89c2e8mr55336341cf.50.1792624453373; 
 Wed, 21 Oct 2026 16:14:13 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:12 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 05/18] hw/riscv/virt.c add trace encoder and ramsink fdt
 nodes
Date: Wed, 21 Oct 2026 20:13:32 -0300
Message-ID: <20261021231346.2452179-6-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad94746 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=mr6zqDPyyxlTI8rpP2AA:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 4Uppqn9bVh51mPvyazwVgAZ1Z2ErLM1v
X-Proofpoint-GUID: 4Uppqn9bVh51mPvyazwVgAZ1Z2ErLM1v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX/J8SLyHqJTYC
 H0sKh7of+Y9U3I6iTMK3+/mHbnwMMNNPefPHTqwW/Rh2v5OXOxGaCugM4fCMyi9N0nqNPpjCWty
 962ALlN2frp0JrPNgi1QoVYiLH88TZLCgn8QUZ1yw1iZAaArS9LvCvDA7kXnWxB2zqHH7mQJoEz
 uLZyhLTAsUZV76ansmBSdcndxFYd8mcaXvPzImea/+elP7TSqwIdFcXfc9RfifelMI7Ogc/54bt
 w6ZDXIwfrhEEETAnZGs2d2qdJtudb2HeblZv1xLqz/NGoN3j15GrH7/j/pgCLiZReHqdjqgrkuF
 iAz5wXXO2t4NcRkIwtrAiPUt6zcrUhE2RpVEDMz3qvnnglj8Juv7bpeh1iUv5xVQNI14XurlMZa
 naXZ6khUCm3rhJIEidxC314UqAeKrSW9YrNErY0+wo1MVA7g+M0wFHhbkJmuR3p0zZKjqh8zdTU
 40Rd9qWpde+EN8gXwyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX0uzpChH98SRV
 6aEi+MUBF5b/Ci+wmwLySF7+A+C71PtBPr75jeJ/EzAC3Wf5yTA16cf4OHhGnNDRs+U00Ikrz0S
 fDhuT5qBxaYeBTdaZ8Bm3ycUTA4O3mY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210092
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

The trace encoder and trace ramsink nodes should confirm to the bindings
described in "riscv,trace-component.yaml" in the Linux kernel. That way,
encoder and ramsink devices get populated on the rvtrace bus and perf
record is able to capture the trace data in the auxtrace section as
expected.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/fdt-common.c         | 70 +++++++++++++++++++++++++++++++++++
 hw/riscv/virt.c               | 47 +++++++++++++++++++++++
 include/hw/riscv/fdt-common.h |  4 ++
 3 files changed, 121 insertions(+)

diff --git a/hw/riscv/fdt-common.c b/hw/riscv/fdt-common.c
index ce2dcb43b4..6130b1bcc1 100644
--- a/hw/riscv/fdt-common.c
+++ b/hw/riscv/fdt-common.c
@@ -105,6 +105,12 @@ void riscv_fdt_create_cpu_socket_subnode(void *fdt,
     qemu_fdt_add_subnode(fdt, "/cpus/cpu-map");
 }
 
+/* Caller must free string after use */
+static char* fdt_get_cpu_nodename(int cpu_id)
+{
+    return g_strdup_printf("/cpus/cpu@%d", cpu_id);
+}
+
 static void
 create_fdt_socket_cpu_internal(void *fdt, char *clust_name, RISCVCPU *cpu_ptr,
                                int cpu, int socket_id, int socket_hartid_base,
@@ -849,3 +855,67 @@ void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
         qemu_fdt_setprop_cells(fdt, name, "interrupts", rtc_irq, 0x4);
     }
 }
+
+/* Returns the 'out-ports/port/endpoint' nodepath.  Caller
+   must free the string after use.  */
+char *riscv_create_fdt_trace_encoder(void *fdt, hwaddr addr, hwaddr size,
+                                     int cpu_id)
+{
+    static const char * const tr_compat[2] = { "qemu,trace-component",
+                                               "riscv,trace-component" };
+    g_autofree char *cpu_nodename = fdt_get_cpu_nodename(cpu_id);
+    g_autofree char *trencoder_name = NULL;
+    char *endpoint = NULL;
+
+    trencoder_name = g_strdup_printf("/soc/encoder@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, trencoder_name);
+
+    qemu_fdt_setprop_sized_cells(fdt, trencoder_name, "reg",
+                                 2, addr,
+                                 2, size);
+
+    qemu_fdt_setprop_string_array(fdt, trencoder_name, "compatible",
+                                  (char **)&tr_compat,
+                                  ARRAY_SIZE(tr_compat));
+
+    qemu_fdt_setprop_phandle(fdt, trencoder_name, "cpus", cpu_nodename);
+
+    endpoint = g_strdup_printf("%s/out-ports/port/endpoint", trencoder_name);
+    qemu_fdt_add_path(fdt, endpoint);
+    qemu_fdt_setprop_cell(fdt, endpoint, "phandle",
+                          qemu_fdt_alloc_phandle(fdt));
+
+    return endpoint;
+}
+
+/* Returns the 'in-ports/port/endpoint' nodepath.  Caller
+   must free the string after use.  */
+char *riscv_create_fdt_trace_ramsink(void *fdt, hwaddr addr, hwaddr size,
+                                     int cpu_id)
+{
+    static const char * const tr_compat[2] = { "qemu,trace-component",
+                                               "riscv,trace-component" };
+    g_autofree char *cpu_nodename = fdt_get_cpu_nodename(cpu_id);
+    g_autofree char *ramsink_name = NULL;
+    char *endpoint = NULL;
+
+    ramsink_name = g_strdup_printf("/soc/ramsink@%"HWADDR_PRIx, addr);
+    qemu_fdt_add_subnode(fdt, ramsink_name);
+
+    qemu_fdt_setprop_sized_cells(fdt, ramsink_name, "reg",
+                                 2, addr,
+                                 2, size);
+
+    qemu_fdt_setprop_string_array(fdt, ramsink_name, "compatible",
+                                  (char **)&tr_compat,
+                                  ARRAY_SIZE(tr_compat));
+
+    qemu_fdt_setprop_phandle(fdt, ramsink_name, "cpus", cpu_nodename);
+
+    endpoint = g_strdup_printf("%s/in-ports/port/endpoint", ramsink_name);
+    qemu_fdt_add_path(fdt, endpoint);
+    qemu_fdt_setprop_cell(fdt, endpoint, "phandle",
+                          qemu_fdt_alloc_phandle(fdt));
+
+    return endpoint;
+}
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d47b295f0c..6bc8d384ec 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -479,6 +479,51 @@ static void create_fdt_iommu(RISCVVirtState *s, uint16_t bdf)
     s->pci_iommu_bdf = bdf;
 }
 
+static void create_fdt_rvtrace(RISCVVirtState *s)
+{
+    MachineState *ms = MACHINE(s);
+    int socket_count = riscv_socket_count(ms);
+    hwaddr encoder_addr, ramsink_addr, size = 0x100;
+    RISCVCPU *cpu_ptr;
+    int cpu_id;
+
+    for (int i = 0; i < socket_count; i++) {
+        for (int cpu = 0; cpu < s->soc[i].num_harts; cpu++) {
+            g_autofree char *in_endpoint = NULL;
+            g_autofree char *out_endpoint = NULL;
+
+            cpu_ptr = &s->soc[i].harts[cpu];
+            if (!cpu_ptr->trencoder) {
+                continue;
+            }
+
+            encoder_addr = object_property_get_uint(cpu_ptr->trencoder,
+                                                    "baseaddr",
+                                                    &error_abort);
+            ramsink_addr = object_property_get_uint(cpu_ptr->trencoder,
+                                                    "dest-baseaddr",
+                                                    &error_abort);
+            cpu_id = s->soc[i].hartid_base + cpu;
+
+            in_endpoint = riscv_create_fdt_trace_ramsink(ms->fdt,
+                                                         ramsink_addr,
+                                                         size, cpu_id);
+
+            out_endpoint = riscv_create_fdt_trace_encoder(ms->fdt,
+                                                          encoder_addr,
+                                                          size, cpu_id);
+
+            /* The remote-endpoint property is bidirectional, i.e. the
+               in-ports endpoint must point to the out-ports endpoint
+               and vice-versa.  */
+            qemu_fdt_setprop_phandle(ms->fdt, in_endpoint,
+                                     "remote-endpoint", out_endpoint);
+            qemu_fdt_setprop_phandle(ms->fdt, out_endpoint,
+                                     "remote-endpoint", in_endpoint);
+        }
+    }
+}
+
 static void finalize_fdt(RISCVVirtState *s)
 {
     uint32_t phandle = 1, irq_mmio_phandle = 1, msi_pcie_phandle = 1;
@@ -520,6 +565,8 @@ static void finalize_fdt(RISCVVirtState *s)
 
     riscv_create_fdt_rtc(MACHINE(s)->fdt, &s->memmap[VIRT_RTC], RTC_IRQ,
                          s->aia_type, irq_mmio_phandle);
+
+    create_fdt_rvtrace(s);
 }
 
 static void create_fdt(RISCVVirtState *s)
diff --git a/include/hw/riscv/fdt-common.h b/include/hw/riscv/fdt-common.h
index eb9db8278d..fd03a9e0ab 100644
--- a/include/hw/riscv/fdt-common.h
+++ b/include/hw/riscv/fdt-common.h
@@ -136,4 +136,8 @@ void riscv_create_fdt_uart(void *fdt, const MemMapEntry *uart_mem,
 void riscv_create_fdt_rtc(void *fdt, const MemMapEntry *rtc_mem,
                           int rtc_irq, int aia_type,
                           uint32_t irq_phandle);
+char *riscv_create_fdt_trace_encoder(void *fdt, hwaddr addr, hwaddr size,
+                                     int cpu_id);
+char *riscv_create_fdt_trace_ramsink(void *fdt, hwaddr addr, hwaddr size,
+                                     int cpu_id);
 #endif
-- 
2.43.0


