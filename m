Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A84606A31F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YYb1mx4o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aofMkFSt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmrF-0003zZ-R3; Tue, 27 Oct 2026 15:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqS-00036w-Hu
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqP-0002Ni-9J
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:26 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHrFF2960671
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aVHtcDzQoKWY9ebfAxKY/sSDNQ1or6DjRqUGLE5mG2o=; b=YYb1mx4oW6eVEBDP
 8smkXkZ11p59P+GeTnzlIdzyDr5+G+S9lYYDltJvy9F08N8E0pNRJWvg/nTcnJFY
 WLdygmfDcmiYaIO4/JfUxQeLl4gA9DN8hZc1w+NLi9Ju1QyQHGGDoDNDtZIYkCcg
 K9/FlEGhEFBueZZGXeyAnhPgBY20hCUP65sQKiCQYLG3DGFjGPj3LS/IDStFDqfW
 Sm3rHlSuM3/c5ZxQxqtbeah/Eka3Zdrqtt78yR2GvTRTGEymgfXBxRHJPdkGt9Ih
 veJPIfJml9LqBOTzrCj0nvojdGxHsaZlH9fdc4CG/NB3xAjU8FPNO3dhzmJcuOOC
 NzpsjQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670vfp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:23 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f3969a2a7so20148385a.2
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129302; x=1793734102; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aVHtcDzQoKWY9ebfAxKY/sSDNQ1or6DjRqUGLE5mG2o=;
 b=aofMkFStV6xlqRSQw8n7KWf79+tlCQyWuwOWIYCfqImcMZjBUnf9+T+XuJZGZjmLpW
 dbHAfOwZDwKl1BOzEA1UyXRgPT15vtHgWzaeoeK5lB3l+VPTXMAVITZSQ2Q+yEaNMq16
 2r+30cGed4Dyuxbw4nkWkW7g5ZIeA5hvkyxGnxHNvMtp7j2bpnJP4+C5n5XammB8jsdu
 A+0+fGd5eGcKH2tlMthMUKb0xMDY7yHqQD2vKa6nhkMWCJ206Y+lU+/Foh/v6+gcdhUs
 PyccgakItuq9M0OXgynGDsGm1kivt6vrHFo4UXk7hBccwBTcX2bufC1FpuEOIAUAZD4W
 qq4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129302; x=1793734102;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aVHtcDzQoKWY9ebfAxKY/sSDNQ1or6DjRqUGLE5mG2o=;
 b=b03j3oIIOrtzpKNOf/FG/p/K/HW54V7dnw98tXWTc7kewKQ2YmcWLcHV8kvMykkQht
 JUEt67PE8MOjrrsVyscuuU8mqoK1oKIPS+a3TXbAQjbDcwEck0qMCIrE4nOYHJyAanHu
 mWS+KZhyomDwq8VvpzyhH748SNogzkNdBZhNRb0K3HXGAzgKhM42maaZKfEUcekGybrg
 P0MfwMQVxeEPAVKq6rLqm32WT+Ybjv/Wu31L3uHD7ypEHPx/qFnhLt26ban2HirCMI19
 i6jNATBUnP/gve7qrsRp2vHRw/nhBNO2KJSJJmJKfdK2OICR/JF+nPv5/NftqkbEKTRB
 165A==
X-Gm-Message-State: AFq9FYKh7CjYdx385W49dMzrOGPdiJYxWkj/xRvteYEDiwE8abuLmtxO
 iCD0Me8t41Z2aQy7qLmEEgPUGbE0GpvpfvX1B2dw5goy9q3sZoa1j0yxmLFrV86lnHPLjMp5LKx
 IRZgWO/rTkdXWLmyEOVzTSnZyF1KWTbETC2/7+kyxXavsneyKQ12Yt/PXXWOara7j0Q==
