Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75443C43602
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 16:40:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfgvr-0000DZ-BQ; Fri, 03 Jul 2026 12:40:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgve-00081L-9G
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfgvW-0008KP-KI
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 12:39:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663GJOxk477914
 for <qemu-devel@nongnu.org>; Fri, 3 Jul 2026 16:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YHmzSZVVsEvaI3vjx81RTf9QjIwrBBvLQ07wtGKj7d8=; b=FhwZ8krQbLMSh3Tk
 pWKUYJc8KXBcIBP8TB2ZTc27pK63NIr9G45KftBPxPRZTyk0g6Ab6M5nMQylPCH7
 sLF2fy1vU8P8G81HYJ98YVclPya84QafjsiVOi30weqlY5UpkhYUKlOOpd/peflg
 55nGjeUXgwCNrfpYJb1myBS1OKvVRgcL6c7AmJQ2LQpM0wkCoL7XxMWTPFm8mfIr
 igyo24E4bbtbguCz8x8UzeXAy7AOc6CjtSF64IaJR667skWhIelCgPHgMUX04azs
 onIKxjOHzjR3sNT0PmClXsBxKssna56BaUmVpWvRarYhnUgqy1M+GAIc480DyMtJ
 NApetg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f60eybx2n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 16:39:30 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e55721a8cso67762685a.1
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 09:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783096770; x=1783701570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHmzSZVVsEvaI3vjx81RTf9QjIwrBBvLQ07wtGKj7d8=;
 b=Puk0ARrSwFoHMbIIo/3pVv0Dq/Z+kUMAOCkitkGIJcjsPA4tE2v40WIgmDQYU0PO6L
 ipavBm4Wfp81bN9vYS1s4EaUPWe1gnkTbtdCyvUNlesuon5ir9StRXroJKZavoLSytmq
 oFq5BxDTYjjOwendrRB/3AnQ5ZBLu6Pjvy5ihVEyhUaEUJHl9V3XRQmHITDC4BKqvv8b
 Oelg7eopUr4gJSEdO2OLShN2EC6ftssGUu4DBh6gygWrAO7iuLm2rr5zOgEmQQ1/nEWv
 c2FOqft/JV5AbRcxGDjB8Qd7uc0YLgeB/fl5E5pFk7az7TbuaH45KGMW9Yl4gY+dVX2K
 MNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783096770; x=1783701570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YHmzSZVVsEvaI3vjx81RTf9QjIwrBBvLQ07wtGKj7d8=;
 b=pJRxewxRUdpPRRafJMIvDWZ3oD9HQnNtYVuu8FQZREH+sXa66UZ3/HbQ1mxhQvGDpT
 N6fLZnLqimkahBcac8C6YMgVoM/q1Nnc/sWVvNdyLVGPSP8wSioX0Bxu3vUmVsWl7moI
 EQsiRdegQOHV9BzNRWTEBfzbTa9ot/SIxiWd0RrTJVucSpf96uYbN+S6syms0qWoNGE9
 FvMjppfyQywrJkt3HRLGedyfbQWVVZtTzJvdnWM0cmZ9qKIeGeGIDG+3fNPcpuIHsGR7
 uUq0qDzWXVtlcQfWdnLnX6sur7iiG8/jxYHjLqoyTx9fSLEEXKu0+HRJyUrB8QlkU4Sg
 1MPQ==
X-Gm-Message-State: AOJu0Yw14vuundgEfxLDtY6Daon1p+VSXpNnhoHFqqAgI0akg778noBi
 VqzcKonfEgIgEY1LLsvbmPhH9odc0y1ZWThDyJcbqIR1Fa5AptnYh6xOm+L7a0LIg302mAXvrJG
 x6+ItWwm2D05DMVnGZJrdHZGgd3biuMa0qCFPHC7r+kv/rM2pBIr+cSNh/GVatSXlZg==
X-Gm-Gg: AfdE7cnf/YsHcQj5JYeJtMqKggzfWpA+qdoNik3BVQwb0/Dl7rA9HzAD6XlIXMBRKYw
 xeyw9BvW6J2FqCeuxdMDF+Ur4CbLrPB7IRcW4Ndjvk5pEfSyOMJEFvjs3x/h71LgVVn98/jO0Ne
 lHIlz6Qns5N4a8ADQgPNzi2hzaGKdbp+359VPv/0oUzjC6jT0hvsNtW0GKdDo1P4EMWJ3YhGyG1
 TXbXDjRVf33hAbN18yDpZnXR+xqEM85mlSyOWtKQonTjwa3fn/pY/7n0KssKjO/Ko03rWeKXXvd
 xaRgQ5ug+QymctXlXoe3aE2y+etQb3suVDgaeEFcl/0XHGDFWyeoPfhaifeILZN1Q/lfqE8g4dA
 ke+60vGYsEYRj90TSZh/odyW2InuMuWoN58vrzc4snk5Bf7a5pAI26V4GgLaSzAkM5DUp
