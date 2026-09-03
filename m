Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091EBC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:40:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24rZ-0004VS-Ec; Thu, 03 Sep 2026 06:40:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rO-0004Rt-KT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x24rM-0006AZ-ME
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:39:58 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683AHAs2212400
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 10:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rj9HFNqOvL6W+iuHT3IkTS3/R63iSdtXObzNE9q86hI=; b=AuHn1PX1GFl0/QMN
 2k/YDsyG0qYYB9cNXVEOyvdp1G79mjX8kVU4OyihHa/QyjgUrnp+tVa6Rq33yba7
 cISRN6pspSk0FpXHURfEbk4mqfa4n3+jQpJ2SMo8qlfyLDZEzDlQgO9DjjXjZFp1
 OSZnkiuox2H40FjF2oMWw9CtJokuBWdRvOkecvWMCpRIuDrjTvakcUpPqDQUCtzr
 nCU5uw92T9T2L/V891+B1E86Pkp3BW4R6Bu5tysXQWA2XQhPrLY3g7sA6NUjd+eG
 3wQWoAMLiZerjCrARGiiufdusrsmtwoVFMPJaX1mSJ6f+2h/bJZHMSXhhQ/bxU2f
 44wMWg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyhfka-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 10:39:55 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390a2c895bso579064885a.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788431994; x=1789036794; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rj9HFNqOvL6W+iuHT3IkTS3/R63iSdtXObzNE9q86hI=;
 b=Esi3XnHeggb8ywL6u5m+HuvnSA1p7yhTgYDhDNJXJhZFzv1h3qAjP39mFjBeEM5cCp
 V/hIoVpmjlwyDYWFsUxIrqyAg3c8ULuK5aF29dH+AWNJTb7hEVVWeYMdqyR3OyF0YwKI
 R/+d/jQMSQqqIS0+bMRov+EF+D8CUImh71MoZfD0THPKB4rMsVTAmPTv6quiBYZgLDDH
 y80ngOlmh43RBvPunyvd3tMFfKBvB4WMvWLiPOVuZ3yy2l9EPivkcEWSW9tUAD931l6W
 6Wf7iHiqHXx6bhQlUn0+Iw4YtxnGaAJLXKiRnvpI6I0CQFJcWxSXE5DDQAEJmhHi/uHt
 6axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788431994; x=1789036794;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rj9HFNqOvL6W+iuHT3IkTS3/R63iSdtXObzNE9q86hI=;
 b=RrW79H3HGZXc8ptiTjDuMvFzgm/SRZHaL6cX3gjOEFLHDwkD1g3dbi/hp8UaUc2Wjv
 D1lvsZhV5MixcUo3QmgXj9hCovCVpedSC1lLSFcr2cuCVBRHS6oPMRyvDAYZiUydmoDt
 Snl/u2Gr/0DSlEDC0/WeFtlDpE5zboquJTSOOQmLgZ8NwTwdzrZ3/mHHO6oP47QHmoem
 RtTil34G9DNUC9TUUaMhNQa2M9O6KE75WWb1LBjpXyJ+oOlccEvD5rUls+1TDfeGM1tc
 Uy4WvlIz8Sc5AajlrM38s6Knj/b+wd7G9UFB9wtRdelhjpVdJPma2WEzha03Sq2fAqEj
 e7ag==
X-Gm-Message-State: AFuF++mUcDU6aEifh/KQw+SUxlfR20ycNQ2VRwDaSbwW/N8iPQC0XOwT
 t6IP8z40PbYd81kut3pdoH7L6ZOfzWOR2kksyGpxd/DDeyhdTVZ0kYdFcfqqvGcO3bbkzFRoh7B
 1VjFYJea46K6CQArnsbYIMkD2rHZeLTnxwABPmxSSXRDvBaiNHEyMx2rxkqq6hT86Ew==
