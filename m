Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE8606A31B
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TyoxzyG7;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Gp2sB0ul
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgS-00046D-G9; Sat, 24 Oct 2026 13:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgC-00040f-1O
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfgA-0008KE-4z
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:15 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0HQb2371272
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rDmE5N4U2dr
 KVTM7K+myjX2FK8CnychzxE0Pz8AHPe4=; b=TyoxzyG7tY3LTPchsNKoZXpXdWI
 QJlC0280Ed6i/yInty/BulRUVG1sPcgpMGTh9qlZu52TjfguJ8MkkwZCJWyuuT1h
 DWcQ1CYDQB4uKi1exxKOSGzwRTGgfXFOhHyMzNMdnUvx3I+ihENJHgqfb+N5cic1
 /mg9NyhXiizOlfjUp7qRKwXMqKooO6KZ95uNY04DMQWLsgcfibfNuEWFVXnwtg0R
 gnemrzvohkrJAmvL0cI1dCTD2zYfHjI+4vLXMC83yPbgex3mEa/oItGJzngpQ9Ss
 kZqLTUG70uhzOnkjc+h4to4Bz8bGi1VX0Lu7D2lPc0aBb7cv2m4EUJYxvrg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgkp6hk5b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab2cb8d5dbso1513190a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863432; x=1793468232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rDmE5N4U2drKVTM7K+myjX2FK8CnychzxE0Pz8AHPe4=;
 b=Gp2sB0ulKijSBknNTOqWmR+P1g2nrugbUjra4Il2QB0KFr4GyKnNqbbgv5l1FHIX09
 SjR7VodgbO0GDvOjghmGi0zRbQ88zI4NV9lzRN95t15hEuG83UtWWIKWMKW08lDCee0x
 qpLTAr43Ays/st9N0CA2iaDY/Zb0J2zke8qrhMUiQ4HOzvdyYwXGsqi4aAhomTu53rPR
 c4D8OHnKreypnDRVer7bwQOIbgytaOu1VzqksptNcoJSPrPtjRt+lzn3eVHCilYX8tW2
 r4f5rFrauneT1cpD4yEQCbJIsDJ+OuZp8yL5ZjR718wXMOZlzvUDhuu4Tpguw/hHSc0n
 Le1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863432; x=1793468232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rDmE5N4U2drKVTM7K+myjX2FK8CnychzxE0Pz8AHPe4=;
 b=vnV0QdeuUeCFfPICvKZ3X+v2JLqtv4buzorcAzPHVZyZXakzqQ2kSsgLGIoQvkIyuX
 b/Gffsg7RBlXSNAJNC1cn2Tg8sA9DzlS8F+rKMcSEvfI3d5gQO3OFpaF9+F52KX51C3X
 TNfNyZs2NbH7n3nlYFujrtU4L/NkRPrHgPRuECFOi+BG2MJ6Z3BvHGKTv8+JQ+hF5UVs
 MuYaZJsWl4msJ0R1WXox4l6BOFJtnwrTZs2J0n2GKC3Y4KiBIxU3WvF2xS8Rd7tig+73
 J9OCtOUeTB1lO9sRRkgnKX450tWNWBTxYmNaGcbHS+y7qEIjMaKvD/2fdomfAe/9WXyd
 U4Xg==
X-Gm-Message-State: AFq9FYLJJiOmQ/43IlEkMMUK/KW4q24eHQODRgxuDt7A/X5g5MVPPFn9
 DQXObM1tjHiByGBnpHy+Zm69fiU3fzpLDdlyoDiRhLSESxqpiksatuf3cQUiV8yrle8MORNqLE6
 rMx00geexUia4HfKQekKyOyXO3V3t5wvRrqTkOWApKZuSlnGJNSOgAD0QP/n876vztw==
