Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 254EEC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 01:10:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjRf1-0000XF-Fm; Mon, 13 Jul 2026 21:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjRex-0000P8-Gz
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wjReu-0003k3-V8
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 21:10:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DNmkd83121245
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 evXUyChMcSwZe2zKBJ0MiCF+w52F7L/7q9AWZm+IPtU=; b=AULaNdhAkO44zmic
 BTgx+fBuGdpc1vmM6X3LO01NgzxV4AQrJWvAFsfXzoSIE/FcFq8kQ5TfKeYHDicx
 ecjOah8WpPRfqKwNQmA913IJigma7kP95sn4CllI+xZQjvHCOJlX8flP8k6+pvkL
 qbkcpa5qpTBXoZEmZzexVis8uLoc6nYxbwmd6LrE2LE01uoCWNc61SJtt1Au4uX/
 iIE8HAbKvqJRmYlDjpMLnDNoDDUUZlYTQPw6kc+R9hmkCMVUYhEhFeRA8wEwzD1O
 TuMoYbck86fJ8qdAApenVwxaRDrC8foxYcoRGhi7ma6h9Ej9/qVh6HS+gl+SfSMv
 G3zzjw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44csc2p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 01:10:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c88fc985a65so4762084a12.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 18:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783991403; x=1784596203; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=evXUyChMcSwZe2zKBJ0MiCF+w52F7L/7q9AWZm+IPtU=;
 b=QXTH0GHipVpMGgqw4yWwDiYHT1PuGOXR2izv1jJgyFrzOYz989Xw/JujQIuSLU6fPd
 Vj9tK1P/NVyyoUT7lG/oMSgXmcJ4MbGgwQfexUt1PCcLRCuEhfAAswd5SDMxFluk2qSc
 Ot0x1SHvEan/pStUMOXKy77Rgr64AezM2QOEECkVhRnogf8OXtK+a7pnUlCCzf9TXL5p
 bhfn5DU+KCnOk2lHnxtE4mqc5G+VmkhE/m70CoNQ29tlkpop2wXk8+rP4KuGnKs/wYA3
 Mw5JUH1AQptiBPjvWaHg2dGaBbUa4EZoVMmFqkViEbAguNSA9rnyHmmmlmd9Y/dFl0nX
 kUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783991403; x=1784596203;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=evXUyChMcSwZe2zKBJ0MiCF+w52F7L/7q9AWZm+IPtU=;
 b=qa+xSRnMi821bEKethJHN02d2JpCMFWgLqIUC0r4n1s2EuTe2jcg5eewu25WeZkj2E
 P+pbBDWiHq2p9TGGt3ZgjlkHQrHbfZZFLAOqCt/QVQbYQjdtVFSausNbQ6sCc3XcLkor
 gzpjyUs6jo3HWd3m/nwxwgDKOeXhZ5dqmWVMy6W0GcPp2oYNZ1WixA66B93EPHJ43n/n
 n7uyUFFbhFo4EWiPSirQ4pbykwiV3ra68GQN7lAIPt6DVney+ULbxGc9hJxPOX2nCzpY
 odF8Gb6CNJffKrqzR5HC/cLqKFQ88VD2rxEA0TOzDl532ys+6wuCLw1bIUqynk96Mi22
 IDqg==
X-Gm-Message-State: AOJu0YzRh87T8OWlqTgqjrzW4/Hjy4aMNq/lJdqUAlrzmf8IHmOJEaTt
 s1ZJm5/EeFqQBMtNhupiBzik2CgKYOVMR7DmvggPaMHY/0YPXGqByVtAU8dz56zHxtAHkTt7l/e
 6QxA1f6OeqAyVeQzaCXxt9r7ZF0ZA8U8R1kGYDMsQp9Qism6jcpM406k5JsbQjInLkA==
X-Gm-Gg: AfdE7ckEsUebxovpWJ6iaFgbyK0IlZrFj2/qjMrlL9ZNVgJkm+gqaxfwRI8NvouUHBp
 vie/96cMvAAs9poFhMcxVUYrAeTqC4s7iCX8m0pz9Eg1xjjzbMMUJY1vxwUw5EVt44j4YIokuj4
 Y0z833b+4GG8uALSF3TOsjn3Tc2VSFkc8SSB4/2j4NVLNpOgt/4Hj7D4cI2YjhjsU5tlHGZ7AhK
 gH32jhOpEcxMtgdUKPCI1VW4yLak0OpEPTvAV0weqq9Plz8ERSVdXaINbUa31+RGkCjwEVmm019
 j6etq3qQeopFQSB2C8aT2KZqOXvVbCB4bdAULvoOd9kdm4z4Ij342qcmkBq7s76KI8ViqSpaJot
 JEKvydBmkwr9zZeac/ZUqu2XH2xFQ0LvFNKiJXqZnLFcHVpBg0R5JI0q6Z/E=
X-Received: by 2002:a05:6a20:6f96:b0:3b4:7b2a:6a0a with SMTP id
 adf61e73a8af0-3c1108982a6mr11468554637.35.1783991402849; 
 Mon, 13 Jul 2026 18:10:02 -0700 (PDT)
