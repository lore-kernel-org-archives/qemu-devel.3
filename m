Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC52606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 18:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XcgVR9KI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b+WoSPpZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJaoK-0004QP-L6; Wed, 21 Oct 2026 14:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoI-0004Q7-U4
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJaoH-00084o-BR
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 14:13:10 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LHpOXi1795267
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AYQaWd5Z1MF4/UxaSk84LD4bb40q2r0A7bRtpzCu1SM=; b=XcgVR9KI0lZK0CFp
 8aN+M7OHxo/QG8HLklmkEZVC6AvTd+eOpSa3W3fAkB3bBuOXRVsbZcrh5Hqgx8ih
 aPkIiV5UMgxmJ/JcPjEOdei3rxO6H0JoF0uCAe//o5X+oMkn0hhKl1XgGQIrWPdS
 eXJksF2IimebKsHxbQ5pATpWxFAR1lMPP4rinpZbs49H9kmyGzAOuqZUUv+/QeS5
 i258Amo2v81+XHJNe7c8mUkbVB1bBatWq87Tw++2C6iO2mVoZ2iQUXSsrYuFqa6w
 wfxyt+xVb7TKIjsfv5BhOmOItZhYBboAUG0W2EOueANz/zPoqwuM9JOx/TTTUdXN
 zw9iig==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf1u3g5e3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 18:13:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso1500656a91.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 11:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792606387; x=1793211187; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AYQaWd5Z1MF4/UxaSk84LD4bb40q2r0A7bRtpzCu1SM=;
 b=b+WoSPpZNpDMFaIiNRDI3qAw7dJ0gJ3dSz8c3zv5T6lP3ImjH5bQr6qWNXXkL9NUQU
 5NAlR1Tz/C72BhXV3SsNmqmS1gJL51Z7qbRr2nKjXaydoUZp1SMrU6yC+HAThUuorLr5
 FoqWH9N1bSDQdmx5qsUbF6+xoaidOFCyYP2MH3RyhuLpf+ZaOb2A/275jvqNVzYS0yDx
 gxWOU8Liz84MtGI4eTNs5hx1fwTlTmFLygHJxJGsKL5oW3OeqUnqAumNM7gezvL7XxPq
 TBCsR93B0g47FL6Bx0QRvfQy37fo+Kv3wPHELZ9Zdz5SJzSxyYCvaQ0MHDN7ZnCbgSLP
 LXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792606387; x=1793211187;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=AYQaWd5Z1MF4/UxaSk84LD4bb40q2r0A7bRtpzCu1SM=;
 b=MhVtKYrLNW3+PRyWZos9UF8zbwcRlgtfu0C1fngrdROa1gVBFpne+UGraNNQsUcpJL
 uofyzjNYnI1Uj6Lx6pMsahDHlnBwPjuHZmqpAbjwp1sK+m8i10lI38Stk48vXHMSDcwL
 G9S4VDvcSWJzTLfb2biLnlenqOjvWRdBJCl3pPOf1+QqXcnB2ZM3zt0RaiSIFKkVQsUy
 7sdrCvI5q+uWqOxMtOFbOAo8I9l58kGzJuLwa5qz6XwDaZgpagtCduI9pEXDJLJdNPwB
 IgXNvSoDFcZM4CEurv52jrKXqFznIkjgwKNBuIydGZcEcXDEoP+BbmWor/xCpzGAPI4p
 Y6lw==
X-Gm-Message-State: AFq9FYKQgqFLvb7Hco4s4RfTcdDM1i68VfLC/wjraQ046dVA2yYx7fne
 YNFAA7Ykbivlpm7GSHpG7jkdR+DqnJXkp4spyXlIvBSOj6nWMawh7ds0Rj9nwml0QiC1dVN5SG4
 eKWK9K3PqGJnnAGCzb9dIqQgjFOMA3Ru5/L/mOkBENJc9Xrz7/6+RuK1J0GTvSY0a3Q==
X-Gm-Gg: AYBFou3JuC5TPp37IawWsgz73ehRo11hN623OYguKTtGb8Gp9zoyWRhq10diPg5H9G8
 gJz+t5PSain8pDgah5QlFgwamN5DMcT4EXLt1O05d7AGMI7jCbQ198hruVazwoU/inFgpY2tie/
 2Lo0so/I5xFpGYtOGO8rhomQ4BWiSgLDH8P+rP2bHSAazCHaYsv5pC7d6r9nc4lrKw6cNBz2E9a
 5jJMjuPppivyWCJ70YApZMOW/lCXYhep9okgVFTvacnAlf1s0LYl3zpJdCpHFsu8hlP6Cb0N73K
 uuut00xPY4vsKOQ8KnE78+1cs6mk3jWIVnWDhvBX8oisRgfpJ4aG3JcvqKGMiyF9tWjUX8aFSn8
 1a0slar3NxLQjhMuc/jqNRhHfKBEG1qArj6UDqWUYyZP2mYBBmE3mU0ru+lphZNI=
X-Received: by 2002:a17:90b:3d8b:b0:3ac:4e18:2390 with SMTP id
 98e67ed59e1d1-3ad86dcac3cmr2188635a91.7.1792606386901; 
 Wed, 21 Oct 2026 11:13:06 -0700 (PDT)
X-Received: by 2002:a17:90b:3d8b:b0:3ac:4e18:2390 with SMTP id
 98e67ed59e1d1-3ad86dcac3cmr2188620a91.7.1792606386405; 
 Wed, 21 Oct 2026 11:13:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48ed74bsm499152a91.3.2026.10.21.11.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 11:13:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 anjo@rev.ng, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v5 19/21] target/s390x: implement get_note_size sysemu op
Date: Wed, 21 Oct 2026 11:12:42 -0700
Message-ID: <20261021181244.867840-20-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261021181244.867840-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=S8ZMU4sP c=1 sm=1 tr=0 ts=6ad900b3 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=EDlH-CkopuZvdY7HuOYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: rAfIF8jnLkNhZUVwktRr6vKF8P_G6ttn
X-Proofpoint-GUID: rAfIF8jnLkNhZUVwktRr6vKF8P_G6ttn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX9XI7oRcXCijD
 2qi3l2IrMpEIK+d2LKP8mTFzZ8h6qL7kuyDLNjPfr8u6cCZ7uEhXoZsUYv93WPtQQn7tvQgMp2N
 l/LNAQM1gfMi0v1737Ea665UY9TuhRYnk66XmL4DDQyAKU3VbCZcyqyqONTo+CFU3hi8i91Ut3l
 ih5zcxRyILBUeExFjbMoP8K2x0u1izHSIPUr3eZ5PraELNEWRR8ZPUvDN0Oj8bHTQ7ZbE+AryqG
 nOLJ+Ot0OuIciwlD3T2chneLnVHp4T8HYmovoSHy8MYAwTxq+S9/uuuUVSt2jFcjD2LS7GeEvX1
 RXaZkGib8iHVAg6qlc+fia4c6JU4hrooYj1en+o1Eh2YRWslTVHO9jqrH3reBKKhMEh24tSIIRa
 R5oHq3tFT+5iGYWTTVuuNP530RCHQnzZcGueNNCHhzQszcEI7tmoQzI7Gbc7ImEeQtzxeX57NRI
 wgHN7XFtqRb2pIaZE4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA3MiBTYWx0ZWRfX/nqHx7HVng4X
 tmygCAf6a6x3uMomFZHbKcR4HcuNFzcbHQiOT4dVlg7CY4c1Rih0A5s25YD6DHMx7kXjCchsFZ+
 h4ychis8Ua3b+Dh9QsE/vPtXmzExqcE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210072
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


