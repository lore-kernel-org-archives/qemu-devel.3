Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACF4606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cWyzuiZK;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Yvqdmep4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xR2PU-00065O-Nb; Wed, 11 Nov 2026 02:06:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2PM-000626-Ti
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 02:06:12 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xR2PL-00029K-DX
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 02:06:12 -0500
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AB5KHr21368993
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 07:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=79HMMearkZU
 SoJ9WoAI6N2QEB6zq6p8A7J7HDAqWuTw=; b=cWyzuiZKbezV99U56mgATvvNynx
 Z+lAcHCDEMIjch9iijWsUaalYXRqaqvgjx2C6zZVvYrOUlwtrDt1or5rkwBgMpqO
 J81lznBwt6qh0oJhVU7eTaZ9rQeNVuGlVSzTTLpxWe4S7JqJpKMMcpSq8ZpZwxc2
 pNia2gvKcoO2Pv8TvPTeZqv7DN00QslI4FSogzNE3eTU6kCWyEKe9foTvgucex3r
 cpgGJjULmidHz3wnYhVspR95AkdLGI3DcqusdkCJjAwE0PZTVkkeo6woB4PD2Xjz
 VAkvfsrsy4hF53QO4DWUzwEhJiSPqAPlQRxmhibyoNdnJAXnLZQUC7PFDcw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvcpehg1y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 07:06:09 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so610622885a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 23:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794380769; x=1794985569; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=79HMMearkZUSoJ9WoAI6N2QEB6zq6p8A7J7HDAqWuTw=;
 b=Yvqdmep4iO2luoDORUxMgpasqjohdp4X1kUp4xsX0nKop3mGlCEXBPhZRRgumXgpS6
 htIOSNxLhjPD5hxQ6goIWP+iCs4R4A5whzjJN/eRgVKXx4poycMSplYLuEXRUgaWe20k
 vM2a3trbev7K9UyA5RoW6CGTE2J/rx+hDmLWGyNNQRp6vjxKKhYZ8YsAR+c7LtBCa4C9
 +cNhhx6WUK5/5l/7SU88V2kIWgAuhH4sUOEu04yCiIrQsuKqd36IIBYPB0aVegyv6b1x
 tWCoJwY5KryVmyfFJ7mDKfpjykY9oRxil2IZuGboKPYZyEM8imxSuj86GTfvld5J06Mz
 2bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794380769; x=1794985569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=79HMMearkZUSoJ9WoAI6N2QEB6zq6p8A7J7HDAqWuTw=;
 b=s3KSABAkom1Daa52FOiQFO2pr0nSaxOJsJLFldbylRrxmZsJdph/FZClh4lJpedK0R
 ijxad45QuQPNqmytdzpmuuNyUGNotE4SHp8kf05iwNV0sgBmLL29fb5bcLHVBw/SDBgA
 i6cvYNHfHGFhrkLttRqiU+NYBcIvZHGCtrcnJPq7creozyvEzB6hIaGEeut1Jwq/BBxp
 fzdH1t/PRzkL16HSzSYEgtYm9HIWBvukxITViqBjGb3MoyL5BBi9rlO+91H9bNe2Ehwa
 xF9ynz8bSRfQaD726Fx9XiwXAQQUSIO4d2dprUjX/7RYuhwB5SUahycAgqbYeFYwucHt
 rItA==
X-Gm-Message-State: APuU4Z9LQpYLHrXCj4BbshLekmKCbmDbe3YbouFctuCJgUHGpwxw6HlG
 pucWFKsUCAxuWSCaWuspD+f3pjNwqXRR/C16qSUsVe2VFQtJzblE7ELcYfkbSDeVQdhwxrk/KBP
 xccHY25GBAZgvcXnV1c/JwcGt9l+35xTzqgSww7AuA4VnSWNZmSq+hsqSUKzX0RgzvQ==
X-Gm-Gg: AYBFou0sS8dMuR9Qf/B8+o52Q4GTPoUVxVKA1/rhW/yC+g+l+gAtRMntVR8yeP3PZpK
 x3da8ZKgvjEWCnVhV0psVUSxSUeqtH13hWcKjTkLSHm+lv8s/j+PI/eiMRm5AkawwVm/Ntxni/q
 ZhtmsP8s3fkqs+GL9h6HWvLByLX7y9vFpalCGywC2w6Bq9QVExpQ55YsM9TJolwGhMQd/i1Pw+A
 eaCMQxaeQBBOJR5j+JB/3OFBQTXLgqA7qKgWNZLMzzReOr5l8VGkuU2SLVwFRRVu5JiD+VNniH8
 9xRjbL+CHpDzMY2+V8iVyrIKKAO7p8GPkpyoZ077HNMSkcV19f5FUugt4hZjEMQ7JCH9Md/Qn31
 fwuGaWZPIchCTH5ahwP6MHhlPIgxkKuZ+B1Vhu/mUZeFMy64gEp2lB9P0/6KshTRj6RG0uHiUw8
 oIGJRaDtgDDaM=
