Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E88606A32E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=eIhSOu9J;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Vk/AGQ3O
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Hz-000240-MW; Wed, 11 Nov 2026 01:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Hw-0001yB-VK
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:33 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Hv-0007ut-3y
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:32 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KLVw1409577
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0lTxAsMA3QpN+9zMtyW0vyhW8QFqCxQaW0AWlpp1bQc=; b=eIhSOu9JDhC+k81b
 Mj0vOImDZI8greZa0huICkZ9dIDxrXSV5u8J4coQ/eFpuwSAH/Xoxmg7ikBwVlCs
 zywUTkWfh0fNYcNh46116qIlYk+mifuRHaF7xt7pBRiYv68Ah98cGoBWaMIFb/aA
 hBo0VWyfh/RBXl+lFeShzXYuyebNHV8NdYAcriyCAIsa+rQZJsc7CrG6L5BdsI8m
 W4W/ZqfKgqS6r4VtUTh7mOJYdOePtI+yLQ7V3AcSMPJVCLiVB9iKfzRpnmmT11i7
 epVmGam1jILN4s+J6A35xZMozgk05J1R0o1X69TkS0XNOoYnQyf5GZtre9nZKqKf
 zRT3hw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdgnd2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:29 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93caf6c528aso524379485a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794380309; x=1794985109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0lTxAsMA3QpN+9zMtyW0vyhW8QFqCxQaW0AWlpp1bQc=;
 b=Vk/AGQ3OwFRpRa9MJSc7NppWxdq01xYJu3cRpLv2y3mvMKUASxZ6xc/6VAXJfFiU00
 AH7/jdNx2iq3SVUBRHal2YbEKh6YjbmIJUYEbnCPAN4CGSK+nCExJxvFOGq/wybfttED
 257YyZz9tVFoacDSvpywT2ePyKSLenywRjZ2FRZfx1nOB9fpgWY9/r+q26MkvmCb7n8l
 J/73d7cBmRlrYemdlb+JTMdXqqVpDWF5YMMuywCzRF2JZmeSlUgiD9kOqsdowepVVXfD
 Vu/7zaRJSnr1XIvSPcDaZzXeOfo0Tggi+i9kO2fRIYCwZyKQsq2D4+SW8+diazq44oY0
 wb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794380309; x=1794985109;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0lTxAsMA3QpN+9zMtyW0vyhW8QFqCxQaW0AWlpp1bQc=;
 b=UVkQuIuwITiwEvlus6IAk3Eva975koXIbGsBjMmwHNBqpTHpkoo/5lPlUmzYVxeucV
 nwGLR+HL/FOoXuL7n+RLHKYWx8Ac58IVwFpqQR4JeUJ9yk76RnNxELH3FSpwKEYmOjOn
 q0ihGICMEzzi/enRHKX4s1E/E8KaAkTA3fgQnPzSaHn6FuYSSBWIrdXyR83fjnVdb4+J
 Dqg10kl3CCpiAp0bd7PPSch4B+lRy4VmjzAZLpC8xLjfpKHmfCkDMzDWa2gvphznsbIE
 quxbaqyXx0H5kT6WTfxZzjut0QwwMCcIHpc2Yk+YmPJ9rXSKkfEsJ2YBeLCo4KYkfF0X
 30cg==
X-Gm-Message-State: APuU4Z+klO9DfnEJ5ZcOvte0QdUS//rYwPPOH3dJUWh1j3ANcEXrxfWT
 K5y/DQ3s/BETuTImtJoWMqXWq1cl0KPSg4gLIrAIVsZkKPZsAjMDvQO4ybIMgTIaNJw/FgXtr/s
 xGkVQqdJ2ek1qv0B+FrZ/k6Hn/ujjs9Muj5ugSr3cuGP9qbMepYuEHuRsZrEvZVKPPQ==
X-Gm-Gg: AYBFou07o0QOKKCWRYj5eUBwYXl9BtzEtI1i1vdxWusDM4jXr3Y3dD8Sw8MkNICrMJR
 DG19F1dWrDrgH5g6bn3di7+NMM/h6VGCRO7R4wt/f5qAU0heN/3GEcXufhQKaaHzMIB9X6Y0Wx4
 +ZoKfjI9saHPJoIX6qFrhig0DUkPeTsEZVoLkNv7enGSnC9sNyu7Y8AJNh/CRvVirm2f6JJ4bT0
 2i0qGAqxzNLyf3akk1AWjFRX3lzaDO6c7HgtBGjKx0tfSS4SJgELLC3v6XwFySoZYGvFYHSrJO9
 jdcqm5sSNyT+lKWIRefP5oZWc08NS+MZCHq2vpJ2hDVYYhpTDWnR3Y5KSpA7rrxFzwWhaV01k/J
 B+bPCkpKZx3UW5Ld6d0GYCOkG5RMG3DQsmCY6bhJdsRxpsmTxcHeakyq/pdCLqEOMml4+A0cWsY
 CMY84B/EcRAnk=
