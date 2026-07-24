Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6111C531FF
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:12:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UY-0004td-JJ; Thu, 23 Jul 2026 20:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UW-0004p2-6h
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:16 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UU-00068Z-Py
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:15 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeMFv948305
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=JLivbfma71B
 H1bKuHhMTJhnZPzwXSqYa+ZbCi1EfThA=; b=aZNonbILKvRvy2c7BBMUKZVgLdQ
 aarLe+th8fh/pw6p1f9ckyvPEKtvcTdtO3OurgK5L8JgsCq5h7yVq9odWBaQ/NEq
 d3xzUnrlogr8JFT4NMBTK6CneMuzVvu0GsBNyvjX+nZHWBp4DzsWRvGZFz1XajwK
 X3e3rxHK8V3xtQXsUEOGjxC2violCuRKLitZT6I9im4wOeNdjnVfTavPhb2Hfo23
 n5zzrUWUjE7NR6DHDllfEluQtva+m9/JUyLuhWWqjrU0l4hicJJK/JgISyVBRGCj
 F2Fwl87B/uX1anTLRG9W5D0OQbwPHw1nxxTrjDyAsFSzb4FDhP2Ka3/LFKw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0kv2fp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c860544c077so2881400a12.3
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851813; x=1785456613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JLivbfma71BH1bKuHhMTJhnZPzwXSqYa+ZbCi1EfThA=;
 b=SVA/W1a6ouDNZcp2HnKXuoGF+dUWh6H6++wXG+RaKIUAHTuPUFFQbG7N2A81wXNY/u
 rDWy9cwjoCx/9iI/fC7//K0QwfM4ZcgRBF2M6BOD5N7+au6uYGwqprv3/wTKtU0uTiqp
 QOYNFlmaGPuE3AKcV2Wztf5vA+5/86z4r3/8hYVb+Df6d36oGDhvrZyK2IF9GRutHii4
 TkOUt3V1aaEcXMdcZkgXvKv8yx0bZucerfWh8ZZBu/21fxfDIXADmOOIYIBCO5M+73QK
 DPG0NhG5j0jtDnhUQF0juPbXJCPXorvzJs2vK/EcYaZAy6tz7+Qrw3CN9Iqu6Ivynfc2
 j5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851813; x=1785456613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JLivbfma71BH1bKuHhMTJhnZPzwXSqYa+ZbCi1EfThA=;
 b=a2h72wtDu+vUizXwxRbNbAMYb9oc1Kkdf+sYumc5g11anyXUdusm7ze2TLFKXwECDr
 65A6T3ik+sLlJ70AArP/KKuoImZboam5a0EkOS/z7o3hG7EAiWZrzBmkgP6tT5xqxqKS
 oGA6oB5MKm8t3KFzkQnBXv/CQq9y0nLLz5NpPHXSMCBv3ESAGMwwFf5QoEMHiDeANdX8
 Z0Xt7fRF/+0vDQAWcXyl/56NqCTHgaXQ9xzC6+pDgwX382GPzBmYktamr1/9I/mHPMOs
 dl/XutUBC2OTg7JVSxprZUg1FNk/OKX54aNcrnFgubt7ZOrN5P9RPM6/XSGAVRkiCUSc
 cAtQ==
X-Gm-Message-State: AOJu0YwdGmDyA4mNySh9d3Jt2sqBhVQtQFNbQCzwJG+eu8VHTX3hjcfU
 oSnzR9pNXWem4DaMisIVrrp2wgVP0QYb7Aem0FsmePp2j9o7r+AwlwUc+gWCucHJv96aqOrlIjd
 D1KqEdlNcZbDjkpAW6rjJ9En8uDuIN+hQKHS9pOn/nJJT/+zDHZG9CVkI6wE1vi5laA==
