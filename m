Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B650606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aXE4wkRk;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FkfSOwI6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nd-0001wz-NL; Thu, 22 Oct 2026 17:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nb-0001wA-QQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0na-0000Kh-6z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:11 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtOPb861296
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XODZhzhla/ejts48iW/V8//dmU78Po3MFS1W/UNJ/Ps=; b=aXE4wkRkKsZax1vz
 eNgYLuFb/5RQ/76MOFPUp7s2BXcc3toeWS1OP1NWdILGsq5LUwqyfHwo6C/XrNx1
 Rtp5MzqKxyrDURGZpBNFOh40kw94FKE5PJwULkLq6bB1Ey/81mON3DmUOKqTX/2Z
 rQnINvDtX/4/ebbnn92YGUaj1W+L4qr8ltDIzcTVbBFrrUFA+sXJgYMrxSRuazwk
 RmIfjvsNGvD2hClPODgZeC70MoJp/TSW1ox9Uf4JLLUCoKilvRl2M0AnjK9vew2D
 ODsfX01uKVFbE2uiOBwzWaoMQUQcQLUA14x6p7NaLhO2cjPoFZIsFbKesEdzSnFF
 x/L28A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnq0ha4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ea0fe07201so1394525ad.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706288; x=1793311088; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XODZhzhla/ejts48iW/V8//dmU78Po3MFS1W/UNJ/Ps=;
 b=FkfSOwI6XVaRDWLFCPBmQzYmGAF5BZCcr5/Hd/LmbtpuhOh2AS5BBgY0ieTBz6rKuw
 xt367MP3Ucqkaaq3MzX5oNZ3SLXNzFubeYQcPMb38HWfNYfkPV4rElndG00o+hdUTvt6
 jFrVB5UmGVykTMbb9gQ/c5DY5rhi38Pmnec2rJPHHOZaiEkOws+0Equ3rGoQUh1VUCxT
 cNNLZStMT65Vmrt73xL+cEQn+INQygLJJzWshwZUJq9GCrg3zTsin6fbNEWB6dFE6gLF
 4kMcBWVI/JUPFyKxIVW/uG4wOmhX/exfFNF2cTYuh7I1180IG8ltqCCyVYIvul5l50IK
 8MeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706288; x=1793311088;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XODZhzhla/ejts48iW/V8//dmU78Po3MFS1W/UNJ/Ps=;
 b=mKxWIAr+ftb9D57A9QyKZFB4nrw0BDW/YiPyJYRPqPNYfgCoghlLY/r05IKDMxysLD
 YrpSO8r0h7SsHPmqEgdpPPeu3jX3VMoavMl0VpLhf99xEoBoP22+2s4IWMj2qjmaH1Ep
 cNzJA+CXuxXcznuR9Yb2W+Ozse/A3XCoAt3q5cKFrmgpSWP+rfswiOIDSl1ytgO578Kk
 JY9by9jK8XLkQL7IoBZQgcF2yLjRIAK5dTYm7v748ItJ4Lae1uxXfBSAVwUrHQ/hdCsI
 Z+H+kCj8Ll085qjbGZNVRb/687iJ1wmdGi3cqxPh8mY9yBCIjKven0t9mzAPaRqWKLku
 TmHA==
X-Gm-Message-State: AFq9FYJMgYErZXIu9IV5TI3RZH+y3KEDJ0ZBiaGmBbFik89l13LSvfxA
 mFnNO6CmVrWvyJPfbq6tTxDga/vXC7yEvOu9QHlcMXaE1hyJOhN4BYUVuCsH9oMIedzG/03ap9j
 wsQ39HuuLNza6cMRT4Q9bGAZlzw7ioreW6x0ee+vnbyXssIr09nPuVBjWrxuTKudjiQ==
X-Gm-Gg: AYBFou2syQoYBo90Koqs0q2I0s0Mq0V6zslAqBfb1lYFR6vLRqf/8TK8CjRzS9QzORC
 25uadeNGvGY1z1wPJ65T9UsP0BUbPMEtI6EX3etqu/t1ki8dwkhkedp/lL/pfsSnZwA5h1RVZOU
 sGQ+Mip6QDo6XPy3Da0x9idDX3lCc3m2GMXlUIg1mYB9NMGKL8aLJD3UejmSmlRHMEDbequlUjH
 +VIkK3GZ7GPg8Mlsr1HVGfw6/TcLAtrvnP7h8sS3Sswaumpx6n0QayphmHGe/Ne7HpGBL2+Sqml
 G6wXqa367ffYLQePU0B8m0+gEiLwa9fMdiq40+YRf5QMhsmQioN+oFKWRMq8RQwWXGd8/R+oKG8
 4l9rZkbbP8fHjwi+MlMoh+Y8FQd4hBguh8qzMKfLL0Ubf42aIjOuYxb9dcol6GWs=
