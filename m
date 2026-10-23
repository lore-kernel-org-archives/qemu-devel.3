Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D245606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 16:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=H9eyk28z;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=c+53HwJF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKHvD-0005Wv-6s; Fri, 23 Oct 2026 12:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHur-0005H5-Oi
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKHup-00027R-Pb
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 12:14:49 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6DnN2462566
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wut0XX83wStumCYoHR6qDbC1UUGLI5szhsFIfyrOcrg=; b=H9eyk28zX4rddYMW
 dgRSpkmtT4OHGuBPUiwrgSzuDlxJhZ6lwn+MK1A0Nva4WM/GnlvRpyZru8Yn6KqS
 hoFPDzzO2L6sUOUtCrGWk/qoNMC7Ql11wAP+XgPVHQEmyIlFbmkm07L9X02+9s52
 Kofzq60f26JvYuD6YcCegW/ty4nuVT6wbI1b+qPG/rHMbJxlgStSLwMYY3lFd+4X
 +hxr97DMm61FvL3ZNh7HCHmLPBdi3CrBoFxX5zsoJfFxwSeX/xmhnx0wu8Ap+b3V
 nRzXt2PAjpcsik43BnbI5pqFddmxp7t7dJPcaiNdmh+HyQsYxlaTlXtOj0Y45Qpb
 N6hBEQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtvhw9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 16:14:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93909014c85so208863385a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 09:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792772083; x=1793376883; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wut0XX83wStumCYoHR6qDbC1UUGLI5szhsFIfyrOcrg=;
 b=c+53HwJFyJIObKFPhBJklQj3izAS50oap8kyJ3iipTwBNVZxXLz2eNCi2jflYBXa9A
 6dMJRBCmiZowrOEppZoVcohYI1xfYAa60QTNvNQjTdvRDJiaUoSPkHakcPGA3NflcNHl
 W/ro9hgzwNpZsgoBj3Ehm2gig/NeDEPJbZZ/Mnlqu7lHFVPt6GRfn8k6SSZ9rBSR/Mmp
 E7MB8B3+nPtBxMYZTy4KXcsSgVNLtWJjj7tLpqQdjufDQvXZih8PDfJXzp29nwF9C/VL
 +gTLeHuJktayo2YwxPKBIs2DYRW6KGSWFqff1RbJTEr1sda8kZeuTaCg8PZyUUeIXUu4
 gY6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792772083; x=1793376883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wut0XX83wStumCYoHR6qDbC1UUGLI5szhsFIfyrOcrg=;
 b=vIL4BkBemyDW9U7hkjQ3ViR42oKbT0Q+hkZRKaOsvgIoNHav8RuSBisRKnhT8seJXm
 LXQwokOTpYRl9bYEmmY64gcgIs+v1mNDurN3+i+chXwtNHoFJT3A6OkvB4RD44o8tF9Z
 XG1hchwJ68WQViKKgqBhY4b9E5hjOeunoxtZip9prf7ZeItv/hlkNcW4D9USU8VgLie4
 1y5g+EXMWl4mxYmymhTyv/FQHPLov+oVCExNUT2wUmT03wnHPl/2+0mNLLnjGGgfYb0T
 Y3MQOmYiuP68fiqp0pWtOmvJ0ERpBEPp63x0QzYq93AEZxKaCdId//G1RTILiCZBiMoD
 0VUQ==
X-Gm-Message-State: AFq9FYJP6bKkLIY8T7MehV2crpd0Vy2SBOtO/d9L57d32ua3YD9iV/2k
 /++hvKmJUleB50tUem2OZRAEwRCdThx4hFWeBerOvwi4VE5xk9lavTSOGfKsJWG98SVVEf8eK2Z
 Ng9gK/0P1Ey52eperjfYJBTrKFE5vhLXu2WsDlDBD8J2jgftHy2YvRfJyNw4JyYeImjNQ
X-Gm-Gg: AYBFou1fvdRpE5CTE10wm2KjKzoG0xDLY8uf0YEGpa3Bs2bwobCuwQ7HBdK9UkQxqjE
 woUInl2s/HdNw33P68uHaxQLaOtPuRyWUdXdCILKJ/sQvFhNXTlHYsi6GNCaLy4xh2uAcOhi9qa
 b9oEuutyrMCbckTWJz23Zqjl2Dln3vdTXKeR4uRMo5WehwIot0u0u6NgW0XzxZ3ua13Ba92XrXm
 qdbGsAwIXdI4q45nXjLou87a1C9EUdgi+72t8xBcuBsN1bvU62fBlvpM/IPi5l48/ryGHIgFWRl
 2McNjzrOV/BN5KD/pQ0Ts4fgo/79OWvw04SET7Gpgz23lyr8GxgFD484vB5jfy9r7qvEM2sXJKe
 qxidYY01QKsAzAs3Qs6fi03Uj8Y14WCU+j3Kl0fWQ
