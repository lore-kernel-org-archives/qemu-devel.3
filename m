Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16630606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FXmS7zOB;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ONPTGkfc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoU-0004Ty-M3; Wed, 21 Oct 2026 14:13:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoQ-0004SX-7S
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoO-00084e-Ky
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:17 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpjTW4040097
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zlXbTVeWFZwsfRc9vm8hY0+L+2iMTjCs8AdXtzKMREY=; b=FXmS7zOBWfB7pWR4
 tF5rQCVDUnmhdSkS/MH2ooyRVcwY2dR4qgigeT93+uR8992BA8uMrBz4WAiHBa5i
 LNW6o3oPkWn3LNFdVj4vWPip294gRsSEj6WtscRKTpfxob/XmDbbXOqWzBODF18L
 CqRG4zFVHE0KVKSmJkSu5Pq2+1XSY5L3myQIiQJI/eX9dJQSGPji9AUYBgwc4GV2
 0BfpKTsbZs9B4y9DNAlz1T4ikL5VG1Dlu6z3PFV/q9etHw845IwqguZZjLSBjA/p
 jzf4us4YHTBFWiF7+Yq1+V1bBDH/ckbl7T7u3O0azn7HMvJkbQXdwJYbl0fHS1Wi
 m6l4kw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7ahn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ac0ae43900so1191612a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606385; x=1793211185; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zlXbTVeWFZwsfRc9vm8hY0+L+2iMTjCs8AdXtzKMREY=;
 b=ONPTGkfcn7ud7CuxqMa5IuoeTeo32J5Gy279whWx6h+EX8krzcWbIHDqgLv891xkmB
 8ODjDXoCkIku/z4h+y/TbRsImAd6y0nzdmQlwGACi9s+KbAmrSK2hdq68LQPLMa4WuAa
 46BE1YAVjMELwwRt7XHBZAKkWHOyAQam6w0NcPul9G+3COMSPMuScQSjt0KXnMF7bOou
 OVanjxLC8HHThdkOGx+n8LIpZNoqtXXPbA+Hu8j5F5Wk1TUOXdWDIllDgt8oZTjfHNoX
 ZZsSb7OMTadvXr/WWrAI/eAMlMV7U5fbeOubAtEEQHIceSiFrry6bweZs8ekBwoTw2PM
 DSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606385; x=1793211185;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zlXbTVeWFZwsfRc9vm8hY0+L+2iMTjCs8AdXtzKMREY=;
 b=n8cLh+bw/LG8DihpksE/hW47xkAeGUMHsMGGrMHP4BpGuJCTmXCxu+j3oVjr04lwnD
 Kx+WlaYmQyVPCuW0sEieDE7ojY3+/dMvh8+YJEisHUstuvYFfTKGO+VRi0DUWFWOjvEw
 2UI9aAYmF83eSppzDF1xHnh4LJA2nOMsaRgs+37Vh2Aguz+tgjblTXmP4/mJj5cGtWSA
 YBUArUOdOFtVw98uV7tXjce70b8Io/fYRX6/GrIFYFukP7oGKUCqT1bkt8wvRKcH5Fpg
 rXDed3y/XX3gliuSzjXsOBx5bhQ65jgQrs5LbmWlLWEILkfk4eM6ftmX6HYL4noul7zP
 7jZg==
X-Gm-Message-State: AFq9FYKhi7Ht5JkldssKHKPjGhv53SVVwunfrWApiFzgn2DnxzS+a5Xw
 wenJMxLO9ZVKffDEfunW9F2snywubd6hEB3FatPEP0nw1mGmrKBQFskVE9WLpvxNGSeTadkmEvl
 pDbi7i+Jt2bczkOStQKvtelwa/YBJkjA5cLWU3OecCfkVPnoB4N2yrKGDdN8G8gePfg==
X-Gm-Gg: AYBFou0HteqcLUs4S42/WJI8zUm/siDlLJCmFRKwbenbCfJX2lDuD/3jAV71zDCj5nI
 I3e02jFB+5HpQvjdRCXWhbPXn7MHB7bmLs2avLWt02KAxre2ZOGQZZYO5Jl+k57nVPTUIENs2ow
 a86DEpCTHayBTIWb8LZKDfFVkqZj+KifsQjMc4jonW2WEbvpbbRLwJFIn9xjw8FrL2Z5THIM/jP
 H5p7JloWYA0zV/oBAWGG2V48DPF9hTtIqFCGJ0CbtxiwvFIaZSgWl9bcP8069lOKfXVpeBYk5d0
 fCHbAxbdAguEkGfAZ4F3sD20JaVYKg8Zh5A9JI6kmBLTXgacHQbJBkrauUh4yNY9wfl9+tycFbv
 v4Ekl0u2DajIxuCBrbxlHNZxwKuW1qemPvZp+5TO7S4TQEF1lmPnzi3yEHL0tAsQ=
