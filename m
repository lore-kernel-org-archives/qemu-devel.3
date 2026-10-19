Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4578606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O1iymEHH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Nuox2rv9
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvK-0004qK-I8; Mon, 19 Oct 2026 17:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutZ-0002uw-Iz
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutU-0006KD-8R
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK45l3673243
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xFsf0QmXzFn4QXLL66KYnC55pfJrve7l4KO6/W5j8F8=; b=O1iymEHHV9xYpR9W
 B60iHtlvutoVO5n8A6lDAlEOOHOBxOsQUVgzWeJwzK9JXqNLmSD51AxsUEi2aSdI
 MHb4NOc6V0jT4P0dXRrcjdOQQrlSAGZ8jRBRyET6Kgg2GT8HH6U6kvq4SLwdhlPV
 8caPulVsTLJT7HhNT554f52q70vnvCAfPldod2KP7202MOahUOXImdmC4jqVm9x8
 ue8XLOQwBz1FZaP2k7qf7tNvglsHgy1D0dyeUhlhkoYboPeegiFuaRbeV1Hq5mcg
 PBUCFZxFMOngP30f7XFui1bCXiC6Rk1UqvlwzyWM2c2LNxefwnB6P5C2ZnfbItJa
 WigRKA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3xbbkb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:17 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac6795617aso2442016a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445237; x=1793050037; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xFsf0QmXzFn4QXLL66KYnC55pfJrve7l4KO6/W5j8F8=;
 b=Nuox2rv9LKA9tO117JqGlcrz/m4/fp9T0A30mmGsM+rlXbXs7/dqeRU8lWJJUv3+br
 L1+DcjW4I90UET2SIwYx5dA6B9LCBIyEimWZt/bEMZiG8CamO7qyWaA0OJa23Q91/8Bs
 OfBCAmYXXr1n6M+d7GDHbFnAD4sy17HpsU7b7F1OuXfBbO3iV+4fBz8GKnp7VLe9VeBV
 vTIvNjhphKBPb5yXwwbsVk0sVS6OjnKenXoCF6f6g783dzek9qbErdwFFtkcmektERpT
 6nGPUnAOuc+lx04UOR4Vvxd7ymRRL1M1jCZm4yi2esd6qD9LbEdkvGHKxn1tD+E/PN6a
 gLcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445237; x=1793050037;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xFsf0QmXzFn4QXLL66KYnC55pfJrve7l4KO6/W5j8F8=;
 b=rQ/x+cRbrZMSC0Xm5v9fw7quHjQENScdhJ6SVv5fkggExl9BcJor5OMxCOmD9pGmD2
 LkBbaGP1Hgty+cygoWNkdhafPrBf5/JL5NG2U48LW4yIfVvsYrGPQlLvuHIifJEqiAnB
 FuwKd1jrckbIM5W/OiUDRkS42n3y0xrIynUMCvPYV5R00XS5fX5uQSfXpRD0i51YUtnk
 BUViVwDsKREvoaipXbIJMMYDQTwrKA6xssDYN+5SmM4OqxEbG+ueDLNwkcMJbGQu1wmm
 FvKIl5bNn7Sn1AT+DHHICovpZPDjqolw8dX8/qMWDTq/j/UrnUBd/eLAzgJ1mHMct3UL
 59Ng==
X-Gm-Message-State: AFq9FYLL5MA9olmRswaK/SCKj43Q52Qdpxhs0wyZaY5bXmly6Sa+f1HI
 YbnPVL/+evYDxCAmU6MJ0NA+8R89p1nHB4cyueyE+mTeC8JgDo/rSa1kek7+xV3dfU56ZXxbyQy
 k7DDS4jTpLv5QyvFsqJUNcOw77vrtf6fwP4wZ5JpspFZY4JfppmlmXnAceOja715YCw==
