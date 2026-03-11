Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F491FD88D9
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 02:38:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w09Rq-0005kw-DT; Tue, 10 Mar 2026 22:37:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w09Rp-0005kc-PP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:37:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jithu.joseph@oss.qualcomm.com>)
 id 1w09Rn-00054P-9z
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 22:37:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B1JvjO509379
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:37:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=UT9CA032ReZS+FGJDFyjv+
 FY7jizDtZJi8z0EhFfcyQ=; b=JsEg/erjOUliQic46RhzPOt0tg+rx0JfqUywAF
 NvdBCmyWgX0PGKDQlgBo55CwAcV8xlIyLc1FOSNsghhlAGj33uUDIlj/YCZt3R8I
 +nLTzJOsIdgCapPi86tCt9OzAfV9KDkg2J+daB+QMQB3apn1LMX+DcshkI8Df4en
 ySWP9CvRhSJ562TM/WW4Tp+gjJ+YNrfxfPjg3yXgk+FZ6fIqa4cItsGquTAroBoQ
 fS8CtgdNbmv2ecfg96QBJPNVlDGC/p3yizLXeENXzZV93WLAtnS+AFrrhFsDU3GY
 xE2dqETDQ7gezE01IiRgVhlqE7QkBujmzUbwUhsQM+wd1MDg==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctppahvm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 02:37:16 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-466ed1116a9so29991424b6e.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 19:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773196636; x=1773801436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UT9CA032ReZS+FGJDFyjv+FY7jizDtZJi8z0EhFfcyQ=;
 b=W/vWsNbrF2WcUobdsLqdSHeR8ZmERqNQo7WDTaRA2C+MMUMe1TlzSU0GpFcTkysPk0
 8PAxlQHq4IXQLgSwsAQkNKmnI+1gb0pWtv5j1fX8Ft8xwRTYF5+H8NRK3lU5wzEeuz61
 ReiwPO0U0anAqp9FU8pDOTkxKkDUP/grBSI0YRbdoqWhykadm3AEmYiPTqss5nglt1M4
 fpRG1XI0djJm03pX9cxkpq+jnCDIW+rG6lyI3IP5EmNnX+4vrEd9g2ls5dSe5syWtoUf
 DWCVB/xvYMTwNhXRg0L5GVPCAKpjfoDtQwaKZRBzckoEdGbR/7Lbh00Edz4YnKcygkj+
 4wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773196636; x=1773801436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UT9CA032ReZS+FGJDFyjv+FY7jizDtZJi8z0EhFfcyQ=;
 b=VGkgg8zw3JS78KppWqAVT054z+gRTGanx1/efn23yZrk7mB62uyf4S2ljIqq0bznLA
 878Y3WO8USUjBpPwBt313IyXyc+72ASBVmadXAWKNFmbwP6f3hSpMhq20J0BLzg0v45c
 4Y3bO7Xts1jXnWISFlTuVKT9G+iTG7RypxdKIGYWwfA0xlmMK6O1GDF7DeWgDAp9ODUh
 /syjeQjlggQ7xzq5sMEZjHgvadcdHa+jBMfJ4rZlvCodmkgMrK8uVWKKE7sL6PHhhqWu
 GSTz2C9kfyJ8hmVaGOb9qcHy8s82AXrsL4Sx08ADHuRC8jj1hGWc9AKIS6dG5NfklirR
 rJpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOR+ODE8d62sOGiNjMw821JCL+lX6QeqqixUBsCvGcsC2x2e8CVECu2zNuZ+S2rUM0JalCcMIIfqj0@nongnu.org
X-Gm-Message-State: AOJu0YwksI0MFgguvbq3lrPOAPARSKOprM5zBeeGduKgdSnu0yYyNIin
 UKMxJ+QkLmwpMN2Z9pMD32+X4KsrYL8QwYWgwCUxnkPs2PlEU0v98tg0j38/YCdPDFO3mGRzzNU
 g0HejRdxB8IpjlfLCFnDT2ccAxqKcSyrOR+/mKIZuZHk6vvxgiZo9KP9ndg==
