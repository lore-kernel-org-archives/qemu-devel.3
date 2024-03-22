Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625A4CD11BF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 18:15:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnjNg-00006f-92; Fri, 22 Mar 2024 14:12:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNf-0008Pl-2T
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rnjNd-00078I-Df
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 14:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711131156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cjy7Ijt3qnLWCz8+8hriRM5HGAkmtAHB92I6+4Xy2m4=;
 b=YzcLZVmx+FPeRIOaBaJnaQsUvI/0em9C0krLpo9ncb1fmnjhpj/1zedO9pVMtdDiQJrHv/
 8fjSi9eoz7P56W5jXLf+4N7f/PXiwUnZhuxyl1DOPnlS+OFHXSKFwChatkS7JzXPLMgj0D
 x/cQTYfR2R9RzEeuGUYPv5/KF88yKS4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-K68jQYYGO2aQGS_z_rN8SQ-1; Fri, 22 Mar 2024 14:12:32 -0400
X-MC-Unique: K68jQYYGO2aQGS_z_rN8SQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a473769f8d0so35466966b.0
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 11:12:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711131150; x=1711735950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cjy7Ijt3qnLWCz8+8hriRM5HGAkmtAHB92I6+4Xy2m4=;
 b=cchez8SxEIFEOEu+uhtz4zAk85p5OlWSejI4SWq9CA0mnEGK9z+1W6srWbDqYcCprs
 YH3pN8gxdKK1e3MRAWQznhpqEMKS32SFxE9NgNU12+Id4ob03ffe/r2y0yp9XJqkkedL
 rC0Z4Cb1mTM0uTS/4d52wxLerm61mNRYkqGNMIpv/X++UgFx09Kf/Yjm3R5H2zvK3F8p
 1v9T+2A9zi74sEOLSztdIhfRQ1U1Aw1hNB754FXWkAoo7jMjRxNz0pxDd88PvIVhzYJ5
 sWXllqm9m4qRRRAyGbXPbgg9rHL716xXh/VWg6HP/3M1iWx9uUHb9m8tUspB2I/DE1jc
 yb+A==
X-Gm-Message-State: AOJu0YzrLi97KiPdK3/2KaGWlR0zIai1XlpBwal/2nB2NAZmfW2xEAPP
 axNYcPBGxT4Bv+sPAGPSQPhfLetEGM3DvzcqGEwHvn513GICiv1nK/5p0+zMQbUbHQO+/7/l6JC
 P/WUP0Z5pSANHVswzmOWm8YuA0g0EDssri/qfypZFrls8n2mQE3cyp4+I0/nNjOlEloR64bq7GV
 k0LwgYHY1ZLuHfrLniZILAzvpE5CKfMYwWIaKH
X-Received: by 2002:a17:906:c210:b0:a47:355f:6dd1 with SMTP id
 d16-20020a170906c21000b00a47355f6dd1mr352439ejz.6.1711131149829; 
 Fri, 22 Mar 2024 11:12:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNpsYYI6NpJcRv2UDKlDGtNwBwXJhWC7O91YdSSphTIdwj9uwU2RHNYTXvTLS1bkfEumYcnw==
X-Received: by 2002:a17:906:c210:b0:a47:355f:6dd1 with SMTP id
 d16-20020a170906c21000b00a47355f6dd1mr352426ejz.6.1711131149550; 
 Fri, 22 Mar 2024 11:12:29 -0700 (PDT)
Received: from [192.168.10.118] ([151.95.49.219])
 by smtp.gmail.com with ESMTPSA id
 mc2-20020a170906eb4200b00a47152e6d10sm71501ejb.134.2024.03.22.11.12.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 11:12:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com,
	michael.roth@amd.com,
	david@redhat.com
Subject: [PATCH 23/26] RAMBlock: make guest_memfd require uncoordinated discard
Date: Fri, 22 Mar 2024 19:11:13 +0100
Message-ID: <20240322181116.1228416-24-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322181116.1228416-1-pbonzini@redhat.com>
References: <20240322181116.1228416-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
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

Some subsystems like VFIO might disable ram block discard, but guest_memfd
uses discard operations to implement conversions between private and
shared memory.  Because of this, sequences like the following can result
in stale IOMMU mappings:

1. allocate shared page
2. convert page shared->private
3. discard shared page
4. convert page private->shared
5. allocate shared page
6. issue DMA operations against that shared page

This is not a use-after-free, because after step 3 VFIO is still pinning
the page.  However, DMA operations in step 6 will hit the old mapping
that was allocated in step 1.

Address this by taking ram_block_discard_is_enabled() into account when
deciding whether or not to discard pages.

Since kvm_convert_memory()/guest_memfd doesn't implement a
RamDiscardManager handler to convey and replay discard operations,
this is a case of uncoordinated discard, which is blocked/released
by ram_block_discard_require().  Interestingly, this function had
no use so far.

Alternative approaches would be to block discard of shared pages, but
this would cause guests to consume twice the memory if they use VFIO;
or to implement a RamDiscardManager and only block uncoordinated
discard, i.e. use ram_block_coordinated_discard_require().

[Commit message mostly by Michael Roth <michael.roth@amd.com>]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 system/physmem.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/system/physmem.c b/system/physmem.c
index f5dfa20e57e..5ebcf5be116 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1846,6 +1846,13 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
+        if (ram_block_discard_require(true) < 0) {
+            error_setg_errno(errp, errno,
+                             "cannot set up private guest memory: discard currently blocked");
+            error_append_hint(errp, "Are you using assigned devices?\n");
+            goto out_free;
+        }
+
         new_block->guest_memfd = kvm_create_guest_memfd(new_block->max_length,
                                                         0, errp);
         if (new_block->guest_memfd < 0) {
@@ -2109,6 +2116,7 @@ static void reclaim_ramblock(RAMBlock *block)
 
     if (block->guest_memfd >= 0) {
         close(block->guest_memfd);
+        ram_block_discard_require(false);
     }
 
     g_free(block);
-- 
2.44.0


