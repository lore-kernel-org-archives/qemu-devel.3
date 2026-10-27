Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2878F606A31D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WD0NvjB+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jP+dOpmQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmp5-0006oi-TW; Tue, 27 Oct 2026 15:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoS-00045V-VF
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:25 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoR-00029S-5C
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIIA4P3486342
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q8b9InkaPernn0ZVT5FK1yUgJ9mw8DbogGbJh9+IUk0=; b=WD0NvjB+wEmzXnX5
 RWcYC5QysRUEFCy0367vRolOFwC7NgKHGETUWGBylataahLbSHIlgWb0Jy3sjlyg
 m8eq9fjzHo9d+2kYb5tkUBimFxYphwK1BNH43k0G97W08lX3JhGBpzXnDP+0geLQ
 bFVjiYoz6I4xenjVwzYsYURCCO+Kcds/5kNgNGGvZK4xquRKE/mbtqCU/WLyMlJz
 nXsfqVT9EsOCY7M4xuvVh2168g0LwiP6frHCVrzOYkj+mw66EEdstMdgZnFwahHG
 UX4DN6w5lW11huM7/sFU5XLevUF7BWE34CfqrTuxyPCf3JPEVg5mpymxSsswIuyS
 g237pg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtc2wq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:22 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so20303585a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129182; x=1793733982; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q8b9InkaPernn0ZVT5FK1yUgJ9mw8DbogGbJh9+IUk0=;
 b=jP+dOpmQTrm9V8cchi1D7DjNiz1tJcwiUsTUc3hPnXahyE5R744cbk2/RRHgq/2jwL
 C4h3Bts7FFfcrjHsTG6WYxSkZvcmsYVbbQyeAaMVJzceL090jh5/gLlfU9SiL1gM8WTm
 cKau5C4sV4wKhJ+NWk5pdpaNwAf7L10DQXL/5CZt6OlhA6T+cD1IEKP1+ozhPVQiJ4rf
 HexIdjol6tnco9VgU/uPvFjN4cS8oyrNlIcbeM+q8KBR9XTGZQgk+b91UDJR7f7kXzsH
 AlOkqR3Y17CFzVZnO85pMm6E822Q2ieA9xp7PbVcknWgsh+CpK1LvbtYd+P7f0yQwp1Z
 OiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129182; x=1793733982;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q8b9InkaPernn0ZVT5FK1yUgJ9mw8DbogGbJh9+IUk0=;
 b=gZnmi8xEDKQI+d+zn3Qpy9mz5OcjKfPtBvEbeRLvrPVyHNCtOIy6ou7rSvCfrMo7qN
 m8QrAjAeewLZSNVQYw2e08ohM9e/e4I8NBUiOc0OtTSjQp23ZdpB1wW6BtbbptHGloo0
 rpxuMaCJG96Cq2n7ndo8uH1pmVvPbsSFfriH3bpic4M5KkJk7FdikjCNoVDMgB4wEeZM
 RBnbBeXEQc9WEUdpdw300f3NiyFZrWPC8ThGY+ni/mbq9qAkJdlQ0NcthmPc01hUI1Ju
 Q9CIi9cBgS6WM82ilhJBxcW6KluSj82EdgZw2U3qLrHkih+LA2+XmeEPU8LPN2KOc84j
 Olfw==
X-Gm-Message-State: AFq9FYLyjDBpLw4s6K2hc1pp3kXHZhe2PaiaIGBxZW5QiV1ZdICM6Efg
 QMgsv+l2oyLGooiLZCViuclxNRKwYEoJ3ljZ0I/gLHQgdh/PYTb+nDJAVDSEaCtRrv3ud4ve57h
 3ZFGrHxC2Koaq2OF7yrr8L02/xTa8+20i/IUQJfj9L5gCqq5xEnnvw0TSeepsI/6JIA==
