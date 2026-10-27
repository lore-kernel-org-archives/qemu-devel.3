Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664A606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B7Ayo9Ae;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OeUuMmUu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmpI-0008JE-Dm; Tue, 27 Oct 2026 15:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpE-0007vX-GH
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmpC-0002FA-Dc
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:27:12 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHQe83553894
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pq0PzXFXasFa6FkofMHKRqN1NPSHvU+K7DkU8wGiJlk=; b=B7Ayo9AehP+74+ln
 lET8Jx5PAP6Ll/MOmc7bWxyAuTrv1V1nVoSvfL6qCZ8Y4Bt5mArYQOZl+z6f0Hmy
 IiZK7i0nvHtoY95I6wDS6q8MAvW7yLo/tn4HIwWP0YLeQ478abu5MtP8nkRs74qk
 2SvthcgksT3bfYcsGKhjUiAlGH41jFIYJQjA5pLFILMAVoFeqUpAx2GtiMsu9CKF
 bO4O2dHCOvhBtQfk7BqjFZree65lAE9nkLKk6TEq9qZjqlxYRdQLo/zkMHyzRjU6
 jvbL1o3SQaMDLsmuVSZ5+TJwW8LqM39WAZZMXbktV50rwTwJTBvKJbUfTM6pSys9
 yecH+g==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw22wr0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:27:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93f559420f3so13911085a.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129229; x=1793734029; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pq0PzXFXasFa6FkofMHKRqN1NPSHvU+K7DkU8wGiJlk=;
 b=OeUuMmUu5jrtvAhdTfCQ/7MBkZmRIfnChATIrAZdC2ZT2qt/alf0nNCLnbm9oh4DE3
 u9Jwy81PPJuVBzVK3JxdFxLfSj0zVBS2+jZym+o4+ucmuE25o1mDvyVLJ12tI9Sqyojz
 4Es+CdLGJUv1MaBhFfdfYkZLTinE+qq/iCc16gYK5rNtoNxrXDR1B0IvfS50OvGP3n2z
 x3PwSZr10Fe6no9h2434O5m3jBlWQ8sbUxijRqspCOYEgtKqEfn7B91dUrJtmGRMIJuw
 Wyrh5Exer77lrsUKh2zvYViGME76yq+sCMtSqhIVP1KHN6W+1WIURadHblYFt8VoUhHw
 wClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129229; x=1793734029;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pq0PzXFXasFa6FkofMHKRqN1NPSHvU+K7DkU8wGiJlk=;
 b=wZ2dxNAxUei2YJvjRYF60B6Is+CXSpca10zv3KXo1qy29xGqJoBnII46UhJmu9TO9B
 v2XCMhk84dlFKfomrZVCsZygdv4LMXmGTa043XRk4eAZWwcM5EMQRP0E/+sTgGldE3RC
 smP+1Kw0ibBYSQbVD5xVFvA5ID2XE3bjJ1MjdZI1sdVBnEHi6gVeTcheHRZ20vRHEuFx
 yJhwiRvxuNepyGw+t0t/JT8meVlmskRyE01QnMgUYScmB3tYzBj+U4HYR4ZAUggDPNFH
 IQ0XUi1ViS6hOR0ecFcc5/ABE6OI/EITYMHw6EGKJMOFWxxVs1WI3YwrHFT8Xjymma/v
 D29Q==
X-Gm-Message-State: AFq9FYL6bMy/nMjIgkXgOdmH30f1+vkNU5p30SUrzDc9qDO5R1hUzdGF
 n8+Rrq6vwRuTEchby4iX9KML5urxwlkapqsrJveulxwjqR6F3qRLyO5Cd9B1vytj+uqWqGk2Dav
 Oa+4cf2xTS4HxlJWJD5Gczm56w5l0W4Nr/MwxKvNBvITHXGOox7tuKeb8y38xBr2Ywg==
X-Gm-Gg: AYBFou2bYw43O4gv+HFU/Mkd7uoIto8Qn78A0oRkLsVbUdid0gpqafKbrOe/pfQScAh
 +IobyEhIUBat8DqZJ+CIbKPEXM9UUVSW/TYGpHjy6cLSGprX8t6BqgB1Uo+yt08jqnPYEWksF7R
 6oA915ShX4YSOZ0EWjy0pdDjFYl699PFkVHyQJZBZXv8CqIA4bTraBuCwZdcYLJtx2OoPvEjsyi
 Qx0KR3ngR6JHdm5ijOzZQD1RGV9ZU6nzRnFU7X/nv1Tco69z1v9dECb4xg3RFSHOgzqjyU3drEA
 eTwQQdNEcdfJ7uGerRRzpoFkJQWzLe0Buj+OUy570pfi1Y4CU0Wc50A0wOLZD9lkCQr3bnMOKVH
 5VahWIn2095fIycvu6MSw9HeUue7SbD45TaD+6zvej5IKhbj8/rDrXu8C
X-Received: by 2002:a05:620a:1a0b:b0:93f:102:566 with SMTP id
 af79cd13be357-940ef9bb6femr1710904285a.67.1793129228635; 
 Tue, 27 Oct 2026 12:27:08 -0700 (PDT)
