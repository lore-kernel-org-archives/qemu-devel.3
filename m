Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5017606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I18FkH+p;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=M+H3b1dP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJfVt-0007XL-D1; Wed, 21 Oct 2026 19:14:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVr-0007WU-QB
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xJfVp-0004zV-9g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 19:14:27 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe3Wu1722154
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=acjVIM2r1vM
 55cDcLowpvxSF7MECSUwgTJBW0V12bqY=; b=I18FkH+pUvwyVpPq2aueQNvUNlm
 ydf7cPHoa3nA7VhMEc2iDO1J+p1eDGuBRsevV4mAN6PKcqp4ylpDnmGFGTDQ9Isz
 CuHe8W+5sBygQYHab6PDtwYDVAs4Xl+ZwUKUDXNCbxnDj4plUx/fK8KJyTOCLTC1
 MzsFoJFjpp7iOBCk1O2Nlzo5WjJW79lApymsMu7KGocMc+xJ3tmenF6SlQ9q2qKx
 Uz+XBW9yEiu8QgFYF0RXHumOF+gLh//iY50JHfqqjbP+1kViTUZeKSa40WJlpEvX
 fMmswZi3BofqjdwB6ERwI0T1b9UWbuP7S/xWtP1WEdqI2QjzCVg0hXIwqgg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hetj4b5cc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 23:14:23 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5337ed1ba44so25944691cf.3
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 16:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792624462; x=1793229262; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acjVIM2r1vM55cDcLowpvxSF7MECSUwgTJBW0V12bqY=;
 b=M+H3b1dPo42Tnn+pYj4pdvCUcrU1WaiQtYsqVruiUbWUo+X6XWilQ2kHBYwtGz/aNS
 oMZGGU7u8QSYzVG2srbZ9QZy7UrCeqeB8X6woTQ507g6qFnzMWbtw1X4kEV6MDNZ5ukD
 h05QWJX2ToCapjpd6FWIJ5rQ+xG+zQ4041G6f0US68J/vNoud7UvJ76k5Vc20AqpmmR9
 BzNo/P+/9vS2AjU0PeYJs62yC9/QUqPpUoBGASSYBaJ4/HdwrNZNR5Ff2HeA1nG62f/1
 rekr8sYeUxy0KPhFU+JjhtfXJvLPcTL2dhpxtzrtkvURe+ULqcE9iBhOIpA7lABE5n42
 sxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792624462; x=1793229262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=acjVIM2r1vM55cDcLowpvxSF7MECSUwgTJBW0V12bqY=;
 b=rx9dKCZsXiWD2IPYh1YEOZY463xAlsV6WUh4kV7+2KTDpZKsHmjKE52ZIA0q8y9/D6
 jG+oPRm+hrt7Dp0Ogx68n44bkS8bxBC019fZlYrTEu3N3rHKKVEfNgGUchNBPUUPR6bU
 C1jTA+JzPAduxk+yJ4nftUrrF50Zl4g8Jf2BRYmjxRWdyjA6fhTHvq0hJo8S5vGarj6L
 U8sFgc3fOnmnEKBGfEXcjl84uBhBQRSwhEIPxQr7eJSInzPxjjG9YoaEgNmau0KrmBUS
 VW+vo95gh2v00uuLZbH1zkFNDJIT2kYPeHIBrtRY4kUYmkwbzXwdNcG2owBDtVJ8di2+
 Hdwg==
X-Gm-Message-State: AFq9FYJarf5I6BuKpiSjaOeJSZXzza2tP8Z36q6fWDsnhbCi0TOgDScq
 8JqUlyOb4MH+YatIvbhkbeKOSKwNdqLleC51L+rLVINp3xPE2pIiSqmwz/jjcFazQKMeiWHre4r
 ZKjiTcSoinFxTeSyPAbNw1d4ixQY389mIsAPhOP6yA+mJqWoEZ6zDR0HF1yIxHdalbA==
X-Gm-Gg: AYBFou0URrE7OWzA7G2dBTzn8xhVNChT2B6z3Eoy3RXEXCownLAPbL62dLe5NqwUIFp
 VDrIaEhgTEAGIxWUJhnnDDrBKbdE6MAELG59GJwTPJ4yCEPOV24xwKO/lzScHFUKfgxLIFKS1LN
 1bdcnvHzM4zth31zW6sDM1eyu1fJlRVje1O1WT8WX5EdtuPwKO4JwKDOU/CeF19oEaH+PagNf/i
 jqCAIdofuBdD+hgckpI5cp8Akd3hCrL8iaR+9WwHl2Im87Kb68vyYg7gQsUlYOqx7r4BG634SNU
 uQUYDHGC+9GupKkKoNB1c+5PHc1CexTZyOhKyfC8wSiV5zHh6ZfcYymfL7f4RHLZ0r8fiy1mlmY
 tlbsAtc+3fzt1GUu3tP6+WIvbLcwUVP5TuXuedOm5VGWvWnpeJ4os4cqkigxJ5E1oxxYU35lZVw
 ==
