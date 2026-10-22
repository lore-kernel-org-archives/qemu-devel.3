Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6067606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 22:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oxyJA+0W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Wq8ZbZV2
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0nb-0001vt-3S; Thu, 22 Oct 2026 17:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nZ-0001tZ-Ej
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0nX-0000Jm-B4
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:58:09 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MKXI3O3413937
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OqvmR4/RcOMjYvXBFZKXLwxVR48i0sWfkA0oV+oPUOE=; b=oxyJA+0WiVzSP3Kp
 JBoGQu/4dLLfqPvhPwcLOmE7EAyqkHAEO+VU/3ydJ5Ha1Hgz+OuIEULOhyMcVs1K
 h0vvMiD3giecMrAEGhhCNFgQW8UL25iF2utgqEhp6EU0dnZyMNdK8TUaohNZ8BKA
 n2KxfnKzBv663KuxtWZmd5eQPPr7oYc2m7KCK+aWQG2IApo4y/r/jqWK8EN8OzJL
 wj7/8jhGFTgu+RGQnbWaK5XYaoiltc4unLHv5jmS+eDjxF0eZm0uCLffzb9/9+bZ
 JYO37/5Xf3tszevpxnR2g+PKOV1QF84O22XLonyRaO2t763YM2H89ihdf8A7TiBx
 k731Ug==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfsmar8dq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:58:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso263281a91.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792706285; x=1793311085; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OqvmR4/RcOMjYvXBFZKXLwxVR48i0sWfkA0oV+oPUOE=;
 b=Wq8ZbZV2XuRXcKJ9M2A1gV/QH3eFL7iKWIwij4jGbj9qYrqHk6kQlxeMzKLrb+VT68
 fm05GYb82PTm2xl5lSWjfVGg/CBDgUmxJXGfyXC3AQTq1S4CFRuZg6wrfPuN0F7SW/DY
 v6FqeFwNozm1RAOsTOmJGp8OL+2lOLw0hmKyxhfJg1aOYuNQUohUm8LnZm10r9P4aBP4
 jlYK7ummgDrVAqaKVKstpG8L1tjfWe9/AikBUzjfiUFhTUOFIbMni5TrzbEqUhXUE74t
 Kqsd26Pi9NlhTgR5I3z58LHASqw+csh3v8HAQC5WLQZhN5AzUUG1BlmHqql+kIMUz0ay
 pWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792706285; x=1793311085;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OqvmR4/RcOMjYvXBFZKXLwxVR48i0sWfkA0oV+oPUOE=;
 b=kU89825GCEYcO+0qEBprTYeopLTygmQlK5kaGk6nZuhLm3g8NoXOKjooYjRb0sij9H
 NadNcLYKaF0HPl6DJlMv7VXkb6HiwFRjNj8WhFAOU5TlSnjkzDoRbLCogrgVRk7YF6u/
 A8rnYwYYFk7A2GpNj+jFXrXyiPtRUkuHJi9i8nfiqpAgwcR5hVbS9UpkwtsuFAIVHCfU
 QVzYZKqeTkj/tSp4FBk2/Ukpi1zIZNHhqS+Ubh7qQq05NryJnBRu7aGKC5oAlf4Js0q+
 qg6/iuzmzqwhwm7+OMz+TXdraiWqBBJ2gXyYjydXXW5Xa3DJ8PL8GM95BFVk22tz3HJu
 M5Og==
X-Gm-Message-State: AFq9FYLc3ElkdCOsOIBdA8MwNHwVxHCVWAmpiJNXxHKogtpsMgjj9KHr
 nuvcCiDBPRRyZ06H9tLbSgncYi1X+4rIeQLLAmKixOGKB3ThEDDnpaIdmY8CLTx9PFS6eD2D+2X
 IpoU4saDkSnxrMF/E9uqv5NVdPU3HwWBAVX7sveawasPgLE4BJ2w1OXJ3Rset7gaF2Q==
