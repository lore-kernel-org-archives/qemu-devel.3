Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01E606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HmQ7nWGT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JAkc5wNi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3q-0004hL-FC; Sat, 24 Oct 2026 02:16:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3j-0004dx-Ko
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3h-0004ax-WD
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:51 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3Q3NH468128
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hd+uzpJI5KC
 MEapWSuuGtDun3gwKWE+jvX6FY+2csiU=; b=HmQ7nWGTGjAWRI2e3THpeZPHhDW
 muClm+066XYUpzJXICvvbDCRXiTvJhmLDzxgbGIUispx5+5uvfjMiOg6aWAOs9qy
 yMLhkguL49SrajC6vAwvauwqfWEVBk8aqUwHpaLex2kpilBVkHHLuXLWJN7rlv/4
 CYn77CcRF07VHWMNER6OXc53axIYaxKB2ksyh+n2xm3wWdMTx5acH4bpxImAqMo7
 gKZBLY9MZsR6NRI2cmXMZlv1zILCbNkjHFIZUlyZ62eGOBIgJmzhScyUivgrhJ/Y
 DOtMYlVS72R8KFP7p/ENEaYuA55+4bVDEr07eTTJzAWHMRJP+6D6n+kE7xw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrug9wf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so17199705ad.1
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822608; x=1793427408; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hd+uzpJI5KCMEapWSuuGtDun3gwKWE+jvX6FY+2csiU=;
 b=JAkc5wNiqa6P3K18lcxSt3dl4ASOtYuYpVv+4pZmt1QkfbfYppzLNgDkrOFo1NVjho
 J4s3Iy5RlTCbXATYCah3Ax/zG94uPV6QszlUbwdXcqU8QXBm2Qx/LaZOaPtXoGATVkcY
 AFY9+nd5bgXnVv7tm0kO0z+2wBF18hzQkxTvzGSh1sZwnahVEcQsdql5LHtOVsXYUVAA
 Qdw/yM6DnHMaBD/RrKRZexbpAiZfj80SAP1mk4Y41jzMp08kOFGrgAHoDelpC6ZT8SqU
 yjXsOHSg323nMDixa/G1n9I8swG5CC2PRw7tnYKg8+vgzyTf9Pg/6tbR0LSoAhf2G1K7
 tYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822608; x=1793427408;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hd+uzpJI5KCMEapWSuuGtDun3gwKWE+jvX6FY+2csiU=;
 b=Tvu/OffHHnl3lS4ss9j0uKLw+pPUex9yKP0+O24T77EdaFS6PJepUUoECp/Ibpy3Or
 Id2deX26FVWp+uzgyRb6bWzRAfhidZwj2O84s5NV1rNV0XaMR7F1YqtP4DKTgJliZzoN
 MkGlFmKKVJF3AIiUcCyvURc5wYIv3Gez18Ul8yoJr4OKKgwYf++449kRZcOH+FShIvIv
 ULg1clrb069a6qm5SWB4EPdf10I28iwg3nRHKybRlZWSQSw3lBDm/5vL4Gcoc0mhCpgJ
 SboK1PTEbzS24sJpnTNamhf7io4eqA2watBoonRsZCxXP1im42WGqOIOXa/1Bus7zu2b
 RYpA==
X-Gm-Message-State: AFq9FYLKf3ZQyK/QegUWEeAggpmXL/BcP+/2mniDGa/APl/9uGd3j2NG
 /laxaiHeiriPtu9FwZ2za9uI5fYjejyTbaZeK9LodrFVbPJUOqYsufpG3u1sizsqDkw4tCYPqKw
 mTqqsERKUuSzfXJ9LF9rmqUcuo8a4/mnOtM5QoriFSxncmFBwN+uNuVFwHwC+s9KKyA==
X-Gm-Gg: AYBFou2NwKbvle77AAVLcwlZYY/sNY8KZeX0AXZaOuHWqtHrDQGwV59QtV3xCdxrShE
 Lct9UoV1t3oAXkd9iK+qhv00R+YQfXyteFKFiDzi9n9zuOidW4X2qe4HOpLMY9trfoqbvLIJd6x
 i0ACI4oFeLMj/aqS/WkUX55jJaPNZdXpA0ThTGntGzMIiM6c/d/CEZnZNKzVhQgyeI4haIwqVLD
 lXLpAWNpVqargTPBMz4gLr/VsZ815fVCLBgZlMp+lauP8RJIBH24/218uNberqJg7XUf8PGp7Pi
 OqfnbovyC/V7SaxQIgL1gY9iwHqaMhGrR36gZ3oyYteS7QBP31jAijlP0FZdUfXnGAMGiNtZXCy
 rG4vXBkPpxzSZiN6RD6/bCTbViXHZEFs9W0xN9KEe2H3v79kxvpatZSh1RQ1/kpw=
X-Received: by 2002:a17:903:244c:b0:2e6:5ef:abe9 with SMTP id
 d9443c01a7336-2ea9c667befmr8964345ad.37.1792822607930; 
 Fri, 23 Oct 2026 23:16:47 -0700 (PDT)
X-Received: by 2002:a17:903:244c:b0:2e6:5ef:abe9 with SMTP id
 d9443c01a7336-2ea9c667befmr8964245ad.37.1792822607418; 
 Fri, 23 Oct 2026 23:16:47 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 7/9] target/riscv/kvm: restrict kvm-accel-riscv-cpu to
 riscv targets
Date: Sat, 24 Oct 2026 06:16:13 +0000
Message-ID: <20261024061616.27381-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX0X1/WWXBKEpf
 J0QhyDTutAT2gkfc2NNLwdC0Zm3vO6w/bK9DR9DLRQ8ug5OxZkrnt8oG6p3xKI+kZJgY6v8/WnI
 3LCRIF/C49OSQMu23ZXT0lq0B2vjB6hToyRt1hJv4jV3JKwkHiwj4z+GDoES9tIthvVB6LoIR0V
 9cL7YsZtxrn7ciLaXANE3ssypvUHo5NAcc9OP/rMweWaU7LlElg8P2T4Agh+se3V4qM71VCB+6g
 MaKDfWpun3mYsUrBCW60EpqVlOM/cU5oWPTvoMZugVqt20clmfdVYq+KIHTtWf2I+I7T4qoikGo
 zz8JOKAygfH094ySGg5i9LnWIgA6eld+9G7OYtti8b6n9ZeiMCvDItAM9HObcGWLWsAKlvxF+QF
 LM9DPdHw3DiPLKZlFgnJPwiBuFPoxjHvrDRk3G30Pj3+ce6wi6SGuLPh1NmhYOch7B4lG3i//N+
 B43c5kmFGLrbIocom0g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX0/kOL557Fvon
 XGSupnapdhbxz5Ry8mdIo+7rCh5EMUzffaNZQ8BYUw7vsmVcFHHArnFbFKzzSuT5pDC92QR550P
 lVJHghutWkoZJujiEILGcY5GAKTbCVw=
X-Proofpoint-ORIG-GUID: mRJCTwO1GAlukGnZhjt9rkqBEfbCpTmC
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adc4d50 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=O-25e2E7vQ1JYfnQKQQA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: mRJCTwO1GAlukGnZhjt9rkqBEfbCpTmC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240024
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


