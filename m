Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFAACA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 03:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0S-0007Hl-0Z; Mon, 01 Sep 2025 23:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0G-000747-W7
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:19 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0E-0004Wl-Ss
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RlRY012433
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0za7H/WAT38BdhgBEdAEcqbGS+rJZjbMl0OOHX3z0T0=; b=lRZHT7/aspEYj+6e
 d1ccHiKmQB9ufTRbUXuqih2D0Yj6DDKaC74Vqr9RhKMZNQI2tNRKEen//+1ydZAg
 dzzshUjRqe2AMpTymVpQHDQ4AWKWGbewsDr5ID4F0p5ngn5XExTr8XFktGwIs3xG
 IzIt51bZzH94uSZslOjG1CpxCYk4bkiAIQv2B/80Xk+U+1nW+UrZTE1pCxydvblc
 TmLvLjyVFTXYW2BJfGAR+oEuDJxjRytpkaWfPWNoIXAZ7zrszWp00hvIbT0zq3XU
 vjNPvtGCjLd5jAKRs3Xc9qZzsz4f1DA7vrZJoC3hFUjHudkecVdNhn7mT3tmt387
 cRd6Eg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uq0eej62-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:03 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-329dbf4476cso424361a91.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784882; x=1757389682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0za7H/WAT38BdhgBEdAEcqbGS+rJZjbMl0OOHX3z0T0=;
 b=h9wtq4cPDO+P5z/olfds+/lH2i+lWYlLZ/N8w3mE7KnJ1l6Cn5WWzAJYy8lfQG6t3s
 Gz6g8GFQ0TpP5MtHbaAa1RGJFl9oupQocH3SgANrrhtvnF+RhzApMcHReS3STv5Dwb2J
 w7IiAMdixAt8/x6LHZUh2Joj0BEtJ4XDs/vyGCxeSQpx7cDzle7PIqGZm+BDiafe/rV8
 MQBGtJGj2qp+OELbl3l8WfBtAMsg53u25GYBaqURUSvTCSp3D171+xj79jQmQx8bQSIC
 N//pYcNbdQLvgJzdaIQ2yur1sGO2isskDNKsqYEvoEV3krNjeZR52GqQkLY0KDfT56Bg
 tzgw==
X-Gm-Message-State: AOJu0YxTvClCUZ3mFGXIfX4Agp5VioCjezTSbKlGRHeGO2HlUqk5xK1V
 poeoSZb/n0TuYLRbxrCbii0P25kxvCVkN50SeY5+ZXP6fTIv+udbwYo22m43hKa0rNfHwr99+EK
 ECMrtT96hy9LtBVDe+a7MFbIg8jPqsPPJmVrcgOyKbt3i3VYCGDMjB8totNUvgzd6PHzN
X-Gm-Gg: ASbGncs2HDnZzWZ5kRpzZG6KgfOiSC6RhAe/MSQSBLOs/CvnFjyeNKHOw2D8fB9ZYQQ
 14oYd4ISa61MPmzGlj46BB5oGA7ia5qXPVVOjuieYbxV8WppdZpZ/mPCnIIfDBD19xQEj7V2xP+
 TCF2ihd+2a9MU6OIS6HMP/j+S+5d0BOgQEYfV29Rqtub+lUS3cJVKaStTLqPMiodqAvP8yQ5taa
 33jt3C3PwpTJYkwlTfNYxkVTEyQ6ad/bkHUd633imUeHqznj/NSH/kYeqT8L3O8hvU15/WWvpqB
 9pMqQnY006bH7j5k8CPWPOcp6xnvtU/ke+d+J4Iq42M6p65JiMxUUVVAaWlrw1dkDkB+aMIHinJ
 PFdQmBbYG9tua
X-Received: by 2002:a17:90b:394a:b0:327:ae00:5c00 with SMTP id
 98e67ed59e1d1-32815412bcfmr11041418a91.1.1756784882298; 
 Mon, 01 Sep 2025 20:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwvGgsgB2Gk4otIp7RHd8I8hmRiCFTHLcBQaggjZYe7VE+Gthp9QjVstV0Zd/mPAQcMXRag==
X-Received: by 2002:a17:90b:394a:b0:327:ae00:5c00 with SMTP id
 98e67ed59e1d1-32815412bcfmr11041389a91.1.1756784881869; 
 Mon, 01 Sep 2025 20:48:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.48.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:01 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 34/40] target/hexagon: Add {TLB, k0}lock, cause code,
 wait_next_pc
