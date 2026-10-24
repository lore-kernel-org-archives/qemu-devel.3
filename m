Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8112A606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VbTZPJmH;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OVeR3BDs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgS-00046X-Uu; Sat, 24 Oct 2026 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgL-00043x-IG
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgJ-0008K7-Qf
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:25 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OExqj61353386
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Wqf0dSnUfCG
 lONgOWw6fTnGlfMMyVqUygUlILWGUw2E=; b=VbTZPJmHt99+0mbF/XcG97bKGy8
 SPJj+hshe6/IGaSj9dXmz3u+w7O3rJvlcvuhOyoWjTbYLl8k1KB15mQ3/aZFx1ur
 RKsjniXZcfRYG7cF+/omAZX+eEyjE2fh0hIddEiAp5JPlLwvp+4YKtRhh2sHNXqu
 3VCdO5jD5S3t/OFk7OtteEFNOesJ+WF4ueNO5oOPNB/YwCvr/KxJS5KT/6xx2Ciq
 lgaD551eL07F+aZLAjYDeQOcPpIBvJp4dO574r3kPmjVX5/JdfzK4OyrazBr+ZDG
 dol9BmHJHr/GMsfCGnrnWZFaeUxMAKDFnhBxU6NwmMgPo0vhPorZE+AkGpw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgnehhc7u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab2395f104so1544888a91.2
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863432; x=1793468232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wqf0dSnUfCGlONgOWw6fTnGlfMMyVqUygUlILWGUw2E=;
 b=OVeR3BDswpNc1Aq2ZG+Y2tY0uGQBFp9j7WaT2aScuabj5DApM2sRsyIUEy227QWnCO
 VxEwb5lOWAWhG/zex4JoMqk4FoftgPVVD61R/yjF/kdci3NBzLft/MUd8y0KFc7yZ1Ny
 I4+1ys/ET4FwQaQOoJgRjMcEPOUdeyfJw+EmyIwBGgLqOvuB94JcGJG8eYrC+Qf8/wnp
 LhcHTqnPJr6p9i8fSRlqetx3rSaRM4B7zzuTvdAlEesW5KSE2bbB2KWnwXfjBYrdYqL5
 43JsQ3dgMqCEmZNE6AUg0+pjTqlZpkQ3kP8QK+zC0JFY5kDMHIc6LWJuymCJ52pZ28Tf
 Ra/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863432; x=1793468232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Wqf0dSnUfCGlONgOWw6fTnGlfMMyVqUygUlILWGUw2E=;
 b=Lb6UrLNpp8ncH85K5J5elnTAj4sKouP4NPhbHNtCmMhgWatSpTK9CClP1hPVoFvRYy
 7dZImQp6ZFuY7KWpt5MvJ44FmompVHJnl0cJjrkHQdx4eCXj+8+ujLI5p4RrtPo6gvQ4
 NbZsGGwrumSFdZU9MeiUV5bMtYSYpQlG57j3GyNJU5Ki2Kd8dMZArdVuVwKldCV6ej/a
 h4wbqAkGAINzv8UfSsK2Xv60Xcdyf7ftglO1jVSluoAH+hwsAFDyRc4DO6pNFJ+dzqBn
 LH7kGzixKkO+w9c97ggNMgtzpV+DC12j+DX/7+Lvchtoh9hLn7DTqSH7kkfN6n0T7Izz
 5IIA==
X-Gm-Message-State: AFq9FYI6oIhFTbl8SLd6GrBCQ2qjwfMK8QogGHe749idMUxjx7gj5o6g
 bOzJVINfGSraMt8U37CsVDFI+21TbD6JijJdJAQaLhs3bt0/q7APrXSZEFik7+F2sqtMNfyhBy5
 q3uUiPWAkRNTWH0t339jGAARXgusLfGOvcoz2xDSSXwJTIA82gFt61ehzqtnCFu2bSw==
