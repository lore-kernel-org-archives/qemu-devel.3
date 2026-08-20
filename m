Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE3DC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0KQ-0001vl-2q; Thu, 20 Aug 2026 06:49:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0KL-0001sc-5g
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:53 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0KJ-0005vX-4R
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 06:48:52 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6n9Ie3732257
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n0X57WJLrSAfllLc3a+/YOYqBoRn9oR6RE40Y8FVcNQ=; b=CRmk1BdaPyRkx/v7
 5ABMLycULxjmQxF1+GwfLluUlVyWTyoo051i5/OkCX8QFlv5nDTW05HTkwFhYvr2
 PNipTzIbakthcHxatGEbkTXGX16IvKWIWrY11+fosZ5PqyPJ/bOU7gsZBN9TxHnp
 hVDoxP0vJyyKjY2K5MQhD6nGRWrS1Ma9PQD221lTz/NKGPRgxeEdlh+gXLfhFm4B
 ALVFqHdNvCUzY60ZaVu/l6evniaeVyF4U7iQcQUhyViE5Xrqq9eQB0M3uHZf40SI
 0GESukM7LsjzQ1DFHKa6I2/Wnpj7UkCFIEt811k5RwPDfjvVAtVhTKvYjBuXhOYr
 K3oXzA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vn88wsc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 10:48:39 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bfe3fa93bso22039011cf.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787222919; x=1787827719; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=n0X57WJLrSAfllLc3a+/YOYqBoRn9oR6RE40Y8FVcNQ=;
 b=kZvenZ9fiSv+T6zVPBl1CHWUy5o1U1UVUQ/MND9AfKUqL5gjCNkG1oQgWxPs8f0eo0
 JFRRXX/evDH64VIfC54Mz6/I0Hb9ZNFDAWfARiuFIaNVPbEy783OPxOL5WbFuKZO/d5t
 cLYR5oWXyfxppQ5MSG2k+HO83xtczkoQYdcXIomJvyHaS/4yEolbdmw2cbA/f5fUl8O9
 e8TXnBqskHrg/V/rGM223u1NKhGhIPzZw4IDL5YB/zJa+imwjEak3+MBBzgtbE6OWf9R
 sgvPjOZB6dm7H+iaf1liEtnbGUIUJowAK3uxnn2ggYb6MAtcMZOG+v8g4blqoP4UTIio
 BTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787222919; x=1787827719;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=n0X57WJLrSAfllLc3a+/YOYqBoRn9oR6RE40Y8FVcNQ=;
 b=GCC35E6Wm9OXcosr5VL/hf6YGl0xzOFmzwKc591YFZoelUd6f2eVhqi2kUDlzmdaXR
 J/MCD0LJr+yzWnD4KLObZa4GNfi8wTKRkNUASCeT9eWCAXjwFVh2tV/mkxPXGp6AuXAg
 mQ5kTA1KJ2ZZ31uMkvkOsn70uOVaQypkfT6Mr68TCcVjVpVDkB7rOEe2adfUSyh53aat
 Rmetfc56veQEDs4H0GJi/VYj5RPcvf0qnSOF9z1xcNsA/lHYefBxDvGeT7efvYBXjaLq
 amOgkEdG4v7lvHoaxC/BWi4kitnvhvlP5OIcgZ3Ve5ky4D5Ln2Qxcf7rngW8QJGN2K/G
 EHZw==
X-Gm-Message-State: AOJu0YyVHzHXcf2KAdwRH8DOOh6BeDnQB/ds2bmNb1x3OOJX9iNp1BKU
 nw09RqQ42huyqpvth5aCraXj4uqWmpy16eKACiCsS0D+uOs3xrDfrXo8I6z3BFEzysSxJN4fmXU
 Brltzsy7wixwnAMdMOpiDANeV+R0x4tq1NvBK2sw7bx+qKkk4i0ui7sSLCsBPTksK3tza
X-Gm-Gg: AR+sD10zP8NJRjPk9tiVcHo3IGSUY3BiP4/ImfwsMwSWfr4U3Goce/Ir/vfDEYmSRo/
 UVQht7CB5qAtoGrgPVoEAnaZjPAVk6cSYwb9bstzPssLwwv4r/heHVCSjtp9g+KbYzJZNTjTqm0
 TIq7kRQeevROn8jB98FTd3iEknMlCnwvpPmUE//ifWoVMrJeZodicxdP5pxO9t+2lbcQlvH7Iyx
 Q7Zy7H2dAHTz0Sk7Vw0TCYGtZVeBkKtjOC8PTW+0TvAVetmMDGgC0H9nLdWKOZ1w5BZ+XtcmQvp
 7+Wa0xASW0G8OJFJjLsgfH1A65ipaDMdpEZFXN3ovIcHGhgvja1OqAoxF5Qm902bbmq6b3e5eKD
 t7iWU3TbKOyFRsfPIqv9jAIaNs8eJWJh/wCGwtjrt8g==
