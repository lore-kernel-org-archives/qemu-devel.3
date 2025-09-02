Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD442CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:56:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1d-0003X2-0h; Mon, 01 Sep 2025 23:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1X-00031Z-Dd
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1U-0004e5-V7
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:35 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822SAKI022312
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PqI4bZNCgVlMM7GvpicjhmQQfbviVJTHvFtF54ovtNU=; b=VDB2qwsv+TAQ6PBj
 jdrdrKPVrAcBrPyj7xajD7EjILIBGmzg0YWHoJzdsTpwdJBAQr5mX4Dnfieb5yPI
 dNj0vLs3vla9xsZ89xcyGTIsy543PdgXNCyf3wUhpowYAhDml9HAeFma1PPRfpd9
 V1q6OM60mfSJITxmlVHFV/q+jabXEtVIoyZsTEUfEvKZ8aVDOwDO8Si+dkpGAxJK
 dXxvAPsTzP/gJvXB8G7TwVH3oy4xTHTwtKd7kOJ3wxeSjGMyD/9s33t+QN9IGzcI
 Qo+waG8UeRGe82o/lzD5PZxxOQ7qe7W2C4IuiC0DViFMHlYXfnWvVvrO5ORssKTO
 oOMgEQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnp6huq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-325ce108e16so7459405a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784960; x=1757389760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PqI4bZNCgVlMM7GvpicjhmQQfbviVJTHvFtF54ovtNU=;
 b=qFtyQszu+J1q8oQzEIvk6nfNuwqhhTMpnMcSvlV5wYyPQC5a22/ckGwEnQCcTpUr5G
 3X7GgT8ChHhiVevP0z1PsVp331KvFRBfyki8iHGEbShzXbjQLszrcUDVP3bSumD8brWR
 F/DxFPlCS1I8EJIBNUl41nYnBuZtF6aDlDeuecnV+Nl7rHdUfNt1BHlKP5+PXTscX8y1
 JbdJhaQFxDC5131DJqInoJPpah5GavCY8G5xkGPftfEdGpSs0RNmRp38VBOdvRCEDAfI
 l5FKczY8f+ZDPgwibW1nzLVIcyZOWU+USfjeUySUXuYolHm27M+vgUnsQ3g1Dh2ghYog
 Ez7Q==
X-Gm-Message-State: AOJu0YwbJtk2NZAan4/VIY/mNhuoLWYMZXypF4IPNuIngJwiRSXluLaw
 j3QxfoyMMSyvWgzq2mj97DAqdZFvYx16yMMLeFrpg0WdnKvKOFTz4o5O2O4Id9riHijTbhqLEGY
 TjlQH9myLVOOBuFXc8LaXmfX4uj4nqNcEm2eNAukDrqsnOnT7AVes5QSKJc3ULzVN+exO
X-Gm-Gg: ASbGncvddYn6XlkSNW3PpL0PXFfQkVkgwzLtBYjBm4NOsCjTSrHJSKZWKtm4Ed2eK0p
 Qz07Uh67BSRCdF+KuhUhYgX1cxtvVg4BHKd9uWFp0NvPMX0YKs16FfSfQdcTyObrHdII3Q4NHad
 +LVUjXNF5XTHwvQ5sp7FZKR9/C6QmB/BkXOHVNo7oSmAx420zkUmL7dYSh9qBFRADQYz0PHei7B
 ziGhBbbKSTVEZt7QhJL2+TrDg7kARzti8xmJoEMnvnMZQ2MiYy9NMMmF2WAVkkxoMrarG5W9QU+
 alzCDAbV/5J10+OFX7szHkVdVpxrOLBx+sewWmkDT9d0WqC1h8FLzScbg94GA7kgm8V3k8/1p8b
 skWzNM6BFWJa5
X-Received: by 2002:a17:90b:3d86:b0:325:4751:3446 with SMTP id
 98e67ed59e1d1-328156c59b3mr15326070a91.24.1756784960430; 
 Mon, 01 Sep 2025 20:49:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXv0d8g2vqOMWgk1fqIMNdYiBnMR4tscB6b/LygKZFWsVSKystuUe+sBAPeeye6vOSkHQUFA==
