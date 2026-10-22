Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B641606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LvXgsdEo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BPWGVA0H
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nc-0001wN-D6; Thu, 22 Oct 2026 17:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0na-0001uS-3H
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nY-0000KB-DN
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLIoQJ1369905
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +QoTBCCricDQsvtnX9DlX87KJqmyDMi6qGc7LzXs2vE=; b=LvXgsdEobFlq4jva
 z8CnqeViXOZ9T/FWGAbzKpr1sDvhyEIyQt2n+LUI3jEtOJU602OQtU4Adrzi+XXL
 Pp6b4xGxBPIPg8OWv/kCkimqSk7oJlNVh0WkjdkV5EYzgNLjZcBbKt2XIxv9IWO1
 tno+MeSsZ/voY42a9YcCCrWsS3iTqqEKnTZ4M3WWKSDHpUP7fFzjYX8HFqaEPAA5
 kcOSXL9Cd/f38KnbFEMJVrfAX2MFNw0tgyp6Yl+39l7wz4EdE444ed8A4v4zFYgv
 +854N8kf+uc9yv7VvoICVs5Zn8+bp+lJwx5+zHVoSqP3cctPjoM0e7v95OrVhJGf
 yCKd6A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmj8rc5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad7030e886so318537a91.0
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706286; x=1793311086; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+QoTBCCricDQsvtnX9DlX87KJqmyDMi6qGc7LzXs2vE=;
 b=BPWGVA0HwDkxq2ZQfOmEr6sPDFmXGRR7dQj2NcsoHG8RQu2gl9T98/+D96oYh/QAh0
 DEqC5bUO97+GjWirdRM1vMGF3cv+78zzDUlWvF4UiwatGId8qLRHA3cH7HAvFmFuo4bi
 fqoZFCXeitNBse9K6xh71H0GgSIpNbzVCRdcm/Kfrl3WwHJzXxCtG/ss9Kzr18TbzSAA
 VKz58QIpeklcUYcWg4LHhzkRSI2xNY2P4BWRWVH412Hsuzrhy5wRsmApJF69MpvTRI6V
 ApwwLoZljDrWuVPwmWF03xbu2CETQaXYCvOoLQCofCLYkHSgDBHujPt7uTeGeR/HQeCR
 EjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706286; x=1793311086;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+QoTBCCricDQsvtnX9DlX87KJqmyDMi6qGc7LzXs2vE=;
 b=EzM5x+VKnX/Wb52FiTtDsX5oC8YUIt2oD4Lhmo9jcEcLLWJF3WPlfQ3/KVy4GCsO4a
 dW5EEZ6akWZYTWoBDsckrQ5q3WUC8uSGiXegZuIdZISDlyBFXCP4dY48SIR26yODr32l
 F9J3NzzAWnSYkyPKO0wGP0FyUcBgSdkmQLrtCa3UAjjpJbCmHVbswWJBkPhDll5PrJ5e
 4jZUXQ+fSmTCYbfTxqChpAQeudLFdQQWvJ7YrD3HHFtt3I94AvXzIUHybYQcjr6RspTr
 rJP9IevUAYVOBxqbWFmL4L8qW7ZjOvn4mml8Gk0A+26YNOL6DgPa+xjdCEFb/6K1epIo
 RU1Q==
X-Gm-Message-State: AFq9FYL14p08lNeVFhNRPysWrqBkEnelKk2CVaVODi60+0SNyUM6RaY8
 gNnDQobIwKOmzd1ImVi50YQJtzpkgiWTq4fIxh8jZJwLnlwVGrEdqFoEKtVEdzALcm7YYwrJYVk
 NXxEVOGmIDhKFc3uwSF6uUFraYdFw0NKhW1du8SkszA0a8uJ/EGfZSj/z3eO7h5K/vA==
