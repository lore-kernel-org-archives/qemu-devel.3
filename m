Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12D27C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5fQ-0005x0-TQ; Tue, 07 Jul 2026 09:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ex-0005TN-KQ
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eu-0000x7-Q8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8cn93755355
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q1kf1bQ6UevRdyXgo0b8Lt2RsNYvkZ5Sc/MeeDvIdg8=; b=FC3/wL0ft1AaZZMy
 yuHIEN6sagW8XSKisie5C9CD594ikr/vbHi9mltSSUgB9u9V09EOx41iduxtWcr9
 GcR0KMj8FsPxatMC9CfkuFtZhirqi8ax3Nb6FQH2eoUlfSErqAC+H/YkWzGccG9A
 5OdcOxdDEysWD0pI4wTneOxMknnZW3FODfWcD7D3xdUudJVkre0yRpzrvAr43uCj
 EwTxAMFHDKlxiVnI9djAUXhMzS5PzMq3pRvyMB3kY9rK73AXkOh1h95wYVsoQ9d6
 su4xV1eOmolZN0A92ZLvv/r4wPeBg5LYXM8gyjLAW7oB3C7yORTVb1m/o7ux4Yg0
 MrqLrw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep1972-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:16:19 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c1a97644aso56536341cf.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430178; x=1784034978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Q1kf1bQ6UevRdyXgo0b8Lt2RsNYvkZ5Sc/MeeDvIdg8=;
 b=Z7EuxghyIuLVgBDJnekNtK9jWLByjXTuj2/KZZ9JldqT6T1wAIge2DJLoQKWhowGxI
 a7AGSnqG52H8ASlKuqVbWWb6ukgys2KrdzdeX4dfBNICL7B6r+BKu3Tb9sunDvDH5NoM
 HsoHOjKa5m34mnpoQIAv1ryyl5tPvt1JweKzUBLJyLtIqxIsBIcj2ZKfjc9WMkErVgRH
 oBAaSgLIJBoKq97euxDQJyshEZsltPA/NGOtX3H67xuak2mOYEBQKhJ2xcGijrsSGmJW
 RXRj47Oq1ScVfeSThADs0dhAhyjZRxGW/poLbf4FQiUOpyTT3x/m+nM1BThu4caJfQy2
 W/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430178; x=1784034978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Q1kf1bQ6UevRdyXgo0b8Lt2RsNYvkZ5Sc/MeeDvIdg8=;
 b=MaRBmZoQ6QOU7Jqc95Y0kOG15fgFu0ZTUvxGAwMNT1VL841HJo2kvLNIH1UjbbPnG9
 hwtle63yMgDwJLIc/vHro3tPhnoZSeQmVHxkcX+I1dHk6rNt34psJAltT54fMXQ1RCvD
 V2JecpLaruKgVn8YNYsZHPTUWfdtzR1YovigI6ojc6hG7CwlGuIFTc7mTId7DY6+NHzm
 R/8kEhSc/rhfqwLpunpnEGVbsfBfqwCTYEhWovXYqpc5SymCOMfkrmltTExz7mx/UFJq
 JZBk9sn+05Jjd+9OFcNnAug4GynyZC68Xodv3G6AiR7WL6mD4MGbOUGWa2N+wvvi28cU
 Axcg==
X-Gm-Message-State: AOJu0YyqgfDYDgUR/4WnVEvXW1xlfye5G6NaXJSZH6icVtaaSPe+t/Dl
 DcLSSBkwhTkxx640uml93NXXuw3FitMkWROe2uAeTYqkUhjWVjEwK87sMbAOHWi/2g+L/jkWHzN
 /CiFVhvPao6DOVWwwzFtDDokatPiV8dhheQpUtZidSAqFnMmHjh5AouyIr0rwsRdSaQ==
X-Gm-Gg: AfdE7clwVk6McbMjaORBdFtBF8XJVl+09P+mEg6lhJibePKeZsQevM0RHwVKK6jIfVG
 bLKsLaYt2eTJk0GwhDyvbDT/Ndxjw4w0fSlXg8d20/ciyBZw9moATV6vYS5WLM2pBZPqGbsuSYV
 ahS4OulUDnFG4HEkDuulJehMB3e8zf9uZQNR/vzpd3Dip49/DFR+6oD/0ltFLgeZIwHmVTv2A7+
 LANiFkVGB5CQ20iq0VCF47zkVFQdHOVtbDAmZz4y3lUb2LayvNHCmjUd5wp42aDwcy/9gkOfsal
 DhhQyLqmTANgHNyDQyV6Pf30bzjSHlgmbHFSSrSGn+h5RrEcR3+I5WiaSh4j4AoSlrGr7Bk2fWI
 5Iteycz76d2FlKMMs+oE8dQw6XQzi8x8YkqvJDald4qJGZsqGSHJqi+vvw2kdWqWp3V8B
X-Received: by 2002:a05:622a:120c:b0:51a:8c9c:7f3e with SMTP id
 d75a77b69052e-51c74914fa7mr52117451cf.65.1783430178135; 
 Tue, 07 Jul 2026 06:16:18 -0700 (PDT)
