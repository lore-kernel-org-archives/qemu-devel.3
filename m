Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5A606A31C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=BWcxQn3G;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=PNLA9Qfe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTE0Q-0001I0-87; Tue, 17 Nov 2026 02:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTE0O-0001HN-KH
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:53:28 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xTE0K-0001rT-U6
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 02:53:28 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfout.stl.internal (Postfix) with ESMTP id 5EE061D0020C
 for <qemu-devel@nongnu.org>; Tue, 17 Nov 2026 02:53:23 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 17 Nov 2026 02:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:message-id:mime-version
 :reply-to:subject:subject:to:to; s=fm2; t=1794902002; x=
 1794988402; bh=ybqdweyjjnpi5CguMzR5A3wBve82WiSIOhN2ZMEKC9k=; b=B
 WcxQn3GBCcL9Xc2lwcoDXYQPOgKmxmuDVrxRndklcQ72+qwKjjK+Rl+EOfJKlLmw
 KlrvH/dpIvHCVgNoerFvqhU4DD3/JqjW9bqrK6n9oucT+QDbEG4UXy7eVbqqnOOv
 ujBDEbPkLpJBNEIeZ90Z5yCsUW/57ckyjChpMfd54wOwvYrGpDDTGNIqENxWSyZm
 xNZaritzS6lKe5Mo7aJzzRMpodVxWAXsdx6ZCJfchFh8hceVr9epL4ECQLkrnSvV
 78WDYMLiuNE3suZCYzHmScekS1drc2a6IitWRwiEndy0OHqcbhVNNizZ9kf2tsjX
 BoD0hgvrLmZmSOVaZWqtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm3; t=1794902002; x=1794988402; bh=ybqdweyjjnpi5CguMzR5A3wBve82
 WiSIOhN2ZMEKC9k=; b=PNLA9Qfe2FgUHB+0nfXYckHcWmIeystSv1CPAmUc03Ii
 9dWGZRTVUL9wHwx7mDWI8K7JGGjOkJqZoAZ55ymp4YMlCj3rRrd+O9T5BzG5eNiE
 N00PjG1zBjGw3BvGcrtEolEszxbYvEgKTfCW+7TkPM1gsxA14EnWfcsUBVdv2cSx
 sKfx6EEK0jIosYEifwT3suJgFuPz30sz6wy5q4Sxu1pLQbRIyrVT+3p/OYh3PULM
 ln8yP8deFPtDRxR8BfdzTLykm3mYZVpDzhl2gYeASBAXGuryw8znVT9v56G0WMcH
 6oU3djzJH++Jq8sw7MZ+rfycxLgcZWPmPMrOTKFGig==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794902002; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:fmn4BppIEcSjDiVSRe8AcVYEn/KW9RAgKaKXFMqcXRo0syR
 /5GMmZNa3WzCnJFaltHWzdu+NHPk222fJaWDTPqtQeTKubpxzEnY4BhtCxtCiLEv
 TZg6UYyFO5pH8u5F8FAywrAIQvkWIcTu6KrZEKIDUB2xhfJu0Eg8ZyMMuGyJ6Nbx
 +UFaiymeI+Y2VqUs1SGrJqmBkuYgnQDN939O+L00jTdL6rQozAK3VxviPy1VKaRN
 0knYGUIj0Mrs3d7XOOh1WBBVq81XFwkG8Y9ZYg1NxuME1yPKMMWPX0h4W0FXs12k
 K2m9WLvRhUOb6yybu905ERMgv3hoGqPnuiZHGyg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=10;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,message-id,mime-version,subject,to;
Message-Instance: m=1;
 h=sha256:aiQS7fJx0S6mheZ3NnRKV7A+egExw+05nRAmAaAuF24=:49DZdhXx3M/SQLrWrEg7DcyrHTenF1IWyP7Le/xA1z8=;
