Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD73C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:13:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSHb-0006hK-1Q; Mon, 14 Jul 2025 19:08:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGX-0003dg-Kd
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSGW-0005Uq-3r
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534439;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4I4y8d1dQyBgPX2DNvcPSwOHDWsxQQcjuy3NVZekjJE=;
 b=LcNmT4kcYhB0v3C7kXDSPv3RktP3gN49TIqLZmAkHXXZYxjC+DuxF1sHPaPOqArfIwLihq
 xUjwzD/VVSaFjxoYB9bBE7h2io7JYVzEH1w9l4HKW9IIUa8EvW7CvHFqZ4aRFe7kyjQHlh
 MnKTeXnLC0dGqvU245UJ3JEvvvFpG9s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-j3Yc66qLOYeFIKBJrXLQUQ-1; Mon, 14 Jul 2025 19:07:18 -0400
X-MC-Unique: j3Yc66qLOYeFIKBJrXLQUQ-1
X-Mimecast-MFC-AGG-ID: j3Yc66qLOYeFIKBJrXLQUQ_1752534437
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1746326f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534437; x=1753139237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4I4y8d1dQyBgPX2DNvcPSwOHDWsxQQcjuy3NVZekjJE=;
 b=pPberbd3CsBnBK48lc2l4w274yEuIRDORaeqTvDjd/42eIlDnx6tlr9OboGriW/ZvN
 Z+EEN1oxlOH8le9qm5hBSzuSHFhqm3XnIrioOZWvpsTmKuSu2DtMQJgtgFJmiYciAyDg
 WAZkGVxjvGNUMXQlYzLyewWJ4A9ADZFDn+YyvdL0BEg0eDK5RdegOtZvIIRJqdXK2G3k
 cwKlFyyWPHYszSTCN7KP4+iM6ya6T/xAeMwnfiY8sN8N45iWUhHqnuwX3J4uBhsU5fES
 UgqYGCTOJj/bnofBQwNYLVzClw7gMPHPZFjq45Q6+0ZBP+SJXqnsLx1myy3IglerKmdt
 tfJA==
X-Gm-Message-State: AOJu0YyizYzLriBnIOFvtMPgcv/pczeS6H13nViSDj8acPAC210KIlD2
 ogq62EMhO0CXgkUh+9rlDUErqhd6hcSxJh4nCQ3QIbvGhSEDNC9zhX7WV3qznuUOWFQb3WffLIO
 ZJmNxg1EnWeJZ0H8k6/O4hRSxDXgzilbjYhC9SLiGoiZuAHySXv70ZVVSP8bDVx7k9oQjzne358
 dolLBATIzk1IZThR3IojLor1sgesN88QUtpA==
X-Gm-Gg: ASbGnctV5DKI8tAo17yh0TrlspQO2mfSUdIaHsEEcc/1Plt2xthRbQXMq28xEPdF45a
 2HckjFXzNyBhlmDQ9PnROWNlYDom/amXuoDslsQHFr2lRe1xSuTSa2PZuYzFD7XQiXSIRz7Zgey
 LiUdX9LE+Bru1GSc0qlIf/nA8LgrNWP5CRjZYFw2g8FP/yVe5W+yWcCytpnhPh6DQEcWVkyx/Co
 y0hDnBEX/KXVa11L2OPT2caf6BiofN08x8Dg1BduFp1FFKrjBr+J13P4rKMcHjizEaI2JPT3ogR
 BBn++K9VvhllGwAlpTYi0ju8k2VI2/s3
X-Received: by 2002:a05:6000:2913:b0:3a4:f744:e00c with SMTP id
 ffacd0b85a97d-3b5f2dfd84cmr10701493f8f.29.1752534436789; 
 Mon, 14 Jul 2025 16:07:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcRXJuoYvrhIKEld4juKp2oTrJXNbCSreIBXLecet80NJ2Dw0qFx/qmojN2NM6Je5MypYWpQ==
X-Received: by 2002:a05:6000:2913:b0:3a4:f744:e00c with SMTP id
 ffacd0b85a97d-3b5f2dfd84cmr10701473f8f.29.1752534436331; 
 Mon, 14 Jul 2025 16:07:16 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e26c8bsm13388117f8f.88.2025.07.14.16.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:07:15 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:07:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Ethan Milon <ethan.milon@eviden.com>, qemu-stable@nongnu.org,
 Vasant Hegde <vasant.hegde@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 24/97] amd_iommu: Fix truncation of oldval in amdvi_writeq
Message-ID: <5788929e05e18ed5f76dc8ade4210f022c9ba5a1.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ethan Milon <ethan.milon@eviden.com>

The variable `oldval` was incorrectly declared as a 32-bit `uint32_t`.
This could lead to truncation and incorrect behavior where the upper
read-only 32 bits are significant.

Fix the type of `oldval` to match the return type of `ldq_le_p()`.

Cc: qemu-stable@nongnu.org
Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Ethan Milon <ethan.milon@eviden.com>
Message-Id: <20250617150427.20585-9-alejandro.j.jimenez@oracle.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 92f94dc788..5a24c17548 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -140,7 +140,7 @@ static void amdvi_writeq(AMDVIState *s, hwaddr addr, uint64_t val)
 {
     uint64_t romask = ldq_le_p(&s->romask[addr]);
     uint64_t w1cmask = ldq_le_p(&s->w1cmask[addr]);
-    uint32_t oldval = ldq_le_p(&s->mmior[addr]);
+    uint64_t oldval = ldq_le_p(&s->mmior[addr]);
     stq_le_p(&s->mmior[addr],
             ((oldval & romask) | (val & ~romask)) & ~(val & w1cmask));
 }
-- 
MST


