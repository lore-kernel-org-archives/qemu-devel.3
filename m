Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0FDDCA100B
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 04:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utI0M-00078N-Kn; Mon, 01 Sep 2025 23:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI05-0006tE-0e
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:05 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1utI03-0004VD-GX
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 23:48:04 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822S6b7030132
 for <qemu-devel@nongnu.org>; Tue, 2 Sep 2025 03:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tNnBEADDordAOyy5MB6vN+nl6oXmjSBG+FKcxUPzNJY=; b=NRVrb7nPFwSQO8Sl
 u/HL2Unpxi2S/ZKRpq7Rzvi84E2/VQUW9jtd3oYIHRU412W1ShTX+GY4onXYhQdt
 0ZZ05Hzv6y+NokB3PLN7vCdwy48xclG8bL0bWBXPG9rw0edL1tNhUPmxSfJnd0Tp
 tZsrcOpyyzcj9xQmTj/14k5Zu5TBrD19Ba1Eyo85pZ4wC6a41Gf8aIeXY5+hEk9f
 yMPgdtfFN7mkV9A3AvPKuHGhgqCxdsCAWevxUPV4RJA0Oy7mLd0utTksQi0Hc3+6
 BPMOSuRHJhI/h9s8Poym4Q0/TXi6+cJ24wVOCNzT++zCpncMNBtGZ7qKB70TrOCa
 51suMA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48w8wy26pm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 03:47:52 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2445805d386so53770615ad.1
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 20:47:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756784871; x=1757389671;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tNnBEADDordAOyy5MB6vN+nl6oXmjSBG+FKcxUPzNJY=;
 b=IR/1Tp7tjATidACJMQ6H9+Nd2JkV7yss+rJFnQ1h8uF2S3GBLCtwr7Vm2RaXJFvJa7
 Wnl72GKc0GXAacsRpwq82eoNzgnVx5M3bG+ZlRzQZk3Uu8GPrCfokSJ7mIOfx1bzJAnz
 yhe4Q65jaBmXC4dLlk1AfJm6PoFIjzTFa/MOodSq1jw8Er68Vm0EQLZbLPl8mi2WCr24
 iMwxuWxmQXzS7zlux8nl1yibQQ8cHA4c2vwvbZUUd8fQHpnyoDqvG7KSJu8ugxO/VLB/
 zZ+ZIQ2UTLpkkvpGWc+riC3MXcQdk/9rbmr+4Lb4as4mQVxIw/gbQCcTCUVBflDdqjrP
 dNMg==
X-Gm-Message-State: AOJu0YzGaNslIxTGW3MMs9kt7y2nnQ/9LvynCpQvIg+7gnseHHN9fY7d
 J18pkiUEAD3aSwS/hG7I4Dfi+Sklfgn+D5xXXNg3HX/VV5xGarmnneat9IgQ+CFkKt0MlNjg9K2
 RBWo6B29U2QfXvCtCpnRwkkS4M7+ciWIN7gplKqoJNMvbcWGvXzqaRDP290g+YyYlN4Nw
X-Gm-Gg: ASbGncu81w8x5wKZQtnA7cToxaWOJBcVeV4y2aHcZcBhWStkHWuAHLyOnpC+EgFUcSZ
 ofi0nvaKn/xYEeCL7S3o3/0cfROtQCQdWclUddhJCX0l1TScxWJPC0Q84RNoZ87dLm+SeAkruzR
 mIr7U7FmY5nr2yDDPpsomTUtZnsABOAShReH6KAj6spX+6IpYwJKHu9T7hIFtNbp2CJEY8pMt0G
 8QPHvtZQSqgM++//HQ8pLkQVq6jfU0ND5A7p4capCEPgzveOagFN2zCFaSVqbnOOF44jZjuWUKK
 dOyvnagtZkxPK3M80OqkVQ/6bZxME6SCbY3TDNPsWrh8G9pht79OYRED0s5de/NkWtxVPnoFCRw
 7B5aBPpAFxSbH
