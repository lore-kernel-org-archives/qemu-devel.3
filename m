Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C588FC02196
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2025 10:20:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgLTL-0007Dp-1M; Fri, 07 Feb 2025 05:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLTF-0007Ch-UO
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:20:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tgLTE-0006BQ-Dz
 for qemu-devel@nongnu.org; Fri, 07 Feb 2025 05:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738923622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VfV5omvEttMhI3EQX/PeOloTPWUmqnbr5osfkTzsZPA=;
 b=STT82YIEWCFI24ogiz6CdCWBaMsqfyKTfu2ZZOARMt+WXBRDsuXLBSSBIfBMHIlbtY8LzS
 lQ6vgtEkXzJ8kY8LUbGpZNScv7ANycBUeUIdYfzPBs2AiyACuB3utj5slPl/CPgfEcssVx
 AaCq39PTKDFBBCWiuqXQwvqqxAM3858=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-bcE6NB4PMlqnPF1niivVjg-1; Fri, 07 Feb 2025 05:17:00 -0500
X-MC-Unique: bcE6NB4PMlqnPF1niivVjg-1
X-Mimecast-MFC-AGG-ID: bcE6NB4PMlqnPF1niivVjg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-aa66f6ce6bfso201060666b.2
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2025 02:17:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738923418; x=1739528218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VfV5omvEttMhI3EQX/PeOloTPWUmqnbr5osfkTzsZPA=;
 b=JnL7NPX/e3ZXcvS5nWix0txoSYd8bSmyP2xMWDDzVqtjsZ2ol9uw0SSLkQ6j657mC1
 h4wLHrLvCde5ZMXi/HboP2A3z/AgXTU/KvzAwybSsTSFlZxhi0Q9UAdxJdLPk6OTpD3o
 9CKQI790CCXLXGtqXK6z7X3BBJP8/txW4cU9cPzf0nurX41UjMajLNzFBd5/0yJXEirE
 SZH8rGNpQkPGkD+1g4YpGfFcA84+nhn9PB460mo1iChRjEDh6oYksCywpiorRRfv2Z0w
 u2iXdXjHdqatLmGi8rcsNFCmEeMm6m7GbM0nHi+6E6KV8JLvmVU3mJpMQeMfI2E1Q67F
 PorQ==
X-Gm-Message-State: AOJu0YyuKarkoHtEYdN1FaJG3OXpb6/nueJQsjzty+Yv5qVBoRlQzF3t
 8M1HBYG/fvKt5waq7atNtjeVZ3KAytSH+7jr7s1sPTJ0kNIELsLnY188UK02qgDoyVH+ydW0iJm
 M+Vik1WzIpTwT1vLnbeLVqCoJatuWA2y/d7zvEfhY/dGEEwJhkCFAz62xydENVV29KAckLHGwhP
 yWBnttmxL7nHXIwWojgYWaxuUpcCjF2NO5DXKBIjs=
X-Gm-Gg: ASbGncvFcAyXcc/xC2WtKgwVr3dWqj1pvSDKRUItpTNJGOMGRBC8gGv7+XGG4WmRX/j
 KFSZaX4mfbfeBRZNBTd3ruxOuujU6SRtGSw3iv2Ha1qxiwkx59qXOSp2z7h4uSyviGE/MgWbBDh
 Itm13rE2cCt7kKbfAIXoPA7VveHsXT2O+6CFQpjt4aMe/ib00ofvPSheiWBnhIGW32OrbG8XrpT
 Q60JXgzb39ft0hdFbfgbJDX2FGK8ccSeWKWixyADUTtS3dzBNUiKMsiiWtf0aXpl6bztdFdXYzD
 ZYKSxQ==
X-Received: by 2002:a17:907:6eac:b0:ab2:d721:ed92 with SMTP id
 a640c23a62f3a-ab789bfc571mr233637066b.45.1738923418155; 
 Fri, 07 Feb 2025 02:16:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IENxl2fGDbpXRhUB0cRg1D0aYQkWxbK9bKR2Fu7DI9m+bd5p0vWIL9kMuJAABQEtkcAZ6lzbw==
X-Received: by 2002:a17:907:6eac:b0:ab2:d721:ed92 with SMTP id
 a640c23a62f3a-ab789bfc571mr233632566b.45.1738923417520; 
 Fri, 07 Feb 2025 02:16:57 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab772f83e30sm240714566b.38.2025.02.07.02.16.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2025 02:16:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 06/12] rust: qdev: make ObjectImpl a supertrait of DeviceImpl
Date: Fri,  7 Feb 2025 11:16:17 +0100
Message-ID: <20250207101623.2443552-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207101623.2443552-1-pbonzini@redhat.com>
References: <20250207101623.2443552-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In practice it has to be implemented always in order to access an
implementation of ClassInitImpl<ObjectClass>.  Make the relationship
explicit in the code.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/qdev.rs | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/src/qdev.rs b/rust/qemu-api/src/qdev.rs
index 8f6744c5e26..cb6f12e726c 100644
--- a/rust/qemu-api/src/qdev.rs
+++ b/rust/qemu-api/src/qdev.rs
@@ -17,12 +17,12 @@
     callbacks::FnCall,
     cell::bql_locked,
     prelude::*,
-    qom::{ClassInitImpl, ObjectClass, Owned},
+    qom::{ClassInitImpl, ObjectClass, ObjectImpl, Owned},
     vmstate::VMStateDescription,
 };
 
 /// Trait providing the contents of [`DeviceClass`].
-pub trait DeviceImpl {
+pub trait DeviceImpl: ObjectImpl {
     /// _Realization_ is the second stage of device creation. It contains
     /// all operations that depend on device properties and can fail (note:
     /// this is not yet supported for Rust devices).
-- 
2.48.1


