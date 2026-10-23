Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650F1606A31D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WtrSlI0m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K2Ia2LDv
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHu1-0003pI-7b; Fri, 23 Oct 2026 12:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHtx-0003of-Fc
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHtv-00024Y-Pa
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:13:53 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6qst3001100
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ghyi54x7016l+OJN9TsCoDTp/Xdc0pg6+ZCI5lLUi6A=; b=WtrSlI0mFcXsQD6b
 4WEpQMbwYMVssaSFrGy5Qe0NLU/P+j/sU8Vy9zIb1Mp7SD2zM0fLfPMYq4OvWqF7
 K9UddCp1wjhgO7om8r6AtSL/Ylld0/sLl1UK9PDfDZVxU3iGWLM31GGbsItMR6SP
 cp84Rde5Cay+7Bt8IZk7r4yn4aAWlmWAwUXfoie8skqzkNJvAch8d5N1mLqBXye5
 7HnYdsuphMj34Y65q49RDsV5txvf8vlE6W6frJQiNbVR8bGtqnAmv8PaqOl3F4EH
 oABoaEiqlEm8jkJDYjyJV49PyGgOXc9UvshshF7G0um1DFRwirZ7TZr3QWvPIkXE
 JsTFvA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hg7cn0vhw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:13:50 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb6391e89so229175585a.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772030; x=1793376830; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ghyi54x7016l+OJN9TsCoDTp/Xdc0pg6+ZCI5lLUi6A=;
 b=K2Ia2LDv4Yebwo1eWLorSvygiKJbZCI8K0xeEG/ZuqxMYsYvvkBB/gFrH70z3U4hGV
 Oq9JQEzRpTphfGqKL9T8mBKgWCzccNXKNIc1nFN3pgR/CD0TwqQFCr+w4foxbIMo6eu7
 tQevExxlAni2aPEDv2Nj8L+4uVXaOILASa+d7IasUt1eME9W7HH1/cmBufY8VuhJM9Fg
 BdnXOrDUVORaoy9ueGYRzlDZ2BNnOWkrtwfcrsYvQq3RQxoa1IeTNZAJ0zGroiQ/gQb6
 a9HH1kXN14w1Wg6RcvewoQR5gJ3iFcUWoyaYLLoEH2OaOKMFd1MRFU/Yhiv0Oqjuk4oY
 myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772030; x=1793376830;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ghyi54x7016l+OJN9TsCoDTp/Xdc0pg6+ZCI5lLUi6A=;
 b=I2SdrtDiLWFogKTpyI6sUAdsRs/UMq0CEJKTI1N98u7h8SZVEOYF+RUD0JV59fvdmA
 ENE/6jkFGf8RDyoqbdvwwAC/29m+3XD3Ont9S8pF4Sd7aQBEglwBj+SKUcp1v57qoWVk
 Q3wrdibg7xMUFKZz8E87mfA12K+g/ddLPQvMtpQ3dmZmKZy1YmZLkGCuaKpw7TCDqBH/
 5vF8tV9HEMBUnqsl2ohuTFXFrYIIy+CqNmuZo5bKTsRD0YgWvKw0LUF2Yltbbx8tHxMv
 BIT3iqI4yyXUPwv6oQSbYvvrGIM0azdkENCSvACDcm3HBsC6V2LNV9Meiu/qjF07wrlT
 Bnag==
X-Gm-Message-State: AFq9FYIAYFeHxmQSb3sekmIlKw1oCBRrGsb6Vc8gmbhif8IXUPSj9ut5
 2QT7SlLFrRGBvJNQ3pXc95K6Ad92skaDRqUSZRVy88z1GP3sF3S2HXCc5DX4gJd8BtiCbpFDQFh
 kkphERG72SZGV9CtVHi65Zu7LKV6ITJiYpWm5kphmwJXmSy9ZK5m7OOvpHpNFjI0yrMt7
X-Gm-Gg: AYBFou255lzJuOSSx40jPUqyFyfLOG0/rTdWU+ejMg1Smxr3ewrDitN4ePMXMK5Brrg
 Rs9UpqjQcovCk+FK5cgmo0ptVDJ6EPdNsNKKj9is/NtxX/lJaDcZ3BdCP10DVuUAuNhDiBMH7MM
 1Ud879w825ySr9beFo0ro3S504BqI3X8n0ABpPIbdHf72wdV5b1+88/xw0xBBbiBuvEDUzRz70p
 8U7JMU8YV8WAAddIq36NQbAfjnrw3f5dltZMT3bUA5xTRqQo3fnMfNHsRmQlOZzy1ZgGxiW9RGF
 c1k96Cz192RI2tHPWf79a8AWsSxHMOYC/Dcabv4afY0V5QDaeTk6C9w83h37wYfLyDfcCoEulqt
 AVwxK8umbxiJmafrxHm2hy4ZkyUnsrwNI+UUYpRsx
X-Received: by 2002:a05:620a:4483:b0:93f:e52:40ec with SMTP id
 af79cd13be357-93f6f8a5381mr476663585a.81.1792772029977; 
 Fri, 23 Oct 2026 09:13:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:93f:e52:40ec with SMTP id
 af79cd13be357-93f6f8a5381mr476657085a.81.1792772029287; 
 Fri, 23 Oct 2026 09:13:49 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a312eafc80sm18139015e9.3.2026.10.23.09.13.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:13:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/83] accel/tcg: Introduce poll_during_halt() and
 leaving_halt()
