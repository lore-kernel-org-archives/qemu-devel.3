Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60148CD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 17:15:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZtrS-0000Tm-00; Wed, 17 Jun 2026 13:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqz-0000H5-RI
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:07 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZtqx-0006cC-Ic
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 13:15:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65HFpS153284182
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9v5lWJbAJQ7eZUBAlERhhzVQgHCflZKIG8PBRcXSvQ4=; b=c5zpMjLomFcOtmga
 oKh9hSPIO6mZI2800udyxgg70ACjhubJjCfu0r4EymQC+eRv/MPGCMATOWFFk4l9
 TqZ68hOWQFcFAI8bHJCfJKn0/245BPxXXlYNkj3oNIM+bZ5FpIDab6hQKh7hbROz
 aD/E4lMyTT9BxmHjU9oo7g3nqLxIz/pWsPbg5v4bV3Nweyl6R31rCYfLOC95aler
 zKDMHmugAJNlRvkZdjELWB9Am2M7RsiaUAkPEIgNUT4C7KAtOUO+WmbrtUN/hjLV
 mMPTgSWVQLEk5DdhFVRib2ZcQzyov+XLJRfHO4MbElRxkHKMfCd6AckgysLqlHd2
 8tyWsw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueevmkb6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 17:15:02 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-72391c58184so15377137.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 10:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781716502; x=1782321302; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v5lWJbAJQ7eZUBAlERhhzVQgHCflZKIG8PBRcXSvQ4=;
 b=d9gKwiVIyVfN4e757TNpCptSQHDsGoHBndmsYRtS2u8JA9szsuxxfPcffwn+QzTpwh
 SXzRRjM+OUlWSjHk1oz2wjkbd8gtg7i0mvOCX0tqDUAibBrh+YaVEwLY8mOyD1gGrIdO
 TUGIPUW+dn3x4U617Iagz+gU3Vp6iKYtpUJEdxLqcmMk71y8z40rjgE0mEjljqRLl3pM
 ZZgvVTPegWesU6LjNdk5qjLPvsy2OxtGpbTiZWlsnBq/4zH674eK5a+sOLv86AyRR74X
 VgoDJTKL6v35YF8OlhqHh4HdmgYSaArtaGuw20JYCgwX052ba+Y35NagmmeaKfdtqdUB
 loUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781716502; x=1782321302;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9v5lWJbAJQ7eZUBAlERhhzVQgHCflZKIG8PBRcXSvQ4=;
 b=m3H7p9SdxPA/nkkZCYt2H+3NOJ6qJ6OL4TyxWNMsLNa60ZZUhhWCnv9fUTg5ji/ak2
 T8VBLnyO1PYE1FA5/3vmRuNhMaDPfwYcmZifNcK181hGobapIVo/xdDvslCled07nQa9
 ZNsAgrim6BOZqyHpZrZhhz+hNmSSMIptVB9FlemXG3v1GkqravyuKxUw1MAZ2CXOmLCT
 TDaFmaolQgMkjO8SiASmbz2kZIxXL9XKFtYOIza5c3PvND/vjwk/gA+Ou/Fy/8+kSe4J
 n1Fe+9N/lNZRPrxu6xFIBaMefVLfGGImHZMvdLxoF7Frg6TWYJp4nwhMiLUMy/YXtN2e
 acdw==
X-Gm-Message-State: AOJu0YxfBQDru4lLAQixbkCsblpvE6yHVETdJzZMGecVh7tc2KpbKhjj
 Kz594qkAj3CDJO36E3DJ5hAo3tvsAeXU8elhYXya75pS1+9T0FRKJNZ/C246aFmecH9mMtumEV7
 5BPh6kZGvsIgp+cgybp7ztkkTxI3HckNB5l9NyT9aP7h2EkQN+1AanEkw7ovCPFzQOw==
X-Gm-Gg: AfdE7cnY81lbUslIKVMEm5Vi1Vg5pDtdoOtrO8BDCvgQQgliHrJ63H8LY1HmLHFGcfO
 AhHCvOx31Rzol043j/Y+4vJeicMFmK9D0ds4aOPxD6phzT0mqVx+lpEyu/dez2QvkE89oyMlm+b
 ZbJ0951cPVViqX1OYQorASPB6g0QRSpOP9gIrgL0Ice/TbX6nyZYWOf8ZjhozVXjgZmUjjAtpAK
 Sxa/OCVyatcC1i/JSMo97GD74DDaDq39w2WVSmjn5VMBSGN1jOftVPBToh0CNaQ+SlRn9bgEk9r
 l7kDW+8YZ5/AFGjgcoFCSohUAmbmGl+aEEupbPyWwYZ6bHXA3ZeiS3MsDMQBa+gwec1OXTo00Xy
 opnrBEaRzKfAJNbpIiEmPGWM9DgHtKr//Fkc9CyyKWfYQg5jdHUaOszcQ4FEKbwYfVsY7
