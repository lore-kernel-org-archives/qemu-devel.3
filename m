Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D58CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 00:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcB9i-0007uT-Bp; Tue, 23 Jun 2026 20:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9Z-0007c7-Lw
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcB9V-0003Ix-QZ
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 20:07:40 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NK0fLK1000032
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FAFAbbkiera
 qKgzFY/50UsOxfNtGrL/uy6qUk6k1aiI=; b=bralpz5+EPy5owInHZooIiIRFYu
 xQScG4Ejk2+SSM0cvR6rYfnHaXgaudy0THQAfUUg4mopGir4p70zjXITwxS3XY7t
 cehHhOPF7hN7t2rhbJoZStHSfFHxkKfpCuDwyXtKseHosTT8D2LAxN/DgzkSukUN
 9HyAo0Nf3ue0joR2MqBW9tJg0c+ph6XSraGv+Y53kDWjoOTLPM3p/tyPEAJxBWM3
 7+GpsLVEKqj3kYM+lB7QaxoN9TQHuxAPzraCVBXVfiEA1FJaNBh9dkof3qXsMGIu
 RCAg3TsZomGsNfLYcFoNfNEd9DQ1eNt/2Fv0OabdKSB5XM90RkjeFOz4xQw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eyr9yu4e0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 00:07:26 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9227d9b3b5cso102540685a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 17:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782259646; x=1782864446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FAFAbbkieraqKgzFY/50UsOxfNtGrL/uy6qUk6k1aiI=;
 b=cH+/+u9FXhzxO035kP4yqdSWk9DXxE9C+QJ6NsxFpeoBV3zB6WNNSPTBitJCpxMSTe
 ZLNpt9A1oy58bBIjVpZEBCk+EurycyGF3QPNiAXzJ2ufrARS8qeowT8WMI35bubrTrTI
 XCXG6cQ9xcboH0xIdEqgSLGJrYskIO6AZeccH12Ej7OmDBcLdNqAM2RkTVfq22Q0JgJ+
 yR9HYYW+Q/pTC4vfWTqEPqEc3P6V+07Dh/E1TwmNBZGhDm1Pl0H/x3dzfFnfN7kPmCQx
 FHKPqx/cY4+dIjfeVxlB6KG+l8NAKUjD6IMW3LwGzxPk2Nl7qLUEVzQKE4g65VZhIwQ1
 doIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782259646; x=1782864446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FAFAbbkieraqKgzFY/50UsOxfNtGrL/uy6qUk6k1aiI=;
 b=V5JXic0Wc2qPIe92pPtlbacoZimUrgCZ5rheECgTdWMWGLHRtaxIGnEO3vzRFoNpip
 JnS2+Xoibd0/X5YXRuRaVXPvcGGifEfVU7BNf59mQLp2niIunNQ5i/znJBfI7rFbuN2Y
 BhYpFIWveNRm93366YYLmC5CJUwfRig+Ft/PTKhBov6OixLC1zJ9lB7PoaME+prVS4xD
 CD1cyO82sqC9OG1s0ujtWkg5E/HqIgjHGz1ox7lHtHga4EeSVq5fMISGqOitiT24SbQk
 HUnrVR5oD6Ul3BrPgNMh5OM1e8E8+W2khtGx+8C+VrlouC2+JeIZ8NXUreuo3n6KhckE
 zVcg==
X-Gm-Message-State: AOJu0YxklgNCmGmvRlXgalH0/oiVBHllckFl90Im7eIj44+hY9O1JsiB
 1WWVB0NgDbZBcy6opf+TE09niC/4zEE6MpbBOP3bOpoUaNxo5CWG3tEIs/o5vwWsepx93IT8Jmr
 Uu1DemXzRnDVfvEofChVad+WeLJ5HmU88amOQIvLlsdMR2zz3MAx9hJUN8B1xk+CG5g==
X-Gm-Gg: AfdE7cmOdWm5ysqXIGghLMxxg+8387w9sb9wNxZHApK4T5OOPyZ0PWnd4m3C2cCYa/O
 WCG2XQ6I+/UPFXofXFV2x4J7JCJwf7s/+g3yxbSNVwNnudQVJzsXOBlXnpmgWsYNrhhgFieHwZZ
 M4KdCh6R1L8n6J1dLXtPN/6/7Odg8XbgfiKfJu9+DyT00Jp2Hcv73gmvcxDHOkFjvPLzrQe34j4
 DTUjAoGKUT2LFOrUjBYVRZxJ/mb0vOS5D5JtzOP3Hban/FvMMMaH2o3O+NZeIPT7DyOaGsO3BeR
 TOQRl3LMraWHLuyxaqCseuvhQMFRnbTiVrZM75xysOXBuT1HV3DOjf28gCaIXurWzIv/e1jY6bQ
 BDx3LO4vDczjox/PFtcfYuJv1OQC+HdAHbNmHvopmtWnJsA==
