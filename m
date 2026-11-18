Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C281606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=Ww48fkvD;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=mIwFdhqz
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTf2q-0007ER-8w; Wed, 18 Nov 2026 07:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2o-0007Co-4I
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:46 -0500
Received: from fout-b2-smtp.messagingengine.com ([202.12.124.145])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTf2l-0000ju-I9
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 07:45:45 -0500
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
 by mailfout.stl.internal (Postfix) with ESMTP id 526D91D001B6
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:45:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-11.internal (MEProxy); Wed, 18 Nov 2026 07:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1795005942; x=1795092342; bh=wFr8E7o0aLghm5CoN4RrbDI/yy62f6fe
 snt7Vmh5TsE=; b=Ww48fkvDcpOUtoZRGRCd3lLepDxXk8shrCpGPTNTQYDoEBp9
 AJQ6a51DUcyXECmNNrvvryhEznl4Sb7bZm0aSASlQxYoI28mz2BDXQ4HJECVoVPy
 n6lRA+CmwFZQVqtTIRxKBwC2poVG4LyFbjXYzd8lXQ2R/hkGwnGpvT0yjC8K9Js3
 EBu5RfbRkJVhkFTyO6hWYNILP+lmpHg/mddU8xaQELsiWQiTrIDTXJZfUTtUAl3x
 g9b8T9zBTOrJj1IL/Ypz7Mn+YO4Yi6f0u7a6FlAYEB/mud97hOZOCHYas2fyZ+tO
 VoCcjOj3BcfTTdBwAfAyBNOylbX15M81Z3AcQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795005942; x=
 1795092342; bh=wFr8E7o0aLghm5CoN4RrbDI/yy62f6fesnt7Vmh5TsE=; b=m
 IwFdhqzUc22fmhRfW5hJhOYUCFSwWiaGHx1iXknPdQOYgfFhmw9SRFHc2klPyObT
 XUk+tWubCdNF/H6sJImGV4XY/fgwtH07jqD8dfp9VXH2IMGCJLyc0YzZ3bjl7y/m
 90JbaE+3SAomxi0JpLFCXZ2cVKwlgvxUXQXH8V48wzudxsubOHUw8nNvaIIMRL0l
 4AopyLmMqFBqv0SBXSHDrbdvSVfhi2TthgiIjc7QsxW/l2N+Ldbe1oiH42zwcmEH
 QBQ7Du7p/K0i6UbMALs5HdZV2WdACDf0HHH5QwUbVSpOArx5cK9fZlsft5nJw+ZT
 Ns2iWTIasFoRL1TSIDEGw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795005942; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:U0jIOfdrRSYGbHh7cAUpY4eFlQGbFvowosFybjxJuTIitBI
 ++OGjkDQgHnSGOl4LZ+WmlIkAOaxMvcry/ThnGhrfo+4Sz262pQge9Q/jZw57R1a
 6A+EV0G7mImYsIYZKLhkdKLZvqM6jSJ1OXUvsm1WiI4nzAhxgYh4KZLkm9O6YkQC
 SBqqaW0oIfgGcIRen/J72lpBWvk7uaz5jVKUXslDU8nqYbZFgnTOZ4GURdWIhsgU
 n8JaKxqmA/qLRc5B2B97eJ3Urx8yhCaJa0+Lt+vJsFjXh2WHmk+iwIKUKkKCpHs7
 iFvWxEdsUs2mYgx4ZQrP0fgoMWxQQx/TpEqkWVA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:xGkJ61vqoDBqLAXZVBm7YaabxJZo/FqS8dY2JUDMLmI=:D5lCwzplBjh/eVBglSCqNuHreIQFDivbDVahva0vntg=;
X-ME-Sender: <xms:9Z39am_Wj7AeiKHKZd59hkRfNexqDfeqy2D-mympsfsFqt37FuWJ1g>
 <xme:9Z39ahomaudluHiekLNYti1pUo1BuBm0gD4McY4gfKstG7DQMbQ77trfCIwXIqKh-
 xc5_3xYqNBeVSeUOdVy3U7tN8xUs5bZJFmX40K4XPlw5bZvL4b2U6ia>
X-ME-Received: <xmr:9Z39arALbqAYUPBsYtHXOP2tdHGJA6oTYy58PDgJ4aU9B6jUGFkT8sSebgix3NECrUGAGdqz6BJPJZg-wCeo7p4>
X-ME-Proxy-Cause: dmFkZTFMzlKcAbeg7nCayXFh3m2ixILkVmRb1Jmm7Bn8QvOUB0ggmGBrZ9PayJ3c1eVXeU
 qW2OOrtTggFL8Lcvr44gEgfOsvJxFX2cyph9Trb25fT/PMWf+OvgLpy4A5bcKDyuNMmzBz
 gbAFtLA3C6n6STIW+xvIfPW76HZ3IdjBZ3wq8Ov6lMh0wUHiyt4l1ktl1+iY6Evd4w/5vQ
 DgYOIHvaSko2UiDcDKUtHXRnz8V8yfeGxFGtqtRBkSJoxa9fhrZk08PaNSx6Aw88y8MngN
 vFr7A5pVva5tNYHBpXOk7RJGLdQ+wYwrUXwo9NkHkol/oxAg+/lE0LasMLlMdfSe/uzztl
 9wLG2ZB/a/gEP/l1YLvK4Wi/1LFfkIEJbrRwPwBudLuNF01WwPMWy90GeQowihp72M+8JH
 Tzcmif3zZq89tH5p1po/1qzObxjRsGgWcqClHnU7dyN9FWl/+AShYE2a6cz70kRSgaZgXJ
 dPZd5xxlCaPjlgd0thqfHFBktfGAXS0gau2gxd3B6e/EFRJJqyG4KkKQmMVnEXFGk8U7uq
 FtzgLE4eEbY8u8jdwpn0Q4V0MAVFCzuU6ntaXEr25u4xWlVTKVWqX5eUu3i12U0b520MhQ
 zIu50rVPEd+rgXR5b5pZSG41FeW8D31dbzvFipygbu6L/NJxkz9/PVsSu0fQ
