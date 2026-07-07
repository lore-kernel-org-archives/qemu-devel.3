Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1E4C44501
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:17:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh5fF-0005jx-9K; Tue, 07 Jul 2026 09:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5ec-00051Q-81
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wh5eZ-0000v6-Pb
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 09:16:02 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667C8hV13755523
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 13:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PvEHIfoCoc8dQMRaAWL8ad0pxGs2GL+p78susvLS+PA=; b=VNVpOLK+kcze12sm
 J6tX20b9ywxfdy/xP7cIEN6w8WDIfkyEezO+fJX9faLqciKBbhaWnVPVOXD/pUkO
 jJll7MUeFIWCQ5gPdq2KP8KD5wtKdORALep2AzMKJ5Wn121DF0SCwiW8IerKGbGq
 itu8x8Z1wKsEXroa531ifiOCIHB1wB/auTeh6TWG273i72jGHSgcSP5az1uL0/aJ
 3Hn80SrNVUjAV5v2Z01QRrmqYb/PKybf0qSxC93wMOZyiIRVvsXEX6zElh+azxVm
 3urw8C3VZTsDRcXpedLPLIeLcm/qLLQQ2gYu8X4JrpJIuHt8ucK6Zbf0CpqQcowE
 9LvA5g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8wep195p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 13:15:58 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51bf321d786so52331741cf.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783430157; x=1784034957; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PvEHIfoCoc8dQMRaAWL8ad0pxGs2GL+p78susvLS+PA=;
 b=eQGX4akNvR85y2k0RjxIlNjxDJNIw3gfHTOKde/rdfAHDlxbIrW26Rnx75/kxnoM2T
 +7rlD0jk+0GN5w1MN1OFWngjTx21vNwNFzLkDC/+aylaWbSmp/cGLpiK047efwoc+7iU
 Zj6dIKlQPkEb4CXik9dplquIir9TYrX/PGgt/k+vulvGM+Y5080GeQyOiLnDVVu48kCV
 BoJd673t7zYlqQjbu9b+uzXwDdBSXRpdm08dQ4nKX6YVQFl3Vq0U+KYAJO3O4ku0nukz
 QfT43RcvA5O2KD4Y2C9XDB3wKyhiMeyvEz9ms7kIMmAc7752xDnfRK971PNDmRqNQZPx
 Wa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783430157; x=1784034957;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PvEHIfoCoc8dQMRaAWL8ad0pxGs2GL+p78susvLS+PA=;
 b=QdXyN4d4wp7YQ4yR6q+xlA5P08Njy4eVxUtnGUCjiae7NYcV1rv5MAoBhLPpgoJqne
 RDsZGSZcACSx82q6E2NBX7iSQ4dVElPrYGyo7QUQjo2nelmNnITCljRIWqDG7rVOYtWL
 V2Y9wLYANX5i2tmILUFG3a8GPv1GuQ93aWibmrUhY5NpP/B8eOftBUoHQ+yUfRM3NbyA
 RmGqOqfTy+ex79NZd7ZpFOkSTbt+ce3E7PA2ePHhNtUJ8LIAcZGEx/5Bp+ULftKkbgJN
 z7j2dqLbiiqx+TzuZ3McYnOD1RfxZjRYG728lO+E85l3+nuvecHRyuevAqu3qU9JceYg
 VeXA==
X-Gm-Message-State: AOJu0YzaXCorAsrxzKlzMYDuUGvE31jKhtOlhPnxtJw/UEQs6FlTTe0x
 gH7lbS/IIL7i2GMOPDQzn6/m3gIlRnLQVvPs73/F/meQlAVMM3VHWw5J8V6LiULknMJZGplD0eR
 E4FMBSvEzzU+pQuSI4qOQY6aLgid1SjVu5bT3Au7vSUimEqq+OBdkymxYC93HbOQYGA==
X-Gm-Gg: AfdE7cmgxQeAUTfCQpszd7Fiky2HO9gD1/0Rl819oMwpssbZsli4HEqaXpU1/FE92AM
 QXJeUsy1IttrZAHEOrADBm6viDZc7Pes30S6y1bpS1dWoN+bzfAS09t9mzeM0ON3n2/fw/D8+6B
 lmDAElW8wCICEKOgOGTlI6HGpitXUMnfuBWtciScUUSmDfe3vyR1S4k245wI9m8nFWARr/0zEqJ
 Zt/Koixcp5lmaaW4tHe24pIkH/P1u7eC6LQpOslZRXNQPxogE9fJYq+hNUBPcc3dfqbdj3a/aBG
 HjTy081uW/z0IgYkD2ff+SCu5u49l4uaksuGwkKYjUS7+Lvlrcmql3rUCgkrQuS3EJeFbYEdBiJ
 imgDlWjk7NTc7ZJXgxp4/unlFhVB0xBUNl4TnOTwLB3AnwpHTcEPr2sgcyN2HaExhOAuq
