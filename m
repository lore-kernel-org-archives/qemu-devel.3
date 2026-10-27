Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68506606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 19:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XDKDu/fA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XqOmIj2S
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLmqs-0003c7-2I; Tue, 27 Oct 2026 15:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqE-00031m-0Y
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:24 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLmqB-0002Mf-Fa
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 15:28:13 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RIHrlC1459821
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /wPjkHgW9wVwXB04Sr9QnRNc+JYiq3caa9eHemufq9U=; b=XDKDu/fAr+TaCNpW
 jiTIzMRzOw/2vGgR4nb2wHruAsEa0BNU/jGyIArw8AfZw5kJUkNHgyBskfnbtv//
 UPLMHHOkCmRVbQ7pRh5jwWYgQrZqLBZgA49piCYBQiDW6X5lq0838B338Pnii0Bz
 TsChJIvLU4GNmPQI8LigkHa3XadDAEEPBevVH0wZaFpp3wCj0A11aGNGZItR3ufQ
 Ex4/H56L+oo3pjpEXloyIsgCJikIgLcQrcUL8r8FcHkcTanBHu1dBo491b+XWu3U
 y9A7kNfo9sgtNh/KxJW0SCkjQVUdGGgumpusOZrJep7mlmEMCQEHPFUisFDDuEEv
 C+T5wA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy710vg1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 19:28:09 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91c7a1a32a5so6778866d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 12:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793129289; x=1793734089; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wPjkHgW9wVwXB04Sr9QnRNc+JYiq3caa9eHemufq9U=;
 b=XqOmIj2Se2sKa+/mBt73kR7BNblELxobgEPBVUeBc6pBvWxCT1GiuJU7GDyGPcZSBV
 6yCexSY2JcfMtOF2O+ByAoGjLdlIIT21JwNGUwjKbGLSkVGw0Eh61HHK8U/6lD19vk3T
 ShE8ky7X9Z70DEo2yadXj1XihMKd6FTgZ8b0aZU8W22cuxy8wrp/3lwx3qxclHwQQOEY
 dXetqlxnzrN+DGX6vcKKMG2B6AHhPvPhCh5HopApy8PsdnKPaWEcexKB9cdogu378umS
 0HdKhI3iXRs18BcpB1Em8mHEHiI9mGHRmYVs5VyKV2boTNartDW7ZpoBt1i8pruMyUhY
 CmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793129289; x=1793734089;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/wPjkHgW9wVwXB04Sr9QnRNc+JYiq3caa9eHemufq9U=;
 b=KHQiCRkv7QIhPPwgmEfquB8+NkjRfofQQaugpQz1izECiWXd/d8Zy0W4AlOwuLzJ4M
 LQ04ubtwP7zm33HA9In5lqwaM6scTUf2YSgl8oViQRm8w8c4ce9WvOxE8y3J46xXSyNS
 ee4+CfR0cjKw7uPS1mcKd0Xt9j7wS7uK0u0+/ebBiskM8p19bTrURyGfBo9Mhv1J8IAv
 qRT0CRnjIvwfDpryRIwK2jmRXMe4qvmSgiWSWQ6UxI4jjxOA1sE2YcIeLe8QI+vMEDoy
 0RCbFmYqfpLAJlz0PqUVN+pEJJIpaAvU8Fanz/i03mpfuwivxgsyLO0OE6wY2M5lXqYD
 JeCA==
X-Gm-Message-State: AFq9FYKe+84v0NFo5aDYhZcuhGrusjQUzBOezg98gXarsIz8qnJoIlTn
 LpNIZbk+JERxk0DF1gqtJmRI1pycqYWS3UnQQIIz80yx5Dy3lc0cU9NB2p/V9FioyfpwmXvgwSa
 UZk62juu2Trums/pzvMgBVxiPCYzL2GFbHic+c2lrMfaR+q8mdm49xmexc0DkTd1lbQ==
X-Gm-Gg: AYBFou2V0jsmXudw77Jd2UsXzV2kg6wcCvzuMAcACL2LlZgLUfXvmy6tI/Q/j9xaNr5
 ocwEfu6CIwuQV9fAIGPDBYBtpKK/c1KKGLSLrt6IpRkfnZTuSKVhf/XiOfV0P+CmaWs4eTPDymS
 0NPKSqRnmiKuF1i5i9F9BZjLCABrwk5qOMMNpdkJEHZmGK4OxrQIWAvVC6JATaHkNjRRbQ2aJoC
 UnUbwcrhXvZ4QW8NQjulKmkg3OiQlyEbAOxwLZOJt+E24njah8lAYxoAN0KaNpe9TZNVqgIIHGy
 CdLB+Qk0gaOyHr0CJbDDutVXqoN77PmTV54v2ixZjEXnljf9rVGbmBsSEMH9z7KQ0+wFP79Luuz
 ykePLPbbSLCAj5Uoha4hy4VyE0E1KDgeyxR4hk9fYXh0RYT7Tk0zO1KdK
