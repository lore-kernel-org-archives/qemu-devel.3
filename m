Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC1D606A88F
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Nov 2026 10:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rfc1149.net header.i=@rfc1149.net header.a=rsa-sha256 header.s=smtp header.b=JlTwmJ2E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSAZk-00087a-3r; Sat, 14 Nov 2026 05:01:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSAZa-00086x-Eh; Sat, 14 Nov 2026 05:01:28 -0500
Received: from zoidberg.rfc1149.net ([195.154.227.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sam@rfc1149.net>)
 id 1xSAZY-0007ro-Eo; Sat, 14 Nov 2026 05:01:26 -0500
Received: from 127.0.0.1 (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (Client did not present a certificate)
 by zoidberg.rfc1149.net (Postfix) with ESMTPSA id 8343380022;
 Sat, 14 Nov 2026 11:01:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rfc1149.net; s=smtp;
 t=1794650478; bh=G5yn2wKkwvMxnOlMsNoOxH5bAHTXonRrB9dTWI3s05A=;
 h=From:Date:Subject:To:Cc;
 b=JlTwmJ2EyQZjAyIHHUAzRT+EzTESJj0OOLwqkeqCagdcbouiB30DqMVwLe5zh+3uj
 20fw8GAESZNQJr1SLvz0rUcaKTH+2kIJAvD8yrX6JovZej0smAyo4maGTgmNAHKwHN
 v/ByT03Hbx3K5w6bHyOw3eVDT63mQZC3J+1e+hRtT2wo9H/xE0/HlaIXixl3ctWsvr
 46AtyDTbZKtUNt835VqRvGi4ojoOrwnZ4g0P16Ty3p83aYhMzkGCAnMkUXIxzNmx+b
 yDUNjqnRnuGIJEIusGCHgGtZJ3nED2o0nAbGbddbsQ6/kCvHTHamlHt9XwQ/PbuSYj
 KYfnz9wICr0DQ==
From: Samuel Tardieu <sam@rfc1149.net>
Date: Sat, 14 Nov 2026 11:01:14 +0100
Subject: [PATCH] rust/common: rename IntegerExt::bit() to single_bit()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-rust-single-bit-v1-1-da0172820f84@rfc1149.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrB1IrIbqVcRFTSd2RKJkklIQ7
 26sy7f4fwehwCTQFTsE+rLw6jN0WYD9vPxEyO9sqFRltNY1hiQRhf20EI4c0aiHMdS07dM5yNU
 WyPHvf+yH25LGmWy8NnAcJzgYLENzAAAA
X-Change-ID: 20261114-rust-single-bit-60366e5998ff
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 qemu-rust@nongnu.org, Samuel Tardieu <sam@rfc1149.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1580; i=sam@rfc1149.net;
 h=from:subject:message-id; bh=G5yn2wKkwvMxnOlMsNoOxH5bAHTXonRrB9dTWI3s05A=;
 b=owEBbQKS/ZANAwAKAaRXn0viD1ZBAcsmYgBq+DFuDlRBECx/pa/5KM5FR6MJwLfjXSPfZqgfc
 grlVSqPQ6uJAjMEAAEKAB0WIQQHrOpY7JQm2Kr/f7ukV59L4g9WQQUCavgxbgAKCRCkV59L4g9W
 QcV7D/4r/RTDgkfiwrJKEukxM51ensrOu/IflmuqkiOdVoTRlEEvcghffefWjD6CN4HDiGQsRK3
 V5Qf6U9C+TCCRvSs0jc1YU758ZY1FmqvMfByLZCDkkVLOBzQkOHvM87u9nIz/rFn0jPQR8vYQnr
 KTKGy+vfe+7Jw7I0Dg5oH7zLVKFTGh+86mGhqKE90LckmBJZb5YGlfn1gWE6OxY4rHhCQ57yN8C
 ErnFvbe7USiiFHI6idtS2Z05ffZCl0aLnXb6h+alA/xO5vpw/NJCQtKQV8wC3rtPtihUgwnFi2x
 NAAZfUQFSbjtIJWSXUpMRc477IQcCXk6YhWYOvqxmkt8YaRCyPmzWQKlDVS+DDNebGrlit8hrje
 +DxUpQfqDQ3qJLVAEA3Z15ae5uRHWi87HzIjEgfCFnF8BG0a4nVIKYbit6E9fEguyKcH2IipBJr
 oSWXuTUIQcqQyY8HYLkSnxMdxg2Xy+NKuna21Y0irl2yXdXub2IRXq3jWkxDJmwqKUs+py6gpfT
 y+zSm8zL0CK3DnnUkxxMlmZT+5L2/w+5YqUCE58VNPybxxUN1F//9huDrbRMV2VLh88rFbajYy2
 04c5xPjeHqyXfoOu9gIDtngHSNiyPo09sasq/71zcCNsOuYCkeEu50x9j1CKdDIIYljvHVcz+xW
 7Amw8oJn7rXlmDA==
X-Developer-Key: i=sam@rfc1149.net; a=openpgp;
 fpr=07ACEA58EC9426D8AAFF7FBBA4579F4BE20F5641
Received-SPF: pass client-ip=195.154.227.159; envelope-from=sam@rfc1149.net;
 helo=zoidberg.rfc1149.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An experimental Rust nightly feature `get_set_bit` introduces a `bit()`
method on integer types which checks whether a specific bit is set. This
clashes with QEMU's `IntegerExt::bit()` associated function which
returns an integer with one particular bit set.

While the `get_set_bit` feature has no planned stabilization date yet,
this is reported as a `unstable_name_collisions` warning when compiling
with the `strict_rust_lints` option, and warnings are turned into errors.
Renaming `IntegerExt::bit()` to `IntegerExt::single_bit()` prevents this.

Signed-off-by: Samuel Tardieu <sam@rfc1149.net>
---
 rust/common/src/bitops.rs | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/rust/common/src/bitops.rs b/rust/common/src/bitops.rs
index 06c78c3b8a..a0aff75d76 100644
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

---
base-commit: e9fa1f66f0d47c74b6766e1b8b87ad7c2a9394d5
change-id: 20261114-rust-single-bit-60366e5998ff

Best regards,
--  
Samuel Tardieu <sam@rfc1149.net>


