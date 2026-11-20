Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6035860A260E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=pQPBAhtw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Rc9MPSar
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSQF-0002tk-UA; Fri, 20 Nov 2026 12:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSQD-0002tH-HZ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:29:13 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSQ9-0003o3-VH
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:29:13 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfSZR304441
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:29:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=K68OlMU+aSviY/3MoK3lsg
 QXt3iLKDDpKUjtlQXWO9k=; b=pQPBAhtw0SA1qJdHgnBYk/pDdlcNkygO7xxoVF
 E6oOE65YmL6HENlg4VfTvH00NvgSKALUzh6WzuHtNTK4mKT7maGWcQ4T3OHolp+V
 nh/4VT1MDiXePeY5j9u2bAzYNuGdL3DyTqu9m7tmMBr30n1GsxVUS2bjVE1Zdzvc
 rf2w0iHiHkXjDcCAMKYde2pi0ImpXYytuQkH8eD0GQGsbnGz7ntVawfrV31pdi04
 YkAEY7GCVDcecxOqNVaTj12YrROfzOSDkUJ+OHpXamaUjqY5RMmsgUS9eJPydvQo
 2rHjdlL6MXbcvSWUV2iOdRZJo55mCHRmJr+mszZ1t7RloqEQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2gu82mcc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:29:07 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-92137a721c7so16961176d6.1
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795195746; x=1795800546; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=K68OlMU+aSviY/3MoK3lsgQXt3iLKDDpKUjtlQXWO9k=;
 b=Rc9MPSar0Sa3o1cCxfwVFKgnBQb0r/B1RRw9/be18/4NHu/18II8Vcum8lxGleeEK5
 Zd03SC9kPczt3a2H2HZt/sgI1d2ax+/kWeYXVY7QnixWMlapmKMZLo7QKj1ANh6/T26E
 DqDsMENNBM6DfV4pubnK0ge0op9TgaheMJjhDEoHq2DZddaq5Ne4SBpAHuNshcnAjA5s
 blH2A59xzFTaZ18y3jvsU3ayeaBJS/NM/FJ4aaClbwkQbiSt4lDK5JAYJD3V8jWzl5Ax
 Hr8vWqZuNjA0hhNan9btZcGAWyu6n8M2uxxXgeKe821rvPHVqRiq3/1YNDSouXb57tfV
 v6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795195746; x=1795800546;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K68OlMU+aSviY/3MoK3lsgQXt3iLKDDpKUjtlQXWO9k=;
 b=Vee2g09qnhf4GeRUh3i7i28eBLyHk0iSsfkoDBQnejREwqkdE0pfxB0F6xVR7b0ZRl
 PTaxPRxQPsoL3hB4ydNi0/qvGLiYJnvfziDgzak/10tEor4hKnp+o4hEaXIhcl+zxzh/
 fS8GbiLh1J+Pt8yiofOxCRBDCnSgYgBbuAK4D4SFwPlEckyBkamNSAtkvAC9vlv4vkm+
 FvujNwB/BtcCoV6PRQoAT1ezH9sVu3BcrRxyCH8UK4zSH0D8Q3tFrmCcNPOKEE6ZxZIL
 HMQrJq7qs5ZivqOTEox3or6Qr/XNUuJNHNYI3CdAqKZCY8Whckpilw9934StVPOF2AHa
 3C+A==
X-Gm-Message-State: APuU4Z8RdBKEuRhI6EOZ2uSqllHo2VFHPYbmcUWavrW4EhsRwdxsMEFs
 ORsA574Vf/OtTyHoMjRLA/yP3nBdldAqO0V7zkJhm4rKMQRaQlS1QA+cp2bSP6CKFRHiAjk0dFY
 WlEggCujXY+eae0phcTp1p/BxtInSpJu/dhrKOrWMtibwHntv33s3wUQw72AYLQxJdw==
X-Gm-Gg: AYBFou0TnGZBnxyoNBpSa++YfnFzcPPLMVLQCvjeki++BRyIp1ZmnvfNIai4KgTSeZA
 DosunUjvm3zqg7RAAjF4uuLx/ujgyryzquwf4rYfsSXfNUVA9MEPM1DtJiZ2fBFszyx130lThJP
 a4TJwLO/QOmvT397YIxrVKz7OO5mWVqrpVbu+jQnlJHnTuno4hXZz+QNyMeaOrq1FhEDArawM9E
 Hu0dcCLhJbQeVyzPXLx3DpyU1b9h3HGtiZsXVXr4YTJyKb+yJdYo3c0NJ0872XrgQw28ypMmbfw
 0SSFiNnlUbgyGdqJmkJ4eikrpem5eOIu0N2h30MfnZkq6ma7SnZz67Wsx3/w9j4BThZP/HhQRND
 EBdVSuFvcoZ1LI/OigWyc4HVQ1dRJCi8wOi74SqvOe18I264WFoRfey7vz+NEuN9bNqUE2uYxHY
 pRCjFlQdF38wLx6A==