X-Received: by 2002:a05:6102:50ab:b0:631:d3e4:efcb with SMTP id
 ada2fe7eead31-7246cff94dcmr2912726137.23.1781716502017; 
 Wed, 17 Jun 2026 10:15:02 -0700 (PDT)
X-Received: by 2002:a05:6102:50ab:b0:631:d3e4:efcb with SMTP id
 ada2fe7eead31-7246cff94dcmr2912627137.23.1781716501024; 
 Wed, 17 Jun 2026 10:15:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4fd31sm173915315e9.4.2026.06.17.10.15.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Jun 2026 10:15:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 03/11] accel/tcg: Remove cpu_loop_exit() stub
Date: Wed, 17 Jun 2026 19:14:30 +0200
Message-ID: <20260617171438.75914-4-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617171438.75914-1-philmd@oss.qualcomm.com>
References: <20260617171438.75914-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX0J6k9UEbm7ca
 Shog7r1Qxc92gRDfs7ZCNIakGRxwaaQ9tDHLg8goE2JIbrtfJ9CUg3nSBwuuaYtmoL/h1EN5w00
 nOqIlYWbKDpN2AwEvVfZ7GfJsLsUQkwwiNWKNc3pWYXgBxNpOiEU3okyVnVRXh55RyCl6UvpAB1
 6G1fBSDD8ONSI2o9hyAzppptLDzdQqOk48+/SjoJPfVPapHZKZczfj36p0scdSaP0iw9HtVKzq3
 Ee0tzYEmNQgtleOZX57AlE4s5AgRbPsRtJizmE37H5VKHJETjym82M9KaAda8h0cs46FpY5cBBS
 x9ndAUzNdPv9LGCBXjL4TYZwraYmbHFqDR99CcQSg7WkiRGbLqh/q0ptHI4oCOulpH6DcU6X3h+
 gSxs0pwjMVDdHbzhjvOdKiIt0iiij7ajVmb5aHXV9TX9fNfLjMYIx6dNMfdsi/uhDGfchtgbZbg
 QIFJZ8WiIWbfqJhUi7Q==
X-Authority-Analysis: v=2.4 cv=LM1WhpW9 c=1 sm=1 tr=0 ts=6a32d616 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=nTtTSeO8Bg4HjSiC9DoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: S2Ep_DEh_g94rIAvBnQU3NI9NMGwhWpv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE2NiBTYWx0ZWRfX19DPIf/xHrgQ
 iBhVOUMWVwCfCdzZEpa76rZlg+ttsZV0tH1e38oyfQ189zxRUT3k6pmPBfwRbiHwuBisCYDZ9Iy
 oCz6wJeFajRV5svQkBus3Urx6XnPFWY=
X-Proofpoint-ORIG-GUID: S2Ep_DEh_g94rIAvBnQU3NI9NMGwhWpv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170166
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Last commit removed the last non-TCG use of cpu_loop_exit().
This method is now only called within TCG files, so we can
remove its stub for non-TCG accelerators.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/tcg-stub.c  | 20 --------------------
 accel/stubs/meson.build |  1 -
 2 files changed, 21 deletions(-)
 delete mode 100644 accel/stubs/tcg-stub.c

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
deleted file mode 100644
index 855e5d43171..00000000000
--- a/accel/stubs/tcg-stub.c
+++ /dev/null
@@ -1,20 +0,0 @@
-/*
- * QEMU TCG accelerator stub
- *
- * Copyright Red Hat, Inc. 2013
- *
- * Author: Paolo Bonzini     <pbonzini@redhat.com>
- *
- * This work is licensed under the terms of the GNU GPL, version 2 or later.
- * See the COPYING file in the top-level directory.
- *
- */
-
-#include "qemu/osdep.h"
-#include "system/tcg.h"
-#include "exec/cpu-common.h"
-
-G_NORETURN void cpu_loop_exit(CPUState *cpu)
-{
-    g_assert_not_reached();
-}
diff --git a/accel/stubs/meson.build b/accel/stubs/meson.build
index ccad583e647..7c6d7ad9432 100644
--- a/accel/stubs/meson.build
+++ b/accel/stubs/meson.build
@@ -4,7 +4,6 @@ stub_ss.add(files(
   'nitro-stub.c',
   'mshv-stub.c',
   'nvmm-stub.c',
-  'tcg-stub.c',
   'whpx-stub.c',
   'xen-stub.c',
 ))
-- 
2.53.0