X-Gm-Gg: AYBFou1qD46gpooTTAFuEDJiCoc2xm0gc4RjPGNlkl8rcib0hgUzHlMkCbazgrO4j7n
 jB2MaHR0hrGO55dl4P04FhLcbceP0eWl/obtuvxKuG6ixTYFQJU52jauWHxVGDRtEd2l8mb3RLV
 4It+ZkgV51DtKlLX6QR5Y3XskZfqvYL3p8NMhpEhqqNd03dgLHidE1WI7COivWIlLZNwjQT9QRf
 Bo6eZ58304yAXDp0Aas/ZMLgcv41vvAuez3gVrJCcQupBPmRtlbGN/bOgBgEBdD+kf9FUSiRwOB
 TA5GFGLorQ/W0iV8k8KmPUK7cLxuQemXOkgSeUJbenuye3OV7OnfMx3t3skofb7zPy2LfTFR8/X
 9HdME9rF2DwkgpZDTGoUXHpMnaoBFF/LHy9D1PwuS3c1OG8RdOz09jLuF6NRT15g=
X-Received: by 2002:a17:90b:56ce:b0:3ab:be66:ddc7 with SMTP id
 98e67ed59e1d1-3adea89911amr2416696a91.10.1792863431737; 
 Sat, 24 Oct 2026 10:37:11 -0700 (PDT)
X-Received: by 2002:a17:90b:56ce:b0:3ab:be66:ddc7 with SMTP id
 98e67ed59e1d1-3adea89911amr2416677a91.10.1792863431182; 
 Sat, 24 Oct 2026 10:37:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:10 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 17/20] target/riscv/tcg: restrict tcg-accel-riscv-cpu to riscv
 targets
Date: Sat, 24 Oct 2026 17:36:46 +0000
Message-ID: <20261024173649.7405-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX019+KD2IaNp+
 eTrgSQ1tY+3K0TBmv1PaxuzT/5i6MbD38o9xj6v6eE6mp7X/YAvP/s7LT0jNgymkgAph/zRJAts
 j1f3m3oFjaDq+OsWSgK/ISkh1b5jUTY=
X-Proofpoint-ORIG-GUID: sTa_taE24Q7jNJ9QnQ8ndwW8dKuz1vNF
X-Authority-Analysis: v=2.4 cv=d5tgWhjE c=1 sm=1 tr=0 ts=6adcecc8 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=_sBhEEXM5gZMwKb8aCgA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX+oIpxIOj2DCk
 HB687COYjCUvv61h+N9pvBw0an1LrX8cdVqHDsE+qjB6yHCtihTq5b42sK9Fo4CLpeGz4d1q6Kl
 yw64IwUr3O2MwRojI6DRmpbOF47q0BFbEeZPXEVE+n3XkLrac8xx7VkbPHr5wsvh0qdjY1FVo+L
 +V6/Uxpy2tOTF6zCw4QwLbb4lRNuZHM//T0QnAbyPYa4fZHimeOvC1GGaReRRzbJSH8O505xUGe
 Ep3DL8o+OA2UwVT4U0iqt7dKUwu/KpywJ498sgi0XSqe6QoacZ+slZ8m5RwEZeHgk6mRK91/clb
 VGdvM6xgniJQaziKnpqEOUjny2a9fkpXOpcLb3l9LwjqeIaqZ1K3lsnDznQbT4/eDtd28Fyak6W
 22Jqs15/pRUwNlYgHEwQudC3By8Wn5cNLEVIMlcR/mbwjKtlJ07Lsw+DmgTLv/3Cem9ryWwdOiZ
 kOgxsFGev4zI1wQz+ig==
X-Proofpoint-GUID: sTa_taE24Q7jNJ9QnQ8ndwW8dKuz1vNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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

$ ./build/tests/unit/test-multi-target
Type 'tcg-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
Aborted

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Multi-target test takes the first target available, which is not
riscv in current state.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-7-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 80c04636175..cbff18afb5c 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1748,6 +1748,7 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
+    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.43.0


