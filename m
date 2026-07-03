Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D830BC43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgu7-0004nF-SU; Fri, 03 Jul 2026 12:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgu6-0004lh-1L
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgu2-0007cw-MW
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:38:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GIa4W511014
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=; b=EOLUzR0nMLsSEQ6K
 H/fCPZl+piERbYUX/NqTX21+SPlk2r51uH2C/gQExAZ/FyHcqqgUQ2JHsJz5I+FQ
 v1/gGTbzjpEnaShCvqL/V4cQpEpC/uOdMoFraUIEXbyCUTbyw2k+wcfewkOovdHM
 W+eOdzQ7aEsgWtVNddKoY84x42/BAfWCAgxY2heqoNi2tp6K6N0svtSNi/65zCco
 106KVKeuGRdGeawhL1dRagxVm89fonBPs/gI3Aqg1FzHcyol4kUx9uAciL4+6LFr
 B47uI2q3YLmTpI50khmsDZGd6ixjHngpFthtI8ZrpUhuwV4YVc+ddQggT1/I8l+P
 AIaxfQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6a849k0u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:38:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e4f27f49bso58739185a.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096688; x=1783701488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=;
 b=TDh8wfUYBnqFmI6htWJ6ldfXKxA2jH2pm1v33JwsMkCFWbh8UdJw6324GDBYkIJdnv
 bPOPNw7M3EDwsc2gUJsxywaBgDlUtS1tkVYx9WNKA/Ljgta25urhw2Ll3TuVg8IDx7XZ
 /zHRlvWgNFm93WimyJPwSDPv+Mld9+t60ai5yRjIEklN3SY3MBjmVDILcYQSanF+N+hy
 lhP6xTGAxuFfucHmEWLX+0qG0kPOnlBceCrrCurAXlQHA7zSUFANLoxYoqAgF5tHyK7P
 qNccFmsCE3Zal+WyovELZ72eoIonaiqUCLl1bJRwKqx0yD857qSpGunc7ZsdKna5BKBE
 Tg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096688; x=1783701488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iximc+qBDNz/RyZclQJYcYQjzkTl/bbNgS8+O8OxcBM=;
 b=GxLNUbgRqOdrCPlKf9uapLhKawKW6U5XhjC8Y4QGgZlS0xTWg6c9FF1ow5V1GGCGat
 EUioVHzi1uX8ydq7w7mX5Pj8+gkUUdlapMeQX6koS6u9uGSwqcAWJfoWQIAX5aIMbqBO
 A35x+7f/uDTlJ3yisEsFRzmwayLZc5yUnbl4VNCGhsxzJIzeh8ARAYRpAeNjuNsvrvQ+
 NPdwxAPuAtN+HsKvHObXxzVS6d2FB7Cb9I8od03U9ezNv6XKSl7hOwx6mqI5bk5kPHKo
 QbgcY4OyDjZiKe6W9pKymEDCboRkOQBQNMHgqpbC9Sec7f1cA7aMafCazfFgr5PpmVMm
 fw3w==
X-Gm-Message-State: AOJu0YywoM1iE8ojVemavTqoxmV6G340rKY6bL0GquUHjcfZgxrcDhrO
 uzFV17eu+FDs5JqB73dx1k5IxudFreJWW7GS/K9CqsxvGwJDSVSm0q8lywhPVufisUZJVCePCJ4
 q8OUU05zTR4lldff/T//Uk8nMYBim3rVcqcYWB+2BYHbtBlIu3RrpOfXwR6BRNbPcZg==
X-Gm-Gg: AfdE7cmHOpb2dAAdUarwS5jBZ9thSDW2/8JZZKcVdWrrcjhNIeKDw2wdt+dxAQ0KYZU
 iRqQt2K9jNATQH6Bf7azzRqOYfan94i3AObzLhcoJrjVdWg0r2hIVMt3B6azPwGsqTKu/UwTofb
 d6bU0CQDyGA7Y9UIwXIehRbFz24uDCaXonyeg8kNzmtTpNE4aOMkAdDtlCMVLHy6xW9ncW16N31
 OqJXApSASZaLf4+zaC1ls+IM/00qqiYWDZbVs2fKmHqdO4emeqXR0Q3z2CtBTHXv8i1BLE19iUj
 YtZ23YZsQVZ7jynZSRwmnVteRnek/FrC+BfBaA6dlZtCyI1nrYTrog6nO+emKeAIUm+aGt1/Krh
 a3fCeKkDOC1Jd8tZfJJnG52h7JSlXvJZTikDdg5O0XIAJo55zqyfP4qt5t6cSwNGuQx4O
X-Received: by 2002:a05:620a:4087:b0:920:bc4a:6d9f with SMTP id
 af79cd13be357-92e9a3755b8mr29393285a.25.1783096687789; 
 Fri, 03 Jul 2026 09:38:07 -0700 (PDT)