X-Received: by 2002:a05:620a:4629:b0:93e:acdd:acd9 with SMTP id
 af79cd13be357-947afb8bf57mr246333485a.7.1794380308594; 
 Tue, 10 Nov 2026 22:58:28 -0800 (PST)
X-Received: by 2002:a05:620a:4629:b0:93e:acdd:acd9 with SMTP id
 af79cd13be357-947afb8bf57mr246331085a.7.1794380308092; 
 Tue, 10 Nov 2026 22:58:28 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e734698sm424919385a.13.2026.11.10.22.58.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:58:26 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com, ZhengXiang Qin <qinzhengxiang@foxmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 2/2] target/riscv: raise access fault for Zicbom MMIO-like
 accesses
Date: Wed, 11 Nov 2026 03:58:15 -0300
Message-ID: <20261111065815.167869-3-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
References: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af41215 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=bDN84i_9AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=f9I5WbiLg-2XRRu5Er0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=J2PsDwZO0S0EpbpLmD-j:22
X-Proofpoint-ORIG-GUID: lYxyOk4mwsxdugs669Nrp65XrYWs20v8
X-Proofpoint-GUID: lYxyOk4mwsxdugs669Nrp65XrYWs20v8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfXw3UukyuXAQdw
 +p2qZ88DaQmAF7gptdxPzvgQ0SE/8G4KQWhysv3FDn7d/r8uQ58Guv0r9MC7S1OXINLSFlWX3dX
 2F7aO7ijZ0aaVTmGYyGJGPrQIM6fhbqlzR0aw6rMSRKVIcpoTDnaH7/lpZLKwTOCiYAEsV8VDL1
 tOl189w7wjMv6W19VRsJEcMy5Tye3SbvZrv/+cMbMWhSnjT2lPOkefTauxg4ObK1AEODHGr+xv4
 X7l+MONP2W4IMK3mr2Gz9G3Ou5yGx3SBHG27R1/DOj3ZjZEV9mjaGD0YonMxRxSWPsUJbHGRS63
 Npy0qvrCXSR2UfmHraH8v/AIHrcWD90xCyzLqjiA2WH2I6FHxK2XDoGJCPdHySdUGLO5ocWG2Zw
 90UE0/Qo+cS44EWSzV8k5NDWVwXrlh/zTxsu30vSf6SiEXtkh/PIvMIS/aqVCfUT8PoBIqd4Zt6
 +BLTm5c1UBQnCF0ErtA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfX6pt2fSNydV0K
 278bMIPmmDJej4Neh3Nw/F9zwzYiXqlwgq/OiZ7KISpH1nMF0/lxCbdJl1CM+Rw0Fk6MMxkSKr5
 ganXF1c/VUE+McqiLVpj7ARR0+48GSM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110027
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: ZhengXiang Qin <qinzhengxiang@foxmail.com>

check_zicbom_access() currently treats any probe_access_flags() result
other than TLB_INVALID_MASK as a successful access. However, a result
with TLB_MMIO means that the target is MMIO-like and should not be
treated as a normal cache block management target.

Raise a store/AMO access fault for Zicbom accesses to MMIO-like regions
so that cbo.clean, cbo.flush and cbo.inval do not silently succeed on
non-cacheable/MMIO-like memory.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3501
Fixes: e05da09b7cfd ("target/riscv: implement Zicbom extension")
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/op_helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index d7af56ef61..52aa545eec 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -231,6 +231,7 @@ static void check_zicbom_access(CPURISCVState *env,
 {
     uint16_t cbomlen = riscv_cpu_cfg(env)->cbom_blocksize;
     int mmu_idx = riscv_env_mmu_index(env, false);
+    uint64_t fault_addr = address;
     void *phost;
     int ret;
 
@@ -251,7 +252,10 @@ static void check_zicbom_access(CPURISCVState *env,
      */
     ret = probe_access_flags(env, address, cbomlen, MMU_DATA_LOAD,
                              mmu_idx, true, &phost, ra);
-    if (ret != TLB_INVALID_MASK) {
+    if (ret & TLB_MMIO) {
+        env->badaddr = fault_addr;
+        riscv_raise_exception(env, RISCV_EXCP_STORE_AMO_ACCESS_FAULT, ra);
+    } else if (ret != TLB_INVALID_MASK) {
         /* Success: readable */
         return;
     }
-- 
2.43.0