Date: Fri, 23 Oct 2026 18:12:10 +0200
Message-ID: <20261023161332.60153-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX6Z/DjCKq1Ht4
 0J40LojmAbiFip4d0w0p/kYwrldCAzDrfp9f/b+wTL1AmAzQdIN4NgOB/hv4O7LW9GJdX2TNQCJ
 GqZaI8pvBf3uvbJR2kG9Woyruit72bMd1g61MvvXL5zVRWT/uEov9jr+c5ACtp5y6mKkJnRROXb
 AgahEIr9wOB1OuM6q0BFcYksG6pB1cdyXSXtRppmj1iFulxCWEuCaRt3gFYza5yXzz5TVnoPKU2
 yTgU3ndqF9k7TLPa1v3fNo/YkAJQWzfsPyxupiDgsj4RsYG0iJ9jsJWB/UAZw/ZUs8IiyFoQDSh
 6ZHLF8Vvl8/hGbzFeFnh3csymLL9HAO7lfH1qAt2FVsS9or95hYaxCObtWoJPghjHzio8cweHdl
 8qmjNCczJ8IhJk5rr2pm3ZbZtUCG5uIx+dRrMXCZxslg2xPu9ksZJpSoSMsC30vOTC3crYO0Yb8
 Me1aUaPUVnS2idL81gQ==
X-Proofpoint-GUID: WFLguwosG9YiOPUgygv00rimbwz4sVqq
X-Authority-Analysis: v=2.4 cv=a9mlZkSF c=1 sm=1 tr=0 ts=6adb87be cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=DbqnPDNGgojIjNu1nyEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: WFLguwosG9YiOPUgygv00rimbwz4sVqq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX+geL2RjD8Onq
 Fnu+TaUqDV9xZW1a57jUbj3Ij7f9/KTB38MmQhSgZU3K+O2UpwPWpEYVe8xW3F+SF+CTUZHx9El
 Fl9oHg7TwpZ/GR+UHqAqC95WwKwCqvw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Split target-specific halt handling into an optional
poll_during_halt() callback before cpu_has_work() and a
leaving_halt() callback after work is found.

Keep cpu_exec_halt() as a legacy alternative for targets
that have not migrated. Require each target to provide either
cpu_exec_halt() or leaving_halt(), but not both.

Inspired-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260930174946.82195-3-philmd@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 24 +++++++++++++++++++++++-
 accel/tcg/cpu-exec.c        | 21 +++++++++++++++++----
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index 3ff6e6810e0..1ee5d3d8bdb 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -169,6 +169,27 @@ struct TCGCPUOps {
      */
     vaddr (*untagged_addr)(CPUState *cs, vaddr addr);
 #else
+    /**
+     * @poll_during_halt: Poll target-specific events while the CPU is halted.
+     * @cpu: vCPU context
+     *
+     * Called when the CPU is halted to handle target-specific asynchronous
+     * event processing before instruction execution begins.
+     * The caller does not hold the BQL.
+     */
+    void (*poll_during_halt)(CPUState *cpu);
+    /**
+     * @leaving_halt: Perform target-specific cleanup before resuming
+     *                execution.
+     * @cpu: vCPU context
+     *
+     * Called after a halted CPU has detected pending work and is about to
+     * resume execution from the halted state. This callback performs any
+     * necessary target-specific state transitions or synchronization before
+     * instruction execution resumes. The caller does not hold the BQL.
+     * Either this callback or @cpu_exec_halt must be provided (but not both).
+     */
+    void (*leaving_halt)(CPUState *cpu);
     /** @do_interrupt: Callback for interrupt handling.  */
     void (*do_interrupt)(CPUState *cpu);
     /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_exec */
@@ -185,7 +206,8 @@ struct TCGCPUOps {
      * if it should remain in the halted state. (This should generally
      * be the same value that cpu_has_work() would return.)
      *
-     * This method must be provided. If the target does not need to
+     * Either @leaving_halt or this method must be provided, but not both.
+     * If the target does not need to
      * do anything special for halt, the same function used for its
      * SysemuCPUOps::has_work method can be used here, as they have the
      * same function signature.
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 853c4b2f67a..122ad9e2e49 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -48,6 +48,7 @@
 #include "internal-common.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "accel/tcg/iommu.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #endif
 
 /* -icount align implementation. */
@@ -659,10 +660,22 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 static bool cpu_poll_while_halted(CPUState *cpu)
 {
     const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
-    bool leave_halt = tcg_ops->cpu_exec_halt(cpu);
 
-    if (!leave_halt) {
-        return false;
+    if (tcg_ops->leaving_halt) {
+        assert(!tcg_ops->cpu_exec_halt);
+        if (tcg_ops->poll_during_halt) {
+            tcg_ops->poll_during_halt(cpu);
+        }
+        if (!cpu_has_work(cpu)) {
+            return false;
+        }
+        tcg_ops->leaving_halt(cpu);
+    } else {
+        assert(!tcg_ops->poll_during_halt);
+        assert(cpu->cc->sysemu_ops->has_work == tcg_ops->cpu_exec_halt);
+        if (!tcg_ops->cpu_exec_halt(cpu)) {
+            return false;
+        }
     }
 
     cpu->halted = 0; /* allow execution */
@@ -1061,7 +1074,7 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
         /* Check mandatory TCGCPUOps handlers */
         const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
-        assert(tcg_ops->cpu_exec_halt);
+        assert(tcg_ops->cpu_exec_halt || tcg_ops->leaving_halt);
         assert(tcg_ops->cpu_exec_interrupt);
         assert(tcg_ops->cpu_exec_reset);
         assert(tcg_ops->pointer_wrap);
-- 
2.55.0


