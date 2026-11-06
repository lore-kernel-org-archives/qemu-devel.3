Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D011606A326
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TSK5GJIp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=djcIwc7g
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPPEx-0008HM-RJ; Fri, 06 Nov 2026 14:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEQ-0008E4-Bh
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:10 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPPEO-0007Fe-KW
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 14:04:10 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6HtFRA489663
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 19:04:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3w2X/AAaaeO
 oGP7gb452wFeJCqTR1dEYqi5/K5evKe0=; b=TSK5GJIp7QfHvLruAf1ccN8SK3+
 +p4DGCBWVlGEo6WOpyDn3YcAFons27qi4vwwAxAor8bKqXPUDeE/OiM/j7mBFVTD
 1VrXHI9ccR6LMrp8KOd+z/01bIqr9dhxRgkqsvcRT2uhzWdatbMaE8VHL67qGuQn
 aMYmWfupQwccRUy3sY8DYGcptRlAQjqbi26/uOcNYfHspjqZGy13mXJpEbgSURbo
 MfjyRDQwKT5K/82DCjZt4CQMBgMdEbucldlMe2xZLzylczb6gIXWwYc7bHMHysiP
 TCxYJerumqNtf3P+eUyGaCZCnPAnM0Abvry8Jh4gOuBstDVh170HCGpniAA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3pa4bcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 19:04:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd633da24f8so1162716a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 11:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793991847; x=1794596647; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3w2X/AAaaeOoGP7gb452wFeJCqTR1dEYqi5/K5evKe0=;
 b=djcIwc7gEUrNi/lCKbDmr28omUfQLffo79FHH4dwAaKtj9VVdctKy2i2q1CYIQTG2L
 6jSGOb+Cj6uHPxpKP7gNJZ9+q6BvKa+dYtdlHLFV97eFhabj7er1ol0fulMJ8WtFX+5N
 c3eVVNNgsFyVEn72T2C5buTDKq3DeiDApetuSP9ASzkhiCflU7i12PpH3BriTdm+OnqM
 2Wb8Ne0Guu08zc3lpuYEZ4udWvRwllF4qc0JjRoAPK4ipwUGboI73mdeR7LQCuwzgh2T
 zJqn71Q+YTQ4jh+7PXBe3zWS8jKJmzvGDtJx5Cg5zrhGM+tvpZ1KWDyf+am9WA6FdYHu
 2sUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793991847; x=1794596647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3w2X/AAaaeOoGP7gb452wFeJCqTR1dEYqi5/K5evKe0=;
 b=a3/ozZ8BJ7L5r0WrMPrDpZGP6POsm9cWTNg0T4/CkQX6eP088SzSAcjaTNnxYB+p6G
 hk5Ap39fYPBeMWLCA0kKfCEN2qYtCf/88Bj6EqAZnVG9eBiSOzDB4mNvT0S3qlVXAzkt
 46k1OEQr55iQdODsoS/jl9PmV0fDB3AP2dQiIN6cogYpJtyA72RahB9aEzENIGUKuGCP
 Ss1sEXxf2/QYNyg/QKrIXPzsXkj3IppWxTqyP2fmQDunWJRRGf6v4969WFpmOiaDMj+Q
 n+dNib2qX+SEHDnbilgJfFlVB7ESTzv5idPrGqahh/hv1AAG7yiZKTrf4ByFywYR4/xU
 7Qjw==
X-Gm-Message-State: APuU4Z969iwkHZ5gx01WI+c17NCAV0v9BdFXxbJmdWJ8xIK7vSBqzDi5
 /xf9/Nw4bnBivnZSMHvtv2vrrbZY0Hvss57+lgjIHklhQC8Pv+tcMAMndZWxpeTQe46SgfYOwNs
 P4FtwRLExefW+ROgrj0ad/Oy95OaexFwE3aO/MZDH5jvn5QSzydXIJM6JDFT4BFDY5w==
X-Gm-Gg: AYBFou15SipLnlowLnyNqn8I4c6yXGiCX9EysReCZb9VYSYXXLA63ootkBX+Kr3BMjT
 IkC7HzMIh1QLdtE+bzIkZtRZPB6OVCWu2BFX+vX+PlEJA6L5k6Es9HPr+VBvbeOxCLZ1+Tp7do1
 FKNT0fxGCpUwWEUxLJo7iNW4n6hJ9CWdJP6zj6lDthk33K2CYj85Lj6+9hDniBYZE9FNavxu3TO
 ZGaqLITg9bKGmojUROkQvonM7hinU/zz4j8mYpZanedGTUYJm9vI4FExlZzvD12B3eMsnY4ClHS
 Xz2/LFmXKlSgNlOvBUGEwgPlu1hIucPTrw0KzUsA8IQRc616bFtKyHMF/5CgDQzIU6wqxa/F5ck
 Udp+HEzU4MmR9Mx76FOMkLfSbij9NKx/9fnDd/IJaoeaGf7ROdj4U6IrMae2epHYCkRjv/65Oe7
 wqi+XMUQQ2DkBnf/tKK916y93+0TFf+3lW4p10