X-Received: by 2002:a05:620a:4087:b0:920:bc4a:6d9f with SMTP id
 af79cd13be357-92e9a3755b8mr29387585a.25.1783096687284; 
 Fri, 03 Jul 2026 09:38:07 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm529133f8f.32.2026.07.03.09.38.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:38:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Zhao Liu <zhao1.liu@intel.com>, alex.bennee@linaro.org,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 01/33] cpu: Constify CPUState::cc (cached CPUClass pointer)
Date: Fri,  3 Jul 2026 18:37:24 +0200
Message-ID: <20260703163757.55500-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: aC0_c4xd2IJt69LOz276lA924IMmXsr2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX7q0oEA2DGnRo
 jh2pgrwt7gonvcmcKSuYckE5h36D995ioGz8Inlr9p+fGmoWPwX0aoUlbpU8cWpjKZUcRbHX/lH
 noRz+sM4j0ZHT5vxfeT9PHrNqsDHzFA=
X-Authority-Analysis: v=2.4 cv=a6QAM0SF c=1 sm=1 tr=0 ts=6a47e570 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=O_p9N0DIn41U_kaacwQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXzMtlK2Nsj8cJ
 SbrG7W7riZPaA7MjjiqxF2LlmYN53JWNKtCU+d1lBcaTfGI5PhaC6NCMFRtxz4IpqrP8Livnu1S
 R1w8tXH9YgAAIIMZL2Kd7c4AkUyEyiOtjF4MYbxh4NFPP+oJwL6qsvKNR2vdgbIUeHm6gfOehv+
 aZU98JRgU4Shav8PHhR3BCsMwnFcyFgnS0i/qi83MiixzPliyZng8go/figlrZnmC+fWiklF3fS
 BSJDsM6Jg8biZp15+U99HIQOzPvG/MziylKzPHqd0P64z2blFIGDgQ0lS1qb9/CFh27QKp3dTUL
 7zZZAIkEskMbfOXyeT5/1TSW5pAsB3OdtYvMqzvnSkgix0FWEkM0Rp+HfzZvFnuZkHobuNdw9DY
 LWGPeXWryrYpwhtT6Qy7wn07amS88EeEMvOmxy5+Jy5ZfKZZE7nlV0edpcrkC6Mq8pdtfXxd9v+
 YGu1MJRcQfXGrawv/AA==
X-Proofpoint-ORIG-GUID: aC0_c4xd2IJt69LOz276lA924IMmXsr2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Various CPUState can share the same CPUClass parent,
and must not update its fields. Protect the CPUClass
by marking the CPUState pointer const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 include/hw/core/cpu.h     | 2 +-
 accel/tcg/cpu-exec.c      | 2 +-
 accel/tcg/translate-all.c | 3 +--
 gdbstub/gdbstub.c         | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 59d601465b4..60a23d6f38b 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -480,7 +480,7 @@ struct CPUState {
     /*< private >*/
     DeviceState parent_obj;
     /* cache to avoid expensive CPU_GET_CLASS */
-    CPUClass *cc;
+    const CPUClass *cc;
     /*< public >*/
 
     int nr_threads;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 9c754b03656..d7f91dce9db 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -460,7 +460,7 @@ cpu_tb_exec(CPUState *cpu, TranslationBlock *itb, int *tb_exit)
          * counter hit zero); we must restore the guest PC to the address
          * of the start of the TB.
          */
-        CPUClass *cc = cpu->cc;
+        const CPUClass *cc = cpu->cc;
         const TCGCPUOps *tcg_ops = cc->tcg_ops;
 
         if (tcg_ops->synchronize_from_tb) {
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 3f1a3a28438..328d96aba30 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -575,7 +575,7 @@ void tb_check_watchpoint(CPUState *cpu, uintptr_t retaddr)
 void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
 {
     TranslationBlock *tb;
-    CPUClass *cc;
+    const CPUClass *cc = cpu->cc;
     uint32_t n;
 
     tb = tcg_tb_lookup(retaddr);
@@ -591,7 +591,6 @@ void cpu_io_recompile(CPUState *cpu, uintptr_t retaddr)
      * to account for the re-execution of the branch.
      */
     n = 1;
-    cc = cpu->cc;
     if (cc->tcg_ops->io_recompile_replay_branch &&
         cc->tcg_ops->io_recompile_replay_branch(cpu, tb)) {
         cpu->neg.icount_decr.u16.low++;
diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
index c3c944e965b..26366acb674 100644
--- a/gdbstub/gdbstub.c
+++ b/gdbstub/gdbstub.c
@@ -578,7 +578,7 @@ static void gdb_register_feature(CPUState *cpu, int base_reg,
 
 static const char *gdb_get_core_xml_file(CPUState *cpu)
 {
-    CPUClass *cc = cpu->cc;
+    const CPUClass *cc = cpu->cc;
 
     /*
      * The CPU class can provide the XML filename via a method,
-- 
2.53.0


