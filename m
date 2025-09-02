Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 694C3CA1007
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI17-0000xZ-LW; Mon, 01 Sep 2025 23:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI14-0000o1-8A
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI0y-0004al-8D
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:49:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S2eE013176
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:48:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J2HZ4hnhlGo7Etuz7B5v9s/d3XbnS//HppLLunMqdIU=; b=i71ImfDE6Qrd/JuU
 DkUs1/F6Cg3Z+K+M7AsW9BX/bQAhlsZ9qQT992/F6e0KHI7QTLhIZonfFdAMVG51
 yOzlKe08eFbqq52BcVwnG8PiJtJLnvTpogluk4Pd9p4mMB6ICeaHHr5B5um7p1v4
 N3O5yVt+KiX6fWLQHuPTz1/GIVx+llm1Zob7EWNbb4DIR5qdZ7JNEpTz+Z4bMNRI
 JGn3+0zCqUtjkU/tFIgIf9ojKmCMvPmzGiwt+NMW4BabxgrHCtOnp8udpA2JOCWq
 wPqcNHsEEHV3Bnyc97acK+CxxvcsfQp4T5vVN6bmhPdTuD2Y2cwQWHKY9PG+4ehy
 N4zwrg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ut2fea49-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:48:57 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-77243618babso2333998b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784936; x=1757389736;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2HZ4hnhlGo7Etuz7B5v9s/d3XbnS//HppLLunMqdIU=;
 b=olKM7Kqbm2k54rF/DqrcgCKsZVTZJmeTx3EDZqwgc2meoiNfYzKE9PFP8ktZ0VW4IS
 ZmG0k986ZEHb/5q9E34CIgXIFPbqWheyzymD09tLbfoBjPmSuQ71qhkZU19+Dfq7Q5rE
 ZtqjWy+M9fO2B+Fkl9o611QgaNSpbOM3OWf71HatO2YxM34elHC1ZUyqDLSHxxzHYfAK
 fzCEGU1kb0HRrybhIj/70/0vWAOZJU/t0Y3UBwLfBhxSrEZeQRvvI/UZ5D1SGN4Bn2Sl
 8d9Yml1t7C7oVyPmOZUBj3rjaSCKgg1PtsIQ62dQWnEJgvsiiXnQR98HGnOMgDvEAVB9
 UBNA==
X-Gm-Message-State: AOJu0YyKI211cVAviZ1PV3S7EkzuwukeY/2U6JQj4TShbvdKLo/De2vv
 z+EAOa+vWZJiNazbVB/9O9b+RrH1HRkvKweecU5KW/hN+H2md7uF3lzS7Wl0bRf9Ugqrvhl/QqV
 rozjyf/zLB9oF3YcJwzzAK1q5SL2QpLSD0tawaiKuFb6VXE05XhruOrH99CaIxjWpjSVl
X-Gm-Gg: ASbGncuqoqvhTz0QTZUSBv9oeZKSpHueF0vHpwP+NZObbR6Z1Z8R+Lh9R7MrCyiWYQ/
 u7T1/uvTuD+w2L9xaYffBsWlsxnRIxCUrGrbZ9g9SP1FLxsnOZKv/lOaAjnP9dytLl76TaITjWP
 FNfToriK2eaFhXZi5fiLjA9lMRxlUnd1jS0gPDr1pnk+4ybblUE9ZBLoAO0ljE7rErue91YJpff
 CK5MZq+Ao9mOXkhg5yXJ+AJswaJljfo6XQvgLIPs2uecerTHw+fzv6QTGhndxxDQ7ZuOIxfPNkh
 tXjOAZ3uk1Sml8Sm8fzaJgteniNYx9ew6R9dl0Pc32AfORBwOnHKQnpq7DrdEzol13hR1OEa7B4
 g9nqGGLlqvQe4
X-Received: by 2002:a05:6a21:6d8a:b0:243:9b05:aca7 with SMTP id
 adf61e73a8af0-243d6e00a9emr13338963637.19.1756784936409; 
 Mon, 01 Sep 2025 20:48:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOT6lpvo9wxqNjhcjnEK2slmhggxUZGgAm8C/8dgmBaZUfLkvpv9B3qY0oosux6Bqu4p0Sig==
X-Received: by 2002:a05:6a21:6d8a:b0:243:9b05:aca7 with SMTP id
 adf61e73a8af0-243d6e00a9emr13338941637.19.1756784935982; 
 Mon, 01 Sep 2025 20:48:55 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327daeeca1csm12543546a91.25.2025.09.01.20.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:48:55 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 03/39] target/hexagon: Implement iassign{r,w} helpers
