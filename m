Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F38606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=I6ViT8yV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GkSWanu5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nW-0001oz-R7; Thu, 22 Oct 2026 17:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nT-0001nW-2b
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nR-0000IH-Cr
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:02 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVLE387736
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tkalM0EFshmDlV4tPhWDUoFA7umx3kTYMyh4HJ+zAes=; b=I6ViT8yV2v32EuWi
 royPI8vQc4UVY6e6tZu4VtNzKxY1IvXJ5Isq0SiiL+pcvIUtEtNWlsFoAd4YAGpg
 zKFleICBmJVhoIprHxvflS4eIy1M2FUKZwwr6ylcOALyzBseUb8uWexNt1AipAYr
 CjsIDxCa3Uv10Ca5XA+V+6+1ERLx+kT73yhN/wdTYsRmZi6IuYQedFHdukO10hHF
 W/1UrzjnBBahIejrsocdvEJeWWKz1X/nrwb4hBsjkxXcFIr7eOg4LFx09oBMZKl9
 bLKJyQcy024ehbsY2bo8hAwYJ5pGYifhxPVi7r3aF/CG5UDsPCOelMREQ8AMbJiL
 92BpzA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq4rcw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:00 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb92868263so129998a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706279; x=1793311079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tkalM0EFshmDlV4tPhWDUoFA7umx3kTYMyh4HJ+zAes=;
 b=GkSWanu5ixBVxsdVmwfN3RV8sVsUHUd3ledAPebehofUUUFQzPIKv1o/7lhqW6UwRl
 zpQ9tgkVl3CscCJqOJF9C8jIixqtM+a3xBJf9FYqpImH9lAoIXs2L/WgpVfVKRbcQZnT
 I9oWgDEIfcUbsA0/eJ3UwfHrMnc1DFqlUrEZVxRUWmQShI0ewVI2980oeI5UzTBK/c8r
 uA3MbvKm1UfnDgoB0JtGhI/ZUtyFp+2DxZgxXD/6EYYgo7ND612KrRT7WLdEP/iAdb5d
 urY/tNBfZTjOcZwMVrGKxkGkKiEVMIQnBadJ/8A9X/ugVZwAycLzxcBDXBltM1rKz6il
 r77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706279; x=1793311079;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tkalM0EFshmDlV4tPhWDUoFA7umx3kTYMyh4HJ+zAes=;
 b=VJ2AFhdpdhCdsa/x5ez4qRNvweYx11y8hQhZUzxz4IH1T464EL4Mcj3uK9fz12vyfG
 WZVg9+fKb4kDbvreso/PGWAQyp83BQNM04CAxcx5H9jk8LgKYt7nPvJrxGqLCL3KynRF
 zVeSgIOxrCbqjWwTHUCUM/RQ47i0o2BUKUzUylwJ8v/YL6kBlxrN8MlzBDUAyv8a/niG
 sx2wLmDROaZfSspDiQVX/C3JaTz2JFXUXu9PAdIvqu2Ui0579PTs/a+EDqz+Z8R28C0X
 EyOI57q+ekEjixLNtIiYVZ+L8ZZhHIbtIfuePaLtkif19jaAwhMn9PMO8xx+3ipAg3bK
 axlA==
X-Gm-Message-State: AFq9FYIhecX9QCJMTblA0PIh00Xx4C4n1hper6IeWdQeuuN71uzgBh6m
 NJecYplIwudUP7L0UkYdhfloCCFjSjRK+hoPGvDopveY2WW53ztxrVX0NGQJdYyimZGV78YcbJI
 9rPM7yvXkcwRLs4iNqlF/VuUWxlsDe3RFFHv3z0jGzr2byBUFknNDxEoFrg1YWW9Y9g==
X-Gm-Gg: AYBFou1WUAkG1C3jcYibPI5Vd1JxYea0L0NoZerQo1a9Er4XhAYpLN/K+616cQK6ScU
 zvX2JByVlaTaHYo8the3lbwyXLrt+ODBVhghPVXjNogrZJk+RgCNK+iLHO8vrfWgoPvY1RabWAO
 vJ1Wg0V8gDSseKZim9uEts15LrN4W2vJ6UoYqNZo1Xa8kVraiENUmaAjDa0rqWvKcyjTkv3cCco
 DBuX+iENkMRjf3TKw4JxPXWqifoituNFbIM5OsbQ5g90NKo3URyD3F/MH+bTTAi33V0YwzfisNy
 vBXt+fIEhHNWTXNFMiZyFWF+pjaguUL404o42+OFIMBFfhEBKbcZ4BmR8/6UPUy1tHG0dICi40F
 x30yeGMd5OUtmln2VSyAgP2qmlXFbi1AhDXZt/ChwvEikRSXh2HN2yuugEcvr6nE=
X-Received: by 2002:a17:90b:50:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3adce422683mr149056a91.27.1792706279423; 
 Thu, 22 Oct 2026 14:57:59 -0700 (PDT)