X-Received: by 2002:a05:622a:a15:b0:536:9980:9a66 with SMTP id
 d75a77b69052e-5369b8f836amr54503911cf.41.1792624462252; 
 Wed, 21 Oct 2026 16:14:22 -0700 (PDT)
X-Received: by 2002:a05:622a:a15:b0:536:9980:9a66 with SMTP id
 d75a77b69052e-5369b8f836amr54503541cf.41.1792624461773; 
 Wed, 21 Oct 2026 16:14:21 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com
 (200-204-190-237.dsl.telesp.net.br. [200.204.190.237])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-536ab6cd0dcsm11995651cf.6.2026.10.21.16.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 16:14:21 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 antikostya2@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 08/18] hw/riscv/trace-encoder: write e-trace packets to RAM
 sink
Date: Wed, 21 Oct 2026 20:13:35 -0300
Message-ID: <20261021231346.2452179-9-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
References: <20261021231346.2452179-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jTpOYRM5YbaclVIrvOVew15NDTZZYisv
X-Proofpoint-GUID: jTpOYRM5YbaclVIrvOVew15NDTZZYisv
X-Authority-Analysis: v=2.4 cv=N768hG9B c=1 sm=1 tr=0 ts=6ad9474f cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=QmVDPCq3bE4LYXGvZ20s0w==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=R6bvkyUyvnGTYty0lT0A:9 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX7+1W3yguchxE
 cF3v7+MRJtQ+BlXHIWN5s8bv2Dshf3SAc4nm4YYP695jkCo+EvwxZs26JKjlCOlLR5tTIPYNanH
 eAOxPZrJCDNdZOB+HVND1QXYtkUa5Z2CuryzNG6FsKnCDx+inMmUYBVN7saBbleWy/hBz2tB0Zf
 TyKvG39Zf6CHQ/wHklzKNPzGPU/afTi+4IQ/0oGRV2Ok9rdg4tF23y+7etACfBRRKRr6CVkegeY
 7kdlAH2Y1Qperdur4rEDeqmTbDQyZy2XZpt3BY5dWDn5ifIi62zOvjRFO66M0rtwKg6M6cWlHdf
 9tmRRUDgakZIidHMHkg7Ms4qNdfZNXh7sDaLHVfN3kFbDGh6lv+aCvE7KJTj74jGGM1Li4XmjQh
 3O2NrQL2sfeTbNGnmHW3Yd1o4XOzLZuzWkJ3cJZo/FGxo+6FqLAa5u9Sp4jk+1RKWtfcV04qzCa
 Op2Vp+epn+YpoLKE7cg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA5MiBTYWx0ZWRfX7O8LdDUQh4Qy
 SHzXKCmW1zfvj9X0znXuimyieEMY+d/svVQICsErvDKqmQ9zgOyyJsMT/Iaj1ynXUyq4pyqr5QV
 nZg/wFeK84CX6x4nbtmXW25CjxZlqqE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210092
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

We have the needed pieces to make the trace encoder write messages (or
packets, in e-trace lingo) in its associated RAM sink.

We'll start by writing a sync message that we're already able to fetch
from the TCG instruction train. The trace encoder must be able to
read/write TR_RAM_WP RAM sink regs to know where it is supposed to write
packets, thus a handful of helpers are added to manipulate both the ram
sink SMEM memory and relevant registers.

The bulk of the work is done in trencoder_send_message_smem() where the
trace encoder writes each trace packet. The 'wrap' mechanism is
implemented to keep writing the RAM sink memory even after a SMEM
workflow.  If we can't fit a full packet in the end of the ring buffer
we're filling with NULLs and writing a new packet back to ramstart.

In an overflow event we'll wrap the TR_RAM_WP_LOW WRAP bit and userspace
is supposed to clear it after the wrapping was handled (i.e. userspace
read the whole ring buffer back to the start).

We're also allowing userspace to freely set ramsink and ramstart before
the trace session begins, allowing for more freedom w.r.t where the SMEM
will be written by the encoder. Note that this also means that userspace
is responsible for setting at least TR_RAM_WP_LOW and TR_RAM_WP_HIGH
before starting a trace session.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 hw/riscv/trace-encoder.c | 122 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/hw/riscv/trace-encoder.c b/hw/riscv/trace-encoder.c
index 1f89dc24fc..2b358b2699 100644
--- a/hw/riscv/trace-encoder.c
+++ b/hw/riscv/trace-encoder.c
@@ -18,8 +18,37 @@
 #include "qapi/error.h"
 #include "trace.h"
 #include "system/device_tree.h"
+#include "system/physmem.h"
 #include "hw/core/register.h"
 #include "cpu.h"
