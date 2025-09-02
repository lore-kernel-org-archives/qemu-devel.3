Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22723CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI1f-0003p2-L1; Mon, 01 Sep 2025 23:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1Z-0003F5-D2
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI1W-0004e9-2k
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822Rnt1029660
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YhiyH7LtIZAoSlZcRmHhacqLQoFuco/McjDzMQWZOHs=; b=NqbMyu/WYXbkP5d2
 djWOVjbu+gLCXvqAwckd8WvD10B+cSfO7v0DZZmjYKJttY/e8iNrAPf0Ih+DvLbJ
 l9JZwU3qlmFBXzCZVdY8zkMzTEELKZ1w18ixfsl78RXIL/WqXCyixMvwv7C2ff9e
 KzG4LUirvomZ5wBnOXj92FUDoDr6wdmJek7bpNGepeLAOwVfya02AlLuEj1fKCs4
 7SakPgIdjaWjI1FbKmUtsiyDgjfkoH1JhymumJ+/O7d3avfhwLLFkheWqj5LRzuU
 HJOI1f5oJ+KgW5dWwh3bWVErdEKt7ORtHfQcXk5SkwmunL8z9uPbOwq5HGT1dL2P
 MFVuDg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura8pc3j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:49:22 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-32993d924ddso2353192a91.2
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784961; x=1757389761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YhiyH7LtIZAoSlZcRmHhacqLQoFuco/McjDzMQWZOHs=;
 b=XsDzcKhg5cdjW4drH7+ho6GD9Dd8vUVgsX1HxjRXS6RXHAt/BpLcLkjWscKIKvvSBj
 4OSle6jtQLAjtItLDWy6M2o3uRd3e3QueBzlxqfIARmTsLJeByPEp7/dEPB+DRaf+J/S
 k3xSKhYlHz8Z5w3aLQ/FP/Yz9UILlB/+6HnOQ9Acn6SmaEv3RM90F3MmSiKzUFug2qI4
 /NPhlRB45CwRbLLALRr1JDsA5VkUg8alaieY9Gn3B/wFMuM+vjs8PTrJclZkB4B49CYB
 A+ea0oVlCG+XeqWvtJ0W5OXMxa1QAxIAcrSuVBPsUvCOJCnzTD53chg1bsM7rzlZKRcr
 y9HQ==
X-Gm-Message-State: AOJu0Yxvz2/7oxNE5pSN4Fot1z+kelGBLB2Jb0wBIY+Rha9ZFlnAfLHP
 gGPPQPdhBKSj0RNioYSoFgAmJJKnjdLZxszxUQyLo9T4hRFpr1nDfCSl49X/tNr0ZH/U+rcW7mU
 Hq+0QmYUtjTqpfxpgwcn9FRyACwneE/y1v7XNcTppBzNjzLfcGeJiI6h3Mrl6WcDtdb1S
X-Gm-Gg: ASbGncvamN5b7NL1e22M1RbHQOQR5G3FR+DOE3JI8+XslPSeu6UOtPa2Mrw7Bjoi59H
 xBlsI0iDFpPp+ASoWufVTECSRUF/vTMXht8EJSNIL+P5mbVZfpUR8XJ++7QXPjr6OynGNZMTJPc
 Z71Uk9QkMJJmlsyy37VJOWRluIkmZFHB3ghridy4++gllS92tECASo3pF+nfzyWDHv6h/EzWjCw
 TMyt7IGtWJnhkpuQoqLNXzMyWlGDCzUKCyLDqfzd8KEO2uayrhTuIOA0ZgSmD+mTfawzK1ZeP49
 ik7izkdWsdT0gj7/Fr79bqIcjP7YRCuZk2yhpop5Qf8u+lV87CffbFF63hMdb6GyjUidCmpumt8
 /+VIZXOSoVpJG
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-32815412c9emr13486886a91.3.1756784961416; 
 Mon, 01 Sep 2025 20:49:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMlEVtV4P6Hw/Zn8viSR0QAHjCb1PKOLhFB7HQSC+dXzM2lnmW6npv+Ug6OJiffcbPuWNedw==
X-Received: by 2002:a17:90b:2751:b0:312:e731:5a66 with SMTP id
 98e67ed59e1d1-32815412c9emr13486859a91.3.1756784960992; 
 Mon, 01 Sep 2025 20:49:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:49:20 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 24/39] target/hexagon: Add exec-start-addr prop
Date: Mon,  1 Sep 2025 20:48:32 -0700
Message-Id: <20250902034847.1948010-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: dV8_Ev-qFf6JVFMEbrbb8QTp5QSyswSd
X-Proofpoint-GUID: dV8_Ev-qFf6JVFMEbrbb8QTp5QSyswSd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX/ZciRKQrd6Pm
 zwhJ8YHAhl/9k0DLU3BK9pO9TMHjK5tA83yJoEg0hUcCyNGjj4a6bYgYwKT/pgyVtXa+7k6ecxB
 fSskcyiv0PJnI3ttxc7LONPSI8lnZnNlnHRy/49pSPpR1+M+GKWvdwc2eroi0NBdcr/cKCl0s7L
 zau8araHh7+y5nZ9uoIglCrktA5V8d/+zaqRNuLdoDSBgqUa7UOOyKbyRb9ClhvUs/QbPwYojbv
 OWCkNerVykxEs2l9LwOI6LcQso5Xfrv4KwUH23NecC9IFYe1fyjbY7iW8cNicYXUmhoIezhZPdY
 W80BLapaAcp0KhKxtdk3QIFr7TtxKMqk5JDpKxkbDsGiesZqB6D3WS1zYX/0pdjy55PhuE4MhSu
 PicDCD8r
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68b66942 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=GeXnehyCMtKHti5O41QA:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020
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
 target/hexagon/cpu.h | 1 +
 target/hexagon/cpu.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 92b32f434b..39d6983263 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -196,6 +196,7 @@ struct ArchCPU {
 #ifndef CONFIG_USER_ONLY
     uint32_t num_tlbs;
     uint32_t l2vic_base_addr;
+    uint32_t boot_addr;
 #endif
 };
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 2af0b4089e..8afa7e55e6 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -69,6 +69,7 @@ static const Property hexagon_cpu_properties[] = {
     DEFINE_PROP_UINT32("jtlb-entries", HexagonCPU, num_tlbs, MAX_TLB_ENTRIES),
     DEFINE_PROP_UINT32("l2vic-base-addr", HexagonCPU, l2vic_base_addr,
         0xffffffffULL),
+    DEFINE_PROP_UINT32("exec-start-addr", HexagonCPU, boot_addr, 0xffffffffULL),
 #endif
     DEFINE_PROP_BOOL("lldb-compat", HexagonCPU, lldb_compat, false),
     DEFINE_PROP_UNSIGNED("lldb-stack-adjust", HexagonCPU, lldb_stack_adjust, 0,
@@ -409,6 +410,7 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     env->next_PC = 0;
     env->wait_next_pc = 0;
     env->cause_code = HEX_EVENT_NONE;
+    arch_set_thread_reg(env, HEX_REG_PC, cpu->boot_addr);
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
-- 
2.34.1


