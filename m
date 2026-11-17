Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E93606A881
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MAZOnx3Y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTJO9-0006ni-J0; Tue, 17 Nov 2026 08:38:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO5-0006jy-MC
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xTJO3-0003Bo-T9
 for qemu-devel@nongnu.org; Tue, 17 Nov 2026 08:38:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922695;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a3pHyXjdino8hK1/vyczWqrs3EtG1X4oXkpO/L6Z4dM=;
 b=MAZOnx3YlvNz7SDV8Usvt2Fs2vEN74LUctPTNEi5t4ccNaaoS+ERBvgIpgiK6TOQalGrdA
 guU0xbjdmNVLGbIcSMtGZbiceR1usKL+LDym+VAUdC9D1CeGXaHOq0aqlH93gScX1tiPyZ
 ow96Ny6rJcqqm29aJlQY59oLOfuDBQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-173-yTKIU2kpMimrgpayxpjc-Q-1; Tue,
 17 Nov 2026 08:38:13 -0500
X-MC-Unique: yTKIU2kpMimrgpayxpjc-Q-1
X-Mimecast-MFC-AGG-ID: yTKIU2kpMimrgpayxpjc-Q_1794922692
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F7AD19560A6; Tue, 17 Nov 2026 13:38:12 +0000 (UTC)
Received: from pbonzini-thinkpadx1carbon6th.rmtit.csb
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E2DA6436; Tue, 17 Nov 2026 13:38:10 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Samuel Tardieu <sam@rfc1149.net>
Subject: [PULL 15/15] rust/common: rename IntegerExt::bit() to single_bit()
Date: Tue, 17 Nov 2026 14:37:50 +0100
Message-ID: <20261117133750.322253-16-pbonzini@redhat.com>
In-Reply-To: <20261117133750.322253-1-pbonzini@redhat.com>
References: <20261117133750.322253-1-pbonzini@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samuel Tardieu <sam@rfc1149.net>

An experimental Rust nightly feature `get_set_bit` introduces a `bit()`
method on integer types which checks whether a specific bit is set. This
clashes with QEMU's `IntegerExt::bit()` associated function which
returns an integer with one particular bit set.

While the `get_set_bit` feature has no planned stabilization date yet,
this is reported as a `unstable_name_collisions` warning when compiling
with the `strict_rust_lints` option, and warnings are turned into errors.
Renaming `IntegerExt::bit()` to `IntegerExt::single_bit()` prevents this.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
Link: https://lore.kernel.org/r/20261114-rust-single-bit-v1-1-da0172820f84@rfc1149.net
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/common/src/bitops.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/common/src/bitops.rs b/rust/common/src/bitops.rs
index 06c78c3b8a7..a0aff75d763 100644
--- a/rust/common/src/bitops.rs
+++ b/rust/common/src/bitops.rs
@@ -34,7 +34,7 @@ pub trait IntegerExt:
 
     #[inline]
     #[must_use]
-    fn bit(start: u32) -> Self
+    fn single_bit(start: u32) -> Self
     {
         debug_assert!(start < Self::BITS);
 
@@ -105,9 +105,9 @@ fn test_extract() {
     }
 
     #[test]
-    fn test_bit() {
-        assert_eq!(u8::bit(7), 128);
-        assert_eq!(u32::bit(16), 0x10000);
+    fn test_single_bit() {
+        assert_eq!(u8::single_bit(7), 128);
+        assert_eq!(u32::single_bit(16), 0x10000);
     }
 
     #[test]
-- 
2.56.0