X-Received: by 2002:a05:622a:c01:b0:51c:22c5:daf4 with SMTP id
 d75a77b69052e-51c747cf3edmr50459111cf.28.1783430157006; 
 Tue, 07 Jul 2026 06:15:57 -0700 (PDT)
X-Received: by 2002:a05:622a:c01:b0:51c:22c5:daf4 with SMTP id
 d75a77b69052e-51c747cf3edmr50458221cf.28.1783430155876; 
 Tue, 07 Jul 2026 06:15:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19d9e701sm6141180a12.21.2026.07.07.06.15.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Jul 2026 06:15:55 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 29/32] hw/ssi: xilinx_spips: Fix dummy phase handling
Date: Tue,  7 Jul 2026 15:12:19 +0200
Message-ID: <20260707131223.51505-30-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260707131223.51505-1-philmd@oss.qualcomm.com>
References: <20260707131223.51505-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: y-Mana4ktGwGklVXgBvyrWLQKL1xV81I
X-Proofpoint-ORIG-GUID: y-Mana4ktGwGklVXgBvyrWLQKL1xV81I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX5qL2oIDd5ZwY
 IHG6FJJVBxy/UY1zsyY3OmRFKOSbHsd2x0NRhB94Gd7AeWrUikeOB8U80e4M9riEqJw42YLYGXE
 yi2+mAm5zTJch3NwJIM1BWwwaPdrr/sX4KshCYCukl+x/tdvFElwBYIxIBod4wYWGX082p2eOcP
 mXlqb81ec5T+nguGkNSfk3v7rA1W/RGX+i/Jc89fcu3+pS/n0Oyhq4bHZN7BAWQ+IyEQJZeVjHR
 gPcVehg2duQuxvHxK87tQURGje4vahl7KjFMHSioQv9bssjbcn/TCKpr/stNboUZ2UJy0LI6m/f
 pdwfumjWj2Xh8sxG8fXeUZiNNST2dL4YmEgpTXOoVVAB4WnR2finuyeyodYM+uP42NMLGZO7kRg
 H5FshY+eOLue4CftmtYSuNBLsD4Pmb/Dvg0fWpOp1PLLzz5DYEB5rh026Wj9SE1qaialp8bAOWa
 QlJz78TfkIw6wD0PIng==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEyOSBTYWx0ZWRfX8fxUyX9Do2OU
 WJ1poDfxXqAhqtNTg7c0j+QSQAi8sP4E7XHeryTyqD1FXhalCkJ+nCL4sCpcxrCvE/VP8pruN9p
 k2W+IXWCHzN+uYtPCUrR/K2aFpVjesk=
X-Authority-Analysis: v=2.4 cv=atSCzyZV c=1 sm=1 tr=0 ts=6a4cfc0e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Am4ss40yAAAA:8 a=FRSEYCzRAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=058f9aFXmwy2ZMPPIcsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=lf-hbUz_c89dky27wAWH:22 a=H4N_Y-AU75W7NKDNhZlT:22
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

The ZynqMP generic FIFO encodes dummy phases as a number of
dummy cycles. QEMU's SSI bus transfers whole bytes, so the
controller model must convert the programmed cycle count to the
number of SSI byte transfers needed for the selected SPI, dual SPI
or quad SPI mode.

The legacy Xilinx QSPI snoop paths had the opposite problem after
the m25p80 dummy handling was fixed. They still treated each dummy
byte queued through the FIFO as a request to generate several SSI
transfers based on the current link width. The flash model now
consumes dummy phases as byte counts, so the manual FIFO path should
forward one SSI transfer per dummy byte.

Update the Xilinx QSPI dummy accounting consistently for the generic
FIFO, manual FIFO and LQSPI direct-read paths. Also make the command
table report the dummy byte counts consumed by m25p80 for dual and
quad output reads, and account for the mode byte before LQSPI data
reads begin.

This matches the ZynqMP TRM (ug1085, v2.2 [1]) description of the
generic FIFO dummy cycle entry and keeps the controller side aligned
with the flash model's dummy byte ownership.

