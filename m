Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FD8CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOLc-00019n-FL; Wed, 07 Oct 2026 05:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFp-0000L6-EY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOFn-0000r9-6N
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 05:48:05 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977k3GP2711704
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 09:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cXM4ZXmvkNMmtTFKga9J3le83Pri+SJF3tGEShqtQPk=; b=dnTpaK2pTpC3GgE6
 yxY/Z4M1r3CFZsRXMcp4JNFkSAjSu7r1X39tMC7OGEfpza2li8+zWcj3pjMWpmQx
 1ymEWemVriI8cFpQP8nLyA3M+ZZEuxH6d0bWw8ChbP9ZgxkIuOdthzn2+Zr9JSLx
 P2dwi+gSzWWl/KXua/4zBijShmdkxQGP0JD79cO84JMtRFGRKBw2db2pPFkBB30o
 Ab7DitQFsr44ySzCcE+mDgcljRXEDzS7MPN4KQsT38ofskR6UgKIg11yRhB2WiGF
 IXdveuOH8Iwj91L1eAm/VsnngJSZr1ZqnMEVjZX6AArW9IKbgc/+3/nzNEysXcT7
 wefDPA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c1s1jda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 09:47:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so748295485a.2
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 02:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791366478; x=1791971278; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cXM4ZXmvkNMmtTFKga9J3le83Pri+SJF3tGEShqtQPk=;
 b=SUj/OTlB837WX0K+QxDrZ+vLpUuUO2lDXD1mDzsVnP3iC7G1jvHEjcmq6UoII1TZrd
 z1xnrms3tOCflacr/IRMylJ2s8VYMvpNYsx9JXp8/DSdHNM8slUUYC4k5CXHx8Pa8zgN
 15v4lVfKuK1fdRvmeTCErPGmPu3pqZ3Ugf7Tnaon4HUFlTYC/qhRO1gq8AvVU9ulpqgM
 E8D3XLpAQzmi5nv5ZHV7B0E4dZSUIcuiBx1zufwcVsk+ut80Aw9UtHaxzI5Ver4+jW4a
 xbF8QChMdhz43OLkMhs5IbI16BeLrNlPTmP0O7Ew7moLQRLONexZAySCIb7UprgI3gWb
 tshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791366478; x=1791971278;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cXM4ZXmvkNMmtTFKga9J3le83Pri+SJF3tGEShqtQPk=;
 b=tsutKsDnNPlNt+BXsgeueTlSJkOCktUu9A1O21HZefSUbVjtt6o4B+EJ95QLn0cHji
 v06qm65qSvuHhzMRovrSxxzt1jmfBpGxlKU902QGSgb5HhJtozWqC4Bfabi2H17iZiDZ
 QEdEELG2ot9K+HKkthJRoYNegdpsXF2SImtewcCFo3Yy7Lw2q6s3h0ZUuMv4HOiF7WJd
 NvgUbmFfi97AxMaT3c1VZnwkCLEvChzNgxypII+SdpXTH32nv+VNYWOdXgOzggjDHj8R
 bM+w2AgC1jW/yHQGaKGXzkUrMOoDww9H8fJVKRDOWOBsJldyR1gyvXy7JJPtbREQQNhQ
 XKSA==
X-Gm-Message-State: AFuF++kSRox4npsL4aA5t7tO0b8Bj/AWyZNp3U2M1WGgS/Iuu55zXkt/
 xh/So6r4FSWho3/wxaj7YsC7GGFgk6xYHqdXRwgIoGdMag1da/zzWKOKt3zoB8rq7jpSlhzytlO
 YwHh+CPi5N0BrJYguj0sjcsQB8abnrKb7Yi1OhRXocRrmhH5Yq4X/A2v415ntrD/grqFK
X-Gm-Gg: AYBFou3jx7s2QUep94jgQe7n06+hbxTvJS6LADKhH13/4FvhoFe7MdidnJLfU/OIeRv
 7HLZhBe1EOm9MGYqUrYQHFGTJOLWmiB/BV7z/Yu8TNGHQEmKZ1Gawy0wAB+rCtSg9UQZ1Tzrks1
 6nAaoKL5l7/5ssZd2nv3mbhG9BXWfEQQ3ShwYisWoxdTUXoJCtRINqDfNsw5zyOXXrnsmlH+TpA
 eOKACJaYD1/M9IhgjKNkC8dJaJCqpnXyQa3fGXxifBY0Mh9+Gws6Z8rEt8KxtpT1011JzQFAf0Z
 e2iwYqzmEHf5wR4n2HSRpXqfFfU97dSqpf+fCOm4J1E4anzfz1i+imznEq3WduReQnAQUMmU1Zv
 HTPFCZSapeQOGDAUVSLpg1qLxkAdDi9d/FTcWS0pz
