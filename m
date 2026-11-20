Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECA5606A320
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=irrelevant.dk header.i=@irrelevant.dk header.a=rsa-sha256 header.s=fm2 header.b=HlJHSOOr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ZI+me4ct
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUNky-0001ZL-09; Fri, 20 Nov 2026 07:30:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNki-0001HN-Gg
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:09 -0500
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>) id 1xUNkg-0007mx-J9
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 07:30:04 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id 9A8371D00396
 for <qemu-devel@nongnu.org>; Fri, 20 Nov 2026 07:30:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-05.internal (MEProxy); Fri, 20 Nov 2026 07:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-transfer-encoding:content-type:date:date:from
 :from:in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1795177801; x=
 1795264201; bh=pVJC8922wZIgyUscrcAUPh1iM1q70XqtWXEtXwdlHgw=; b=H
 lJHSOOrUgjQH5dH4gxhLg/q4At7IqqwLjAPVmtDQ0dlCFsh3P4Vd/xFuWgPKBLTA
 0WMo5yFvJnAlTkfW9ef1HjSLHb41mReZRbJ0TkKQ4nNBsZpuwLN4wD0jrt4WZVw4
 285M+a+Vs4ccki5DEx2HN/lXEUXx7/gdROdz9KoVqFVOjlqp2jpyYq7JYNpTvde/
 JIVyUkEFj1NBmIwAvWwF0AbjiN19Bgih8cXMnReiMy1Sb0YMZ74j+anyILtUUlt8
 Izy4gsKzQsa8Nm96+zmnpscUOZ83/vYuovIJL9CEmfKSR4Yg4iUUKqPP7OHj0+Tj
 6KqcEymXz5Mx+q/79sIFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1795177801; x=1795264201; bh=p
 VJC8922wZIgyUscrcAUPh1iM1q70XqtWXEtXwdlHgw=; b=ZI+me4ct2PpWSY4fr
 1DKCXxVQZ1JAHr8VX/txVZ+AY7BO8sLT+rRp7B0LQxz+luy/phjb/cpXNiqag2xA
 4Or9V/GeiGhH6YXB/JSz1mIQbChgBtsdYVPy96QbL/V3fqB3AF2k0d8DxgTwGDEX
 ZXvVcHEcfshepARqdj8gjhJjQWlPDdFq9pLQsaUt6axoCrNg5lua0g8vzR5BcMk4
 n2lxxLqxrzlHw59OCnyX0GghsjpeE2ET8wHNNRg0vlWzpTD3RQoyCDCiHshBZ1Dp
 I8A7xXG4gAYhbR36QyjBGT1lYjpUWDHTMix069Ck9Jrk++ATrkKhg6NfS4ZtdWNW
 GxRsw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=irrelevant.dk a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795177801; d=irrelevant.dk;
 mf=PGl0c0BpcnJlbGV2YW50LmRrPg==;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:P3c4lIo9D6MYKSiuh7ur1AwUzCLMLbkkWm8r+458gF7ljPa
 jEXg6xcZFjAWT6wiNYl+Z2OQqkIKsF0+imTOupm6k8+HUHyFEBhbkPa8xGkUConU
 zTbe/P8J/706P+SBi49Dw2F/QVmDUil6aWX1BwFsG2HD0QLMpoNpzXDz1/JwdIsa
 s6n9Wpde7yKUlIqUPTvXeZElgl/qurE2qdb6/cIvlJAmj+PK/V+L0z6qaSRQZrXA
 MOsMAoOcm5DXZnbZF+BEY7K9M8va9uLjPfoFjHel6/9Dw7W3Iy4j+s8pDvijkA6h
 Zd1bHRCqCWyH92ncZFjAbiJwx1vfxgHTZF1TA1Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=11;
 hn=cc,content-transfer-encoding,date,feedback-id,from,
 in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:rmGhYX99Sida1NCd4QsVrlbBm5mQcsAMHoggy0uZ9Nw=:ZcfmdgaqxcNthBS0gxH3Krm7T4CxQfqCMnqC16c3gn8=;
