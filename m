Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1359EC531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UR-0004kX-Tk; Thu, 23 Jul 2026 20:10:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UO-0004iX-OM
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UN-000671-7S
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:08 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeGtG814653
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Hp5M3ip/bc/
 yTTHiKwR54bLiv7roKtxyhfxsT+2GNw4=; b=gFEpe8i8JNVeIwitzdYeARSJUPB
 BJefG5habAOE1lWg4fV9X5nHMO8GRxJlhh9Xx9OYWXEHjTKHDu95pNQrY8OvqpUu
 geUQCaq8h+R6GEHA8kbHU4MzAntuPZIBabfBO9ffiqUSBjNqv8sYuNqnFr9r6OWs
 5xtsjB+eQ7737RoZyEFk5zFVfl+dNL7i5f82RglAVjnbM6YQOHYbikrAnLfrYgec
 vNFVVgtHKyLlLRmkheMkfDzx1KhiuF5Qn88IhgnwED/bWUqcoS6imW1Myt8E+1vm
 AS9iU7QGpBeD1zhB2tbDGX8KhMcezKaGtq+uWRVc9NsLxQSUW9ExQeXD3uA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqajsaxp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:05 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-caf5fa127d4so2304536a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851805; x=1785456605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hp5M3ip/bc/yTTHiKwR54bLiv7roKtxyhfxsT+2GNw4=;
 b=GCuQLMirUFvHl8BD6vfZZSolRCqLmE+AHEJttkpJ33U9mNOiPsLJN61z7FYcJBzgA/
 uxqHdL8rjOmMyixL4//aRqEPgb1ePhATNPoPQGhvH9lt91Rbd4k0xzHkvEv7BQk1CU1x
 9mUbUBT1A7cHQG/7xdHDUaedGbwgGtylMVel/5yfgerS06D7tBQ9Yy3zm/nbtJ92GrQt
 r0B6sCxf2PmaIrX4EfWt5du5xk7j6+ljnqQUS19Pz9oyHMQF3DSCsons7/cxNS7Bxrgd
 gP2mRtlQb+nPASCgBZrZLVjbXJfB8FnUr52wz+N4RgStmyjOS9xfezuyrhGMImHcRRgz
 Pmyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851805; x=1785456605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hp5M3ip/bc/yTTHiKwR54bLiv7roKtxyhfxsT+2GNw4=;
 b=jgGs8+upPXiOneDrS9nrLEPgltoNbtZj+oF3p64iXEIK5iKpR2psUTchzw1gzD4bJ4
 51CxdJmIeQrxGvyH9TDKjE37/iGJgxuzNDpMkI+4YhdNTvVP11z9d0WHTSuP9+MIHT/3
 ezC5yBa77v6UWeDpV7k56gM6Mj19K6m29H4VJ78psqzh5UWGTo9+mChyN0ZwM9xvM5Sq
 SGLL9WAmjV2ARWZ7j5Ijx9Y2D/D4ow77sDAq3rU3HIDtKEShMAV+bMW/oUbpIrC8E3Wu
 b+22SNp/wSvE4Yi+0YUAX8fnpRtTpa9mcwMbQe17McFpnUdMSzkrxaHTXfqvV1gv09kN
 y9lQ==
X-Gm-Message-State: AOJu0YwCxfpIwxnJ1ME6DbYPRAKMxdfJ8EsTilN6mMPKXGP1KT9FxvMx
 sqxnQgnvlFiqjefGiVJ5P91J30PtBWyAKO4Ul8ULgIBZynQUtfSMByl9PQP3UqhzFuFqehhX0Hb
 8KERC1KjU14Kl6hOyTHHura3z123gQymdNVO9v/yy1tnAVNCP5ZORgqxpKy7XL+/nhA==