X-Gm-Gg: AYBFou1WEBxDmJIUjjyVIVX3LII7uORcXcySAztl3Q9XApC1BgvsZj61ulKV7bEhjWL
 8ZRQsB28va6tAOowMjQItTzPUTs2gXV/BWSbvqJzEqPGKRudEQXltBao1uFHW457cRXUDopqUUm
 8cAV8joHylJhTk71LTDzSWVM+o+yY2410rdqMHhZgwf4f4RLpJK239LhOpbMJFr9YbLhvxGsKoi
 bK9DTNTVh3CL4MLZI7zIBb7+xET9AXLUGIW04+hbB2AhLBqHW/uVJg/snq3G2W6J5PfwgSvuQC4
 B+3JLzUm2LDZrlO3pw7PHr2VgBIhGgbJ0V4ZqQR4L4WIVAhUVMSbdukL4x6G5++2u5SKtviDL+N
 efosIZjvSPGCLA65GObIEeKyJvaLnKoGoEvlHIZXa7WgUKcekxur36wXbqpEcHyo=
X-Received: by 2002:a17:90b:564e:b0:3ad:b86d:dbad with SMTP id
 98e67ed59e1d1-3adead249c4mr2316883a91.30.1792863432307; 
 Sat, 24 Oct 2026 10:37:12 -0700 (PDT)
X-Received: by 2002:a17:90b:564e:b0:3ad:b86d:dbad with SMTP id
 98e67ed59e1d1-3adead249c4mr2316873a91.30.1792863431828; 
 Sat, 24 Oct 2026 10:37:11 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 18/20] target/riscv/kvm: restrict kvm-accel-riscv-cpu to riscv
 targets
Date: Sat, 24 Oct 2026 17:36:47 +0000
Message-ID: <20261024173649.7405-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: whmldVfqCb1DdvMsOWQINmW9cXx4S1b3
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX9vxElyw2jHuU
 igsmX29WJjoJyQj8lUCs6GSTbrzI2RtoImLyDcmI1xiDp+tIS1wyU4WA0eexCgEyaRGlIcOlRoJ
 rFepMpmXCCmeUMmeOm8I21LD48g+V58=
X-Proofpoint-GUID: whmldVfqCb1DdvMsOWQINmW9cXx4S1b3
X-Authority-Analysis: v=2.4 cv=bq/Zl0ai c=1 sm=1 tr=0 ts=6adcecc9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=O-25e2E7vQ1JYfnQKQQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX61+9kFYFKCU0
 RnquWobuA+oXYdQUtesCmLYmfbVj0h2FyByhIRHplXUEPKFpgn+3XoKKzwy/I8PuskEc9JuhGnz
 PtGi20a+B6YnQsHRpJPSPesOel1dQbs6HiEKgATel6kXmJS3HxMZFENQufADxQL9Txsvqx9i/jy
 Qx/HZpz+BR9ThechwUKPTMEo6TW9G0a6fEwU5P5UoxtuoJGXgBBx9sk7ajq0iBdO7jOyhOeAUsD
 8l5C/Yb8lXmzqAd2XLNkpsKPN02vxYxUQNdVeaTbMuED5G8bch8QkR4iP7mORTVwEmt3d+aNgy5
 7PB6k1gF5e9xR6lAeqKg9gr3yrNUQG11SKEz43fmzuxq5Yk8gSqJ6GRTOg6Kp8ibGoKqbat/P6p
 QavbzTXGh8988d/WF8onFgCR/jKLUPHbQeF9+mr/77WezOPpEla6OPZKjJ09LvpteiZqDFK5P1I
 xJU6FqvZM97taDflyrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610240070
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

On riscv hosts:
$ ./build/tests/unit/test-multi-target
Type 'kvm-accel-riscv-cpu' is missing its parent 'accel-riscv-cpu'
Aborted

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Thus, accelerator specific cpu types must only be registered for
riscv targets.

Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-8-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/riscv/kvm/kvm-cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 45ad5e1525a..f28d9115c82 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/main-loop.h"
+#include "qemu/target-info.h"
 #include "qapi/visitor.h"
 #include "system/system.h"
 #include "system/kvm.h"
@@ -2208,6 +2209,7 @@ static const TypeInfo kvm_cpu_accel_type_info = {
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = kvm_cpu_accel_class_init,
+    .is_available = target_base_riscv,
     .abstract = true,
 };
 static void kvm_cpu_accel_register_types(void)
-- 
2.43.0


