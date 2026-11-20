Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDB606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 17:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E1NtRkQc;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kOYlbI+d
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUSBX-0003Zi-SM; Fri, 20 Nov 2026 12:14:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSBA-0003Ga-Sl
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:43 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xUSB8-0003tO-Se
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 12:13:40 -0500
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKEfiiG2947046
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GNutknphZQYW/QLgcDhW3Ed6+xGQZtXRUfm12mKXV6c=; b=E1NtRkQciC+I0DnW
 AAW7ZQ22ZfsKAyYbfUjvK5FfhjMnq+9cr1DCvKjSubMcgzcdRvh9H7TVYmo2j41V
 51wqoMd9WVHtbJH6ZnenYGcy4tDFCiuCjOwmt9OeuADK2NpKMgFEULeKFPAMmYu0
 pI4wjZXyaQciyYI8ZPqhKPybc98FAUekduQuBjeK/LbsmnSzUPWL+vibKd5kD97O
 3LnmxIz5uUNT6caurHttuBHTQ/fKP8fEmVdvqdopMroS/ZA7ADR+sqT+cx/Rf7YA
 RtHuXK+QCbtqwxezS3ymlp5SNaMqyD6q/cy8HGvsxJLrvKZJr6MvzYLvkxN8fhvD
 vdWoUA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j2fjjaw8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 17:13:37 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-921273a6cacso17853816d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795194816; x=1795799616; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GNutknphZQYW/QLgcDhW3Ed6+xGQZtXRUfm12mKXV6c=;
 b=kOYlbI+dmp7YPupcR9QcPL+JMieBxPB1WB38Zplv5r/w1AMNnITU3Tnxj9s+5/cA22
 w84pIazuM2WgJOXPSPAtoi5p7S3FuBk6aoz0XbCE18E+VegL2jQBrUn9SLb2h69oueIn
 lxi0hfMDC9J6rpUsmOxB4J9/wu/5RrXxQ/eXQ6nlSIALsn/+7i2QRv5nXgKbnLFaOAU0
 /snlwOl021kj1GFxLuwuMz3Z1fiT1GmuWXhXHnU5k/SdXLm8ube1lVh6PS9X8r3SegEJ
 F1dOfiVvbHV0FkaUZfZ0sk5yhTdEtRXeSzz7kFys/w5VO6fr40tjFmpJ8zjdCsWeM9KZ
 o80Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795194816; x=1795799616;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GNutknphZQYW/QLgcDhW3Ed6+xGQZtXRUfm12mKXV6c=;
 b=2Yq9c1DRqMcZZWxtk2cOyaJDKoEImEPlH7Xg0e3pK2+OnDWx0Wk3Wms0RFmtVmsyra
 Q0pXXu9YxXWIik7hqe/eHCZXwFzNRNI1UQfg0vPIe9eokabhLNBOJna/MnCXwYHRfMbt
 eldIZD7XIGv2VxXpy7Gmmp0aF+Keuz6X+udpLns/ooWz6MmGxG6w7rHYHLZhKrw49x0o
 iAJWlJciYO5x1wB4ndCVkJjtDt+g7OKsGODxRrtrogmdwhDDHfvXpNa1AnBlwnvODQep
 CvprofnsrPEU/ezm9rh1Tvb6A68ZVk+4AQngkpcp8tBZGPqdeOACfQlQOdFKMBmfXEUC
 dzwg==
X-Gm-Message-State: APuU4Z8MhpAeH++A7pe2enEg9kw1gb82gXZbYC+5tGiPF95JExXlOaFR
 ttPz3O1tmnDEPuE54SR18ldWdBtW1of3r06yEnYOM90Six8hMJlmypfd2z3GGFn649FB1lmRAUd
 HvozLk093t7fPQbLtCpSoITVxIuM/Os2SxzSLExtcz+RDZ6EEQxeL0yRUhBArnIHbsg==
