Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05458CA0FE7
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 13:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqtmZ-00033k-Ce; Tue, 26 Aug 2025 09:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtmV-00033B-PB
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:32:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uqtmM-0001kd-UX
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 09:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756215117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkPZsGp6ZeVYVc5x6Vipyv12yXqNlG0hQZLJpmHsBmQ=;
 b=PNTymDzYmxDEF2+gyKBxcCH8eiNceR0bj0ORn/V340Q7SRItAkIXFYV4575BODPjZQvFd/
 lumHa/CcL3dAuPCd4bEIExHoyRGZvQ14jxIt80txBKvqzXokvQrSqezx4v9EAva6ZSvGEY
 6b//pI/1rDQNFRmjWxC4C2oMx9TuRXg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-UQ5tiD64My2THa0PPvLGxg-1; Tue,
 26 Aug 2025 09:31:54 -0400
X-MC-Unique: UQ5tiD64My2THa0PPvLGxg-1
X-Mimecast-MFC-AGG-ID: UQ5tiD64My2THa0PPvLGxg_1756215113
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 037001955F06; Tue, 26 Aug 2025 13:31:53 +0000 (UTC)
Received: from localhost (unknown [10.45.242.16])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D20D91977686; Tue, 26 Aug 2025 13:31:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 pbonzini@redhat.com, qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 3/4] build-sys/rust: update syn to v2.0.106
Date: Tue, 26 Aug 2025 17:31:31 +0400
Message-ID: <20250826133132.4064478-4-marcandre.lureau@redhat.com>
In-Reply-To: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
References: <20250826133132.4064478-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Necessary for the following patch.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 subprojects/.gitignore    | 2 +-
 subprojects/syn-2-rs.wrap | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/subprojects/.gitignore b/subprojects/.gitignore
index f4281934ce..0073d61003 100644
--- a/subprojects/.gitignore
+++ b/subprojects/.gitignore
@@ -18,5 +18,5 @@
 /proc-macro-error-attr-1.0.4
 /proc-macro2-1.0.84
 /quote-1.0.36
-/syn-2.0.66
+/syn-2.0.106
 /unicode-ident-1.0.12
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
index d79cf750fb..560942befc 100644
--- a/subprojects/syn-2-rs.wrap
+++ b/subprojects/syn-2-rs.wrap
@@ -1,8 +1,8 @@
 [wrap-file]
-directory = syn-2.0.66
-source_url = https://crates.io/api/v1/crates/syn/2.0.66/download
-source_filename = syn-2.0.66.0.tar.gz
-source_hash = c42f3f41a2de00b01c0aaad383c5a45241efc8b2d1eda5661812fda5f3cdcff5
+directory = syn-2.0.106
+source_url = https://crates.io/api/v1/crates/syn/2.0.106/download
+source_filename = syn-2.0.106.0.tar.gz
+source_hash = ede7c438028d4436d71104916910f5bb611972c5cfd7f89b8300a8186e6fada6
 #method = cargo
 patch_directory = syn-2-rs
 
-- 
2.50.1


