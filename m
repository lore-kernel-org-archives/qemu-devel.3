Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA8D606A32D
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 21:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NS3vGWPk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TIj9UUZo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQtJR-0004Fn-2g; Tue, 10 Nov 2026 16:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQtJO-0004FM-Of
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:23:26 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQtJN-0005fJ-6V
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 16:23:26 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AAIoeww4187230
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:23:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V0lfivLAx81
 qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=; b=NS3vGWPkoDsFUOAHPpBbBmf9UmK
 UNYs8JH2xWubROBk5p/eRstb1z+z5vOT2RhnynhP/Cmr8YyI0mHrNHr4SVNawWGR
 mqZAdx7n6YbXC6Z74tSgFH4BakrdNmKmYsp3EwzW3e12+8EPy58Aa+3OVZGUDXvd
 dPLOn2PVSD6A/D6oxcpUGXN08m1DaI1WUMUF6yetdecZPkSjxciiT+th2hUuI9ID
 GeRbgRPZ7JxXGfTfjp/wGzzb9pcio6uv29JdSFIH8oArYTETutVWCZ+M0wQDDx0Q
 hhICu67Uq6JDUdCkwjzBYD9yHwfpRqtpKpkH62UxEN4M4BP8H8Nmh8s7z+A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyufty3t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 21:23:23 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91ea71789d8so66667656d6.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 13:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794345802; x=1794950602; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0lfivLAx81qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=;
 b=TIj9UUZobqNDW65tKk9Vh6uUlQdhNMJy4LZ/49ELppiF682Ei2ItE3Hzx0m5hd7PlP
 Gv/brV/am0fLPkxeDuCa14O12HW066HLFNZtjCLLyTyJJWF8mSoXEI//czrgXEbmynRc
 2l+4GWFdoTXB9Xc8GqImaXs7TuOQKe3QSF6Dbft1wrxSAJSg7egs8m3B8klQXHtS/cwC
 6L+BTwcqOXwncOX237C20svHd3LU1oLcatyDW6W5uLsjL306yruu6uphzNx5TAPFITQg
 RR9vKRh0mdVL7QcUzlanDzT/Ce5DFM3eGdjjnRHRtpQH0DSM54I8XadPIs5RMjnj2mng
 KWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794345802; x=1794950602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0lfivLAx81qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=;
 b=SJ0jr1J6unF8fHvdSq95IdvMaLQ1KwQLH5YndWRmh+y2OsPFqJtmFS2oVSUrPQdQGw
 xc8T1XmUy6OAvAWTtHzgLsGvzXOSRrvMuE4nbLnVKuI8ewyTbHYo36FdhK/coDMvvDMU
 vaXJ6OUnSB+LeADt5xF1Jm+3cF1Sj0rxcsMpiPd6vosmQYAhdN/FUP2qUZJL9PLGKmgl
 /oqRT+9SNWM7XeMIbb3uVwRXH9VP8XqgUqBjX9+lK68GUzAX6WqYd5mInXVkdxogJ248
 KgOJmjAkKUrVzzmX8tbL8zuU/yfz1oQ0dWyjOAhPiRpgH7SPby6IyLb6RYFaq8TqaDG4
 sK4Q==
X-Gm-Message-State: APuU4Z9I06+jxWPzvbUvsqQmaqdsGCYCa5rspiwIsaauxTT+5angFM2l
 9j4eFtj2WgW97V3lunZbdTA0GQn7dajZEfbeoXCwKaKcpmKV3ABy62TZpY4b3ipBPLwAK1O26nW
 MQl+DOYOSR2UiovtdpqYFWLTmKgiq76PvpY3RmolR2YDp/AdPgmJm6npmhfjz4bzO6Q==
X-Gm-Gg: AYBFou3dvhO6gJBN954rHJFLJIr369xC4WSTugnlKyAYVr74E7H8uM/qDJM1qwP+gMZ
 yHcH4T1ICXr/IXsRKvLz35PIgWVmoTfslhlz17WEiDDlS6BnWOkpltYxPYQOZkM343Q49KY++fP
 C55e1vDdjiBlg1JteyAnzEE2A/96VYxPvB70JLnjs6VAzsza4lq8MnqrMHqD/m1mwlDtOsQm9C9
 iRxwloogTm9gcCZye1dF3KcLcS3d2uNj46mCnixnKM2u+rVTgkIqPA9p64oELJEAt6abz0TGFZd
 3FAD7VC08xFPZEJmnK4FliowDc7kDBq0UsRv2Mdd+9oZ8+qdmVB2d3TQ6kgLut3hcvnIlJjFjSL
 wHt+MlLdUPjW5cPxK/MMQ9p88wem/akxQBryTDZhQLKgOIKHlrUqrdqo1YlSy1+aqlg9nUDNXO2
 DQWmrgzeq9qAQ=
