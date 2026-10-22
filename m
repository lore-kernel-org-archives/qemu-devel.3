Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128F606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UWnp415s;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jnKxkmka
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0kc-0005GV-Rr; Thu, 22 Oct 2026 17:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kT-00052b-3I
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:55:01 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0kR-0007vG-CO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:54:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtMBm861122
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=; b=UWnp415sSti92vTK
 +69DFdsslBMpPnHD5S6y2veAr0QzGfGwSz5yZXF9u6beAbdAH5yFoy+1fnKxV/hz
 RZpI9/ppSvpZzb944HPAjpbWBic8KuhS+s3yLMShWph+PlMFWPF6EtBKcuoA17dC
 2npwruQsOgQM2aF4CLKvnu3HuTIczMa47z7bgMgh17RI5KfJkzuTw0xtMAiWe6LW
 EVuPp5msgUFQp+l3BK14FPUCeeWe24w6bdvv5YlpICmnPl0KkBtsJUFYDq46bLRn
 YuK8Wi+W97NasyNoZg1XQCIs/ZZ0JLeULG2a4+7JXhAEKcTPYqEPmuGhfZjtcw2z
 OaQpXQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0h9qp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:54:53 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f5844e383so50106485a.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706093; x=1793310893; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=;
 b=jnKxkmka7E2BMk3mgFMT2J7M21gJ4Y8Q/hppDUnEuWFiaXvJm4Y7y01C4t/ShojGT4
 Y/1gWbzg+hQsGSTLVfjSGi3mz8WIgxShVlhIaPctqk92LWTyssJDNOR1IL4x2sTk54Nt
 y4S4DSBhxluCN440zgKGNFUD6Y9xA0/eTYhLP4hj55uZRDeZUrgjVf7HDQv4E2kcg9Pk
 VKsNdlv3m4zb+AUVARYuVeu/FCRFylFZUKUmNmfggJt16yRd3hZoZQbebM7trO96WA/q
 Dxs3asTY7hBwfJFQdymH0lg0B2MDG0D8MyoR3wsPcd5j4LZL8wVADzH8UJpfg2RQtXzf
 Edow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706093; x=1793310893;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p7RQ7yiqg1Ox1Ti9CPFcdqZ1SQNOTHd0iyzgVVE7fmg=;
 b=CGew/v17dRNjw3xb1oiVLJ3IugkTKGs4PKnkR1KLcr1f/+PVD3LfACGHNrtYlV7zFZ
 03M4gpLh1ugRpdDrR7aUHAoBBrskGBh5rAr7df4eH8o7PzWaHJ+87+sSI1RR4UzdpEK4
 Yqfb9EFIDIov+Gi5G3g2LTaF/Nc4GiVIGkJTfrMUADSSbez4t42fNrG5dL9VIIdbJQ7K
 SCmzJYs4tMfKjqeRC7VT92sI2WSKuB5vU/GTrLaj8kHQzXhZvNR8WjIxt8ZQaf0CKccd
 38qCJtzhjqiSu7iy5474Rn739CTjO2aGchoJ1Y1N2/yElNy1mub1z0ExmHwDiA2dW+9q
 OImg==
X-Gm-Message-State: AFq9FYIVS3e8ALTQ27Bfv1gToBrnbCFLhHqgyivc1q9XQqcwoA3PM6b/
 Ssh6EvPpy6X9m0ixsAMPrxGPVbd3eLV3Rg7eme82fzlVS9sXDP6pB1fdqV40vGbjO0uDINgnT6U
 NyiwrU4VkJ1lVt3jmfLRzn2wJKAfn0DSI84ux76q+/FLKthxISDha+ta48ALDz3rl8Q==
