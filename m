Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC1CC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 22:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUuc-0004ki-PT; Sun, 05 Jul 2026 18:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUu5-00042F-Ni
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUu2-00016u-56
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 18:01:32 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LxM4k2646580
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 22:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=; b=mHpW7np3oGRmql4u
 Fw5zl63H6dXrBLR2iq4c5dtYcRZ1h+TPlrW1ps1YFmph0GlT9VpK8RCoMfaDliho
 Nl8U2ZcF/F+lejFeKNnoZofWDkDI2z3PLpWru+hjpCXoRZDyPDv5vPDRlI8nsAZO
 uaJ4t1L7u/Uy0916hXoTkC5ZuC7dqgezNNm9B7UsDYTx/tXYFLzRdBS7K6rWHkpe
 Z1ZXgkrg2dzOfzsHjz8WzoPrWPCLVKVDOUkFZ3v6d/qe2i8SHXhgpeSZkdC9Y2BS
 CEKNSQhFp+bzGi7DhuRKIV20Umf9LAeuY34YIWQPkA1JS2fU63RL7RBa1RUdnF9Z
 Ogm1PQ==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgkc6p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 22:01:17 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5be1c53e800so1762183e0c.1
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 15:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288876; x=1783893676; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=;
 b=XzCUxCU9/5D7FTRyHzaUh6sAvOoMHripFmp4Eb38rP3Cx01ZIK1m8rNx36K1jPU518
 729tjCel/FLFEQAsS+VKg2nn0S6Bk6FkuMVAcgljnHC376XiXYPyn+EszQ2L8AwCY0lK
 GTtwetMhQVUo9A+5He56MqKuuy00hv1DyeD2udEwDvvihon+3FrWsI6e6XSVuE/9nkpc
 zppJlzeJ0u3ZZTi3vyEhvSeK2SvyEAKcU6u3UUPIwgYMNnB7RqCN2dx2TwjG/fN93koo
 3Oy1PbI1nbEmmazm2F3By2KgfUvxEu0tTq6tjJjz9X2ziCX6g3sFhFxVsk1l8upLEkpF
 xAFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288876; x=1783893676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=euJn44qDWZ2TcdTti8/aLCTKwbg3pgDFPtWDEjD8jME=;
 b=tNWMhOTr20f0yeaqp5WSEzqfkypiCoqZ/aYLvr0WzdSxm4zZI52h/9aj3x9ce/0Hlo
 r/pq33b/3E2kUAt27Cn1NupwewTJk/uU1n4r9zjq5YR4ZZC0OPlE2SWbqKNlmqYlFDnU
 3XCbjlOdAX0reeADsQlgPaWYHgnQT8q55X4G4UPBQh1cwGmhKBro2KEQk8WBPAxG9l+d
 pgUOC9q+UabO8CJTsstnj/cHGusJ0DWaH8zqBcsfWZ5EzMEwrfc4SbES589vQY1Gv4Y2
 P4ofPpd0Y6Y4v4rW2cXuJoecNzeb85cRDQYYZqDnupd0VYlAqJ3Z5Jcbfs1fBRLJoXQ0
 QGug==
X-Gm-Message-State: AOJu0YzAOCuMjNbTbHb3QQD9RAbTdqpdUWjpBB2x9nwOc5kd5ykbhPqF
 TnHIzObLPKFD4mtCBq1VWIVWbteI0xEdjQipx26bgG3aONxDH+7VFIde1BhhN4OndNES6k1T7dy
 TJ3Dq2xd+NyLL7fEJR1FPpMLwmqM3HEsB8Fi3hGIezx3Nza30iBoc8r69kh0GJeCxGg==
X-Gm-Gg: AfdE7cltYuznsBho73eykySokm5s8Ln0Kl+w1ckqn3IxI8obRCZ3llNNiCx2W/n5p/6
 YBfdDtsTE/uYFNDjhBFyLGNMU1kbRa0mvpfE593L/0UPFuH+/53klsclLxTY9aaBiN4MEGQ3Yqx
 7ztIB5LczSes58+9UVWRCc425nLclaeHy3VF3WbhtLicF3S9o7B5yeQJt4NKeHw10b1GTYkQykV
 9ufw2RXBdFE3fxuC93xkUC1Q7GfbtLcddY3JxlWQvXQB2Bsq1LFUpHiBE9tcL51d3OQ5nLFxOpn
 jAaG06HSa+JFeDO0JWsecikuUPtwxSXEr70FBzA2b3U/FzuN13skjzwwAFP9bmnzISrAvHJO/EE
 mDkbtL8qVZr44fu+rU1BCLsigLvdHENFawwNV0tOAgOIQfhhdE1zbW4WtASoXAtLOdLoM