X-Gm-Gg: AYBFou1rz96wsrhJohLYpCQRyzImJidtSGfzUyrYxlmLekMP/MAawztMEguyBunWbu5
 PXRlP2l8KJ9RmBh7Un0/T1vBzIBAOzRnTJGwO3lDJ9iwWVGT+vmxkSZY/oOe4wtMZLLKFmAYgKJ
 5Uj5FDCQCLUzZk5Ny18mRgGMlC3uh/DjH0fkjG+87HBs4l9OTNRE/9xAmr78Z/X4FI6AoHBu6WI
 CUIGruS7bk/JXX5bLDcNSxihzV/GZgk9WR5SmoxKts2LwsW1ciZ/lHs4C47owJpH8oBJ2RkYyUH
 7RHYLcdWobMKK2UAwhrtnHPugUWrsoEPrfkHHe+WLXE66tCYF09f6tI0ilpoCskCd0jJEpQxZXf
 xvH78TtxsMhz/VjNxxw/syJHSL1RuGdOnrCjotFsGvCmNnGbbDz6drlu+
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-940ef995a75mr1788425585a.67.1793129181531; 
 Tue, 27 Oct 2026 12:26:21 -0700 (PDT)
X-Received: by 2002:a05:620a:c4d:b0:93e:c12c:f128 with SMTP id
 af79cd13be357-940ef995a75mr1788421585a.67.1793129180861; 
 Tue, 27 Oct 2026 12:26:20 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd48e0sm25027512f8f.38.2026.10.27.12.26.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 23/59] Kconfig: Extract config IMX_AVIC from config IMX
Date: Tue, 27 Oct 2026 20:23:04 +0100
Message-ID: <20261027192341.9197-24-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXylTW76rGPh0Q
 mrdzdQfs3MiyZV4cOZfUjdxDHdZCwbw9ELYodebCm914owdSnv1OB2kl00SmZ72qvPT9UB329Tk
 mveH/vdWIo0WRVOGT00+h8bv1cp3oZ8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX2ylsfqbVrDnV
 lYOII003dOevixHLdqqYFd5rOAcjFz2dpYNia/cL/jBlkkyzzG67FfJwEXksmtwUk9LCXb3YhRQ
 GGNS5fSX5BsyuwR1KFfyX5N5+5wmeHr8nh1HT4QqCscqZ5mQfkO7NUAISlcYrbEHkrMgre/kCj4
 Kd03sqaPm7foGTSaDIW90tNYJq7623ABLmlzHTlmVZiiPx/4nj6hs7nC3R+7sxXSAf5PCHUIy7v
 X6uWNIlltc3VJ2tII8zMi31lZ8p4WdN24AaUwDwB8Ih+AQ9E7YleoZB+bT4dU3h56EpyUnVRxZR
 KPjeGf7pJ2UC2r4hjsxHFBTDtkFgqk3Da1Gdn78gqrbC7r/qN0jayluyMP4N0E6n2uLiJzSHnOB
 Szbimu/CKD2pH/yvajntMSsLZyZivT8lxveyHye2Xz5p38fePdseEwlIARnrbyxCIlVnBV8j9k8
 A5dEVwJVF33wvErE/4A==
X-Proofpoint-ORIG-GUID: 8gFSDTBPOihUyqdxfxoZ4RE41KaQEhEW
X-Proofpoint-GUID: 8gFSDTBPOihUyqdxfxoZ4RE41KaQEhEW
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0fade cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=4vP5oIZo8vggi2BNiS0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
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

Over time, QEMU has grown a number of i.MX boards and the monolithic
config IMX drags in unneeded dependencies into each SoC model. Extract
config IMX_AVIC to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-19-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6e8755783e67..2b7547cf3de1 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -480,6 +480,7 @@ config FSL_IMX25
     depends on TCG && ARM
     imply I2C_DEVICES
     select IMX
+    select IMX_AVIC
     select IMX_FEC
     select IMX_I2C
     select USB_CHIPIDEA
@@ -493,6 +494,7 @@ config FSL_IMX31
     imply I2C_DEVICES
     select SERIAL_MM
     select IMX
+    select IMX_AVIC
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 05e697967d03..97355f9df78f 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -5,6 +5,9 @@ config I8259
     bool
     select ISA_BUS
 
+config IMX_AVIC
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 0620b0792a16..74d84b8ddcd7 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -23,7 +23,8 @@ system_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_gic.c', 'exynos
 system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_avic.c', 'imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
+system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.55.0