Date: Mon,  1 Sep 2025 20:47:09 -0700
Message-Id: <20250902034715.1947718-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FGfWxTkdc12JKr3r5oyIzSj2sMhYvzJS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwNCBTYWx0ZWRfX3P0/TCJxu3Jo
 VGYZU0OmbI7rnY/TXt4mgZP8l8v7qnRWXackR1IQgSGKtiNhmhFCwh39bbAdVyBVn/Gn7e/bj9k
 1aI8oR7rUC90RlGKa185pMDndDh3Yf3coeuN7nMP7bCnTQ4awKYZJpjq9WADdji8la9xcOJpw6M
 nwKxmv36nhFhhw+y8L2qzNuYwdl9Dq8jopU6G6wqzbygUxD+B6Bb4A9xrKQbY/5dGB6mMr4UELl
 BsH0B/wKewEhgCAiZAK5kHOuT2fEyJNFDRDEt+hdF8MqHXx5nq6l50bJpOtsbgQ/wsIvxJY1w1l
 KmmU5dvIYXWRtDrBJ9lI10Z2U37Hy/Ry/SlAOjbeoJoIUCS/lXVl77UGZaBfJ99jA9CSXkPqJTN
 Mgh8XQHn
X-Proofpoint-ORIG-GUID: FGfWxTkdc12JKr3r5oyIzSj2sMhYvzJS
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=68b668f3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=u-CS0nqVCHpLmCmQHcYA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300004
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Reply-to:  Brian Cain <brian.cain@oss.qualcomm.com>
From:  Brian Cain via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

{TLB,k0}lock counts are used to represent the TLB, k0 locks among
hardware threads.

wait_next_pc represents the program counter to set when resuming from
a wait-for-interrupts state.

cause_code contains the precise exception cause.This will be used by
subsequent commits.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/cpu.h     | 3 +++
 target/hexagon/cpu.c     | 4 ++++
 target/hexagon/machine.c | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
index 8b1ff23c01..6b49912c08 100644
--- a/target/hexagon/cpu.h
+++ b/target/hexagon/cpu.h
@@ -130,11 +130,14 @@ typedef struct CPUArchState {
     target_ulong t_sreg[NUM_SREGS];
 
     target_ulong greg[NUM_GREGS];
+    target_ulong wait_next_pc;
 
     /* This alias of CPUState.cpu_index is used by imported sources: */
     target_ulong threadId;
     hex_lock_state_t tlb_lock_state;
     hex_lock_state_t k0_lock_state;
+    target_ulong tlb_lock_count;
+    target_ulong k0_lock_count;
 #endif
     target_ulong next_PC;
     target_ulong new_value_usr;
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 56098b4c55..43fd13cd0d 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -307,7 +307,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
     env->threadId = cs->cpu_index;
     env->tlb_lock_state = HEX_LOCK_UNLOCKED;
     env->k0_lock_state = HEX_LOCK_UNLOCKED;
+    env->tlb_lock_count = 0;
+    env->k0_lock_count = 0;
     env->next_PC = 0;
+    env->wait_next_pc = 0;
+    env->cause_code = HEX_EVENT_NONE;
 #endif
     env->cause_code = HEX_EVENT_NONE;
 }
diff --git a/target/hexagon/machine.c b/target/hexagon/machine.c
index 18c3f87188..10e0fe9688 100644
--- a/target/hexagon/machine.c
+++ b/target/hexagon/machine.c
@@ -22,7 +22,11 @@ const VMStateDescription vmstate_hexagon_cpu = {
         VMSTATE_UINTTL(env.next_PC, HexagonCPU),
         VMSTATE_UINTTL(env.tlb_lock_state, HexagonCPU),
         VMSTATE_UINTTL(env.k0_lock_state, HexagonCPU),
+        VMSTATE_UINTTL(env.tlb_lock_count, HexagonCPU),
+        VMSTATE_UINTTL(env.k0_lock_count, HexagonCPU),
         VMSTATE_UINTTL(env.threadId, HexagonCPU),
+        VMSTATE_UINTTL(env.cause_code, HexagonCPU),
+        VMSTATE_UINTTL(env.wait_next_pc, HexagonCPU),
         VMSTATE_END_OF_LIST()
     },
 };
-- 
2.34.1