X-Received: by 2002:a05:620a:400b:b0:93e:7898:4d73 with SMTP id
 af79cd13be357-93e9b7b1761mr276430285a.45.1791366477560; 
 Wed, 07 Oct 2026 02:47:57 -0700 (PDT)
X-Received: by 2002:a05:620a:400b:b0:93e:7898:4d73 with SMTP id
 af79cd13be357-93e9b7b1761mr276426585a.45.1791366476899; 
 Wed, 07 Oct 2026 02:47:56 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c50f54sm130838775e9.10.2026.10.07.02.47.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Oct 2026 02:47:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Yonggang Luo <yonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>
Subject: [PATCH 22/27] target/sh4: Define exception vector constants
Date: Wed,  7 Oct 2026 11:45:10 +0200
Message-ID: <20261007094516.75732-23-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: UlUDB_DLr6jOE-XWwTJSf9mGPUpmiRIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX53hWOVnbRKye
 4TLvw/leKAMBmdhxihOIFr/LPTV21cDPLbZDR+ZpBhzLjaIeyJfDupUMMwpJYPEqAArgCZsCp4Q
 597CEX7ZxEPuRzzQS5wXXk9itKIFvNcpNbPZYmwOKowMAJBTbIAVRoEBsI+RelPpO2pA9Sw2/6F
 X+T0gAATp75KcLoMQ+/+fbNeNoZxz0ig2OOah5FgSnGMtL2mCaTnkobTLFVFm1cOvuSXwTCUkYJ
 59t1OiTw1UipzXlq3yy6kVNs0SP16DTxVdsho+QBUUWUpXWyt5CGNUdzBhCjqutmAJRVvmRQBye
 TLDR5ZOKCSNlXBbcTDLfP6O+vawSMpmYcKQq2b+nuh9jzx0BpDgTve189t/ZBk60pRKxgd/ayvg
 6Rv5D1+4P+Z5By6WWrBCbrzPs98ZgSFgVxtLz7auyYKp9ZlKWOF73UdeHmerP6tA8P1cl/6V5Wa
 h7G0iixNdBB0i62ZFLw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzOCBTYWx0ZWRfX+2D2Ufx/6jB5
 /355ElASxCRobAd+S8NlInNGm5ueoG689RdtNidYKEBHCBo39rNQv6YKPouFAdlvrL71IGquR/+
 kOpjFeNt8lrz2p9A7sF1AtVJaSrBnZI=
X-Proofpoint-GUID: UlUDB_DLr6jOE-XWwTJSf9mGPUpmiRIq
X-Authority-Analysis: v=2.4 cv=NatzRGD4 c=1 sm=1 tr=0 ts=6ac6154e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=exSUSkewqcAxhAk9TGUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070038
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Yonggang Luo <luoyonggang@gmail.com>

Name SH4 exception vectors and use the definitions throughout
exception handling and exception raising.

Signed-off-by: Yonggang Luo <yonggang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/sh4/cpu.h       | 21 +++++++++++++++
 target/sh4/helper.c    | 60 +++++++++++++++++++++---------------------
 target/sh4/op_helper.c | 16 +++++------
 3 files changed, 59 insertions(+), 38 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index 6984bb462fb..a1e9049b7be 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -135,6 +135,27 @@ typedef struct memory_content {
     struct memory_content *next;
 } memory_content;
 