X-Gm-Gg: AYBFou0e+Rjh97ufI4nFQYAu7FsyBYNJrxFBtJ3OP5aDn6D8deFPukzic25JNuVKeFr
 FJaXzANTkp5xLwixnktZi/IKO1SDzhXABBtD+IfGY8UBbQxi6yNALk6/wAfRPobqCCax2V0xq3c
 Ht1+iQszsBsccnzCM9YNJwW2s/IelSNqTKP93x1jkwKLfndjl9+THdKGzYwXkXRi9JHWHMkX6RP
 ALz09UIk2b2zx1JcElxFyDwjf1RbCzFJBL+z3TLrFPtcL4juCbiEwGU8RRqWUBzBsyQ5+0AIBL9
 /Jm7Q3XWZxNbXbH0XF+nH5uvp4sub7FYjs8REYh6BSDF+/KfNIjmGZEWcAD3sOK5AKdh1MWmeqf
 7Wx66o4y68pNvTSG/8T+oZtJjohUEA7kHj6lN8L1xJuz/J+FHKZRvSr7e/3XTNmh/+Z0CoxNR5U
 vZWJ8XClKjl+uTlw==
X-Received: by 2002:a05:620a:480b:b0:949:3017:1f91 with SMTP id
 af79cd13be357-949bab23b74mr601322085a.48.1795194816109; 
 Fri, 20 Nov 2026 09:13:36 -0800 (PST)
X-Received: by 2002:a05:620a:480b:b0:949:3017:1f91 with SMTP id
 af79cd13be357-949bab23b74mr601314185a.48.1795194815452; 
 Fri, 20 Nov 2026 09:13:35 -0800 (PST)
