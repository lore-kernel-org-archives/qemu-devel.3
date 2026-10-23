Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776E606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H34RchTZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gXngkYAT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHul-0004qy-44; Fri, 23 Oct 2026 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuU-0004Pt-HG
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:30 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuS-00025t-88
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:26 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5vmX4063370
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oEtO3TXJ7yS5COlFIX1s7AsquxuY7dAeP+Qpp0El5hs=; b=H34RchTZyju2tKeb
 A/1/EBmg8PWzTCtNVIone4dYhYtNCMp+TBZepj3g7rxoRqj17nlPARu5V1hXm7FP
 5bcK/WM+S406NNr1QBpgzAJFqs1zdrt23yQFXbnLmQMn2+44hbIObTbUNxhXBToX
 2IHpMABMt1zcm3sXWOGV9jzWhRRv0EJu7Sg2/sfZLdRQSol2PgFconq7B0vv6Upw
 rrn4o070RB5AHfKxlyGMmhaDtJSYNLiTM3tRP2NLX8d7Caa6N3DWy4GqDhMNgx7B
 7K7mL1BPbycUazm49m0Ur09JXCB7oPVk8q2XoT33KNr8anGoEYIi5aZZYj+TX6PV
 GW7yYQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgf6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:21 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f559420f3so107356885a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772060; x=1793376860; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oEtO3TXJ7yS5COlFIX1s7AsquxuY7dAeP+Qpp0El5hs=;
 b=gXngkYATzjUVXJRVuFsGhpul2MtKfRWOc42X3KDkKhQh7S+aUEa7b4kywwaq1JKNXw
 rzrm1zRvp4uIRFch9RDQd+aXVmBhfeEtun9ZwqtMKUf2tv5uVrDqdJcCG1Umv0nAzBDI
 aSXODYDpvAuPGkDSnIh+mGvkCVzok3dBdmmcFuah28rnBLO/KIld7zqzOXcrJaOxmEmO
 JdxtYAlv5iOPLna5UxwUziUKlTc20193eRdnT2RASGXHSZkKx8hUWXwq//Sky7tONk2b
 MzkK9QYQwXKQRpq+PhAmm8RwwzzszBahNVIDbMV2r95rNbIM51axJyKlBPT2AXfLsLiy
 HxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772060; x=1793376860;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oEtO3TXJ7yS5COlFIX1s7AsquxuY7dAeP+Qpp0El5hs=;
 b=wNNkh8nCKIjcd7VWjJgmIQeD6aJ8QBebQIlqb8GLvWvwLlnIlGcXKItYXcEFRGqkMs
 XgiEXneULAal5euCpVLSSi237p/YV2+EWhU+sufHf76A0L8C3IrOcf2A9QwiYV9FJfm7
 TXo2sJkw+HcxGSXw5sWi424L1J4ky5/N2Fstw17FoFC1IILBpGoJwGQELwNnWXhdJyoS
 22rhLSk19+o2tQNahMCAJrYuQnMgJIbEmVsMQ+MnBV3wWSd+clz+FizuW4ocr6Kyyi/T
 A8TqbLTpNax++kUdTx8KHpmhzz29LRRydfpQhhePZd3fX2JMAu4SA0i9Rzg/hTNRRlBI
 4o9g==
X-Gm-Message-State: AFq9FYKLTLep1HErMarF4IStQ657RDZTjTo4UWuJrniR0PKUI0GoCtmG
 weuIpAEenLGLU6TMCDBuFimDrkFFhqjndN0bEQMA9xw0rtVEDg5Yc2IfGhrjkcwJsF8lRcng5W+
 zaCVkHEUPnLRRr/uQ98yCNNs/7huZThyj38Lg4DEmeGVE2YpiE1T2Jepn/RE1m2ekFHYJ
X-Gm-Gg: AYBFou3J9Iilf2w+iBO2Ng6zpJFqB6/CH+tcKHKVOK8bfcza1+mVtZDYbk0S3ev4ZVY
 CCsCWoNuVtt3Q9u2iAIIjeHM/OSgGnKgW4MHrugMVFXoSbAggytX7K6sC83FqmTS5GRrYEPvD36
 h1cuymQLmJsxUz57XUQGF3tem9PA0ug74Y6qVyf81/1H0jqRHOg1GfM4oPRCr5Y9wuFTE01zPHm
 TpZz3oZA5isQW6wwmpyuadVd3Ik3ONOnZK0n8KFif0G/33WejKhXRG0RhNm2gfEX6vZkRvbzZBb
 STQAxF4k+3fffjjavxRh5bo0E7WcoLIf2Pgmk848xtb3SnsPmPfFHpIAX0tMfbr8gMJZHHO2X1K
 w6bH6js4LisNQC994b/iCi6L26zLQOfNM8HX0YEnX