X-Received: by 2002:a05:622a:120c:b0:51a:8c9c:7f3e with SMTP id
 d75a77b69052e-51c74914fa7mr52117051cf.65.1783430177454; 
 Tue, 07 Jul 2026 06:16:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c15ada05d72sm136789566b.53.2026.07.07.06.16.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:16:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 32/32] Revert "aspeed/smc: snoop SPI transfers to fake dummy
 cycles"
Date: Tue,  7 Jul 2026 15:12:22 +0200
Message-ID: <20260707131223.51505-33-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Mopu1QOkr9jOzIEYmo6b3I2bg79_Rb_-
X-Proofpoint-ORIG-GUID: Mopu1QOkr9jOzIEYmo6b3I2bg79_Rb_-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfXz+MfLtE8Izjt
 Hb/r0udY6xm2rK8dAeLy5PnqXfDgA/AK2VL8JSBuF4vFSWSKVBwM1Bz8rsQLxa5B71bHrabQyBM
 dohjVPCj5DfA51l95ENGee5bru8kao32YKzinvA6XJufjJOwLHoOpcqX5MWRqpRCDqidY+2jva3
 YWU6IrxCvHaxFrvzyw78PZZXpkD1wgb5eonkux+1jeFt7YgXlNpqGb51GNKHALb3HTda1zgRrdS
 iK8wxOStDJ2XwjwcbKUOyXPR5beh+49rEgcckHQqZnWyCSTfFPmYyMNyBGeJtKhqwVQbYe+SlXi
 MTGCDzJDnEKaZlYCLb6MC9kFVdpNtdEo53p8AuBOH+761KrNdvEjNdWVyfFwKKWC3JnBByZb+V9
 lF9zdrcs6AVe17rs/itge9dmsnbNw4FJzu3iHswZwn0DnAGe2whMdmWspdrh8DYN/1du8kR2T9Q
 7gBrvbeRkyk7q9pMfJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX1mlHrq6UtQHs
 vGmhURm4VO4i4JMQ4T9VXWUXdWmnB3n9lTWdHFyjnYifB+7p+M0B6jQGVLeICj/FqgoHMbe38tA
 07slWBZLB1Gi+pR0PFWO2BhSjosWoyY=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4cfc23 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=aow-egSQAAAA:8
 a=T2d0spz66GM-GJdn4fkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=H4N_Y-AU75W7NKDNhZlT:22 a=gFNbaldVC-z-bsjSTzMo:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070129
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

This reverts commit f95c4bffdc4c53b29f89762cab4adc5a43f95daf.

The m25p80 model now accounts for fast-read dummy bytes in its
command decoder. In ASPEED SMC model user mode, guest software
already sends the complete byte stream, including any dummy
bytes needed by the flash. Hence the model should just forward
exactly the bytes supplied by the guest without the need of
decoding guest-supplied flash op codes to inject extra dummy
transfers.

Signed-off-by: Bin Meng <bin.meng@processmission.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-10-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/ssi/aspeed_smc.h |   2 -
 hw/ssi/aspeed_smc.c         | 114 +-----------------------------------
 hw/ssi/trace-events         |   1 -
 3 files changed, 2 insertions(+), 115 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 76831422c6f..a273365689e 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -80,8 +80,6 @@ struct AspeedSMCState {
 
     AspeedSMCFlash flashes[ASPEED_SMC_CS_MAX];
 
-    uint8_t snoop_index;
-    uint8_t snoop_dummies;
     bool unselect;
 };
 
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 58e5087b570..c8cc6cfa56e 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -197,9 +197,6 @@
 /* Flash opcodes. */
 #define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
 
