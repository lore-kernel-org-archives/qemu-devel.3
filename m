Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103D1606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jCJLQf3g;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K1RXaxEV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7xS-0006RC-Ri; Wed, 28 Oct 2026 14:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xQ-0006QC-9m
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xO-0000au-DF
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:04 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SF9uH42542927
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d6E0CkKZ7LJHRPQOHef8IEj3L9QR2jbYZoNocidlmrM=; b=jCJLQf3g8MI6UnmU
 J6VtozRgwt8PoLVrogAeS3Kp6ooXUHp53TbnYkm3f7wA/nkeaBv2C96GXQ6+yFOH
 SYM93tOWwInxPNWY/VFTODlpgO+o/9jE0EviVUpp8I8jS44DBUEciPjAQkjh+zhh
 ugCxi5JQMNpLJyfgpRQD7mSmNVKUvelMRL1ATAJ/kfIh/HzO1+Fr9mW6NvbviFf6
 ogrYn8ys+n1peqUiSpxOcXEXVz+TCzjO6pL6ffV0bI3L/JK74hdDqbgu3duKaOAV
 S5njZ7EtDWNwT+bI+acTDp4bCYhsIN4y7DvLsS5e0BoyFbafwUtVMZM3CKm1oBIP
 5kK29g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkkehrsr4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:01 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f5844e383so185834285a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210460; x=1793815260; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=d6E0CkKZ7LJHRPQOHef8IEj3L9QR2jbYZoNocidlmrM=;
 b=K1RXaxEVA2ejV9x+V3vN0jWhqpK8kBeCZ0GGEgFpTg9/8be0U7UozvHqup+255jF3S
 rv3qq0hrUZpou/doz4wMpu69/CwmlUCgcj3NHiAL/MTbWET9554nDukaMQ2K9jUhXEop
 CtFP3fdgpvoZGEkq6aQ/x8VXaqfjxgrJ+zEqJRnphbfwuQu99b8rUVhXpZxpEK0ehE5d
 VMSSfcD+pdOawn3G+fNV8dXrybrDh9L+odLUBQYaJ8h53ewC80CtoZf8zKNZ/xgzuTA1
 slO+RgsQf2kAJYqnTnvzbjdgKHYO/849dkelZA8Ts54apSpFTC5pA6crl1kz25R/tX5z
 kQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210460; x=1793815260;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d6E0CkKZ7LJHRPQOHef8IEj3L9QR2jbYZoNocidlmrM=;
 b=p5i41T4m0yDc/POOmplYMcuF4+ai0wuMQ+lrhrMp4jnTjkDM8+CLvqE3r1Sz3GHeTr
 60OZq8oNy4rFgZjZ0NRymn2KddUWe0EeM9mSgcF/pub+t/u9b2gyzS7LTa452XQyP94C
 JGtLlbUYJMdDQq1ixw2fGAwEKXaj6LQT8+8tmagk7Ig/89dxMk8Jol2czhaIzJaFs64B
 uY0Zmgmx49jqflpOZXCSXWwaqHlGmiEgxLLSZRVr5aikFmumU3ESOR0tnAj2VN5J8Hl9
 caHbIVg3C/aKlMkoDIrlmF4scf0QmIz4L42qXSNvZWEGHCVxzDvM9mgvejZT/O79qkHx
 C51w==
X-Gm-Message-State: AFq9FYLkVpDLkueC90rIUTaAnREkFd9LKoYJct+l9xmWWPhj3LcY3uky
 JfQyWjEnLU5WmGzaoHy9O7JXYGNO/ZtXajC9uVpx7IemEM01I6+JiHDX442PnY3ipV5d1kK7VVq
 vzyUFMKtW7CSbhVPJfdpK5TvL/DHwy+Q+ZNYMh9F2AYDbpnO1h0mrykFmlsHzzw08VhgX
X-Gm-Gg: AYBFou0LFaWtJoVCqps1jqXqjVWR0PvWztT49iEzsYneX2YQz822w6i+ZXRMDErVS98
 FSziqMr7SgXcVVNe1Aw20PkxtB8+qaMlDXGMyN+dvnZP6ngPGmRoiSZ0FY/Xh0QfIyc1l62GBAC
 pGCWqmWtam5LYc4A9YnmRlovc1bqCq+MOpQuYnNVYmYwB02zFzdRz9PxntwLH4ru/6XvCgCVzc9
 v46ZueTGBLE1C8DPCVm27xZdeEagRziaUV5lbmXNZZitbVRlyJ41iGHWb6NnPmFVuW+CuXsGfdW
 NzlPIjpmc2uXdZE0yJ0R92ESCO7/SIz99tJR6P8Esa+blRO8y95rDM/vkiHCbH2tlQ33/xvNCzX
 8Jfm3JYslC5+ytgWWKRuCBwM/JJ6XM8ze702IEsTd6dalAZlJp2inXzR//VxJPB4JW29dIHCEn6
 Aa8xJoOZtJcTAkrQaC8p4HfKa1P5HGjw==
