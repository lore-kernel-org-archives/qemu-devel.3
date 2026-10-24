Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5C3606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 06:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jgnA+ZcU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LEFeDmwD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKV3f-0004bT-98; Sat, 24 Oct 2026 02:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3c-0004aR-1H
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKV3a-0004Zt-7a
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 02:16:43 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O3Pq56468008
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QMb8AYJWcMM
 Axw35yzK8RraREVY8VLnMc7VzDCjD5pc=; b=jgnA+ZcUud2151siswN9EJmnczX
 Sf6pST71Rlvpa3bMVOzyclVX2EhlcRqBLEWcvCBq4uZ+/ge2IEp6S/sd73ZFDR35
 LMoBaIUeFEALwTq+10wXFYtbvJx+CycB5/6Denr4a9hIygfK2mzpILpbQaUD36eE
 4xga7/e5rL0/a58djLZZ9Npo8F/a7PeLuGxM7jPd6rjwP/Nnk9/VJcXGYAjjJ0C1
 v6mPKKkhzJxM32NcvFjMH1pwyJCw7U9LjJn69gQL+rXfnO776am2fD+jbh6aAGD5
 WqPZBTrjzJMHT8Rh+h+jbEoN6iGZ/+nRQWQcVIzVJHtAW7K4V7bHS5Mq0yg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmrug9w4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 06:16:41 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac7a4ba546so1860280a91.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 23:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792822600; x=1793427400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QMb8AYJWcMMAxw35yzK8RraREVY8VLnMc7VzDCjD5pc=;
 b=LEFeDmwDc68EksXb5P0FqyNZTNINGOExeTDGeZu/9H20EJwXvmvIkbXXysMbMp7oRl
 mGDYt8MyZlxEbDtg+pAg1sf7A+9u7XsOObRJ9NaFhc7vNoGbbecgDcI916FQCUQFw2nx
 D22M8zmUPQvckQDRBi/fqgVuKX1afZ/tEJ9FllH11ycATyoT/gGEWTKcSOBgXL/VEg5H
 BCQuZRxnIaPyeUG5ToiSzdHlfXTt142qW4qboW2pYz2GHFHhPrcH81SvbGuohC2sVAUf
 fikq+DpOqfgrzkbWwj4Jc8efRG967dHqBBkZ9KzP4gnERzyETAOs46hLhNmxIcLOqvcf
 99xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792822600; x=1793427400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QMb8AYJWcMMAxw35yzK8RraREVY8VLnMc7VzDCjD5pc=;
 b=MiMvRTu1238V8JYYywUVCk1ULBbDPpXnKCqSRsr44P2+DS6irdgTKOO2RIqj4ipiml
 ebm1j+lYOjFL1j2ldYKj1SZ75cjdmtsJQaWLQpC0YHMhLlF853ijCk6GlM3OH9uYd+az
 UY6UxEdLnP8hYBsMryRHqrzgo+S3DtIpncIM730RGLNI0UgnNnn3hhX3wiDmmLFV0KpV
 SpKhKMys5zY8cvQyDpdqqLQMoY9jdAGUmm0Blxu919k6YLD0x3MwdKGgupSZNMCbRomV
 qnC/W0qbKVdCSVE2xGhPN61gtk5pdLEuWBRu2iXjE6h9aPUsac4gPj0+kmMClj+/6Pd/
 YPfg==
X-Gm-Message-State: AFq9FYJ2DYaQEbc1HL29qVjh30NcKvCGIraTY0zPPNzn43grSwbysjLf
 U7PjSjWnVXELaWTKQjZfehD2+XYKKiOYTbnnQs3bxzyi1/5QFWdDw1/OpJJj1cHUY0Tn6dRY2S3
 NbN+KmBLQFGtO5/O5CRDqO7Dy6IjqX1jyIMK/ZZEdYg8RK6yYGPWRm0HIBNFxxhrihA==