X-Gm-Gg: AYBFou37v6N/GdwvrSh1Gawj4Faz2h56T8VM70Lz6QldZaO8oE5rCAYo/sED0pgV//+
 RsfDSRfFGOWI6jR11El03ixXeVtq1d3xz3f6ik+uufES3NMAkjV/NXcT/jXrH1Lir2bA8whKvRm
 vL3YUeNfphXcgggytwK+iACAhOQZUGwX0u+24jKiEPfA/v74tdmsSYvMF2JG+3UiWoH7eSiJVTf
 DKzHC9nysRnqFqUxkFkwcCe7vCVYlyMeYCs1Bl1cGar559J2Z9tnV2CsuarsSWopZJElO3kaFBF
 KkwP5zoU3qtSLqAuogIBVZZuVTmQTa33+//wn8HU8EVW+CjdNewRNuWllvQLfVF584JcJsAbaYk
 semD+COiYO17brQxa1Q/r+nHixiNxrC/SbiwPP83D
X-Received: by 2002:a05:620a:c50:b0:93e:7192:191c with SMTP id
 af79cd13be357-93f6f91e524mr139569385a.17.1792706092737; 
 Thu, 22 Oct 2026 14:54:52 -0700 (PDT)
X-Received: by 2002:a05:620a:c50:b0:93e:7192:191c with SMTP id
 af79cd13be357-93f6f91e524mr139566385a.17.1792706092109; 
 Thu, 22 Oct 2026 14:54:52 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e38048ae6sm645821f8f.37.2026.10.22.14.54.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:54:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH v3 29/33] target/sh4: Register CPUClass::exception_name()
 handler
Date: Thu, 22 Oct 2026 23:51:09 +0200
Message-ID: <20261022215115.19680-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: hIpycqk6XqLPMfKmxUmhO5mErUVmiwF8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX65W/cxYiyG6l
 XGZi0FFssAPn4KDpsBzrNNZwaGVnhJ1qumpRJswHAfKoyqwc9lj0iGpGobbS/5fezeNIuc1qdWw
 NXufPcf22q2TC4ycTG+JZ18BjTluxHSKvehf+oxgbKmzWpfjvyU0lwTfMUQVSVvDoa6HVPLqtZu
 OabMHuqlqxmvxs3pjy/HfKfoFXnLqJ+/DejATQVQdmHBEPf/Y9IuWizIuLR4rbe40rZGiR3nY/x
 6oAM+jfChI/NVOMQpngeJPXkyOyHcuXaMAn4rtihlLHafUswHtbmZG+SR/V5VJp27kaXnZp/TqO
 tpTJQvuTncABQdp/YLkImBFm+BdfkNmNCANtdwbAzmnwJJPtqdYKq8ZA0cyyqz4qV6WOdhx7kKS
 LnpmXqqyGUi3veHCJ4r5ZpIKnJFSIfzTi3XJoPJmeLpQUdf1aqWAze0Wa7oHe+rx0rFTStM2A9n
 lkDskZFMoRyPEreXrRw==
X-Proofpoint-GUID: hIpycqk6XqLPMfKmxUmhO5mErUVmiwF8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX07zLWQRvZ7hF
 koWnTTWneMIyIazWOYwxbl8h85tM/j3JzMKJboL9nhqtUU7bx5qmXyyHb9i1pfOAVG1fdnf6qP0
 qLX+ycZGa+FTF4YLsyhrN6VbQnPCxTs=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada862d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=1bLhyRm5UWLPkFMrcSkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Factor sh4_exception_name() out of superh_cpu_do_interrupt()
and register it as the CPUClass::exception_name() handler,
so the common exception logging can resolve SH-4 exception
codes to names.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/sh4/cpu.h    |   1 +
 target/sh4/cpu.c    |   1 +
 target/sh4/helper.c | 101 +++++++++++++++++++++++---------------------
 3 files changed, 56 insertions(+), 47 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index a1e9049b7be..94f2f1278b9 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -258,6 +258,7 @@ struct SuperHCPUClass {
     uint32_t cvr;
 };
 
+const char *sh4_exception_name(int excp);
 void superh_cpu_dump_state(CPUState *cpu, FILE *f, int flags);
 int superh_cpu_gdb_read_register(CPUState *cpu, GByteArray *buf, int reg);
 int superh_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
index 3bbdee301d5..97a718c3911 100644
--- a/target/sh4/cpu.c
+++ b/target/sh4/cpu.c
@@ -334,6 +334,7 @@ static void superh_cpu_class_init(ObjectClass *oc, const void *data)
                                        &scc->parent_phases);
 
     cc->class_by_name = superh_cpu_class_by_name;