X-Received: by 2002:a05:620a:4042:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93f6f94fe12mr485250885a.37.1792772059844; 
 Fri, 23 Oct 2026 09:14:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4042:b0:93e:78b7:fa4e with SMTP id
 af79cd13be357-93f6f94fe12mr485245685a.37.1792772059255; 
 Fri, 23 Oct 2026 09:14:19 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a29cdb2bd1sm18993295e9.8.2026.10.23.09.14.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/83] target/i386: Split leaving-halt handling from
 x86_cpu_exec_halt()
Date: Fri, 23 Oct 2026 18:12:14 +0200
Message-ID: <20261023161332.60153-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: uDWKIm2mD-Z-Qk-t4P9bv9HUM6Fvyl4N
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX02pZloyczxit
 u1hMGPNsjVhqgepl4oFmXB6e8o4LRRw/sw6R21sOGh3f7yJrIKuN2dnaak6iYlmXP8rpod+JJth
 eDBOOvMrmEDSfauYmUgcIcVkBi0pWeM=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb87dd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=GiXQl85om2WzCxkx9rAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXxs7RGKAE6o9u
 A4UHy+j8NfTuq0zqztJ9puUfXsf4HmuqosmbaGgqMgIeAN/60rNCO01zrcqWFYUSg3JxY/oCHnu
 9Tvp8a/qOBmkDg/LVKKI/cR5VKJyFfdD/yZou1qo9HCX71DSb2kZ81EXdYs+tVxGV7BuUcEPpOi
 MEsvKuiSMbMp5hgssXNYpyTkcCfHSscKYBOM5DQDu3ZmkJTvmgDGQlG7BqEvFPzvG2/E1TIdGTi
 3KZTy1D7NyCyxO/Us9Sn+6UC441YR8UUfXJRdnYMH1Cjr3o7h3t7kaDqjD9u57vjj+zfBMaYBDx
 b9Pm+6kvmsottkkMeiF14t25toDOlF0yXXJOC1/42TcslIZlgEwo6w8X40cYi/BcOZIxIBH5fAT
 gtXCv+E2pLepB5qsf/m8UkatkexfE9oes5TaGMw0rT1xOaVL2QUOdtnHZk1QiKa0uABRyqV3I9R
 aWliL1grjzHb9b0xYiw==
X-Proofpoint-ORIG-GUID: uDWKIm2mD-Z-Qk-t4P9bv9HUM6Fvyl4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Move debug exception handling performed when leaving HLT into
x86_cpu_leaving_halt(). Keep x86_cpu_exec_halt() responsible
for checking whether the CPU can resume.

Document that #DB IRQ delivery through do_interrupt_all() runs
in the vCPU thread and does not require BQL protection.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-7-philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 +
 target/i386/tcg/system/seg_helper.c | 25 +++++++++++++++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 58e8ca0bc1b..96accb30a80 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -39,6 +39,7 @@ void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
 bool x86_cpu_exec_halt(CPUState *cpu);
+void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
 #endif
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 9ce608a0bb7..566b3d4d80c 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -140,22 +140,31 @@ void x86_cpu_poll_during_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
+void x86_cpu_leaving_halt(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
-    CPUX86State *env = &x86_cpu->env;
-
-    x86_cpu_poll_during_halt(cpu);
-
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
+    CPUX86State *env = cpu_env(cpu);
 
     /* Complete HLT instruction.  */
     if (env->eflags & TF_MASK) {
         env->dr[6] |= DR6_BS;
+        /*
+         * do_interrupt_all() is the normal TCG exception-delivery path
+         * and runs in the same vCPU thread context, so #DB delivery does
+         * not require BQL protection here.
+         */
         do_interrupt_all(x86_cpu, EXCP01_DB, 0, 0, env->eip, 0);
     }
+}
+
+bool x86_cpu_exec_halt(CPUState *cpu)
+{
+    if (!cpu_has_work(cpu)) {
+        return false;
+    }
+
+    x86_cpu_leaving_halt(cpu);
+
     return true;
 }
 
-- 
2.55.0


