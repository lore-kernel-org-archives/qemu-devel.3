Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD6606A31D
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Oct 2026 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WG+VZV+W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gjf86jRA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKfgU-00046u-L9; Sat, 24 Oct 2026 13:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg7-0003zZ-Ef
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:11 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xKfg5-0008JE-RZ
 for qemu-devel@nongnu.org; Sat, 24 Oct 2026 13:37:11 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69OF0Agr1863446
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=865E6RbRKeZ
 dfbJcqk32bAZRQausPpu0JHbPApawbSg=; b=WG+VZV+WvwF+QrhBey32Atr9bAF
 N4WVURwusj9oUSy04wS4luUM1W+mjKA1IoxsEuJe93ghPze7Z29BRFy6g+YBpeai
 bgerB54w8mYlFpG5/epxxMaK4SBQ6Cx+lvK96nQi0oOjBSuPNAOF980Ep/YsWQNG
 YWj4SARMkfw38IIKZ5qg/iq8xjlR1r5cNfnhh3U7vuivXh2o5zgoxtyj0wnv26KG
 HD38+hH7EMAV0eSODh+Oh84hqRwr2IJEdHiaHPm3k/Qb66l/IMeHt5q4msSvG3P2
 nlCFRfWK39YyriHSx9e64jF5xFMcjMCmNXLAt1f0bkeKx0g6eZqZtyC0bBg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmruhet3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 17:37:08 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab7f1efe5dso3221331a91.1
 for <qemu-devel@nongnu.org>; Sat, 24 Oct 2026 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792863428; x=1793468228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=865E6RbRKeZdfbJcqk32bAZRQausPpu0JHbPApawbSg=;
 b=gjf86jRAp0nXUlo5FhJlflUsarH7TsvbqpOEPiRtExvweHzINLIaQAbZIpQrcEC7Su
 WsxtZTUH9TicbtDMLfXjPq+CP9DnGA7SoOMQdye1GSGviIfjad3BitHGp4Ff5xhsnC9i
 d7wWFf63kbVUSHmGcurWi35pOUKVYX+IqAedUmezijBsRHO3JEVhl3AAlIMRjR2ADjuc
 BIBwmI9Q3ypIupPdhN3OA10EYqLpJbhMlxlxuv4vq6pEj2LsU1yahA6r0mcw1yndf6a2
 7g1EaYhSbVuEcOmi9MJqHsrG3I7Y7jpiz+NUL6vO6UUMC9CfrsEUIhy83PSipBi0XCUE
 oZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792863428; x=1793468228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=865E6RbRKeZdfbJcqk32bAZRQausPpu0JHbPApawbSg=;
 b=T2iCuFjUCspx43tq9bwavkWgZFlXxWouO8MoAfmCtMhBjxH8NVDemen6MO2/10dEAa
 vUrFch1bqPtu9lWLO4dZZYo7mQ8cZw6Y/rThBG95A5Xr2U2UXtPzP8sQTfkTjJtyZva+
 Iiq1FyHxrr6eCIBR9FDtTQIoi4OFOeOoinyoHDFpQOg292VG521NBM9gOyGkYnp8XxmB
 GoyndSdDzZLWo2AaXwbgXBc36e4DA6BMASQz1GO9jOjIIYZF/hHRY/slvmeNbvoUuN5s
 kJJ08K6bFTZZaoC+4aLFUCpnHjljmC9fnMT0698TAVSyyPqFbFpRQ/08uOIqIboww4hV
 3Xfg==
X-Gm-Message-State: AFq9FYJRuRHvcpTsXgpch9IsEnznqZcCST1s/RW0h7janwz+ij2nxS/w
 amFCDKIzPci00T1347XoE8jOkfjr9s3ZMF3Jy8XZxOPKaNtgkHtyEmnyrhT+aHhotnk5Y0A0jvj
 EuE1aqvICgpcZw00ZF4jPKVo/siVDtJcGxaVEQo2qLitTVRPcUe38AFHAY3zV0ky+RA==
