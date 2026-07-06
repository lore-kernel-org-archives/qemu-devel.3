Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08388C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 13:46:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgjdt-0006DV-6p; Mon, 06 Jul 2026 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdr-0006DN-56
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgjdp-00069s-E7
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 09:45:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666AxIG9391280
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 13:45:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FdZQ/hXJPnQHh8pxClBbjH2cf/RH4LMCCU4QJ17vy7M=; b=M2uq49UVvnz+E/MU
 cpBJq+ad0zAw6Q+p5MouZuQrAMiYSiE1SWMVMRJTEeWEgXhJBQW0G01b0dfKKWcB
 QZIwA1qrrLhTd9qYD8Lp5YJ9VxYj8i/m9hHem7HHspiJR6gIl2BUz8fg5NlZJUX3
 EoRo0BguPCqxwPsYtn7y9lc4IAksPOeIQsEg1hxpXuU2fxQT43tsHFSOI8DRroBP
 MQ9odcuntDdOa6D/0VUuFWVavZxf5+FiOD+CKbyqt/7SSCoxXIqz1rd0/CCi8+zv
 3rn/aeAuqPLGpIVAM44rp2b05kFdTKEnZiCtiWM2v9Yxov11wBJgE5LGb0nF/BBc
 rBqmGQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgs14k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:45:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92d1cae5740so350825885a.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 06:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783345542; x=1783950342; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FdZQ/hXJPnQHh8pxClBbjH2cf/RH4LMCCU4QJ17vy7M=;
 b=Xc5Q0ZfcHqO91Y3XZaiu9x5/Zs3WaEboQh7doCLByC9WgKVhPAUc9MW3GLETLW3VlX
 6rtUhivAJoL9JD5+w83P6ZM/UZyPp3nrVgsEfxMTKd+lqu3m5eQGfM8jkwwEVuOPpTzA
 X/DYiwavRHjNIhbuMXZGz4WOc3Q2BNeuZjfptoOM6gFz0EaROMHWraCRaLk5yK9cxz/n
 g6HK/P+DUYSMooNEebXhJWqC2owEHsCQvPxd3fKdJvX7i6eeCyohmQK8V8ewn/DMXsZs
 FOXsTaRlqx/1leNtJUH3LuI5+i3r/OCWqAcAtndDfiyrruTHMppfiS0pfS82XkXS9Noy
 fVmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783345542; x=1783950342;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FdZQ/hXJPnQHh8pxClBbjH2cf/RH4LMCCU4QJ17vy7M=;
 b=Jv4V6ffPLpppcAYLFa+UmhStEP8uJSRx9geTWjHGYa6lQ9lPbiYE1Evc012YhO7tDd
 DPPsnO6gK/sCDsUr5Ls1JiYKuhZ+FdgzjcKj1MDSDmLtJ90LpZmV2Ugkl2C7R89uu97D
 Z95aqoex5SQrseDPSk7+d6yMdh44EzKeHnSnu7grbC0e2ecMINqcV8e68Hf77eI9aHD5
 KyNWUublockJ67H6YPcrLotymCmFQkCUbYLnbKkS89PkjWIer/6qwF1UCCANxvlLC7cU
 tcEGQygHTBWg+2SD1d4VVizq8AXYrYhiqyYG2sMlY9D0r4RD6ARuyq+lVQgfvJS/Z9jp
 8/yQ==
X-Gm-Message-State: AOJu0Yzb/r8LTQwhUOZHdpn6XErxrZ5eO5hMieuM7C0Oq706uLCfJE+Z
 4tOxYj2FZqrjza42YjAi8iyBvgINqSedGB8MZ5E3nZCKjkkMUtAGsDdaKN6zejjfPDKcEdxnEJp
 tFA+6gp7toGLRCjq51NByI4pxU2/lu4dtRAY+/pQ+MzM2zUuN5hmHTVe2GMlCH4LAug==
