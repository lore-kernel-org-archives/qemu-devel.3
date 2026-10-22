Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F13B606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fyhlO2pt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C5yNsKzg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hv-0005br-83; Thu, 22 Oct 2026 17:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hU-0005W7-HI
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0hS-0007Sn-TN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:52 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKutmc792321
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Pd9kWAW3Sk6uFhz5XkighXmfH/Qo/vqEvwy+a+nwB4=; b=fyhlO2pti5wTlBxs
 zTgxneqHjbRB8cbTnNNbwTUruG6WYYUpdSMQTYygIxY5V2Bwf+Yp+711k8mxFj6M
 MJMcUeqLYtpMr/SoYEn+snAuhCarHDwDSf9vPuoIX0L0ULi/UoqoVHfwsObHfy1A
 ur0hMHad9GPuQ4EBifH2O4xGSba+46ycCtL/rwDbqW4M1o6kpRwzywOsOODgQzCA
 KwXsEMFxXltiSAtDnlaqNqtb8BZX2usbOdKWtfynYWipKxKFYoHPEVIHehJKectD
 9nCZKUpon6jnECBMyjo9YeUEmw9aX9i8LvdDTNy92sHg3BQFelbeYK6emNT4T7ll
 RNHfmg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsyk8595-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f2005ce21so44027985a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705908; x=1793310708; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0Pd9kWAW3Sk6uFhz5XkighXmfH/Qo/vqEvwy+a+nwB4=;
 b=C5yNsKzgsayUb94uD593R+7LlQqu/89x9Nah0u7s6RT+Lnq1gcFzXTll1uzKNgDHXc
 RwldlvLyfyM+2xPJksVOlmcft7S8AQ61uL6XcOSVCzuPmUhjLToB65JQMsINRCCjy3Bz
 yWbegvUL4a3AP5FzH8fiYbcoay0m1F4MkSMwQXdfp5zsEtFpQT8bOZ+lX6hwsm9gxeON
 ncdqNrv9RAe5J7qio6SWWDy0MOTMl6admST3+EFsGFwLzNVIWrZWb1idnazGSezXc0lO
 HadAppKpd74bVqqrcdqtVbsy7law+3sudrNb/reo97qUE8XM+hBl3UQpTuzf8PH5lPLE
 Cckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705908; x=1793310708;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0Pd9kWAW3Sk6uFhz5XkighXmfH/Qo/vqEvwy+a+nwB4=;
 b=L6zfMBOjRddidiAdctJ/TuTqGRk5A34/PP1nBTVPAXyD/PaHVKvyYRxfQGhabcCEqU
 S+aQHzByZ7I7jWMPTg+1gKqCzUj2PKqv3MhfJOfecPzFo1mvN0tzH5ZC4+yEOBqb3vp+
 AbT2Dlno/PnuWmsmARv9Qeu3ho36aZlP58idlVc1Tlj8X09cEpvgTNrxM4tVPzyi08CV
 i3Lsyk4G3+rdsiHgkGdPuA965w55pWICyOT8NAGmEm4YzhBXvpEhCOo10zahinEOs6Zr
 n1DLyA2ZkLBsYXTCO51fV5GTbbb5oCPanXmV+yecYqJyw4VCpi9A0Go/dCLGy7ZhZrp5
 7vLA==
X-Gm-Message-State: AFq9FYI0gWlwgf5u1Rpfzc9rA3M7q4K5DMPxg3kQsNkrd1mzK0MFoT7R
 MVNPQWuF49VxjmatlvFvaTnfgjyrLZbf5fZK/P/ifTqGsSMgL5mxuZMxoOs6LZEOKdzc0823rl8
 3qfoSWcGQjvXrricr85qJqouKUkVhAomaI83wkVCKdeglHUW083gRrXDAlaEEM4H2VQ==
X-Gm-Gg: AYBFou0w4ABeD37TAy3paLHZOFZ9tNnw8u5k8tq/E6YoLGfyFAGGFW16pRXaDMtujBx
 H56IehQH6fXVMpDzTZTNdUCk8wlPTsNTAzZ3EcECo4c8NR2gXctSbCrY4hGH9Xxh1j27x4IzBqw
 BbQljUXvDgcjllAhMVFARXZkRpiI/TEJXJ4Dnav7GrY9MTpOMtbP/6bhGEgIy9fBWe/GCyKkzOm
 LwJo4gKN9AE0nbx+BUV4o8SRA40zI+0Nv31YvmtfaKhO8YdHFxYdxL0YbTH+5RWT8ceo08OZTbU
 A51DC8G2uQ7dFdSSxaKY3G1FKCiGs02Bpj87HET357DQgTT+ndvc/H6nwEVaiGGdLeKJ7cMD7v8
 WLLZnZc8rxDL1cwkC4RaPDHZl/y8w6LcTtaDSmNf0
