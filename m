Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4943606A31D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KsGg7Cwc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cnZyO5hd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7yd-00072o-O9; Wed, 28 Oct 2026 14:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xo-0006bm-OA
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:35 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xM7xn-0000e6-60
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 14:01:28 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69SFB6qa2070802
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gnSZjEDGS8jItl6xasuqulm/UPiy9r4i++cANIC38bg=; b=KsGg7Cwcyv6YzmTw
 xtvpsI7V+Q1L98UqCJ1o+EkqqFcXkNtlZk4oPL3j+QlDfF3WIg9/MkHzv3HoOFYs
 CGOibEyI5MFL7HZ9iCaevp92yc+1TR+n6ikgUPjzh1M5SxjULPYDMAFqtysRbs7B
 KBtv889PZ6BmgkfHwacQsz5CNU8lzHOLiXkx2IYJtg1A8BsMKfpQQGxHK9XaZFVV
 8KAzYBQ1CV8BJ/nFrCn00TB4lcw+RuPbFAs43SrIiut4TJoMMQzYjqDdyO7OukYI
 awxaqz1y3oLi0hKdnCcHCb6HPK7IHcRlr/8A8P0dkWll/I0xzOTCtsLLuy+szJ0q
 Qp1/Ew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk7g7kkwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 18:01:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93c5ab5c136so190216785a.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793210485; x=1793815285; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gnSZjEDGS8jItl6xasuqulm/UPiy9r4i++cANIC38bg=;
 b=cnZyO5hdo0aqcaIsxCg+A/H7sGul7wUgfgtM/4DBm91kd5ohBP6SpZhYrYppHpljEq
 QVBvm6/eAQauahNzbn3jPYo+3s5XPWPbH/QBKIvEJ+UIzpcu6mbXL1rQNOtZ2J+w8OCA
 0EzJ3xmwoMSqJ72u9CPreZwCC1rqvZpGeGdPsQNwmjP40C125dSYnYefr9P/myeoJ2q2
 vAAMTCPSj5mfboJP3SgpOKe7ySeb7pFneHyHAH2JVeSO4iXtVtoazWZmZypc6AT1FXXJ
 j2jcjZ7nsjWAsTnqfd3sCTfS6LYx9KKHpT4jdr7f1Bsq9d/03F14tTkq+nfKgyuvU+U7
 wUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793210485; x=1793815285;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gnSZjEDGS8jItl6xasuqulm/UPiy9r4i++cANIC38bg=;
 b=UTCTJ7wOv9DvJkwWW9BLs7JzUmgweBC2pDI8qPZEhUpfGvGCfm2hCrl4azZI2cyAR2
 WOuXXyudvJhvLF370PV+51sJbwLTvM2SdRDA6W4QoCsf1a65MBIO6CqoJeNaK19q+4wh
 C6E8QpEMpx8/lcv8W/FH/pKyOtj8T9w1YeaaoCYVKUKfqNQYVAOLiCm21qeG8RG7w7LH
 CxEF4SU5a6fqk/TY2sEarFY969YmyXBx1KziQopJ/GKRnnLgAdZKg3I5wvNX28a5SDjD
 xREeq0D2c8PE22QJCy7OSU7qv/z91J7ez/YFQjeVr0F5yWkzlDQYfAHouTHW8R0H9uiP
 P4kw==
X-Gm-Message-State: AFq9FYL9GWcz490vAXgVm5QMNpZq4vYzOxcLb+6RwmkjJ2ncChx4jh0p
 KSNVFxXLJRgZfziDj75RKyrgs5hAzVGLVXi9dUSywVCsUiFqJDbFVJnfHMDRy9wYftGLIRvWWEu
 4NQ4c+Uyiv6wpgyvQGq+el2thKgGEZv9AiOac76gokDE+iG+tGVugK56Yn6rtDc6LCrOY
X-Gm-Gg: AYBFou0uIScjNB0dga5vVtNf2eP7RWyzLA7QqAbytr/1IqH2pczTmzY8s7mWL3VYCbI
 Ob7zo6SWeSbi/FePlkthUo9g0lBOha5Qjsz2qkI/kvfTdI65D4I/360FpQs5QiQRJpsKXLYrlHA
 R2Wqbc0tt26iWkB/7vRxdsbgiv1NOKMCvCwHDHY1EvnuiBpKjErqlQoIjJA3e4QR9SuBHBina98
 np9YagG78Iv49lva8K43qlybJsbCpfzYJRgHS6hxkAgoSOfjzwEvf0GMNJbPooiFCyJwPCHIodH
 wG69vVhgbvNVZOvoDvHM9qs1xGq8OulhVl3k5M2IyF/NXOTZH83aa9b9ABVJZbYRh3LshoF7JJk
 dNJc9Yu1j8Snb7Cpplj3DuWlkDI1KHj1FncWHy8ZI+AQvxmILHQqvQAsiE7vWUdGjgle4CA5j6P
 kppR3IaaTRFmqNIE/7pz/f97NBTnTC8w==
