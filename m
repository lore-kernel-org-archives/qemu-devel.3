Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7768606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GcBeGc02;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z2nqXsoT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoQ-0004T7-Ta; Wed, 21 Oct 2026 14:13:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoP-0004SM-Fm
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:17 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoN-00084Y-V6
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:17 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpNtO454561
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JP0YrXeH6WRFXhDp2PBgCgtcZy4/CuZS1RSjSelqaT4=; b=GcBeGc02u1bks5Ig
 tDwX8wu31Cr3hvZ69XZFQfMk5BrBIxIeXNtpcrFJophd1u0lRAthAh6JNvznVWMZ
 4EXQtIT6y9NvHs/6suPBKCvlb2a4Qd/w5W7Gjrkp3pFSbn56+LXFTVivNk/dTSe7
 kB+Uf6NQJujIQnYQhgLW30+IGbic7Y1Y/fPTMXFwjZCf8RClpexIblKp4ABkdwaZ
 N4YlEUUQ8yfqQjQe7yXiOtZARab1RIkQ2sCeKP36DqHqqmDiEYJdtloMuJZiOjQs
 kjOza5DMeXJ2DmehqAF16qAhusSy+8NdKZ9lSYqJ5y+u+8Re0nJpU79l2FtjAJZw
 TmaF/A==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex589c29-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:04 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so1510278a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606384; x=1793211184; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JP0YrXeH6WRFXhDp2PBgCgtcZy4/CuZS1RSjSelqaT4=;
 b=Z2nqXsoT2Zj68DfV4w/HRom4I5hkKec0Vd7Rctpb6X9I4gFxgpq8rSHLiCoUvGQz0V
 jTuSiRPmZqxBzQcNWZzKKtXugGB59674E27FZOKDXmzVvpdz6OM3esSLkCdeuOhW0n1R
 66P5f21rwNptRt7Ub4lZcQDVybV21ra5kCC1sK8AVk+CEq585Q+TibHDFlYhbZsmh0ij
 NBOnQ1HOv2g3Ms3gdUTt0tZ8jQSU07OAuw7TTxepIdHGZ26hSC7yTMvBQzbJgek+sbpz
 4fS+u1/MZQL52D0AdWH7Yeq+TUb3JHCh7FJpB6gnn81Nl/JxXU2dY/QuTP+ouqbh9oj9
 vDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606384; x=1793211184;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JP0YrXeH6WRFXhDp2PBgCgtcZy4/CuZS1RSjSelqaT4=;
 b=T6zNT3j9xeIPHVqw8CzaFVK+ZwDVm6DmxBU0bZsMyagUrKwWoy32YJn+wbYjPPExWk
 A7eNfJE0QdJSj4uC0ueEPzS20X10JWIhjs10TdUr2U/yjhYrwGCO1cWotTS2oK4hzB0d
 sxmbhDOAOVz6I/XYf3VDKquZLKsX7+Ir4spynQ3b5hmY3t3uzyYVNOR0sofrw14m2tTu
 dYVLrhrA6D6RSe7VvrxkBYclT9LllWLT+L+Ff0u6vKX7nVGkLESiqbC5HzaOfoZTDG+C
 NNDF6Qnpf1FUVZc+xZJdyTN/lpm35udynVeYbyzsflwoENpudzNG6G9CbXTAguBQd1+M
 IZ+w==
X-Gm-Message-State: AFq9FYIY4ydS4wijzJLjrdFCQ7uyoWmDbVeJuHprj1RDgokGQ5wwW0rB
 JK6QuFhXZ/sRDLZS8IJQqL3SHLynasXzVgsQiTpRUMGVR5c4DbLuhSWOesknCUqMTgQKUnMCrvU
 fsK7GCvJmCPI0TREG2vitLi23CKxRpn7jUml31ecaXmbHOuR+vKZZSGno3H8ZMxxUpQ==
X-Gm-Gg: AYBFou0Bd+tzi1RqNbe8VGinHY35WcdEN25I41DqZvDANKEBTj22r9/A9RbAU8EaKfO
 eriMLr4xZTwV8HaxqTonPOWC0zxj7LJTqf7zPRpep18aheCQKnStImAYjXCDDhXZf6N+rR/Lgsk
 yQDqDxRk/rg28hciaw0zCw4zZbSiAEiQ4fGQ1LBMhSbJEHsTMd3LcU31DmDIFh3VjgtngexmJLl
 MH5npWlUni3UJrfxZ2cusYcxZVtiLw+LXSyRGtJiIsJ3hbL/Lyn2qK0C7SIfK6gtu/FkVdHKNem
 qy0qEaz+6EG5xDU6xBmbiJ5oks/BDL83MtfkCeVG1irAjpheAq7bWTQq+tiqtLDgKRL1ukWVv5K
 wK53v0sGK16eaYAKLIjCOjS02zb5ORYAf1cVnd4hFjdWX5x7PphURpDZ8zt6C4Ys=