X-Received: by 2002:a05:620a:284a:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93f6f972914mr136490985a.47.1792705908335; 
 Thu, 22 Oct 2026 14:51:48 -0700 (PDT)
X-Received: by 2002:a05:620a:284a:b0:939:6de6:9518 with SMTP id
 af79cd13be357-93f6f972914mr136488385a.47.1792705907845; 
 Thu, 22 Oct 2026 14:51:47 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3804450bsm659018f8f.30.2026.10.22.14.51.45
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 04/33] cpus: Introduce CPUClass::exception_name() handler
Date: Thu, 22 Oct 2026 23:50:44 +0200
Message-ID: <20261022215115.19680-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXxt/Vv/XgRUHA
 4SallJGkmBhieLIxxgwn8I/chIQDRm0QaFPwpBXLg4MhNFrN7apV9nbpZfE8P0BfTpF1tfivE9f
 RLqjnyTzRZQEW8wWgho9HPoMHaD3xsMYmwuQO8aW2KiPbYYhpy9vlIjAn3/DlHWnSnfLFPanNNU
 7PDP8gWdP9/GHt/1XuE+ZYUJI2yv88m6Kr5lb3/3IE/JbyT3xi4im3g4Ks2iUsAZD2qyEz30+s8
 cUDURzutaY5ZdC0yTIOTLvCxn8rxLDPAusxImPJRT9S4fO0E1u9DTYhf0z4PzCEmQAwVqgSs01J
 oF8B+57lMCQS/bie9hlxLNOIdBR5PgtACE1+BYq2ACxWJqB8KzqDa7R4FBNzjD/Q+xUZ1GUJaV4
 bMr9YwMboRz92O2YxaEUClu5geAbYkgSoLj2uQAWjmOM2YlfbMopteDDDc2FUUKCfrKgODEa4wa
 Or/wSxmEUztroL5vDDQ==
X-Proofpoint-ORIG-GUID: EKoudxc8YZ4VdlEDM-gxGnCW21Hukdtn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX07CPepxh+DuD
 bVFrbYLB/sdN/l2vtP15fjW6otHfWxetCSuBPHs+swyzoV5Zb3KPEBdoUUGHNAx4IWvwc0hS3EF
 KQcPR4t+fp2tX0gjECjSaT0U8bhW+fg=
X-Proofpoint-GUID: EKoudxc8YZ4VdlEDM-gxGnCW21Hukdtn
X-Authority-Analysis: v=2.4 cv=GLKdgeNK c=1 sm=1 tr=0 ts=6ada8575 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VFrVLvhLpLwouTeFobcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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

Have targets register a helper to resolve their exceptions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h       | 2 ++
 accel/tcg/cpu-exec-common.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 456154df6f6..9d71db16d2f 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -108,6 +108,7 @@ struct SemihostingCPUOps;
  * @list_cpus: list available CPU models and flags.
  * @parse_features: Callback to parse command line arguments.
  * @reset_dump_flags: #CPUDumpFlags to use for reset logging.
+ * @exception_name: Callback for getting architecture exception name.
  * @memory_rw_debug: Callback for GDB memory access.
  * @dump_state: Callback for dumping state.
  * @query_cpu_fast:
@@ -178,6 +179,7 @@ struct CPUClass {
     const char * (*gdb_arch_name)(CPUState *cpu);
     const char * (*gdb_get_core_xml_file)(CPUState *cpu);
 
+    const char *(*exception_name)(int exception);
     void (*disas_set_info)(const CPUState *cpu, disassemble_info *info);
 
     const char *deprecation_note;
diff --git a/accel/tcg/cpu-exec-common.c b/accel/tcg/cpu-exec-common.c
index bd2cb9d6311..4e5e69649aa 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -115,6 +115,12 @@ static void log_raise_exception(const CPUState *cpu, int excp)
     if (excp >= EXCP_QEMU_INTERNAL) {
         qemu_log_mask(CPU_LOG_INT, "raise exception: 0x%x (internal: %s)\n",
                                    excp, qemu_excp_name(excp));
+    } else {
+        const CPUClass *cc = cpu->cc;
+        const char *name = cc->exception_name ? cc->exception_name(excp)
+                                              : "unknown";
+
+        qemu_log_mask(CPU_LOG_INT, "raise exception: %d (%s)\n", excp, name);
     }
 }
 
-- 
2.55.0