X-ME-Sender: <xms:8Qf8aoKtRUYopbYptGmYRXcvoHpLjr0n8WUlXitOp1lpuVHZpnLTyw>
 <xme:8Qf8ajHLlcRF68mLYKZYxr9WYviHtCfvOsxYvua0acYQEE5jbDAbWhSyS5xKwfUwh
 jPT2ci1X26tlBNbrhGGN-EjNKHiOxrZWTx26cTYH7BWdG59nReodwr5>
X-ME-Received: <xmr:8Qf8ansAiiU3yu35o1Zy9GlkXe9od37PJSMjAvr43fAXzxrN22mJFtcTFMKzUalfWbRnfN5qIZ_sj0WpZQuVzGE>
X-ME-Proxy-Cause: dmFkZTG331ANC+OYwvGCt/mOqGu8yppSaP9iWu/iaaxOOYGKP4u2+Sn2L7goVhGP32coER
 9Hz10Nypqd9AvxgDoSlD/XSM0ZY8gcXA6TmiY9rfgL2c7F8R7O9C8eIibzUiSNpVVv/XiJ
 1KlkTeaZEYWgNaOzvIfJ66D+ywS1/UAB0v/U+2OCtYDBh29jMj5kvrYsHbymwU661oUCjK
 zvYsGAwpn8r9ygvZPDagbBOdwm+3JJVB6K2Ya7gK5LZHEg3LyO5wgEiGl1+vDXdrjyjO/+
 TDbDX1wWEP12bVA5CCMsbx4zrgKPETp8RTIrkTIVG73sRhuxK0EbVLasvyiiqQluBWv9mC
 Wi5grYRWS8hVSwl5ahBk3WnRwO1UyjXmxiAkdIoEjVXDKi5vnMdbiu+sK4h1bK9dCfsN5s
 wIUJBAR2S8b3vckCvBazf9rYXVFxRnp7PMh+iURIYoIL9oq0T4VNKov8iheJrl2GXtPhQd
 M/jCdVCjnS/rUtVHkQii/Ez0BnkDDrwdT37Z/nwWQgXVMmZuwHsAz6k2/GnOZiELJHgLND
 4PJOArE4Mq9H+5SkdW/DGa9xduKWSJSB8WrbpxvDjtfVrrdsfR71kfGj8CN3wm+/sXkS3E
 WgGCtkPLXtZ+jzs7DhiK3r5tyXZ19baGfgTxyMfL7rUxhpT9vkqKXei07hFw
X-ME-Proxy: <xmx:8Qf8aqu6YhLezTUlNmw5H5PmdK8TPS1nBxEUEqeHWLbbFxTlk5IcHw>
 <xmx:8Qf8atD4ptKV43zpack8dAg5uHoPjWDfLm6VG7inlFiWsRR5-80eVw>
 <xmx:8Qf8asM-EgOh_JHokZHY3vLqXcMrt_Wm6F60bx7kRCTNhNfcxj9dOQ>
 <xmx:8Qf8amy_oPDFiUp63d_uDxm512YJHLaFlVumJoVmjKUtgMci_zR5rw>
 <xmx:8gf8aqMGF_eq9kY2qsccut7UmIO3vt3oxwqgkslPlVwgIxdv2B6eq15b>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Nov 2026 02:53:20 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
Date: Tue, 17 Nov 2026 08:53:11 +0100
Subject: [PATCH] hw/nvme: fix zone descriptor extension allocation overflow
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-fix-4730-v1-1-1a3d813ed0f0@samsung.com>
X-B4-Tracking: v=1; b=H4sIAOYH/GoC/yXMTQqAIBAG0KvErBM0S6GrRAursaaFhVYE4t2zW
 j6+nwgBPWGAtojg8aJAm8sQZQHjYtyMjKZsqHilhBCaWbpZrSVnFhusJ8WVlgZyffeYs++q63+
 Hc1hxPN49pPQA2EQZcWwAAAA=
