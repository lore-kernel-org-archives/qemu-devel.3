Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 264BCC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHpO-0001Wz-JJ; Thu, 02 Jul 2026 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpM-0001W5-If
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:40 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wfHpK-0007x5-Ue
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:51:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662D0bUi522228
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 13:51:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=; b=alNS3D1q8CDpGcqe
 F2zQbnEJzAW11jKCpfiSun4EccF24PAM4Kty4TWOTzhLEZYRfWoQjhoC54jUXMTP
 Tkcvw6848Zs71A0bEVbF7rKDfxf+JsM6VpwLf/ufCHY0bqLkX5hegdJqwwNbI8S+
 p4Y5m07QjWCG87El0ipGLZ4ywqP+xyHJ/SVQa96VVahwZg02q0PkpYEJw9JzM9vw
 z3wxx3BrHmqetwlsZp7mjeM0KMkS0r599pbFzDkygiP9peusAvIezI/ndtp59Y5V
 FyYpk+7JPtYy5Yj6Ip460rBFrxT5AnZHf7UqrTm+BCDME2eVWXZzj6iSphpd9K1Z
 ry+Ymw==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc1gf5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 13:51:37 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-96927e59ae0so1663782241.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783000297; x=1783605097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=;
 b=Xgd3qNmRv/u5C/CK4UE+oNgGYFM477LjeAY3UL+ntnV84NZBOmI8udh0v0K1tjknf1
 F5QIRtweFzqBOx70QfYyUS8KCYXgG+caraRprutQWzImO5J0BLGaiia44a2kPSffEdFL
 itAFo8Sh4PQN0qBwwN8x0zHUPH74xzw4oDAkSwxjuDZFqJnshEPW6/IC0svkbUgdMLud
 JppmhIl8mhTYcjhRkSwZI++sCL9bJ+gv3P0+rbuQwHgWU4Pnp2B5Qn1MR3Hh+OSWHLWi
 qr6t0pCKTnUpL3PRtBHP/+K6hndFrp8p+cP5JU6PRkpuIgLsXdLne0O8Slzg65YZTqt9
 nk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783000297; x=1783605097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MwoyJ3+n9gbZYNrn4kY1BYNWBjSGHcQWXOQ8WJCYYjM=;
 b=UO2B81TYjzuYU2BIpJ1bYdXkROY/5QAOPwU/Qt5MchpgE5tSDWOK0NFDobLyssHkej
 yjIq1uqX9sWAl7/tqCAyt9zRorI9GMy4kDAhKeXZj/vrs2bfa9XLMYK43TVB/m2ETfcj
 mPpyc7SJ73DtYKrf+lNIV93pYDoXmjhndpFjIem64LKbkSGENjib2kguP/9zJvSx/2J6
 XXiLoMbOd3xmU3f4uM7QbN/Mhf+70yz23bSMYB/G66F3Ka1R6Z4ud9KLGzNdeq5CkCkU
 Wt6Zi3CV/Vm737K8K31mTVD0YDBQt31TPTxZrnDxKDgjSwlyDmGQFeqAVFlXstE+YNTj
 hg8Q==
X-Gm-Message-State: AOJu0YzHwHtTX5fOmg8SvYNes82HauIiTCRfT9yiLgWeJYSqlm7aF0My
 vU3uHlWwLPsSK8JedDc7e+Ao8nCIlfPup61Nhgyl67IT4t541J8CuEYBancNYtFOcoQQCTD95fo
 xsbpcW9s5TAA9RZJ+HaUnlsxCHTeLkvBL5MgQHxbadm3V1LMbZjcG0kyicuPxY3ymjQ==
