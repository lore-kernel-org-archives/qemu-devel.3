Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377D606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q5BbOJSk;
	dkim=temperror header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=K67KehSN
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmor-00059L-R5; Tue, 27 Oct 2026 15:26:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoa-0004Mh-OI
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:33 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmoZ-0002AK-2h
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:26:32 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHpiA2960453
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4cEwCCl5DWrg301CzCKNGn18H8JUDg/M9i155OIZYCM=; b=Q5BbOJSk5GG7qAsL
 HS97mi+48PoJ0Mpr86Inu0DJqHdkqkqXPWQEO/6B+NlDOdHnaTQCQ1eGnoEDugeq
 vsnVMzwP/1qCpAq2xVphCKHPD1mOgwYRfqqhTM7iHu2UD1QA6Rjzg28gJGpaa+wV
 RzoX2ZnHlgMFH1zpELtKD42HLrrJYTz7VytGLchuNllRfdM8aFUHYHS5SMWA0CYB
 X8sSLdaBI/6NDyM8IdHZrzfRRZsd+88NvLuwoPwyKcmAJlvD7Gb04oen5l1oBhVC
 ttJPTYDniTEf9bUCHmP9sym/HWV5fLmCVpgt9fvA9YW4N+AW9MqHDrNnI8TdwzXN
 Jg4QrQ==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670v82-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:26:28 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91c7a26f892so5515426d6.0
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129188; x=1793733988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4cEwCCl5DWrg301CzCKNGn18H8JUDg/M9i155OIZYCM=;
 b=K67KehSNtaYRFCbGETT0FEU8eTHFXKjhHgMcOSZopRfjmGVXgQpF82gPq7eAEzndQz
 0KMi5XRZs9ij+/jXm456bw3rZMyNtT5dzOeUkayCXAGVdX1A7PoU3CsPetmp5yRoYOIZ
 BYdv85T5echQfxwPeNl+f3Le4E9GIMoVHbvDdYCH1LMgDHHPsZNNHitBuFUVJNRDKfT2
 SaWo2+zQvRl3O4FYCAYXxhr/wYPDFfgGDMS3ap9T3Z/20v/M7FEsj7a62QMe1jV1EsjG
 Ih/6qA0i4g0+vETpU+cFFpevkNlTpPlUoSN/FCuNCROVVVqx4pWIhRSa09ZDWr6sNC3S
 qlhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129188; x=1793733988;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4cEwCCl5DWrg301CzCKNGn18H8JUDg/M9i155OIZYCM=;
 b=HVuIZu7IcdAGOXm434DAo0p7j27kTvInt4EKgqTZjjpjzTNhqo/x09LabmTYFr0vmz
 Xc06nmUpCEU4RdblzT2DDdyAyHfx+2EHDunchuBWUiB3SY10YImxQUMl89VyfGIxnOu2
 P1YPP1il/0iriGa2hrqsKB0AX97B5zIKv9sZ6JP8nUMmk2KKvACHkgBDUeqtkyFC58FE
 A7O3/2Ia89Fod7X31Cmu1jaRM+7YNHzsg88aHOUQYNHGLb/P7XrZ1l5fIvvMcLtZ8BZd
 xRKVrLeidyQzlo6dAGXGPv2Y1NahezXO+F3CxssyXSzRx7SyTUhNrTtPd337Su7qHBAt
 rnaQ==
X-Gm-Message-State: AFq9FYLXktqsbW2P2v/pXYn3bezPceFdCjajxHUvuWX+Wf5qGhkUuolP
 R2Pxo9hXDvOprv/HG4RjVgeBFYIOgkSq2rJwnk6mLD+Os5GIJm+ktfZpfd0GGdoFMxFQpMZwZKD
 iaxFfGurfyQ/0hWegS/bz/W+1LCq9YfquQCJdZkmNx9/HftJApfcKjSoJLHWmkKKZyA==
X-Gm-Gg: AYBFou2GPDnD9RYQ270ZW7Eem4gV0dBmgnoYUCzE0PaxfIb09Gllbs48cNu6Pn/r7Tt
 +GUqzB3OCc5LVcPCjZ5behqozhdnj08DEO4yCnULykIV10hfgKH3b/sYGJA1D9/rGsrLEMY/tW+
 AZLz+9rEPxz+EeEidAhk5ZSLcSReqCXJsweCqAdws30qSmUvg8K74+M7mKixFCfvt2W4ctWpcMF
 eA9SZW/BXhLxhYXpKLly05F7qggpSaMttwnX58gdBbtwD1NtmIb51IpDO3TnTs/jLsuQna0/aQj
 yudSVppH08wiI8zhXNUKTNQ0VoPcyu9betAbIQHsJQ7LcmLUiWxPhXyunGMm7ubXt+Szq/nToKk
 4jwGyL8J4K7in8eEqujlAOLx4cqeEPHOf9+nzoeMq6zRErP9GsQ46pmDi