X-ME-Sender: <xms:SD0Aa-ua5Z1q12DkXZqRJRv2C0AA91i8g24D0eTIyMiFV8qUtEGiaA>
 <xme:SD0Aa9h343Dl8PyLxkmIqk73UgpfcTD4rCapgzUGbUkveygpkHLgf4nXdj-dhHLxk
 sEK8Jf9e7EUriqwvMoKnLKPTrrp3_fC-33eymQkQsdv-r-sQnxGrSad>
X-ME-Received: <xmr:SD0Aa5pygK1slzzeeMQuQpDJtwrBLe1o2KqX-XgFahx-FLfkk20AQP48fTZfFC-TKM0KlFKKVIuWH6b1jSbKfsFLaVF9Bh9WgDkOgkx-W-IbVzhwohfpRLXU0g>
X-ME-Proxy-Cause: dmFkZTFExTPYgg8rgO42EmNi083fhhkydGLyZE921u8lzGuruqpOi7Ge9E8B6a/id363MM
 M8BuWLLMO4fVvHkeGeOvWlpeoA6GU35EKJN3DgbiBVzuwXF8r2cHQLJg8fU0rGl2E0dOeO
 s+Nw2MlKxrILceBWhs3BK1ffPSR4HqonM4K29WT+QrvPJ096TStn1G84JjDR/oel6TQubk
 pyaFkaRhqF5OW/axUdI48bq8biSN19b82iagHYFTHVCw0Gkg9xAKDwvCK7KO0j7WxrJBUI
 ZB+43jhea1ublyYSN1UTeSHfOMWuASCGqIz4XcJ9chfm7jLNIur7l8entiBUQTObBo0Pkj
 FLpunm7O1LCjvNH4+GIsm3QgaB7UcQ7PBZQEslAXbuYULc9CDKVC4wZzwe1y74kKEwfNIz
 pQrCcYBNX7sFcUam9Oxua+YLW/Vq8dYsru6n3Zz3d0/z9B8crvciepKv8iohPZfhGuSM9i
 p1Siyqc1euvOEv4EtAcrDQ9rXUmRAopiaJai5aRfe6J+wLc78AX1ktjhn7ubbcocmuEeFv
 xwmG+zPuYkLtrr+vFIEu6nGyRo4r/AGyUVrFAEZ1gv8VxAbjl2Zg/qp8ti13w6k/+9pit9
 pPqBxyvCmqLBtWSXBTw8vR6unvZKNMQ7JP6l9KaDNG01fJkT4e5nGcFXZThA
X-ME-Proxy: <xmx:SD0Aa6siCAdYb1AArDxuhtS_0TErOalz1aUwy37DLfB69yNvMb4TIg>
 <xmx:SD0Aa8YizSDkHaLmqkWklhBEQP7WPBnB6rxL20ch6nREt-uzxZ7YLw>
 <xmx:SD0AaxbQBnxvugsr4SMiLxNoXkFXFShzVNUlLo_c4aDZBtFGDZh-6A>
 <xmx:SD0Aa9nrYP4BkBHnQ6jOLxhhVFjYk9sVqQoGmCitCknUr6t9XBN9QA>
 <xmx:ST0Aa30IVKaS9XFthYT2VCHaxvWyr7-uQ7hb667m1hNgTgrkXYQk4i0x>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 07:29:59 -0500 (EST)
From: Klaus Jensen <its@irrelevant.dk>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 qemu-block@nongnu.org
Subject: [PULL 2/5] hw/nvme: fix zone descriptor extension allocation overflow
Date: Fri, 20 Nov 2026 13:29:46 +0100
Message-ID: <20261120122949.1044-3-its@irrelevant.dk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261120122949.1044-1-its@irrelevant.dk>
References: <20261120122949.1044-1-its@irrelevant.dk>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
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
-- 
2.53.0


