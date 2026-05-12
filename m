Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD7CCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuP1-0004Ol-8u; Tue, 12 May 2026 17:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOe-0003vV-AC; Tue, 12 May 2026 17:12:08 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuOc-0004iM-HI; Tue, 12 May 2026 17:12:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619303; bh=2Gtggnx4uN7XeKrjgXmdEZpjam9YIWP8Xqby5s/AinA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RQXf7amGNujHGObHeZSx+M52/1ND02n+kpizb9l67nYx1a3ZUjJQ0N6dOKhp8RJhS
 eLL3rpxtMnBNMJqmNYhSYkHBLequ4mO3or/V/tZJr6WEhkuoLIwwk9YvqV9wTeUEjU
 B7urDZ76Bp7PuCMZGEk7FTTPwZfvd+3J9opu16lZ2nxXTzs+cYqEebNzDHnBUji/1f
 fKwgJYNkNTzk4iETRvmIa0K7iuQc5F47VrmBe6bW3t+6vbIhCv1Mo2Blf0MeMgBlmV
 kqKSyQZdnWQp14oNcnUqyeDLvFLURFer9WuqGdAP197dPwHouVhLK9GcrwqA/6nNWU
 cqKzWcgHRE0Bw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BDE241AA37B;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id CA9BD3ABCEA;
 Tue, 12 May 2026 23:55:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 061/117] rust: hide panicking default associated
 constants from rustdoc
Date: Tue, 12 May 2026 23:54:03 +0300
Message-ID: <20260512205503.361097-61-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Paolo Bonzini <pbonzini@redhat.com>

Work around rustdoc issue that panics while trying to evaluate
the constants.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 34f66fdfd285eb861cefcec2ab573dbbdf71cfc2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 4e983da28b..c2ca17f6ce 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -132,6 +132,7 @@ pub trait ResettablePhasesImpl {
 /// [`bindings::PropertyInfo`] pointer for the trait implementation to be safe.
 pub unsafe trait QDevProp {
     const BASE_INFO: *const bindings::PropertyInfo;
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const BIT_INFO: *const bindings::PropertyInfo = {
         panic!("invalid type for bit property");
     };
diff --git a/rust/migration/src/vmstate.rs b/rust/migration/src/vmstate.rs
index 267f9c8e05..f9d9f335b9 100644
--- a/rust/migration/src/vmstate.rs
+++ b/rust/migration/src/vmstate.rs
@@ -101,6 +101,7 @@ pub unsafe trait VMState {
     /// type for the length (i.e. if it is not `u8`, `u16`, `u32`), using it
     /// in a call to [`vmstate_of!`](crate::vmstate_of) will cause a
     /// compile-time error.
+    #[doc(hidden)] // https://github.com/rust-lang/rust/issues/149635
     const VARRAY_FLAG: VMStateFlags = {
         panic!("invalid type for variable-sized array");
     };
-- 
2.47.3