X-Received: by 2002:a05:620a:c50:b0:93e:746e:235c with SMTP id
 af79cd13be357-940ef915dabmr1552105885a.15.1793129188154; 
 Tue, 27 Oct 2026 12:26:28 -0700 (PDT)
X-Received: by 2002:a05:620a:c50:b0:93e:746e:235c with SMTP id
 af79cd13be357-940ef915dabmr1552103385a.15.1793129187605; 
 Tue, 27 Oct 2026 12:26:27 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94c02115dsm3589655e9.1.2026.10.27.12.26.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:26:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 24/59] Kconfig: Extract config IMX_GPCV2 from config IMX
Date: Tue, 27 Oct 2026 20:23:05 +0100
Message-ID: <20261027192341.9197-25-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Yze28ZRjIC4xpQU_Rb_LQaLmgv0gQHjO
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fae4 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=FRSEYCzRAAAA:8 a=mp_0PXW2FjX-tl9Z7UgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX+ZN9VFH3Tws7
 Xudq1luU4pDhgouLHIWuLfJ/I0/vCIM5Mmoeh6CTVoNeEo+u/SXAQ7+NZp9lms3Nwxe/faPyh1d
 S3JuWNZbUonT3wmx2a9veEiwNmWXrM0=
X-Proofpoint-GUID: Yze28ZRjIC4xpQU_Rb_LQaLmgv0gQHjO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfXxDh402CixVxN
 Nj4YZodkdPCXJNZ7d5sZJbxMa+BJ6Z94RnNihElUp3N5A0OgW/4hovwRgDALTfCh7nwmtBaBMvg
 28l5maH2Bwt9DFs3LfOsiMjgwfbTUqGzfuOTyLp/QuVjZwlOdAz7Ui4F0huQlg/Mo9Cvh2F7pja
 yCV5wwuL317SDSdeJC/xFKjb2JbyGDZUv/5OeZ5tSBzjSdjvPNvT6aHpYW5LBNQcZup46ZojQwn
 WoGbvVegC5XxfMruKhALHpsQ+Kx0ASXz6Kls9N9IMl7sAUgmQZMZpuOXkwvKnY/bnw22KQI+0NL
 HBm5wK00EyYd6Zwfd0kk97Ska8lc0NCDitFC7DujFmzq7DImb6jsqOVURV9wc+HPvzeH98hl0IP
 tCsDkM83zVBcKrjEvoBimstoJ7HtmUE+985ZK0l7M97KO+ytweSsqWFO9EkPzDXQRAMS18cMwfv
 9cU0BAArjIXOF8VDfJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
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
config IMX_GPCV2 to eventually eliminate config IMX.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20261006083445.30362-20-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/Kconfig      | 2 ++
 hw/intc/Kconfig     | 3 +++
 hw/intc/meson.build | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2b7547cf3de1..45a67b1ae6c2 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -581,6 +581,7 @@ config FSL_IMX7
     select PCI
     select IMX
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select WDT_IMX2
     select PCI_EXPRESS_DESIGNWARE
@@ -662,6 +663,7 @@ config FSL_IMX6UL
     select IMX
     select IMX6UL_LCDIF
     select IMX_FEC
+    select IMX_GPCV2
     select IMX_I2C
     select IMX_USBPHY
     select WDT_IMX2
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 97355f9df78f..98dba7efb865 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -8,6 +8,9 @@ config I8259
 config IMX_AVIC
     bool
 
+config IMX_GPCV2
+    bool
+
 config PL190
     bool
 
diff --git a/hw/intc/meson.build b/hw/intc/meson.build
index 74d84b8ddcd7..2ac575095f08 100644
--- a/hw/intc/meson.build
+++ b/hw/intc/meson.build
@@ -24,7 +24,7 @@ system_ss.add(when: 'CONFIG_GOLDFISH_PIC', if_true: files('goldfish_pic.c'))
 system_ss.add(when: 'CONFIG_HEATHROW_PIC', if_true: files('heathrow_pic.c'))
 system_ss.add(when: 'CONFIG_I8259', if_true: files('i8259_common.c', 'i8259.c'))
 system_ss.add(when: 'CONFIG_IMX_AVIC', if_true: files('imx_avic.c'))
-system_ss.add(when: 'CONFIG_IMX', if_true: files('imx_gpcv2.c'))
+system_ss.add(when: 'CONFIG_IMX_GPCV2', if_true: files('imx_gpcv2.c'))
 system_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic_common.c'), if_false: files('ioapic-stub.c'))
 system_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_intc.c'))
 system_ss.add(when: 'CONFIG_OPENPIC', if_true: files('openpic.c'))
-- 
2.55.0


