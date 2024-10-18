Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 911ECD2FFF8
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 12:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1lkR-0007fW-8I; Fri, 18 Oct 2024 08:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1lkJ-0007ej-0K
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t1lkH-0003UF-DU
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 08:06:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729253174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=0GmJsbmZbfEk7JZtvep5XlsYZgrfd/O2JlM7Ljfl28E=;
 b=Q1cYy1otDQVjHoGCN9teN2CZv8BaIdi+2uy/+5iY3+F7NnRa4w6Hk7nf8jPu7GRi0/HyQo
 ghoZZ1LrZOqe7b3B4/a14vtyDkWcBI2GXSnwma/1RwoqQobOBrXYE1SYJYIBC7UjmeWq0Q
 SVN2RGq/e9yeOOK3iVe6J5bZx2nGNPw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-J6VWwWDwOdySMyo1zOR0Gg-1; Fri,
 18 Oct 2024 08:06:10 -0400
X-MC-Unique: J6VWwWDwOdySMyo1zOR0Gg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585201955F40; Fri, 18 Oct 2024 12:06:09 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.39.194.196])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 80AEF19560A3; Fri, 18 Oct 2024 12:06:06 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, manos.pitsidianakis@linaro.org, pbonzini@redhat.com,
 qemu-trivial@nongnu.org
Subject: [PATCH] configure: Replace literally printed '\n' with newline
Date: Fri, 18 Oct 2024 14:05:57 +0200
Message-ID: <20241018120557.43586-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.016,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The idea here was to leave an empty line before the message, but by
default, echo prints '\n' literally instead of interpreting it. Use a
separate echo without parameter instead like in other places in the
script.

Fixes: 6fdc5bc173188f5e4942616b16d589500b874a15
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 configure | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index 72d1a94225..0918147156 100755
--- a/configure
+++ b/configure
@@ -2062,7 +2062,8 @@ chmod +x config.status
 rm -r "$TMPDIR1"
 
 if test "$rust" != disabled; then
-  echo '\nINFO: Rust bindings generation with `bindgen` might fail in some cases where'
+  echo
+  echo 'INFO: Rust bindings generation with `bindgen` might fail in some cases where'
   echo 'the detected `libclang` does not match the expected `clang` version/target. In'
   echo 'this case you must pass the path to `clang` and `libclang` to your build'
   echo 'command invocation using the environment variables CLANG_PATH and LIBCLANG_PATH'
-- 
2.47.0


