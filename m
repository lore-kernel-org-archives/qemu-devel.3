Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6B13C27C53
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 06:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sENv3-0003Wn-1N; Tue, 04 Jun 2024 02:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENuv-0003Lm-No
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sENut-0007Uk-Oh
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 02:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717483507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gL7H6TrSHsDkCBwd59AyjrEB8aK2tm0LoE7ROoerM98=;
 b=Li655TP/RTa5WK0/dDnUt+LL/Wu0QZoCcjhb3+S4AmE/PsvJUq2awS+jOYm+wb1a+JmV/w
 pvsGTewNbW3lUhGD0lSdNV2rDFHnkuvIUceJo+IobNQYUjobIdE3a5x/pElxUY68NyA8g6
 pean7eJoBWX03rGEsMQYS2sYRfUNzdc=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-sMieBnRZNti30nyL4XTAqw-1; Tue, 04 Jun 2024 02:45:05 -0400
X-MC-Unique: sMieBnRZNti30nyL4XTAqw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ea91ce9225so34707141fa.3
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 23:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717483503; x=1718088303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gL7H6TrSHsDkCBwd59AyjrEB8aK2tm0LoE7ROoerM98=;
 b=H6rKAkCxIjaRSQOPeOQSLnDVtZ/NEiEQaLrWmYBaYroCH6R7063qfEon9H5JzjS/vy
 OhpmW75PTYrl2VT2rXus3wfcrZ05t+9w1Tofh+uDS7/X8CnoUuL7a8aOi93WeAHiTDGO
 0bmnOejnl2NJBv6ozCKzLXcUVsuuXBkKlhmJaimoRyqp0CrrR5zVCbunv54rzzR9wjnY
 amRCajDMt8VWlrNHLVZbkFT60P7rw9Kw+R6NsewsAgp7pqyGVdzomxWs5qOP+mVCzFpv
 gOCBzXG9R9+YnxB2RHvIGiAkv/aVc7o/kPKB76RY4FjZLq6DZcYOCMAKihPUrII+OUWF
 lgxQ==
X-Gm-Message-State: AOJu0Yy+9bYqfnwJA5UbmtH7Q8i3qSKhdSRky08z2mjY6vVJN5ecSrTe
 +WooYQ9qKkdcoFuXUEIKoinaTGdXL7KMa07btckzbyCmuAzkEzyu/YPPxu02Qoo8O7UL5T+bS6Q
 bXxCaXrG3Vdrr7gOqLbOxul4F0ZXwTpzExGxCilQkfqwbTWCrkEa7Q4Szzlvdj38u/ofD6ixeLz
 PP9ZePr2N0aLe7C9IaQfdCfw3zp7HGen34yyyc
X-Received: by 2002:a2e:3202:0:b0:2ea:83b1:bf70 with SMTP id
 38308e7fff4ca-2ea951df832mr90800411fa.37.1717483503085; 
 Mon, 03 Jun 2024 23:45:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHG2EFb3kpWeBCqXRCEX8l1FvNmNvGFoav8wXYBgU0trykJYsFWc6EhHUQLNDU52BsSkAXFtQ==
X-Received: by 2002:a2e:3202:0:b0:2ea:83b1:bf70 with SMTP id
 38308e7fff4ca-2ea951df832mr90800261fa.37.1717483502629; 
 Mon, 03 Jun 2024 23:45:02 -0700 (PDT)
Received: from avogadro.local ([151.81.115.112])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a68f8110912sm322669466b.17.2024.06.03.23.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 23:45:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pankaj Gupta <pankaj.gupta@amd.com>
Subject: [PULL 17/45] i386/sev: Replace error_report with error_setg
Date: Tue,  4 Jun 2024 08:43:41 +0200
Message-ID: <20240604064409.957105-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604064409.957105-1-pbonzini@redhat.com>
References: <20240604064409.957105-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Pankaj Gupta <pankaj.gupta@amd.com>

Signed-off-by: Pankaj Gupta <pankaj.gupta@amd.com>
Message-ID: <20240530111643.1091816-2-pankaj.gupta@amd.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index d30b68c11e4..67ed32e5ea9 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -952,13 +952,13 @@ static int sev_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 
     if (sev_es_enabled()) {
         if (!kvm_kernel_irqchip_allowed()) {
-            error_report("%s: SEV-ES guests require in-kernel irqchip support",
-                         __func__);
+            error_setg(errp, "%s: SEV-ES guests require in-kernel irqchip"
+                       "support", __func__);
             goto err;
         }
 
         if (!(status.flags & SEV_STATUS_FLAGS_CONFIG_ES)) {
-            error_report("%s: guest policy requires SEV-ES, but "
+            error_setg(errp, "%s: guest policy requires SEV-ES, but "
                          "host SEV-ES support unavailable",
                          __func__);
             goto err;
-- 
2.45.1