+    cc->exception_name = sh4_exception_name;
     cc->dump_state = superh_cpu_dump_state;
     cc->set_pc = superh_cpu_set_pc;
     cc->get_pc = superh_cpu_get_pc;
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index 0fbd613f333..5856bab6983 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -47,6 +47,58 @@
 #define MMU_DADDR_ERROR_READ     (-12)
 #define MMU_DADDR_ERROR_WRITE    (-13)
 
+const char *sh4_exception_name(int excp)
+{
+    const char *name;
+
+    switch (excp) {
+    case SH4_EXCP_ADDR_ERROR:
+        name = "addr_error";
+        break;
+    case SH4_EXCP_TLB_MISS:
+        name = "tlb_miss";
+        break;
+    case SH4_EXCP_TLB_VIOLATION:
+        name = "tlb_violation";
+        break;
+    case SH4_EXCP_ILLEGAL_INSTRUCTION:
+        name = "illegal_instruction";
+        break;
+    case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
+        name = "slot_illegal_instruction";
+        break;
+    case SH4_EXCP_FPU_DISABLE:
+        name = "fpu_disable";
+        break;
+    case SH4_EXCP_SLOT_FPU_DISABLE:
+        name = "slot_fpu";
+        break;
+    case SH4_EXCP_DATA_WRITE:
+        name = "data_write";
+        break;
+    case SH4_EXCP_DTLB_MISS_WRITE:
+        name = "dtlb_miss_write";
+        break;
+    case SH4_EXCP_DTLB_VIOLATION_WRITE:
+        name = "dtlb_violation_write";
+        break;
+    case SH4_EXCP_FPU:
+        name = "fpu_exception";
+        break;
+    case SH4_EXCP_INITIAL_PAGE_WRITE:
+        name = "initial_page_write";
+        break;
+    case SH4_EXCP_TRAPA:
+        name = "trapa";
+        break;
+    default:
+        name = "???";
+        break;
+    }
+
+    return name;
+}
+
 #if defined(CONFIG_USER_ONLY)
 
 int cpu_sh4_is_cached(CPUSH4State *env, uint32_t addr)
@@ -95,53 +147,8 @@ void superh_cpu_do_interrupt(CPUState *cs)
     }
 
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
-        const char *expname;
-        switch (cs->exception_index) {
-        case SH4_EXCP_ADDR_ERROR:
-            expname = "addr_error";
-            break;
-        case SH4_EXCP_TLB_MISS:
-            expname = "tlb_miss";
-            break;
-        case SH4_EXCP_TLB_VIOLATION:
-            expname = "tlb_violation";
-            break;
-        case SH4_EXCP_ILLEGAL_INSTRUCTION:
-            expname = "illegal_instruction";
-            break;
-        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
-            expname = "slot_illegal_instruction";
-            break;
-        case SH4_EXCP_FPU_DISABLE:
-            expname = "fpu_disable";
-            break;
-        case SH4_EXCP_SLOT_FPU_DISABLE:
-            expname = "slot_fpu";
-            break;
-        case SH4_EXCP_DATA_WRITE:
-            expname = "data_write";
-            break;
-        case SH4_EXCP_DTLB_MISS_WRITE:
-            expname = "dtlb_miss_write";
-            break;
-        case SH4_EXCP_DTLB_VIOLATION_WRITE:
-            expname = "dtlb_violation_write";
-            break;
-        case SH4_EXCP_FPU:
-            expname = "fpu_exception";
-            break;
-        case SH4_EXCP_INITIAL_PAGE_WRITE:
-            expname = "initial_page_write";
-            break;
-        case SH4_EXCP_TRAPA:
-            expname = "trapa";
-            break;
-        default:
-            expname = do_irq ? "interrupt" : "???";
-            break;
-        }
-        qemu_log("exception 0x%03x [%s] raised\n",
-                  irq_vector, expname);
+        qemu_log("exception 0x%03x [%s] raised\n", irq_vector,
+                 do_irq ? "interrupt" : sh4_exception_name(cs->exception_index));
         log_cpu_state(cs, 0);
     }
 
-- 
2.55.0