X-Gm-Gg: AfdE7clb/IEi5QytJdX5CJ6CLAY7Ubgofzrkycxmw7qzDaLz5u89oVOEU0+JlgrRmdE
 sPlfJUvK27Oy3RdZcA95RUHOCM9CPQO73dEoB0NzBXdPGqkiBToAnBjONt3HdEVZgtkG+dEpblg
 SLaAlzp0B3V2CweBrj/7zPYP1Rv4M0NF77FtZA2KSFQi9dEzmKFDu6/dt/DtAWdDN84LU0POOwH
 YowvYVOkBintS5tqu2o7I26z2ZVh9rHEBTzqo6OQqSooUH90nsI4qgjygf1NxRRiSoDF04wdjY6
 kcH4KU7BrfVA8z9ouY9Gr27+geC+pklxSdxpeNYZwNf9V6W1fDJv2/RM1bY7ibgkfsLZcp7WDTS
 FJEBkfcDbj2Vuuqv5gxpnRE2dufFwMMUHdR12uaYXRqJoZlbOtCcQzjGtQQ==
X-Received: by 2002:a05:620a:440d:b0:92e:6d2a:776c with SMTP id
 af79cd13be357-92ebb5dec11mr79818585a.46.1783345542366; 
 Mon, 06 Jul 2026 06:45:42 -0700 (PDT)
X-Received: by 2002:a05:620a:440d:b0:92e:6d2a:776c with SMTP id
 af79cd13be357-92ebb5dec11mr79813485a.46.1783345541729; 
 Mon, 06 Jul 2026 06:45:41 -0700 (PDT)
Received: from localhost.localdomain (1.171.88.92.rev.sfr.net. [92.88.171.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493ccdb62d3sm310087935e9.8.2026.07.06.06.45.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:45:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] cpu: Constify CPUState::cc (cached CPUClass pointer)
Date: Mon,  6 Jul 2026 15:44:56 +0200
Message-ID: <20260706134527.84808-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134527.84808-1-philmd@oss.qualcomm.com>
References: <20260706134527.84808-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A6t35uOiR8emNq1bZ6oSDArVSb8D0Nbm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX9VNbOlsC930I
 K4vPu6xrMTX7vvL7a8AYwHKBy/qu6FQc4fPiWpERLp7LgT5qtThKtFXtk6KN6yIMvFmgWnxXiQg
 FBYABwJ1kp1Uy179HcpKaVsAPwW0H/pbSJ5XSSlUwaW8+MkK2YaKKum1mnmkPpWrOxW4eVMQITX
 NzqPFFOrPeuog/upy0JshpVf/b5SEUkqzRDHs8/rwwrVgltQasfm+k3EgbNcankAapwDQWK3f2W
 feII5Gk+R8uN1Cv3rYpGi0V2LxtIQKD38FqaIIHIYLnorZ75UbTzg4UnELRdpaOemlAgNV1rBhj
 badskLtI9+wnzCK/jdGqR2kGanadx7w2jYpYw5XRb7LPY7cE/wGACZyQNVQbnq8eHneCCoQ47vZ
 MmKnIpuOsb17nTQ65Kxr0yPsDVd72f+okF/udwj1+TDE19CHQ6xrv6HDNYLlm2k0NkaGGw0h5j4
 nJpJTpA9LWFkSMQ9MqQ==
X-Proofpoint-ORIG-GUID: A6t35uOiR8emNq1bZ6oSDArVSb8D0Nbm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MCBTYWx0ZWRfX26Ib3/3eOzYS
 Aew0tN8DFl+Kuly3mTRqCjQXpAmDetg3ZzklLOj/hxDrTDRmGFUb3a7wfNpGiUlJkTykwId3sZO
 cHYOdbz2WnlY+rGI66BJx5EK5JaJGDo=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4bb187 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PLEY+c9/kVlxBKEpvFYBUQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=O_p9N0DIn41U_kaacwQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060140
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

Various CPUState can share the same CPUClass parent,
and must not update its fields. Protect the CPUClass
by marking the CPUState pointer const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Message-ID: <20260705215729.62196-2-philmd@oss.qualcomm.com>
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


