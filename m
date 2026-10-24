Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91B606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EpOhS1lL;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dDB6wU9X
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV44-0004ma-FX; Sat, 24 Oct 2026 02:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3i-0004dZ-LH
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3g-0004ai-BJ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:50 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O2Brdd820337
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3k4AnbR5DeN
 GVLanxKtCzEtiBxIXHsY2MNppOlUUzwo=; b=EpOhS1lLt8NbGJ4G82WZC2hFUsB
 dCSrtI6884nEqkBfrgDRF/y9cN7YmmPlKM/M3iu90U2i6RyBVKDzJhJIVZbM+BOG
 5rGaHc3+dW1M9hIAOgG5Js178wAPBi6XECpOlT92g1oSYYcUu5RvcgwwY8FK6Dh/
 aSyQEqlOnc/Qkn6eToFSlJOXXoE4tY9+BVElpf4Zj81J0Mq+Bl8NQ9RxNxmnB8s3
 7ZfKLrxwSC3LkQlt/ug0iHmi8s7+TA3At1y/UBqMFSK1CjtDDFfaK8sbHe3Mgdd/
 0CJj8QybK+blsLIgb+dddQCj/kEDMNRF4v/BIwR5tBIIbT7SKStUc+kuIgQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6gekm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:47 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3adcb81f487so2267068a91.3
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822606; x=1793427406; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3k4AnbR5DeNGVLanxKtCzEtiBxIXHsY2MNppOlUUzwo=;
 b=dDB6wU9XAIAOlJJaWLbR6NMsk/kvRysIYkXZHGXYsyGbdi55JfgmfrGC9xwCYVFSQI
 m22tJkADL7HZWZ47Fm0fFSoKLiu9xVykRjDgT+WuL9LeroMLdiJtKdtAskae9XexpblS
 iCcWkha42hIAHpJqqAoiFk6ty3vWYqmd8iQdDQhTpQzKOKV+spSGGdx3h2VRAOKUeR9S
 GuW4oNXUetkismnT/WBC6BDsQqK5+BMK5TlwGDRudWYJ30pKelSskD3ZnJT4dYLa/MXc
 NBhCOU2Z6kGJqIhdbQKJMm3gHGhbe2hxP110phZHLXkoPGmRm7xPESe+UUbhYyImYqrz
 nm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822606; x=1793427406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3k4AnbR5DeNGVLanxKtCzEtiBxIXHsY2MNppOlUUzwo=;
 b=P6oKhRcR7nJ+oYlWTNNkWw49cr/ygPzQXYIpidVhsV0wXKlKSFVBJd5VzGfDTntkN3
 gUlHpeDRFVTCIfbf5YrEKkCDJJAjv5NnDiOHQHpDnNgm6+gyacUnvPaRtA36Ae10actd
 XxFlL4auY2FmGMmeJ1L1GDoQA+nHwAMXRFY/bUJuGa26JT1cUnmUO8DaEa5cjUXPb9vP
 F8N9txShz8sk67omd6zpbZDqJNg21ft9Mnk1dye4ebg5e2gy0iviJVkmQtPMxvXSHfwA
 ecsRO3/c9SoLbcpYyYmxHCk7EZdZ6T/pBi34i7PuaaHedA/+4nk5rvmVEU+dVYsg2VEi
 8PTg==
X-Gm-Message-State: AFq9FYKu1ZBQkqNGQ0+zRa+28jgHvK7upTZotHknfYe0hjwC3eqpm2Q/
 x20SDyWOgpsFOJX8DoTKNK+guVHCzQNeE1TXkSQXGnexZIZ6YiwPa2Ze07YnzoxgOY+vXuPN5IG
 7RMkADKtqEJlrjY4eENQ4lrmRypLkcYzhF3x+iTLhpJfKVAmuqA7aSbYkgaBfO89NEg==
