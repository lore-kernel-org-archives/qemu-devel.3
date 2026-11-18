Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21D606A32F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=i7IRYXUv;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=eKvXnuiw
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThC2-0005U2-B9; Wed, 18 Nov 2026 10:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBa-00057L-Qt
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:03:02 -0500
Received: from fout-a3-smtp.messagingengine.com ([103.168.172.146])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xThBW-00044F-Pn
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:02:58 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.phl.internal (Postfix) with ESMTP id D438CEC0B24
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 10:02:41 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 18 Nov 2026 10:02:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795014161;
 x=1795100561; bh=Tkn2TcRxPs0xAU4cGhaimY6dODk/qYtEhFVwGsizWVM=; b=
 i7IRYXUv72VHYjnUmUDubrjJK1/9SJOye13+szm0Zasx3OhjG5ZHoovTeTBuLPEU
 YAf0oR0Xt4hEvMwHk2cOeRufQTwU864987k/Ji6mCUb9N0iy3aLo1AwE/Tt45PoR
 Ov1QBvMxx39hR1GsZZM15Rh6nynAj20+BuDRDo+iXv2nT8EC3Z5QvZ43zln77+G7
 kXAaymydtV8SIiKLyAnFkUIe+9ajLHYgcQI1JdIUgMB2ebzTInutYrdEiHI3zAs3
 rgW2o5P0wGPfVDFh/ziRfPp84RlyZUmALOB13WDXF4/Im3XnO4GAJdmsrz2Yz6pz
 mvk8sjZdumI272WPPVi5ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795014161; x=
 1795100561; bh=Tkn2TcRxPs0xAU4cGhaimY6dODk/qYtEhFVwGsizWVM=; b=e
 KvXnuiwSgg2b0/UfnPjrgLOPiXHLfBQW5ebFUqSuOWpzjbl8ArWXvZ+Xa82Sghfy
 WiZO76SpeJHXsGhUSCdjF3Dy/75zFROLowYbLQ5HJEmVakU4xnfnaXD2arhb63VY
 oqiBcvkNSOboSzwHbGuML+xg+EPGJLaPwlKXHxuB0xkRsHpzGWdFmHplDjJwEurs
 6DB5U83r70IhDtVanBU3oUvwKCphbN0xVAsae3bFe8YyM49j4D7LKawH7dtSyny9
 xNrhtXKez2BuTXMta2blIoz9B8PG+M+ZDb9WU6uiQ0Tzz3AKCnnK9QCRYtGuW75C
 dikxD8wFq5SHyTHyfNBDA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795014161; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:PK2sVq2znS4I1Z5xyYQz91MDpAL3NW7hhrKpyoGkrZpgGj5
 Vxvih12Mp+/SWNK6nGMhedLeCKFgT3uiRunntfV/qLNHZqRnvMzZXhEpT0vFsZ+9
 VIZk6gJw3S52g0R1m2D1HsVCLBhx208KoyDUrlJtr8AXOTS+7VzHntMSaMEXQgUg
 YHme97RfXUljEb7m3Oo+uYOO5H1+c7oCHYioKKgsYZaNVRglMUnn1sPxpUPgN0vl
 hwfQk/Kto+WMiNI7O370vOApWoja3trU6zcbblGwxAKu2MlbdwyZJM33yKb++CcF
 9AT+NdYFMP4VWWRynKj0zoospU+hCUBypMxPf/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:JEIUdMH9Fdi5aHWFv8vpK58yO12p4y+sexFqajB6AHQ=:HPOMBHQFAfq97l2BqSygpv/1Q1YBr7+DYc7wpWgFVgU=;
X-ME-Sender: <xms:Eb79anToFjMv7x64EAtLsd6_Djssbr-vcqOTf5jU87fj-QWdw3YADA>
 <xme:Eb79ahuLhTyqxZqUxk0-sS_f-aOKP17Ma6-T2LrFoTv6X2r6Ho19T4Rlzv2ysUHuu
 -mHU25aVYr5IDWLF4MQrR00mbXEaOV9SQDf6Ww63alaiGNnPLjxaZdD>
X-ME-Received: <xmr:Eb79aobE87zvaeotIRLohRt_e1MZhHhzGH86Kky6MXxmPcOtEEmQRxxe_mbJNqSRvnM>
X-ME-Proxy-Cause: dmFkZTFTzozI3KSw2TI2Ra4YqnZ1EkS70wCE5WQvqMsS0FreDvuXTAbhuGSPvTkGdUwFvK
 xIadfCLoR9SkejMt3f3CSOouTaiOPr8OqMbRPe7GHrK9/YGpKp7iLTS7QR/XnHT1cV+v8P
 sU+UTnXuAxSgcX9VlZsPfQgxKqOk+1SwiAe2b3NoMvwxjG+vuHjNXjkohOnjgEtkBzzABI
 r/Rk0tNsFOR9tz98HuaKdTjBdnpGFLITBJWSWoj6VROczVGkQPFHxiu2GjerWEfLzBl83e
 fS1MBrEMaQ+r1hf8cNazY5fMvm2rOrUQEMQQrGREkvle3eKSw11CCOMhYQWlnAiTn9CviR
 /5i497DXFPk2sYG1/d4Q+UX5JNbPKJF4fnINfSLRi5rglRXc3XbIAgavigUzWmHQHjmY4B
 XTie0xdyvPnvReBUqpszr0DbGfKqQv/IrXZtlssJVV6rfcmG3ZPMeUMh457OVTCd8cGQ3n
 Qu1ZqXFY33RXqATDWVu+7d1HlQXlwHv99NvlPROqZ17BUj0vt0TsAqs3k+pRFNN0uw6gyr
 o9wsj150303wYgDwNsiyu48+R4bvYzUMHpC3ylGuhoJYbU0U3CrTW7yRzgUY+NvqPBFCTx
 yZUhYQRrHlJBQIB55jUk5B699Lp/28zLmzLcAvmZ/pouyOZ+vPQjZJGf4GOw