X-Gm-Gg: ATEYQzx4n+zbjWcCcTekQLRRXcSlKgoWomCHHzcGwUCVnKOtF+xLpY8/TiYUwaqCSgo
 fxqYOa+x3Fts43MuKmjrQx/0BNMohpKPoVyE+nc3XPpnFT7Mg57pBSGFmp2Vuk459PzdSW/cahz
 m316vsDrsbIu31nvo/Ur+0iUdtfqmq1pE9OQURONbLnv9Ng1jEpJhJNhlw31Pt0cIAuarJIXq9D
 ItQBB0+I8chBZUzC8fP7DXhPAQFjO31VYZoe5ot6osKkSwCLjkHFXd0tX7c5a7CSUYeISn0Fhsk
 72GZdhmwq4L9JGnHBXbYmJjh0qmZYhpNa6SpQ3dz+ddVqS+V0gNCZ+88dsNwuG3qldQUF/rL2xT
 2pIP/EhmF2OiuIkpw+L+8zp4OeM/g+/IttRcUjjJypPheCJCyOJ9C7hUXA9SPzuPGlbnPSW4G7R
 Cb
X-Received: by 2002:a05:6808:3505:b0:467:32c1:ad08 with SMTP id
 5614622812f47-467335cf6a6mr613547b6e.56.1773196635648; 
 Tue, 10 Mar 2026 19:37:15 -0700 (PDT)
X-Received: by 2002:a05:6808:3505:b0:467:32c1:ad08 with SMTP id
 5614622812f47-467335cf6a6mr613524b6e.56.1773196635151; 
 Tue, 10 Mar 2026 19:37:15 -0700 (PDT)
Received: from hu-jithjose-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342ef853sm435315b6e.15.2026.03.10.19.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 19:37:14 -0700 (PDT)
From: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
To: clg@kaod.org, peter.maydell@linaro.org
Cc: steven_lee@aspeedtech.com, leetroy@gmail.com, jamin_lin@aspeedtech.com,
 andrew@codeconstruct.com.au, joel@jms.id.au, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, jithu.joseph@oss.qualcomm.com,
 quan@os.amperecomputing.com, jae.yoo@oss.qualcomm.com
Subject: [PATCH] hw/i2c/aspeed: fix lost interrupts on back-to-back commands
Date: Tue, 10 Mar 2026 19:37:12 -0700
Message-ID: <20260311023712.2730185-1-jithu.joseph@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HfDvHiwnnGu6oJUho-81bUtJ_h8ARAWO
X-Authority-Analysis: v=2.4 cv=D7BK6/Rj c=1 sm=1 tr=0 ts=69b0d55c cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=vzhER2c_AAAA:8 a=EUspDBNiAAAA:8 a=i6Hr8m2T0cAuEC4tR94A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=TPnrazJqx2CeVZ-ItzZ-:22
 a=0YTRHmU2iG2pZC6F1fw2:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyMCBTYWx0ZWRfX9fg2ZVwRKwH+
 FExuWrGNgKB9FidgQAt7N3qJr2yWLShOezqhylRojRr4Dh3Db64tiGs38QKZiuD+0cKbjddFvtK
 CPN94FCNs5UdqXXLBXSgnaUHXKmvw7n2TrRuAvpxPuYXneml4uT/0JOZcwZ4iPgHvVX2LpaBCmr
 pUqezs4AporP3WGcCrsZFPTda6fo3S/hfDuo81fJnwZg+87LPAVdZzYA++1LzQ3ulfzldfoW+Xi
 rZ0NAFC6IjZMy6rbOKShnvubu7syukQhSOWSY6PKJI8Itst49cBAik0Dz/Hu4OxJWXCnMpTpmUy
 vL9ZPrmReF8wMNvUW142DwH3d7EbVzPZohwJf40lrTqyaHSL8qXFXwuchPGuOBwPPwCPdPXpSmP
 N9JKG8VLOp2oHC4B2PKAv/9V1FTgFnPcTvbdq1CxuLEQGc4wuT3b3ZS8Zg/lNNO2Xu/t0qLw0me
 rij5Q5mYSaiZKxFvuCw==
X-Proofpoint-ORIG-GUID: HfDvHiwnnGu6oJUho-81bUtJ_h8ARAWO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110020
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=jithu.joseph@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QEMU executes I2C commands synchronously inside the CMD register write
handler. On real hardware each command takes time on the bus, so the
ISR can clear the previous interrupt status before the next completion
arrives. In QEMU, when the guest ISR handles a TX_ACK and immediately
issues the next command by writing to CMD, that command completes
instantly — before the ISR returns to W1C-clear the first TX_ACK.
Since the bit is already set, setting it again is a no-op. The ISR
then clears it, wiping both completions at once. No interrupt fires
for the second command and the driver stalls.

