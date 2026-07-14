Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 452CBC44507
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:36:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjiv5-0001ZE-Oy; Tue, 14 Jul 2026 15:35:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiv4-0001Z6-V0
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjiv3-00055l-2x
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 15:35:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EIxKaF1481546
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Wi/yH2BAkmWSY8q/5WbL83633G2Lv6HztDay1MN7yEE=; b=Z/6heRxQMkB5oRYY
 1CiCqcVIVKK7uH+M6nnS6pazAL5wVgVYwFDoUzIRM0fIO05lYvNT1xy3GCkK5ew1
 g2MR7gmo7Fr1NQqmzmDnUj9/iy4JQDrlM8BL6iFyIw28Rl9yFKIV8x8tvh2sfnhQ
 qBijrInN/Jl5++cMLlnPDBjwAzstTFhCpP5x3iShIjuJ8XDX8uxWqlEFzaMP58EK
 wMP2GSMKGg28+AU6eieFKgnIKug457eTXQ/ubNjY+K9vU9nZ7ghrAhyQfRCWsyJf
 PXqu0nWj2PBJvWHge4cl6GPXeMTk4UKkCBQW6FhsWTVDeFWsJw1hef75EO8n08nE
 aJaptQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdgudjt14-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 19:35:51 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso73393831cf.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 12:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784057751; x=1784662551; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Wi/yH2BAkmWSY8q/5WbL83633G2Lv6HztDay1MN7yEE=;
 b=jW1flvxqCqVIX4Ge1qWaiP91Sxu11F+Pq+VWtkPTOGxM7Vpu08zuqvzSX8ikaOwIeI
 3MAYKx7yJqWkYKbpc6H6l7y4k/3nTllQoKxJZkpPEgNJEHz0Izq16ZF9F7wiRNg0oeeJ
 E9rg7NuNR+bnNBgzRU1fBTtn4VRd7KpTDVk2oh5Ps+FncH2OEx7crv2aqRfidsqyOwPR
 rT/DOPp0MwZMfQMXD/oZCHYrP/7Ze99e26rlfnvxZjnC4YJFGyUp9cDz3CBeAL117Iqo
 YFrzJLT7WJb3wbmfFW3sdd9Db5fMEE7cJvDBO6juvUuXUWmEAdzpHAoT0sDIQcJtI0KH
 pYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784057751; x=1784662551;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Wi/yH2BAkmWSY8q/5WbL83633G2Lv6HztDay1MN7yEE=;
 b=SqI9UiW3Tpnov1c9pTCbpCL3Ddue/fn/NEctmwGh41QRDdugjEwJBPh13BQ120iL/C
 wtWIHa4CsulIq1uOv/2zwHjdkFrFMkbGGV2EqkT9hETNvcUXngjJnpgq9iFdK7ZAf1tY
 IYAoN5IfD6d5VGGBVxe94ZXHizvQYR5X/dCW7k1GsuKv4PDU9eQgXrOoiUaOGM1KZ8Ue
 NcHUNSN+gizD2pbSZzrW2K1LIEatbSbfoL9WikySMhHJd69ze37cQIjW2szJsjrKiz8o
 fV35g5exYkF9jor0PMTuqwuXJxp8NOPtzLXMeEx89bpFDfr9OKniva/Cm49y9TqcLb8n
 ao4A==
X-Gm-Message-State: AOJu0YwTj4Sk38rtEzAx2FhKXHEVWa+2oMmOMUPMyD2wYqqCRyG22WTy
 lbFGRHidihT83WO06itZMV4AOAgpk0kVN5c7JBik1VFdEj6AykyrF9hOs1GbTNNz1PeR0eNZIYF
 Kczcd/YL/pcXAgYFCO1ePCRxCQ/keTncFw704J2N8s9i7UdhTFBTWUKhQiPNctilFow==
X-Gm-Gg: AfdE7cm0SRTP5tUW/glrCBpDlPpMe5pDfhZGQRMvHlxF5bldC3eGR7Mpj5eEHsDQPD5
 jAbjlxePWJHE/WKU8SqgSINm/OjeI6It/i3QGuHFu3dUJveU0npyExNsAfJouIapxCebmTKXErW
 G9rB0AbP/Irwh2IoEgDTjCIJgdZZVlHYwfL+ZaaTusHWHvLnHRp+7mZ+V1mS0iz3dDmi/WIncev
 N7FhyY7dFSZ6fJIRCFGydTIqvCWcbiGT906+q6zSxr64sVjUU6f5KbkIV2J4Mgg8SKdRlJ7dd1j
 ppHMO8LFN0Uli+WuM0uZfIQgvpDyN7JI+Vdy8t1K8FUKlmFDDq/KR9S6rhfZr6sKxv6p+5L5PgH
 RVMC+I/5tWwRiVjs6SC+iMBVxLfhixpW+nGEKUTX65taCvVjNCLlQU9LxaURVlZVJapkk
X-Received: by 2002:a05:622a:1c18:b0:51c:7b12:6000 with SMTP id
 d75a77b69052e-51e4f22de1fmr204061cf.76.1784057751247; 
 Tue, 14 Jul 2026 12:35:51 -0700 (PDT)