+#include "hw/riscv/trace-ram-sink.h"
+#include "rv-trace-messages.h"
+
+/*
+ * Size of header + payload since we're not sending
+ * srcID and timestamp.
+ */
+#define TRACE_MSG_MAX_SIZE 32
+
+static TracePrivLevel trencoder_get_curr_priv_level(TraceEncoder *te)
+{
+    CPURISCVState *env = &te->cpu->env;
+
+    switch (env->priv) {
+    case PRV_U:
+        return env->virt_enabled ? VU : U;
+    case PRV_S:
+        return env->virt_enabled ? VS : S_HS;
+    case PRV_M:
+        return M;
+    }
+
+    /*
+     * Return a reserved value to signal an error.
+     * TODO: handle Debug (D).
+     */
+    return RESERVED;
+}
 
 /*
  * trTeControl register fields
@@ -82,6 +111,41 @@ REG32(TR_TE_IMPL, 0x4)
 REG32(TR_TE_INST_FEATURES, 0x8)
     FIELD(TR_TE_INST_FEATURES, NO_ADDR_DIFF, 0, 1)
 
+static uint32_t trencoder_read_reg(TraceEncoder *te, uint32_t reg_addr)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+    uint32_t val;
+
+    physical_memory_read(addr, &val, sizeof(uint32_t));
+    return val;
+}
+
+static void trencoder_write_reg(TraceEncoder *te, uint32_t reg_addr,
+                                uint32_t val)
+{
+    hwaddr addr = te->dest_baseaddr + reg_addr;
+
+    physical_memory_write(addr, &val, sizeof(uint32_t));
+}
+
+static hwaddr trencoder_read_ramsink_writep(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_WP_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    return ret;
+}
+
+static hwaddr trencoder_read_ramsink_ramlimit(TraceEncoder *te)
+{
+    hwaddr ret = trencoder_read_reg(te, A_TR_RAM_LIMIT_HIGH);
+    ret <<= 32;
+    ret += trencoder_read_reg(te, A_TR_RAM_LIMIT_LOW);
+
+    return ret;
+}
+
 static uint64_t trencoder_te_ctrl_set_hardwire_vals(uint64_t input)
 {
     input = FIELD_DP32(input, TR_TE_CONTROL, INST_MODE, 0x6);
@@ -171,6 +235,9 @@ static void trencoder_te_ctrl_postw(RegisterInfo *reg, uint64_t val)
     if (!te->trace_running && trTeInstTracing) {
         /* Starting trace. Ask the CPU for the first trace insn */
         te->trace_next_insn = true;
+
+        te->ramsink_ramstart = trencoder_read_ramsink_writep(te);
+        te->ramsink_ramlimit = trencoder_read_ramsink_ramlimit(te);
     }
 
     te->trace_running = trTeInstTracing ? true : false;
@@ -274,12 +341,67 @@ static void trencoder_realize(DeviceState *dev, Error **errp)
     }
 }
 
+static void trencoder_update_ramsink_writep(TraceEncoder *te,
+                                            hwaddr wp_val,
+                                            bool wrapped)
+{
+    uint32_t wp_low = trencoder_read_reg(te, A_TR_RAM_WP_LOW);
+
+    wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, ADDR,
+                        extract64(wp_val, 2, 30));
+
+    if (wrapped) {
+        wp_low = FIELD_DP32(wp_low, TR_RAM_WP_LOW, WRAP, 1);
+    }
+
+    trencoder_write_reg(te, A_TR_RAM_WP_LOW, wp_low);
+    trencoder_write_reg(te, A_TR_RAM_WP_HIGH, extract64(wp_val, 32, 32));
+}
+
+static void trencoder_send_message_smem(TraceEncoder *trencoder,
+                                        uint8_t *msg, uint8_t msg_size)
+{
+    hwaddr dest = trencoder_read_ramsink_writep(trencoder);
+    bool wrapped = false;
+
+    msg_size = QEMU_ALIGN_UP(msg_size, 4);
+
+    /* clear trRamWrap before writing to SMEM */
+    dest = FIELD_DP64(dest, TR_RAM_WP_LOW, WRAP, 0);
+
+    /*
+     * Fill with null bytes if we can't fit the packet in
+     * ramlimit, set wrap and write the packet in ramstart.
+     */
+    if (dest + msg_size > trencoder->ramsink_ramlimit) {
+        g_autofree uint8_t *null_packet = NULL;
+        uint8_t null_size = trencoder->ramsink_ramlimit - dest;
+
+        null_packet = g_malloc0(null_size);
+        physical_memory_write(dest, null_packet, null_size);
+
+        dest = trencoder->ramsink_ramstart;
+        wrapped = true;
+    }
+
+    physical_memory_write(dest, msg, msg_size);
+    dest += msg_size;
+
+    trencoder_update_ramsink_writep(trencoder, dest, wrapped);
+}
+
 void trencoder_set_first_trace_insn(Object *trencoder_obj, uint64_t pc)
 {
     TraceEncoder *trencoder = TRACE_ENCODER(trencoder_obj);
+    TracePrivLevel priv = trencoder_get_curr_priv_level(trencoder);
+    g_autofree uint8_t *msg = g_malloc0(TRACE_MSG_MAX_SIZE);
+    uint8_t msg_size;
 
     trencoder->first_pc = pc;
     trace_trencoder_first_trace_insn(pc);
+    msg_size = rv_etrace_gen_encoded_sync_msg(msg, pc, priv);
+
+    trencoder_send_message_smem(trencoder, msg, msg_size);
 }
 
 static const Property trencoder_props[] = {
-- 
2.43.0