X-Received: by 2002:a05:620a:170f:b0:93f:3120:6c71 with SMTP id
 af79cd13be357-94408a6b161mr476659985a.44.1793210459847; 
 Wed, 28 Oct 2026 11:00:59 -0700 (PDT)
X-Received: by 2002:a05:620a:170f:b0:93f:3120:6c71 with SMTP id
 af79cd13be357-94408a6b161mr476652785a.44.1793210459282; 
 Wed, 28 Oct 2026 11:00:59 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a32eef4sm38053105e9.3.2026.10.28.11.00.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:00:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 2/5] target/mips: Constify get_physical_address()
Date: Wed, 28 Oct 2026 19:00:36 +0100
Message-ID: <20261028180040.22848-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TIRdTQf4H20PCVhWofQfJc_qu67U92Dh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfXyqU6h0zCe7+O
 fPObz4aVfKELhv4FughBDxtPVlPVyJxcprAVbOW97VzRniToCTEXyOSNAiyNWbTE7fW9/9nYsgw
 mlXuWqaVHOPQXmsfyzU5dP34rHKxEIPjt/DPzFl0R3UUoODd0QlWk08L+vaGw8Lhk7ZdBa1FkNv
 44+yejVKP6P3XjfouOz/8yHjJ8qSFXkypldV4dLQQPY/pWZqo6jTfBsf/pVsaQXcOlTJ09BIjAB
 GAtPm1k/+eITbHFrvQYxngp+ZxWXw2gfFinJTSMFpsEjTEJp8BLOpw6CPA4FbcrSfF/H5WYKAFG
 /MKQN5EaeV2y5Xh6DnK/vj5u69873v5rNQpEG+zR6mJFZKzTKT2+l2wCGFZ/tydPFux5Pwf8K/Z
 3MlcPDf1q1qKsf9/mqIuxpRRz306Dblc+OJ2a7CI7FY0+KUyTvBTVOizTkm+NgDvdK8rgg5tbR5
 fL5eLiCWrwvXbW2yEHA==
X-Proofpoint-GUID: TIRdTQf4H20PCVhWofQfJc_qu67U92Dh
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX1dgVurE8WPKf
 CC5R6rAUBhLonAYvBMLhn9zg1wQvvqlyWOexoR13VRFf6yggumKbskQz4MEX2me5+jFqSgx66t+
 Jqgsi9yIQuV8wZBrCjlqOK/N7/T2Ij4=
X-Authority-Analysis: v=2.4 cv=bYv+w+PB c=1 sm=1 tr=0 ts=6ae2385d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=ab2e3UV3xNEu_U-M5WsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280071
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

get_physical_address() and its static helpers only read the
CPU state, make their CPUMIPSState argument const.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 target/mips/internal.h        | 2 +-
 target/mips/system/physaddr.c | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/mips/internal.h b/target/mips/internal.h
index 177fe5cadaef..2c152e246a24 100644
--- a/target/mips/internal.h
+++ b/target/mips/internal.h
@@ -115,7 +115,7 @@ enum {
     TLBRET_MATCH = 0
 };
 
-int get_physical_address(CPUMIPSState *env, hwaddr *physical,
+int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
                          int *prot, target_ulong real_address,
                          MMUAccessType access_type, int mmu_idx);
 bool mips_cpu_translate_for_debug(CPUState *cpu, vaddr addr,
diff --git a/target/mips/system/physaddr.c b/target/mips/system/physaddr.c
index 6f11e70ba804..523197f02090 100644
--- a/target/mips/system/physaddr.c
+++ b/target/mips/system/physaddr.c
@@ -75,7 +75,7 @@ static int is_seg_am_mapped(unsigned int am, bool eu, int mmu_idx)
     };
 }
 
-static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
+static int get_seg_physical_address(const CPUMIPSState *env, hwaddr *physical,
                                     int *prot, target_ulong real_address,
                                     MMUAccessType access_type, int mmu_idx,
                                     unsigned int am, bool eu,
@@ -99,8 +99,9 @@ static int get_seg_physical_address(CPUMIPSState *env, hwaddr *physical,
     }
 }
 
-static int get_segctl_physical_address(CPUMIPSState *env, hwaddr *physical,
-                                       int *prot, target_ulong real_address,
+static int get_segctl_physical_address(const CPUMIPSState *env,
+                                       hwaddr *physical, int *prot,
+                                       target_ulong real_address,
                                        MMUAccessType access_type, int mmu_idx,
                                        uint16_t segctl, target_ulong segmask)
 {
@@ -113,7 +114,7 @@ static int get_segctl_physical_address(CPUMIPSState *env, hwaddr *physical,
                                     pa & ~(hwaddr)segmask);
 }
 
-int get_physical_address(CPUMIPSState *env, hwaddr *physical,
+int get_physical_address(const CPUMIPSState *env, hwaddr *physical,
                          int *prot, target_ulong real_address,
                          MMUAccessType access_type, int mmu_idx)
 {
-- 
2.55.0