X-Received: by 2002:a05:620a:8399:b0:915:afa5:754 with SMTP id
 af79cd13be357-92e9a3133c3mr33826485a.2.1783096769817; 
 Fri, 03 Jul 2026 09:39:29 -0700 (PDT)
X-Received: by 2002:a05:620a:8399:b0:915:afa5:754 with SMTP id
 af79cd13be357-92e9a3133c3mr33821985a.2.1783096769364; 
 Fri, 03 Jul 2026 09:39:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm520025f8f.30.2026.07.03.09.39.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jul 2026 09:39:28 -0700 (PDT)
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
Subject: [PATCH v2 12/33] gdbstub: Inline gdb_supports_guest_debug()
Date: Fri,  3 Jul 2026 18:37:35 +0200
Message-ID: <20260703163757.55500-13-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703163757.55500-1-philmd@oss.qualcomm.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfXwKDHh6YRBY+l
 PV63M4X+jhuFLIsbkPwcfIbqDNKUHiOx0j24hb2/EuBCI/PIIVewrWFXK6duAij31n/v5A2pRYu
 iwITkcpSqds1XX/jMHNNNeK3wDzU6JnbndXROeLgQu8u2Laa4RksFrLAL58iUbEGGjFXHa8lYQu
 DSsV9WF9thWpUK4qFbIEp50bCWvcp3TwkB2USJgNgYm62Jz6hSx1KCiTisceBGuj/d2zmeK3hvb
 VRilrZk0FQoP4bfmwMm+BeJKA0GCQF0kIiPiyh5tkQiLTqRDCDOwfcZeGyRQSJ7EYaaRwTm2A6F
 2NhYYm+quqdPQ10C3c39GaAKUTvyily531Iy3+0mmgjmyketGUDZW99J8nmBwW2HsT25gLePqdX
 a5Or56temy9eREXfHqWXAm9A4qsGeq9EIsT5EjJQBSMqCFHSDoXRo6upqw5iIpYqoZd/yf7Sj3s
 w2YN3iEmdjdTVlfM/fw==
X-Proofpoint-GUID: aA_ah61wr5Ob7uGoP9XMtledgc_t1_rt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDE2NCBTYWx0ZWRfX1OkjN7AejTbJ
 KdBc5Tx/W+49XtBBPghUq9XJZxqGgtJlhiF/Oo8Qedk+UZUEeIHHxgccA3NB+XBCeAyuCuNOD7l
 UOSHHWgs9OUFJVrRnQh0+5UIBMjOHNE=
X-Authority-Analysis: v=2.4 cv=SPRykuvH c=1 sm=1 tr=0 ts=6a47e5c2 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=mZCV-s_RuDa5I9ykUf4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: aA_ah61wr5Ob7uGoP9XMtledgc_t1_rt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030164
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

gdb_supports_guest_debug() is only required for system emulation,
inline it there and remove the user emulation variant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 gdbstub/internals.h | 1 -
 gdbstub/system.c    | 4 +++-
 gdbstub/user.c      | 6 ------
 3 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/gdbstub/internals.h b/gdbstub/internals.h
index 9b25bf58b8e..60ddc146661 100644
--- a/gdbstub/internals.h
+++ b/gdbstub/internals.h
@@ -217,7 +217,6 @@ void gdb_syscall_handling(const char *syscall_packet);
  * Break/Watch point support - there is an implementation for system
  * and user mode.
  */
-bool gdb_supports_guest_debug(void);
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len);
 int gdb_breakpoint_remove(CPUState *cs, int type, vaddr addr, vaddr len);
 void gdb_breakpoint_remove_all(CPUState *cs);
diff --git a/gdbstub/system.c b/gdbstub/system.c
index 2063b63b2f8..1179c82cb86 100644
--- a/gdbstub/system.c
+++ b/gdbstub/system.c
@@ -331,6 +331,8 @@ static void create_processes(GDBState *s)
     gdb_create_default_process(s);
 }
 
+static bool gdb_supports_guest_debug(void);
+
 bool gdbserver_start(const char *device, Error **errp)
 {
     Chardev *chr = NULL;
@@ -627,7 +629,7 @@ int gdb_signal_to_target(int sig)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
+static bool gdb_supports_guest_debug(void)
 {
     const AccelOpsClass *ops = cpus_get_accel();
     if (ops->supports_guest_debug) {
diff --git a/gdbstub/user.c b/gdbstub/user.c
index 97eb13e796a..f7bc4e63dfd 100644
--- a/gdbstub/user.c
+++ b/gdbstub/user.c
@@ -796,12 +796,6 @@ bool gdb_can_reverse(void)
  * Break/Watch point helpers
  */
 
-bool gdb_supports_guest_debug(void)
-{
-    /* user-mode == TCG == supported */
-    return true;
-}
-
 int gdb_breakpoint_insert(CPUState *cs, int type, vaddr addr, vaddr len)
 {
     CPUState *cpu;
-- 
2.53.0


