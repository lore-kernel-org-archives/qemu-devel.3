Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF307606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FUEMmAEZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QCagTmTC
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKi5l-00035E-Al; Sat, 24 Oct 2026 16:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKi5h-000344-Sn
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:11:45 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKi5g-0005aL-AG
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 16:11:45 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OIU1iW2873458
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=nBIktV7LfPh78JMyR+YyCLFXLHUiSr8AACR
 036njdH0=; b=FUEMmAEZ4a+slpu9nar64HGGabVa2UhLXMnObvV/nmNovh7vyzk
 i34AAMWlDhJ0FgesfMGRkg7oXs7sdiKkEnsz6Jq8d3Jr+oVebplbB0euLA9dP5Kj
 14+ReDq9/0IWjNZThWthrixCG+4DONB3UYRGJkilFMot8EB/WnqP8DrAuZooS6bg
 rAN1YMCU0X4+EOFGIDAeFhljEguRwQHFOD3eOc8+B9jlZXENphzuXVmyhnyJEcDX
 byRCkpiNErXPBAcM323DTD2/U4+hgGHSWtZGqwh+Pmmr+0WkncKcDC7e53U/GYbr
 D/HmQGYS1XjHYo80jKamHX6gnnvV+gN+Rlw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgm8xhryf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 20:11:42 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso3331619a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 13:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792872701; x=1793477501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nBIktV7LfPh78JMyR+YyCLFXLHUiSr8AACR036njdH0=;
 b=QCagTmTCdyZHAM279bYcxqs2xyPUwfDBJWp/bX5cpPHYaM2rWq5m3237gAeqqZNa7D
 9W/NhKobPd2o10q8hRc2vdTXI0wllBIWDBXLmdNdIx9VBbT4jJjlZSIMTCgDjnJF/ReE
 UoKWqPbkeKSVf7dwSo5oh9Nur6N5jYO54A1U7QSKIMgtL3WsOQDbgOjT+oxeTlgiGfqu
 BICW9qykCspyVWRlbJ6BTDPgNeVoS5IzynRQZXXJUjYRJrWae4JHteyOCkpyIBm5zEJ9
 UELAwD1l0wXpvUXQDOmi9NWqv0WcPywZkQnzjDT+Y45cxDIZhE5FB5XxkAP0sjdb1XRI
 Dmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792872701; x=1793477501;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nBIktV7LfPh78JMyR+YyCLFXLHUiSr8AACR036njdH0=;
 b=mc4sP51lV/JgOk/MXv2TIPC8Xkl91lMau/lkNNPVgApfCt3wce5QlVIpwfr5Z6Y0g0
 c8EWPf2J8XTuUDqU/PIJzedJmX7U1DrTJ+a1KzgWvdsQKqRkMogyIgY8raZz2WGAf/lN
 cUJbEJ0n2NgRjafnvQ415+PRS2SMwzP5Ts6eOAb4/td/3F4Vg/8r1Y2VRFYngmI1iwr2
 0B5+MVLlSI9CuiaF2DuwwvL7ROqutG2TgO8ssBZ/efdB1p/53xEcX6Dzk63e40gy5MCJ
 LUQ23L2zvrPL3ChkzZg7dcRSbwfW+zAZS9dXq0WAZAW6n4WHAsxD/Yg/ZZFx1ZsT5Dsi
 japw==
X-Gm-Message-State: AFq9FYJkjZ4z8H3r0hRx8genyJvtDHwI8urGe2So+jGRJSL65Bj0P7vj
 qSRnR3VVd9aKskM78wuUbXvhYIk7Adc3Ooh0p9bxRMJbY6+CBGpKUqKkOqnzLH2VA0aibojrOEk
 goQ/69CTdmzSlKAl7kbpXTSxaERtzELURl8CcJ3XvO6lllUpblG5PYB4h/CgpswZAiw==