+/* Guest trap numbers. */
+enum {
+    SH4_EXCP_RESET = 0x000,
+    SH4_EXCP_MANUAL_RESET = 0x020,
+    SH4_EXCP_TLB_MISS = 0x040,
+    SH4_EXCP_DTLB_MISS_WRITE = 0x060,
+    SH4_EXCP_INITIAL_PAGE_WRITE = 0x080,
+    SH4_EXCP_TLB_VIOLATION = 0x0a0,
+    SH4_EXCP_DTLB_VIOLATION_WRITE = 0x0c0,
+    SH4_EXCP_ADDR_ERROR = 0x0e0,
+    SH4_EXCP_DATA_WRITE = 0x100,
+    SH4_EXCP_FPU = 0x120,
+    SH4_EXCP_TLB_MULTIPLE = 0x140,
+    SH4_EXCP_TRAPA = 0x160,
+    SH4_EXCP_ILLEGAL_INSTRUCTION = 0x180,
+    SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION = 0x1a0,
+    SH4_EXCP_USER_BREAK = 0x1e0,
+    SH4_EXCP_FPU_DISABLE = 0x800,
+    SH4_EXCP_SLOT_FPU_DISABLE = 0x820,
+};
+
 typedef struct CPUArchState {
     uint32_t flags;             /* general execution flags */
     uint32_t gregs[24];         /* general registers */
diff --git a/target/sh4/helper.c b/target/sh4/helper.c
index b6b057f104b..0fbd613f333 100644
--- a/target/sh4/helper.c
+++ b/target/sh4/helper.c
@@ -70,7 +70,7 @@ void superh_cpu_do_interrupt(CPUState *cs)
     do_irq = do_irq && (cs->exception_index == -1);
 
     if (env->sr & (1u << SR_BL)) {
-        if (do_exp && cs->exception_index != 0x1e0) {
+        if (do_exp && cs->exception_index != SH4_EXCP_USER_BREAK) {
             /* In theory a masked exception generates a reset exception,
                which in turn jumps to the reset vector. However this only
                works when using a bootloader. When using a kernel and an
@@ -97,43 +97,43 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (qemu_loglevel_mask(CPU_LOG_INT)) {
         const char *expname;
         switch (cs->exception_index) {
-        case 0x0e0:
+        case SH4_EXCP_ADDR_ERROR:
             expname = "addr_error";
             break;
-        case 0x040:
+        case SH4_EXCP_TLB_MISS:
             expname = "tlb_miss";
             break;
-        case 0x0a0:
+        case SH4_EXCP_TLB_VIOLATION:
             expname = "tlb_violation";
             break;
-        case 0x180:
+        case SH4_EXCP_ILLEGAL_INSTRUCTION:
             expname = "illegal_instruction";
             break;
-        case 0x1a0:
+        case SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION:
             expname = "slot_illegal_instruction";
             break;
-        case 0x800:
+        case SH4_EXCP_FPU_DISABLE:
             expname = "fpu_disable";
             break;
-        case 0x820:
+        case SH4_EXCP_SLOT_FPU_DISABLE:
             expname = "slot_fpu";
             break;
-        case 0x100:
+        case SH4_EXCP_DATA_WRITE:
             expname = "data_write";
             break;
-        case 0x060:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             expname = "dtlb_miss_write";
             break;
-        case 0x0c0:
+        case SH4_EXCP_DTLB_VIOLATION_WRITE:
             expname = "dtlb_violation_write";
             break;
-        case 0x120:
+        case SH4_EXCP_FPU:
             expname = "fpu_exception";
             break;
-        case 0x080:
+        case SH4_EXCP_INITIAL_PAGE_WRITE:
             expname = "initial_page_write";
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             expname = "trapa";
             break;
         default:
@@ -161,18 +161,18 @@ void superh_cpu_do_interrupt(CPUState *cs)
     if (do_exp) {
         env->expevt = cs->exception_index;
         switch (cs->exception_index) {
-        case 0x000:
-        case 0x020:
-        case 0x140:
+        case SH4_EXCP_RESET:
+        case SH4_EXCP_MANUAL_RESET:
+        case SH4_EXCP_TLB_MULTIPLE:
             env->sr &= ~(1u << SR_FD);
             env->sr |= 0xf << 4; /* IMASK */
             env->pc = 0xa0000000;
             break;
-        case 0x040:
-        case 0x060:
+        case SH4_EXCP_TLB_MISS:
+        case SH4_EXCP_DTLB_MISS_WRITE:
             env->pc = env->vbr + 0x400;
             break;
-        case 0x160:
+        case SH4_EXCP_TRAPA:
             env->spc += 2; /* special case for TRAPA */
             /* fall through */
         default:
@@ -632,7 +632,7 @@ void cpu_sh4_write_mmaped_utlb_addr(CPUSH4State *s, hwaddr addr,
                     CPUState *cs = env_cpu(s);
 
                     /* Multiple TLB Exception */
-                    cs->exception_index = 0x140;
+                    cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
                     s->tea = addr;
                     break;
                 }
@@ -828,33 +828,33 @@ bool superh_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     switch (ret) {
     case MMU_ITLB_MISS:
     case MMU_DTLB_MISS_READ:
-        cs->exception_index = 0x040;
+        cs->exception_index = SH4_EXCP_TLB_MISS;
         break;
     case MMU_DTLB_MULTIPLE:
     case MMU_ITLB_MULTIPLE:
-        cs->exception_index = 0x140;
+        cs->exception_index = SH4_EXCP_TLB_MULTIPLE;
         break;
     case MMU_ITLB_VIOLATION:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_MISS_WRITE:
-        cs->exception_index = 0x060;
+        cs->exception_index = SH4_EXCP_DTLB_MISS_WRITE;
         break;
     case MMU_DTLB_INITIAL_WRITE:
-        cs->exception_index = 0x080;
+        cs->exception_index = SH4_EXCP_INITIAL_PAGE_WRITE;
         break;
     case MMU_DTLB_VIOLATION_READ:
-        cs->exception_index = 0x0a0;
+        cs->exception_index = SH4_EXCP_TLB_VIOLATION;
         break;
     case MMU_DTLB_VIOLATION_WRITE:
-        cs->exception_index = 0x0c0;
+        cs->exception_index = SH4_EXCP_DTLB_VIOLATION_WRITE;
         break;
     case MMU_IADDR_ERROR:
     case MMU_DADDR_ERROR_READ:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DADDR_ERROR_WRITE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         cpu_abort(cs, "Unhandled MMU fault");
diff --git a/target/sh4/op_helper.c b/target/sh4/op_helper.c
index 777380f8e40..8beac9ca034 100644
--- a/target/sh4/op_helper.c
+++ b/target/sh4/op_helper.c
@@ -33,10 +33,10 @@ void superh_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
     switch (access_type) {
     case MMU_INST_FETCH:
     case MMU_DATA_LOAD:
-        cs->exception_index = 0x0e0;
+        cs->exception_index = SH4_EXCP_ADDR_ERROR;
         break;
     case MMU_DATA_STORE:
-        cs->exception_index = 0x100;
+        cs->exception_index = SH4_EXCP_DATA_WRITE;
         break;
     default:
         g_assert_not_reached();
@@ -67,22 +67,22 @@ void raise_exception(CPUSH4State *env, int index,
 
 void helper_raise_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x180, 0);
+    raise_exception(env, SH4_EXCP_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_slot_illegal_instruction(CPUSH4State *env)
 {
-    raise_exception(env, 0x1a0, 0);
+    raise_exception(env, SH4_EXCP_SLOT_ILLEGAL_INSTRUCTION, 0);
 }
 
 void helper_raise_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x800, 0);
+    raise_exception(env, SH4_EXCP_FPU_DISABLE, 0);
 }
 
 void helper_raise_slot_fpu_disable(CPUSH4State *env)
 {
-    raise_exception(env, 0x820, 0);
+    raise_exception(env, SH4_EXCP_SLOT_FPU_DISABLE, 0);
 }
 
 void helper_sleep(CPUSH4State *env)
@@ -97,7 +97,7 @@ void helper_sleep(CPUSH4State *env)
 void helper_trapa(CPUSH4State *env, uint32_t tra)
 {
     env->tra = tra << 2;
-    raise_exception(env, 0x160, 0);
+    raise_exception(env, SH4_EXCP_TRAPA, 0);
 }
 
 void helper_exclusive(CPUSH4State *env)
@@ -255,7 +255,7 @@ static void update_fpscr(CPUSH4State *env, uintptr_t retaddr)
         cause = (env->fpscr & FPSCR_CAUSE_MASK) >> FPSCR_CAUSE_SHIFT;
         enable = (env->fpscr & FPSCR_ENABLE_MASK) >> FPSCR_ENABLE_SHIFT;
         if (cause & enable) {
-            raise_exception(env, 0x120, retaddr);
+            raise_exception(env, SH4_EXCP_FPU, retaddr);
         }
     }
 }
-- 
2.55.0


