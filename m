Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57889606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=o6hveQB/;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BQBbQUMX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2Hx-0001ye-Io; Wed, 11 Nov 2026 01:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Ht-0001ve-Na
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:29 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2Hr-0007uO-Qq
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 01:58:29 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KDJB1409011
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V0lfivLAx81
 qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=; b=o6hveQB/PALGku4Rxq9pDou96de
 lZukATrjT5OzoT/2JuvD+KgOS8qebcHQtyxP5TXHUWgU9Sw8g/ET5AP1pTjFRUum
 WOuudsVWTkIz6JKbk1UG3dG/gh7tsnbU4OKJI3ssIBubp9um1uCO1CJ5JVLZzFle
 cxzx0SrQtEHmr/uocsWuadFAWkLY4qrW+XqBO7esYEfTisiGza5lbD0Ihh5eY8p3
 aHyBhCihHdKKiDG/zhuDB4h823hEVrLHklu8kqCnF2WRo4LTID4cr74EZnLVQmRs
 Cwr9Br5U+4qQIv39bVnVt+z2mZEpv0/3oTaPaQv2FYqHoiEqYgLJlBPhrVA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdgnct-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 06:58:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93909014c85so605342785a.0
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 22:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794380305; x=1794985105; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=V0lfivLAx81qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=;
 b=BQBbQUMXcm9ZVsw9dTnMScA8UfTwhCmOKPgqSYsPu9KYzZKI+GHNTMY/CHLD26d8dH
 FYtyN+1jfSYi4Vld8HqMWxxGO7apKghW2QXfI6ZQZabwX2bXVRzkSrWV96P/JUiQGbsa
 lRYbUdzzGNficWphgqbmhvZp8FZneWsj3XkFfgsZgRl/eOEpTmj4SEmqSXpAT1A/9vH6
 V4190T8A5GB0clXNjdN2BmZwlDUU8XXzZhc/wbUhcssm882KZMsoYELOYjOYYDLnpJm9
 JuCDw+XR/IOs2yI6TKCV0Jvw/HAEuMcYQxUfHbh7ulHx1fY8zSTGNC4zxejMrK/slW0T
 /l8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794380305; x=1794985105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=V0lfivLAx81qjccHpGn6e3n3pqQvnE2uIqshAxKN1NI=;
 b=sKYExMgUZOn7y50P8j+eI9v2fwBwHBx/rlqxGfRz8Dr4c6TtRsgJo9PxRr5+wVp5dr
 REdIczlDgqMgRelk1vbs34otbIXetLfln/7DKImJR+6oaWTxMO+4ZkWsjbkKxPbc/bya
 RkzvpPZ7Vq93JPBqlZ5JxNxAUV1XBXq1KyOaa9sJDJC4LFWM0nnQOdXl/BAW6WTTquOP
 TVl09VzwRRMvI/teN0BY9HHd7ZqllCAWWPfBIVaCAoBJCBWjKzdX1gCTqFMQr9SmoUoq
 LlqLpy0CfObiTjWAltwAbuJ8EoL1ApJEvPCNctU3a545PSZ7GjtepnXNYBtAD5f/Efa2
 u43A==
X-Gm-Message-State: APuU4Z+a3t3YxlAC0Cw7P1BNBAX92jX456hKS3JMfldgp9gHAbDXPsjG
 Ze3GsdVBBHCKGncPjF7ssPmOH/GCBzjYkbmuyL8m42F9fHGgmPmCihUuoJ9Ss9zCwouNSyI6yMb
 ljlU5Jl0QxhbZlqrixWnZzcslM9SCZ5gN8TqE0QBQdvIqwvTeFZ1N3/e7QWVvMpp0JQ==
X-Gm-Gg: AYBFou1jo7SnuxoxuHzg8l+vT/uj5LL2SNkTHr9zefKkGd2RAZqsPYS6J+4H1qUW/0S
 fPwQptyZo4LELh1E2+0C2ZpDF9B35bzyTYtj5dmJzG6TBHyNJjpq6MAxTM5y9sgSTEygDhwmUPy
 yRZJ2iWFaZIk+f5sng5V9EnrDoec1WyP9SrUkIAjv1DeUqXCf82OpK2kA6JM97ABGcbEHCOpXyw
 hBWZyFfiJgwkwuKh3h1dMxn5UcSjabwW5USBy82h+dbS6+8KB8h4ncCfz47YmGwhIwhAP0X5GRq
 RCxyxNutojXlbN9STPEdg2D1PaeZ53InvuCJOfEBExq/Et7mG9u2AFoWuh2eV6s/NMxZN5tM/b8
 ikpIXzLoGpdpZNv5IVeAqsSfBLjVoILYC3JbI8mGDocAGkj1f6xky5HKTVQCxqVmyRvh2dSkNgg
 cGome2MDePTkM=
X-Received: by 2002:a05:620a:2687:b0:93f:2aa8:c555 with SMTP id
 af79cd13be357-947b006d9b5mr236662785a.57.1794380304740; 
 Tue, 10 Nov 2026 22:58:24 -0800 (PST)
X-Received: by 2002:a05:620a:2687:b0:93f:2aa8:c555 with SMTP id
 af79cd13be357-947b006d9b5mr236659385a.57.1794380304294; 
 Tue, 10 Nov 2026 22:58:24 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e734698sm424919385a.13.2026.11.10.22.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 22:58:22 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 philmd@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v5 1/2] target/riscv/tcg/op_helper: avoid env_archcpu() to
 access cbom_blocksize
Date: Wed, 11 Nov 2026 03:58:14 -0300
Message-ID: <20261111065815.167869-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
References: <20261111065815.167869-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af41211 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=un_eBsdixQ8VRd_I7m4A:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: v869paWMPifg9cd-YeKojhy2bqlt8lvo
X-Proofpoint-GUID: v869paWMPifg9cd-YeKojhy2bqlt8lvo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfX0AVjYWI90tcP
 Y69f80IWP+kwFoZBcm3kT6qlHzE04ssaSM1G1lQUrbvgzWNOP00Y48C2LCKJXwEJYUbxl79xvzo
 vKFS19C31nQ1pOXkqGJtVWDprYFBtY8i4E6f5/hn0n/K/H2DwZRFY6pDUqfOvkhchQIkIOM77O8
 +LHCETy1QcgUNsKGcp60ORZiip0lY4PKNOOgrqcrzgAHi/EzrnH9dGaI5rknzL1+qCqXak6nmhP
 ogIO9HE+e5XQxKIaw/7RYOz39ZRiILvSi/gw+i0LTeCZKjV71LE7xpUJr/WK/jP1Qi1SE/2ktQo
 huKAqmclHwloRBu8bzDjBnrApib/MvANbCkdh9GqdPXETz/DJp06d3o/MI9EOSve6JoP8d9rQ5T
 s15ROjj3Q27UAi4GyJcNR6EuQy14RDLpfBj2r0JUAiiOM6NgW4W2ydroSTpqU/GxJDzE1qsyxBQ
 v7rG1F+bTINQL4goNzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyNyBTYWx0ZWRfX9efhwkh6nlaC
 rU3ruTY6+pgMe3krCcOmmdzgzhGrjNfkvle1iM6M9gtJ/cLbLk2n0VmlwRscRVtHlDExu7PFyd9
 mEysRZcNQxjarJYdKa34CJXeLhuNJPQ=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
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