X-Gm-Gg: AYBFou3JPvZnuLONTCBN6RspAopQ4L5tBRFBVIhq+l/ES3Je+N3bPKbHxeAFsyar0Pw
 ArmJOIzf5ayK4PoiYtcUzYCpVrUw6m38wyc5sG0vQKFPaKhkdkcfvC0FeBgeK9HB9IhyeV0Q5ca
 HaKUUi7ha828MuWYQTUcbXsDWidCje2jv3DABdq0bpNVbN8OmQZRHZPY+HQEOtVjqake+4Pn8C8
 QvhTTVTRV4hL5POFNH9TFe1de4WZhBUTWJbVyWBTzeOJjcx9jjeSHGqFdU+2GQWq+ONCKr2r+sk
 d5CtOW7VaKCg5lmHTECrrVQqDsqmGkWQpLPhz61aZNLUSuSgX6sAvmEBoAXB3/EkEsMmPSb195Y
 K4fVG8bmxZOODb/w/LJ7oa2dUH29n4Yt8ZFnRgJIq
X-Received: by 2002:a05:620a:2992:b0:939:7835:8f87 with SMTP id
 af79cd13be357-9397835926dmr134622085a.17.1788431994002; 
 Thu, 03 Sep 2026 03:39:54 -0700 (PDT)
X-Received: by 2002:a05:620a:2992:b0:939:7835:8f87 with SMTP id
 af79cd13be357-9397835926dmr134617485a.17.1788431993328; 
 Thu, 03 Sep 2026 03:39:53 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e72c28sm13900890f8f.6.2026.09.03.03.39.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Sep 2026 03:39:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/51] hw/sd: sdhci: Fix SDMA boundary bug
Date: Thu,  3 Sep 2026 12:38:46 +0200
Message-ID: <20260903103936.62355-3-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903103936.62355-1-philmd@oss.qualcomm.com>
References: <20260903103936.62355-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX78akgPch3n55
 OA4I7xfXn1wlkcr7QgDq3nKB5DzWR2dSPFQszBpW/ExkNrWNbISUzMzBSGMdJzo19sBQ/Z9o9XE
 MbGGvOpg1AsHu4rTqsIugbx8x82lna7mcpba7xKQETyiz7dH1Yxe70pzVJiHsIT5Ap1Xe7NNn+H
 Ho/miLfOn9LEJrXg5/dHke5S4vYt/4k8br3N+w2cpPYv96TQFCArGnqiPNNPVFVNhS3TRZIOPbS
 qgM4eBmRgGU3VMXDPAT0j4UfZv2jt3E+kNif6OonqsN6WKRENybm200xgZtEosXa5ZnKXCyxlSi
 +1ZYvv3SUtWllNcclvy19KRsLNiN9VwPHdlHyd5OpAlqjMbCHDmWui4u/NEy4LvjgIhUXPtt1/8
 wuwly+ivSWm2MWub95iByJNnIQCs4UzHDwvfV3CdSXRYklrlfUGtVM1E7dGh+gIZT0Xwqeux7cr
 9udCMJU6haNycvFVLdQ==
X-Proofpoint-ORIG-GUID: dnXmfqhdS1LbU7PIsy2HqXJkZ3ztWh_S
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA5MiBTYWx0ZWRfX3zrT0I4PlMTG
 hbU2Ub68tj8FiOe8uTJ/TkhnYk/roos3wXtOMLiCqD1cEJdX5fAC4xdfS1coEV89qwHae/bNSwL
 8LY0g7jydANim04ErEOtxv75VvtrEJY=
X-Proofpoint-GUID: dnXmfqhdS1LbU7PIsy2HqXJkZ3ztWh_S
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a994e7b cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=Byx-y9mGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fbXbqCvtxzTOMWPQE0UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030092
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

From: Tao Ding <dingtao0430@163.com>

During SDMA transfers, the controller raises an interrupt at buffer boundaries
to request a system address update. The host driver will rewrite the SDHC_SYSAD register.
(according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.pdf section 2.2.1)
However, the current code will ignore write operations to SDHC_SYSAD.

To fix this bug, when SDMA encounters a boundary, a state is set to record it.
In this state, SDHC_SYSAD can be written. In other cases, it is still protected by TRANSFERRING_DATA.

Meanwhile, a subsection has been added for migration.

Suggested-by: Bin Meng <bmeng.cn@gmail.com>
Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
Message-ID: <20260715160731.29969-2-dingtao0430@163.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/hw/sd/sdhci.h |  2 ++
 hw/sd/sdhci.c         | 54 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