X-Received: by 2002:a05:6a20:1584:b0:243:c2d8:a06c with SMTP id
 adf61e73a8af0-243d6e00d61mr13017727637.13.1756784870894; 
 Mon, 01 Sep 2025 20:47:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsmb258MGnROlRy398pttq87bKhKwMn5oc4AuQxDScDEart45d7OkuZoZKOhM1DhCo+LQSeA==
X-Received: by 2002:a05:6a20:1584:b0:243:c2d8:a06c with SMTP id
 adf61e73a8af0-243d6e00d61mr13017686637.13.1756784870394; 
 Mon, 01 Sep 2025 20:47:50 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4cd006e2c6sm10633584a12.2.2025.09.01.20.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 20:47:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, richard.henderson@linaro.org,
 philmd@linaro.org, matheus.bernardino@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com,
 sid.manning@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v2 24/40] target/hexagon: Implement do_raise_exception()
Date: Mon,  1 Sep 2025 20:46:59 -0700
Message-Id: <20250902034715.1947718-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
References: <20250902034715.1947718-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ycq95xRf c=1 sm=1 tr=0 ts=68b668e8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: f-RQ6F4669dkFtGWT7dxgWk8tzPLsacf
X-Proofpoint-ORIG-GUID: f-RQ6F4669dkFtGWT7dxgWk8tzPLsacf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAxMDEwMSBTYWx0ZWRfX+3VImTDwV9DR
 eBVGPUKGNUbdIVfxcvvKZuI7KwUKk32AifUHiKO4NUc+GyRnNtbm+eJhTVJxT/zAufiGpEvq1sq
 ngmgDEhsExvXCONcAllVKKFf6xsUcI1fkkTWukbriHVCjlUI3lJ3oRHk8UaM8T1DFGtAv6iwoDj
 Eio+WJTE8JSfmxFzG6Yzz+AiVDVjJE37WRJMEkQ7lMQD7eEHzV+V7LgCtzn76Gu9+c5UU32DUIw
 dlUdP6I/skSXS0S/wdFSdxQSfktZvWjtQV5ZCOWrZyVQPJHN+gIy4p0SRVXJ9IshROcWRtcOVY9
 CXV20sKRefgCwkh1oWK/yD+0quRWWGbYPLWde3rSXgonPPTiq4Hzbq+AacxXFf6zvBbk7p35vrp
 QCMDFkLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509010101
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
 target/hexagon/internal.h  |  5 +++++
 target/hexagon/op_helper.c | 20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/target/hexagon/internal.h b/target/hexagon/internal.h
index 9658141316..7cf7bcaa6c 100644
--- a/target/hexagon/internal.h
+++ b/target/hexagon/internal.h
@@ -31,6 +31,11 @@ void hexagon_debug(CPUHexagonState *env);
 
 extern const char * const hexagon_regnames[TOTAL_PER_THREAD_REGS];
 
+void G_NORETURN do_raise_exception(CPUHexagonState *env,
+        uint32_t exception,
+        target_ulong PC,
+        uintptr_t retaddr);
+
 #ifndef CONFIG_USER_ONLY
 extern const VMStateDescription vmstate_hexagon_cpu;
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index 72bb75a878..cbbf3048a0 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -37,6 +37,26 @@
 #define SF_MANTBITS    23
 
 /* Exceptions processing helpers */
+G_NORETURN
+void do_raise_exception(CPUHexagonState *env, uint32_t exception,
+                        target_ulong PC, uintptr_t retaddr)
+{
+    CPUState *cs = env_cpu(env);
+#ifdef CONFIG_USER_ONLY
+    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x\n", __func__, exception);
+#else
+    qemu_log_mask(CPU_LOG_INT, "%s: 0x%08x, @ %08" PRIx32 "\n",
+                  __func__, exception, PC);
+
+    ASSERT_DIRECT_TO_GUEST_UNSET(env, exception);
+#endif
+
+    env->gpr[HEX_REG_PC] = PC;
+    cs->exception_index = exception;
+    cpu_loop_exit_restore(cs, retaddr);
+    cs->halted = false;
+}
+
 G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
                                             uint32_t exception,
                                             uintptr_t pc)
-- 
2.34.1


