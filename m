Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20079606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLAwFC4C;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Llf88VsZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvC-0004Qv-Ej; Mon, 19 Oct 2026 17:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutL-0002oF-2w
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutH-0006Kd-2X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK5kw2157813
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EKBDIuyydqiXu7ZYwrxS/q3NvUzv0AXvSQAEvMQhm48=; b=QLAwFC4CfsA8t5HZ
 otVaWZpcrf3geq6oRt9aZUrqz7XpMtixOpuVSoGxs3ESnKa0irqyHn/w0+HtpRRs
 IYn6g4M2u+an7EjvaeaJyrQh5FrxOZqIAguLjOT1fRufsuqhHq/FB0++MRAFkE+o
 LVjPxbYM8ktbrbwH9qCu0w1Xa6ERKM+qYF3we1tT9FOMS317kO8UHJsntriRH8HY
 Ml31gYTtZk518yZbGchVewkN9lsGOLCfdMmPArUYKDDwBksm7FSL2UR3S7qN4cFH
 4ZBWNZrd8YsD3OSWojphtf7Csin9Oy+wNSW/dUIUbohijC7NXX57EBf4//kMbyRI
 izxWAQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf65kb5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:23 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab27eb38d6so2766806a91.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445243; x=1793050043; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EKBDIuyydqiXu7ZYwrxS/q3NvUzv0AXvSQAEvMQhm48=;
 b=Llf88VsZmPW84PXaTblWqYICEsKN+z7VkIkHp8wrdrU8KPByUGXcLN9vrtOE6Er3C6
 4HXYS2oeFBdVnGoRCStOuOtpyAKz6qjdErmlsWv78KOh55O1OvyRUmfn5kKReQTDSaaZ
 xbpdcSz5BH/CWIlR8SqohT4x4ifP7HUI5etPoM7iyuxUUcjB9WitrBJYOB3emh34s+3h
 chnTVIWAYWHqGdkZfCRndIVwJwTuhem1wHKTRDhbKE+ArBpJNCqT+2T66CyYcRNQ90ik
 AjEM3ak8GIJ8zE4DkY8tQS32CbITNwpY2Sf3c9k2LU0sfvDaTZI0i1AGxruq5VofgT86
 wc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445243; x=1793050043;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EKBDIuyydqiXu7ZYwrxS/q3NvUzv0AXvSQAEvMQhm48=;
 b=HJDFHcVUS2KXFNC45THPA5snATcae9Y9+ZdKKCRHmPwioRS8QrcQnyvjsCxPapY3Rj
 gEf47i0lASRC+UIvld9OpSQTYB/+VLFEhXIkoNw7za1y4fJqXWP/TTsbwDW01qrVIyDx
 gEfgTlSW5ffHatItlc7MlKzL5mSUqvktCfnyxl6pzYm1DL5tBNa3V9Wjs9mKaK3wBN/p
 EcY+FuHyT2LZ8wX17cNBv5BDrGEJnJpoVoteCEijO94MgHWqAC3SNcI85QLRVMIyNLlx
 k1ac3+fL9t+JdiOqH69Iqz6hTGr6KcZsIVH5XUewrC5C9CJW3tN+b4ZJHqU8PTqqlXxh
 svng==
X-Gm-Message-State: AFq9FYIeXQC93LNQudymr4YdzF2MJ7DGCNQeTvMgqNhSBNVaTmdXGuQh
 v836kxYSrxxrA9CXSIYTXhCu4uJ7Te0rJVHG6hZ/CGu6Tcmg+/lVy1knon5khJoZd4wYzQdaOfv
 VDbLtMdVzvK0y4inqER92slcpVmkli2M/sfFmJJTYVtxsleU527dS4G+WjM+ktFpJ4A==