X-Gm-Gg: AYBFou37hvuGcY2APo/8YKVo+egrKpcu+EyGh5sYTkXvutpNw1zLPczwACyASigGWYW
 3+Jcrotb2H99rmRiCxdHvqxv47vNgnW8mMmsMxFZjYVkcoZQcglIDPCgxKr+RceI/nGYAyc8BUB
 HJ2qaBJaN8hNdgmzv6iN7fuJsczZEx7RH4rWh0mYf1Wrr70aE34gdMWEscvvDXf2z27cGmTp66x
 7bqGRQsBGCtIHDdUJV4B0roTYuqolpSqmupccT9/unzoDznpRIiWY5R+5PO4P0CJn9atllwDpWg
 30wEdHbpLAtgQl6u5md5UHUZE/n/a/MnlcO12g5dyUSKbQPTZQgoUrf49s7iU8T+iYWM2xFNRSV
 rmKQdVKph3vonMo+st50XLk8WXn0EUfRi6gLaNz2sAyGY9Sn/6nMf+F5A/i8f1zw=
X-Received: by 2002:a17:90a:d610:b0:3a7:9adb:2a18 with SMTP id
 98e67ed59e1d1-3adce1755e3mr196105a91.62.1792706286301; 
 Thu, 22 Oct 2026 14:58:06 -0700 (PDT)
X-Received: by 2002:a17:90a:d610:b0:3a7:9adb:2a18 with SMTP id
 98e67ed59e1d1-3adce1755e3mr196090a91.62.1792706285790; 
 Thu, 22 Oct 2026 14:58:05 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 18/27] target/riscv: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:37 -0700
Message-ID: <20261022215747.2479440-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: frPpwUz_AzoN5P56QlxHWGpp-d-afHKE
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6ada86ef cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=WHTxxU84TY79vzyxHH8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX2W5PLK6S+9jW
 r6advuKA9QnRguyY1WGK7ijMEY46qO1Z0PmIrUBXR9QDG1Eg9krwdKQYmJacEgLP2Vm399E4Fs0
 2rDEnZgRgxQJg6k8Wu/bJqhVnIdk4LM=
X-Proofpoint-ORIG-GUID: frPpwUz_AzoN5P56QlxHWGpp-d-afHKE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX7Nu8qTCA4foF
 1pudmdnWrzqvmjLVcukHyCEMwixuLh33FDTVXS2Y9ruG8yEvpGGeKuWSAm/7vXcxl6UNBtwCpR6
 yZUsQBxV4a5TZ/gZtCOVThNe8EtXbvpoaGNVIk1beMB9QmbUo9Purap6HDbrqhx0ZVGzWbIsyXK
 3psTCZ8RvAkcOy0FV+5ubikKLbpCm5/50GW9BWhZVaCVsl4IFKZEmHDGr6Z72I7FyAw6+UnmKeF
 12cwsqeQTuBQkIAzNrAFFrClac6dFfnjTlUBCG0fwpg+lGFKCXsrlga+UAK8eCGxswraw43cnPM
 Yqix8cn/rrxe4GrXCQ875T7EaxYeKuZAfexvTZy1X1m7VYAqc5NpVBGU4SgCkDGYtgotKe7wtzw
 +W1g7dSH30+aR+WKHnwIRTqKIMNEHDpSBpox6/dteJaY6oGiHi/FLaPlqQT0mzNi94Yup4SoYVK
 Uv3ywqvYE1F+69Mv+UQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

For now, we keep the global cpu_get_note_size symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-19-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 8 +++++++-
 target/riscv/cpu.c       | 1 +
 target/riscv/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 578435941de..06b66a56855 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -180,7 +180,8 @@ void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                      ELFDATA2MSB : ELFDATA2LSB;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus)
 {
     size_t note_size;
 
@@ -192,3 +193,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return riscv_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 059aee855df..b202a4eb6ea 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3105,6 +3105,7 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .write_elf64_note = riscv_cpu_write_elf64_note,
     .write_elf32_note = riscv_cpu_write_elf32_note,
     .get_dump_info = riscv_get_dump_info,
+    .get_note_size = riscv_get_note_size,
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index d2993842a32..9f1dec6748f 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -209,6 +209,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 void riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                          const GuestPhysBlockList *guest_phys_blocks);
+size_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                           int nr_cpus);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.47.3