X-Gm-Gg: AYBFou1YMB+oKr+LROsxLhzlC4uD4gWJNCjDyg8Dv9IdLcTjC+27AO2xSNJQvSwKcGf
 ylSRkUx3+zDaYmtYvQ1DSKYQs4jCHdbhiSWdBBA4J5xEchMc3A39NP7PS7DmHWajk+Cc7UW7rGY
 fHXDkwF1K88mfMND94cGHMWSud+Qy/6/0SNp71DqW0jO5Z5mJ/otPpWFQawUISohchq3Ub1dSeb
 XGvQkyYCqiE6cy5VAbWFzy1zlK/lUk7hgEcNRJ/qK5r3bsSpTueAy9mbF17y5ryreFbB8AW03lw
 qiBrjDcgdCD9jbuL2zLCPp6aM6aJw5D50+9sXlujYJwZ6g/KM+As4H1DhOrFxu3aAywz4xus4qW
 cYiaQXxtu6OM7/iVRIuUoT5uZtLSuFqIIM0I6wY8LpBdMxzIrSFTGp7YHqElqLOM=
X-Received: by 2002:a17:90a:e7c3:b0:39e:6c6a:6580 with SMTP id
 98e67ed59e1d1-3adce115bd9mr161424a91.67.1792706285293; 
 Thu, 22 Oct 2026 14:58:05 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c3:b0:39e:6c6a:6580 with SMTP id
 98e67ed59e1d1-3adce115bd9mr161415a91.67.1792706284872; 
 Thu, 22 Oct 2026 14:58:04 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adca62e477sm648061a91.2.2026.10.22.14.58.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 14:58:04 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/27] target/ppc: implement get_note_size sysemu op
Date: Thu, 22 Oct 2026 14:57:36 -0700
Message-ID: <20261022215747.2479440-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261022215747.2479440-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=V7LoQuni c=1 sm=1 tr=0 ts=6ada86ee cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=Lumvk8zKUu4O7nVSwh0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX+649JaADvxbU
 nFBwxpyOZMQDyNM+oeczaL158OM4jaiGYkUtKASx6H67clpUbNSzkNPQ6K0o42yE0i2MDqGNztM
 eTA3mHw6ecoxRoKkTPrlUpYbwRItYq4=
X-Proofpoint-GUID: n8WcMmqrxV6ZYza1heryWFK4nWmxPyci
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9Usb2ErLdbBZ
 RfqrzYz1w0I1zY07+EufvZxd6+Tqzk2isQvq+qomzFbTSzG/QQ3W7KqeD2AIYtn+Qe0VebzvNne
 IRwzSyOaac47Hl7ovP67xEv9CQczuypErDJNoqZPm8L4Ul1pzympf+dQXA7pBWDoRpzgzxlHlno
 c+5gjvp9ONkvQfweKuY7YyoNFBVIsYnNOTdEQrNAXXWrLmexVODQGU2PZslRiEsSkmn1+K7FUs1
 ZDPRU2s2Mnb/WCrLtPGV1ZNH1u60DGPBYmB3bS3Y0ssjoY+HCy1c6lT8Zd2BK+eMfxvbc0UwRkj
 8b7TUZWZ73svPOOXVki44hgXOvWqmpRPOo2VOlNVGzaMlo9mwycW2C5GTi3ucvqp8R8j9/NF1tO
 GXEBFN3b4JlVN7s7TxiUKZ2bgI90cF0DZblbFOT8ocpHZV9pJI7j/oEXWEZ2h2FQMdhT64A/Mdq
 C/pIO/SqNxXgA0Q+aAQ==
X-Proofpoint-ORIG-GUID: n8WcMmqrxV6ZYza1heryWFK4nWmxPyci
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
Link: https://lore.kernel.org/qemu-devel/20261021181244.867840-18-pierrick.bouvier@oss.qualcomm.com
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