X-Gm-Gg: AYBFou3ahDDI7BCIv15DoOODixDm3VCLKQ0URGeETqwCHaScC2540qCKennxfIZlVIm
 FDYKnGrK9L+VrAm+Ag//Ps23EZ9t8K7nmZ3hmxMfPMLR+fNEn5+1L5cR9y7A4/5bzumuwjG49fh
 oeRR7uEdfcLWOyQkbilRuFMXmpF392pm0iHfruCrWtw8Mnm2wcGIN3U+6qhOp+MR4OQFhN0dpyY
 N06DwX8j+mVyOAQxZJ7aUeuGdZCiOwAUflFRkHtpzNIKBodIGsJOs1UHHTNMvsSW7mxwJ2a6M8M
 wBN9FI+dsUlw5zn5srJLPA4Nx33rmz8po5cOdQ1yRkoae+efdjVLHy877bqh+nfLpSU5QXgr2rs
 y/UPbBSK52vX9a4ImrYPn0l/StNrLLPZ7gFiRDbN44RUkUaDi97/AOJ29bEMUQMA=
X-Received: by 2002:a17:90b:2e06:b0:3ac:a6a5:5757 with SMTP id
 98e67ed59e1d1-3adeb550f38mr801953a91.11.1792822600119; 
 Fri, 23 Oct 2026 23:16:40 -0700 (PDT)
X-Received: by 2002:a17:90b:2e06:b0:3ac:a6a5:5757 with SMTP id
 98e67ed59e1d1-3adeb550f38mr801941a91.11.1792822599677; 
 Fri, 23 Oct 2026 23:16:39 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebb1e37esm1074882a91.4.2026.10.23.23.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 23:16:37 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 2/9] hw/riscv/virt: make machine available for riscv
 targets only
Date: Sat, 24 Oct 2026 06:16:08 +0000
Message-ID: <20261024061616.27381-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024061616.27381-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX6kWyZqEM4ult
 cODY0gor6rBqyDBlwr911VgXlkDEaetb+bZNA4mYft3v2bZNhn9BnynLEFTur6QxbqwhGeHtd4h
 7qd/BHQ/ujC5W5y0pdpVZC1ZvIkqLYFkILwbDKfkGTyRQjFtOc7ZGqZvdoiD2hLho1lHrB0QhkS
 L6X8hjNE3lLA0HbfT/8qXxjv4B/xkpY2fiJGT63Uz0W9xlvItkKJUxfFE2COobQmlJ60wyQtpMO
 NCqbZGSeN2y45lmowaiNoYW9X+z6v5IwhK0Dcc/lolLiMcBzdVJXJvPzHyrVfVXauABjrjVJL2n
 qLym22jcQKPUDZdiK12YDWrEP4Bc7ybrnACsviFhH4vD3217v2p7/gQ77Wx+JX9pym1t1XRu2rA
 Az5eANoR9nGDUgdnsueahgpEyZHT3oh/x4TlqMSIRGWfObF7j18tiFw4EDqzQ1Y3Xkgta4XX1AS
 euStn9BpkkmEYx+ZIdg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDAyNCBTYWx0ZWRfX1Cm9+Y96IS09
 HzWYGueQQgZfFNdhxBpjCJ1At9be7zxgXexCjtrlPwAmTDtzIeNSWDTnq/j2hZnIsf12lzDO/20
 zcyoAiIXDajNtC2YdgGDHjJ4NN2u+1k=
X-Proofpoint-ORIG-GUID: 1k99juOLzP7eP7RMNaEuzWCNs_g32Ifi
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adc4d49 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=JF9118EUAAAA:8
 a=EUspDBNiAAAA:8 a=DBNBiUfQWWGXfxp0DDwA:9 a=rl5im9kqc5Lf4LNbBjHf:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: 1k99juOLzP7eP7RMNaEuzWCNs_g32Ifi
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

Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/riscv/virt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..894cdd97976 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -22,6 +22,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qemu/guest-random.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
@@ -1203,6 +1204,7 @@ static const TypeInfo virt_machine_typeinfo = {
     .instance_init = virt_machine_instance_init,
     .instance_finalize = virt_machine_instance_finalize,
     .instance_size = sizeof(RISCVVirtState),
+    .is_available = target_base_riscv,
     .interfaces = (const InterfaceInfo[]) {
          { TYPE_HOTPLUG_HANDLER },
          { }
-- 
2.43.0


