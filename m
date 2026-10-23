Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E8E606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RBkV9DCi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jBXJA27a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHul-0004td-D9; Fri, 23 Oct 2026 12:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuZ-0004TR-9Q
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHuX-00026W-Io
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:31 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE5xGS4063478
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yyjhp+Xe8BcOnZkMVuSHJIWJ73JZWvyw1/KmLw6zgts=; b=RBkV9DCiZsVFvvfF
 Oe13Xggr5V1aMGoyOWxIoDdyyz/2JTAdQcnVjfZY3bCugurGIgmKAsmwREngvNkL
 o28AA3ajWYr3fKWsEvBncrwpw5EBiyQvkE/mySTWiqbjh9MUUzViqLjJEBMrpQE2
 A2JuXifniGqpcEkz+hFZO0efcVTyAE1+ZYZQQtZwjgMmQOwdIDBB91YagnheRS3i
 fZ3LMP/7J7WadH5MH1JMt9qlFst/RiUyyMueCBgsMY5mFvRjEYoD1aadNr5eGlCj
 D1qirr5+zy8twkuXPaRzxjH8DadJ/oMv0BjkSYJ5d7h1sKglLxZlQwvoeVFB63dw
 YSGO9A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrcgfs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:28 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f32050e72so340679285a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772067; x=1793376867; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yyjhp+Xe8BcOnZkMVuSHJIWJ73JZWvyw1/KmLw6zgts=;
 b=jBXJA27aL0+R+S/NNz+dc4YTiDXv/+6WKnayIAGn5RXof7t/YCVJi5mWvMOBIIJn2h
 QTgFFRE8nt9wgbTvTC5sxBURMIkKrEFMCJ2xdSiiLUjaYYdU8rE3+8B+qfYhR2uANH+V
 cwRHIMvnjBcrtUD58soXO0gvkOpGT6Say8MQPpq/RHqpgeQvfLJTRSfBM5GVsTGBKG+t
 saNPYn5btUOjAUEMKL7Kv3/94DbT2ZcN3889I5pC/X4S+RxgQAKOaurmYrav2pWLusoU
 dmbOJt2CvXdTG84szq8EaZ38y06UekUwAD3z33ZmvA9xhGfODxXmRdqOytWxaKnIHlos
 lC8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772067; x=1793376867;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yyjhp+Xe8BcOnZkMVuSHJIWJ73JZWvyw1/KmLw6zgts=;
 b=oR/5eZQoMnjH0Iv8cYufvxCJitpeFGwFTvNf8dJJVAB7zUJhzGnZQEYEZs3h6WKn/W
 qCpWhOjssdPn0dNHwigApu+SYddbnSu+F4RIeeirEEouRZLv/n/M2GX9O4ZjWpJ7I30x
 KSlx2dzndC4EBYubWILltlTffpyllmvCqRM0X1CThGY8z9LdcIIzKaWh21w8LTB+MmrO
 cgPgx887JjyJdESWW+jXPrF+9RgHIkAxOMhPMGv9I+G8PzzPC5EA974SM00V6RH+YLds
 UIo67ifa4Lt0EzTmqU25gXZY8HqKO+VprQZolpLznznAuxwQvSWQp3M6fFzGbEu2PBLh
 pTEQ==
X-Gm-Message-State: AFq9FYLRhm2R/fKIFQfQ1EFlA5oh5gCgqe8sA6hcEgYUid1Li8HosVgU
 /HzVZpPgnucaUgS8O1Gv42EE5XLlz60qsdMgXXEH5KsgnrLDF/RdjdVhPwq9QB9s/s1aM8ChVwr
 ujbdQ6U/mG9+vNL7BvHjrh7fQngTY5aYJ6cZrRG6Vlr2tdMGuDQqQHsz7AoRZre0KlbZT
X-Gm-Gg: AYBFou0emgfCfTlK2tvJT3Fp/AqjYeSADr2xthHHHwQKVFXqBBelr+ikfw3Urdqpw66
 5SDXkcD0xNGKSdH/JxsDEuJ4UDzhR7B6PzRYv4XdOxfOCWYpT8BLlhvlaFtpOPoLTC6EiqTTdSs
 HGmiFr79+sgPkRfzVkSFipYnnWcYiBGapTZN6Gbl94hDOUtUEDsSyfOpCpEunJWoFBb3GM/xXrK
 h2G3GqTabMt4Bdyvch1UzLC72lTyGL0JZAXPcRqngedWCLmuz500oilg5DUcAy729EXac7nA60I
 xW2L2hHy20P9jkUnGB9HNrRVtLKYwGb/1fjneNgY5arwKbuazt0Jfk7tPp79t7ih99jmRq9jzXq
 L/mRFnkaKWFKQ1vaDqtOfOYD7O0JYiqT6Ugb+6AKa
X-Received: by 2002:a05:620a:2a02:b0:93e:c12c:fbc6 with SMTP id
 af79cd13be357-93f6fa28e8dmr491686585a.83.1792772067059; 
 Fri, 23 Oct 2026 09:14:27 -0700 (PDT)
