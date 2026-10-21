Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830FB607B110
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 03:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XJ0SyRc7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Jmk23Fl/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJMn8-0002pf-MD; Tue, 20 Oct 2026 23:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMmt-0002gT-Ll
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJMms-0002QA-3f
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 23:14:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L2Eu3q3469268
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HJHtdVy5wVxjfhiD2204eyvZWcyoZdZQUrEb1ToGTMw=; b=XJ0SyRc75PL9B26I
 9DRVFMCLNzNkigtjSeuveIqW0wrfhRZqXRy2EI0WU/QQpeNgAus/4Y0gT+S1Bk9d
 2NfoX35MJdBet1wnvkuvrJ1dLn4eMyf+vbqtlHCUY+XxS7++hZ2UpFQSo618uowN
 FDjb4aT/q9JPJVqHOrXkMHbz85U5/sJOlMBw9SPUpmwUtmmqUrvgJJE+u5Y6Nwef
 Iqd+vnr9L5K7M0dvq/9YcW1qkOvNedl67xjQ0Kt8VHWZkxjnqYneho0SaZR5RZkV
 i1wJPtdCorKeIWS6/hkwcrrelvrDKUUhu4+FHDbFoCWXP9iS9vZpobuGzJOQi8Db
 xoj76Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2ba43-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 03:14:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso40465485a.2
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 20:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792552473; x=1793157273; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HJHtdVy5wVxjfhiD2204eyvZWcyoZdZQUrEb1ToGTMw=;
 b=Jmk23Fl/cpG14cVideIl7m5Xu0FGzcAvzYPCZBt785Qgyz8BPYwBEZ3rGXmF/MuEiT
 VdujIQwqpDvHsVmsh6k8JS9qK7Fotv7lJqZParPQSna6e0baOjzSg/2a69hP31FODJRM
 YSwJSf7pSXkC2NYEFzpnDEXFPyWZRVl9rvBHBWihFN3n+O+X2KS3ekRqYLJJRS3AxDyr
 XjtXgRFfE2opHf0t7M4VT6pjDEWHdoBAcHDRWa08S1nul56r6R6nRFC6Hv8vIEKbfuSV
 HeKUb9CtVXywPnHVD/XmIOGTtP9w/5/8x6eSQW3rVMWpuxzxly0fm9WT+wjwQz7F/j9S
 tvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792552473; x=1793157273;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HJHtdVy5wVxjfhiD2204eyvZWcyoZdZQUrEb1ToGTMw=;
 b=cfWOSuf8ymtX9KL1TpXYeo9yrRuc0XfIbUqEuqRdUivI0kFvZFLbUqZOVUQHOFIfph
 NuINMFEaH5qMtjdtM5iYkwYZP/5vPEQnyj9oKgISax3ZNMLwqBlCKv3RyA50Qq0EtrQ3
 pUbrfxZOw6Zjft8L6JZeaNg+ayvwMHgAoViejj4Wpq38cAq5P4FaiWUOElrrekT3I9iR
 oeVYUrh925GWeet2mDqGEknuXWoyJKzDWpC+eBpWB1CXdJy+JZIbiCDy0xREOJAqVTsq
 XJhPkWtq/QnkEIdaomDOmVcMqc/CwZ0bJ0cgGiHEsX5r7qZ5t9Mpn1IlUYkLPjQei9oV
 svNA==
X-Gm-Message-State: AFq9FYIIV80txqCN5CCgKFPRzuqfFqXTM0iKtS2RjcQZLq6A4vf3Z8qR
 uCfiEEj94wkYWeED1mW7VhcvuIMBMQV5CAgFLsRVaXz/uKdajlGRwOYgP1sVCrJFmdmW9aeUZsm
 9YchZcXcduRiHfgZoH5YqYTg3djriUT8h0nfoWSi83FQ+fcFcV54bF6VvTxJohDf7bCXQ