X-Received: by 2002:a05:620a:2688:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-94408cb5c2dmr430985985a.26.1793210484952; 
 Wed, 28 Oct 2026 11:01:24 -0700 (PDT)
X-Received: by 2002:a05:620a:2688:b0:93f:2aa8:c550 with SMTP id
 af79cd13be357-94408cb5c2dmr430977085a.26.1793210484154; 
 Wed, 28 Oct 2026 11:01:24 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dd7sm29921781f8f.15.2026.10.28.11.01.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 28 Oct 2026 11:01:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 5/5] target/mips: Use CPU endianness in MSA LD.D / ST.D helpers
Date: Wed, 28 Oct 2026 19:00:39 +0100
Message-ID: <20261028180040.22848-6-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028180040.22848-1-philmd@oss.qualcomm.com>
References: <20261028180040.22848-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX1I7p1VC2Yipb
 UDsIcv2qRlmbGT6GzkazL4irI3f4Cr8xPjoyXprA/S0Z++5ltczlk2l80X/ueqGdQbw8YkPTlTd
 xkaP1P8xxN/lcT13Db6okP/csKU32vU=
X-Authority-Analysis: v=2.4 cv=SoIFe/O0 c=1 sm=1 tr=0 ts=6ae23875 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=rw3zklGyVYttAUjtENMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: ruyCeeNTS_1CkzBYQ9oRmqPWnz5w_pMV
X-Proofpoint-ORIG-GUID: ruyCeeNTS_1CkzBYQ9oRmqPWnz5w_pMV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3MSBTYWx0ZWRfX8678bKxORRiN
 1zQltBDjI/AImn6RK2J6E4mCmHCTjsrqyODWvassmNkqKcz6gUD2papQGuSIQ2/OsM97ae9vOzS
 EGeLZuJx3Rv70FnGUPiMhZmDK4A0BRkJL9MkO+DvdTh8dVzLEV9DfmBoCoyNNqQdqexMu716ll/
 iF/tSM4esnFr7B+gPKZv+iZVumbTmzFKTVJbLPWzgz7Tw+ppytQ0VvRBPdhxsl9PbumaSybw/WF
 uCFlpc6OgY74fNTzAvq+vHOakgmE78gLSUv083q1/XyOkER2YYsgU2/Vg7bgLhB/tf9BumbBtw9
 LbQK/luqUabDs0D3NKGMgcjKb5C1HELXUlIqXqgHLSKyedAom+mRTC77OSNl5hVJ3Bm7zTCQI4p
 qQJbin4pZssyPm9hDDO5fCSBr88Lp/xNxZWP2BjvCvxLDtwrBYh06KHlCYMA0ieOa/PMFOS4UTm
 wmGi2fEpgOUQcueVwlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

helper_msa_ld_d() and helper_msa_st_d() use the legacy
cpu_ldq_data_ra() / cpu_stq_data_ra() accessors, whose endianness
is fixed at build time by TARGET_BIG_ENDIAN. All other MSA load
and store helpers check the vCPU endianness at runtime via
mips_env_is_bigendian().

Do the same for the doubleword variants, so they keep working
when the vCPU endianness differs from the build-time default.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
We have a better conversion of the runtime helpers by
translation which allows to respect atomicity, but the
series isn't yet ready, so meanwhile this patch is useful
enough.
---
 target/mips/tcg/msa_helper.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index fb76524ba081..1919ce6be9eb 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -8300,8 +8300,13 @@ void HELPER(msa_ld_d)(CPUMIPSState *env, uint32_t wd,
     uintptr_t ra = GETPC();
     uint64_t d0, d1;
 
-    d0 = cpu_ldq_data_ra(env, addr + 0, ra);
-    d1 = cpu_ldq_data_ra(env, addr + 8, ra);
+    if (mips_env_is_bigendian(env)) {
+        d0 = cpu_ldq_be_data_ra(env, addr + 0, ra);
+        d1 = cpu_ldq_be_data_ra(env, addr + 8, ra);
+    } else {
+        d0 = cpu_ldq_le_data_ra(env, addr + 0, ra);
+        d1 = cpu_ldq_le_data_ra(env, addr + 8, ra);
+    }
     pwd->d[0] = d0;
     pwd->d[1] = d1;
 }
@@ -8389,6 +8394,11 @@ void HELPER(msa_st_d)(CPUMIPSState *env, uint32_t wd,
 
     ensure_writable_pages(env, addr, mmu_idx, GETPC());
 
-    cpu_stq_data_ra(env, addr + 0, pwd->d[0], ra);
-    cpu_stq_data_ra(env, addr + 8, pwd->d[1], ra);
+    if (mips_env_is_bigendian(env)) {
+        cpu_stq_be_data_ra(env, addr + 0, pwd->d[0], ra);
+        cpu_stq_be_data_ra(env, addr + 8, pwd->d[1], ra);
+    } else {
+        cpu_stq_le_data_ra(env, addr + 0, pwd->d[0], ra);
+        cpu_stq_le_data_ra(env, addr + 8, pwd->d[1], ra);
+    }
 }
-- 
2.55.0


