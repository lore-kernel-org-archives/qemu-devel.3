Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB38606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fqieUpK6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iA5eE3mS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmow-0005px-H7; Tue, 27 Oct 2026 15:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnq-00035S-Ju
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmnl-00026c-Ox
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:25:44 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIB7v3486365
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1XHZQAaeA2gZrQhajwi9m4Ma+u+G4QHTGsZIvOHMkgo=; b=fqieUpK6SLbzetIQ
 OBPIqlDpre7vGTY/OHqOUc/L20Lgg7i3XTK85DzQrObML2oiFvh7pvB+sjDlgdef
 o62yvSRGkPRBPseGLl2xRumji8vbPr8v0iTMZC9xEArYxLCxD1ZlNxoXQ2ydry7Z
 WJhkuLvZYhyYrPkxANlDtEokTo5zwJrAwTeF+gcVTr7hkyzaHzYXc+mMkjofT61V
 xq9jgiVxhpcjI4aU7TxnZFov5R4TjRVAX1171WXY//2DHuoRYwZMr1u0Fizcv0Ms
 39GYO9hEVEs8eDMukMbNPHP7NGkUZBZuueRH3s/P1vhdYwX7L5QKpWYYQ9HhznXA
 J42qVw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc2t9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:25:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f62934ef6so24700785a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129140; x=1793733940; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1XHZQAaeA2gZrQhajwi9m4Ma+u+G4QHTGsZIvOHMkgo=;
 b=iA5eE3mSLaTLYJOqP+FzWwV4IxZMq9yyit4Q1IXSEJ1+5RKOz4bs90Q/hiry8iQk/u
 h7IRZgaiJlSXE87qzsImd8zaINBAUaw9VVBAeL6jfbz6YMAEUwMJHk0iu6X97LKCDvj7
 yXy4jVTA47SZT0G2S7uy7VQs009MV6MJFm/1YiWW62GcHIPw793CxAFD4+IUqkusZOot
 jyvX2K9eDeowJnHSY8e32yX8Skfd3y30P3N7i4Euj/OgrOlSvx1EHQF9qnQmYlEeUJUN
 i9ZQEyM6G5c87Tddy9Y7aph9DqUf/Gw1o4vHw6a9AEbNVefdSw8M3kk3AiOfmMWoGtn7
 Difw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129140; x=1793733940;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1XHZQAaeA2gZrQhajwi9m4Ma+u+G4QHTGsZIvOHMkgo=;
 b=wUWCeo0Ii97tc67KViAx1ZHGA12SaiQkktX/U9fkPHTGm6zyBq3HysxXOUNikqJtMy
 +A483cb2oK4/TnL0qfJ6V14KzTh0j00S2GYwX4Lk+CNEu7kc/ZKISXOD35Y6W5Ago5oX
 x+PItzQik4mGyl7G83s6GOOz9+bqeLOHeS2ww2z5P9i8fNZviiKIWnVqj+xk/IObDZJA
 TDfCfkSckw0y2GMDVVkDuf/oxY44gysN/eOmiMBbBaVW7t7gXQxX3JbE8usydH948p89
 8DRabJvdoyZ7cJX3JZMSOfxD3EV5J/oXdgLq2GlQo5uUwINKwk1m3g0y9Lh+jATr4W3j
 vObw==
X-Gm-Message-State: AFq9FYKkGlZOt9RuOPBpKgrLexjDV1xdc7CNQmXA5lICkqaNcizITy+k
 ThWmXsNITSEQcSN66vOmfQSl+5jZzY+KUKOG5StlvzkzJ1drNYq066rbAwTubRITDjOKy5ZtcYW
 XvPmAqQMl9crbthU1sP6CyxrxMeR/X4KYja3b+1WeyCay7pu0cUBRL55Brq3pif4J5A==