X-Received: by 2002:a05:620a:1b89:b0:945:f28f:ce92 with SMTP id
 af79cd13be357-949ba9b0744mr594792485a.40.1795195745673; 
 Fri, 20 Nov 2026 09:29:05 -0800 (PST)
X-Received: by 2002:a05:620a:1b89:b0:945:f28f:ce92 with SMTP id
 af79cd13be357-949ba9b0744mr594786285a.40.1795195744880; 
 Fri, 20 Nov 2026 09:29:04 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm6745374f8f.47.2026.11.20.09.29.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:29:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Ensure VMStateField compound literals are const
Date: Fri, 20 Nov 2026 18:29:02 +0100
Message-ID: <20261120172902.63398-1-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfXydqBpMWGT3ae
 fI0XVAtknVu70+oyu+0vb40qUQUheO+3/wkstSbK3RI7ENkAMuUJ0jl049MhGFYHlsGiJsXgnXO
 oL2M6wFUbaKbIobwK4+EFW92CJZbZJ2kK6wPeA1LQ8gDbW3w0zkQTGNKqFWR4DaPu5r8oe5Z/U4
 6c2sqBo8vGPebzECufRswbEtkYI1G/R7pSbbD2vhMfH0AKOleOWf815AdP5CaST07hFd1mTjgRk
 eIjkr0KsnnSvsxbgZU5B9bq3IjtSs63XXUpD10N8Mmc5qgkcnndPB6tvu9rbf4Dlv0C0v6JHP58
 moYkoqAPLQjK5uLbz2TPH7AV+w79eTn5RcViKFiuDWbRsYYcQIsLm/jMNIDA8tAlPZGxm9cZjOC
 py/RxKuuM4C21wUwwqzR2GNw8GtSALxbPbDN9H35W6s6rBsGC+ruDwAvoZDN/RjoY9k/ZboaNkA
 Ru/Fbh1rXCR2mb5CFdw==
X-Authority-Analysis: v=2.4 cv=bLeDs/+Z c=1 sm=1 tr=0 ts=6b008363 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ebuZ08BYedcQcWoC4xIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: MzrMrAWJcMxhwwTtarw6ascFxpxk7EVg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OSBTYWx0ZWRfX/+zp443T67ev
 V00YrOSSnNXR0dtCQRf8HNBv3cFZTU1gt9xYc2HTT9LolhrVuxuirJPl7EnholI6T6htbI0gTMt
 F66NkdksDI0Y7KUlgQRIUwpgNNuVqLI=
X-Proofpoint-GUID: MzrMrAWJcMxhwwTtarw6ascFxpxk7EVg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611200069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Since commit 03fee66fde3f ("vmstate: constify VMStateField")
VMStateDescription::fields takes a const VMStateField *, and
the API has expected const-qualified compound literals ever
since. Still various files declare non-const (VMStateField[])
literals, forcing the linker to place these tables in .data
instead of .rodata.

Convert the remaining (VMStateField[]) compound literals to
(const VMStateField[]) so the arrays can live in read-only
sections.

Teach checkpatch.pl to reject new non-const VMStateField[]
compound literals, so this stays fixed.