X-Received: by 2002:a05:620a:2628:b0:944:192:85ef with SMTP id
 af79cd13be357-947afff4786mr239272985a.22.1794380769398; 
 Tue, 10 Nov 2026 23:06:09 -0800 (PST)
X-Received: by 2002:a05:620a:2628:b0:944:192:85ef with SMTP id
 af79cd13be357-947afff4786mr239268385a.22.1794380768831; 
 Tue, 10 Nov 2026 23:06:08 -0800 (PST)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e4fa312sm419911385a.0.2026.11.10.23.06.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 23:06:07 -0800 (PST)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v2 1/1] target/riscv/tcg: clear itrigger_enabled during
 trigger_reset_hold()
Date: Wed, 11 Nov 2026 04:06:00 -0300
Message-ID: <20261111070600.169519-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
References: <20261111070600.169519-1-daniel.barboza@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX9yZvxp53EokN
 WznwFBcR7mDnvbI2exfORoCLQUdc4JkjaZFB9qVR67MUJjMiT9zr/XH8QXbMaQsdRdsxXhtK2rk
 Xge1CLMr4vaMqLyt2C+PyX70gwQePzyTLVuR6mRmcQ+2SEL6K8G/nruwi6KBsJCu1oyKLEMIdsj
 oTd/k52qfAnu5WFx/hNtjgdKKfCzHFvBcKm+GhczI8Gha/z7VBookfvzv9tIZDrc68tQ8rplU0c
 eokYo+EFeukHuYv8fLZ7/hDtxgq/i2pj8IdWm5zzVaUUVMYFnaOa/uXgf/QgDqAlYS36r3O4m0v
 ZZlFSnsIhX9IUarD2+DzRUJd+kc0HpwU+RB83gSdm8lj2Iukyy3GdJEgSU6SisgRxXD+W25nzvf
 gloO3oZwzto4uIzcpWKwai6YoA0+2cz6ZxCA3HAPHV17gz9ZIXSsPFDh7JPZm9WRpDnB5aXCNci
 5/YrCuUSvIFoSZrRtcA==
X-Proofpoint-ORIG-GUID: 26fctP16r5fSdtXz6vi2KAl3BdCXQWQC
X-Proofpoint-GUID: 26fctP16r5fSdtXz6vi2KAl3BdCXQWQC
X-Authority-Analysis: v=2.4 cv=RfAFmFtv c=1 sm=1 tr=0 ts=6af413e2 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=zcreZ36wYqc89bCkXXAA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDAyOCBTYWx0ZWRfX5HSuo6ba1ML+
 PyYcZq+GbQLQC4lltgccCU+OujKBYJ4X2HakBNiYrNV6ar96EwR23hbNDOvOqgGFCvL+9wHaoQE
 QSRnHGHjb6HSz9xobFc+lmOZhIixOg8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 spamscore=0 adultscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611110028
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We're leaving env->itrigger_enabled untouched during reset() while at
the same time resetting triggers to AD_MATCH (type 2).

So, in case we reset the CPU during an itrigger session, translation
code will enter itrigger_match helper every time (via ctx->itrigger),
and the helper will do nothing since there's no type 3 triggers set.
And we'll keep doing that until something else clears
env->itrigger_enabled.  This is a niche case that it's a bit hard to hit
but it will cost a bit of performance for no good reason.

Found while reviewing an itrigger related patch.

Fixes: 577f02869488 ("target/riscv: Add itrigger_enabled field to CPURISCVState").
Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/tcg/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/debug.c b/target/riscv/tcg/debug.c
index 8b58cbd07a..988bc815d7 100644
--- a/target/riscv/tcg/debug.c
+++ b/target/riscv/tcg/debug.c
@@ -1213,4 +1213,5 @@ void riscv_trigger_reset_hold(CPURISCVState *env)
     }
 
     env->mcontext = 0;
+    env->itrigger_enabled = false;
 }
-- 
2.43.0