X-Gm-Gg: AYBFou0HYjyyxWXZ2Er7rg33yMs3XB60S/3QD+tqvMTSjyWtpr7y9GQ2+nuPv7Vyz+/
 g5KMUKREEj6OLJHr199g/fZOFLnS8dEKVUCqWLUfC4RxrLhGFMvxYhZ5+L9u985DzR/FUSxYV1B
 AVOZ87uh4IWARJDguu27yVpAQuX0DEWyhcWvGseUBo3HVdOLvrFRREKHh8YZT5wibGaLvb7c0ww
 o6J5G5dQT0/ox5zSXnYvauO+Qc7N2GcI8dIgqklAfkwUXQSHXW8bDUnFE7/MXpaNcPpOlJQmq/x
 F/HGF444NNGjPfG1UPm3LLhFVrJ8QoLPQg/zq5c0Lps2mJw8qBlO5oYMs3KGWXoiV7b6hw6OXOT
 Bh+yZH/Z2Py7Ail/1NJCER2bGbggUZj3RYJbrMGZq3TFbDO1Y7+U5sU1qFJRHrvo=
X-Received: by 2002:a17:90b:4e8c:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-3adeac07c4fmr1195659a91.18.1792822606404; 
 Fri, 23 Oct 2026 23:16:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4e8c:b0:39d:84af:a0b3 with SMTP id
 98e67ed59e1d1-3adeac07c4fmr1195649a91.18.1792822605991; 
 Fri, 23 Oct 2026 23:16:45 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:45 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 6/9] target/riscv/tcg: restrict tcg-accel-riscv-cpu to
 riscv targets
Date: Sat, 24 Oct 2026 06:16:12 +0000
Message-ID: <20261024061616.27381-7-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 6J4W5zJuUc6x0JwkdV8vVsVbMpir6i3E
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX73x0Fym+Jt3H
 Az46mRy9cwavPGCvB4LLPP4k8W/mNGOXIIk6Mq5Mz6XcD6XKheUwZ89ZxLyEnPSMMcpqLtauaHN
 TW/8APKzCQBySOw/hRPkeRrufbmwEjs=
X-Proofpoint-GUID: 6J4W5zJuUc6x0JwkdV8vVsVbMpir6i3E
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adc4d4f cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=JF9118EUAAAA:8 a=rPeX-qeqI60SAoByUTMA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX2OpGvwMfxzKQ
 yax5ywxXjvuHhL4kG86MVGZGix1rBBQyhYwo4JrBr0Yy5GYpvyh5ozs9+jqgY2hz2KngT9wV2Zj
 Lt9iSRVQ2FzBFGqVlplkC63VnjpiSDVUTBWDj/WQeaHk/i6J/smiH6MoA3NhQWJlNRDdMWRXeEW
 hkqBUPdccn64iv2jr8CK973gLBSIsT3Rxzj0fprS8UkLKZ7wPE3sf9wAmsDRXk0mb9qCH5Zn3ig
 5uz4xejBwxBnBW4b3FQNCw3cI2gLYebdaq3kZSzwYJaciMlRez8BDzls7huZBh3ySE0skAIYOJq
 xOAEvobw3Fw4nul3rcfDJyJyAENY9obz4cl4D9XC0scM51bk8UbZ294caeQAypxEcQQbY6Cik1M
 ugwHstyeh2ogk9q4vl/7a52Vawj105cCxBoqBbFOIyr8wsT6OJ/QQ7HzODAbsqcp1lz9KxAegJl
 efDntBo6gez0icmMjKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240024
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

$ ./build/tests/unit/test-multi-target
Type 'tcg-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
Aborted

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Multi-target test takes the first target available, which is not
riscv in current state.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/tcg/tcg-cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index e07ca95e49b..be913602489 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1749,6 +1749,7 @@ static const TypeInfo riscv_tcg_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = riscv_tcg_cpu_accel_class_init,
+    .is_available = target_base_riscv,
     .abstract = true,
 };
 
-- 
2.43.0


