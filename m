Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4359DC44529
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 10:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm7uH-0006aO-NP; Tue, 21 Jul 2026 06:41:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7uB-0006Rv-2D
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wm7u8-0003AN-Pm
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 06:40:54 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66LAQrrh2502597
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v98OUyNHVoEImDtK/FwT7ApOp72nP1SHAYeex0kNqo0=; b=R3IFkv2U8PkdcNE5
 TRibpv89VvnFep7juvAd78t4Y49Vlp2HOgMWude8uz5c0a9kiOarUaPbTavs/mJ4
 OlX25Sz5d071KC4sq2qbcdjYyWTA7xdN17/gaoC6OA971KNdOWasbzJEge/zrQDG
 p8DShsvlRFIoAcBBAg27nl1ZjC7HcngWiibZb+x5CFKRMzlobaFmOBrCWfb1o9kM
 fJ5hVor6rpTHUN19Ncj1h5mAJCJEZV7IX6tIh+KhuxXVQlipT3Nd046qjlt5hnNR
 9UYGniOmt2mPWdaYENu/Di2E51hcNLLcdp4HFRSvB2TkQFhrT0BGw5Yc1uC7t6W1
 MsNo7A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6nsr4pj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 10:40:50 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c20762d21so107299311cf.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 03:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784630450; x=1785235250; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v98OUyNHVoEImDtK/FwT7ApOp72nP1SHAYeex0kNqo0=;
 b=juPT/CXAj2XlADifhAkQlKDGodyEALHIz74L1hOJMAtcU0rtnFlrlAw+PRE8Xbraed
 iuEeT3fwiyoOgDKL8OfWnXTn1HwwGmGCh1yLpRyFKLzS2XbXl/Mn49AS0adefhnBYd8M
 oMqaNTFBbzSsYXJbHZca/HCVo6qjKwH8vgoeDLHFyoGmTPhaFUaXXRB3epkoxgvoPkXi
 AXPAEizCNjVmdE7eRGtwj+WFdLK0UvmrO9E8sG3xaS5C40cUVDUgHQWRO3dy2zQPIaD7
 rTdGGWZWVAKD80sNAGvnu1aemIRf1XmNAdQK8p3dYNLENxfsXDpp8BvAifkgkdRthwAV
 CpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784630450; x=1785235250;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v98OUyNHVoEImDtK/FwT7ApOp72nP1SHAYeex0kNqo0=;
 b=qzEbEXNVn5wBxY4XsvzbRQfkKyMz/lqPZIqUnKvnUFC5F/WUQX+CC9I2GIPRPfHfjo
 b6QpnDhMCbT+3ttsOmR9c6O2HUBXtjZUjEaHm0iZR6eYN62/W+wCbT6K/LxkE4jRCUBS
 R7nyy/ArkibtYEiFWGSTH0RXfY/eMH8v3PAEW/TgXBFrq3lHJBROJzTelEgkFSNFnz+z
 KBd4dw0OHfFOCFWs9qdmHTzc9h7kR2/7UmfvQo1mTBAfEkVnMav0P5Db1S1FRd2hB9Yo
 YpeNa5AiFfoSpjYqMDvaWzRQFsSMmwpv0U3bNu8Ytyt3U73XjCuaVRUULE/j7GLMAD0v
 6kwQ==
X-Gm-Message-State: AOJu0YymytSlaliF4jGrO5VvH1Y3eINMCTvVev7HYLtFnW975lRE8VV7
 /oLX990he9r+hZQOs7E6puiF2CBATmZ/gy9+1rHVsS14bQrgajDvfoqhYC8yBY8VuAODvnmY667
 Mzkr08srUwG2zF0GXGpHgdMBcuuqhexM5VXtm9IJJbX/Nzabnrf/MH9ailpqBf7lpyg==
X-Gm-Gg: AfdE7clCUUNrsr87ZVnL40LA8+ZkRiZHXJm6PkCqM5xsJ4YRGliNpgrIiisN0lWmJCX
 gt7LFmd+AOlRZD/oE4U21VtuXTKYYvzu+t4VjOEhsqT0mZCfqdUckpmp0Xpz3+Eod7HcqeMdB0r
 NtRjOCCnv24taIJlCVhbvGMkGqgLTnE0Xd+a2d6rjQBaSJI9QRVTjUWEPwak3Gcpd7qVBp1m1E6
 SMqZFWn1ekhLFL94RD4Hn2WyN2ZYPVCsQr1TJCD5Fcz64rlrHyTvk5ExgxR84BPgK7vpL22laOJ
 wRN9R0qAeXhn5G5kp5gPH44ex7v1njB/Or8zsasbBwhw75uXu/r0irkUtPDafsRrYxLWGJAXKZe
 oF9hH2zxuUICQrCZvyBXyZnA+zBsYEgmuuIMb62cD/6Pd8vmWbDJ1biY/uQ==
X-Received: by 2002:a05:622a:350:b0:51c:555:7dea with SMTP id
 d75a77b69052e-5213cbd667cmr162883921cf.30.1784630449732; 
 Tue, 21 Jul 2026 03:40:49 -0700 (PDT)