X-Received: by 2002:a05:620a:2705:b0:915:cda5:27fb with SMTP id
 af79cd13be357-9277f8c955fmr227698285a.54.1782259646173; 
 Tue, 23 Jun 2026 17:07:26 -0700 (PDT)
X-Received: by 2002:a05:620a:2705:b0:915:cda5:27fb with SMTP id
 af79cd13be357-9277f8c955fmr227693685a.54.1782259645735; 
 Tue, 23 Jun 2026 17:07:25 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df81cdec56sm142422976d6.32.2026.06.23.17.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 17:07:25 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 pierrick.bouvier@oss.qualcomm.com, philmd@oss.qualcomm.com,
 fritchleybohrer@gmail.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 15/24] target/riscv/cpu.c: handle TCG bits of
 riscv_cpu_dump_state
Date: Tue, 23 Jun 2026 21:06:22 -0300
Message-ID: <20260624000632.2149359-16-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
References: <20260624000632.2149359-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JYSMa0KV c=1 sm=1 tr=0 ts=6a3b1fbe cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=n_Gjmr79VRyvsDPUZ2MA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: Y_nLPKTCyqd80aHi-9hA38rzQ56pgmMP
X-Proofpoint-ORIG-GUID: Y_nLPKTCyqd80aHi-9hA38rzQ56pgmMP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfX7YOnAi1X/nyc
 cegqw4SRu5fIHKQBqJqfNxtyheU+fsRXSHCmezEcbCic20Y+oAZvnrQ0rSbXzD0dVqVuzhmVVry
 HHrQA+f4Paglu0SxE9Nfah/MUXdrUPciFC0v238Nz/NOTj9joT60A0gy35Ox/PD4C+VkJPbE8le
 NY6tToNzNFzam6Ke/k9RYw3HIniuE962N4ax+utQYsdqUFc71XoJiiCK85CeAqPhSs0PG31fD95
 QJeEKK28a/Jb6w6istJBXhhiGWVCnFkouRSDdfhcdBTmIqbwhv31fSZtzRzreaA4pXAHbdwC3nm
 rUbd0r/8N4rEU+zWNytieyOgcGa8VG90OdwOgyXIZwfp72VvED0OsKKYomBoNAxXYE0GKCM5rV5
 LNh5GTscH59vhvdq25VtBVTUwggtd8ld0/c26HqxN3HQsh1qwBO950SJ3RR9VAln19j20Wfknzr
 VOIyo5KTLKKQii0z1wA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE5OSBTYWx0ZWRfXzPBsgOeGZfm7
 FqwLaJ17fJkh1AJqHMpSRRLXihywSBcmoarLVmtwNXba8JiO0TwT4bh42SR9A4iY5sb+M8zo4El
 NZK6ozj+hBmVEZNsbNjUBd3IpEC0c2Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_04,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230199
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

riscv_dump_csr() is a TCG only function but we'll have to implement it
at some capacity for KVM eventually, therefore put it under a CONFIG_TCG
ifdef while making a note that this function is unimplemented in KVM.

The csr_ops array is also TCG specific, thus the for loop inside
dump_state that iterates it is also TCG only business.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4fc0ee2823..7bd5bc0fc1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -605,8 +605,10 @@ char *riscv_cpu_get_name(RISCVCPU *cpu)
     return cpu_model_from_type(typename);
 }
 
+/* Note: this function needs a KVM implementation.  */
 static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
 {
+#ifdef CONFIG_TCG
     target_ulong val = 0;
     RISCVException res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
 
@@ -618,6 +620,7 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
         qemu_fprintf(f, " %-13s " TARGET_FMT_lx "\n",
                      csr_ops[csrno].name, val);
     }
+#endif
 }
 
 #if !defined(CONFIG_USER_ONLY)
@@ -655,7 +658,7 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
     }
 #endif
     qemu_fprintf(f, " %-13s %" PRIx64 "\n", "pc", env->pc);
-#ifndef CONFIG_USER_ONLY
+#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
         int csrno = i;
 
-- 
2.43.0