X-Received: by 2002:a17:90b:50:b0:3ab:c674:d83c with SMTP id
 98e67ed59e1d1-3adce422683mr149049a91.27.1792706279004; 
 Thu, 22 Oct 2026 14:57:59 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:57:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 11/27] target/s390x: implement get_dump_info sysemu op
Date: Thu, 22 Oct 2026 14:57:30 -0700
Message-ID: <20261022215747.2479440-12-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Wc7NuJMBNXwNsJBJ14zVcP_LwhFdyGXD
X-Proofpoint-ORIG-GUID: Wc7NuJMBNXwNsJBJ14zVcP_LwhFdyGXD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX45A8WAfyqTF9
 nGDeVnjnZFkUVt8/rt5hdQ7ldM/pj0+3EyJxdyVBFFUCV1vFL3Q1Hipf0ikm49OIBR7RBs7+evH
 vBmzjy/w0jiQZ8xxXjFg4zPgdGBWlgA=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada86e8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=tWNUsTMbvNwxkxjYQD0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXyWIY2x9IsVol
 yFdM+mE6qDD6chrI1f8tZVuSWlOjKeeqMdStbku32v6wWpAe9ML98gihmotJDHAgUdisQESCf0v
 S9rUjXpk+x+FHDWV2vWAXpejQB4JGtIOonqpbWZOShxiVlHKwyUKo+sy8uZmAnGxcXV6BVRny0A
 SBG9gw6CrMvum189RQKFZx5c++SXwPvAyUAqdw5gNvrxM1dPHEUPg3iI7u73zwb0M+gOUHM30Jv
 gdtWkqz06xWfY/UdX61LlaMDWetjA97F8wHtqo3QUZLmpin9zG6mb0PANZcwuOz6ZY0MWt0kFzO
 oVBc91+cmzqMAMb2dy1NypmY9QPwBQutb/WQFqm0UmR/HNjL4s1eXxoqo+3zTgAzRzNEotpaJuX
 j91k/srolsx6f3I8Wgv0lWAh0JN6JGiRXMD18oezf52/NqBPsV9yXQeF1zHFJ44XGphM40Ibciw
 FI1CpkC8v0cyPnq0v2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
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

For now, we keep the global cpu_get_dump_info symbol defined.

Reviewed-by: Anton Johansson <anjo@rev.ng>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-12-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/s390x/arch_dump.c      | 10 ++++++++--
 target/s390x/cpu-system.c     |  1 +
 target/s390x/s390x-internal.h |  3 +++
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/target/s390x/arch_dump.c b/target/s390x/arch_dump.c
index 2c26e992959..b26f0ffe143 100644
--- a/target/s390x/arch_dump.c
+++ b/target/s390x/arch_dump.c
@@ -449,8 +449,8 @@ static void arch_cleanup(DumpState *s)
     }
 }
 
-int cpu_get_dump_info(ArchDumpInfo *info,
-                      const struct GuestPhysBlockList *guest_phys_blocks)
+void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks)
 {
     info->d_machine = EM_S390;
     info->d_endian = ELFDATA2MSB;
@@ -466,6 +466,12 @@ int cpu_get_dump_info(ArchDumpInfo *info,
         info->arch_sections_write_fn = *arch_sections_write;
         info->arch_cleanup_fn = *arch_cleanup;
     }
+}
+
+int cpu_get_dump_info(ArchDumpInfo *info,
+                      const struct GuestPhysBlockList *guest_phys_blocks)
+{
+    s390_get_dump_info(first_cpu, info, guest_phys_blocks);
     return 0;
 }
 
diff --git a/target/s390x/cpu-system.c b/target/s390x/cpu-system.c
index d963d9e940e..965f5cf29ae 100644
--- a/target/s390x/cpu-system.c
+++ b/target/s390x/cpu-system.c
@@ -186,6 +186,7 @@ static const struct SysemuCPUOps s390_sysemu_ops = {
     .get_phys_addr_debug = s390_cpu_get_phys_addr_debug,
     .get_crash_info = s390_cpu_get_crash_info,
     .write_elf64_note = s390_cpu_write_elf64_note,
+    .get_dump_info = s390_get_dump_info,
     .legacy_vmsd = &vmstate_s390_cpu,
 };
 
diff --git a/target/s390x/s390x-internal.h b/target/s390x/s390x-internal.h
index da60b2b1fd4..5bfc37fc46a 100644
--- a/target/s390x/s390x-internal.h
+++ b/target/s390x/s390x-internal.h
@@ -249,6 +249,9 @@ void s390_cpu_finalize(Object *obj);
 void s390_cpu_system_class_init(CPUClass *cc);
 void s390_cpu_machine_reset_cb(void *opaque);
 bool s390_cpu_has_work(CPUState *cs);
+
+void s390_get_dump_info(const CPUState *cs, ArchDumpInfo *info,
+                        const GuestPhysBlockList *guest_phys_blocks);
 #endif /* CONFIG_USER_ONLY */
 
 
-- 
2.47.3