X-Gm-Gg: AYBFou3jCF14NvAk4JsXCP6hu0KQ5iWHkvb1iBvUu+ChctJiMUdIUHSXQI2srtEx5XH
 CUz0wNe/R/vw+nrXeoZWi4s7F/mkAOlaaR07VLc6ujOaD8ZUvh03Xb9Y/q2qPP3alYtstOrczFL
 MKdrUBPNG0cSx2Qo+5/9zI3UXxwR5OUHckeDrqQJMy4r4H42SWBq5aPShMBAXL6soIfICR++aDw
 cWs1zsj6T1J3WVmILbk3EdueiauBLvpcRB0X5fnSno/9AkFSyokHfbPpAaSJDA1orshcNe7O+OH
 70OXmkh58oqDLAhBXDzKA3A3+Qj6g57mnzA7AKlp6xs2Jv38Z3rK7xyA7HpNUtg+jYDX9UOi2hf
 1mvuKHM5cDEcH2ROgB9wX+OY6FRrCOrZCNWW34DdJH1iwHrCM83vNmhKDj4g8bOWa1NdhZ10Sx3
 Wps2ge/N7UKJc7+19JpM8CxxcEo6ERmQ==
X-Received: by 2002:a05:620a:4385:b0:93c:70da:e45e with SMTP id
 af79cd13be357-940ef94005bmr1543500185a.36.1793129302381; 
 Tue, 27 Oct 2026 12:28:22 -0700 (PDT)
X-Received: by 2002:a05:620a:4385:b0:93c:70da:e45e with SMTP id
 af79cd13be357-940ef94005bmr1543497385a.36.1793129301868; 
 Tue, 27 Oct 2026 12:28:21 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94ec845d0sm2506745e9.13.2026.10.27.12.28.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 41/59] hw/misc/imx*_ccm: Avoid casting from void *
Date: Tue, 27 Oct 2026 20:23:22 +0100
Message-ID: <20261027192341.9197-42-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pv4STZQjDx_9DQ-EjAVVTUtdOVA43FqB
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0fb57 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Gluuv57YqANPM52PeZoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX32o2Y1CYi3eq
 yxPbkHdVfNGqZ0UqndPp6vTAhBga2I4Fn/DXMMSJFxxLYYnDssLfY049pU4e4eg4gUVIVQN6AcT
 octmQ3CUvaWvMNgg3uujsg0Bj57pbSY=
X-Proofpoint-GUID: pv4STZQjDx_9DQ-EjAVVTUtdOVA43FqB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX+LliiofwuJXU
 /PQvi1l0eRt/17jNzetFBfdYUIn3kLC1SZ+qxLrboGEJnoaSjck3ALx3NzJkHZZvIiykmYToVYb
 IN++sj7Vd4OaaQ7J2es23jlqWvNjwrk+jXI26AzqzjTZr5dI7fheZ/FurjZRr33VcEx9/w+Q7Bo
 qufCZEHsFhqtlVi18TaZcLFWlsQZWSMpXpagnfp4dMuuAmyr1pmmmy6v8guYK2TJvr6vsmO65HY
 9m5/QgJCOX6D/YoTNHTbdn2oS0FfmC+Rr9QFeyTPyTF5rV/9WcXjG8jdOlC5I8Mee9G3i1p0GGR
 LYYWJvL5hXOR9ZaAhxWlnKN1D4LIsg2k1l+cuD7stfDVi2GiHypgGH6xl1UokgtHwrHkXyPCJiO
 1UcEiUpPjiin+3ojegJDq/kZ6NTEs2MzTVOQ9C1fiWD/wiMlWzqWPx+xSfApxzdIp+GZmOd5ve/
 M0mGNi8kmlevSxVY91w==
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260921214710.29422-39-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/misc/imx25_ccm.c  | 4 ++--
 hw/misc/imx31_ccm.c  | 4 ++--
 hw/misc/imx6_ccm.c   | 8 ++++----
 hw/misc/imx6ul_ccm.c | 8 ++++----
 hw/misc/imx7_src.c   | 4 ++--
 5 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/hw/misc/imx25_ccm.c b/hw/misc/imx25_ccm.c
index a91b0be68285..8fd2a329ddbc 100644
--- a/hw/misc/imx25_ccm.c
+++ b/hw/misc/imx25_ccm.c
@@ -217,7 +217,7 @@ static void imx25_ccm_reset(DeviceState *dev)
 static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX25CCMState *s = (IMX25CCMState *)opaque;