X-Received: by 2002:ad4:5fc7:0:b0:91e:a05f:25e3 with SMTP id
 6a1803df08f44-91f04001c7fmr11352546d6.20.1794345802035; 
 Tue, 10 Nov 2026 13:23:22 -0800 (PST)
X-Received: by 2002:ad4:5fc7:0:b0:91e:a05f:25e3 with SMTP id
 6a1803df08f44-91f04001c7fmr11352176d6.20.1794345801625; 
 Tue, 10 Nov 2026 13:23:21 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91efe5da1b4sm13117746d6.13.2026.11.10.13.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 13:23:21 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v4 1/2] target/riscv/tcg/op_helper: avoid env_archcpu() to
 access cbom_blocksize
Date: Tue, 10 Nov 2026 18:23:11 -0300
Message-ID: <20261110212312.56809-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
References: <20261110212312.56809-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: LKzGzkS_dacuO3j3IyO-X86bZfcNO_a1
X-Authority-Analysis: v=2.4 cv=S6lMU4sP c=1 sm=1 tr=0 ts=6af38b4b cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=un_eBsdixQ8VRd_I7m4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: LKzGzkS_dacuO3j3IyO-X86bZfcNO_a1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA4NSBTYWx0ZWRfX0eqT/T2hRZn3
 og5/kYQbtXK5/Di6bKkR0z1EIqTZtb9gYvqf2e59xClFSXWz0t0XA+sShI4IjOqvszj+T8IJXql
 d4ykcm96VJJo4k+SmISLBKanVhS7SPc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA4NSBTYWx0ZWRfX2ll1gCGrRsID
 LvUkz/0aDsEu5tFcQ+H3gipHTD/O/Vv6uW50eMEOvMhB1uHX6bMXNH9Xk4UxWi9vveK4T6GjADd
 DkGotSq/bnmZUXLoVXxTK8dM82SCMRWEtYUKBXRPJQEd5cTTJ1jZCogD4M7DrPlbY+PvCNjeWyY
 c8hZiwOBkSJ5sM4i+8RJeGims4J3Xm1/yHHFHoccgr11tNBdYQA0uqJuHjljSTIDTo66SrCmEjh
 DXFGo9XGcFAXC6Ws0Kpljll7dhisLrpXQErQTtsYpgvGjsTdpHUp/6QvBXCO/IVPcj5GRTP73A/
 ZulMLBD4f9mzU6DlSyYX5fhwAKmI6I8HJIeFD8ckaJmKys3YwERqWlV+h1/qAxNjvv+APCb+dAX
 Pn0gk5gcg9sb5WXcq1tPj03h53oTL6gVZjqnPFIXhV5LS070EVxFiY7sUGr/sbiV0dTQTSpvgov
 9kzGrkrII5O80VO2bSQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100085
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

There is no other use for the RISCVCPU* pointer aside from accessing
cpu->cfg.  Use the riscv_cpu_cfg(env) inline to retrieve
cfg.cbom_blocksize instead.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/op_helper.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/riscv/tcg/op_helper.c b/target/riscv/tcg/op_helper.c
index f9c79fe6b9..d7af56ef61 100644
--- a/target/riscv/tcg/op_helper.c
+++ b/target/riscv/tcg/op_helper.c
@@ -229,9 +229,8 @@ static void check_zicbom_access(CPURISCVState *env,
                                 target_ulong address,
                                 uintptr_t ra)
 {
-    RISCVCPU *cpu = env_archcpu(env);
+    uint16_t cbomlen = riscv_cpu_cfg(env)->cbom_blocksize;
     int mmu_idx = riscv_env_mmu_index(env, false);
-    uint16_t cbomlen = cpu->cfg.cbom_blocksize;
     void *phost;
     int ret;
 
-- 
2.43.0