Inspired-by: John Snow <jsnow@redhat.com>
Fixes: b75d9bef4a13 ("hw/misc: Add LTPI controller")
Fixes: d447e4b70295 ("MAX78000: UART Implementation")
Fixes: 23c82c1daf30 ("hw/gpio: Add BCM2838 GPIO stub")
Fixes: 3d107d36f99c ("hw/net: Add NPCM8XX PCS Module")
Fixes: 90ca4e03c27d ("hw/uefi: add var-service-core.c")
Fixes: 08f787a34cbe ("hw/net: Add NPCMXXX GMAC device")
Fixes: d9fa4223b30a ("vfio: register container for cpr")
Fixes: 034cb968ca8f ("hw/uefi: add var-service-policy.c")
Fixes: 1cdcfb6e936c ("hw/gpio: Implement STM32L4x5 GPIO")
Fixes: b935def0f8a0 ("hw/misc: Add basic Aspeed PWM model")
Fixes: 20936684b6dd ("hw/misc: Implement STM32L4x5 SYSCFG")
Fixes: 5bb89df2e373 ("hw/uefi: add uefi-vars-sysbus device")
Fixes: 04f398b2a25d ("hw/intc: Add l2vic interrupt controller")
Fixes: 6328d8ffa6cb ("misc/pca955*: Move models under hw/gpio")
Fixes: 54857b08168a ("vfio/container: register container for cpr")
Fixes: 9f38a8e6570c ("hw/misc/bcm2838_rng200: add BCM2838 RNG200")
Fixes: 4fb37aea7e01 ("hw/char: Implement STM32L4x5 USART skeleton")
Fixes: fcf5ef2ab52c ("Move target-* CPU file into a target/ folder")
Fixes: 0cf4a87966da ("hw/misc: Add RISC-V CPC device implementation")
Fixes: ebb62075021a ("hw/acpi: Add ACPI Generic Event Device Support")
Fixes: 9b3eb0e2db02 ("hw/i3c: Split DesignWare I3C out of Aspeed I3C")
Fixes: 376b851909d4 ("hppa: Add support for LASI chip with i82596 NIC")
Fixes: 290a1f174ee0 ("hw/misc: Add RISC-V CMGCR device implementation")
Fixes: 9ce93b74cdc0 ("ncr710: Add driver for the NCR 53c710 SCSI chip")
Fixes: 7d0f982bfbb9 ("qapi: generate a literal qobject for introspection")
Fixes: 325d1c934448 ("hw/sensor: adc128d818: add 12-bit 8-channel ADC device")
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/acpi/generic_event_device.c |  2 +-
 hw/char/max78000_uart.c        |  2 +-
 hw/char/stm32l4x5_usart.c      |  2 +-
 hw/gpio/bcm2838_gpio.c         |  2 +-
 hw/gpio/pca9554.c              |  2 +-
 hw/gpio/pcf8574.c              |  2 +-
 hw/gpio/stm32l4x5_gpio.c       |  2 +-
 hw/i386/amd_iommu.c            |  4 ++--
 hw/i3c/dw-i3c.c                |  2 +-
 hw/intc/hex-l2vic.c            |  2 +-
 hw/misc/aspeed_ltpi.c          |  2 +-
 hw/misc/aspeed_pwm.c           |  2 +-
 hw/misc/bcm2838_rng200.c       |  2 +-
 hw/misc/riscv_cmgcr.c          |  2 +-
 hw/misc/riscv_cpc.c            |  2 +-
 hw/misc/stm32l4x5_exti.c       |  2 +-
 hw/misc/stm32l4x5_rcc.c        |  6 +++---
 hw/misc/stm32l4x5_syscfg.c     |  2 +-
 hw/net/i82596.c                |  2 +-
 hw/net/npcm_gmac.c             |  2 +-
 hw/net/npcm_pcs.c              |  2 +-
 hw/scsi/ncr53c710.c            |  6 +++---
 hw/sensor/adc128d818.c         |  2 +-
 hw/uefi/var-service-core.c     |  2 +-
 hw/uefi/var-service-policy.c   |  2 +-
 hw/uefi/var-service-sysbus.c   |  2 +-
 hw/uefi/var-service-vars.c     |  6 +++---
 hw/vfio/cpr-iommufd.c          |  4 ++--
 hw/vfio/cpr-legacy.c           |  2 +-
 hw/vfio/cpr.c                  |  4 ++--
 target/arm/machine.c           |  2 +-
 target/i386/machine.c          | 10 +++++-----
 target/ppc/machine.c           |  2 +-
 scripts/checkpatch.pl          |  6 ++++++
 34 files changed, 52 insertions(+), 46 deletions(-)

diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 65a5d1612fa4..fe6cfd62f5ba 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -391,7 +391,7 @@ static const VMStateDescription vmstate_cpuhp_state = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cpuhp_needed,
-    .fields      = (VMStateField[]) {
+    .fields      = (const VMStateField[]) {
         VMSTATE_CPU_HOTPLUG(cpuhp_state, AcpiGedState),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/char/max78000_uart.c b/hw/char/max78000_uart.c
index 85fc6eed3e5e..9e8e110f888a 100644
--- a/hw/char/max78000_uart.c
+++ b/hw/char/max78000_uart.c
@@ -217,7 +217,7 @@ static const VMStateDescription max78000_uart_vmstate = {
     .name = TYPE_MAX78000_UART,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(ctrl, Max78000UartState),
         VMSTATE_UINT32(status, Max78000UartState),
         VMSTATE_UINT32(int_en, Max78000UartState),
diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
index c4ffc0d6ce52..00268aa3b0ed 100644
--- a/hw/char/stm32l4x5_usart.c
+++ b/hw/char/stm32l4x5_usart.c
@@ -567,7 +567,7 @@ static const VMStateDescription vmstate_stm32l4x5_usart_base = {
     .version_id = 1,
     .minimum_version_id = 1,
     .post_load = stm32l4x5_usart_base_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr1, Stm32l4x5UsartBaseState),
         VMSTATE_UINT32(cr2, Stm32l4x5UsartBaseState),
         VMSTATE_UINT32(cr3, Stm32l4x5UsartBaseState),
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 4ae7706b9a0f..025b334c7045 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -327,7 +327,7 @@ static const VMStateDescription vmstate_bcm2838_gpio = {
     .name = "bcm2838_gpio",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(fsel, BCM2838GpioState, BCM2838_GPIO_NUM),
         VMSTATE_UINT32(lev0, BCM2838GpioState),
         VMSTATE_UINT32(lev1, BCM2838GpioState),
diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
index 07bb00babf63..eb2e28f3259f 100644
--- a/hw/gpio/pca9554.c
+++ b/hw/gpio/pca9554.c
@@ -244,7 +244,7 @@ static const VMStateDescription pca9554_vmstate = {
     .name = "PCA9554",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, PCA9554State),
         VMSTATE_UINT8(pointer, PCA9554State),
         VMSTATE_UINT8_ARRAY(regs, PCA9554State, PCA9554_NR_REGS),
diff --git a/hw/gpio/pcf8574.c b/hw/gpio/pcf8574.c
index f871f1e78809..64831ef5f0f2 100644
--- a/hw/gpio/pcf8574.c
+++ b/hw/gpio/pcf8574.c
@@ -104,7 +104,7 @@ static const VMStateDescription vmstate_pcf8574 = {
     .name               = "pcf8574",
     .version_id         = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_I2C_SLAVE(parent_obj, PCF8574State),
         VMSTATE_UINT8(lastrq, PCF8574State),
         VMSTATE_UINT8(input,  PCF8574State),
diff --git a/hw/gpio/stm32l4x5_gpio.c b/hw/gpio/stm32l4x5_gpio.c
index e3e5bc46e77d..4b0b5e9fee9e 100644
--- a/hw/gpio/stm32l4x5_gpio.c
+++ b/hw/gpio/stm32l4x5_gpio.c
@@ -430,7 +430,7 @@ static const VMStateDescription vmstate_stm32l4x5_gpio = {
     .name = TYPE_STM32L4X5_GPIO,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32(moder, Stm32l4x5GpioState),
         VMSTATE_UINT32(otyper, Stm32l4x5GpioState),
         VMSTATE_UINT32(ospeedr, Stm32l4x5GpioState),
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index be4b9b28ef60..a127e688ce76 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -2623,7 +2623,7 @@ static const VMStateDescription vmstate_xt = {
        .name = "amd-iommu-xt",
        .version_id = 1,
        .minimum_version_id = 1,
-       .fields = (VMStateField[]) {
+       .fields = (const VMStateField[]) {
            VMSTATE_BOOL(xten, AMDVIState),
            VMSTATE_BOOL(intcapxten, AMDVIState),
            VMSTATE_END_OF_LIST()
@@ -2635,7 +2635,7 @@ static const VMStateDescription vmstate_amdvi_sysbus_migratable = {
     .version_id = 1,
     .minimum_version_id = 1,
     .priority = MIG_PRI_IOMMU,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
       /* Updated in  amdvi_handle_control_write() */
       VMSTATE_BOOL(enabled, AMDVIState),
       VMSTATE_BOOL(ga_enabled, AMDVIState),
diff --git a/hw/i3c/dw-i3c.c b/hw/i3c/dw-i3c.c
index 6386499dd9fc..78b65f84d71e 100644
--- a/hw/i3c/dw-i3c.c
+++ b/hw/i3c/dw-i3c.c
@@ -1767,7 +1767,7 @@ const VMStateDescription vmstate_dw_i3c = {
     .name = TYPE_DW_I3C,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]){
+    .fields = (const VMStateField[]){
         VMSTATE_UINT32_ARRAY(regs, DWI3C, DW_I3C_NR_REGS),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/intc/hex-l2vic.c b/hw/intc/hex-l2vic.c
index 93fbb7449e88..81748aede1d6 100644
--- a/hw/intc/hex-l2vic.c
+++ b/hw/intc/hex-l2vic.c
@@ -522,7 +522,7 @@ static const VMStateDescription vmstate_l2vic = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields =
-        (VMStateField[]){
+        (const VMStateField[]){
             VMSTATE_UINT32_ARRAY(vid_group, HexL2VICState, 4),
             VMSTATE_UINT32(vid, HexL2VICState),
             VMSTATE_UINT32_ARRAY(int_enable, HexL2VICState, SLICE_MAX),
diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
index 2e413550b9fd..87e365565f67 100644
--- a/hw/misc/aspeed_ltpi.c
+++ b/hw/misc/aspeed_ltpi.c
@@ -129,7 +129,7 @@ static const VMStateDescription vmstate_aspeed_ltpi = {
     .name = TYPE_ASPEED_LTPI,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(ctrl_regs, AspeedLTPIState,
                              ASPEED_LTPI_CTRL_SIZE >> 2),
         VMSTATE_UINT32_ARRAY(phy_regs, AspeedLTPIState,
diff --git a/hw/misc/aspeed_pwm.c b/hw/misc/aspeed_pwm.c
index dfb93ae7fb81..037817eb2ea9 100644
--- a/hw/misc/aspeed_pwm.c
+++ b/hw/misc/aspeed_pwm.c
@@ -89,7 +89,7 @@ static const VMStateDescription vmstate_aspeed_pwm = {
     .name = TYPE_ASPEED_PWM,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedPWMState, ASPEED_PWM_NR_REGS),
         VMSTATE_END_OF_LIST(),
     }
diff --git a/hw/misc/bcm2838_rng200.c b/hw/misc/bcm2838_rng200.c
index 1b39527cc0ce..b221c4ff4a6a 100644
--- a/hw/misc/bcm2838_rng200.c
+++ b/hw/misc/bcm2838_rng200.c
@@ -64,7 +64,7 @@ static const VMStateDescription vmstate_bcm2838_rng200 = {
     .name = "bcm2838_rng200",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(rng_fifo_cap, BCM2838Rng200State),
         VMSTATE_UINT32_ARRAY(regs, BCM2838Rng200State, N_BCM2838_RNG200_REGS),
 
diff --git a/hw/misc/riscv_cmgcr.c b/hw/misc/riscv_cmgcr.c
index 0390996f78bf..ee6ec6653685 100644
--- a/hw/misc/riscv_cmgcr.c
+++ b/hw/misc/riscv_cmgcr.c
@@ -184,7 +184,7 @@ static const VMStateDescription vmstate_riscv_gcr = {
     .name = "riscv-gcr",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(cpc_base, RISCVGCRState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/riscv_cpc.c b/hw/misc/riscv_cpc.c
index 37fdd0b39ba6..dc413b179f61 100644
--- a/hw/misc/riscv_cpc.c
+++ b/hw/misc/riscv_cpc.c
@@ -230,7 +230,7 @@ static const VMStateDescription vmstate_riscv_cpc = {
     .name = "xmips-cpc",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(vps_running_mask, RISCVCPCState),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/misc/stm32l4x5_exti.c b/hw/misc/stm32l4x5_exti.c
index 8de4568de706..433f84bc02fe 100644
--- a/hw/misc/stm32l4x5_exti.c
+++ b/hw/misc/stm32l4x5_exti.c
@@ -259,7 +259,7 @@ static const VMStateDescription vmstate_stm32l4x5_exti = {
     .name = TYPE_STM32L4X5_EXTI,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(imr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_UINT32_ARRAY(emr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
         VMSTATE_UINT32_ARRAY(rtsr, Stm32l4x5ExtiState, EXTI_NUM_REGISTER),
diff --git a/hw/misc/stm32l4x5_rcc.c b/hw/misc/stm32l4x5_rcc.c
index 85095871340e..3da9e7887d7c 100644
--- a/hw/misc/stm32l4x5_rcc.c
+++ b/hw/misc/stm32l4x5_rcc.c
@@ -129,7 +129,7 @@ static const VMStateDescription clock_mux_vmstate = {
     .name = TYPE_RCC_CLOCK_MUX,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, RccClockMuxState),
         VMSTATE_ARRAY_CLOCK(srcs, RccClockMuxState,
                             RCC_NUM_CLOCK_MUX_SRC),
@@ -281,7 +281,7 @@ static const VMStateDescription pll_vmstate = {
     .name = TYPE_RCC_PLL,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(id, RccPllState),
         VMSTATE_CLOCK(in, RccPllState),
         VMSTATE_ARRAY_CLOCK(channels, RccPllState,
@@ -1345,7 +1345,7 @@ static const VMStateDescription vmstate_stm32l4x5_rcc = {
     .name = TYPE_STM32L4X5_RCC,
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(cr, Stm32l4x5RccState),
         VMSTATE_UINT32(icscr, Stm32l4x5RccState),
         VMSTATE_UINT32(cfgr, Stm32l4x5RccState),
diff --git a/hw/misc/stm32l4x5_syscfg.c b/hw/misc/stm32l4x5_syscfg.c
index 52495610d1b9..e3d8f323d112 100644
--- a/hw/misc/stm32l4x5_syscfg.c
+++ b/hw/misc/stm32l4x5_syscfg.c
@@ -244,7 +244,7 @@ static const VMStateDescription vmstate_stm32l4x5_syscfg = {
     .name = TYPE_STM32L4X5_SYSCFG,
     .version_id = 2,
     .minimum_version_id = 2,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(memrmp, Stm32l4x5SyscfgState),
         VMSTATE_UINT32(cfgr1, Stm32l4x5SyscfgState),
         VMSTATE_UINT32_ARRAY(exticr, Stm32l4x5SyscfgState,
diff --git a/hw/net/i82596.c b/hw/net/i82596.c
index cd7bd0f7fef9..fcaf1d578fc9 100644
--- a/hw/net/i82596.c
+++ b/hw/net/i82596.c
@@ -2170,7 +2170,7 @@ const VMStateDescription vmstate_i82596 = {
     .name = "i82596",
     .version_id = 2,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(mode, I82596State),
         VMSTATE_UINT16(t_on, I82596State),
         VMSTATE_UINT16(t_off, I82596State),
diff --git a/hw/net/npcm_gmac.c b/hw/net/npcm_gmac.c
index d9902d9ab5d4..a7694d75e9f8 100644
--- a/hw/net/npcm_gmac.c
+++ b/hw/net/npcm_gmac.c
@@ -918,7 +918,7 @@ static const VMStateDescription vmstate_npcm_gmac = {
     .name = TYPE_NPCM_GMAC,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, NPCMGMACState, NPCM_GMAC_NR_REGS),
         VMSTATE_END_OF_LIST(),
     },
diff --git a/hw/net/npcm_pcs.c b/hw/net/npcm_pcs.c
index ae078e14c385..8e2cfaffc1e7 100644
--- a/hw/net/npcm_pcs.c
+++ b/hw/net/npcm_pcs.c
@@ -377,7 +377,7 @@ static const VMStateDescription vmstate_npcm_pcs = {
     .name = TYPE_NPCM_PCS,
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(indirect_access_base, NPCMPCSState),
         VMSTATE_UINT16_ARRAY(sr_ctl, NPCMPCSState, NPCM_PCS_NR_SR_CTLS),
         VMSTATE_UINT16_ARRAY(sr_mii, NPCMPCSState, NPCM_PCS_NR_SR_MIIS),
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 57967e7a84f0..9a57270ed2e9 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -2289,7 +2289,7 @@ static const VMStateDescription vmstate_ncr710_scsi_fifo = {
     .name = "ncr710_scsi_fifo",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY(data, NCR710_SCSI_FIFO, NCR710_SCSI_FIFO_SIZE),
         VMSTATE_UINT8_ARRAY(parity, NCR710_SCSI_FIFO, NCR710_SCSI_FIFO_SIZE),
         VMSTATE_INT32(count, NCR710_SCSI_FIFO),
@@ -2301,7 +2301,7 @@ const VMStateDescription vmstate_ncr710 = {
     .name = "ncr710",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(scntl0, NCR710State),
         VMSTATE_UINT8(scntl1, NCR710State),
         VMSTATE_UINT8(sdid, NCR710State),
@@ -2364,7 +2364,7 @@ static const VMStateDescription vmstate_sysbus_ncr710 = {
     .name = "sysbus_ncr710",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(ncr710, SysBusNCR710State, 1, vmstate_ncr710,
                        NCR710State),
         VMSTATE_END_OF_LIST()
diff --git a/hw/sensor/adc128d818.c b/hw/sensor/adc128d818.c
index 4ac7a4393d13..27a25f5bd6b1 100644
--- a/hw/sensor/adc128d818.c
+++ b/hw/sensor/adc128d818.c
@@ -579,7 +579,7 @@ static const VMStateDescription adc128d818_vmstate = {
     .name = "ADC128D818",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8(len, ADC128D818State),
         VMSTATE_UINT8(pointer, ADC128D818State),
         VMSTATE_UINT8(rx_byte, ADC128D818State),
diff --git a/hw/uefi/var-service-core.c b/hw/uefi/var-service-core.c
index 65da71029a60..4e85f51b04f9 100644
--- a/hw/uefi/var-service-core.c
+++ b/hw/uefi/var-service-core.c
@@ -50,7 +50,7 @@ const VMStateDescription vmstate_uefi_vars = {
     .name = "uefi-vars",
     .pre_load = uefi_vars_pre_load,
     .post_load = uefi_vars_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(sts, uefi_vars_state),
         VMSTATE_UINT32(buf_size, uefi_vars_state),
         VMSTATE_UINT32(buf_addr_lo, uefi_vars_state),
diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
index d43cc9b2500b..766e8f37c1ac 100644
--- a/hw/uefi/var-service-policy.c
+++ b/hw/uefi/var-service-policy.c
@@ -34,7 +34,7 @@ static int uefi_var_policy_post_load(void *opaque, int version_id)
 const VMStateDescription vmstate_uefi_var_policy = {
     .name = "uefi-var-policy",
     .post_load = uefi_var_policy_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(entry_size, uefi_var_policy),
         VMSTATE_VBUFFER_ALLOC_UINT32(entry, uefi_var_policy,
                                      0, NULL, entry_size),
diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 656496317b50..b13799a51db3 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -22,7 +22,7 @@ struct uefi_vars_sysbus_state {
 
 static const VMStateDescription vmstate_uefi_vars_sysbus = {
     .name = TYPE_UEFI_VARS_SYSBUS,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_STRUCT(state, uefi_vars_sysbus_state, 0,
                        vmstate_uefi_vars, uefi_vars_state),
         VMSTATE_END_OF_LIST()
diff --git a/hw/uefi/var-service-vars.c b/hw/uefi/var-service-vars.c
index ef8849f81511..123bdff9fbfd 100644
--- a/hw/uefi/var-service-vars.c
+++ b/hw/uefi/var-service-vars.c
@@ -25,7 +25,7 @@
 
 const VMStateDescription vmstate_uefi_time = {
     .name = "uefi-time",
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT16(year, efi_time),
         VMSTATE_UINT8(month, efi_time),
         VMSTATE_UINT8(day, efi_time),
@@ -75,7 +75,7 @@ static bool uefi_vars_digest_is_needed(void *opaque)
 const VMStateDescription vmstate_uefi_variable_digest = {
     .name = "uefi-variable-digest",
     .needed = uefi_vars_digest_is_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(digest_size, uefi_variable),
         VMSTATE_VBUFFER_ALLOC_UINT32(digest, uefi_variable,
                                      0, NULL, digest_size),
@@ -87,7 +87,7 @@ const VMStateDescription vmstate_uefi_variable = {
     .name = "uefi-variable",
     .pre_load = uefi_vars_pre_load,
     .post_load = uefi_vars_post_load,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT8_ARRAY_V(guid.data, uefi_variable, sizeof(QemuUUID), 0),
         VMSTATE_UINT32(name_size, uefi_variable),
         VMSTATE_UINT32(data_size, uefi_variable),
diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
index 6758c73b6b96..c064d6db4c6f 100644
--- a/hw/vfio/cpr-iommufd.c
+++ b/hw/vfio/cpr-iommufd.c
@@ -30,7 +30,7 @@ static const VMStateDescription vmstate_cpr_vfio_device = {
     .name = "cpr vfio device",
     .version_id = 1,
     .minimum_version_id = 1,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT32(namelen, CprVFIODevice),
         VMSTATE_VBUFFER_ALLOC_UINT32(name, CprVFIODevice, 0, NULL, namelen),
         VMSTATE_INT32(devid, CprVFIODevice),
@@ -148,7 +148,7 @@ static const VMStateDescription iommufd_cpr_vmstate = {
     .pre_save = iommufd_cpr_pre_save,
     .post_load = iommufd_cpr_post_load,
     .needed = cpr_incoming_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
index 807ffacdbc9a..dfab326d9b8f 100644
--- a/hw/vfio/cpr-legacy.c
+++ b/hw/vfio/cpr-legacy.c
@@ -125,7 +125,7 @@ static const VMStateDescription vfio_container_vmstate = {
     .pre_save = vfio_container_pre_save,
     .post_load = vfio_container_post_load,
     .needed = cpr_incoming_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_END_OF_LIST()
     }
 };
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 6e1659dcddc1..74c4d48b8569 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -149,7 +149,7 @@ static const VMStateDescription vfio_intx_vmstate = {
     .name = "vfio-cpr-intx",
     .version_id = 0,
     .minimum_version_id = 0,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_BOOL(pending, VFIOINTx),
         VMSTATE_UINT32(route.mode, VFIOINTx),
         VMSTATE_INT32(route.irq, VFIOINTx),
@@ -172,7 +172,7 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .pre_load = vfio_cpr_pci_pre_load,
     .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_incoming_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
         VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, pci_msix_present),
         VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
diff --git a/target/arm/machine.c b/target/arm/machine.c
index c3aef3f33012..15a0ad35bc48 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -315,7 +315,7 @@ static const VMStateDescription vmstate_zt0 = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = zt0_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_ARRAY(env.za_state.zt0, ARMCPU,
                              ARRAY_SIZE(((CPUARMState *)0)->za_state.zt0)),
         VMSTATE_END_OF_LIST()
diff --git a/target/i386/machine.c b/target/i386/machine.c
index b5c6b127c9c5..72eefb6087d4 100644
--- a/target/i386/machine.c
+++ b/target/i386/machine.c
@@ -1614,7 +1614,7 @@ static const VMStateDescription vmstate_msr_hwcr = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = msr_hwcr_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.msr_hwcr, X86CPU),
         VMSTATE_END_OF_LIST()
     }
@@ -1634,7 +1634,7 @@ static const VMStateDescription vmstate_msr_fred = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = intel_fred_msrs_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.fred_rsp0, X86CPU),
         VMSTATE_UINT64(env.fred_rsp1, X86CPU),
         VMSTATE_UINT64(env.fred_rsp2, X86CPU),
@@ -1744,7 +1744,7 @@ static const VMStateDescription vmstate_shstk = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = shstk_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         /* pl0_ssp has been covered by vmstate_pl0_ssp. */
         VMSTATE_UINT64(env.pl1_ssp, X86CPU),
         VMSTATE_UINT64(env.pl2_ssp, X86CPU),
@@ -1771,7 +1771,7 @@ static const VMStateDescription vmstate_cet = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = cet_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64(env.u_cet, X86CPU),
         VMSTATE_UINT64(env.s_cet, X86CPU),
         VMSTATE_END_OF_LIST()
@@ -1796,7 +1796,7 @@ static const VMStateDescription vmstate_apx = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = apx_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINT64_SUB_ARRAY(env.regs, X86CPU, CPU_NB_REGS,
                                  CPU_NB_EREGS - CPU_NB_REGS),
         VMSTATE_END_OF_LIST()
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 569536bd02d8..cdd8b02acc6b 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -723,7 +723,7 @@ static const VMStateDescription vmstate_bhrb = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = bhrb_needed,
-    .fields = (VMStateField[]) {
+    .fields = (const VMStateField[]) {
         VMSTATE_UINTTL(env.bhrb_offset, PowerPCCPU),
         VMSTATE_UINT64_ARRAY(env.bhrb, PowerPCCPU, BHRB_MAX_NUM_ENTRIES),
         VMSTATE_END_OF_LIST()
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e7514a4a9f51..d7503357c861 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3409,6 +3409,12 @@ sub process {
 				$herecurr);
 		}
 
+# check for non-const VMStateField[] compound literals in .fields initializers
+		if ($line =~ /\bfields\s*=\s*\((?!const\b)VMStateField\[\]\)/) {
+			ERROR("VMStateField[] compound literal should be const\n" .
+				$herecurr);
+		}
+
 # format strings checks
 		my $string;
 		while ($line =~ /(?:^|")([X\t]*)(?:"|$)/g) {
-- 
2.55.0


