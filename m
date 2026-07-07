Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44712C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:14:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh7Uz-0007Rq-Us; Tue, 07 Jul 2026 11:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Uy-0007QP-5X
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:12 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh7Uw-00078s-MT
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 11:14:11 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C9FNZ3590494
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 15:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 t19/MYRubPwTkKX5hCIB582+6b2Ad0WgAiE/WCw/+2c=; b=N1YdMfa3ofXs1FPN
 0wQH1Vu1e61w0oAgPWgDoJ+fNrjiPGPWW9ymPgX3tSGM+RzXhHm1UPsmFeEOPlZ4
 w2W/iFslGunliSSV3WAESod7xGui8C33l0F7vn/vsHqpew0EljzI0byQptXBqsOA
 Zxd+7sE2WICGucmW+fCwv/EaM8v5DPzILIrwBT1oPHGXeACBKgRkuHJ/QN2gRpef
 Gg9iwf5vRZBgZm/472YEoQFYgA+v7SUO7sUCf9PtphJ6wC/eS6HMJWdl2RDTGiyr
 65IyR+hfbML0ff7oDln8w6SJGrPbZsAKXf6IpCA5fpST4o09xLVUj8KTaiTGDpaC
 3cOnXQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2u9wbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 15:14:09 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c20762d21so52746291cf.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 08:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783437249; x=1784042049; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t19/MYRubPwTkKX5hCIB582+6b2Ad0WgAiE/WCw/+2c=;
 b=Q6hog21NHp4yiQ61mcTxlR0cePBwBnfLBifoYhsi2tTlLfu0l9eyZup11hbO7tzdBY
 My5XGq/xgEQr8Xif76yNq0o9RF5fyzgwCcoFmvmhQRJISRV2iea1EzfYJqgq0uiq73cn
 dapl5j+HJwyqJnIcPPrBJ7GoIeMo1Z4EtNSOft8W3UuptimTB+eZy3qU1n5s/3vxWVNb
 d7LiNtGdjWcPLTbg1u8DdIdwOYy+mpIb/4IB+MYRlvYzcQTX26vM+adHCnhlpHx6OPvm
 ZDQK2DVudgyQ6IxbGZZOECLcQ33MFChyPtPOw6s9tgQC89q79xG8ZYq97wb+ccKPbFO1
 WUdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783437249; x=1784042049;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t19/MYRubPwTkKX5hCIB582+6b2Ad0WgAiE/WCw/+2c=;
 b=UMQrxyWXSt7x397oy/2fD/Pv0O9LB2+98eC/KwNo8mXm18oisoTFDIo2DgD4ESAq+I
 auf2RuXYyGkmC7kZcLLcgWbchORhhaYUvmPUMFEfiUIZwOw0nChfflFfLHtF/87y3jy4
 y74ctyjG/UE9cg8RTyiCyfUSv/dZKWsvkUyM7iBpvwnBN31WJZEB2kwTfOmXsJDWpSbZ
 OIf7MCoFSAKFYVkmCtLNsGJxc8a9sGdf4WpmjXd9iApwmUMRzT0nG+gdyzaORXYtlu96
 5Dg7NzZg4g6lb3UzTWbgIRtOo94SWmURlbNnxpbSYHCX7N2DafefLaocHmUOsrO/kAIE
 wgJA==
X-Gm-Message-State: AOJu0YzTsU9XyKFMuDJZEFvQ6OX20kMwdJCAGNruwzF/2WWK6drWsjTb
 faP4bfiHjPliR8hHgGLEF8s7Jkb1vIberJiBQxTQFCuzSjS4OHBUHMoKAdaVDpaecFVlumstH5t
 1/DZZwpn46vRYBQ1rfGwADaPAoOxe4ukUo35qRWzzlH8TNS5efusQqj4iCn1whjAwkg==
X-Gm-Gg: AfdE7ck3yEzihBSfXTVB07NbJ58aTjAmm/PeBBUuLeqHHAOkUuvVBl7zuWq8WaZ8Vaq
 2n3ZLI9MxFwnJPYZOuZ8lKUuedS0L0HPktCISvkrqpqfUtcYvdlxtfudBB11Ed40KP+L5v8cqHX
 fbKhHOOMsfcYanHlo4wsS3RxXeKSThvk1mOzw6erBacTPWMkotKet79NelwyUN122WTOPFq5XeU
 UUpoM9MtZpIBlZZqfECi+n8xtaE03D0EHkxMcRQea4RB6eYJkj21w91BDNK+Tu6eG/3rBsk4uSD
 XG2sbmIc5erjhZydYdHjVvSzgqmJlAJLSDYMbBXEhIZtzOI9Jw7J/Do5Vtlw0gLtsBeXLUBLL0G
 QZXTBtf7O7RNg7iwPp/AGzJtfvQMjTPvr9mby+XpKQd1JmWTVEJTRKObqesuFU5oULK5g