X-Received: by 2002:a17:90b:51c3:b0:3ac:9706:7739 with SMTP id
 98e67ed59e1d1-3ad86f1bd90mr1990364a91.17.1792606383918; 
 Wed, 21 Oct 2026 11:13:03 -0700 (PDT)
X-Received: by 2002:a17:90b:51c3:b0:3ac:9706:7739 with SMTP id
 98e67ed59e1d1-3ad86f1bd90mr1990350a91.17.1792606383458; 
 Wed, 21 Oct 2026 11:13:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 16/21] target/i386: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:39 -0700
Message-ID: <20261021181244.867840-17-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXyUVHrrxrtdPA
 c1Bzcn6pyIEzNIHH/Ftva+tMdcPmPV8Oaa1kaLK0KTMzlYgUHuZqBk9Pfi6DFRwe+v5HKQ1mfPt
 SoEGVitVcfi6+4Xu1Ev5YKFaQKdgOpM=
X-Proofpoint-GUID: EstiKBz7H3t79Z7TVCi9HAUUtMW8c-ED
X-Proofpoint-ORIG-GUID: EstiKBz7H3t79Z7TVCi9HAUUtMW8c-ED
X-Authority-Analysis: v=2.4 cv=Ku7YSmWN c=1 sm=1 tr=0 ts=6ad900b0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VkRzHO9NBAn2Hx42XgYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX0cbNjNt3rWMw
 hHGLXQzvUvF/pyBN7du4JefYu0mbKvshFn3s3FU1dvP+tu5TlJBycxsNUPxmC9ne3n7RBR6nghB
 jv76JbYONtwT0bkjk5Vqy/qwGguGQXRS+medOkRCEmgvL8o/h290IZDekX8EYXRwYGK67DfeKsU
 U4LCWMA6S4hiCeN8Q4dJtjJdKg917CEKimqgKUQ4HcSj2EwHfP9gr6TS8nOYUq43j3TCz8+F9Bt
 fLONZvtTWkPsUVLdg9tKs7+FUkAbXFkjqjD/zkeplqgAr+H531ybWtDqEDq5k3b95Rt1TqiyyKM
 zQtNmB4IJg8hl5PDvjyDKBevreNtlVRI77So6JIYt73/sVk0JVqGYHUeG3jR+E9xtsOvanLeOev
 SnT+IQwvEylOxDM94k7ywYGh+2vS3WywQbsKTxR8SQzb4mcu+sIcW8geUG5imSQ9DgabdCK4LVb
 ng86G7RRc94nsZnEWvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210072
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
 target/i386/arch_dump.c    | 8 +++++++-
 target/i386/cpu-internal.h | 2 ++
 target/i386/cpu.c          | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/i386/arch_dump.c b/target/i386/arch_dump.c
index edbe99d3f51..270adb04468 100644
--- a/target/i386/arch_dump.c
+++ b/target/i386/arch_dump.c
@@ -428,7 +428,8 @@ void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus)
 {
     int name_size = 5; /* "CORE" or "QEMU" */
     size_t elf_note_size = 0;
@@ -458,3 +459,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size + qemu_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return x86_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/i386/cpu-internal.h b/target/i386/cpu-internal.h
index 75bbd00bc7a..7f234cfd1b7 100644
--- a/target/i386/cpu-internal.h
+++ b/target/i386/cpu-internal.h
@@ -68,6 +68,8 @@ void x86_cpu_machine_reset_cb(void *opaque);
 
 void x86_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const GuestPhysBlockList *guest_phys_blocks);
+size_t x86_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus);
 #endif /* !CONFIG_USER_ONLY */
 
 #endif /* I386_CPU_INTERNAL_H */
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49f453bb011..dd9cd7c5625 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10921,6 +10921,7 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .get_dump_info = x86_get_dump_info,
+    .get_note_size = x86_get_note_size,
 #ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
 #endif
-- 
2.47.3


