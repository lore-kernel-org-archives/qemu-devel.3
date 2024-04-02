Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA3A8CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:34:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrcPi-0007WV-50; Tue, 02 Apr 2024 07:34:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPb-0007Sk-9r
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rrcPT-0006eu-3u
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 07:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712057674;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kmfWPYUoXX6bScoUXzhELmYVEYe3YTHOcJQw40qC8FE=;
 b=KFFtc20pXCfzPVM5G6NuM2ax5lH8L+I7+a27Wk9R3ZgHBaisq58fcUYaXlFsodzrB85a4v
 cerxlcAc6uYZVlz+MRNAlZJPqUjW3qQA71+XnFsIX7rUwrUU+aDkz7A7VuA9WKTakBsFKC
 C9jUJtEvIGVuG6K5NjVCH7HNZCK5ZSs=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-Z5AKJwSjNsmAyYoskNQ9RQ-1; Tue, 02 Apr 2024 07:34:33 -0400
X-MC-Unique: Z5AKJwSjNsmAyYoskNQ9RQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d45c064742so51519851fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 04:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712057671; x=1712662471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kmfWPYUoXX6bScoUXzhELmYVEYe3YTHOcJQw40qC8FE=;
 b=DFhvaSvCm+yZ4fdoiZjjit+DnDvke/uhffzo740jwgCtrSyq0P06Bj5bepH7m6fS7K
 uKwYLb1VZwVNKn3ysMQg5MW2jJRn2s5hGWrbbiouWq8MFTfmFAs8evGzvq0yCrNQlMd4
 jsBGxG+G/hS2qFESQeIGfOQQ/ZA5hkJyrB5Y/uQek4IjfMqhzA4RkSRjZGzzP0VwAdgN
 SdNfSD02F8chWfTqaOrY0J6O5jC2NN31isK22VSO4mkFELiRHG4Z6JTTPDBOEGs12uRH
 XRRxJh1kkXS9cv+YqOVRtmCW5VdUa8N5paaLpmEelUzVo88KR5T2FbPhjfvUTyZLewpG
 d39w==
X-Gm-Message-State: AOJu0Yzz6tgLejXgwAkFTZ5Vv0yvreFNg2og1PjsD+mdz2Akr2zV0JlZ
 bfgmlBaNMnBTmJdF/dG0JX49hTG4w2AN0NECm2WhqPPd0q1TxFRXYGTSTaIcfaH7z2PcFhjyLtQ
 AQrziJBmfhb10gdc+0IEnSpb0oLyzifxAQ9+wGssL/qJhhC+LSNr09YXSJ5i+dwsvX/j3eL19TU
 BpNBGEThvzmxv5gCE/w2YtITMIwAdTLfd6PHpp
X-Received: by 2002:a05:651c:381:b0:2d4:49d0:d20b with SMTP id
 e1-20020a05651c038100b002d449d0d20bmr7333342ljp.5.1712057671420; 
 Tue, 02 Apr 2024 04:34:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvmOKqvU4PGTpSlJhI2MJGdbMxq3yUgltkcwTmbpzddQwKHCTZaoCWjffkn/m1neOCBH8h2g==
X-Received: by 2002:a05:651c:381:b0:2d4:49d0:d20b with SMTP id
 e1-20020a05651c038100b002d449d0d20bmr7333292ljp.5.1712057669850; 
 Tue, 02 Apr 2024 04:34:29 -0700 (PDT)
Received: from avogadro.local ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 ay33-20020a05600c1e2100b004156a816048sm4789657wmb.35.2024.04.02.04.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 04:34:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Helge Konetzka <hk@zapateado.de>
Subject: [PATCH for-9.1 6/4] vga: move dirty memory region code together
Date: Tue,  2 Apr 2024 13:34:08 +0200
Message-ID: <20240402113408.18048-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402113408.18048-1-pbonzini@redhat.com>
References: <20240402113408.18048-1-pbonzini@redhat.com>
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

Take into account split screen mode close to wrap around, which is the
other special case for dirty memory region computation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/display/vga.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/display/vga.c b/hw/display/vga.c
index 77d709a3d69..e91a76bf76b 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -1596,6 +1596,10 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
         region_end = s->vbe_size;
         force_shadow = true;
     }
+    if (s->params.line_compare < height) {
+        /* split screen mode */
+        region_start = 0;
+    }
 
     /*
      * Check whether we can share the surface with the backend
@@ -1667,10 +1671,6 @@ static void vga_draw_graphic(VGACommonState *s, int full_update)
     y1 = 0;
 
     if (!full_update) {
-        if (s->params.line_compare < height) {
-            /* split screen mode */
-            region_start = 0;
-        }
         snap = memory_region_snapshot_and_clear_dirty(&s->vram, region_start,
                                                       region_end - region_start,
                                                       DIRTY_MEMORY_VGA);
-- 
2.44.0