This affects any multi-step I2C transaction: register reads, SMBus
word reads, and PMBus device probes all fail ("Error: Read failed"
from i2cget, -ETIMEDOUT from kernel drivers).

The issue is exposed when the guest kernel includes commit "i2c:
aspeed: Acknowledge Tx done with and without ACK irq late" [1] which
defers W1C acknowledgment of TX_ACK until after the ISR has issued
the next command. This means the old TX_ACK is still set when the
next command completes synchronously, and the subsequent W1C wipes
both completions at once.

The trace below shows `i2cget -y 15 0x50 0x00` (read EEPROM register
0x00) failing without the fix. The first START+TX sets TX_ACK. The
ISR handles it and issues a second TX to send the register address.
That TX completes synchronously while TX_ACK is still set:

  aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
  aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
  aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
  aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x1      # TX runs, TX_ACK already set!
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # re-set is no-op
  aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
  aspeed_i2c_bus_read  0x10: 0x0                    # LOST — both ACKs wiped

The driver sees INTR_STS=0 and never proceeds to the read phase.

Fix this by tracking interrupt bits that collide with already-pending
bits. Before calling aspeed_i2c_bus_handle_cmd(), save and clear
INTR_STS so that only freshly set bits are visible after the call.
Any overlap between the old and new bits is saved in pending_intr_sts.
When the ISR later W1C-clears the old bits, re-apply the saved
pending bits so the ISR sees them on its next loop iteration.

With the fix, the same operation completes successfully:

  aspeed_i2c_bus_cmd cmd=0x3 start|tx| intr=0x0    # START+TX, clean
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK set
  aspeed_i2c_bus_read  0x10: 0x1                    # ISR reads TX_ACK
  aspeed_i2c_bus_write 0x14: 0x2                    # ISR issues TX cmd
  aspeed_i2c_bus_cmd cmd=0x400002 tx| intr=0x0      # INTR_STS cleared first
  aspeed_i2c_bus_raise_interrupt intr=0x1 ack|      # TX_ACK freshly set
  aspeed_i2c_bus_write 0x10: 0x1                    # ISR W1C clears TX_ACK
  aspeed_i2c_bus_read  0x10: 0x1                    # RE-DELIVERED from pending
  aspeed_i2c_bus_write 0x14: 0x1b                   # ISR proceeds: START+RX
  aspeed_i2c_bus_cmd cmd=0x40001b start|tx|rx|last| # read phase completes
  i2c_recv recv(addr:0x50) data:0x00                # data received

[1] https://lore.kernel.org/all/20231211102217.2436294-3-quan@os.amperecomputing.com/

Signed-off-by: Jithu Joseph <jithu.joseph@oss.qualcomm.com>
---
Background: A Linux kernel patch series by Quan Nguyen (Ampere) reworked
the i2c-aspeed driver's interrupt handling to delay the W1C clear of
TX_ACK until after the ISR has processed the completion and issued any
follow-up command. The motivation was to correctly handle AST2600 and
AST2500 hardware where I2C slave mode requires this ordering — the
authors explicitly verified the series on both platforms. On our internal
AST2600 hardware we carry this patch as a necessary fix for I2C slave
mode to work correctly.

The series did not make it into the upstream Linux kernel because test
failures on QEMU blocked it. However, the failures are on the emulation
side: QEMU executes I2C commands synchronously inside the MMIO write
handler, causing a follow-up command to complete and re-raise an
already-pending interrupt bit before the ISR has had a chance to
W1C-clear it. On real hardware this race cannot occur since bus
transactions take measurable time.

Since the kernel patch reflects correct real-hardware behaviour, the
right fix is to adapt QEMU's interrupt delivery to handle this ordering,
rather than requiring the kernel driver to work around a QEMU-specific
timing artifact. This patch does that.

 include/hw/i2c/aspeed_i2c.h |  1 +
 hw/i2c/aspeed_i2c.c         | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 53a9dba71b07..d42cb4865aa5 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -256,6 +256,7 @@ struct AspeedI2CBus {
     qemu_irq irq;
 
     uint32_t regs[ASPEED_I2C_NEW_NUM_REG];
+    uint32_t pending_intr_sts;
     uint8_t pool[ASPEED_I2C_BUS_POOL_SIZE];
     uint64_t dma_dram_offset;
 };
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index 8022938f3478..ad6342bec0d4 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -628,6 +628,8 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
     bool w1t;