Received: from localhost.localdomain (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab5ffcad11sm6777993f8f.0.2026.11.20.09.13.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Nov 2026 09:13:34 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [RFC PATCH-for-11.2? v4 08/14] hw/scsi/ncr53c710: Deliver completions
 from bottom halves
Date: Fri, 20 Nov 2026 18:12:28 +0100
Message-ID: <20261120171235.61325-9-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120171235.61325-1-philmd@oss.qualcomm.com>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FJaOVOos c=1 sm=1 tr=0 ts=6b007fc1 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=zCys0jnkAAAA:8 a=EUspDBNiAAAA:8 a=pfTFL2jsI9KnObYQJNEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=AAPjE2N9MkmuCaafd2wf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfXxHsRHIrQN1uZ
 9gfMsiCGM1AKdxAOht+oIsVTYrnvbAvoQrMh2d7Oj6j0i6JBBhrDnfZYS+zCMnWSD31PL7xyWR5
 ZlcwsoFgJ4PakUF7rku459bFv7WTwxA=
X-Proofpoint-ORIG-GUID: ZRae8bWnAq3x2lIUgPGDRy0Ra3lXy7pa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA2OCBTYWx0ZWRfX8S95gj4DxQ7q
 c13wmJ8TDusvUw3n2BXcIwrvT+wXpLwcxgDGS95kOaWWdUIR7Zy4pLHTDh7FNWeF7ITyJPEZW5M
 cTrk7Q0ASZDJbAm5sZ9WpTJ1LtEBGSDfCvF5qilEw8G/aGTwBMWsyE8oi2V1EStAi1s3DrgCCfl
 xQGPKyk01eEmyEm+rSc7aWR07FZ2HS98/PBrRBpk44V8Fv1G4c8Eh/NbFvizBcUbjEHR1pzt43n
 tBuTFPPSzBfF35FItsot2OkT53vI6LToc4EtXpGD1CrSncQBGzYSabQoQr0G6EFOFfWjFB6Ls3y
 aJx161I4Gv9yFFX0LYXKvj+Sr5D3rzcTzHYZQnwZNwr6RQobReHblzbn++KtPGIRwAwZv9QiW4K
 ZcRBoZBhBzENtQnFix/az0GXQbLsW/Tu7cGzGmah/mGIfZWUwlqYocveedsXUER0hLq2z2QXb4x
 Ykcso2ij+1Wf7R1ZcYg==
X-Proofpoint-GUID: ZRae8bWnAq3x2lIUgPGDRy0Ra3lXy7pa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200068
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

From: Keith Monahan <keith@techtravels.org>

Completions are delivered asynchronously, as the real chip delivers
them, rather than reentrantly inside the interpreter: a reselect
reconnect and a tagged completion off host cached media (the install
CD-ROM) are deferred to a bottom half.  A reentrant completion would
collapse the disconnect and the completion interrupt into the one guest
MMIO write driving the engine and race the HP-UX 10.20 c720 driver's
completion bookkeeping.  Untagged and polled transfers keep inline
completion.

A SIGP kick that lands on a stopped engine, rather than one parked at
Wait Reselect, is held in sigp_pending_resume and replayed once the
engine parks.

Signed-off-by: Keith Monahan <keith@techtravels.org>
Signed-off-by: Helge Deller <deller@gmx.de>
AI-used-for: Patch series decomposition (commit splitting and ordering)
Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 hw/scsi/ncr53c710.h |  8 ++++
 hw/scsi/ncr53c710.c | 92 ++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/ncr53c710.h b/hw/scsi/ncr53c710.h
index 82202940caa6..8b5cbfc135e3 100644
--- a/hw/scsi/ncr53c710.h
+++ b/hw/scsi/ncr53c710.h
@@ -93,6 +93,14 @@ typedef struct NCR710State {
     uint32_t select_tag;
     int command_complete;
     bool script_running;
+    /*
+     * A SIGP arrived while the engine was halted instead of parked at Wait
+     * Reselect; the Wait Reselect handler consumes it when the engine next
+     * parks.
+     */
+    bool sigp_pending_resume;
+    /* A SCSI continue was deferred to lsi_issue_bh. */
+    bool issue_pending;
     lsi_request *current;
     /* Disconnected tagged commands awaiting reselection. */
     QTAILQ_HEAD(, lsi_request) queue;
diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index 305958b92f4a..b9ebeb4d96dc 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -73,6 +73,7 @@ static const char *lsi_reg_name(int offset)
 static uint8_t lsi_reg_readb(NCR710State *s, int offset);
 static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val);
 static void lsi_execute_script(NCR710State *s);
+static void lsi_issue_bh(void *opaque);
 static void lsi_set_phase(NCR710State *s, int phase);
 
 /*
@@ -106,6 +107,7 @@ void ncr710_soft_reset(NCR710State *s)
     s->select_tag = 0;
     s->command_complete = 0;
     s->script_running = false;
+    s->sigp_pending_resume = false;
 
     s->scntl0 = 0xc0;       /* full arbitration */
     s->scntl1 = 0;
@@ -272,6 +274,25 @@ static void lsi_bad_selection(NCR710State *s, uint32_t id)
     lsi_disconnect(s);
 }
 
+/*
+ * Deferred half of lsi_do_dma()'s SCSI continue.  It runs on a clean stack,
+ * so a cached backend's completion cannot arrive reentrantly inside the
+ * SCRIPTS interpreter.
+ */
+static void lsi_issue_bh(void *opaque)
+{
+    NCR710State *s = opaque;
+
+    if (!s->issue_pending) {
+        return;
+    }
+    s->issue_pending = false;
+    if (s->current == NULL || s->current->orphan) {
+        return;
+    }
+    scsi_req_continue(s->current->req);
+}
+
 static void lsi_do_dma(NCR710State *s, int out)
 {
     uint32_t count;
@@ -314,7 +335,21 @@ static void lsi_do_dma(NCR710State *s, int out)
     p->dma_len -= count;
     if (p->dma_len == 0) {
         p->dma_buf = NULL;
-        scsi_req_continue(req);
+        /*
+         * Defer the completing continue (dbc == 0) of a tagged transfer to a
+         * bottom half; the engine parks at DMA_IN_PROGRESS (set by the caller)
+         * meanwhile.
+         */
+        if ((p->tag & LSI_TAG_VALID) && s->dbc == 0) {
+            s->issue_pending = true;
+            aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_issue_bh, s);
+        } else {
+            /*
+             * Complete inline for untagged transfers and mid-transfer
+             * continues (dbc > 0).
+             */
+            scsi_req_continue(req);
+        }
     } else {
         p->dma_buf += count;
         lsi_resume_script(s);
@@ -417,20 +452,43 @@ static int lsi_queue_req(NCR710State *s, SCSIRequest *req, uint32_t len)
     return 1;
 }
 