X-Gm-Gg: AYBFou1Zzn1DA+l9hdcK2v4l2HXMBCjoNvwC6HtUY92So67KjX9KWN8iSuZ8go735rI
 leG1nD5SJGvGG4amDYnoFnXGAPVuMiayEs1Ay2G6Pmpt48YrF8oZV8t2ULXCwQJvb12CJciKNSt
 vZ0zlBi06NMmiQhqxreAEH+zDIu28fjy9xe+HTg32EHAmkq5z192r9RKu4eUeyvtdbqH2kaB6rJ
 gY1+316eUU+nUZmgbCl1kCl1C1RYr7bHeoY0EIfqIzKBISaS39UENXFeOE2HFQlSkLAtL2QGrv+
 lRTdS+arQZDyd3/6oabl54hfol71SCB99G5Uj6ySpiEQ0qKkqj6xpPchvFBv0uuvdUar5hhkBnC
 Q6xX2igHCDMN0THbsMX/c0e+e+JObQ5GAZVUHFC58FY/DbRBkE5kI7QvilUO9kaw=
X-Received: by 2002:a17:90b:1b04:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3adeae8b8e9mr2513545a91.31.1792872701140; 
 Sat, 24 Oct 2026 13:11:41 -0700 (PDT)
X-Received: by 2002:a17:90b:1b04:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3adeae8b8e9mr2513535a91.31.1792872700679; 
 Sat, 24 Oct 2026 13:11:40 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebfa3794sm3604222a91.14.2026.10.24.13.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 13:11:40 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Anton Johansson <anjo@rev.ng>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH] multi-target: restrict whpx-accel-*-cpu to matching target
Date: Sat, 24 Oct 2026 20:11:36 +0000
Message-ID: <20261024201136.27090-1-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: JdE8cYUsOj5UKfM8hT-MWpko1ez_pkeI
X-Authority-Analysis: v=2.4 cv=Ra0FmFtv c=1 sm=1 tr=0 ts=6add10fe cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=3mmYAVufMbg0zkDCPNAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA4MCBTYWx0ZWRfX5B0oXWsmkr/B
 Y6UlANaRXGl1NBPeIw/Tb5gTMWD4MmxB/9mt0tGMlugelbeW89MGLc7glv21piiwMSTt58IqG5p
 lenzYJwm4pDprsKtNplqedr91EmYZS8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA4MCBTYWx0ZWRfX0QHiPAqiVX+u
 f+DHI9xQ4+muzVJZFM/fj+HntpCvw1s5QSdlLeb7m3YFoBXS2o2p0QBKYi5QqEVLXeVBYmYFW7a
 9ZDZnHkmo5v2+H1oUVT9XxznkhgrmaasFLVhOJ1FsqIIBLU8mJoKQ5IaiNphsg4VBO8zh4N6A3a
 cFhCQe62BN6mt02XfJanygtnrrl2K84tSiwSjfN0Tx8eRoPtMaGdii2Wkf9l9OaZJ3PRdZhhujP
 96oVxx0s3/xJhlz3ucVvE1NK1NSo1pqULybDU4RtBxY7FbfeOxQ5T/d2klZg/zHMnHP0nqNKOfY
 d7eU5lWrH8oyl2miPIRciFONX0NMzlJXDxx8G276guzLUgOldjpmpeJuuO5kHhbvGFoBi20/6ek
 p/R8Q83BnOnztRIvd0XlsRRsG/BqSee06In84oOUVgw+aY9N1sV3X+Zf3G07lf1SYKL6sqZ66yJ
 0N/vXxVVZ1WjKaDITww==
X-Proofpoint-ORIG-GUID: JdE8cYUsOj5UKfM8hT-MWpko1ez_pkeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240080
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 accel/whpx/whpx-common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/whpx/whpx-common.c b/accel/whpx/whpx-common.c
index 247e12db812..b7a3249f33e 100644
--- a/accel/whpx/whpx-common.c
+++ b/accel/whpx/whpx-common.c
@@ -20,6 +20,7 @@
 #include "hw/core/boards.h"
 #include "hw/intc/ioapic.h"
 #include "qemu/error-report.h"
+#include "qemu/target-info.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-common.h"
 #include "qapi/qapi-visit-common.h"
@@ -512,11 +513,18 @@ static void whpx_cpu_accel_class_init(ObjectClass *oc, const void *data)
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
2.43.0