X-Received: by 2002:a17:90b:3d86:b0:325:4751:3446 with SMTP id
 98e67ed59e1d1-328156c59b3mr15326037a91.24.1756784959954; 
 Mon, 01 Sep 2025 20:49:19 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 23/39] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Mon,  1 Sep 2025 20:48:31 -0700
Message-Id: <20250902034847.1948010-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e_t-UCxKWi4zaiXakdoyuH62hu8LWGhH
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b66941 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=fg0LxJQkbHe3Ved8Rg4A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: e_t-UCxKWi4zaiXakdoyuH62hu8LWGhH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX5s3bV4+7Jixh
 81P978WFSSwr1ZhbWGRRwBfgJBufano6fvtru0JTmwVG2RoP6zA0B3UPmGWR5Qp6wdVyXiXjUbq
 akcCwKGqDgWFwp3qzD3HVh5pxnu065Nie95tqsM53SsGSK+SorKXJMLAov+FR/m0OeW0O0tRrVZ
 zreRpi3Z9j0NQIS9Msj/hn9jh0EIrbKXkNPF0gICYbSr+KV3iN8ysGsfxZxHMknwuCpB2h0N5z+
 2Xm8eRhgUF/XkvXYwMvBEWB3/uPnqe8LDOPmmEYF7qDT8uN6TJI3Zhhy0woeAForUBMGhzRCwj8
 IbajCfj6EyM3OiIciEL59QP67q0wHMn4pYd9OUB2oTcqKyVnESVd4TXdvNTpWPu9LDpktdcutII
 JUymCTSz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 2ae6874841..2af0b4089e 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -19,6 +19,7 @@
 #include "qemu/qemu-print.h"
 #include "cpu.h"
 #include "internal.h"
+#include "exec/cputlb.h"
 #include "exec/translation-block.h"
 #include "qapi/error.h"
 #include "hw/qdev-properties.h"
@@ -518,6 +519,24 @@ static void find_qemu_subpage(vaddr *addr, hwaddr *phys, int page_size)
     *phys += offset;
 }
 
+static hwaddr hexagon_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    hwaddr phys_addr;
+    int prot;
+    int page_size = 0;
+    int32_t excp = 0;
+    int mmu_idx = MMU_KERNEL_IDX;
+
+    if (get_physical_address(env, &phys_addr, &prot, &page_size, &excp,
+                             addr, 0, mmu_idx)) {
+        find_qemu_subpage(&addr, &phys_addr, page_size);
+        return phys_addr;
+    }
+
+    return -1;
+}
+
 
 #define INVALID_BADVA 0xbadabada
 
@@ -623,6 +642,13 @@ static bool hexagon_tlb_fill(CPUState *cs, vaddr address, int size,
     do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC], retaddr);
 }
 
+#include "hw/core/sysemu-cpu-ops.h"
+
+static const struct SysemuCPUOps hexagon_sysemu_ops = {
+    .has_work = hexagon_cpu_has_work,
+    .get_phys_page_debug = hexagon_cpu_get_phys_page_debug,
+};
+
 static bool hexagon_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
 {
     CPUHexagonState *env = cpu_env(cs);
@@ -665,6 +691,8 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .pointer_wrap = hexagon_pointer_wrap,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
+    .cpu_exec_halt = hexagon_cpu_has_work,
+    .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
 };
 
@@ -692,9 +720,12 @@ static void hexagon_cpu_class_init(ObjectClass *c, const void *data)
     cc->gdb_core_xml_file = "hexagon-core.xml";
     cc->disas_set_info = hexagon_cpu_disas_set_info;
 #ifndef CONFIG_USER_ONLY
+    cc->sysemu_ops = &hexagon_sysemu_ops;
     dc->vmsd = &vmstate_hexagon_cpu;
 #endif
+#ifdef CONFIG_TCG
     cc->tcg_ops = &hexagon_tcg_ops;
+#endif
 }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