-/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
-static void lsi_wait_reselect(NCR710State *s)
+/*
+ * Deferred half of lsi_wait_reselect(): reconnect a disconnected command
+ * whose data is ready and resume the engine.  Does nothing if the engine moved
+ * on while this was pending.
+ */
+static void lsi_reselect_bh(void *opaque)
 {
+    NCR710State *s = opaque;
     lsi_request *p;
 
-    if (s->current) {
+    if (s->current != NULL || s->waiting != LSI_WAIT_RESELECT) {
         return;
     }
     p = lsi_get_pending_req(s);
-    if (p) {
-        lsi_reselect(s, p);
+    if (p == NULL) {
+        return;
     }
-    if (s->current == NULL) {
-        s->waiting = LSI_WAIT_RESELECT;
+    lsi_reselect(s, p);
+    s->waiting = LSI_NOWAIT;
+    lsi_execute_script(s);
+}
+
+/* SCRIPTS Wait Reselect: reconnect a ready queued command, else park. */
+static void lsi_wait_reselect(NCR710State *s)
+{
+    if (s->current) {
+        return;
+    }
+    /*
+     * Reselecting synchronously here, inside the guest register write that
+     * drove the engine to this Wait Reselect, would deliver the command's
+     * completion interrupt reentrantly.  Defer the reconnect to a bottom half;
+     * the engine parks meanwhile.
+     */
+    s->waiting = LSI_WAIT_RESELECT;
+    if (lsi_get_pending_req(s)) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), lsi_reselect_bh, s);
     }
 }
 
@@ -930,9 +988,10 @@ again:
                 /*
                  * Two things release a Wait Reselect: SIGP (jump to the
                  * dispatch address latched in DNAD), or a disconnected command
-                 * becoming ready to reselect.
+                 * becoming ready to reselect.  A SIGP that arrived while the
+                 * engine was halted is held in sigp_pending_resume.
                  */
-                if (s->istat & LSI_ISTAT0_SIGP) {
+                if ((s->istat & LSI_ISTAT0_SIGP) || s->sigp_pending_resume) {
                     /*
                      * The SIGP divert is a one-shot: clear the latch so a
                      * later Wait Reselect does not re-fire on a stale SIGP.
@@ -940,6 +999,7 @@ again:
                      * auto-switching.
                      */
                     s->istat &= ~LSI_ISTAT0_SIGP;
+                    s->sigp_pending_resume = false;
                     s->dsp = s->dnad;
                 } else if (!lsi_irq_on_rsl(s)) {
                     lsi_wait_reselect(s);
@@ -1404,6 +1464,17 @@ static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val)
             s->waiting = LSI_NOWAIT;
             s->dsp = s->dnad;
             lsi_execute_script(s);
+        } else if ((val & LSI_ISTAT0_SIGP) && !s->script_running &&
+                   s->waiting == LSI_NOWAIT) {
+            /*
+             * SIGP while the engine is halted on a just completed command,
+             * not parked at Wait Reselect.  Clear the SIGP latch, as a Wait
+             * Reselect consumption would, without disturbing the pending
+             * completion.  Remember the kick so the next command is selected
+             * once the engine parks again at Wait Reselect.
+             */
+            s->istat &= ~LSI_ISTAT0_SIGP;
+            s->sigp_pending_resume = true;
         }
         break;
     case NCR710_CTEST8:
@@ -1535,6 +1606,7 @@ const VMStateDescription vmstate_ncr710 = {
         VMSTATE_UINT32(select_tag, NCR710State),
         VMSTATE_INT32(command_complete, NCR710State),
         VMSTATE_BOOL(script_running, NCR710State),
+        VMSTATE_BOOL(sigp_pending_resume, NCR710State),
 
         VMSTATE_UINT8(scntl0, NCR710State),
         VMSTATE_UINT8(scntl1, NCR710State),
-- 
2.55.0