X-Gm-Gg: AYBFou0X1bVnhTiSYpSmjyOuX0QYrUzmAQAomYbKiSU4mvxka5UUYj5uaenmi5z2yeu
 ggw4f8qOcIsdO7oddrvufSsrZKa2ER+x6p2G85xOlbRwgyeSE50DRwIGVZuPJWz8av4K3uaidwN
 TOc9W4beQKwGgU3oz/bh0L3JClUoiFUGzyXzxNnY7qTI2UdFvDQ0UxxsnCnfslLEYj7Tgy5TyRo
 nY4mpoaVMneT/a96N7iKw/DrdWmdCoU/Yc9SaGC5pm9wr+puLCWPQEkmNpHgezpH3KWcAcRWX/I
 BZWQZK243kEjNp6vcLQiLVlCNYH8O5ds7iqmQUWZ+rmTTBSHST9uVSnuNO8xh+2IR+okabLSJkr
 PuacxTEpLHM/dPccvxyT3LkrsiBNWikeHAN4l5GC2KZpYjKFSewVlnS70tiqKMNo=
X-Received: by 2002:a17:90b:4d06:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3adeb0ff8d0mr2386636a91.49.1792863427937; 
 Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
X-Received: by 2002:a17:90b:4d06:b0:3ac:7f4c:a68c with SMTP id
 98e67ed59e1d1-3adeb0ff8d0mr2386623a91.49.1792863427499; 
 Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
Received: from pc.taild8403c.ts.net (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebbb1a13sm3324093a91.2.2026.10.24.10.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 10:37:07 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 13/20] hw/riscv/virt: make machine available for riscv targets
 only
Date: Sat, 24 Oct 2026 17:36:42 +0000
Message-ID: <20261024173649.7405-14-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261024173649.7405-1-pierrick.bouvier@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX4ZHvec+qqobv
 kvYb5mDyBD28W0B6lpo0m9TFcXR1hZvA+W+t6zf6f4pDkzAARrZJT/WwLbGPs2lbWNl1s+6ttq9
 jW9KkYxCtp/XcoviOaKIB+7rVfY2D7CRtwaVW5YXIb0ntZz+3DqM+2X1KtWHsBFazxG+PIOeIdw
 rCvK2n2yYDB+ODhTLJA9GnYukNETckSpJ0MuAU4xI//4JkZtom+ErGUah27CPQzdRPi5vzvzkA9
 1JrF9oksjF97GRguCeI9WiAGM3X5hF99ATjeb/MSouleeEyQhSVjcSKhlxYe+Cm9oxcsMVpMEsq
 8PD7tbEgf6s34IKc1U0yang7vgkiS9Wl4OoMFsyFlBf4kFdPfc1HKkEW5xi1XluyjTrO61uV3r5
 WGT9BPlEmqIO1sNv3WkCyoiISsQHdKOzfybX0fnHQG/E72nBFfu5Cjm064OHTJi/qeMifXTRnIK
 ZfhoKGc0cKuBS5AQTPw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA3MCBTYWx0ZWRfX9Tv+10FXxxR0
 M+ySYWZivLAewI8FOMn9RoD3xEuo97zFPTpyEwY24no/0ufcXH/rl2NXo5ZQVhbqIU+9gsprlnV
 rEgDfd2Jwpuj8pKQZybmRUa5uqwbYBY=
X-Proofpoint-ORIG-GUID: JMkhIL1ygwPdcHkGncGpjgy-t8LT7AjL
X-Authority-Analysis: v=2.4 cv=e+aT2qp/ c=1 sm=1 tr=0 ts=6adcecc4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=q8esh11VyTb3HfjNB3MA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: JMkhIL1ygwPdcHkGncGpjgy-t8LT7AjL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240070
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
Link: https://lore.kernel.org/qemu-devel/20261024061616.27381-3-pierrick.bouvier@oss.qualcomm.com
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


