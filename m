Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B89C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4N-00058s-D3; Mon, 24 Aug 2026 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4F-00055s-Jf
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4C-0001jg-K5
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:35 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFn2dv3450323
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y6grNUJeZCc
 HgbN6QFALJG1WXFdzATJpfntYR9G55hs=; b=HUIVT0vbHU/n54Ko5Y6y8JI07yS
 CXn0fGVUzZlArpZvBqW/UPhqkl6OuS7nrfXk/ohZs9Y7zeKtC2Q12lT0bf7hW2DZ
 Zm7X9t3pPmtV7P+z6eDy9zEy45nZIim7vKj3WslP3AS/t5slkXKNq9Iqk9/fX15V
 k1J41v6mmGeNPXhwdN2CSbmBlyMnW6/dzKa3CIYcgFFywmq++1RVuXfDUb0vx6sJ
 zfcKvXTpSr0gb6HV90EDuKhGOEjJxIuNnNJGSwjkPcI+jJVTVwnp9pAkEmHnRzCp
 LxnhEmsI7Wllpe+sOUL+vwG8ntTKkeEg5eQcgLaxySxkNUirbWx7b2tVzXA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8pkdgpqj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so1449693a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587110; x=1788191910; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y6grNUJeZCcHgbN6QFALJG1WXFdzATJpfntYR9G55hs=;
 b=WEJS99g5yXBTbBQbG47bYEFwJ1LK+XJdTl5FxikIrC0wLQuhhN5JtIRu1L9nBTYspO
 ZmyvwXikEegKMvxfxiTOrEJ3dntQ1knc18uHIu04IbPvaRorzXUHDfizA4kVw91CrRjN
 a7AINoWFBvufu7bx2TMukUn9EyksS8R4m9o9vIn928PiJdogiWRca3LTcjLQXCPwN4We
 BhFmNBimPiTYRGsneupUCEnMSyy4csEWDRb8pXCMrycNnMD2zbDoxdI+nvgFZ6zXNtua
 gxdenQKEFiNFd3Mt2i8NwaVMhB8kon7EOEM4at4J0LCT+R/DfkVW7P38IjJGksdA8Bc9
 IacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587110; x=1788191910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y6grNUJeZCcHgbN6QFALJG1WXFdzATJpfntYR9G55hs=;
 b=MvAWhXcJgUTA6E+94SEFZm0t+l/z/m83lTXjfIEOA2iDjmk7RVk8OMuwxOew4Ud7oo
 COr/kgW3ePkaQedF8eDnSeACvTU9wVOvE2WphUK+gwq+2/f/djgHx63Md1tSSeGXnBJC
 gJg7NCkMEgdd2t2ocRNGzzUI9trYmQbesVs1wQwcgM0r/7evv4dn3b+OF1148SbS0otQ
 JUhyKHDO0KlbQSX1JJZCwkKC0ohMZCZb8sYzlSwKokKQjMmZJA8QTIvfto+f7yepvuVB
 3rhug71YahBOwNBH7p4uhJ+JlxJyNXUnk0czhXOp7EQHaIMg72u5fVXpEsoOlp87xQJf
 erdQ==
X-Gm-Message-State: AFuF++lpjLo9Vl1xVp4jcXGOXTfCe6AbI9B4r8hhJ4qvHdYPMh4VD4w6
 vQ/2BVdIs1XvEsnt5rXdXLr1/pcHTCI7yN2AGxIZVmUEk3dmn/EiOORhYe1eVVfQ/gkhtDpM9gi
 UygZ7izhq91o5LSKHrAlCytmA9ZOWH04//ZTkGdD8QI4hdoInsdROb2sN/Kvbn3wRCLRO
X-Gm-Gg: AR+sD10fp8yTNcNK4asLH6os8CDeqnBGlaWmrqpMelYngGf70LU/XQwhczf3FH2H8QH
 O7Lzba6+RdimjnCKv9LOlBnX3FY/fZP1wUWFZZttwyLM5kerPkfHR2YdN+0WD6HHcuhmtxwWGR2
 TPgLMxVL5mD15sTleJhxMA0gCHIU0zg9pn0QGsMuo4euOuasdqd65lO3xLdV/MMEoPcZ4de1OK/
 IWzn4VwNImiC+II4r0Ys5dvSL8Ircff/VC+YcqUtGuiJtKX90gPkC6zrE2DendDBodr3Z68QPRg
 uRIHzP+tcNT0PI5+UijfL+g0+ycLY2ssv66x3T3EcqkCQgcf/pi+/a8LcS76HPFFaAjFDg5SuWQ
 K3rL4MgzaEPRamCMFh6WIhrur6YK18NQOzDuOF46rxkbc7kuUBw+E7SpkpXX4Z0U=
X-Received: by 2002:a17:90b:1d8e:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-395df24f741mr30536309a91.11.1787587110481; 
 Mon, 24 Aug 2026 08:58:30 -0700 (PDT)
X-Received: by 2002:a17:90b:1d8e:b0:38e:7f1b:efa with SMTP id
 98e67ed59e1d1-395df24f741mr30536173a91.11.1787587109906; 
 Mon, 24 Aug 2026 08:58:29 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:29 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 03/14] target/hexagon: fix improper assign of cause code to
 exception index
