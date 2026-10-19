Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DE606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 21:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V6ALCkZe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gBNIW94f
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIuvF-0004eD-Gm; Mon, 19 Oct 2026 17:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutX-0002uc-UC
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xIutU-0006Kt-S1
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 17:27:47 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JJK3p4501259
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qGlHPSLqQRb6k7iy3z637YD+y6sVnnmdCcAdi3Of2es=; b=V6ALCkZeHBcuN42b
 4sF1yLkH7LVO8MOYTZotonLMYS5WLVy4O6sXH3bt0A4gITXkS4mh32H9SG53Sctl
 j9x47xBjOnSSJ2iLUO+z6wZHh/iTdI6DdRwPb0OeEgWeur/jPicc586emC/0RKqZ
 h6jSExRXbYxtNn9pEq7uUZ5JLrgPJlVNB85lL1uUi/EhCq3U4O1PbaotP79G1Fb7
 Bp8glE/68Ao1TnjWUKaATd8QP5Od/XcmgzxGO5Dv8AJOCYhY3bG5fUzZ4lqIPeUL
 BckLl8nCN9aJ3i+vR7JiWFoquRkd13sNHXiyqZ3tG/JAiaugdJ0KdaZQ5YyOicmU
 kINndQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3fbb94-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 21:27:25 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so84019a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 14:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792445245; x=1793050045; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qGlHPSLqQRb6k7iy3z637YD+y6sVnnmdCcAdi3Of2es=;
 b=gBNIW94flI9NmYLR7QU47PssxEJlHZ8BXkPT93otNtAghNoySACM/5wkA3B8VO8mNP
 cSOMXaDuT/n/I4vxhYPKXOCRrUopiOKSmzz4jwKZQjkSs3IcqWwQ6+YWZG8ssJrpy2Tn
 3PRTrJ+XSlr+DKGv6G9mXfPYiT4ailsZsoQ+sK29GXkAQuWFhhIlmpSky2MvwXV3JWkM
 xRxOdHUj3CL/7+0rHKbtvFkfgFHkGSDR6XcbUXRqiAqZpN5yil4iRCtuKGFU/2YXLEN1
 /WBP2i+GVMq6dG6hV4DkFtFrZ9Pb5bBMDxjJar1V3n/C8iAU2kE5ftoIMGAGcW53I1rF
 h/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792445245; x=1793050045;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qGlHPSLqQRb6k7iy3z637YD+y6sVnnmdCcAdi3Of2es=;
 b=KkYpI4/Py7c1oJUw1brZ9fACZ5H0hB9ZPPVLdpsUGbValikoxfkOfjH/5lCjlJerZA
 Woy6bLPT/SNyGs6FMFYzQrTmQ4b+NyGQ7I/DZErPQqXpE6SZJax+iKxrlHbJ0PX0V5xE
 U7fUE1Bah3WVtcjY0Rns+x1lo1SvJ/DP5EtSOi3wc7zWbnrSmQWYiL2WJV/Bx8mm1Ojw
 P2gxSYXhESUP/CIQ44nU+/nGD0YGC5KCD61r8pEpr1nnGHNynxf6p6XXsVvXNLHKi+O0
 ceia8tVjpsNlN+X7Cc5GPomxw0uZjG+UjARMnHUO4G+7Vmvf5n439Zm2IOqCAMRkghSY
 AxBA==
X-Gm-Message-State: AFq9FYJWk3qITOEdFFtykeosqLWA1CaEiLk6NvT5GPuE93ndiHuWLd7R
 ecUl69Yskt4aB5W5jBsiajFOu0hPMeex60U673++QkHCA3awAsJewB31QxQHMthDcXtE/cbmXgz
 xLkmxQCL5HSfDG7C0czSB9j80yrYnLOQizm7Abh4PqlbNqh2rYdtnVs3tu7sTeCOpew==
