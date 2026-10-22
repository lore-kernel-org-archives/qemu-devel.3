Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFB6606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=J40P8BUi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ewr4BkjH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nd-0001wv-DY; Thu, 22 Oct 2026 17:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nb-0001vv-51
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:11 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nZ-0000KP-Cu
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:10 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKWlKf3413259
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ubDfcbqAarQmkZyx6uMPXMSuMLG7AFg4lOXxHY4wz10=; b=J40P8BUiP1qwad3A
 gxKsO0iUdTmVtc+AWC/LZC4KY4Xvy6aGXQ/6AWHNvkDxwpiVZ9INoOoZLoCUQxLc
 hKaOBGqg4b8wK34tz+bomRxM+r7DYvIYndmkTbqK+bPCRwQct1/S0BltdiOMWvO+
 Yk0GjYIrFW/gSdpFb8Vr6AcAMyAq1cpFPHoLyIxlHopYjZBzf3KT98KPvd716Ptn
 +XdzHlTd3I+gl9QU5i+rLm2HAH7XNvmf6xA5iqfjv7nHpTDdEnK8o1D/DK/AJHE2
 2l8k41UjOov80qf8yCCpZwX3wJAz7lxuemqOLImoh15RMOe8a3kJ12AjZyfEc2OR
 Jx6zKQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar8dt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad91787a1aso189553a91.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706287; x=1793311087; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ubDfcbqAarQmkZyx6uMPXMSuMLG7AFg4lOXxHY4wz10=;
 b=Ewr4BkjHPPxmonw1hpHsj/uLr6bFUnu/R65EWKdvAvSXJEJ753HJgaYk35snPdLbFt
 y+IgHA4tlLi0ChwJu/QVlKcwz0/TuhDA/3HxaMcBhTUag+NyPBXL3IXWDC1/iho1Pv6Y
 GShjRW5IaUA3NuS+Z0esLgKaUmY3Tng/pwSI4EaRMXGi7iBNFW/f80D8xDkBEyhlcUBX
 BzmQsdXXaqMkF/wp/goZHpfddBXNl4cVjq6HGIL/5CGDwkaJFJebLHK88ii5P2g1Msma
 qHcKf7CLnGArVfhOYmeIJwwUCZlX/z3ELGsxl6U6CVwDIqlqeb/76zMZfKyl5Lb8vi3X
 Cihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706287; x=1793311087;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ubDfcbqAarQmkZyx6uMPXMSuMLG7AFg4lOXxHY4wz10=;
 b=z8cumC/z/eZA4M53wQF3iczts5sQ+IujcVZtlLAuW4X06RMgA7xZPKkk5xMdQp+g6W
 6CoShVGKFitEaYu2TGUvBTiOHz+02oeVDBmXG5lPTDCLsaEhS1aX1rEGO8Nr79iOPpzQ
 uPtsf1W98jEiQsQdKLF3j+qiLSewPCkWUrxJLDbLb/+3dWmjDsMVeqz+R+uOyBxHApjQ
 XnKpm83fRKuWsNuD4G2VXaU5rVyuPmRiKuAms2Sr8aknvFZrtOwjlPFTjIM7y0Fe4AKX
 1B2J/KUjkruIrSFTC1e+f1aG1F7TkyBjJN75sCW/LQ4cP8iP3gJVSSSIJgbCgqHZLDBl
 kqBA==
X-Gm-Message-State: AFq9FYK4BgdFOPf1SvyNZSCmWLn5gQ5gwjTaQ/Xx+89HYAaVx4SEz0SW
 VJWN3M2dM6FPCT3CHnmiGUSm5jskXGxQ8gGKwi2YAsDRAsj/0TX1VKYgWXOVbWzqJTKtySCiT7O
 JTjMJIQq53BEJGUmoF5yBeJ5QpQblWGiqH99NrssuFfvKNT2GqKC9GH83J/3FJ4lgEQ==