X-Gm-Gg: AYBFou2a/olkhtGLoFeWMldEWJ9fPQ+CbA2MHbEppGiMUF1M+ITx8XZEv1EsW1r2QaV
 8xNo59a4hS14GgyZtOhf3+lC3AwT129R2ts4DJJrgUgWwmA/MNimhvWG+JjsFTL8HjBR6WCYJyV
 bDeBGvEC28fQxh/5WlWMODN8IvLYQwDbKdH50h3g1YxOPUGeerhf0YBMZis11t4stRhjtlN3D9j
 OdQ3HlO4dyYd4xtV47nMyoJt/9fLjoWrYDPkOjx4nxFUfptnevQXcMVWkL68lHlwMhSjwWtK9WX
 X/d5onf3eMkFLBuRgkgcpNhV1V7ZvwBDSok4z0EwaiPY8m0fHfdCRwmGBUr+LgteVPxCioTdLOF
 gsp6CC+e7ICptG4m2YbgMlmzrMq/clvuZ3o8n7GAH58X3bkya3R9y8s+MBSMJf+c=
X-Received: by 2002:a17:90b:1a85:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3acef5ae3f8mr8659723a91.58.1792445236784; 
 Mon, 19 Oct 2026 14:27:16 -0700 (PDT)
X-Received: by 2002:a17:90b:1a85:b0:3a7:b260:9ced with SMTP id
 98e67ed59e1d1-3acef5ae3f8mr8659703a91.58.1792445236309; 
 Mon, 19 Oct 2026 14:27:16 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:15 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 12/21] target/loongarch: implement get_dump_info sysemu op
Date: Mon, 19 Oct 2026 21:26:39 +0000
Message-ID: <20261019212648.154493-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: XRwZz4X6AcqtVKyrqmv0ukg9VVc1ajUh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX8U/hcnUaZ+J7
 iUdU7ijDFPPkuOKMX8UH6N9awP6pJxrKdrGN5BRYvVXd+ejrnTN088pQ5tY6yeo//fthuV+gUv5
 5mB2qhdOlEbMva3MK9j9W5OcD8CEkPQ=
X-Authority-Analysis: v=2.4 cv=XPOl2ghE c=1 sm=1 tr=0 ts=6ad68b35 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=FnhWYSpmk11jPv6NQAkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: XRwZz4X6AcqtVKyrqmv0ukg9VVc1ajUh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXzbWdl6FCeX8N
 lS5QxQ1BlkTerNP2eTOgC+ZQBBQPdDZu+JMPvuZBbfAej7UyJ9kbTAYF07llx/rFZV8mdrD7e+t
 t21FwelVmVfu4I8Mwz0KgeCVZp4/6zw+qjWKAKsJG2mcMmAk3+cCj7JrgCVcOMwq8QxWu9AknhQ
 j+mr/Y+extU2Yv12Bb+JJwECf7xDr+zEKJeCSZ4RIU2p8FarJ+EtqkVcOelLmz38lZWBN6HvZK2
 6gyH3t/tQS18sucIfQgW3/liN8fMfyffUXQfbCXZK3GrNC9/cWOepac+0JS1ioUf32YOAdaGfRK
 EWnQLDIKRu5GK6uO51KXpLYRo7gLXvO5rCZkQN+gjYZRSLSdjJ1PPqQvMrAE/CpoB7IWQtQk3La
 z86lM+1YFDqidpXkgHgUH/RqJo51mtai6R5clfAPvOHZgzzt/mE5cQhLkHaC23o2shkPj2NGbIv
 CQzpZt0TslhbHtVaDNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190085
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

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 10 ++++++++--
 target/loongarch/cpu.c       |  1 +
 target/loongarch/internals.h |  3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 9d84faef969..e216e906414 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -142,8 +142,8 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
     return ret;
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const GuestPhysBlockList *guest_phys_blocks)
+int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                            const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_LOONGARCH;
     info->d_endian = ELFDATA2LSB;
@@ -152,6 +152,12 @@ int cpu_get_dump_info(ArchDumpInfo *info,
     return 0;
 }
 
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const GuestPhysBlockList *guest_phys_blocks)
+{
+    return loongarch_get_dump_info(first_cpu, info, guest_phys_blocks);
+}
+
 ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 {
     size_t note_size = 0;
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 54c26998979..65772f30947 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -841,6 +841,7 @@ static void loongarch_cpu_dump_state(CPUState *cs, FILE *f, int flags)
 static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
+    .get_dump_info = loongarch_get_dump_info,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index ff956823fd7..83220f32aaf 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -51,4 +51,7 @@ void loongarch_cpu_register_gdb_regs_for_features(CPUState *cs);
 int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
                                    int cpuid, DumpState *s);
 
+int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                            const GuestPhysBlockList *guest_phys_blocks);
+
 #endif
-- 
2.43.0


