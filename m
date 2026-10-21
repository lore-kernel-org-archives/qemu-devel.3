Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE95606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QEf+7G08;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bUPLHNLO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoW-0004Ud-Jz; Wed, 21 Oct 2026 14:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoU-0004U1-Ob
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoT-00084u-5g
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:22 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpPXr791166
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 h2jTlZiDdjPjAMEPohS+5uafdG9Vx/YqO9x5Q4tOymM=; b=QEf+7G08fX3BfnRO
 vo9ZB/quMOYqi7xrU5vvuDXVQFVjIOI3yr/EiQHQryjOLkrYuhmr49LOiGEPRLi3
 M9SwcblwoOAS83JiC+6ffi5Z8Jkt6tjXtuzM3CyyyUH4qpDEhw08AGs+H+0FAWMn
 hU9IhNZcGV1OXhNHkYhTrftNsInPvPdbcEWS7yBzDWbB962bl0SvAvkoNpwXjrtv
 FdkU1LkGPhPSKWHvNgikDvrwYJtq914XqCAIKjM+70FcKOoqBUUpBXLNyW8UH7wJ
 xsPuIHUDlTteFC5oWfbw6jpAIKpUG4/FhNOxU0D30WnLBm6AoXOhEIlDgvvJsMoE
 uCYm1g==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0cv0n0p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39de4e72b33so1510382a91.2
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606389; x=1793211189; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=h2jTlZiDdjPjAMEPohS+5uafdG9Vx/YqO9x5Q4tOymM=;
 b=bUPLHNLODKc02PfwxWR+ij4UgvmKas6lK6IpJ/S9ID5isppWbCLD6JlV0f9OMmlONC
 Jjg8OwznYoLMriwn/6lXckAtGw9oI4UNnJv50R5Emma/yMEl+kweZCeggqZQ3kQQcdyl
 Xs6aMZcdUqqdUVzrihQAPgQLAMoVPZYbV35wvE01sSKmUDKnrrMcxPdPm+ZtcoJSnuJn
 gfOs8I5BOeW2O+J2cEhJhH4yAvl+8P9JJUDfvfK4gGhPVO3u2Svb6qNMpJbQFuQqVK7V
 dfu6hwcUaaDONYuh/r2M49OJlWB+dRsEqwnMGMbh9a2Nvw+sTaID5TD0+0iXR496xwdL
 PO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606389; x=1793211189;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=h2jTlZiDdjPjAMEPohS+5uafdG9Vx/YqO9x5Q4tOymM=;
 b=yf9hm5fj2QD6FLGFGLCUyrgpmjuyU1lxEygEk34FR9sjo0sFQ78dABPMA7Pp/Y+lbM
 jcDWSkQPLDsJ97XA1TkCJbvCfDBui9OvzZci/1ZP2R/GWwPmvT6CZKULkasc3eblPRwz
 kUNOQuPCDhuXw1+FXAXZQ+scPvsjR/awkxD7pyfxrMYD/8KARRf560oOVTH3PA2jCA/u
 HDSexzaU8PtydyHOpUoNYEvWTnwrfCl/Oz7KDlJvjkiK8NuVcPXfVP1pmT7YAwdsdUKG
 bUF8Qh0mLI6K+otFFJtRpM1kCBZ2bSc2NVxt50aSHtAE5bSRV0O4UNeBNWfe1lcmWqp/
 FZoA==
X-Gm-Message-State: AFq9FYJmq/gorJ3y2FfzzGr7RHoPWH8mdYfwnibID6IKV+zHJyu1lvr+
 FeqAqyeBM7iEfepzZMILIiXDvb3aw8OQP/esULRemBIRcdJkZk7ruV6HBWF7HXA1u/v/FpDIhbo
 kx+uPDFSo36+7oxaC9OA//wyAHx/r1/tvvdahc9an8H4I67VWuiF8OJYLZm459H47yA==
X-Gm-Gg: AYBFou1wuxXik5+mcnzGTrISyw9ENlOyKVqFjyBlwi3/WnNDsp/ufE7BbIy1o3At5V2
 wjC6InJABwZmvXxdA7nrQo6xsl1MnHodoK08bVHSM6RnwZp41ksL0R17Vi2mMEgDVFkmg8GDkWG
 Z8MtlNHgMPmyZngBXqI6zSokW5xqI1rB9iIlmNJziMOY4l1Z5Njg3N7lFJ9MeiWSGM+gfxLi/Gb
 KjZw3OXAFAJkqkXvRxVm25DypGamlj3h+FJG+yJbCq4BsFyxGzroQ9RU7mGYJUMoYp+NPkVOioR
 uTmfACyKrNN7tiuaE+HEcq7Abvz8anlxLuCkswQbfTe4ZHLGvIDCPsvqM/60ypAMeLgrMSKwuHq
 vvw37Z+Qh/1tRz8hZAplqn4PwxV+nbOyZLOUdyCTpe3K97aUahV9JeIFAQD4VOtk=
X-Received: by 2002:a17:90b:570f:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3ad8707153bmr2338922a91.49.1792606388918; 
 Wed, 21 Oct 2026 11:13:08 -0700 (PDT)
X-Received: by 2002:a17:90b:570f:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3ad8707153bmr2338869a91.49.1792606387074; 
 Wed, 21 Oct 2026 11:13:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 20/21] target/loongarch: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:43 -0700
Message-ID: <20261021181244.867840-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NrRE4MdJ c=1 sm=1 tr=0 ts=6ad900b5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VoVa20T_UCIUsInyF4AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: L5fUWn1SeFKlr0cRlWjR6oLAHhML2C3Y
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX7W0NKPcyIDnf
 D/vvz5t4V38RcPCuSwbP7gJOIt+EWBqEKkE4gsuFlOA0/977CJKXlceyv2ugO/QfBx0QK79HBrp
 WwjUSieYsSDI5R76DwQJrUTobO5pnu0=
X-Proofpoint-GUID: L5fUWn1SeFKlr0cRlWjR6oLAHhML2C3Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfXx9eouuIdn25y
 WX+fVMgr6DraIyyyQtWMLmxosuLdujU+jTda4uHrlJbEOe+pvs3ni/WjGhnzZKBNttgcOzTJhRv
 dHXsOdeFbQxu8JBhouRxBiTer0Laf8XqFYhLOH4Tt3OARytDBJkyplnTaPKEbg5bqnudmxYp6pB
 FaGr666znc3NyMyGrOBZ6tIN8X4Dcj8/stLpz1VduL6HOCtNpUbU7xBgg6ViDFG7tRpnMDWIPqG
 5f7Uwr8D16Ox3k4FFSrL5L+Xmmff+aHUqPLzXCZvkFYu8uoUIlHmNZlDJKLZwofp9ztvp/Tvslx
 SmqjGMgdpB//KcfEgjjJs3Lc9+IfO4unSNVSclUzNtEnmfBt2KnK7Q+hLZ4s24ovOJ+gWDiiScA
 d1TnHRY4poIbDzPqlPqv+yiS7JNfJqjiSKl9+YuGH8+WKMN4SBVlmfku7Cj0bGfVjkVXde7VYlm
 wJ6y7gYbyEui64qBL6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
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