X-Gm-Gg: AYBFou2xE/2+mMYAUPsiBJAO6o77OBTL6WV3TZFZzMpdNmJnBc/+ETFSKMENmisykK3
 waQD1AnBM5eNAlVXUJioi7Rv7pI2u27mALYCd/FdnktS2xvMm5yveKfgr+6Uh4lAq8J+VaQidZ1
 h/nWv3/rQo/xekSE+MFSppiWHWGbjP5KkEDE0UR8Ybo3AEGvaUnqWU3d41TkZvyHr87AtFEyVi2
 yCWRKqEnH8eYR/HAi+KsIoa3Eb2+ynhoFjdsNVj/DKubetoTjh/IFetLRTogSkRiz4ZYI5mN7s4
 iYiMELlC7A+cqmvh78c6B1Kn8vshQqztSzpybbHJvvwfy5rmnwHo3xT96gIxeFYkhDJYU1q8hVD
 +0GpWEmTOx1kuMAmejrguKL8Unk8PPwM9ZfFlsUFIjsE1sYTa62vmD0ezVNuGYw8=
X-Received: by 2002:a17:90b:3d89:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3adce5e61camr139360a91.16.1792706287319; 
 Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
X-Received: by 2002:a17:90b:3d89:b0:3ab:c80:936f with SMTP id
 98e67ed59e1d1-3adce5e61camr139347a91.16.1792706286822; 
 Thu, 22 Oct 2026 14:58:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 19/27] target/s390x: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:38 -0700
Message-ID: <20261022215747.2479440-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada86f0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=EDlH-CkopuZvdY7HuOYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX3RlsMzdCx7Ef
 8FSu3NqrhkMWO8GlfsXD9hiJmUbxI+l8cwXSnAsBRiff+hNUU23kyC6mNYR4qNTSB1uYVseF3re
 s14goR0ApT7d9pxBf+aXTjcU89PMhHo=
X-Proofpoint-GUID: mo-1so5bdeWF7LrPF7MOAVVSc4x5xqpk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+iQO+SkoR+7b
 547k97EbsOFyD/Xk/+lG+yHyCKo99g9s/MPCfMDx7g31OGc0ggIG5R1sdZHb/vd6YQsDpz6vvhD
 I0PeUK/gmCbfW3JNWZtyqzGkbX22c8ZvDs//sJFwbqpa4b2Z/wOajWtW5oRS3LojCE0WmYV7dHP
 zSmwXmrPc2cLtQ8BFObvkmqNUALYG9F5H/vqbbWl2NQ3C61UpPRuk+Kpioc9i1GB7A01XutX6d4
 jeUy6JDrR+mrNI98JCHhxtu+2T6cXp36zCscbQFxxXyNmNRB2tjLnzPsnFojUEbkUPYe5d48hXO
 HIwXaSqCOCMUPHDKchhNyjBlYeyA215BsB7yCB94EB1rtp6Y9OSZ+Y92UBwVaysoiXoZ/ao6Vjo
 FD9Kn86uo88IvB6GIpCJAmIDKbDzbuvK++ZgEnKmxRl7EEUwBM/AUAJrRGPgUGJx+0lI9kiRsr9
 IYM4HCChhbKJCmCx63A==
X-Proofpoint-ORIG-GUID: mo-1so5bdeWF7LrPF7MOAVVSc4x5xqpk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-20-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c      | 8 +++++++-
 target/s390x/cpu-system.c     | 1 +
 target/s390x/s390x-internal.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 15299dd7a25..5092835afc3 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -468,7 +468,8 @@ void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     }
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus)
 {
     int name_size = 8; /* "LINUX" or "CORE" + pad */
     size_t elf_note_size = 0;
@@ -494,3 +495,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return (elf_note_size) * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return s390_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index 965f5cf29ae..784bf4e90b9 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -187,6 +187,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
     .get_dump_info = s390_get_dump_info,
+    .get_note_size = s390_get_note_size,
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index 5bfc37fc46a..9dd2243d486 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -252,6 +252,8 @@ bool s390_cpu_has_work(CPUState *cs);
 
 void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                         const GuestPhysBlockList *guest_phys_blocks);
+size_t s390_get_note_size(const CPUState *cs, int class, int machine,
+                          int nr_cpus);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.47.3