X-Received: by 2002:a05:6a20:6f96:b0:3b4:7b2a:6a0a with SMTP id
 adf61e73a8af0-3c1108982a6mr11468521637.35.1783991402402; 
 Mon, 13 Jul 2026 18:10:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174accb0esm76826246eec.30.2026.07.13.18.10.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 18:10:01 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com, Alessandro Di Federico <ale@rev.ng>, 
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Laurent Vivier <laurent@vivier.eu>, philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH v2 4/5] target/hexagon: raise SIGBUS on unaligned data access
 in sysemu
Date: Mon, 13 Jul 2026 18:09:54 -0700
Message-Id: <20260714010955.2226493-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
References: <20260714010955.2226493-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 2ivOrHuoz8KfKxaZ6BkpUPFuYHwD6nW4
X-Proofpoint-ORIG-GUID: 2ivOrHuoz8KfKxaZ6BkpUPFuYHwD6nW4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfXx5VxOD87Vwls
 SHMZksSk+oyeNaSdqKaCBdMlSE423M61C7xZ89mE2tYmmfq7ZpSHrWHCXSJ1JoMsVIZvK53++87
 cxA/D4/uiMLdoRmvWy9+RM9SY34k5dk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAwOSBTYWx0ZWRfX1nO6JLbIrMvd
 xV5+0i/bJ6j3bO/vEJeuhh0UngOMs8HCNp0Ds3SR4PfcAWhlwFWr016MkqqEIdmc6evlYovdMPR
 la7oQZkayB/4hZ6EBc4Wp0gr66QU6G2tpdKI5LFiELB1cGZVnAqDkQopjYj+kqEzC61BsAE7JJT
 7CwuMX5rk5ds3c+w+uPZjH3IaI3SpqGTjfJA1o8pm7MWaHDHK/h2t4k5P92jpyBHKvUXsDBF7Po
 AY5Vi7hNKCgSlfb7NITSQKGyAJSfdNBeqI480D20V7zfrlI46ogWYdaMUDdx+TH6OUEktaW3EtD
 ViQ6c7Pr1OJqe9A43SUkRvyjBTfh5a7T0CjCVZG9NPcdHtvbawoRDceJuoBMDXKBDaK5DWm8O/s
 yEZueKDUtfPByJh+anYqZ1reo59G8tceuHOL0Y8wIe6KDTLJdyhoMoRoh06K+zC7bXL4CXsufon
 0gQ9vybHIKiRhFXZbVw==
X-Authority-Analysis: v=2.4 cv=P84KQCAu c=1 sm=1 tr=0 ts=6a558c6b cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=QWbXAH-yNWLVfgUa_9MA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140009
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

hexagon-softmmu had no enforcement of alignment for scalar loads and
stores: the MO_ALIGN flag added by the previous two commits triggers
TLB_INVALID_MASK/alignment faults in cputlb.c, but Hexagon's
TCGCPUOps did not implement do_unaligned_access, so the fault was
never delivered to the guest.

Add hexagon_cpu_do_unaligned_access(), which raises
HEX_CAUSE_MISALIGNED_LOAD/_STORE via the existing HEX_EVENT_PRECISE
path, mirroring raise_tlbmiss_exception()/raise_perm_exception().

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 42d93e5da47..e2af736a99d 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -637,6 +637,18 @@ static void raise_perm_exception(CPUState *cs, uint32_t VA, int slot,
     cs->exception_index = excp;
 }
 
+static void raise_misaligned_exception(CPUState *cs, uint32_t VA, int slot,
+                                       MMUAccessType access_type)
+{
+    CPUHexagonState *env = cpu_env(cs);
+    int32_t excp = (access_type == MMU_DATA_STORE) ?
+                   HEX_CAUSE_MISALIGNED_STORE : HEX_CAUSE_MISALIGNED_LOAD;
+
+    set_badva_regs(env, VA, slot, access_type);
+    cs->exception_index = HEX_EVENT_PRECISE;
+    env->cause_code = excp;
+}
+
 static const char *access_type_names[] = { "MMU_DATA_LOAD ", "MMU_DATA_STORE",
                                            "MMU_INST_FETCH" };
 
@@ -715,6 +727,18 @@ static vaddr hexagon_pointer_wrap(CPUState *cs, int mmu_idx,
     return result;
 }
 
+static G_NORETURN
+void hexagon_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
+                                     MMUAccessType access_type, int mmu_idx,
+                                     uintptr_t retaddr)
+{
+    CPUHexagonState *env = cpu_env(cs);
+
+    raise_misaligned_exception(cs, addr, 0, access_type);
+    do_raise_exception(env, cs->exception_index, env->gpr[HEX_REG_PC],
+                       retaddr);
+}
+
 #endif
 
 static const TCGCPUOps hexagon_tcg_ops = {
@@ -732,6 +756,7 @@ static const TCGCPUOps hexagon_tcg_ops = {
     .pointer_wrap = hexagon_pointer_wrap,
     .cpu_exec_reset = cpu_reset,
     .tlb_fill = hexagon_tlb_fill,
+    .do_unaligned_access = hexagon_cpu_do_unaligned_access,
     .cpu_exec_halt = hexagon_cpu_has_work,
     .do_interrupt = hexagon_cpu_do_interrupt,
 #endif /* !CONFIG_USER_ONLY */
-- 
2.34.1