X-Received: by 2002:a05:620a:4714:b0:93f:2985:40d0 with SMTP id
 af79cd13be357-940ef92abebmr1791262985a.34.1793129288972; 
 Tue, 27 Oct 2026 12:28:08 -0700 (PDT)
X-Received: by 2002:a05:620a:4714:b0:93f:2985:40d0 with SMTP id
 af79cd13be357-940ef92abebmr1791257685a.34.1793129288469; 
 Tue, 27 Oct 2026 12:28:08 -0700 (PDT)
Received: from localhost.localdomain (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a94fce50a8sm1821895e9.4.2026.10.27.12.28.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 27 Oct 2026 12:28:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/59] hw/char/imx_serial: Avoid casting from void *
Date: Tue, 27 Oct 2026 20:23:20 +0100
Message-ID: <20261027192341.9197-40-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261027192341.9197-1-philmd@oss.qualcomm.com>
References: <20261027192341.9197-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX1Tdm2QBjC6ga
 bob1LNSqWZtd2YfnA4bi9/gFCAa70eTXBbYDgEpcwlzcmA31tuNFDidMBxh0IsQP3gdTxaAXC6w
 AXVwI+EyQkw6wYaWfW8BGodLRMVVO0iXQnthKLJoeOPs8MeGRJFdHyfz5UQoVhs9D/gfhn7ZSnA
 4rQjlKZiRfFopfPWNJGRYyNqXf3dwMNKpPGyXpC6LHMSXRImOKrKtTIsRCTUII2MTo6MiiRVEV+
 IYUzHFjxulraBRJelsIw9gFU4dpiSY/dDIlI55ay0HN39ELxVZJg56/H0g1dY1zAdt++5buqzy5
 YXVUQw98U51g/Pqms1E3oCW18sB8xqKQI3ccMyI4+uKEH+AKieO/kzhZsXuiRg5qMPrAYSuFAsx
 DACLny+8/TE36pOAyg34bLZrWSk5PaFKOnh0Wjds9LpYUKrezHFZz+DYq2DGnpJTV2+ul4ThZRL
 CSdsLPYI3FmGri+XKJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3OCBTYWx0ZWRfX7lAtcvIoR91K
 VsNUPEjfSvheEZ4isdhLY66MpV2ZT1Rb9YLyMRndF81pXoqh3fgqb3wF8gL6dzhZO3vH3vBBSmY
 0uIsTF5cTeyffsZ13+fpELU3rlNkePc=
X-Authority-Analysis: v=2.4 cv=JspkP84C c=1 sm=1 tr=0 ts=6ae0fb49 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=BfiHqgA561l1T9IiZdQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: tqevnJS1hUXozHDke3OLYtgg1o7dWjjv
X-Proofpoint-ORIG-GUID: tqevnJS1hUXozHDke3OLYtgg1o7dWjjv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
Message-ID: <20260921214710.29422-37-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/char/imx_serial.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
index 8ac4efbb5e98..8780678ea4be 100644
--- a/hw/char/imx_serial.c
+++ b/hw/char/imx_serial.c
@@ -186,7 +186,7 @@ static void imx_serial_reset_at_boot(DeviceState *dev)
 static uint64_t imx_serial_read(void *opaque, hwaddr offset,
                                 unsigned size)
 {
-    IMXSerialState *s = (IMXSerialState *)opaque;
+    IMXSerialState *s = opaque;
     Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     uint32_t c, rx_used;
     uint8_t rxtl = s->ufcr & TL_MASK;
@@ -277,7 +277,7 @@ static uint64_t imx_serial_read(void *opaque, hwaddr offset,
 static void imx_serial_write(void *opaque, hwaddr offset,
                              uint64_t value, unsigned size)
 {
-    IMXSerialState *s = (IMXSerialState *)opaque;
+    IMXSerialState *s = opaque;
     g_autofree char *label = qemu_chr_fe_backend_name(&s->chr);
     unsigned char ch;
 
@@ -386,14 +386,14 @@ static void imx_serial_write(void *opaque, hwaddr offset,
 
 static int imx_can_receive(void *opaque)
 {
-    IMXSerialState *s = (IMXSerialState *)opaque;
+    IMXSerialState *s = opaque;
 
     return s->ucr2 & UCR2_RXEN ? fifo32_num_free(&s->rx_fifo) : 0;
 }
 
 static void imx_put_data(void *opaque, uint32_t value)
 {
-    IMXSerialState *s = (IMXSerialState *)opaque;
+    IMXSerialState *s = opaque;
     Chardev *chr = qemu_chr_fe_get_driver(&s->chr);
     uint8_t rxtl = s->ufcr & TL_MASK;
 
@@ -416,7 +416,7 @@ static void imx_put_data(void *opaque, uint32_t value)
 
 static void imx_receive(void *opaque, const uint8_t *buf, int size)
 {
-    IMXSerialState *s = (IMXSerialState *)opaque;
+    IMXSerialState *s = opaque;
 
     s->usr2 |= USR2_WAKE;
 
-- 
2.55.0