index a9da6203fcb..c485277744e 100644
--- a/include/hw/sd/sdhci.h
+++ b/include/hw/sd/sdhci.h
@@ -103,6 +103,8 @@ struct SDHCIState {
      * to be protected. Set wp_inverted to invert the signal.
      */
     bool wp_inverted;
+    /* Indicate that SDMA transfer is paused due to hitting the boundary */
+    bool sdma_boundary_paused;
 };
 typedef struct SDHCIState SDHCIState;
 
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e58a6103970..02f09187272 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -307,6 +307,7 @@ static void sdhci_reset(SDHCIState *s)
     s->data_count = 0;
     s->stopped_state = sdhc_not_stopped;
     s->pending_insert_state = false;
+    s->sdma_boundary_paused = false;
     if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
             object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
         s->norintstsen = 0x013f;
@@ -414,6 +415,7 @@ static void sdhci_end_transfer(SDHCIState *s)
         s->norintsts |= SDHC_NIS_TRSCMP;
     }
 
+    s->sdma_boundary_paused = false;
     sdhci_update_irq(s);
 }
 
@@ -681,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCIState *s)
     if (s->blkcnt == 0) {
         sdhci_end_transfer(s);
     } else {
+        s->sdma_boundary_paused = true;
         sdhci_update_irq(s);
     }
 }
@@ -717,6 +720,15 @@ static void sdhci_sdma_transfer(SDHCIState *s)
     }
 }
 
+static bool sdhci_sdma_transfer_active(SDHCIState *s)
+{
+    return TRANSFERRING_DATA(s->prnsts) &&
+            (s->trnmod & SDHC_TRNS_DMA) &&
+            s->blkcnt &&
+            (s->blksize & BLOCK_SIZE_MASK) &&
+            SDHC_DMA_TYPE(s->hostctl1) == SDHC_CTRL_SDMA;
+}
+
 typedef struct ADMADescr {
     hwaddr addr;
     uint16_t length;
@@ -1164,6 +1176,7 @@ static inline void sdhci_reset_write(SDHCIState *s, uint8_t value)
                 SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
         s->blkgap &= ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
         s->stopped_state = sdhc_not_stopped;
+        s->sdma_boundary_paused = false;
         s->norintsts &= ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
                 SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
         break;
@@ -1185,7 +1198,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
 
     switch (offset & ~0x3) {
     case SDHC_SYSAD:
-        if (!TRANSFERRING_DATA(s->prnsts)) {
+        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
             s->sdmasysad = (s->sdmasysad & mask) | value;
             MASKED_WRITE(s->sdmasysad, mask, value);
             /* Writing to last byte of sdmasysad might trigger transfer */
@@ -1464,6 +1477,31 @@ static bool sdhci_pending_insert_vmstate_needed(void *opaque)
     return s->pending_insert_state;
 }
 
+static bool sdhci_sdma_boundary_paused_vmstate_needed(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    return s->sdma_boundary_paused;
+}
+
+static int sdhci_pre_load(void *opaque)
+{
+    SDHCIState *s = opaque;
+
+    s->sdma_boundary_paused = false;
+    return 0;
+}
+
+static int sdhci_post_load(void *opaque, int version_id)
+{
+    SDHCIState *s = opaque;
+
+    if (!s->sdma_boundary_paused) {
+        s->sdma_boundary_paused = sdhci_sdma_transfer_active(s);
+    }
+    return 0;
+}
+
 static const VMStateDescription sdhci_pending_insert_vmstate = {
     .name = "sdhci/pending-insert",
     .version_id = 1,
@@ -1475,10 +1513,23 @@ static const VMStateDescription sdhci_pending_insert_vmstate = {
     },
 };
 
+static const VMStateDescription sdhci_sdma_boundary_paused_vmstate = {
+    .name = "sdhci/sdma_boundary_paused",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = sdhci_sdma_boundary_paused_vmstate_needed,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 const VMStateDescription sdhci_vmstate = {
     .name = "sdhci",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = sdhci_pre_load,
+    .post_load = sdhci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(sdmasysad, SDHCIState),
         VMSTATE_UINT16(blksize, SDHCIState),
@@ -1512,6 +1563,7 @@ const VMStateDescription sdhci_vmstate = {
     },
     .subsections = (const VMStateDescription * const []) {
         &sdhci_pending_insert_vmstate,
+        &sdhci_sdma_boundary_paused_vmstate,
         NULL
     },
 };
-- 
2.53.0


