Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EB0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:54:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3re9-0006xC-44; Wed, 01 Oct 2025 03:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdr-0006c8-ES
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3rdm-0003B7-Jj
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759305159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wkmJmPrqH3IoM0HBrMlgVGI5gpDbA3okoWc8ks14C1w=;
 b=NUazE15Nsj8RxekEvK/dJoLk4QmHBSsxBjiprZ0QjMLBDNgVeO2Oe6HoGEUQdhzyFLLpkH
 Qx+N8WBiNDFN7So8jjCVyP6ej90tElhoUMgIkOPRYhz8tw1yopCpwczOr6cenO/ZxWYnrV
 sxdceJPelk9tBJQDV+s5izg5bdn6NWw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-213-a8N7uEwzMXK9n3FuEJ4NTw-1; Wed, 01 Oct 2025 03:52:37 -0400
X-MC-Unique: a8N7uEwzMXK9n3FuEJ4NTw-1
X-Mimecast-MFC-AGG-ID: a8N7uEwzMXK9n3FuEJ4NTw_1759305156
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b04a8ae1409so963012866b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759305156; x=1759909956;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wkmJmPrqH3IoM0HBrMlgVGI5gpDbA3okoWc8ks14C1w=;
 b=BaPtQ+txvl3euxsv3zMjb3JT7OgttJzT33rw3QqXF2917TrYR7i/ST3r01s8QCoiRy
 HZAS2xb0zuaDSodv2JSFaYcg64nCExaSm7bDPvyAlm9esl58ZSde/fXY3gO4u/Yjk7GI
 eT85Ins5Ka4GG4gKIMe/Oa4y2GoETT01XTvFQxzeMF2P5c0Gbe9czF+RInlRx56HmElH
 sMAI3zXKUjzQBR8KgJAIM71PuEJHGrtq8zOlAAXRa39dDqNmu2AORjDkJ/uFQ/GPgUXt
 Zz7Bzd4Bd9Nk/g+6SGwUjG2L6dfqlwwdpYh1L2xeHCDys7BO6nHQ81//tvsDRn3hNbeM
 UiTw==
X-Gm-Message-State: AOJu0YyABfrjnmGhZepo8aWDHMXCPRHoqqWFN7Gg/ZVe3rEYWdiHx6GM
 Djk0vyan6atMzkp6N/6wtX+WvVSGFMsJLnwEDlI1HdrXib77xJwG3JZ+5NjbZUaYB/OwyCuyRO2
 h0rwSDijxGSmLEY8mqbXI31bwgJYlOsJSQD67PiEAd+tQ/TPjwWszTjdv1nXxW8Wcf7B4B4C3VA
 azed5+M5O0+rwQo9XGpPbVzGLzvFZ87LloLSClgRMN
X-Gm-Gg: ASbGncsa9Ga/d/hvLRvBA6ALAhfDo+1qiwHXy5kGYFV5WAR0EESAiLwwZ3+jUu3V9NK
 UCOZRnI/JUOfARHTrKB4psw/0Y7/P6+aLVuvtCUoOV2syZYOUr1onn4o0pMZ/weLapnpX4rUnfn
 Klh1kMgzEaExDW6SgiExSlH+U5rWxv+fc8igOQ3Ai/AOnPQy+l0ReDNqEI+XEG8XoS7sjw3vQch
 Bh9GM3KI0JZeD1HP/7w1x9t0IdDhu3Fbr14OEw7U9SoLkAvpPvvSZb5617MgANWlWlnY4ezR63T
 24wzIhEkoqjf7V2LkfJhJux+6nTA1VqESVwiruzqrebTlgBRotidPvK+XppmNxaHop4FJfbd96t
 XJy3xRp0X5VmQqmA2V2Fb1Qgvxtu1RpeNk2SmFTCW/2GwowpcuHw=
X-Received: by 2002:a17:907:6d0b:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b46e43aae78mr336804866b.10.1759305156145; 
 Wed, 01 Oct 2025 00:52:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcPAsowgyBe0WjwQd5OdqeYzVwW2rSbqDmeQPQmmj3PUB1ZmokupnLMBQ7kDlgs31x+K1UXQ==
X-Received: by 2002:a17:907:6d0b:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b46e43aae78mr336800266b.10.1759305155694; 
 Wed, 01 Oct 2025 00:52:35 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3f575aa694sm549217966b.54.2025.10.01.00.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 00:52:34 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 11/11] rust: migration: implement ToMigrationState as part of
 impl_vmstate_bitsized
Date: Wed,  1 Oct 2025 09:52:10 +0200
Message-ID: <20251001075210.1042479-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001075005.1041833-1-pbonzini@redhat.com>
References: <20251001075005.1041833-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is most likely desirable, and is the easiest way to migrate
a bit-sized value without peeking at the innards of the bilge crate.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/migration/src/vmstate.rs | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 2a29aff7cd6..c95f8ece776 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -295,6 +295,25 @@ unsafe impl $crate::vmstate::VMState for $type {
                                           as ::bilge::prelude::Number>::UnderlyingType
                                          as $crate::vmstate::VMState>::VARRAY_FLAG;
         }
+
+        impl $crate::migratable::ToMigrationState for $type {
+            type Migrated = <<$type as ::bilge::prelude::Bitsized>::ArbitraryInt
+                                          as ::bilge::prelude::Number>::UnderlyingType;
+
+            fn snapshot_migration_state(&self, target: &mut Self::Migrated) -> Result<(), $crate::InvalidError> {
+                *target = Self::Migrated::from(*self);
+                Ok(())
+            }
+
+            fn restore_migrated_state_mut(
+                &mut self,
+                source: Self::Migrated,
+                version_id: u8,
+            ) -> Result<(), $crate::InvalidError> {
+                *self = Self::from(source);
+                Ok(())
+            }
+        }
     };
 }
 
-- 
2.51.0