X-Received: by 2002:a17:90b:2b4f:b0:3ab:c80:9365 with SMTP id
 98e67ed59e1d1-3ad86d5066dmr2270111a91.42.1792606384591; 
 Wed, 21 Oct 2026 11:13:04 -0700 (PDT)
X-Received: by 2002:a17:90b:2b4f:b0:3ab:c80:9365 with SMTP id
 98e67ed59e1d1-3ad86d5066dmr2270094a91.42.1792606384108; 
 Wed, 21 Oct 2026 11:13:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 17/21] target/ppc: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:40 -0700
Message-ID: <20261021181244.867840-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vLnJuLEZ73EfjY9BtUVw3-ulgIxo1I6t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX3LUl1PsdmQk1
 56Neanl/b8N70cn72vJxntkyAw1CKk61PZS4xjtseSbsdkHc9ELXeuMJ/sS0XRLgoU/YIedm6C2
 fmz6nILx6300Hgkc4s/O4yHZCkX1BBnEz8TFWrUCYt+enY6fde/vWWPAf408a2tdtoO+/wars7B
 fLLk6igN/9mJI5jYJuxTBcHhDrU8p2fznS9aO9EY7HWJs2yNJoPphhp8fad82IiNieRlvLGgsM6
 QZapE11tZQYvWt9R4AbgsemBLADGZ4ak/FDtIf2tRPlrYgCMlHrey9RHFQNywPeGQTQssRSard7
 OjyDGUVv//4+iU2wf2v8jxOMBRLsk4T19tTHb/EeVp1jETricBHfgYtxsSH9rElWxZLMGT+npyU
 m7fZ5eXZzq+uHondeQeyaUKvtFSbIsTTuoguNpGsrZaIbw121oxwle+YeWEhh91RL4oFFTbvb3d
 8i4lVy5Qrm/Vl8XWaNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX2qAvNXZGbklX
 FBrS9I6d4kJc1m6480MLUFeH2rjDeNnVre9gFLwKhD+sw9YNKsEbSJ+1so45X9abISujHlcCDSn
 imobZevJ92Mc0sgGYB94iA4cCzRKWg4=
X-Proofpoint-ORIG-GUID: vLnJuLEZ73EfjY9BtUVw3-ulgIxo1I6t
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad900b1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=Lumvk8zKUu4O7nVSwh0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
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
 target/ppc/arch_dump.c | 8 +++++++-
 target/ppc/cpu_init.c  | 1 +
 target/ppc/internal.h  | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
index 86e31c65467..42e5cf936d8 100644
--- a/target/ppc/arch_dump.c
+++ b/target/ppc/arch_dump.c
@@ -250,7 +250,8 @@ void ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus)
 {
     int name_size = 8; /* "CORE" or "QEMU" rounded */
     size_t elf_note_size = 0;
@@ -266,6 +267,11 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
     return (elf_note_size) * nr_cpus;
 }
 
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return ppc_get_note_size(first_cpu, class, machine, nr_cpus);
+}
+
 static int ppc_write_all_elf_notes(const char *note_name,
                                    WriteCoreDumpFunction f,
                                    PowerPCCPU *cpu, int id,
diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 5853a92bffd..578dd9194eb 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7474,6 +7474,7 @@ static const struct SysemuCPUOps ppc_sysemu_ops = {
     .write_elf32_note = ppc32_cpu_write_elf32_note,
     .write_elf64_note = ppc64_cpu_write_elf64_note,
     .get_dump_info = ppc_get_dump_info,
+    .get_note_size = ppc_get_note_size,
     .internal_is_big_endian = ppc_cpu_is_big_endian,
     .legacy_vmsd = &vmstate_ppc_cpu,
 };
diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 02dc68fe2c9..b3ed57eaf73 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -327,6 +327,8 @@ TCGTBCPUState ppc_get_tb_cpu_state(CPUState *cs);
 #ifndef CONFIG_USER_ONLY
 void ppc_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                        const GuestPhysBlockList *guest_phys_blocks);
+size_t ppc_get_note_size(const CPUState *cs, int class, int machine,
+                         int nr_cpus);
 #endif
 
 #endif /* PPC_INTERNAL_H */
-- 
2.47.3