X-Received: by 2002:a05:620a:6883:b0:93f:3e45:a419 with SMTP id
 af79cd13be357-93f6f7cee4dmr451577785a.38.1792772082928; 
 Fri, 23 Oct 2026 09:14:42 -0700 (PDT)
X-Received: by 2002:a05:620a:6883:b0:93f:3e45:a419 with SMTP id
 af79cd13be357-93f6f7cee4dmr451571785a.38.1792772082241; 
 Fri, 23 Oct 2026 09:14:42 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3d427e68sm784753f8f.52.2026.10.23.09.14.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 23 Oct 2026 09:14:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/83] target/sparc/gdbstub: Replace gdb_get_regl() by
 gdb_get_reg64()
Date: Fri, 23 Oct 2026 18:12:17 +0200
Message-ID: <20261023161332.60153-10-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261023161332.60153-1-philmd@oss.qualcomm.com>
References: <20261023161332.60153-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6adb87f4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=XEEDF0r_pM4_IqxSCIsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: JCZRwPvVjZTfolcDP5VIotF_C4J6WF-G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX/XuUHFUtt6Jk
 7IN1noOZIG4/reE1dZ8RFJ++T9eW9lOGRL+jNkEN4y86s0BEhQZY+lDNgMSkAbrH3LVKQLcePRd
 8Yc3ju1Z/w48BtW+PwcTiNrgWGAY9NyEGaoH7Qd1PV39z6ITXIPnn/5xcWzINsUdgwFjIx8frCk
 79KaVfwZv//HoBtetH8uN05qHTgBWagQCla2bHu/YVa80hMOWGU/d+6CBchEExrbh1bZMwzzveU
 yi+Ek1cW8NNhScNmm5eoiSKQK3C8t9d38qRAWZ5JraifkfEVISuNici7+B1REEdsCJdbB6QLd2T
 OzhkrRuK9hpTFsBZJEH4BCz7MkDufGipcjlfB8zzbnP3k2fbyx/ZOkEhNqtZcqxXLYZcfVVxmpR
 QM6p7hV0FXjhBXNsmg0Ec5joHuedTHewUopven8c77gjJtZfHM7KQ+VUT8Hg36muNOJv8Al/5VT
 MWc2cCBN4RAE1E8sRfw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MyBTYWx0ZWRfX6RtNGz21J46s
 vhrGt5+B5pvY7kClOJEGIOymHL2k7ajjsMFlvGxeXKnaJqt7TDmlZIDO17EnSYHjg6dQpBcZg1o
 naMbbC4RWVNc+lmDLjZL81e9HTZU0So=
X-Proofpoint-ORIG-GUID: JCZRwPvVjZTfolcDP5VIotF_C4J6WF-G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230063
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

The gdb_get_regl() calls in sparc_cp0_gdb_read_register()
are guarded within:

  #if defined(TARGET_ABI32) || !defined(TARGET_SPARC64)
  /* 32-bit */
  #else
  /* 64-bit */
  #endif

Since the #else branch is only compiled for 64-bit targets
where gdb_get_regl() forwards to gdb_get_reg64(), we can
call the latter directly, dropping the use of the deprecated
helper. Assert the invariant at build time to be safe.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20261007232326.66240-2-philmd@oss.qualcomm.com>
---
 target/sparc/gdbstub.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/target/sparc/gdbstub.c b/target/sparc/gdbstub.c
index 2874ce1b350..d3ccf533839 100644
--- a/target/sparc/gdbstub.c
+++ b/target/sparc/gdbstub.c
@@ -106,22 +106,23 @@ static int sparc_cp0_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
         return gdb_get_rega(mem_buf, 0); /* csr */
     }
 #else
+    QEMU_BUILD_BUG_ON(TARGET_LONG_BITS != 64);
     switch (n) {
     case 0:
-        return gdb_get_regl(mem_buf, env->pc);
+        return gdb_get_reg64(mem_buf, env->pc);
     case 1:
-        return gdb_get_regl(mem_buf, env->npc);
+        return gdb_get_reg64(mem_buf, env->npc);
     case 2:
-        return gdb_get_regl(mem_buf, (cpu_get_ccr(env) << 32) |
+        return gdb_get_reg64(mem_buf, (cpu_get_ccr(env) << 32) |
                                      ((env->asi & 0xff) << 24) |
                                      ((env->pstate & 0xfff) << 8) |
                                      cpu_get_cwp64(env));
     case 3:
-        return gdb_get_regl(mem_buf, cpu_get_fsr(env));
+        return gdb_get_reg64(mem_buf, cpu_get_fsr(env));
     case 4:
-        return gdb_get_regl(mem_buf, env->fprs);
+        return gdb_get_reg64(mem_buf, env->fprs);
     case 5:
-        return gdb_get_regl(mem_buf, env->y);
+        return gdb_get_reg64(mem_buf, env->y);
     }
 #endif
     return 0;
-- 
2.55.0