+    IMX25CCMState *s = opaque;
 
     if (offset < 0x70) {
         value = s->reg[offset >> 2];
@@ -234,7 +234,7 @@ static uint64_t imx25_ccm_read(void *opaque, hwaddr offset, unsigned size)
 static void imx25_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-    IMX25CCMState *s = (IMX25CCMState *)opaque;
+    IMX25CCMState *s = opaque;
 
     trace_imx25_ccm_write(imx25_ccm_reg_name(offset >> 2), value);
 
diff --git a/hw/misc/imx31_ccm.c b/hw/misc/imx31_ccm.c
index 8d620711ddd9..3cb9f44fab82 100644
--- a/hw/misc/imx31_ccm.c
+++ b/hw/misc/imx31_ccm.c
@@ -222,7 +222,7 @@ static void imx31_ccm_reset(DeviceState *dev)
 static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX31CCMState *s = (IMX31CCMState *)opaque;
+    IMX31CCMState *s = opaque;
 
     if ((offset >> 2) < IMX31_CCM_MAX_REG) {
         value = s->reg[offset >> 2];
@@ -239,7 +239,7 @@ static uint64_t imx31_ccm_read(void *opaque, hwaddr offset, unsigned size)
 static void imx31_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                             unsigned size)
 {
-    IMX31CCMState *s = (IMX31CCMState *)opaque;
+    IMX31CCMState *s = opaque;
 
     trace_imx31_ccm_write(imx31_ccm_reg_name(offset >> 2), value);
 
diff --git a/hw/misc/imx6_ccm.c b/hw/misc/imx6_ccm.c
index 45fdd0d5a8d5..4a40fe08ea72 100644
--- a/hw/misc/imx6_ccm.c
+++ b/hw/misc/imx6_ccm.c
@@ -491,7 +491,7 @@ static uint64_t imx6_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     value = s->ccm[index];
 
@@ -504,7 +504,7 @@ static void imx6_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     trace_imx6_ccm_write(imx6_ccm_reg_name(index), (uint32_t)value);
 
@@ -519,7 +519,7 @@ static uint64_t imx6_analog_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value;
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     switch (index) {
     case CCM_ANALOG_PLL_ARM_SET:
@@ -611,7 +611,7 @@ static void imx6_analog_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6CCMState *s = (IMX6CCMState *)opaque;
+    IMX6CCMState *s = opaque;
 
     trace_imx6_analog_write(imx6_analog_reg_name(index), (uint32_t)value);
 
diff --git a/hw/misc/imx6ul_ccm.c b/hw/misc/imx6ul_ccm.c
index c4f6e372fe1c..f12ba6ebe22f 100644
--- a/hw/misc/imx6ul_ccm.c
+++ b/hw/misc/imx6ul_ccm.c
@@ -625,7 +625,7 @@ static uint64_t imx6ul_ccm_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_MAX);
 
@@ -640,7 +640,7 @@ static void imx6ul_ccm_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_MAX);
 
@@ -654,7 +654,7 @@ static uint64_t imx6ul_analog_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value;
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_ANALOG_MAX);
 
@@ -754,7 +754,7 @@ static void imx6ul_analog_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
     uint32_t index = offset >> 2;
-    IMX6ULCCMState *s = (IMX6ULCCMState *)opaque;
+    IMX6ULCCMState *s = opaque;
 
     assert(index < CCM_ANALOG_MAX);
 
diff --git a/hw/misc/imx7_src.c b/hw/misc/imx7_src.c
index 77f13bd020b7..4a59e347c58d 100644
--- a/hw/misc/imx7_src.c
+++ b/hw/misc/imx7_src.c
@@ -105,7 +105,7 @@ static void imx7_src_reset(DeviceState *dev)
 static uint64_t imx7_src_read(void *opaque, hwaddr offset, unsigned size)
 {
     uint32_t value = 0;
-    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    IMX7SRCState *s = opaque;
     uint32_t index = offset >> 2;
 
     if (index < SRC_MAX) {
@@ -167,7 +167,7 @@ static void imx7_defer_clear_reset_bit(uint32_t cpuid,
 static void imx7_src_write(void *opaque, hwaddr offset, uint64_t value,
                            unsigned size)
 {
-    IMX7SRCState *s = (IMX7SRCState *)opaque;
+    IMX7SRCState *s = opaque;
     uint32_t index = offset >> 2;
     long unsigned int change_mask;
     uint32_t current_value = value;
-- 
2.55.0


