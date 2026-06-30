Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0AECC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 22:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wegXh-0002t5-7c; Tue, 30 Jun 2026 18:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegW5-0002So-Qa
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wegW2-0003WU-5O
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 18:01:16 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UJDalA2948483
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BV3Qij8EC8HKpY66szPIpqeKiHQzHVd80VSFDRIdzxo=; b=T8uWZARW3jkobYyv
 86/iBQ5uoy1qy8t27DC5NJ2v95Jau/msqwekOfbnCtFjWduUrUiTovAt1rSoWDeZ
 y6/oWLx4f6H++Qr/KNAqNOcoMeKEjwVXT689L87djojfZm6YQXSXpylcUVFOLAEg
 y0xb7EQNVa0RiXnG4g/E+IkYfii4pD6XgvsnCl7yn9LFFxG8eGtIJ4s+o2M0pcIS
 Wz6N+UNbjL4JvrD1vDNyr4yHlXWafQM+XB1aI3KZhBiyb/+ymE8UkDr0OKHzkEFT
 EKeR/sRks5yJGxOBfk8qrJ6g2P9l+Nt5lGiRd7W3VhTowH8ODRQn3breIv1AYK6z
 qF7OAA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw0pqb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 22:01:12 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-9692ca167ddso1086277241.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 15:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782856872; x=1783461672; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BV3Qij8EC8HKpY66szPIpqeKiHQzHVd80VSFDRIdzxo=;
 b=SZC8koXhRxO4L0LLkm5DvRZOP5Q07h9AQgSvSgqELRvNyo6IWnC8MnOvLHpRCIZcS3
 iyEw2RZI7lYECot8hrcM/UlS6Q/JCJN1CMwAI+3AmIasUbhkmB2ql1LZBOjv1iVUwARR
 EPXFJI0DBcXtYumMY6TS6aPeW179GjMeoEXHpaWtlRqYS0qPBFywL7KEw6F88hW6nKve
 +1FrwCZ1kPKSafCY+rYbQ/vMZirfSGm5HzSlIHOOevKA4197oY4AbpP4g9n/BPW49n3g
 nBL3qfz3iPkAc0+yoEVbwbcLXjEIh9i44qPe0rLnCe9q3ThA8CeMaRf7HHB8fzuWEyQ+
 Nwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782856872; x=1783461672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BV3Qij8EC8HKpY66szPIpqeKiHQzHVd80VSFDRIdzxo=;
 b=YexoX88SpcHuIPoQhS8fO0gzZRi6lc7Mt1XXNu/VhTErjBtX0eECHUHfdrKnoCH79M
 U3ygA3TXwPojUUp4zNX7QlA8V4zVcv63iEPi9LYKVYSLuClcqliRevmwdxnDzW2j7/OQ
 0L2puoCdqj/Uma0dB4dilNII4jSYIqe3mNNbJf/lDuNf3RjYhl92hy3M161N58AwQx88
 +bnS7p/qpsWJIE8wNmhoMbnxNdHQoDNwrokrZltlYFSjBGaP9JmDt3Ua8l/mOARAdMRM
 iPTBXsSMZsBXg79E2NmSqvJx1ikzBEf7RWD1S7SyNqx4LDKZqsiIkDPruFGwE/mC/kLN
 +aGw==
X-Gm-Message-State: AOJu0YzacrDpA3dD7FYBNFX0MbVYzMsDOr0RKTyUinfab4k68Teh9Csk
 adTt0Nsw35YuKslGwCbCQkgsMUJwQvyRXyt8gnVyKOfMtGBpS3uITKaCW5VgwtmuFC0l36Xfvxn
 I+V+CkH6PeFiqlzjfJCV4eVCAdLegDACEVz2qzA0zsXyqI1N9a8r/acXyJDALW3AFDw==
X-Gm-Gg: AfdE7cli/RdqXjBMOZNtdvwaipm+IV7HEPyG3/ZHRdlaXbPwgxOEpFhajdWSFEMvLA6
 1ADOrD5iSxYs+ZB5C03ViqdbShHFT37lEmeahnkA39rsqjWcACIm6M7hQkZb9lFxVehM2SALEqn
 B+xNZ76x+a6BNc2t5cwdd8dGRlaeBESNmSC6NRIbX10auLqfqQeOsAUFkZiNITjBezRySSc1Z1w
 2GmUqpJsz0ps/iMlov4mqd+2/PFByVdrwzRXse+u3kM9MlkvNCAzi3/MOEDmyj4X2bRmCv0S4Yd
 aBPx2OXpBHVxi7jzf7g8Kb9xy159dIQtjj1nIiJPt9QQssUO4uJqbQv/OZAzGIb3utdpdi30IyO
 Kf0Ty4WNxn5m3yrxCvNQMFsLpxdK/0bOA8IUloWDcaqDxkd13j+t4U3CbAjMyOpatlBc3
X-Received: by 2002:a05:6102:644b:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-73a35ff40b8mr2328058137.4.1782856871556; 
 Tue, 30 Jun 2026 15:01:11 -0700 (PDT)
X-Received: by 2002:a05:6102:644b:b0:6d4:ba3e:bf97 with SMTP id
 ada2fe7eead31-73a35ff40b8mr2327993137.4.1782856870920; 
 Tue, 30 Jun 2026 15:01:10 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cf1asm12147563f8f.18.2026.06.30.15.01.08
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Jun 2026 15:01:09 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 01/33] cpu: Constify CPUState::cc (cached CPUClass pointer)
Date: Wed,  1 Jul 2026 00:00:28 +0200
Message-ID: <20260630220100.1289-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630220100.1289-1-philmd@oss.qualcomm.com>
References: <20260630220100.1289-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a443ca8 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=O_p9N0DIn41U_kaacwQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-ORIG-GUID: jGeWFDtRW5Xdnyj-Lbws5_f02n-M6l8J
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXz9lQ1Uxre5mc
 /LrKJEQW2DARF9Qx2rpiTTgCEXwTpHJ62ONfNR4T0OM/LfPEmw8aKZsRZeBx3oyIpk3JiM964kd
 8KXqDdyJ+XtWXx8YCzCChqlpocKkyIE=
X-Proofpoint-GUID: jGeWFDtRW5Xdnyj-Lbws5_f02n-M6l8J
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDIxNCBTYWx0ZWRfXzXzprp0LMju+
 1jWKz8QJ2uZMAwqq/4sOuMKSVi5qyvgLMVU2Ezyqr/WJkdoR3PvCEEkoTKbL90aJ1oQIAV/MJmD
 dboSSrVTCd4eKlIWlumZKmqshz/ffdkWlwEDXYjqCD0XwJSDAB08MvBgKycgpWU4H/PXQ4LU1bD
 kfvswHgFohlsUjKI/cbWYFvbk3mO/ClWFYWtzqxKxyo4hLhGwHL7m6lScE0lDaxEN70snE5JeDY
 4yKltoWYfPDwIexZtRq0b+sCQttbX0nNrY+hNKrLevWeMRkUcW07QTvit0RNXgu5pfpIh4Ws7fe
 5tAsSME+s0qbV0snIouXOYFJurjTsi3aApMjrqJnvOP0Mc2SLDYBFBtXRUfO5Ld2NjrcRZdrnRZ
 0WoOXX5lj5XiJQ/ZUI1ZE5QKclMQlOGg8bxsb7BdVu8RhzbwOnulck0x/hdYvbfvKQIwPGUvuOO
 g15nAoew+E6wmBqebrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300214
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