-#define SNOOP_OFF         0xFF
-#define SNOOP_START       0x0
-
 /*
  * Default segments mapping addresses and size for each peripheral per
  * controller. These can be changed when board is initialized with the
@@ -537,104 +534,6 @@ static MemTxResult aspeed_smc_flash_read(void *opaque, hwaddr addr,
     return MEMTX_OK;
 }
 
-/*
- * TODO (clg@kaod.org): stolen from xilinx_spips.c. Should move to a
- * common include header.
- */
-typedef enum {
-    READ = 0x3,         READ_4 = 0x13,
-    FAST_READ = 0xb,    FAST_READ_4 = 0x0c,
-    DOR = 0x3b,         DOR_4 = 0x3c,
-    QOR = 0x6b,         QOR_4 = 0x6c,
-    DIOR = 0xbb,        DIOR_4 = 0xbc,
-    QIOR = 0xeb,        QIOR_4 = 0xec,
-
-    PP = 0x2,           PP_4 = 0x12,
-    DPP = 0xa2,
-    QPP = 0x32,         QPP_4 = 0x34,
-} FlashCMD;
-
-static int aspeed_smc_num_dummies(uint8_t command)
-{
-    switch (command) { /* check for dummies */
-    case READ: /* no dummy bytes/cycles */
-    case PP:
-    case DPP:
-    case QPP:
-    case READ_4:
-    case PP_4:
-    case QPP_4:
-        return 0;
-    case FAST_READ:
-    case DOR:
-    case QOR:
-    case DOR_4:
-    case QOR_4:
-        return 1;
-    case DIOR:
-    case FAST_READ_4:
-    case DIOR_4:
-        return 2;
-    case QIOR:
-    case QIOR_4:
-        return 4;
-    default:
-        return -1;
-    }
-}
-
-static bool aspeed_smc_do_snoop(AspeedSMCFlash *fl,  uint64_t data,
-                                unsigned size)
-{
-    AspeedSMCState *s = fl->controller;
-    uint8_t addr_width = aspeed_smc_flash_addr_width(fl);
-
-    trace_aspeed_smc_do_snoop(fl->cs, s->snoop_index, s->snoop_dummies,
-                              (uint8_t) data & 0xff);
-
-    if (s->snoop_index == SNOOP_OFF) {
-        return false; /* Do nothing */
-
-    } else if (s->snoop_index == SNOOP_START) {
-        uint8_t cmd = data & 0xff;
-        int ndummies = aspeed_smc_num_dummies(cmd);
-
-        /*
-         * No dummy cycles are expected with the current command. Turn
-         * off snooping and let the transfer proceed normally.
-         */
-        if (ndummies <= 0) {
-            s->snoop_index = SNOOP_OFF;
-            return false;
-        }
-
-        s->snoop_dummies = ndummies * 8;
-
-    } else if (s->snoop_index >= addr_width + 1) {
-
-        /* The SPI transfer has reached the dummy cycles sequence */
-        for (; s->snoop_dummies; s->snoop_dummies--) {
-            ssi_transfer(s->spi, s->regs[R_DUMMY_DATA] & 0xff);
-        }
-
-        /* If no more dummy cycles are expected, turn off snooping */
-        if (!s->snoop_dummies) {
-            s->snoop_index = SNOOP_OFF;
-        } else {
-            s->snoop_index += size;
-        }
-
-        /*
-         * Dummy cycles have been faked already. Ignore the current
-         * SPI transfer
-         */
-        return true;
-    }
-
-    s->snoop_index += size;
-    return false;
-}
-
 static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
                                    uint64_t data, unsigned size, MemTxAttrs attrs)
 {
@@ -652,10 +551,6 @@ static MemTxResult aspeed_smc_flash_write(void *opaque, hwaddr addr,
 
     switch (aspeed_smc_flash_mode(fl)) {
     case CTRL_USERMODE:
-        if (aspeed_smc_do_snoop(fl, data, size)) {
-            break;
-        }
-
         for (i = 0; i < size; i++) {
             ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
         }
@@ -717,7 +612,6 @@ static void aspeed_smc_flash_update_ctrl(AspeedSMCFlash *fl, uint32_t value)
     s->regs[s->r_ctrl0 + fl->cs] = value;
 
     if (unselect != s->unselect) {
-        s->snoop_index = unselect ? SNOOP_OFF : SNOOP_START;
         aspeed_smc_flash_do_select(fl, unselect);
     }
 }
@@ -763,9 +657,6 @@ static void aspeed_smc_reset_hold(Object *obj, ResetType type)
         aspeed_smc_flash_set_segment_region(s, i,
                     asc->segment_to_reg(s, &asc->segments[i]));
     }
-
-    s->snoop_index = SNOOP_OFF;
-    s->snoop_dummies = 0;
 }
 
 static MemTxResult aspeed_smc_read(void *opaque, hwaddr addr, uint64_t *data,
@@ -1293,11 +1184,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
 static const VMStateDescription vmstate_aspeed_smc = {
     .name = "aspeed.smc",
     .version_id = 3,
-    .minimum_version_id = 2,
+    .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSMCState, ASPEED_SMC_R_MAX),
-        VMSTATE_UINT8(snoop_index, AspeedSMCState),
-        VMSTATE_UINT8(snoop_dummies, AspeedSMCState),
+        VMSTATE_UNUSED_V(2, 2), /* was snoop_index/snoop_dummies */
         VMSTATE_BOOL_V(unselect, AspeedSMCState, 3),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/ssi/trace-events b/hw/ssi/trace-events
index 2f36cf96b8b..b9d86482974 100644
--- a/hw/ssi/trace-events
+++ b/hw/ssi/trace-events
@@ -2,7 +2,6 @@
 
 aspeed_smc_flash_set_segment(int cs, uint64_t reg, uint64_t start, uint64_t end) "CS%d segreg=0x%"PRIx64" [ 0x%"PRIx64" - 0x%"PRIx64" ]"
 aspeed_smc_flash_read(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
-aspeed_smc_do_snoop(int cs, int index, int dummies, int data) "CS%d index:0x%x dummies:%d data:0x%x"
 aspeed_smc_flash_write(int cs, uint64_t addr,  uint32_t size, uint64_t data, int mode) "CS%d @0x%" PRIx64 " size %u: 0x%" PRIx64" mode:%d"
 aspeed_smc_read(uint64_t addr,  uint32_t size, uint64_t data) "@0x%" PRIx64 " size %u: 0x%" PRIx64
 aspeed_smc_dma_checksum(uint32_t addr, uint32_t data) "0x%08x: 0x%08x"
-- 
2.53.0