The description of the generic command fifo register says:

  When [receive, transmit, data_xfer] = [0,0,1], the [immediate_data]
  field represents the number of dummy cycle sent on the SPI interface.

[1] https://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf
    table 24‐22, an example of Generic FIFO Contents for Quad I/O Read Command (EBh)

Fixes: ef06ca3946e2 ("xilinx_spips: Add support for RX discard and RX drain")
Fixes: c95997a39de6 ("xilinx_spips: Add support for the ZynqMP Generic QSPI")
Signed-off-by: Bin Meng <bin.meng@processmission.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20260707083431.219671-7-bin.meng@processmission.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/ssi/xilinx_spips.h |   2 +-
 hw/ssi/xilinx_spips.c         | 123 +++++++++++++++++++++++++---------
 2 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/include/hw/ssi/xilinx_spips.h b/include/hw/ssi/xilinx_spips.h
index c8f6c5053c4..d1eefa4ba67 100644
--- a/include/hw/ssi/xilinx_spips.h
+++ b/include/hw/ssi/xilinx_spips.h
@@ -69,7 +69,7 @@ struct XilinxSPIPS {
     uint8_t num_busses;
 
     uint8_t snoop_state;
-    int cmd_dummies;
+    int cmd_dummy_bytes;
     uint8_t link_state;
     uint8_t link_state_next;
     uint8_t link_state_next_when;
diff --git a/hw/ssi/xilinx_spips.c b/hw/ssi/xilinx_spips.c
index f6e717bc019..e4fce2c1957 100644
--- a/hw/ssi/xilinx_spips.c
+++ b/hw/ssi/xilinx_spips.c
@@ -192,6 +192,10 @@
     FIELD(GQSPI_GF_SNAPSHOT, EXPONENT, 9, 1)
     FIELD(GQSPI_GF_SNAPSHOT, DATA_XFER, 8, 1)
     FIELD(GQSPI_GF_SNAPSHOT, IMMEDIATE_DATA, 0, 8)
+#define GQSPI_GF_MODE_SPI     1
+#define GQSPI_GF_MODE_DSPI    2
+#define GQSPI_GF_MODE_QSPI    3
+
 #define R_GQSPI_MOD_ID        (0x1fc / 4)
 #define R_GQSPI_MOD_ID_RESET  (0x10a0000)
 
@@ -237,7 +241,7 @@ static void xilinx_spips_update_cs(XilinxSPIPS *s, int field)
     }
     if (!(field & ((1 << (s->num_cs * s->num_busses)) - 1))) {
         s->snoop_state = SNOOP_CHECKING;
-        s->cmd_dummies = 0;
+        s->cmd_dummy_bytes = 0;
         s->link_state = 1;
         s->link_state_next = 1;
         s->link_state_next_when = 0;
@@ -382,7 +386,7 @@ static void xilinx_spips_reset(DeviceState *d)
     s->link_state_next = 1;
     s->link_state_next_when = 0;
     s->snoop_state = SNOOP_CHECKING;
-    s->cmd_dummies = 0;
+    s->cmd_dummy_bytes = 0;
     s->man_start_com = false;
     xilinx_spips_update_ixr(s);
     xilinx_spips_update_cs_lines(s);
@@ -457,6 +461,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
         int i;
 
         if (!s->regs[R_GQSPI_DATA_STS]) {
+            uint32_t prev_gf_snapshot = s->regs[R_GQSPI_GF_SNAPSHOT];
             uint8_t imm;
 
             s->regs[R_GQSPI_GF_SNAPSHOT] = fifo32_pop(&s->fifo_g);
@@ -484,7 +489,57 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
                 }
                 s->regs[R_GQSPI_DATA_STS] = 1ul << imm;
             } else {
-                s->regs[R_GQSPI_DATA_STS] = imm;
+                /*
+                 * When [receive, transmit, data_xfer] = [0,0,1], it represents
+                 * the number of dummy cycle sent on the SPI interface. We need
+                 * to convert the number of dummy cycles to bytes according to
+                 * the SPI mode being used.
+                 *
+                 * Ref: ug1085 v2.2 (December 2020) table 24‐22, an example of
+                 *      Generic FIFO Contents for Quad I/O Read Command (EBh)
+                 */
+                if (!ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, TRANSMIT) &&
+                    !ARRAY_FIELD_EX32(s->regs, GQSPI_GF_SNAPSHOT, RECIEVE)) {
+                    uint8_t spi_mode = ARRAY_FIELD_EX32(s->regs,
+                                                        GQSPI_GF_SNAPSHOT,
+                                                        SPI_MODE);
+                    /*
+                     * Some ZynqMP GQSPI drivers, such as Linux, use the data
+                     * bus width in the dummy GENFIFO entry only to configure
+                     * the controller mode. The immediate value is already
+                     * the number of dummy cycles for the dummy phase, which
+                     * follows the address bus width. Reuse the previous TX
+                     * phase mode to convert cycles to SSI bytes.
+                     *
+                     * This does not make the model Linux-only. U-Boot emits
+                     * the dummy entry with op->dummy.buswidth, so the entry
+                     * mode already matches the dummy phase. Its opcode and
+                     * address phases are immediate entries, not DATA_XFER TX
+                     * entries, so the override below is not taken for U-Boot.
+                     */
+                    if (FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                   DATA_XFER) &&
+                        FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                   TRANSMIT) &&
+                        !FIELD_EX32(prev_gf_snapshot, GQSPI_GF_SNAPSHOT,
+                                    RECIEVE)) {
+                        spi_mode = FIELD_EX32(prev_gf_snapshot,
+                                              GQSPI_GF_SNAPSHOT, SPI_MODE);
+                    }
+
+                    if (spi_mode == GQSPI_GF_MODE_QSPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 4, 8) / 8;
+                    } else if (spi_mode == GQSPI_GF_MODE_DSPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 2, 8) / 8;
+                    } else if (spi_mode == GQSPI_GF_MODE_SPI) {
+                        s->regs[R_GQSPI_DATA_STS] = ROUND_UP(imm * 1, 8) / 8;
+                    } else {
+                        qemu_log_mask(LOG_GUEST_ERROR,
+                                      "Unknown SPI MODE: 0x%x ", spi_mode);
+                    }
+                } else {
+                    s->regs[R_GQSPI_DATA_STS] = imm;
+                }
             }
         }
         /* Zero length transfer check */