X-ME-Proxy: <xmx:Eb79anFSVM0ChLrmWi5pvzvX8PtwEUYMFbxonVE78VihJzMB_ILBPw>
 <xmx:Eb79asz653UqKZQ0uTJM1-QcqCXLBY1KbdNFyz6Hk0EL9k-tn794Bg>
 <xmx:Eb79apmAFp8ikly0Nw2BsmSvVuX8glYmkocfdbuOWnOW_xCAZAmLPw>
 <xmx:Eb79alkGoJVK-arZcTC4pHRVPZ0xOXXUUpIxNdAJ8wt9WiZLuG2z1w>
 <xmx:Eb79as1_RS8Jcid7oQUcJPPciWrMT_Py3GjdHTVzVx4mQHyk5x_3VZVL>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 10:02:38 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Wed, 18 Nov 2026 16:01:34 +0100
Subject: [PATCH 7/7] hw/nvme: get feature FDP events (1Eh) - return
 supported events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-jwd-181126-fdp-fixes-v1-7-ed76fad7861d@samsung.com>
References: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
In-Reply-To: <20261118-jwd-181126-fdp-fixes-v1-0-ed76fad7861d@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.146; envelope-from=foss@defmacro.it;
 helo=fout-a3-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

From: Jesper Wendel Devantier <j.devantier@samsung.com>

- support reading saved (default) values
- rewrite, command should ignore dw11.NOET (and dw12.FDPE).
  Instead, must return a list with one descriptor per supported
  FDP event type.

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 52 ++++++++++++++++++++++++----------------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 95affb25c18..04a43867dcd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6359,19 +6359,16 @@ static int nvme_get_feature_fdp(NvmeCtrl *n, uint16_t endgrpid,
 }
 
 static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
-                                            NvmeRequest *req, uint32_t *result)
+                                            NvmeRequest *req, bool current,
+                                            uint32_t *result)
 {
+    NvmeFdpEventDescr evds[FDP_EVT_MAX + 1] = {0};
     NvmeCmd *cmd = &req->cmd;
+    NvmeRuHandle *ruh;
     uint32_t cdw11 = le32_to_cpu(cmd->cdw11);
     uint16_t ph = cdw11 & 0xffff;
-    uint8_t noet = (cdw11 >> 16) & 0xff;
     uint16_t ruhid, ret;
-    uint32_t nentries = 0;
-    uint8_t s_events_ndx = 0;
-    size_t s_events_siz = sizeof(NvmeFdpEventDescr) * noet;
-    g_autofree NvmeFdpEventDescr *s_events = g_malloc0(s_events_siz);
-    NvmeRuHandle *ruh;
-    NvmeFdpEventDescr *s_event;
+    uint8_t noet = 0;
 
     if (!nvme_fdp_enabled(n)) {
         return NVME_FDP_DISABLED | NVME_DNR;
@@ -6386,34 +6383,27 @@ static uint16_t nvme_get_feature_fdp_events(NvmeCtrl *n, NvmeNamespace *ns,
 
     assert(ruh);
 
-    if (unlikely(noet == 0)) {
-        return NVME_INVALID_FIELD | NVME_DNR;
-    }
+    /* Saved selectors fall back to the default because nothing is saved. */
+    uint64_t event_filter = current ? ruh->event_filter : 0;
 
-    for (uint8_t event_type = 0; event_type < FDP_EVT_MAX; event_type++) {
-        uint8_t shift = nvme_fdp_evf_shifts[event_type];
-        if (!shift && event_type) {
+    for (uint8_t evt = 0; evt < FDP_EVT_MAX; evt++) {
+        uint8_t shift = nvme_fdp_evf_shifts[evt];
+        if (!shift && evt) {
             continue;
         }
-
-        nentries++;
-
-        s_event = &s_events[s_events_ndx];
-        s_event->evt = event_type;
-        s_event->evta = (ruh->event_filter >> shift) & 0x1;
-
-        /* break if all `noet` entries are filled */
-        if ((++s_events_ndx) == noet) {
-            break;
-        }
+        evds[noet] = (NvmeFdpEventDescr){
+            .evt = evt,
+            .evta = (event_filter >> shift) & 0x1,
+        };
+        noet++;
     }
 
-    ret = nvme_c2h(n, s_events, s_events_siz, req);
+    ret = nvme_c2h(n, &evds, noet * sizeof(evds[0]), req);
     if (ret) {
         return ret;
     }
 
-    *result = nentries;
+    *result = noet;
     return NVME_SUCCESS;
 }
 
@@ -6535,7 +6525,7 @@ static uint16_t nvme_get_feature(NvmeCtrl *n, NvmeRequest *req)
         }
         goto out;
     case NVME_FDP_EVENTS:
-        ret = nvme_get_feature_fdp_events(n, ns, req, &result);
+        ret = nvme_get_feature_fdp_events(n, ns, req, true, &result);
         if (ret) {
             return ret;
         }
@@ -6579,6 +6569,12 @@ defaults:
             return ret;
         }
         break;
+    case NVME_FDP_EVENTS:
+        ret = nvme_get_feature_fdp_events(n, ns, req, false, &result);
+        if (ret) {
+            return ret;
+        }
+        break;
 
     case NVME_WRITE_ATOMICITY:
         result = n->dn;

-- 
2.51.2