X-Received: by 2002:a05:620a:1a0b:b0:93f:102:566 with SMTP id
 af79cd13be357-940ef9bb6femr1710900485a.67.1793129228086; 
 Tue, 27 Oct 2026 12:27:08 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a952b02697sm1708015e9.9.2026.10.27.12.27.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:27:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 30/59] Kconfig: Extract config IMX_GPT from config IMX
Date: Tue, 27 Oct 2026 20:23:11 +0100
Message-ID: <20261027192341.9197-31-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX/yC0BK0bNssW
 VEsBQ9X62PkVKK4JULryKJslqD5QL/hTa1bQQODJUW+F7nbQvk3PG8c+euH3H74SKf5lKFVcYl8
 JnLQEq89MbxXsxAvNRes1YB6vlaTc4sbgNK+AJoBP6UtsB4m4q3rlqp1hyivelTY1KcTre8LVm0
 HrMKw5ezrNPfPd7Qh9WqvwS1XY8Oh+z57kQ2PolD5ilfpmhFVXF3KzDUdi7kEw46aMJeX91Lf4c
 zHr/dxepki1dYb9I0DFjf/kVmaVM9mjWzSsy6HQhozPNFQp5LWf+h48ICAumjprM5FTKEXcuOO8
 S7/FYimE8K1hmNl2qy72SIxM2CSmuueEFKJPu/T2gBbVtOW0rFjgEjbwMa1t88O8RhmMJiu48wX
 seJby7MP0lAFV/UqCoKJ/d2PkcodzANbB3XXoceVMWJ2+DcZhf7ZUDr97Z7Id+hgH//hFCmuCP0
 U7ENzAXp7st+A4sSdXA==
X-Proofpoint-GUID: hA5lnHJcuY0k-x1BtMIKUjfXEr90ruiL
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX/myyEVEmXI8G
 WAvhRYSfNNyFGWFPFaweBfLPGLbXjTAzltcMTZA1rGpa8nVHZ4HxjEXjd2I/82zH53+aAVNZoo2
 v4bss1oTcAr4XKyrykKrZNGr84szeVg=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae0fb0d cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=SVMGOoKj2laJ7-jveC8A:9
 a=nAlHLIbS_sV33Ou0:21 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-ORIG-GUID: hA5lnHJcuY0k-x1BtMIKUjfXEr90ruiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
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
config IMX_GPT to eventually eliminate config IMX.

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-26-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig       | 7 +++++++
 hw/timer/Kconfig     | 5 +++++
 hw/timer/meson.build | 2 +-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 4d9279ca2c8e..57bff99c2585 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -483,6 +483,7 @@ config FSL_IMX25
     select IMX
     select IMX_AVIC
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_RNG
     select USB_CHIPIDEA
@@ -498,6 +499,7 @@ config FSL_IMX31
     select SERIAL_MM
     select IMX
     select IMX_AVIC
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select LAN9118
@@ -512,6 +514,7 @@ config FSL_IMX6
     select FSL_IMX7_SNVS
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select IMX_USBPHY
     select CAN_FLEXCAN
@@ -592,6 +595,7 @@ config FSL_IMX7
     select IMX
     select IMX_FEC
     select IMX_GPCV2
+    select IMX_GPT
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -611,6 +615,7 @@ config FSL_IMX8MP
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select OR_IRQ
     select PCI_EXPRESS_DESIGNWARE
@@ -637,6 +642,7 @@ config FSL_IMX8MM
     select FSL_IMX8MP_CCM
     select IMX
     select IMX_FEC
+    select IMX_GPT
     select IMX_I2C
     select OR_IRQ
     select SDHCI
@@ -679,6 +685,7 @@ config FSL_IMX6UL
     select IMX6UL_LCDIF
     select IMX_FEC
     select IMX_GPCV2
+    select IMX_GPT
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index e1b751a54a7c..49a4d20e55b1 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -23,6 +23,11 @@ config I8254
     bool
     depends on ISA_BUS
 
+config IMX_GPT
+    bool
+    depends on IMX_CCM
+    select PTIMER
+
 config ALLWINNER_A10_PIT
     bool
     select PTIMER
diff --git a/hw/timer/meson.build b/hw/timer/meson.build
index 8323efaf46b6..477dd47486ea 100644
--- a/hw/timer/meson.build
+++ b/hw/timer/meson.build
@@ -16,7 +16,7 @@ system_ss.add(when: 'CONFIG_GRLIB', if_true: files('grlib_gptimer.c'))
 system_ss.add(when: 'CONFIG_HPET_C', if_true: files('hpet.c'))
 system_ss.add(when: 'CONFIG_I8254', if_true: files('i8254_common.c', 'i8254.c'))
 system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_epit.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpt.c'))
+system_ss.add(when: 'CONFIG_IMX_GPT', if_true: files('imx_gpt.c'))
 system_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('mips_gictimer.c'))
 system_ss.add(when: 'CONFIG_MSF2', if_true: files('mss-timer.c'))
 system_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_timer.c'))
-- 
2.55.0