X-Gm-Gg: AYBFou3dfs7BwWpuBFdFQBHvoI3S0ajp+2ZvShaG84R6ZKkY3rdDghOXmst7789salo
 fVHhTh4VbpqDoT7AlJbKDubNAy26x7odVVvCSMAWD9uQpdcR8YcEaZMhkADwM8a2o2I5mC7jFDj
 NZVNdMhcqnWdpP6SHPIq0QlJBSWlx6bIFr2UhpY1TbB6Pk/Nk/9VioOAg1scHmWrSwrYhESiJUl
 AphqKCXlW4UkzlW6eeZbUswHV8cOX/2nmWLwwlLmTP8Brs7WLVJIyZIcceecFesf4hIvPYGhUzR
 Zg11/AEXMN3ie8D615E/4kZ2w33zBmlAFsSt+rKJRZVp4fMMUa/JhNrLaVM2jDHIwBdEoRGpLLr
 V7iHu3EEvb7cUqTjIRUkm5K4f5ExBB9enDQKaqjAgoPmRy68p0F1E6D7lvHOYqdw=
X-Received: by 2002:a17:90b:2b8e:b0:3aa:412f:b0a7 with SMTP id
 98e67ed59e1d1-3ad64b8fab6mr189703a91.5.1792445244684; 
 Mon, 19 Oct 2026 14:27:24 -0700 (PDT)
X-Received: by 2002:a17:90b:2b8e:b0:3aa:412f:b0a7 with SMTP id
 98e67ed59e1d1-3ad64b8fab6mr189691a91.5.1792445244218; 
 Mon, 19 Oct 2026 14:27:24 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad60f2c785sm867061a91.7.2026.10.19.14.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 14:27:23 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v4 20/21] target/loongarch: implement get_note_size sysemu op
Date: Mon, 19 Oct 2026 21:26:47 +0000
Message-ID: <20261019212648.154493-21-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261019212648.154493-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: aedDc923qiJrT0hx9VMRIgLi2R9NUskz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfX/7HoHJwH5WNj
 JsGjsZd/VDG/tufZ6QtQ0YbPCJfh/S9uBd4tzwNHNOYV28Ml+hJ/It40HI70jsgO6blytC+kQEN
 ZpAcuVpzXW+vqpKeP3Fld2TjOb9bgwzTY+SHX0twFWUJ4yFayBOsWUO3c4S+ifc8W2OCjlHP6OG
 8YcTi1NatibODsf4tq2STy2XBtsRxKRBoLpsz+pzam2fBaUugDdoB2rZ5HcltCIgBDGqbUriU6z
 E0COxLeWAhio3lzBsUtUo88erfy+WG5hyP/g1dSGwRZsnUq+1zQGaGrTIM4P+vYEGsZmVOHlTDk
 gNEy0DcAtSJlusm/E9Su8RlnBR+rxn9Q2RN0ImWlHLIfT//klAgoDda5g+BIG2F+K8PIAh6BSgO
 Qz9tgwXmekxHYqccQ2CQktzO2M5Cc5rl1MnNkqzCBFFugvTZjtZHVR2WDwbY43X/Kvwjfw1zjIh
 w7lRNF5y7ITN9WVxBsw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4NSBTYWx0ZWRfXzg50Rpo29U/H
 5XUW0hNs5DubR7OoRct2TmzZqDZaghI31hWN1TMqbwPQM8N/GoWM8PInuWeAy80jNwLrxInWOtk
 RGZWmo6mATAZYnYJ/z50dwzADcwk2wo=
X-Proofpoint-GUID: aedDc923qiJrT0hx9VMRIgLi2R9NUskz
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad68b3d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=VoVa20T_UCIUsInyF4AA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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
index 5a0e1742242..e27bd0f6497 100644
--- a/target/loongarch/arch_dump.c
+++ b/target/loongarch/arch_dump.c
@@ -152,7 +152,8 @@ int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
     return 0;
 }
 
-ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus)
 {
     size_t note_size = 0;
 
@@ -162,3 +163,8 @@ ssize_t cpu_get_note_size(int class, int machine, int nr_cpus)
 
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
index 83220f32aaf..4b37e88070c 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -53,5 +53,7 @@ int loongarch_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cpu,
 
 int loongarch_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
                             const GuestPhysBlockList *guest_phys_blocks);
+ssize_t loongarch_get_note_size(const CPUState *cs, int class,
+                                int machine, int nr_cpus);
 
 #endif
-- 
2.43.0