X-Gm-Gg: AfdE7cn+QhxCtEC+wVaAOkCF6k7HWH1uYsg3kPLARfQfcTn49ckPt6TfXpHq8ivdlpc
 +ARMPzmVHG4FMDdH1Dc5SI4XosymZKlaDKZrvZ4zZHL2khat4Ein1kzQ2tnNpr5dmVLnT7xrOXV
 l9tsXnmKtt9zCMoUORaX8/Ex8lJfLYdFXrx/SswjmhlDc+dGf/Hvv1LkBBAV2lYVJMfAqIWIqbl
 KQAnnDAW3oRuXNcx9S9Czbn5Q+f1OU0glD72OVjMKJaCkNIxiZMiTZ4rTvsHgoz8ykh2MHUOG1U
 GDAh1zKn0NRf+xLeoMuqD5SSd2TVhV4FzjgmCE+pu93Gk0p9UX/ELyJyVfxP382NZX42t+4yeii
 zvbt+62dRgu1EAl/HM5gQVMGXyh1CAstgUTMfgDE/Dm7KZw==
X-Received: by 2002:a05:6102:2925:b0:738:54e8:c101 with SMTP id
 ada2fe7eead31-73da95b0c2cmr2818515137.15.1783000297163; 
 Thu, 02 Jul 2026 06:51:37 -0700 (PDT)
X-Received: by 2002:a05:6102:2925:b0:738:54e8:c101 with SMTP id
 ada2fe7eead31-73da95b0c2cmr2818490137.15.1783000296628; 
 Thu, 02 Jul 2026 06:51:36 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([189.79.21.40])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1c4e64a3sm1276462137.9.2026.07.02.06.51.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:51:35 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 Zephyr Li <fritchleybohrer@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v3 01/24] target/riscv: Remove unused tcg/tcg.h include
Date: Thu,  2 Jul 2026 10:51:03 -0300
Message-ID: <20260702135128.1188021-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
References: <20260702135128.1188021-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: uYNcNnSUl6aooobQX56Ik2qcqd8nPhwL
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466ce9 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=sHJf4AwOIoU3qjeHFPlg6Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8 a=beEPI9FAKrdLFu6WGxcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXw4wbbUFJrqPJ
 HQvlb7icSzAWbv98oBiZGhT30AOyBv1DUviA6QWFfrDuRw1GEAdFQK+8XTFM8hC3VW3kfaXckAQ
 cSIgPHlzgBCoYPfkfpYjOjUdZW75dMli8FkZRte66uCqAaqPmQOPwe9NdazHHxXbapTe0JefsgT
 u8qhiUjStHxNY8J1Sb2vpBUd8testvaBty6TUEna3vzkH4ifsiYBwafsvwbmJ3rluop9ieO2ia4
 XcTCvqiKFupUJu138ZDjXQx8u+clbDsb2EHPW7IzhGUyl85p7HzGIR630rMndkcHtmsAsqvLsBI
 jcmQ5OSw6GYTdkQ53CDq6TSD/wzbrno1hV0t4+zpaHew1BeJovGqsmmnmeV7cCSsXFvohlnHuk8
 /1ZEyPRsKZrvqHeCBqwVmgTWZ9r8M5uRBro9z8rW+nT8VdS0vKYQfr3XX12xNqsB5AdVguqBGXL
 +NCRiSVhydAfjYrdEbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE0NCBTYWx0ZWRfXxaS5ZlYrlCU+
 aZQEPG30sU7zWgLH4ieHZGKEGwwf4QkgrhRRsoHuTfDlAH/U+3IqlC8+BYeIt1x5Nsr970HFt4r
 bHPr6TASDkksYkl+l9cIfDeriK2Hjkg=
X-Proofpoint-GUID: uYNcNnSUl6aooobQX56Ik2qcqd8nPhwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Zephyr Li <fritchleybohrer@gmail.com>

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
---
 target/riscv/cpu.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 4d2eb281bf..7664e686fa 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -38,7 +38,6 @@
 #include "system/tcg.h"
 #include "kvm/kvm_riscv.h"
 #include "tcg/tcg-cpu.h"
-#include "tcg/tcg.h"
 #if !defined(CONFIG_USER_ONLY)
 #include "target/riscv/debug.h"
 #endif
-- 
2.43.0