X-Received: by 2002:a05:622a:1c18:b0:51c:7b12:6000 with SMTP id
 d75a77b69052e-51e4f22de1fmr203671cf.76.1784057750475; 
 Tue, 14 Jul 2026 12:35:50 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950873270esm89620715e9.6.2026.07.14.12.35.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 14 Jul 2026 12:35:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 04/13] hw/scsi/vmw_pvscsi: translate data endianness
Date: Tue, 14 Jul 2026 21:35:08 +0200
Message-ID: <20260714193517.60708-5-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714193517.60708-1-philmd@oss.qualcomm.com>
References: <20260714193517.60708-1-philmd@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UGqz76woKj9P9O-5XoTnNlrvPo6Nm1wP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX3EdIwhDXHxBm
 thXJYykuU/I+W2qEke8/3wNyYbXPmBF4ChlazK4XjOOu9eNHIpeND/HUR6ymn1dOVSWyCWET1U3
 x5yq4SADWJqp5Ir93OVGBddDSLuBLqqPTnZX/321ylvqTG5SUI3RZI33+rvgWYsfAyMsumI5nkj
 jhWx5n0yNEbUconf5r0sW1lUagJnQq+BmJ22aKeTashVcx2thWANTZC4DbGyjYYdgyZcgC/b3+j
 a3z9loZQW+dmKEtnQSfSj52oUjDKquPwrFg9sSsdbXyGr6cs5Mi2V7dzrNXwJ7HGB2wQaq36sek
 OCaDRFksUjRHqMgP5ajAt6/Uq/TJbXWP46s217WDfqaDiUG0MraHQREo3RzmuzbdyLqhdh6wKSD
 HT1k13Rc0lAhXRbRlXA2zEOWvA9j2woTRuzLp2cK1yWFWWxey3tLHzcQLdmm4RGClWkGp1UtrcO
 fk+Xt8DyHSn9AOAtMpg==
X-Authority-Analysis: v=2.4 cv=T/O8ifKQ c=1 sm=1 tr=0 ts=6a568f98 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=bo06jjfrt4HcdEXMXB8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwMiBTYWx0ZWRfX3pgsqJ019/Fe
 TqZ9ih24ChMdj1FsLMhcKDoiwWSb+EQbEyVBgiuTX+pOBV5+85EdfackqWIGG2HTiBhCrPLyZeW
 V2fHqC31ieoiwry7jgdEkAgDGjJzkxo=
X-Proofpoint-ORIG-GUID: UGqz76woKj9P9O-5XoTnNlrvPo6Nm1wP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140202
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

From: Miao Wang <shankerwangmiao@gmail.com>

This patch improves the implementation of the pvscsi device by
translating the endianness of the data sent or received from the guest.
This ensures pvscsi can work on big-endian hosts with little-endian
guests.

This patch assumes, although not having found any specifications, that
the pvscsi device is little-endian, since pvscsi seems to be used only
on x86 platforms, which are little-endian.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Miao Wang <shankerwangmiao@gmail.com>
Message-ID: <20260710-pvscsi-endianness-v3-1-27fe1c4d1f6e@gmail.com>
[PMD: Rebased on top of commit cb30b8758d4 physmem API conversion]
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/vmw_pvscsi.c | 57 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 4398aa54990..05f93171cd7 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -392,9 +392,18 @@ static void
 pvscsi_cmp_ring_put(PVSCSIState *s, struct PVSCSIRingCmpDesc *cmp_desc)
 {
     hwaddr cmp_descr_pa;
+    PVSCSIRingCmpDesc cmp_desc_conv;
 
     cmp_descr_pa = pvscsi_ring_pop_cmp_descr(&s->rings);
     trace_pvscsi_cmp_ring_put(cmp_descr_pa);
+    cmp_desc_conv = (struct PVSCSIRingCmpDesc) {
+        .context = cpu_to_le64(cmp_desc->context),
+        .dataLen = cpu_to_le64(cmp_desc->dataLen),
+        .senseLen = cpu_to_le32(cmp_desc->senseLen),
+        .hostStatus = cpu_to_le16(cmp_desc->hostStatus),
+        .scsiStatus = cpu_to_le16(cmp_desc->scsiStatus),
+    };
+    cmp_desc = &cmp_desc_conv;
     physical_memory_write(cmp_descr_pa, cmp_desc, sizeof(*cmp_desc));
 }
 
@@ -402,9 +411,18 @@ static void
 pvscsi_msg_ring_put(PVSCSIState *s, struct PVSCSIRingMsgDesc *msg_desc)
 {
     hwaddr msg_descr_pa;
+    PVSCSIRingMsgDesc msg_desc_conv;
+    int i;
 
     msg_descr_pa = pvscsi_ring_pop_msg_descr(&s->rings);
     trace_pvscsi_msg_ring_put(msg_descr_pa);
+    msg_desc_conv = (PVSCSIRingMsgDesc) {
+        .type = cpu_to_le32(msg_desc->type),
+    };
+    for (i = 0; i < ARRAY_SIZE(msg_desc->args); i++) {
+        msg_desc_conv.args[i] = cpu_to_le32(msg_desc->args[i]);
+    }
+    msg_desc = &msg_desc_conv;
     physical_memory_write(msg_descr_pa, msg_desc, sizeof(*msg_desc));
 }
 