X-Gm-Gg: AYBFou1N3P4vq6Uybx7PGkoCuorj4oU78I6XstFxhEs+7j7535EcdUcdxpct9hcqqii
 3M10WE4zjHrBq1c0qZbOzgO8SzDzCyBzm1nfRBch1QZYu3xmBRjxb1JYKiOpuDKyr09laScCZ++
 n/O7VzzVh9xewqdvzkRfkaQRHRSj8o/Sw7bmSrcuQkSIR7rsvZH6gcA8CXoxYSDs6CFXUbroxxO
 65i3y+oRDNMLwy16XYL4iQWVPlXn/Eq0rLMUyTqpnoFzgzWgJ96Z8vzVZ7W0ToKyQv4VumeWqCG
 E0wpONidhgfIS7o5XL42Yyr3HRBotERP01jl0b5zBDFBu5oHVuvmWGrB3TLIeioXQvn7igmqAmA
 WWtgu6YlAO22aYnO9l61ewhAs5fIIv7XJMVvpuo3+6TYQdai0n1abSwiG
X-Received: by 2002:a05:620a:628f:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-940ef8adbfamr1769230585a.22.1793129140070; 
 Tue, 27 Oct 2026 12:25:40 -0700 (PDT)
X-Received: by 2002:a05:620a:628f:b0:93f:34c9:9248 with SMTP id
 af79cd13be357-940ef8adbfamr1769227585a.22.1793129139544; 
 Tue, 27 Oct 2026 12:25:39 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm24513299f8f.17.2026.10.27.12.25.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:25:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/59] hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue, 27 Oct 2026 20:22:58 +0100
Message-ID: <20261027192341.9197-18-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX4hXohiKbfhYo
 7Jrhqm+d2NNXxi9wQM+6KVHJ2NTWYxVL0gtWzpNyKr8RIFZOK2bwzag4sNe0PrbJcvEUCuas9UO
 UwagKLqkWMbHD4e9KxYxm+PXl9tCxbg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX3vwY1DhCxOsQ
 4h9jnNK2bYhl4Lxx37kb4iUSxPxrK0ALrYAr+NF04yQIj2uXSjuLmKqqq5a2Z18iCa10Dc2d00b
 Ak7qmnoYL63lfoOjptP5uBVxv7Y44O1tIIXX566/2ArpRbETFZJ6FJxTJ5baFEforeiAkyxwKN2
 w/lTwJAyzxbMvh4jRsxls688K0i0mCKaNpNcM6jl7GC8leftBiW62QzXsNdHYbs96GnODXqjwD0
 Mdgl2V67vgDbaNwJuBKOf2dxmSqbwyXUDvl8C8Rlb0wFppk2ReiL7X6l2y1KnpW/71w2G0JGkzc
 wqGAz4GDxECVran15Xg9M9BF51OxAGzhPE2vVtM6AuGSMpDUguIDJIoN2vNSCeY3YXP6o0IwuTO
 4Y+gnW8hh/ECOObsdeZ9wwCBpVlj9rw3tHaKwDS8cF3s05hfHjqH1k+ZMXQAIaSX1pb4XwfCOPw
 PZ36EUMKCuaw7U7ebeQ==
X-Proofpoint-ORIG-GUID: 1tmBI8yD5X4aGvjOsUJvDTdSWof8qUd3
X-Proofpoint-GUID: 1tmBI8yD5X4aGvjOsUJvDTdSWof8qUd3
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fab4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=QqySrU4nI9ZZNlfiYE4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

From: Bernhard Beschow <shentey@gmail.com>

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset
upon machine reset.

Remove clearing user-creatable which is implicit for SysBus-based
devices.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-16-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/arm/fsl-imx6ul.h | 5 ++---
 hw/arm/fsl-imx6ul.c         | 4 +---
 hw/arm/mcimx6ul-evk.c       | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b7767..9ae0488990ce 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -18,6 +18,7 @@
 #define FSL_IMX6UL_H
 
 #include "hw/cpu/a15mpcore.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
@@ -64,10 +65,8 @@ enum FslIMX6ULConfiguration {
 };
 
 struct FslIMX6ULState {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu;
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d67..84451c99097a 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -730,13 +730,11 @@ static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6ul_properties);
     dc->realize = fsl_imx6ul_realize;
     dc->desc = "i.MX6UL SOC";
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6ul_type_info = {
     .name = TYPE_FSL_IMX6UL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6ULState),
     .instance_init = fsl_imx6ul_init,
     .class_init = fsl_imx6ul_class_init,
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 4964cb934519..53d221b4a9a5 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,7 +44,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
                                 machine->ram);
-- 
2.55.0