X-Gm-Gg: AR+sD12yIBAuX8BAVSEIcUihGLOeUmFTFlDy5uRwqbfZPD9fCgDe1o+9Be5lQlZFUol
 H7OVMk2SQoZsbMtLTy0KPy4gPr2cYWqb1kNJPFhfVbgx9i5yCZVUbxr+zXbHM5xf0N31PhPggDJ
 XNv2h6rU+XUkGIMFxdy70UP9M7gpVmh2i6Kl7+17wEGkZwCzgERHcGpYOL46de43zN0Y8hYCbh2
 BeMKwLhv6CPUdBDW2k31cQKPUzykb3IaNlTS1k2O+mkPrCBJtfBloCJrOlCW3s6aLROGae1SQxp
 TRmoCJ625TbvynUR8kMZQhbX2tcmdZImgNrQyslILEpgGY/ZkcCwA6NWtLoWj78W6NUvhAHDDcH
 j2KAHy6XUpj5fDGkKAQzWmIOxC4Jd6c1mzn9VAktmGNKnjHXFTPVHMJbrGeIzvLpISYAcPs4=
X-Received: by 2002:a05:6300:6701:b0:3c3:875d:c53f with SMTP id
 adf61e73a8af0-3c44b244a6emr6311639637.69.1784851805164; 
 Thu, 23 Jul 2026 17:10:05 -0700 (PDT)
X-Received: by 2002:a05:6300:6701:b0:3c3:875d:c53f with SMTP id
 adf61e73a8af0-3c44b244a6emr6311609637.69.1784851804742; 
 Thu, 23 Jul 2026 17:10:04 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:10:04 -0700 (PDT)
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
Subject: [PATCH 07/27] hw/remote/machine: implement TYPE_TARGET_SPECIFIC
Date: Fri, 24 Jul 2026 00:09:27 +0000
Message-ID: <20260724000948.234657-8-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WNZPmHsR c=1 sm=1 tr=0 ts=6a62ad5d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=qEk-lo4X0PzbKD8g-ZwA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX/OYH9w1nmrDH
 BE1YRXwY3VoeerH36S7qKs6dSSe9zZ6p/BLM6lkj6Perq6LX3qhrJitvbk4i5qh0C5LPv6DIv5B
 jJsarLakks+M4m0AtbOl0pdF48J2uSom9I4bwHp3ofdnCwqY6xEQJjMjVV3dacw/IF4auT9cnWt
 aT8YESyWqAVCdkj9lX/7GdWVX/z3uu891Fw1eqyDmjhpCJ2e1leKiED1z9m4HXKtqzrFLMYp1vE
 8zKxiuxDERiLoeWn/Uid8DZcrZCGkDo5uwUuWaXUWlFhuG9lWVBJvQxyLnuP4EZoxMbZA2Jg3X5
 7WLAL8SilJJYU5K+JPv891RnM5fNEai5/fhDTF1QMWZcLnIuv7zG8dmSF9jtJWp+l0HoXi61SlI
 TkaZ6usGWDwO717QZ60Ujft0dQxe2Tao0WSqf6lmMGcsL0UbWmXJqrl6U/26fjU9iuqXAfNr/Bs
 SwkZ0tqQj1ime3TYPaA==
X-Proofpoint-GUID: 9C-RaFILqUhBnXc-kRX-WWfs6_ibc9Dp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXzBrZvtLPfXk6
 hpPjmQBvOLjshdJOFSiV3p7ADL4rJ8X+VDD34YBK9g2XuFAgcZSgZpioQc/+YMpTbi/DDjPzYk5
 39qQRKyz1DUCpwilB5MtGK8kSeAWC10=
X-Proofpoint-ORIG-GUID: 9C-RaFILqUhBnXc-kRX-WWfs6_ibc9Dp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

This board is a bit special since it's not "statically" available for a
given target, but a combination of host + target.
From meson.build, we can see it's present only when CONFIG_MULTIPROCESS
is set. From Kconfig, we can see it's set when PCI && PCI_EXPRESS &&
KVM. CONFIG_KVM is defined for specific host/targets combination.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/remote/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 88d38b75d52..fa750368df2 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -124,6 +124,7 @@ static void remote_machine_dev_unplug_cb(HotplugHandler *hotplug_dev,
 
 static void remote_machine_class_init(ObjectClass *oc, const void *data)
 {
+    TARGET_SPECIFIC_CLASS(oc)->is_available = target_config_multiprocess;
     MachineClass *mc = MACHINE_CLASS(oc);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
@@ -149,6 +150,7 @@ static const TypeInfo remote_machine = {
     .class_init = remote_machine_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { TYPE_TARGET_SPECIFIC },
         { TYPE_TARGET_AARCH64_MACHINE },
         { }
     }
-- 
2.43.0