X-Gm-Gg: AYBFou2/B5vss7TNQ+5KYFM7nuPQ5ZtGC6Pc+vGfGwL49GK3tN9lpT89S6a6FNSVaUX
 DgiXqbgqPCFltcFPJ6Lrm5ettGqEbkf+ja2FNZHdodfBVp8K/W9GX2qfBcEJbPsXQ1SLmCB8BAy
 tOPLU7c6fgzm87pUUN6n+MSYG2RUbF6708wZ01swnG++OQiGtlbRcHUzgiRY1+KWCnzR67DgkZz
 TNJPh4ttKQFf4Qzvf+R7dpBZZwQ+2iUvjvfzl7a1nOQHr+7Igek7BIfJXi4Qq1lTFg4n7Tjp+jw
 IJSHG7R5Uaynjc3oM0ol2Ewd4YK77bZuXsAFwbJufKZolN575Ijiy2FxIjRqVWTqNEUcs9Iiw7a
 nARmqSlyDrOLYmJhm6HwMjXyHtJn9HU/u/WpBLhcI
X-Received: by 2002:a05:620a:45a1:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-93f57fa3df6mr187622185a.60.1792552473419; 
 Tue, 20 Oct 2026 20:14:33 -0700 (PDT)
X-Received: by 2002:a05:620a:45a1:b0:93f:32c5:69b0 with SMTP id
 af79cd13be357-93f57fa3df6mr187620785a.60.1792552472925; 
 Tue, 20 Oct 2026 20:14:32 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e2581eedesm2246455f8f.14.2026.10.20.20.14.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 20 Oct 2026 20:14:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 03/33] cpus: Introduce CPUClass::exception_name() handler
Date: Wed, 21 Oct 2026 05:13:36 +0200
Message-ID: <20261021031407.24862-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261021031407.24862-1-philmd@oss.qualcomm.com>
References: <20261021031407.24862-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PhO-mfw3GwFJ3kJJ5zPC3TEL65dupwtE
X-Proofpoint-ORIG-GUID: PhO-mfw3GwFJ3kJJ5zPC3TEL65dupwtE
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad82e1a cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=nqYS7Cp7_YcMA-VLD7UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfXwppD29PPk24Z
 HVxjRVaY/qyFtmZdb9RKQ5zA7zB98mX98uF/PfEvMEddD8HV1pMFQ0LAh6uTg+EhYRCklY/QLTY
 FHnP+zFGj3sZwpB5twQWfMuADxhp2sI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxMiBTYWx0ZWRfX5wGsSHt5rxHg
 0AbhbypOHs9ux9dkzMi/yCAWCkwyiHOFnHloPNywhPUBP9+XeIrutXIUw4GjKm2DteQCQ6bg5Et
 t5lkCvYk7MPzmyjTyfxtvNcDarDBHQxn2dwBCuLTuv2NqrOy2+hkYTB/U1dPPgCts0EeDt2Zp1B
 fvfDNug9N/CujMFdEVs9Ozd04Pwg7sX1G/jLUHJRvkHCIp6DiA3h6YlVO0nOYnCJUsK8jie5uGR
 ejS4keWpNF5Pa3Yc7ozVhM0kyHwjFUX9iG8ja4muUMd/A57gkLMiMJNYlbS0l4rKyOcC2rJYmRj
 kGT6nYGOGnQPbDYKlW5ZyYYZHo8nxqYnKByCI2AyXQ6vqrwzrzh4asGRZ+O9S8B8qkKOCusGu60
 lH5P88ztkwa/HR0pdYMSZEzd+gDbmmDtzKG7hqIJ2laanaJUAoxXskXx4YIAPK2aF+Wx0iTOcel
 ikIFOi2eQgHDn58BJVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210012
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Have targets register a helper to resolve their exceptions.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/hw/core/cpu.h       | 2 ++
 accel/tcg/cpu-exec-common.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

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
index 2ac8380d0bb..a347dc244d8 100644
--- a/accel/tcg/cpu-exec-common.c
+++ b/accel/tcg/cpu-exec-common.c
@@ -106,7 +106,7 @@ static const char *qemu_excp_name(int excp)
     if ((excp < ARRAY_SIZE(excp_name)) && excp_name[excp]) {
         return excp_name[excp];
     }
-    return "undocumented";
+    return "unknown";
 }
 
 static void log_raise_exception(const CPUState *cpu, int excp)
@@ -117,6 +117,12 @@ static void log_raise_exception(const CPUState *cpu, int excp)
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