X-Received: by 2002:a05:6122:e267:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5be10381c7dmr2612930e0c.12.1783288876575; 
 Sun, 05 Jul 2026 15:01:16 -0700 (PDT)
X-Received: by 2002:a05:6122:e267:b0:56d:451b:e4dd with SMTP id
 71dfb90a1353d-5be10381c7dmr2612883e0c.12.1783288876158; 
 Sun, 05 Jul 2026 15:01:16 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d843csm18354071f8f.14.2026.07.05.15.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 05 Jul 2026 15:01:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, alex.bennee@linaro.org,
 qemu-s390x@nongnu.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 29/32] cpu: Better name cpu_single_step() trace event
Date: Sun,  5 Jul 2026 23:57:25 +0200
Message-ID: <20260705215729.62196-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705215729.62196-1-philmd@oss.qualcomm.com>
References: <20260705215729.62196-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX2QJD2ZwG4H4g
 Lf4ebr5DhG2CAIwPnoLRjO+QyKTrE30rZjCK+rRt2S7pLd+fh3VJO1+C1iTGPB8I4B9Rl+l+QN/
 Yb7iMsbvPRUwp9RRQ03/2jwoMFttZ7E=
X-Proofpoint-ORIG-GUID: I2bWXMdAsVwX-11-uaV_ctls0nllsBD4
X-Proofpoint-GUID: I2bWXMdAsVwX-11-uaV_ctls0nllsBD4
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4ad42d cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=fWCg92Okmkq_k9tJrKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzOCBTYWx0ZWRfX5XTJL4Ecj7UJ
 uUdTZRU9Pmp++7UJ5MfQUCwVSl34qywcljzmskCmA+uiF15ygp6Y/bM2bdePpOOycTaC7Id+9FL
 KJcbkjawSNQoqfv4Y8voNP3pFhyDkoTVLe+OaRQ3OxF+9srrxEjBkrxcvRHGq44r1Ya7AvOJlwy
 TNzE/z9N3SuMCgB32n5k5DLAba9IArGiBaYrAJFm+1mEVT86xKuxoFuHv1xQ3OiEDZiJMirwHxW
 Z/5gi2x9YyXsCltiwsS2lOc09I0ZFe1wzmHtzitornGL9LDQdjD5lycbAsyF9a6tCW0kDYhvAs9
 NRlvv5GgEseR9wbNKTCzBV5htVhwX9wfBczT3Xz41aEAFCHewThJ7rxmvbQw3Vtnc4KhbpsiOjs
 YW44VRyUvYLhSV0HcAFt+X4WIzGoUYKUfWa0f5iL8uXh/zdCmKF6Pe57r4X70ahKEb8m5DuLQSH
 lFXHjS4r6+Rjtpmm9ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050238
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

cpu_single_step() is not related to breakpoints. Rename the
trace event.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 cpu-target.c | 4 ++--
 trace-events | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/cpu-target.c b/cpu-target.c
index f030e2c642e..019906b32eb 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -31,6 +31,8 @@
 void cpu_single_step(CPUState *cpu, int enabled)
 {
     if (cpu->singlestep_enabled != enabled) {
+        trace_cpu_change_singlestep_flags(cpu->cpu_index,
+                                          cpu->singlestep_enabled, enabled);
         cpu->singlestep_enabled = enabled;
 
 #if !defined(CONFIG_USER_ONLY)
@@ -39,8 +41,6 @@ void cpu_single_step(CPUState *cpu, int enabled)
             ops->update_guest_debug(cpu);
         }
 #endif
-
-        trace_breakpoint_singlestep(cpu->cpu_index, enabled);
     }
 }
 
diff --git a/trace-events b/trace-events
index faeba6242fa..ea1d2b11a22 100644
--- a/trace-events
+++ b/trace-events
@@ -28,7 +28,7 @@
 # cpu.c
 breakpoint_insert(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
 breakpoint_remove(int cpu_index, uint64_t pc, int flags) "cpu=%d pc=0x%" PRIx64 " flags=0x%x"
-breakpoint_singlestep(int cpu_index, int enabled) "cpu=%d enable=%d"
+cpu_change_singlestep_flags(int cpu_index, int old_flags, int new_flags) "cpu=%d flags=0x%x -> 0x%x"
 cpu_exec_start(int cpu_index) "cpu=%d"
 cpu_exec_end(int cpu_index) "cpu=%d"
 
-- 
2.53.0