X-Received: by 2002:a05:622a:241:b0:51c:7b12:1202 with SMTP id
 d75a77b69052e-51c7b1216d1mr31306931cf.80.1783437248746; 
 Tue, 07 Jul 2026 08:14:08 -0700 (PDT)
X-Received: by 2002:a05:622a:241:b0:51c:7b12:1202 with SMTP id
 d75a77b69052e-51c7b1216d1mr31306151cf.80.1783437248064; 
 Tue, 07 Jul 2026 08:14:08 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d8410sm34980466f8f.15.2026.07.07.08.14.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 08:14:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 29/36] hw/arm/msf2-som: Fix spansion-cr2nv value for
 S25FL128S
Date: Tue,  7 Jul 2026 17:13:49 +0200
Message-ID: <20260707151351.57769-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707151351.57769-1-philmd@oss.qualcomm.com>
References: <20260707151351.57769-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX0qMz+96sPYYT
 UmTPMwR/s7669xZ0RByNNsHIcFB0m3WypIIrQXd576ErGU2fFfAFbsOUDOP1zr8coXSW6nSHpSC
 waKHv2NNp8dKPhVVIjerBtpcmYnJou0=
X-Proofpoint-GUID: rKEi_09uF39RmG_MeAVwceXN7Py8miLN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE0OCBTYWx0ZWRfX3DiDM7/kwBLu
 9yP+43XiCbF08bUKU7IxqUlNwZwFm1Vn6SrRMH29Fwinq79klqFMPiiya/secnmboJZ9MWDj6lP
 G+dTqjUgKz8fxQX9rXQpwBDsiyOcv61sIdmA32INAHq5vkjv+buLxh4+G8HWtIkkjARdZhzWOWk
 TV1kFV25QSBdOGs3V1ws07vBecCSomsOZUXV8TWhmn8BF6ZuEAj3S8oSx9YF4upF3WG/RxcYdaQ
 XiME8I2+41zk2a6UCkxdr4Sfy8ukjoNy06IQZLV+ObC15zMfRwUKMEFbil5s9CUylvN7aOTD9VP
 zcgN5i53IPBgf0Rmjec2dCiTIdQqWsh0IRdZhEC5Owr0NKJL6YlK4pUqjx/414Ljd4kCXNEkPS5
 v/G3O/hvKoD3wiJxgaBJisgtl/V2KkcTUc4YfKNbUj2qNs1+0naA//CT14mVwA0NjMPtBAqtis/
 4bGnjuB/GFgqpOOAXPg==
X-Proofpoint-ORIG-GUID: rKEi_09uF39RmG_MeAVwceXN7Py8miLN
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d17c1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=9bFI_O7vVwkWIVXnD50A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070148
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

From: Cédric Le Goater <clg@redhat.com>

The emcraft-sf2 board set spansion-cr2nv to 1, which the old m25p80
code treated as a byte count. With the dummy cycle to byte conversion
fix, CR2V=1 at SPI x1 is 1 bit, not byte-aligned, and triggers an
assertion. Use the S25FL128S default of 0x8 (8 cycles = 1 byte at
SPI x1), preserving the same runtime behavior.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-Id: <20d58663-a8d1-41ff-9348-cae4982c30f0@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/arm/msf2-som.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index caf6e7e1ad7..1ada1a13613 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -84,7 +84,7 @@ static void emcraft_sf2_s2s010_init(MachineState *machine)
     /* Attach SPI flash to SPI0 controller */
     spi_bus = qdev_get_child_bus(dev, "spi0");
     spi_flash = qdev_new("s25sl12801"); /* Spansion S25FL128SDPBHICO */
-    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
+    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 0x8);
     if (dinfo) {
         qdev_prop_set_drive_err(spi_flash, "drive",
                                 blk_by_legacy_dinfo(dinfo), &error_fatal);
-- 
2.53.0