X-Received: by 2002:a05:622a:350:b0:51c:555:7dea with SMTP id
 d75a77b69052e-5213cbd667cmr162883511cf.30.1784630449146; 
 Tue, 21 Jul 2026 03:40:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ed2314sm1969401f8f.23.2026.07.21.03.40.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jul 2026 03:40:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 6/9] hw/net/cadence: Return current Cadence GEM queue pointers
Date: Tue, 21 Jul 2026 12:40:01 +0200
Message-ID: <20260721104004.84934-7-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721104004.84934-1-philmd@oss.qualcomm.com>
References: <20260721104004.84934-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9tphLoLUIIbE0YrWdNtGi9eTV78S8YI8
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX8SLi+HbLX7Fk
 yO7koYBM36DGnD8kmFxKTW9hx6ipqTv0nt33zqqkWSPDPM1V2ozTT40l8/DfpCOetmfZcJCJ5cL
 zsPOogJ/PCSQ+8dQY2WQJkBLzdG5jsE=
X-Authority-Analysis: v=2.4 cv=ZJjnX37b c=1 sm=1 tr=0 ts=6a5f4cb2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=FRSEYCzRAAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=5y4S8oiitaOSQFV_i7UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=H4N_Y-AU75W7NKDNhZlT:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-ORIG-GUID: 9tphLoLUIIbE0YrWdNtGi9eTV78S8YI8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDExMiBTYWx0ZWRfX86PR34DT7bqa
 SBb3EwHbfORVPGAHjA3jPLl7yU7HcnfWGgXLpeM/5YAdPuOW9s0xzFHx4qjDM1o87BCs7lPxZZ4
 FPI14xyY1Ixfly0F9WGTaRBBpRzsDkYzpUFNZsLzobykTdNdUjmkWZANpUbpVye8TUJDuxw1Uu4
 S0vgEnMM0Zk0GzGl9tTm0Dgj3XWX3sf2L4+YNdxB9RrQMl+Tl6CHOsVdoR1MtwNAQCKgJU3xt52
 ZX/0DEFziSLFKghzVqpGZqMQjwFCdQVzmgUlS4WUOnYanPs3X6L1mkGSfdf4+9JH2WttIsDXUrE
 Kp+nnjaWhOOAiExoyHpRhrbhyYf9wWcx0eZk30sAnokNpXTr9l8c0SJ1wGrz8QWZCJhv3aQWmgL
 oakyJR0Jh5nddIEnWOaZ6bs/mGw+y9WPsc42wgv9iFM+l0QpHYpSo9dF/RkdYub4urmTvBb1XZL
 XCRQoUiGv5GJBhN45IA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_01,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210112
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Bin Meng <bin.meng@processmission.com>

Cadence GEM queue pointer registers are programmed with the descriptor
ring base, but reads return the descriptor currently being accessed.
The model tracked the current positions separately while continuing to
return the configured base.

The Linux macb driver uses the transmit queue pointer when recovering
from a used-buffer interrupt. A stale priority-queue pointer can make
the driver restart DMA before that queue handles its completion
interrupt, causing queue 0 to repeatedly raise TX_USED.

The primary queue has had this mismatch since the initial model.
Priority queue support later copied the same register-read behavior.

A single-queue machine usually handles TX_COMPLETE before TX_USED and
empties the software queue before the restart check, which kept the
issue hidden there.

Return the current RX and TX descriptor positions on queue-pointer reads
and clear those positions on reset.

Fixes: e9f186e514a7 ("cadence_gem: initial version of device model")
Fixes: 6710172501be ("cadence_gem: Add queue support")
Cc: qemu-stable@nongnu.org
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-ID: <20260720120731.2022475-1-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/net/cadence_gem.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index b568fa3392d..39e3620ef5b 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1469,6 +1469,8 @@ static void gem_reset(DeviceState *d)
 
     /* Set post reset register values */
     memset(&s->regs[0], 0, sizeof(s->regs));
+    memset(&s->rx_desc_addr[0], 0, sizeof(s->rx_desc_addr));
+    memset(&s->tx_desc_addr[0], 0, sizeof(s->tx_desc_addr));
     s->regs[R_NWCFG] = 0x00080000;
     s->regs[R_NWSTATUS] = 0x00000006;
     s->regs[R_DMACFG] = 0x00020784;
@@ -1593,9 +1595,22 @@ static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size)
     offset >>= 2;
     retval = s->regs[offset];
 
-    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset*4, retval);
+    DB_PRINT("offset: 0x%04x read: 0x%08x\n", (unsigned)offset * 4,
+             retval);
 
     switch (offset) {
+    case R_RXQBASE:
+        retval = s->rx_desc_addr[0];
+        break;
+    case R_TXQBASE:
+        retval = s->tx_desc_addr[0];
+        break;
+    case R_TRANSMIT_Q1_PTR ... R_TRANSMIT_Q7_PTR:
+        retval = s->tx_desc_addr[offset - R_TRANSMIT_Q1_PTR + 1];
+        break;
+    case R_RECEIVE_Q1_PTR ... R_RECEIVE_Q7_PTR:
+        retval = s->rx_desc_addr[offset - R_RECEIVE_Q1_PTR + 1];
+        break;
     case R_ISR:
         DB_PRINT("lowering irqs on ISR read\n");
         /* The interrupts get updated at the end of the function. */
-- 
2.53.0