X-Gm-Gg: AR+sD12XHLzjIwaVLHZ4hB+5OZ59WeqbJTwRWkG5p81pqBVYeMcdluMqR4Kd643+Ii7
 ITjxLgfbznTTQ3KmT6Nw/YkYOzswTRGsuzXbUKKn0F52DILP2usYD7NzRrnhCd3LSb+NWjENqhJ
 fd+CHmbrZla1DTogZ2pbaPnpjZMe18fqRBvg9LGy0hM93WjgC+/tw3/fp7S5NW3qM/gaCTw28GM
 VhYWk8dqan3mN3c4rGqdWc0J0U/mZ+E+WIIw4hVUSJo6XYjvAxqbnJFa0RWrlinA10i5PlWwGQy
 mroG+f4rAG1ASqOb4aeQkd/8ul/9DFJH+FJdQEk80oqVyzLWpYadsIgpDEQ7sScmCYNS1KtLTRM
 hL0GvdJfXdQPx4imKfsmYVdHKvMYnjyCQOca6iyzCO4qvFe1JHlu4KkFws4RO/lekdJv47aE=
X-Received: by 2002:a05:6a20:7483:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c44afb58c5mr6124825637.7.1784851813011; 
 Thu, 23 Jul 2026 17:10:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:7483:b0:3b2:8685:1473 with SMTP id
 adf61e73a8af0-3c44afb58c5mr6124799637.7.1784851812686; 
 Thu, 23 Jul 2026 17:10:12 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 12/27] hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:32 +0000
Message-ID: <20260724000948.234657-13-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -K_0MVQ9tnAkQvvL6Ezpj6SB84-MiHeB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXx+GVKNQyah0v
 CEcQGpoEeAFKp2Gy+d8T0dj3wmKRb43zouPg99wnmyywkRd+OWShzJGSBkdtI3tNoKWaDDFz7GB
 kLD/ldxqAAVDxSF2kKrW3uNe9sLB8NI=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a62ad65 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=ZqlWALTiu-kBWpxS_LgA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: -K_0MVQ9tnAkQvvL6Ezpj6SB84-MiHeB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX0cYtUXS6lQCL
 gjuobV9X49VRGAO2KfQQYXTlojuvCCwa6JwUBy4OkNU8dmN2+8zAFqifzne2qae6V4QbnayTVs9
 AnValMWam1F34r95SeaPmOfUeHVRcKwC7cK7WMCwcC5FWgPKB1Q6MlYYNL3l/Wu90eLUpwfhkw0
 oJ0xAZkcyEnuTxg71AfwEi7lOKJqHTVhxYNz7BuqDZs+r+po0Y5JBmb0baFiISrTRmwEz1mGbxt
 bkDGYn6+V3nmRCXV3bOgfvXlpZUJTINSV57m4bfUw5MQGplSRd0Ye/z/uiOT71eUWQAdfoSLN3s
 rzJjvMWNx/Q8k7BPcUp6ycRzQZSi7RQNVAqnjB69eozN3f97lR2kTH6KM7K6A4DQtJhs6mRWABy
 2+ER1X9QMzIhxDzDpPzNXqFZWJuJttOSn72OXYBMM3jnnx9o4to885wv2qAmUf0jp3EPHJKgbmd
 aISIVIUFCB1PZcniakw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This machine is available only for aarch64 host/guest and x86_64
host/guest combinations. Some nitro devices follow the same rule also.
To avoid duplicated information, we use CONFIG_NITRO instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/nitro/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index 8849959359c..79d57664886 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -248,6 +248,7 @@ out:
 
 static void nitro_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_config_nitro;
     MachineClass *mc = MACHINE_CLASS(oc);
 
     mc->desc = "Nitro Enclave";
@@ -264,6 +265,7 @@ static const TypeInfo nitro_machine_info = {
     .class_init = nitro_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         /* x86_64 and aarch64 only */
+        { TYPE_TARGET_SPECIFIC },
         { TYPE_TARGET_AARCH64_MACHINE },
         { }
     },
-- 
2.43.0