Date: Mon,  1 Sep 2025 20:48:11 -0700
Message-Id: <20250902034847.1948010-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
References: <20250902034847.1948010-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzOCBTYWx0ZWRfX7cmjKHmvicla
 yrBBmxrhGdNh7zFXNYKpHOCq+jhyxh7ApDcKPSLzDnx2bEkJCPzv97uXMU1blt707vyaleZ2BSZ
 E855pSYSdiwmE9tyhGCqUdrWL4I0zVQwe90b9toXl5z1Uo/sUeVwFb4tO/7CqGvegCfyhNscEOB
 lbX8jvQPpyUA+A1NogoD+Two33NpIt7SYfuRB7XvbndcSfaHySsoY/LczC15buZQWz5ozlKPKL5
 D24PT72ulJV+PQy5hMjJ6sbgUmxJKGoyI0hgrBldseo1dx7KXOZuKV343xVaR2UBqIZY8EqTiHL
 KFVAH/Y/F/v+7Xi9NP7pTKGqrczWnh/iYgSI6gB8wuAD+mncoKoHzSl1fmLENRxKBNHMVswYmUl
 +fD6biR5
X-Proofpoint-ORIG-GUID: h_sPGAe9qv3Ok8rcPgpaEEOWn1oBtpf9
X-Proofpoint-GUID: h_sPGAe9qv3Ok8rcPgpaEEOWn1oBtpf9
X-Authority-Analysis: v=2.4 cv=U7iSDfru c=1 sm=1 tr=0 ts=68b66929 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=bRQZT2Nycl1zLt5I3jsA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300038
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Brian Cain <bcain@quicinc.com>

iassign{r,w} are the "Interrupt to thread assignment {read,write}"
instructions.


Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 target/hexagon/op_helper.c | 48 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 875935b903..74f8c1bf4f 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -1401,12 +1401,56 @@ void HELPER(cswi)(CPUHexagonState *env, uint32_t mask)
 
 void HELPER(iassignw)(CPUHexagonState *env, uint32_t src)
 {
-    g_assert_not_reached();
+    uint32_t modectl;
+    uint32_t thread_enabled_mask;
+    CPUState *cpu;
+
+    BQL_LOCK_GUARD();
+    modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+
+    CPU_FOREACH(cpu) {
+        CPUHexagonState *thread_env = &(HEXAGON_CPU(cpu)->env);
+        uint32_t thread_id_mask = 0x1 << thread_env->threadId;
+        if (thread_enabled_mask & thread_id_mask) {
+            uint32_t imask = arch_get_system_reg(thread_env, HEX_SREG_IMASK);
+            uint32_t intbitpos = (src >> 16) & 0xF;
+            uint32_t val = (src >> thread_env->threadId) & 0x1;
+            imask = deposit32(imask, intbitpos, 1, val);
+            arch_set_system_reg(thread_env, HEX_SREG_IMASK, imask);
+
+            qemu_log_mask(CPU_LOG_INT, "%s: thread " TARGET_FMT_ld
+               ", new imask 0x%" PRIx32 "\n", __func__,
+               thread_env->threadId, imask);
+        }
+    }
+    hex_interrupt_update(env);
 }
 
 uint32_t HELPER(iassignr)(CPUHexagonState *env, uint32_t src)
 {
-    g_assert_not_reached();
+    uint32_t modectl;
+    uint32_t thread_enabled_mask;
+    uint32_t intbitpos;
+    uint32_t dest_reg;
+    CPUState *cpu;
+
+    BQL_LOCK_GUARD();
+    modectl = arch_get_system_reg(env, HEX_SREG_MODECTL);
+    thread_enabled_mask = GET_FIELD(MODECTL_E, modectl);
+    /* src fields are in same position as modectl, but mean different things */
+    intbitpos = GET_FIELD(MODECTL_W, src);
+    dest_reg = 0;
+    CPU_FOREACH(cpu) {
+        CPUHexagonState *thread_env = &(HEXAGON_CPU(cpu)->env);
+        uint32_t thread_id_mask = 0x1 << thread_env->threadId;
+        if (thread_enabled_mask & thread_id_mask) {
+            uint32_t imask = arch_get_system_reg(thread_env, HEX_SREG_IMASK);
+            dest_reg |= ((imask >> intbitpos) & 0x1) << thread_env->threadId;
+        }
+    }
+
+    return dest_reg;
 }
 
 void HELPER(start)(CPUHexagonState *env, uint32_t imask)
-- 
2.34.1