+    uint32_t old_intr;
+    uint32_t cmd_intr;
 
     trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
 
@@ -665,6 +667,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
             break;
         }
         bus->regs[R_I2CM_INTR_STS] &= ~(value & 0xf007f07f);
+        /*
+         * Re-apply interrupts lost due to synchronous command completion.
+         * When a command completes instantly during an MMIO write, the new
+         * interrupt status bits collide with already-pending bits. After
+         * the ISR clears them, re-apply the saved bits so the ISR can
+         * process the new completion.
+         */
+        if (bus->pending_intr_sts) {
+            bus->regs[R_I2CM_INTR_STS] |= bus->pending_intr_sts;
+            bus->pending_intr_sts = 0;
+        }
         if (!bus->regs[R_I2CM_INTR_STS]) {
             bus->controller->intr_status &= ~(1 << bus->id);
             qemu_irq_lower(aic->bus_get_irq(bus));
@@ -708,7 +721,17 @@ static void aspeed_i2c_bus_new_write(AspeedI2CBus *bus, hwaddr offset,
             bus->regs[R_I2CM_CMD] = value;
         }
 
+        old_intr = bus->regs[R_I2CM_INTR_STS];
+        bus->regs[R_I2CM_INTR_STS] = 0;
         aspeed_i2c_bus_handle_cmd(bus, value);
+        /*
+         * cmd_intr has only the bits handle_cmd freshly set.
+         * Overlap with old_intr means the same bit was re-fired
+         * and would be lost when the ISR W1C-clears the old one.
+         */
+        cmd_intr = bus->regs[R_I2CM_INTR_STS];
+        bus->regs[R_I2CM_INTR_STS] = cmd_intr | old_intr;
+        bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
     case A_I2CM_DMA_TX_ADDR:
@@ -845,6 +868,8 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
 {
     AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(bus->controller);
     bool handle_rx;
+    uint32_t old_intr;
+    uint32_t cmd_intr;
 
     trace_aspeed_i2c_bus_write(bus->id, offset, size, value);
 
@@ -868,6 +893,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         handle_rx = SHARED_ARRAY_FIELD_EX32(bus->regs, R_I2CD_INTR_STS, RX_DONE)
                     && SHARED_FIELD_EX32(value, RX_DONE);
         bus->regs[R_I2CD_INTR_STS] &= ~(value & 0x7FFF);
+        /*
+         * Re-apply interrupts lost due to synchronous command completion.
+         * When a command completes instantly during an MMIO write, the new
+         * interrupt status bits collide with already-pending bits. After
+         * the ISR clears them, re-apply the saved bits so the ISR can
+         * process the new completion.
+         */
+        if (bus->pending_intr_sts) {
+            bus->regs[R_I2CD_INTR_STS] |= bus->pending_intr_sts;
+            bus->pending_intr_sts = 0;
+        }
         if (!bus->regs[R_I2CD_INTR_STS]) {
             bus->controller->intr_status &= ~(1 << bus->id);
             qemu_irq_lower(aic->bus_get_irq(bus));
@@ -915,7 +951,17 @@ static void aspeed_i2c_bus_old_write(AspeedI2CBus *bus, hwaddr offset,
         bus->regs[R_I2CD_CMD] &= ~0xFFFF;
         bus->regs[R_I2CD_CMD] |= value & 0xFFFF;
 
+        old_intr = bus->regs[R_I2CD_INTR_STS];
+        bus->regs[R_I2CD_INTR_STS] = 0;
         aspeed_i2c_bus_handle_cmd(bus, value);
+        /*
+         * cmd_intr has only the bits handle_cmd freshly set.
+         * Overlap with old_intr means the same bit was re-fired
+         * and would be lost when the ISR W1C-clears the old one.
+         */
+        cmd_intr = bus->regs[R_I2CD_INTR_STS];
+        bus->regs[R_I2CD_INTR_STS] = cmd_intr | old_intr;
+        bus->pending_intr_sts |= old_intr & cmd_intr;
         aspeed_i2c_bus_raise_interrupt(bus);
         break;
     case A_I2CD_DMA_ADDR:
-- 
2.43.0