X-Received: by 2002:ac8:7d0b:0:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-52dd5e3020emr104843881cf.42.1787222918571; 
 Thu, 20 Aug 2026 03:48:38 -0700 (PDT)
X-Received: by 2002:ac8:7d0b:0:b0:516:e152:7a59 with SMTP id
 d75a77b69052e-52dd5e3020emr104843511cf.42.1787222918151; 
 Thu, 20 Aug 2026 03:48:38 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b2af1973sm16978845e9.3.2026.08.20.03.48.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Aug 2026 03:48:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [RFC PATCH 09/13] cpus: Add const-qualified CPU environment accessors
Date: Thu, 20 Aug 2026 12:47:25 +0200
Message-ID: <20260820104730.25462-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820104730.25462-1-philmd@oss.qualcomm.com>
References: <20260820104730.25462-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX5bMYKlKuykWV
 L3Y6i2HE5ZczBMLuYppFGgNA+dt1+N6m/Bbg15Q7phU+16PRLGtsO6YmzAJ8G9Gbc64b6G2xsw1
 3MoxsAtJ8MkrOi1gkIozdMhvEgHz/JH6+X79KsDQALN8n/wZatRGNUW3+C9DsjGyyaxCwOulVAy
 GTKroP38qR8i1anqmkpwSwjQiD6LR+X4Do/EZjBFgZJMAIDgJy0knl4oEVlXXfPt8XlCQ6/BFoI
 67d3ouEcj+dB1i9v+K0ZHWb4ekOlcmoITgP2ajvh98WcicVyhMSAEvG/2m+OhUG9VATF/LqkcOQ
 JgEUa6n5HEqF0jP8NqQddxRNz8Y9z6ftFs+SbgQSnQB5grsNbDwIIzsRtfJBAR12WvqYiM1lIBY
 AQXlXl4Xf26P9UciGQv+RPaGNk4SOn/lSExWffBBh54cutM39QHXLIqXhj4PTk1Z77gnfEFyC1P
 5uT6oapYwL62v/OkAuQ==
X-Authority-Analysis: v=2.4 cv=KpJ9H2WN c=1 sm=1 tr=0 ts=6a86db87 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=nWU2JzSQJiCcj08VKMEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3OSBTYWx0ZWRfX5Kq1iXJFMTNI
 e0m2R/awbVNR1Sj7deFlhocS3j+5i4Sbr2Har9omhIrN7ODamIZCO6ppXYaQtK/qEW8uIv7X0AO
 9pW2IY7n4NOryf8bNH61TplKT3FyJCM=
X-Proofpoint-ORIG-GUID: iumj6RDPT6cURGQI_U0T51fJ8eQgxPfN
X-Proofpoint-GUID: iumj6RDPT6cURGQI_U0T51fJ8eQgxPfN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200079
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

Introduce const-qualified variants of cpu_env() and
env_archcpu(), to safely access CPU architecture
state when it should not be modified.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/exec/cpu-common.h | 11 +++++++++++
 include/hw/core/cpu.h     |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6594f7fa1be..f3a3799f451 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -79,6 +79,17 @@ static inline bool cpu_loop_exit_requested(const CPUState *cpu)
 }
 #endif /* CONFIG_TCG */
 
+/**
+ * env_archcpu_const(env)
+ * @env: The architecture environment (const).
+ *
+ * Return the const ArchCPU associated with the environment.
+ */
+static inline const ArchCPU *env_archcpu_const(const CPUArchState *env)
+{
+    return (const void *)env - sizeof(CPUState);
+}
+
 /**
  * env_archcpu(env)
  * @env: The architecture environment
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 81af7b9ee1a..59f777f3f15 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -594,6 +594,12 @@ struct CPUState {
 QEMU_BUILD_BUG_ON(offsetof(CPUState, neg) !=
                   sizeof(CPUState) - sizeof(CPUNegativeOffsetState));
 
+static inline const CPUArchState *cpu_env_const(const CPUState *cpu)
+{
+    /* We validate that CPUArchState follows CPUState in cpu-target.c */
+    return (const CPUArchState *)(cpu + 1);
+}
+
 static inline CPUArchState *cpu_env(CPUState *cpu)
 {
     /* We validate that CPUArchState follows CPUState in cpu-target.c */
-- 
2.53.0