X-Change-ID: 20261117-fix-4730-fe5e4d60673a
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=k.jensen@samsung.com; 
 h=from:subject:message-id;
 bh=3J9ZggAnwAGP/l8wxyKZeJBdP0rgcYzi5+w/L+iSFJo=; 
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkFGdEFaTCtrQTBEQUFvQlRlR3ZNV
 zFQRGVrQnl5WmlBR3I4Qis5VjN4TzBCZ3g4QkhyOVZrN0Jzem9xCmQva3pKYmprNVBxRks1d1RT
 OS91WElrQk13UUFBUW9BSFJZaEJGSW9NNnAxNHR6bW9rZG13RTNocnpGdFR3M3AKQlFKcS9BZnZ
 BQW9KRUUzaHJ6RnRUdzNwNzdrSUFLS01PQ2tmTmxwMGpiMXZQS21CdjJYWi9ERFozaE94emVQZQ
 pIT0dZWG92L2ZsaEJGZ0Zvd3pCczZhazY2ZzhZZEk2bzUyZVNWS2xZbU5reVUzTGoyYksrZzFxR
 G84TmtwRDlECmJoUVkrSVgxWUpqU3ZQRXZlaDAyL0xScTZWVG43ZDhxazhlQTJvYnJINkw4OFBh
 Ni9wbldMdi96OVNLZ3FnZ1IKenlpU1VhdXhuQm5aVjNSR3RadFl5bTVBeDVUZHVPejRjcndvOGp
 GUjJXN1ErdzF0OXBBRnR5b0luZjg2V3lJQgplZ080c0xHVk1ubGpxVnJqcE01ZTJ2Q1ZDcVdvdW
 gxRjhZbGkwMG1UaTJISEZYZDFyMjlzcmZHZ3NrNUJrNnYwCng1SXBGOE1VYkVLWCtOcnVaTkVkM
 XYyclFkTDJEUXhKR3JacUpKSWQ1RXFIWHJ4Y09lbDdDclNICj1iQ3BkCi0tLS0tRU5EIFBHUCBN
 RVNTQUdFLS0tLS0K
X-Developer-Key: i=k.jensen@samsung.com; a=openpgp;
 fpr=DDCA4D9C9EF931CC3468427263D56FC5E55DA838
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_ns_zoned_init_state sizes the zone descriptor extension array
with 32-bit arithmetic. A large enough zone extension size and number of
zones will wrap, causing either null pointer deref on Set Zone
Descriptor Extension or an out-of-bounds write.

nvme_get_zd_extension has the same problem.

Fix the initialization by using g_malloc0_n and compute the per-zone
offset using 64-bit arithmetic.

Cc: qemu-stable@nongnu.org
Fixes: 1a9290ade33a ("hw/block/nvme: Support Zone Descriptor Extensions")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4730
Reported-by: Karl Mehltretter
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
---
 hw/nvme/ns.c   | 4 ++--
 hw/nvme/nvme.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 37d45bb4d533..b18fcab43b44 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -314,8 +314,8 @@ static void nvme_ns_zoned_init_state(NvmeNamespace *ns)
 
     ns->zone_array = g_new0(NvmeZone, ns->num_zones);
     if (ns->params.zd_extension_size) {
-        ns->zd_extensions = g_malloc0(ns->params.zd_extension_size *
-                                      ns->num_zones);
+        ns->zd_extensions = g_malloc0_n(ns->num_zones,
+                                        ns->params.zd_extension_size);
     }
 
     QTAILQ_INIT(&ns->exp_open_zones);
diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index a4b2c01a2cc4..1bfe85c10de0 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -363,7 +363,8 @@ static inline bool nvme_wp_is_valid(NvmeZone *zone)
 static inline uint8_t *nvme_get_zd_extension(NvmeNamespace *ns,
                                              uint32_t zone_idx)
 {
-    return &ns->zd_extensions[zone_idx * ns->params.zd_extension_size];
+    return ns->zd_extensions + (uint64_t)zone_idx *
+        ns->params.zd_extension_size;
 }
 
 static inline void nvme_aor_inc_open(NvmeNamespace *ns)

---
base-commit: 97c88c61d45dee6e1f9bc160a338048189846d28
change-id: 20261117-fix-4730-fe5e4d60673a

Best regards,
--  
Klaus Jensen <k.jensen@samsung.com>