X-ME-Proxy: <xmx:9Z39ajweaZLSLp4dIB5Oak3kCIwnWQMMcY2PGqaXaHuw9RTStGufhA>
 <xmx:9Z39ao2jf5qoeIUR3rDsUdhRPdYOK-WQOkhAyuXafLrRkkKcyM8tAg>
 <xmx:9Z39ajy_9A_fYBIQSUj5wOuyZUSTfOglYzr3ZDtFueRT33yrb99AXQ>
 <xmx:9Z39avEoCkqPW4qVFqBIIaEC93NvvqG1LU9G4pFAn1QmnHEoxGzqwg>
 <xmx:9p39akLxE7d9j8NrkCIHwC4B54ZFNoCtq7h7rNsuRdvMbP5HnzOw5INW>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Nov 2026 07:45:40 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Wed, 18 Nov 2026 13:45:34 +0100
Subject: [PATCH 1/3] hw/nvme: fix open zone zrwa allocation
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-fix-4520-v1-1-dfa182213376@samsung.com>
References: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
In-Reply-To: <20261118-fix-4520-v1-0-dfa182213376@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2098; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=IYMwbWQrWeLMKdQUQZgC1VX5/SMSQXfTqeNQ5DIlxTQ=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I5bmZEVUMzNHZ4OUo1MXQ3YTkxWlF0bVB6CmpTaDVzY1pLcWlSZ0lVM2Z0
 RHpaZm9rQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9aM3d
 BQW9KRUUzaHJ6RnRUdzNwaFVzSCtnSWNGRytKbkF6ZnpzNGdFUTkzZmlrWXc0NDVRNDR0dWFVQg
 pTSVRXM0pVRXNKWStXbWExNTExeDgyVkxQZVhWcWQ0azhYREVWR2tBUEZRcS9Oc2w1T1hnYU5IW
 TRCOWpaTkFBCm9YSFBvQ3JiMXp5R0dnMEk5bnNtcEcwZU1pVllmZ0ZMNi9vUStQYlpHc3R2dTZw
 N0dWZnBJcisweERvQTJKbSsKL282VnJjM2ttZjJnUVBmUXNiRitBMG1nVTRkMlU5cWdaOGlwNkN
 LMVEyQUxON1dqTTFMTXF1OXV4dWo2RGk1UQpZaXdRVUVaaWpCRjVKNHlJN0taZis0OTlKcVpUY0
 d4a2lSdGNqSi9sR3pBRm1xeEcraXFCaTI1aHRud2lmRHdKCkNHYXIvbXFZU0F1dnFxRUhKWmJMN
 3ZaOU1tdzJIZVU5MzRoa0psK2ZmYU52OE93YlFsZ1dYS3M1Cj0vRzRPCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.145; envelope-from=its@irrelevant.dk;
 helo=fout-b2-smtp.messagingengine.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_zrm_open_flags incorrectly allocates a ZRWA resource regardless of
the zone state. A ZRWA resource shall only be allocated if

    a) there are available ZRWA resources; and
    b) the zone is empty.

Fix the state machine and error out early.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ctrl.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 5e8788a257da..16860ccd9520 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2038,10 +2038,19 @@ enum {
 static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
                                     NvmeZone *zone, int flags)
 {
+    NvmeZoneState state = nvme_get_zone_state(zone);
+
+    bool zrwaa =
+        (flags & NVME_ZRM_ZRWA) && !(zone->d.za & NVME_ZA_ZRWA_VALID);
+
     int act = 0;
     uint16_t status;
 
-    switch (nvme_get_zone_state(zone)) {
+    if (zrwaa && state != NVME_ZONE_STATE_EMPTY) {
+        return NVME_INVALID_ZONE_OP | NVME_DNR;
+    }
+
+    switch (state) {
     case NVME_ZONE_STATE_EMPTY:
         act = 1;
 
@@ -2051,8 +2060,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         if (n->params.auto_transition_zones) {
             nvme_zrm_auto_transition_zone(ns);
         }
-        status = nvme_zns_check_resources(ns, act, 1,
-                                          (flags & NVME_ZRM_ZRWA) ? 1 : 0);
+        status = nvme_zns_check_resources(ns, act, 1, zrwaa);
         if (status) {
             return status;
         }
@@ -2080,7 +2088,7 @@ static uint16_t nvme_zrm_open_flags(NvmeCtrl *n, NvmeNamespace *ns,
         /* fallthrough */
 
     case NVME_ZONE_STATE_EXPLICITLY_OPEN:
-        if (flags & NVME_ZRM_ZRWA) {
+        if (zrwaa) {
             ns->zns.numzrwa--;
 
             zone->d.za |= NVME_ZA_ZRWA_VALID;

-- 
2.53.0


