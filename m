Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBF0C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 20:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFIIj-00079W-8W; Wed, 14 May 2025 16:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIW-0006x9-Jn
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFIIV-0003ZM-0L
 for qemu-devel@nongnu.org; Wed, 14 May 2025 16:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747252905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XMKQccz4NfqoEUSihdV88pqT2wjsRf3oFYxwpJIsn2I=;
 b=L7ZukfLWBYTdLVWyGYsDE1po9ef+2wRo6SIn7OamgXQHl1mXEUDo7ESAdDduOPWEZEwJzc
 wgKUaSCQncSga9fZ506UR660R50dS+H9z5g5CqT6Yr7p03hM+wCnNkN4MCps2iSqrVAg8g
 /Lg07C7mnqIVkau+oJIxLXXWdk4nnhU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-kVdYkez-PoiidPNKqMNNEA-1; Wed, 14 May 2025 16:01:44 -0400
X-MC-Unique: kVdYkez-PoiidPNKqMNNEA-1
X-Mimecast-MFC-AGG-ID: kVdYkez-PoiidPNKqMNNEA_1747252904
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f5462cdfb2so4112886d6.1
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 13:01:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747252902; x=1747857702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMKQccz4NfqoEUSihdV88pqT2wjsRf3oFYxwpJIsn2I=;
 b=WiKcjZkRl7AtsdfLWuyODNdsTrdHcVLKFhljIy55E+K61vooVp78b2mAxeNuMkAhlw
 HtfJJL7DFy3/ZcgNYXz3MwghzNc3/k4Uua/5jvU9JaJuRn3FfbKte5/5m3cXK4xQPGw3
 IICVphMCgEkEldgx1HXKE78SLUjaWNaEy2SWBCptHgK0USATu54lGO5t6/BVIetTlnmG
 A58re0stMav/qBnNNJAApdGJl14sc75UVlg+Lozk1bX6/l1UIV1zHvuaW1Fd3Vu4eJeF
 U/dXSBO3rRRGOW39gbWnS0RM+37o6ujH+TAcEr7ZFBwHg8ef9/hZ4P137H6c6M4AN2fG
 Vlqw==
X-Gm-Message-State: AOJu0YxiXiDYSVYFKdGqqpXZz+RbM5mTTeZamqcZTzlBn8RM4kN2vDI5
 Nt+gxmYj0/TqxAAP6UAKM8NFGqNST9bGR/VZ/5hH5CLQy6d+VtyQy2RaY5EGOP8ElfcAp9exzmP
 mOJ+5+wmMIH4kexixo5XTTLjqLx3OnkE3arM5BBVeiiyA4ok1PYObrn70dKl6POOIFOtbQvXE2b
 B+X1NDwnT0Vlxh6CrkBLaFJAz8qylZiCSghw==
X-Gm-Gg: ASbGncuRw9o42tvJtVjVcZ4kZaIjsMSiT3Atx2rV67RE11VLQDn9JBSLeb4Adg4c2fP
 2vPQZC1fINE/1Np9lb0XzN+bRE+a39g+1lvIWP/+dG5VqkPbVdD/UanPYbBytUaAnLwbzekTtip
 KtpKxiiSrscwAzleYQDrqf+DKhkcTzfpkV3BL2Y7Nx9XRds2LXC7yx1bi4aatqHRUvacssXHqZV
 nOMQFoR5Vkc/YFU5LaQuLlK9hvs+Q9EJqyBFIxEWdQGAiY+tPoyvKloQKrNLXpytcGTT19UxVai
X-Received: by 2002:a05:6214:da8:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6f896dfc14fmr71526156d6.1.1747252902424; 
 Wed, 14 May 2025 13:01:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNinB6BnAkaLTTKasbob2z3OMjCuSJniFW+VysELaJtkXRsFeT7UYfgpMD7AJoVeHJEDWdwA==
X-Received: by 2002:a05:6214:da8:b0:6e4:4331:aae0 with SMTP id
 6a1803df08f44-6f896dfc14fmr71525776d6.1.1747252901976; 
 Wed, 14 May 2025 13:01:41 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f6e3a524a6sm84979066d6.104.2025.05.14.13.01.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 13:01:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: [PATCH v2 1/2] migration: Allow caps to be set when preempt or
 multifd cap enabled
Date: Wed, 14 May 2025 16:01:36 -0400
Message-ID: <20250514200137.581935-2-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514200137.581935-1-peterx@redhat.com>
References: <20250514200137.581935-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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

With commit 82137e6c8c ("migration: enforce multifd and postcopy preempt to
be set before incoming"), and if postcopy preempt / multifd is enabled, one
cannot setup any capability because these checks would always fail.

(qemu) migrate_set_capability xbzrle off
Error: Postcopy preempt must be set before incoming starts

To fix it, check existing cap and only raise an error if the specific cap
changed.

Fixes: 82137e6c8c ("migration: enforce multifd and postcopy preempt to be set before incoming")
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3fcd577cd7..162c72cda4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -568,7 +568,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
             return false;
         }
 
-        if (migrate_incoming_started()) {
+        if (!migrate_postcopy_preempt() && migrate_incoming_started()) {
             error_setg(errp,
                        "Postcopy preempt must be set before incoming starts");
             return false;
@@ -576,7 +576,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
     }
 
     if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
-        if (migrate_incoming_started()) {
+        if (!migrate_multifd() && migrate_incoming_started()) {
             error_setg(errp, "Multifd must be set before incoming starts");
             return false;
         }
-- 
2.49.0