X-Received: by 2002:a05:620a:2a02:b0:93e:c12c:fbc6 with SMTP id
 af79cd13be357-93f6fa28e8dmr491682385a.83.1792772066569; 
 Fri, 23 Oct 2026 09:14:26 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b065c850sm15438495e9.13.2026.10.23.09.14.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:25 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 07/83] target/i386: Use generic halt transition handlers
Date: Fri, 23 Oct 2026 18:12:15 +0200
Message-ID: <20261023161332.60153-8-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZUVD1i_yqsTXPA54VXOttuUV3SMFQgjr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX8aMUymwNfE/X
 IffVRo8uCfJztLhXVFADEKchc3CWd8M1lDnzf3T5HGLqsiUb/9O88GSJaZ/oReovmbuCde57435
 0YtdqmHT8CQMX7X3ueJKkT2vizc4sws=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb87e4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xWu8-Agft_6X_INOG6MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfXyTLSsgwdSOoE
 Mw/MiAM4hdaa4nGWUy30ltyQWNGNlYjCNJsiGB0Fu8Y+Cx+k870bW9UU28bjnwm7WM8gr2TL8Sj
 0nZYxEXNa7clq4ehUpGrK26EyCpRzkgWFK+5cXnFm2PybaqlzGIff8XWLjn72Dj/swErg1abtOV
 JauqbvSc3UWjxxTsMEQPbmlRIaE8MaiZyNmIgirS5Ku1jwlYBhp34iW3GXxfHeKUQKDoeHtOroS
 AnLCiaFOQRizDvAOrpI5atI58O3ae+ZEd6P2E7On0HQFxPsoz/PcIIS2EtC6oj29kmc27XA2xjt
 zezCU6HZVux9A10ZOgEwZiM43HDhq5iwAmgvarb6U8T4uCNCqG9E8TTw+6wJJmvQ5ybW5P5+xiX
 dsk41NaTCGpOdKtrntVJFin6nHMeYy5LkxFiDVytWtlhOOseT1JqU+LoK8Y+lIicJCCP1TKfnd5
 gfjLcoRkni4IKzWEfXQ==
X-Proofpoint-ORIG-GUID: ZUVD1i_yqsTXPA54VXOttuUV3SMFQgjr
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

Register x86_cpu_poll_during_halt() and x86_cpu_leaving_halt()
with the generic TCG halt flow. Remove the target-specific
x86_cpu_exec_halt() wrapper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-8-philmd@oss.qualcomm.com>
---
 target/i386/tcg/helper-tcg.h        |  1 -
 target/i386/tcg/system/seg_helper.c | 11 -----------
 target/i386/tcg/tcg-cpu.c           |  3 ++-
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index 96accb30a80..4d543556a9f 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -38,7 +38,6 @@
 void x86_cpu_do_interrupt(CPUState *cpu);
 #ifndef CONFIG_USER_ONLY
 void x86_cpu_poll_during_halt(CPUState *cpu);
-bool x86_cpu_exec_halt(CPUState *cpu);
 void x86_cpu_leaving_halt(CPUState *cpu);
 bool x86_need_replay_interrupt(int interrupt_request);
 bool x86_cpu_exec_interrupt(CPUState *cpu, int int_req);
diff --git a/target/i386/tcg/system/seg_helper.c b/target/i386/tcg/system/seg_helper.c
index 566b3d4d80c..e24d01000ad 100644
--- a/target/i386/tcg/system/seg_helper.c
+++ b/target/i386/tcg/system/seg_helper.c
@@ -157,17 +157,6 @@ void x86_cpu_leaving_halt(CPUState *cpu)
     }
 }
 
-bool x86_cpu_exec_halt(CPUState *cpu)
-{
-    if (!cpu_has_work(cpu)) {
-        return false;
-    }
-
-    x86_cpu_leaving_halt(cpu);
-
-    return true;
-}
-
 bool x86_need_replay_interrupt(int interrupt_request)
 {
     /*
diff --git a/target/i386/tcg/tcg-cpu.c b/target/i386/tcg/tcg-cpu.c
index 9db9795a3b2..167ff7695ae 100644
--- a/target/i386/tcg/tcg-cpu.c
+++ b/target/i386/tcg/tcg-cpu.c
@@ -182,7 +182,8 @@ const TCGCPUOps x86_tcg_ops = {
     .tlb_fill = x86_cpu_tlb_fill,
     .pointer_wrap = x86_pointer_wrap,
     .do_interrupt = x86_cpu_do_interrupt,
-    .cpu_exec_halt = x86_cpu_exec_halt,
+    .poll_during_halt = x86_cpu_poll_during_halt,
+    .leaving_halt = x86_cpu_leaving_halt,
     .cpu_exec_interrupt = x86_cpu_exec_interrupt,
     .cpu_exec_reset = x86_cpu_exec_reset,
     .do_unaligned_access = x86_cpu_do_unaligned_access,
-- 
2.55.0


