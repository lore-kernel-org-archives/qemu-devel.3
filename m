Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A1606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=defmacro.it header.i=@defmacro.it header.a=rsa-sha256 header.s=fm3 header.b=iQzjYKZd;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=W6FJMH+J
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVVcL-00021f-E0; Mon, 23 Nov 2026 10:06:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbK-0001Lj-Mz
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:03 -0500
Received: from fout-a7-smtp.messagingengine.com ([103.168.172.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <foss@defmacro.it>) id 1xVVbH-0003h7-L2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:05:01 -0500
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfout.phl.internal (Postfix) with ESMTP id 19641EC0BBD
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:04:58 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-06.internal (MEProxy); Mon, 23 Nov 2026 10:04:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=defmacro.it; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1795446297;
 x=1795532697; bh=JeY/OzFJu79JKgruOIyx/0zK5jyzcn8SNLP15dAFbjA=; b=
 iQzjYKZdKtHVWn+YNzwDORoCOmLgDEHdAFAlwZ280mtwmGpM4VNgU8L5eIqfqRF+
 e5oPU5F+B7bZqv+9Ud08fDbBUhDZlkx9FuBVjyAsJtQEcCpjR1sOlsZwYjHYSuEV
 D2Dh4md9qYvYnVosYTw2SdtzEEG4PVWE9CKsj9Ymweoi54aT3RkqiLFDdfRDeZV5
 wyXul/Z8Mg8xelGEucIXyvo+zYWHttPLIYfIV7KcutrVVxS2BKY5HR876OMeGG6U
 Oq7VFNf/owF0/g5n6rjG7VhGnvV69z9Sq4UivRORT8IfZlcxFBxYXV7hcZrYml1A
 RCPZFxk9RcpgpVaRuSDZhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1795446297; x=
 1795532697; bh=JeY/OzFJu79JKgruOIyx/0zK5jyzcn8SNLP15dAFbjA=; b=W
 6FJMH+JZ03AYAmJLVmgL5LX15+l1XFAA6bTy5gOsCVZTE+WqFbiFReCy/A44r8f3
 BoHjpfsKEFWeGihaLeyfOye0Py3LfYTWAurfS46b4Lzedk3Y44qzPGhFL/5qyfVF
 H3wtpbDeaQGspXMHA2OEkfyqBUxK5WstD7P9EG3qNbE8sbdEyzpM5NUXus3m6TLe
 IhC29fnzo/nzAQXqyBUaV84e0lnsOkWXBBh8TDpZ4ZUKr8Jm7AU8FxkSo7a9ro0U
 0OOodZ+KPsePPgEM+huUWEqfFjkD+Hn9TulrraWquKgOHgAF/z686OL+9z06HUEh
 Q9HWTG1s8CvByTy6I0OMw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=defmacro.it a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795446297; d=defmacro.it;
 mf=PGZvc3NAZGVmbWFjcm8uaXQ+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:L4EfvxQ4nXUU7TWS4NXF0JCUhP9TXEvaaSMw6Fx8Wq3LWtG
 FpY6G4E+0CSnR8Rhx0uJ9n8Tvc7CH+DgTw933uxk8WASW3YNwVYU1zKqmwCuB+E6
 uW8yfTgTpaVncwf9QBP2szBRE98BzKdMN93+qIXgT3NX+aL/8a/z6qyTPdtot3J4
 eRebInpjoDWhamq1a2G0g4zj609gtIKqbYgUiUcSkhIjK2d90iJt29YKvpaY40UB
 Tb2i2RHsTOdLNinYkaz3T5RRT0IDE71CLlcp2dv9dn0Qr/kKYYBYZaiv38hm4gpZ
 09oQ/tQZURMCiaqTfa/Q8e2kybMQLITQQygEWhw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:qgXJS2t5So4zyMRSVaR1b71Z+m7iz2Xk31fa+dh+IS0=:hQnyvlpU7cI68wCzqaFp5H3ncE8hTLT8vH+Gewr8Kv0=;
X-ME-Sender: <xms:GVYEa-cLDBWW96PK6CBfacS-QXRPRHB2YaeT9GiWhmUL1v9p1ZMOlQ>
 <xme:GVYEa4pRaCVFVr-RJIZHRxza7p6XJr6MkE8ztc7WSbLNED_ysYJ13YA_6oFS8hJ9T
 jO-heSg62adVvzeRG8yZQwk6Fq3mBW2jBhKFDgWUxQ8avyCrbK25e9->
X-ME-Received: <xmr:GVYEawOw60altpQmRiOB9SRZeiz0kJBwKv7kvpZpCqL1gzJn3W0kcgC61uZsZBGB7AvrnI6HB2UDc1zPSiS8UE10fmMF_BA49TjB>
X-ME-Proxy-Cause: dmFkZTE+oIySUTencSDrezjdlYlA3KRh/B+gt/B7pvsu4MYYZUmi9LXvi9Ffrqz4t56wFH
 eDEN1nNdacz5DD1luGTgKjOqmCi06+6FPKXqnvYVkitPCyyh5BZizsVnUsjbYqWs7QIb+m
 KHSxtZhJEfsjm2cF5L++Mi7A+djysq2nH/FN84chbpJMoWKoEui2Lm3b3ikSnZ5VKaUqbI
 nwmFM4Ie4ZaT4pNhF1HIQWpJZ9q9IkC/OfP7nGHsmxwKnRtVil+fcHNEgWhQG+7qx11qUr
 3uSsMPiQDMStnjDIePLvIjHwJ8aCzUSJ50KHyZNdCVN5tVRmohrAi9u15+uOtwQMfFJ0HF
 jn6nZMjYDaNoYKOCiAlfxl2314ip6bYFAoLjwSjgIkDV7M6pFr6do8Q/ZAG+dZ1qRB+R4D
 gvRugVj+QymRwT2+7tM8HcFoctEQiTTfG0nwMWGNCEdbFQQhI7b2+REUBhL5rNmz03mrKe
 Zyeck4w8Ny/zZ9auO3LfKqIbizW+10ZoM8KpwY919DTXmr5XcV7titFjuaS1CFkay0QsSR
 la1nU7PGw6liuQWqptQiXSQ/MyQdM7In/2wz5IO9KyjLJZtVRdy3KKXXESmX+TnCczbd53
 +DHjjituabpK0NmDExELGQSVNWSBRach87fPG3sn37EfN0LrcAh7JI2TvySg
X-ME-Proxy: <xmx:GVYEaziKDEesMEV7mzenz9t7wHzj2TAQ-IQ7qp_FREXEMbYfjivuZg>
 <xmx:GVYEa7tiy_NZjrxcYW3lxYqu9sGL-LroCaHhQH-gWpANDJT56j1Ngw>
 <xmx:GVYEa_gMJueATAQb7Soi5nFhdDr__Qt1WKYUdjQz4l4hVs8SMEYkkg>
 <xmx:GVYEa5YtmPuWvwKUriH7Up91By_kLnkAz_PFkDDonkWW2ieniENujg>
 <xmx:GVYEa0nO2ikmc8SAE8eBCae5GpuXvhtRrazRD41O7iEQttu0LxIAukWu>
Feedback-ID: ic0014905:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Nov 2026 10:04:56 -0500 (EST)
From: Jesper Devantier <foss@defmacro.it>
Date: Mon, 23 Nov 2026 16:04:50 +0100
Subject: [PATCH v2 03/12] hw/nvme: fdp enabled helper
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-jwd-181126-fdp-fixes-v2-3-4c9893537cd1@samsung.com>
References: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
In-Reply-To: <20261123-jwd-181126-fdp-fixes-v2-0-4c9893537cd1@samsung.com>
To: qemu-devel@nongnu.org, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>
Cc: Jesper Wendel Devantier <j.devantier@samsung.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=103.168.172.150; envelope-from=foss@defmacro.it;
 helo=fout-a7-smtp.messagingengine.com
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

Signed-off-by: Jesper Wendel Devantier <j.devantier@samsung.com>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index c8da01f11d0..5d4122309ea 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -385,6 +385,11 @@ static inline bool nvme_parse_pid(NvmeNamespace *ns, uint16_t pid,
     return nvme_ph_valid(ns, *ph) && nvme_rg_valid(ns->endgrp, *rg);
 }
 
+static inline bool nvme_fdp_enabled(NvmeCtrl *n)
+{
+    return n->subsys && n->subsys->endgrp.fdp.enabled;
+}
+
 static void nvme_assign_zone_state(NvmeNamespace *ns, NvmeZone *zone,
                                    NvmeZoneState state)
 {

-- 
2.51.2