X-Gm-Gg: AYBFou3RW4N+WjhpBmnajGVZz3AO7fJ91gC9BXKIkqlFAiU9sfGo6g6/OXhDyTWkxrw
 Dnt0/zhtdlRu6PjM3LJNfaB2iyivIvVhhRR45FZDA6LNJpkT2Wd/nG9h5rc1FHs9GJE9OP1iJaD
 a5HONZyyZcPjx9emGhGZnf5rebCeTbAVHwmSH3ioPW8LiKpMjROYELvX5MXZSUNsJUc5OwOY6Jl
 1DeaA8qrRbf4qN8fWQEQb/AQ8dVk0RMNw60PcsRwo4o7GJvHTVsqae4mWMqWiIN4/mQvGtLpFO2
 ZV4RRoMLVtL6lB89WlseFYCCj3/c7+RMiiHq+8qcIVpZ04GIAU9hpHy/6m6ZXF5DXKjAfRvs8XK
 rQ0lUpjd+VdsT0w4YoQKUdQ4p7Kz1W3Wwl3LTc4QIapEkrscD5b1bjfKBsDbuXlA=
X-Received: by 2002:a17:90b:224e:b0:3a8:59d3:530f with SMTP id
 98e67ed59e1d1-3acef596160mr7980939a91.57.1792445242714; 
 Mon, 19 Oct 2026 14:27:22 -0700 (PDT)
X-Received: by 2002:a17:90b:224e:b0:3a8:59d3:530f with SMTP id
 98e67ed59e1d1-3acef596160mr7980924a91.57.1792445242272; 
 Mon, 19 Oct 2026 14:27:22 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 18/21] target/riscv: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:45 +0000
Message-ID: <20261019212648.154493-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX5RupJFTOOv2m
 WAEdqI1ZwL3mxFrmAgFzbLheY9Zi3Ex85+PKvxQ21uV9mCTRuhnsXHIwFGCaaUsgvosN4wpwuA4
 qq3fPxt8Pw2FmMc1bqbSANJD1dcmLvw=
X-Proofpoint-ORIG-GUID: 8OcKw2prORZaAoI9kQSnJApYFjZuDNrm
X-Authority-Analysis: v=2.4 cv=Y5ptIReN c=1 sm=1 tr=0 ts=6ad68b3b cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=WHTxxU84TY79vzyxHH8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX9Kv7aU/h1qUT
 D9zSbgADXygGslmm7tmcVTT7kSp3gdCdb4Og6M3lMs9kOMB3ljk9jpYnjhkvpVpXul1Lk0vhJ7y
 oN4sMxNu18L8C3AZKd1NHUQdhuAocaLp0cjiJgpYoWKUC2ur+LZgkQ+lOb9lAeGCNXWeA5omJUX
 uwbWTFhjE7jDiQVhONAH5I2vNd7xSu9+Agt/62Z1Csp/3Oxn8yK5wpSIozUHeP9/jBa1zwvnF5X
 N569SFPPbO2biGcTTuQ3SPE4+fxklR2iLB3GesRGqmx33+gDqCx0nfGgxrCpHxN3caGb7UcNa1g
 HW2CCmXNnG4xSKo05FbYg1bhe4vtnjEz+YZfkwwDy0p+0LKQCGTIa20l9trOp85h65gW9yBJCVg
 Hs0QnS/eP3xA6P6ZufZFXjEnWu/6Dvfz/rj+KB83P2BxBRVNt1OBAgZKBDibT8gIJhtCsoTaQ4w
 mnPFFqM+t5AV/C9TxjQ==
X-Proofpoint-GUID: 8OcKw2prORZaAoI9kQSnJApYFjZuDNrm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190085
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/arch_dump.c | 8 +++++++-
 target/riscv/cpu.c       | 1 +
 target/riscv/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/riscv/arch_dump.c b/target/riscv/arch_dump.c
index 13aaa87202b..74b1489ddcb 100644
--- a/target/riscv/arch_dump.c
+++ b/target/riscv/arch_dump.c
@@ -182,7 +182,8 @@ int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                            int nr_cpus)
 {
     size_t note_size;
 
@@ -194,3 +195,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
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
index ea4b4140c09..a0b040f70c9 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -209,6 +209,8 @@ bool riscv_cpu_has_work(CPUState *cs);
 extern const struct SemihostingCPUOps riscv_semihosting_ops;
 int riscv_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                         const GuestPhysBlockList *guest_phys_blocks);
+ssize_t riscv_get_note_size(const CPUState *cs, int class, int machine,
+                            int nr_cpus);
 
 /* Zjpm addr masking routine */
 static inline target_ulong adjust_addr_body(CPURISCVState *env,
-- 
2.43.0