Date: Mon, 24 Aug 2026 08:58:12 -0700
Message-Id: <5403f0e70b2746e55e716359dc93c2f936a52c11.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX1/PoFbTxCfmw
 eIVZy29XRKHEk4CC2+91oSa0KKr9Jyn6EX3TQQWns+pYORZWzCOdwBGA2uxXVG3B8cQBHgTlQ+b
 87+ODuwnqq9ednyq72fP274MzkgxyiI=
X-Proofpoint-ORIG-GUID: b_rvxnoCXmh3Dni0SOlefWROBRnkjQka
X-Proofpoint-GUID: b_rvxnoCXmh3Dni0SOlefWROBRnkjQka
X-Authority-Analysis: v=2.4 cv=Kq19H2WN c=1 sm=1 tr=0 ts=6a8c6a27 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=P_00z6N83E2WU_Jz4wUA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXz9Ho6h8C3yOh
 JWL2XXPlpKKHUiZ26XnF/FRGKE81bC/Hh/fETtgMl/tvIYyDIAn/nhvT53TeYragYLM98aopQTp
 DafDY3jfCn0G9gzTIDsrJ6k81XYspwb25r61hciCW8kVwd7l3zcxdr1ct+tV8dTUCjzhrrZDeri
 2fZni2FVMIhPu172fis+JGEuZO/paksoECW4zuNi1Fht5hlTw0mAdPAuCqIWSWYJJqrfzgSfD2Y
 FRgMaNAN4Ue+7OYtpGpVkF0Ov5Sy7812aKalHSL+5eIvey8zJKSBTJH6g6vRDPmSYm00aEOTMXI
 c9+Oc5nXCFCjq6Rx/6UQZnDWFygH7v8pAqr096r6lSB0dMGoEcQBmzBWdOoWmzyWcyygUb2C258
 i1wYfxgZkl9M1CjfdQ7ZwKHXyVHaqQlZpwSwj+sKzDIUJ+JMdo+LVsFi8/WmokhrDQLhsRQvVWl
 EEZRswtdGXRp6VX2iAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

hexagon_get_tb_cpu_state() detects a misaligned PC and raises an
exception, but it passed HEX_CAUSE_PC_NOT_ALIGNED (a cause code) as the
event argument to hexagon_raise_exception_err(), whose second parameter
is the event index (it ends up in cs->exception_index). This causes an
infinite reboot loop when we reache a misaligned PC.

Similarly, gen_exception_decode_fail() is called with a cause code
(HEX_CAUSE_INVALID_PACKET) but unconditionally routes it through
gen_exception(), which treats its argument as an event index and stores
it directly in cs->exception_index.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 linux-user/hexagon/cpu_loop.c | 5 +----
 target/hexagon/cpu.c          | 3 ++-
 target/hexagon/translate.c    | 4 ++++
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/linux-user/hexagon/cpu_loop.c b/linux-user/hexagon/cpu_loop.c
index d7f73439db..d46b922479 100644
--- a/linux-user/hexagon/cpu_loop.c
+++ b/linux-user/hexagon/cpu_loop.c
@@ -78,6 +78,7 @@ void cpu_loop(CPUHexagonState *env)
             break;
             case HEX_CAUSE_MISALIGNED_LOAD:
             case HEX_CAUSE_MISALIGNED_STORE:
+            case HEX_CAUSE_PC_NOT_ALIGNED:
             force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
                     env->gpr[HEX_REG_PC]);
             break;
@@ -88,10 +89,6 @@ void cpu_loop(CPUHexagonState *env)
                 exit(EXIT_FAILURE);
             }
             break;
-        case HEX_CAUSE_PC_NOT_ALIGNED:
-            force_sig_fault(TARGET_SIGBUS, TARGET_BUS_ADRALN,
-                            env->gpr[HEX_REG_R31]);
-            break;
         case HEX_CAUSE_INVALID_PACKET:
         case HEX_CAUSE_REG_WRITE_CONFLICT:
             force_sig_fault(TARGET_SIGILL, TARGET_ILL_ILLOPC,
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 7067e5b70f..134fbb2cfa 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -323,7 +323,8 @@ static TCGTBCPUState hexagon_get_tb_cpu_state(CPUState *cs)
         hex_flags = FIELD_DP32(hex_flags, TB_FLAGS, IS_TIGHT_LOOP, 1);
     }
     if (pc & PCALIGN_MASK) {
-        hexagon_raise_exception_err(env, HEX_CAUSE_PC_NOT_ALIGNED, 0);
+        env->cause_code = HEX_CAUSE_PC_NOT_ALIGNED;
+        hexagon_raise_exception_err(env, HEX_EVENT_PRECISE, (uint32_t)pc);
     }
 
 #ifndef CONFIG_USER_ONLY
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 06a8159d28..29821ffe3d 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -245,7 +245,11 @@ static void gen_exception_decode_fail(DisasContext *ctx, int nwords, int excp)
 
     gen_exec_counters(ctx);
     tcg_gen_movi_tl(hex_gpr[HEX_REG_PC], fail_pc);
+#ifdef CONFIG_USER_ONLY
     gen_exception(excp, fail_pc);
+#else
+    gen_precise_exception(excp, fail_pc);
+#endif
     ctx->base.is_jmp = DISAS_NORETURN;
     ctx->base.pc_next = fail_pc;
 }
-- 
2.37.2