X-Received: by 2002:a17:90b:1dc7:b0:3ac:adce:60a9 with SMTP id
 98e67ed59e1d1-3adcdc95144mr223602a91.9.1792706288128; 
 Thu, 22 Oct 2026 14:58:08 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc7:b0:3ac:adce:60a9 with SMTP id
 98e67ed59e1d1-3adcdc95144mr223584a91.9.1792706287631; 
 Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 20/27] target/loongarch: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:39 -0700
Message-ID: <20261022215747.2479440-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KjTkeeW4OV0o9L2lnFr-Tv65BEsOIGBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXzkichyXy9jVD
 kwoFggy6evX9dqjMIkFkZwbaivyzOoyxRggiOE9KrET6dNj6LCw4MX4ISfG/tesM+SQgBeYCPO+
 f1sk9bgnpODAJm+nIKwQIFjUggrTVtJXVgb5rvASswHblY1j2axlDHTdZT5nE2kn+WVim8QGKNc
 r6KUtJVfMvtGaPHlQ7FgjHj4qDrelsiMJ7nuT9R2LtOZiiuS9PLT733vo091volhOkIFVmP11Am
 QsZotWNVgoaOeQSOkxuytP6uSLjzKdwYFN3rerhxFnBR+K6HYMu8zoWRu8/8Sx9dIg4SinwZjwk
 gWJTrK8THzx9ekhoat3AE/aZX29xLay0lkAm2F+gDI6mjLDaIjOdvIbynW9lgwhGrvX8mgm8DRb
 FtUfyQTbCvLTm2yTLpcvFZPSaIAVs5eBSdrKvXstBx3o6WM9XNO6J7wWImX/5i+TkIMdq1k3kDA
 q42V6aLWaYgwvi3bnlw==
X-Proofpoint-GUID: KjTkeeW4OV0o9L2lnFr-Tv65BEsOIGBn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX4BSjkS5rMZ3u
 YtqFHUalboHev9pXgOqzAdvj1K1VvJbWDj9N4zG7dgcJL52ZF813dpy4ZDbvdETRaw1c0WMC4SA
 IbUdTaicCKdGJYi4lMj1mRCyQuC4cDM=
X-Authority-Analysis: v=2.4 cv=UaHE26SN c=1 sm=1 tr=0 ts=6ada86f1 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=VoVa20T_UCIUsInyF4AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0 adultscore=0
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-21-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/loongarch/arch_dump.c | 8 +++++++-
 target/loongarch/cpu.c       | 1 +
 target/loongarch/internals.h | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/loongarch/arch_dump.c b/target/loongarch/arch_dump.c
index 853a60d7b89..47036105e0a 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -150,7 +150,8 @@ void loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     info->d_class = ELFCLASS64;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+size_t loongarch_get_note_size(const CPUState *cs, int class,
+                               int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -160,3 +161,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
     return note_size * nr_cpus;
 }
+
+ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+{
+    return loongarch_get_note_size(first_cpu, class, machine, nr_cpus);
+}
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index 65772f30947..5e182922b7d 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -842,6 +842,7 @@ static const struct SysemuCPUOps loongarch_sysemu_ops = {
     .has_work = loongarch_cpu_has_work,
     .write_elf64_note = loongarch_cpu_write_elf64_note,
     .get_dump_info = loongarch_get_dump_info,
+    .get_note_size = loongarch_get_note_size,
     .get_phys_addr_debug = loongarch_cpu_get_phys_addr_debug,
 };
 
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index 041d07442fd..952c98f74ae 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -53,5 +53,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
 
 void loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                              const GuestPhysBlockList *guest_phys_blocks);
+size_t loongarch_get_note_size(const CPUState *cs, int class,
+                               int machine, int nr_cpus);
 
 #endif
-- 
2.47.3


