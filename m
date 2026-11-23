Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8A4606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=phuS88sf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=NxAnZgg0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcK-0001zw-Pv; Mon, 23 Nov 2026 10:06:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbc-0001RB-TG
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:26 -0500
Received: from fhigh-a4-smtp.messagingengine.com ([103.168.172.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbX-0003kB-B8
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:19 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id CB61514003CC
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:05:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Mon, 23 Nov 2026 10:05:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446307;
 x=1795532707; bh=b4D82fMgvYMAAkAVFwMZQyqXBXy3g1xUtlmhdK2gt/E=; b=
 phuS88sftjA30tplBUeHpknLNGC5PcWqGr40V/JagQSAg0X8JWArG/eg1ngq0J7l
 x6gt/Ng0143VqeThuzUg3aiL4NbgerLhuzlZSOAS1Mb4GUh2xWm85HWexQTtlw98
 aY2jIyecvhPOV8HsSBCAEa1Q89A+atW+vIUZnbcZIahQef7n5S7b2HsOsacPu+xC
 62WKSBZs3MJNB5pnejMocc+RVMsptC/OMgwJBHDpROJhMXgJa8gPGDoU17xHr8fr
 Tys+rstpxkHGvoaZrpFjKr/74auqzMEifHRBZDCQkDYr+4gnR4ljklMjvlxVOjDf
 aeUTgI6YwUpkJVa/5tx9cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446307; x=
 1795532707; bh=b4D82fMgvYMAAkAVFwMZQyqXBXy3g1xUtlmhdK2gt/E=; b=N
 xAnZgg0eOlGdV4FMCm8n9iiy8eh4e+iF+Ia8iEuhaGS01hnfQCxWHH6MHQPttd4L
 9yvjn8Clj0jhgjQ4K8IhfzKb5tOOLLs4hp8v/s/2G+0RmeE8wYpE9yLQ2McINsXT
 G/tMdrWr+Ez+IU7KMhUHfvbkhQMRsEScWMaHPxgZMwsb+Z3LrEvncdhYojyFKLKy
 uVmoBGL/z3AIM3waoheSCkCK8Kstxb7Fi/rnWB2Uw/gvYV/T1hZ9njWv53BtNTcQ
 hzldyTEaUp8KcZKZcnDwi4Dmb4/CdoAACmHhksD9k9eHqWesfMZUxbLPIQPclsBW
 JUX8SG8qlOBSoyF4KeGJw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446307; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:tHQM9hGW0wRKLaZuKCUcbEGEBNR7I63JuWHl8zPNZ6bkW6E
 48kCA9XD8R/9AsbMfijByIhxMa7Zm9CWh7+U/R1GlIJGQftt2ZycAOhD76kS1V+o
 z2FOzzQXfENcLkWisR0dqb/YURKbL9oQzmGDwCep/pqDztrEGyW8UZSkOUxZRru1
 QPh1tw5XCgmO/8IgKVs8DyUnOZNT6k7SZtyXfqRD2RJg7ftanSkAZ2HI0dF1Peca
 iJimqxJeZCLfSgU7YXRMNf6KblvdQdtIUg/SgJJd+JLkRieQy/wLhXh/VnduM16R
 R9ckXbq7EFRbVaN3LEJ4PtY9lPKZ+TNxqh0ZHbQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:pTOAXU3XvV8ydZPPvduBFTPP16qZ1rI+HSR/IeO7cgY=:/j0DLWEOciipkFnDw1dnNpnGbDVNpIgyw0mlWvj39yU=;
X-ME-Sender: <xms:I1YEa5dTac1iK29c1Bz9hUoEDoGsqmpgDy9RRLO2cH0ScJsqv9Jl4A>
 <xme:I1YEa3r3xylj1nyn2oJd9REuLF1b8Z2ofUygsiNmS9nQuxzCNcOkZFGlJtDzYjBpD
 QNVlJi1xdVyrY4uPDS16KV_nAPSQUuDx1BpvQ6Dj0szGcm-0RCxyoo>
X-ME-Received: <xmr:I1YEazP3-itLLw6IR7GbIacjTdxSs04SPwYRpojCQZAEgZIpbX-i5NhzfWXIaquMRybENYwVR_na7zkDRYQzXH9LlL8JL5hEOqkn>
X-ME-Proxy-Cause: dmFkZTGB7n4iRbxkL5EKH5afsxNBGu5hKNBCu9NYeUwp8wHZTplRTS+HvL6v9Haw8wpEg8
 Zq2Qfrm6LlhHCfbTptsRIeUivsTnI7nIruVPWBJoI3pNIb8lBjYAnOrcKiv8u5fg0AODOW
 NH2AwKH1rEuKfFW/YIGG6WQn/KuGY//3Mkn+Oaw4soUPNDzzL/vBUWpJgwkDxpX5QCQk3i
 wGedWCQmOy/5wXfLQqwmF+d5VfOpIT/MIHWFIC9iR9FkbsufRA0wZL3ADXfJJgxtK91v4z
 edysda/X136m8zypSyqrCdxBUsCK/niHrGPZ+BrKOfTvrtczXoZRqTAMdSzA99Al4RSqE/
 sPfVTAVnmUev2U9hQU2E8Y0guiybYMALQ/OwoVv11ogrftvtjFGf5b9QQH65jFhZpYcjK2
 7S2p/aJWu4TspoiD4H9R4pAtn3TukwcyXHaottyHOwkWdQeprpmzChcA5cv++tGt72SjzN
 UJZIKNYrs65NZoelb115J64Q0XQY59nTh5KVoyVVDRCJYwZ2ApwBLnuUD/3gpoSDJOIOXg
 dToDMLhA/qttHd3qe51yXtMG+JAjGemT1qzN65V7A2S2OUSkRBdQ9H04y+Quyf172PakBM
 yiFCRNHOOXeOhuhZW/DBdSjRIuFUkMm7z4dUo4m8mJUaac7aUXiJLj4EDlSw
X-ME-Proxy: <xmx:I1YEa6j5wsjC3gAJWnavYWJ2d_D4lYqH8L_oboWIQtLTwSIK-7g2Pw>
 <xmx:I1YEa2t11_Fjm_QdAr-pujPLhH14XBlBbF_-l7dsd8zgAQoXMNSGkA>
 <xmx:I1YEa-ghVMUAvYx1jPiPoBfhVNAqYBjw55FOXtbRbIHBQvF6n-URTQ>
 <xmx:I1YEa8a3RmlakjY7wqvrJWiqFBosoSDNeyIlL3xWaAnqsD3bu-VX8Q>
 <xmx:I1YEa_lC4IEBZASMnd6TJj59NXpSqWjrdp1HfQqsqcqluVB9MG1FcX8C>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:05:06 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:54 +0100
Subject: [PATCH v2 07/12] hw/nvme: get feature FDP events (1Eh) - return
 supported events
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-7-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.155; envelope-from=foss@defmacro.it;
 helo=fhigh-a4-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 558bde95cab..cbdb5cf6981 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -6359,19 +6359,16 @@ static uint16_t nvme_get_feature_fdp(NvmeCtrl *n, uint16_t endgrpid,
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