@@ -481,6 +499,9 @@ pvscsi_get_next_sg_elem(PVSCSISGState *sg)
     struct PVSCSISGElement elem;
 
     physical_memory_read(sg->elemAddr, &elem, sizeof(elem));
+    elem.addr = le64_to_cpu(elem.addr);
+    elem.length = le32_to_cpu(elem.length);
+    elem.flags = le32_to_cpu(elem.flags);
     if ((elem.flags & ~PVSCSI_KNOWN_FLAGS) != 0) {
         /*
             * There is PVSCSI_SGE_FLAG_CHAIN_ELEMENT flag described in
@@ -759,6 +780,12 @@ pvscsi_process_io(PVSCSIState *s)
 
         trace_pvscsi_process_io(next_descr_pa);
         physical_memory_read(next_descr_pa, &descr, sizeof(descr));
+        descr.context = le64_to_cpu(descr.context);
+        descr.dataAddr = le64_to_cpu(descr.dataAddr);
+        descr.dataLen = le64_to_cpu(descr.dataLen);
+        descr.senseAddr = le64_to_cpu(descr.senseAddr);
+        descr.senseLen = le32_to_cpu(descr.senseLen);
+        descr.flags = le32_to_cpu(descr.flags);
         pvscsi_process_request_descriptor(s, &descr);
     }
 
@@ -808,6 +835,17 @@ pvscsi_on_cmd_setup_rings(PVSCSIState *s)
 {
     PVSCSICmdDescSetupRings *rc =
         (PVSCSICmdDescSetupRings *) s->curr_cmd_data;
+    PVSCSICmdDescSetupRings translated;
+    int i;
+
+    translated.reqRingNumPages = le32_to_cpu(rc->reqRingNumPages);
+    translated.cmpRingNumPages = le32_to_cpu(rc->cmpRingNumPages);
+    translated.ringsStatePPN = le64_to_cpu(rc->ringsStatePPN);
+    for (i = 0; i < PVSCSI_SETUP_RINGS_MAX_NUM_PAGES; i++) {
+        translated.reqRingPPNs[i] = le64_to_cpu(rc->reqRingPPNs[i]);
+        translated.cmpRingPPNs[i] = le64_to_cpu(rc->cmpRingPPNs[i]);
+    }
+    rc = &translated;
 
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_RINGS");
 
@@ -831,6 +869,11 @@ pvscsi_on_cmd_abort(PVSCSIState *s)
     PVSCSICmdDescAbortCmd *cmd = (PVSCSICmdDescAbortCmd *) s->curr_cmd_data;
     PVSCSIRequest *r, *next;
 
+    PVSCSICmdDescAbortCmd translated = *cmd;
+    translated.context = le32_to_cpu(cmd->context);
+    translated.target = le32_to_cpu(cmd->target);
+    cmd = &translated;
+
     trace_pvscsi_on_cmd_abort(cmd->context, cmd->target);
 
     QTAILQ_FOREACH_SAFE(r, &s->pending_queue, next, next) {
@@ -862,6 +905,10 @@ pvscsi_on_cmd_reset_device(PVSCSIState *s)
         (struct PVSCSICmdDescResetDevice *) s->curr_cmd_data;
     SCSIDevice *sdev;
 
+    PVSCSICmdDescResetDevice translated = *cmd;
+    translated.target = le32_to_cpu(cmd->target);
+    cmd = &translated;
+
     sdev = pvscsi_device_find(s, 0, cmd->target, cmd->lun, &target_lun);
 
     trace_pvscsi_on_cmd_reset_dev(cmd->target, (int) target_lun, sdev);
@@ -892,6 +939,14 @@ pvscsi_on_cmd_setup_msg_ring(PVSCSIState *s)
 {
     PVSCSICmdDescSetupMsgRing *rc =
         (PVSCSICmdDescSetupMsgRing *) s->curr_cmd_data;
+    PVSCSICmdDescSetupMsgRing translated = *rc;
+    int i;
+
+    translated.numPages = le32_to_cpu(rc->numPages);
+    for (i = 0; i < PVSCSI_SETUP_MSG_RING_MAX_NUM_PAGES; i++) {
+        translated.ringPPNs[i] = le64_to_cpu(rc->ringPPNs[i]);
+    }
+    rc = &translated;
 
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_SETUP_MSG_RING");
 
@@ -994,7 +1049,7 @@ pvscsi_on_command_data(PVSCSIState *s, uint32_t value)
     size_t bytes_arrived = s->curr_cmd_data_cntr * sizeof(uint32_t);
 
     assert(bytes_arrived < sizeof(s->curr_cmd_data));
-    s->curr_cmd_data[s->curr_cmd_data_cntr++] = value;
+    s->curr_cmd_data[s->curr_cmd_data_cntr++] = cpu_to_le32(value);
 
     pvscsi_do_command_processing(s);
 }
-- 
2.53.0