@@ -550,7 +605,7 @@ static void xlnx_zynqmp_qspips_flush_fifo_g(XlnxZynqMPQSPIPS *s)
     }
 }
 
-static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
+static int xilinx_spips_num_dummy_bytes(XilinxQSPIPS *qs, uint8_t command)
 {
     if (!qs) {
         /* The SPI device is not a QSPI device */
@@ -567,10 +622,11 @@ static int xilinx_spips_num_dummies(XilinxQSPIPS *qs, uint8_t command)
     case QPP_4:
         return 0;
     case FAST_READ:
-    case DOR:
-    case QOR:
     case FAST_READ_4:
+        return 1;
+    case DOR:
     case DOR_4:
+    case QOR:
     case QOR_4:
         return 1;
     case DIOR:
@@ -611,7 +667,6 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         int i;
         uint8_t tx = 0;
         uint8_t tx_rx[MAX_NUM_BUSSES] = { 0 };
-        uint8_t dummy_cycles = 0;
         uint8_t addr_length;
 
         if (fifo8_is_empty(&s->tx_fifo)) {
@@ -631,26 +686,18 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
                 tx_rx[i] = tx;
             }
         } else {
-            /*
-             * Extract a dummy byte and generate dummy cycles according to the
-             * link state
-             */
             tx = fifo8_pop(&s->tx_fifo);
-            dummy_cycles = 8 / s->link_state;
+            for (i = 0; i < num_effective_busses(s); ++i) {
+                tx_rx[i] = tx;
+            }
         }
 
         for (i = 0; i < num_effective_busses(s); ++i) {
             int bus = num_effective_busses(s) - 1 - i;
-            if (dummy_cycles) {
-                int d;
-                for (d = 0; d < dummy_cycles; ++d) {
-                    tx_rx[0] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[0]);
-                }
-            } else {
-                DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
-                tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
-                DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
-            }
+
+            DB_PRINT_L(debug_level, "tx = %02x\n", tx_rx[i]);
+            tx_rx[i] = ssi_transfer(s->spi[bus], (uint32_t)tx_rx[i]);
+            DB_PRINT_L(debug_level, "rx = %02x\n", tx_rx[i]);
         }
 
         if (s->regs[R_CMND] & R_CMND_RXFIFO_DRAIN) {
@@ -685,9 +732,9 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
         switch (s->snoop_state) {
         case (SNOOP_CHECKING):
             /* Store the count of dummy bytes in the txfifo */
-            s->cmd_dummies = xilinx_spips_num_dummies(q, tx);
+            s->cmd_dummy_bytes = xilinx_spips_num_dummy_bytes(q, tx);
             addr_length = get_addr_length(s, tx);
-            if (s->cmd_dummies < 0) {
+            if (s->cmd_dummy_bytes < 0) {
                 s->snoop_state = SNOOP_NONE;
             } else {
                 s->snoop_state = SNOOP_ADDR + addr_length - 1;
@@ -697,14 +744,14 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             case DOR:
             case DOR_4:
                 s->link_state_next = 2;
-                s->link_state_next_when = addr_length + s->cmd_dummies;
+                s->link_state_next_when = addr_length + s->cmd_dummy_bytes;
                 break;
             case QPP:
             case QPP_4:
             case QOR:
             case QOR_4:
                 s->link_state_next = 4;
-                s->link_state_next_when = addr_length + s->cmd_dummies;
+                s->link_state_next_when = addr_length + s->cmd_dummy_bytes;
                 break;
             case DIOR:
             case DIOR_4:
@@ -720,10 +767,10 @@ static void xilinx_spips_flush_txfifo(XilinxSPIPS *s)
             /*
              * Address has been transmitted, transmit dummy cycles now if needed
              */
-            if (s->cmd_dummies < 0) {
+            if (s->cmd_dummy_bytes < 0) {
                 s->snoop_state = SNOOP_NONE;
             } else {
-                s->snoop_state = s->cmd_dummies;
+                s->snoop_state = s->cmd_dummy_bytes;
             }
             break;
         case (SNOOP_STRIPING):
@@ -1152,11 +1199,13 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
     XilinxQSPIPS *q = opaque;
     XilinxSPIPS *s = opaque;
     int i;
+    int dummy_bytes;
     int flash_addr = ((addr & ~(LQSPI_CACHE_SIZE - 1))
                    / num_effective_busses(s));
     int peripheral = flash_addr >> LQSPI_ADDRESS_BITS;
     int cache_entry = 0;
     uint32_t u_page_save = s->regs[R_LQSPI_STS] & ~LQSPI_CFG_U_PAGE;
+    uint8_t command;
 
     if (addr < q->lqspi_cached_addr ||
             addr > q->lqspi_cached_addr + LQSPI_CACHE_SIZE - 4) {
@@ -1170,10 +1219,10 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
         fifo8_reset(&s->rx_fifo);
 
         /* instruction */
+        command = s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE;
         DB_PRINT_L(0, "pushing read instruction: %02x\n",
-                   (unsigned)(uint8_t)(s->regs[R_LQSPI_CFG] &
-                                       LQSPI_CFG_INST_CODE));
-        fifo8_push(&s->tx_fifo, s->regs[R_LQSPI_CFG] & LQSPI_CFG_INST_CODE);
+                   (unsigned)command);
+        fifo8_push(&s->tx_fifo, command);
         /* read address */
         DB_PRINT_L(0, "pushing read address %06x\n", flash_addr);
         if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_ADDR4) {
@@ -1183,14 +1232,22 @@ static void lqspi_load_cache(void *opaque, hwaddr addr)
         fifo8_push(&s->tx_fifo, (uint8_t)(flash_addr >> 8));
         fifo8_push(&s->tx_fifo, (uint8_t)flash_addr);
         /* mode bits */
+        dummy_bytes = xilinx_spips_num_dummy_bytes(q, command);
         if (s->regs[R_LQSPI_CFG] & LQSPI_CFG_MODE_EN) {
             fifo8_push(&s->tx_fifo, extract32(s->regs[R_LQSPI_CFG],
                                               LQSPI_CFG_MODE_SHIFT,
                                               LQSPI_CFG_MODE_WIDTH));
+            if (dummy_bytes > 0) {
+                dummy_bytes--;
+            }
+        }
+        if (dummy_bytes < 0) {
+            dummy_bytes = extract32(s->regs[R_LQSPI_CFG],
+                                    LQSPI_CFG_DUMMY_SHIFT,
+                                    LQSPI_CFG_DUMMY_WIDTH);
         }
         /* dummy bytes */
-        for (i = 0; i < (extract32(s->regs[R_LQSPI_CFG], LQSPI_CFG_DUMMY_SHIFT,
-                                   LQSPI_CFG_DUMMY_WIDTH)); ++i) {
+        for (i = 0; i < dummy_bytes; ++i) {
             DB_PRINT_L(0, "pushing dummy byte\n");
             fifo8_push(&s->tx_fifo, 0);
         }
-- 
2.53.0