X-Received: by 2002:a17:903:3244:b0:2e9:5507:b52c with SMTP id
 d9443c01a7336-2ed40c578a7mr40955445ad.34.1793991846651; 
 Fri, 06 Nov 2026 11:04:06 -0800 (PST)
X-Received: by 2002:a17:903:3244:b0:2e9:5507:b52c with SMTP id
 d9443c01a7336-2ed40c578a7mr40955255ad.34.1793991846196; 
 Fri, 06 Nov 2026 11:04:06 -0800 (PST)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ed47d40d19sm8283735ad.32.2026.11.06.11.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 11:04:04 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 5/5] multi-target: restrict whpx-accel-*-cpu to matching target
Date: Fri,  6 Nov 2026 12:03:52 -0700
Message-ID: <20261106190352.1665081-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261106190352.1665081-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX5SM9JoG4tVmH
 XVc9nLYe5JmVjB1Pw2BCWXP4XOQJD7VJhUzd4liSIg05Hx0jwdQ7xnlqvD0+RJedWMYZp7IwBTB
 L1kbJQLpBCMt3gqs10Xx+fq3vt9kUqAzzLiej7I9n9nlonuQhwbaSfiJL+zevN13PrXV+7ELYoE
 uv9sptPAQ/n8WI4N/dFDaySFd52bdJWPeXP8APfFhzus1Ag5D+XflP0US4l9X1x11uPH1417jc8
 33kvfAGiy4GbPXK28Kd81/Dd+fCl+0pptBMlSik3jx+Ls4QKcYUn82WputzIK52IBiQ7RRBxmvO
 GXyTAAAhER6BA3j19WwSJS//l4VjmNc+m5u4QfYLHVurIjmclNKwKGvbfjr1kNYfZvOg5ghO+cy
 dWIr9hztBzuXXlnIrhblR3FGiECcg+234RxNtPahXpHQZhHxCBAnUTf9uiqov1LD7yiHIUtbadf
 QzV4U5fWDhf/pPUsnUw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA3NSBTYWx0ZWRfX0vg+kIVPAksZ
 UKQMvws8P906ZPOrlFHVul7w700ODRG58Y/c8ppjKMLT+n1xGnXFXAmzbAL0at7ElRw5eazmGcD
 ibDwiRIPbhySRF4sEKtMkJMlrtWCNnA=
X-Proofpoint-ORIG-GUID: TGCgxsv4XFuWLxIXkAsriQ403eCIv30b
X-Authority-Analysis: v=2.4 cv=GpzXaU1C c=1 sm=1 tr=0 ts=6aee24a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=3mmYAVufMbg0zkDCPNAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: TGCgxsv4XFuWLxIXkAsriQ403eCIv30b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060075
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

On windows x64 host:
$ ./build/tests/unit/test-multi-target
Type 'whpx-accel-x86_64-cpu' is missing its parent 'accel-x86_64-cpu'
(same for windows-arm64 hosts and whpx-accel-aarch64-cpu)

Parent type is conditionally registered from current target:
register_accel_target_type uses '"accel-" + target_cpu_type()' as type
name. Since whpx-common.c is shared between arm and x86_64 targets,
only register whpx accelerator cpu type when current target cpu type
matches the one it was compiled for.

Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/qemu-devel/20261106175326.22629-1-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/whpx/whpx-common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 78d2827809b..20c684638b0 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -20,6 +20,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-type-infos-common.h"
@@ -492,11 +493,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
     acc->cpu_instance_init = whpx_cpu_instance_init;
 }
 
+/* TYPE_ACCEL_CPU is only registered for current target cpu type */
+static bool whpx_cpu_accel_is_available(void)
+{
+    return !strcmp(target_cpu_type(), CPU_RESOLVING_TYPE);
+}
+
 static const TypeInfo whpx_cpu_accel_type = {
     .name = ACCEL_CPU_NAME("whpx"),
 
     .parent = TYPE_ACCEL_CPU,
     .class_init = whpx_cpu_accel_class_init,
+    .is_available = whpx_cpu_accel_is_available,
     .abstract = true,
 };
 
-- 
2.47.3


