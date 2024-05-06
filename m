Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 564B4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 08:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3t9R-0006ia-R7; Mon, 06 May 2024 03:52:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9L-0006Kx-KN
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s3t9K-0001jA-4Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 03:52:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714981957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n3vpEUsRGRbH/fpvacNXxdrZu8llumdrJ7M6KLKOzzM=;
 b=fbWO3+MAZVbXzAQXPtrYtk3sJYHDCCh8XKf9etDjGV2wBls8GCM0e+mnv+071JcWGv1jBh
 Scotgb+CnhurbKhh/7eK5zHIxFVurQAqW8nKJP85Uv1braBNRH7hFwnpdWMzKX8o7uz6MT
 zSWvRToWgPZqqA3/Y7HgCb/EGVVthos=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-K42BlKPpPnq_ZKYuuNz5OQ-1; Mon, 06 May 2024 03:52:35 -0400
X-MC-Unique: K42BlKPpPnq_ZKYuuNz5OQ-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a59caea8836so47211966b.1
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 00:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714981954; x=1715586754;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n3vpEUsRGRbH/fpvacNXxdrZu8llumdrJ7M6KLKOzzM=;
 b=mVVLi0IpeB0cGVlN56imijQO2SmGNmfQZo8/Wf2uRfk6/OlpxcuaWnhVutVJmpflbP
 ud9cOA38024ZZHQbiHb4ZFLiPqpaH/vs3B7/fYRn3QeW4bh54uwu/ziYvqLrDbI6u7lI
 SWCGA6aTE1kHaTcBlpxWrtq3FYH+PFg6s0N6Z+tgcjhEhWmF+x4g4Dsd3S2GJJYGqiJo
 cUI3kwmA8hScpsSCJ0FIzmL2tzomsPdXfrMJ55k2p6I0ScAZdWmyXCcerTY76wz/wShU
 NIWeXjUN7dLEYz2zYzZhaQOhoOQ0sHaJIwlGO/fGRIAhSRX7cb7uapyCEmcP5cKFAkNO
 d1lw==
X-Gm-Message-State: AOJu0YwnCpBuHPBlcVlIhgIz5CvQPuTE5C2VwT5dmeg/L5EcxI6EqFGF
 2syvKIO6J6wQO/IqO1f5WMHHRSknvd1RYIr7DTPP7Li5uNZPyZQdyirT+jZJu9HrdDKQ2ceNXaV
 7pBrtfkBSEeCdaPjYmiva737137lLabC8BFQpPc13/n+77PCIErcKnd+W87ALRoCWTKw2G1+8e8
 OEEMSJuQ9ISY0UU/NeqXCjoqQgUfV1DYUqkC9A
X-Received: by 2002:a17:907:29c4:b0:a59:9cc1:7330 with SMTP id
 ev4-20020a17090729c400b00a599cc17330mr3959550ejc.64.1714981954404; 
 Mon, 06 May 2024 00:52:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGd/xr1Oud7WQgc9pO/J3MgJJQyuziJrF2NZGTe34CAsqwe3zuJUGGVUIZnxEXo2bzntFzAqw==
X-Received: by 2002:a17:907:29c4:b0:a59:9cc1:7330 with SMTP id
 ev4-20020a17090729c400b00a599cc17330mr3959538ejc.64.1714981953977; 
 Mon, 06 May 2024 00:52:33 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a1709066b8c00b00a59c0ecd559sm1744622ejr.112.2024.05.06.00.52.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 May 2024 00:52:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 27/46] docs: document new convention for Kconfig board symbols
Date: Mon,  6 May 2024 09:51:06 +0200
Message-ID: <20240506075125.8238-28-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506075125.8238-1-pbonzini@redhat.com>
References: <20240506075125.8238-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.431,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Boards have been switched to use "default y" and are now listed
in default-configs/*.mak only for convenience.

Document this change and the new possibilities that it allows.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/kconfig.rst | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/docs/devel/kconfig.rst b/docs/devel/kconfig.rst
index ccb9a46bd77..52d4b905f67 100644
--- a/docs/devel/kconfig.rst
+++ b/docs/devel/kconfig.rst
@@ -211,6 +211,8 @@ declares its dependencies in different ways:
 
     config SUN4M
       bool
+      default y
+      depends on SPARC && !SPARC64
       imply TCX
       imply CG3
       select CS4231
@@ -228,8 +230,16 @@ declares its dependencies in different ways:
   directives.  A device should be listed under ``select`` if the board
   cannot be started at all without it.  It should be listed under
   ``imply`` if (depending on the QEMU command line) the board may or
-  may not be started without it.  Boards also default to false; they are
-  enabled by the ``default-configs/*.mak`` for the target they apply to.
+  may not be started without it.  Boards default to true, but also
+  have a ``depends on`` clause to limit them to the appropriate targets.
+  For some targets, not all boards may be supported by hardware
+  virtualization, in which case they also depend on the ``TCG`` symbol,
+  Other symbols that are commonly used as dependencies for boards
+  include libraries (such as ``FDT``) or ``TARGET_BIG_ENDIAN``
+  (possibly negated).
+
+  Boards are listed for convenience in the ``default-configs/*.mak``
+  for the target they apply to.
 
 **internal elements**
 
-- 
2.44.0


