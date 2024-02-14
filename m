Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7A4C48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 11:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raDDu-0001uj-1S; Wed, 14 Feb 2024 06:14:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDr-0001dV-Pf
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1raDDq-0006sQ-5w
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 06:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707909277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCVOMcJiLddQAE98l74rVjecbrg61kvWL8401omA3iY=;
 b=XtDlVgm+zHN8yyA+Ruk7tOOTq2ye/cvWChKX7G+1N7k+5PKGogMopg/N3vvbE95Bder/03
 401Y0j3SeByRRszP5Fuklj7MoaaiuNNbkbD6f6lZnhh1MJoceu1UtDpSdYNa0GzcPzXuUQ
 pA6AYuYeNb5nIvIPRzS92bzEVbTMFiY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-Q6KHLJMvPEqErtCEHzmXUA-1; Wed, 14 Feb 2024 06:14:35 -0500
X-MC-Unique: Q6KHLJMvPEqErtCEHzmXUA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5621c809accso455896a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Feb 2024 03:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707909274; x=1708514074;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCVOMcJiLddQAE98l74rVjecbrg61kvWL8401omA3iY=;
 b=ih1bLW+ebXBKUwFuJDwY8Ny62pyPNNwQVk8leOHKl5zHsYvnJyEozboUCSX4B9t94E
 JfvfV6cWwRyIbZNTcDpHqJ+I8k2VGyqUdq/Q8zS85YVe3MbxKxI2Da0qd2kLKVBFL2Og
 OYQtFhAouJXwd29lPGWw/Rr/zrn218pCKgb0P0oqnEtde7HpGGiZLKd/iYAAmgGsQxEH
 gSMfJtej0/Yww6HGbgfsExJawcFvzRcznzs+zUm+KHWBJx023U7pRykibfb+6CCOFDfI
 36+STdRQfn13HLgFeSoqn0AvW1R+8mXHQFreC1jMy+HMgIX2vqiL0uUyLBI1biJpKzkf
 1rlA==
X-Gm-Message-State: AOJu0YxliwcajIzt0dZtB8npJNLP3vyrDDT6aelr5vr+eXE6S+LDeuu6
 Gt5+g6GCRuJH0mZKmQYLNBiSq9jj275R9hAOiyNl+h0Uf8Bf60aA7LsE+QQZV3nmV0E3BXby7p4
 RbBKNcuJAgLaZ2pnsEQ1S5zAnXtTzdoMYKbf/mGCp3jAk7n4HnxDswqr5wg8q4WOYYhtjvkEj3u
 u+Wj3ndZwW2PUL1myC7dvFxkLN+EzCZQ==
X-Received: by 2002:a05:6402:26c9:b0:563:42c:5420 with SMTP id
 x9-20020a05640226c900b00563042c5420mr1330639edd.30.1707909274274; 
 Wed, 14 Feb 2024 03:14:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWvdfndwfDABzjfAvQs+a5JHcNzIgtBC8udj/EzP+91gBxbyIeX1/DOMT67EIhYlnSgAUlXg==
X-Received: by 2002:a05:6402:26c9:b0:563:42c:5420 with SMTP id
 x9-20020a05640226c900b00563042c5420mr1330615edd.30.1707909273925; 
 Wed, 14 Feb 2024 03:14:33 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+tl5wWQGa00DQGgpo93NJVvuJgXAmGOxDSEWYou6BVp3sEZyN5sL5SEbf1Ong3KXskEJxv/xFOHIP7/2QYuW8OCoaSxshCS6m3qfoFZUwOQzMHhJ+2IFLopHioKMBTEyXuwyl10nFZc4J8cb6XeRiHojRc2vPOsn4QvgXhATohuGmE5FNIA=
Received: from redhat.com ([2.52.26.67]) by smtp.gmail.com with ESMTPSA id
 da23-20020a056402177700b00561a0dc7934sm3217986edb.7.2024.02.14.03.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Feb 2024 03:14:33 -0800 (PST)
Date: Wed, 14 Feb 2024 06:14:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: [PULL 24/60] hw/char/parallel: Move portio_list from ParallelState
 to ISAParallelState
Message-ID: <ee3d1f1b46e0c304ee4065b3099734158f322860.1707909001.git.mst@redhat.com>
References: <cover.1707909001.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707909001.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.504,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bernhard Beschow <shentey@gmail.com>

ParallelState::portio_list isn't used inside ParallelState context but only
inside ISAParallelState context, so move it there.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-Id: <20240114123911.4877-4-shentey@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/char/parallel-isa.h | 2 ++
 include/hw/char/parallel.h     | 2 --
 hw/char/parallel.c             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/parallel-isa.h b/include/hw/char/parallel-isa.h
index d24ccecf05..3b783bd08d 100644
--- a/include/hw/char/parallel-isa.h
+++ b/include/hw/char/parallel-isa.h
@@ -12,6 +12,7 @@
 
 #include "parallel.h"
 
+#include "exec/ioport.h"
 #include "hw/isa/isa.h"
 #include "qom/object.h"
 
@@ -25,6 +26,7 @@ struct ISAParallelState {
     uint32_t iobase;
     uint32_t isairq;
     ParallelState state;
+    PortioList portio_list;
 };
 
 #endif /* HW_PARALLEL_ISA_H */
diff --git a/include/hw/char/parallel.h b/include/hw/char/parallel.h
index 7b5a309a03..cfb97cc7cc 100644
--- a/include/hw/char/parallel.h
+++ b/include/hw/char/parallel.h
@@ -1,7 +1,6 @@
 #ifndef HW_PARALLEL_H
 #define HW_PARALLEL_H
 
-#include "exec/ioport.h"
 #include "exec/memory.h"
 #include "hw/isa/isa.h"
 #include "hw/irq.h"
@@ -22,7 +21,6 @@ typedef struct ParallelState {
     uint32_t last_read_offset; /* For debugging */
     /* Memory-mapped interface */
     int it_shift;
-    PortioList portio_list;
 } ParallelState;
 
 void parallel_hds_isa_init(ISABus *bus, int n);
diff --git a/hw/char/parallel.c b/hw/char/parallel.c
index bd488cd7f9..c394635ada 100644
--- a/hw/char/parallel.c
+++ b/hw/char/parallel.c
@@ -532,7 +532,7 @@ static void parallel_isa_realizefn(DeviceState *dev, Error **errp)
         s->status = dummy;
     }
 
-    isa_register_portio_list(isadev, &s->portio_list, base,
+    isa_register_portio_list(isadev, &isa->portio_list, base,
                              (s->hw_driver
                               ? &isa_parallel_portio_hw_list[0]
                               : &isa_parallel_portio_sw_list[0]),
-- 
MST


