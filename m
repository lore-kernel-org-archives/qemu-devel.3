Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5154BD5E154
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 10:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9MSe-00048v-Ec; Fri, 08 Nov 2024 05:43:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSd-00048c-F7
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t9MSb-00068X-7b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 05:43:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731062603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gIN+84P0z6LauJlEQr+ZQXSO1RWV1B3JIaI4h+K8Og0=;
 b=XX30VnOAsyusXvbsVOXKFVN8ING+vs93XE8Ma0cu2wJJJnDsM8yVM2+Pzw40nN5W47qBgn
 ip2jQOV289XBF6+6/6npe1BHRWkBxcHF19WEp+NGo/ErvbxTfSYOe0OzFfgSamRzJxx/zz
 MA+2EVn+XtHjl/w6k0+WshJcfscRxFQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-0jH-_kPrNqyhj70k9ItAuw-1; Fri,
 08 Nov 2024 05:43:22 -0500
X-MC-Unique: 0jH-_kPrNqyhj70k9ItAuw-1
X-Mimecast-MFC-AGG-ID: 0jH-_kPrNqyhj70k9ItAuw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 34EE11955DC4; Fri,  8 Nov 2024 10:43:21 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.118])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D5BD1953885; Fri,  8 Nov 2024 10:43:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PULL 01/10] scripts/checkpatch.pl: Ignore ObjC #import lines for
 operator spacing
Date: Fri,  8 Nov 2024 11:43:01 +0100
Message-ID: <20241108104312.534448-2-thuth@redhat.com>
In-Reply-To: <20241108104312.534448-1-thuth@redhat.com>
References: <20241108104312.534448-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

From: Phil Dennis-Jordan <phil@philjordan.eu>

checkpatch.pl lints for spaces around operators including / (slash).
Code lines starting with #include are ignored, as slashes in those
represent path separators.

In Objective-C code, #import is often used in preference to #include,
as preprocessor-based multiple-#include defenses are considered
non-idiomatic in that language.

This change extends checkpatch.pl to treat #import lines in the same
way as #include, avoiding false positives for "missing" spaces
around path separators on those lines.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Message-ID: <20241024123555.25861-1-phil@philjordan.eu>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1b21249c91..06d07e6c22 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2246,7 +2246,7 @@ sub process {
 			}
 		}
 # Check operator spacing.
-		if (!($line=~/\#\s*include/)) {
+		if (!($line=~/\#\s*(include|import)/)) {
 			my $ops = qr{
 				<<=|>>=|<=|>=|==|!=|
 				\+=|-=|\*=|\/=|%=|\^=|\|=|&=|
-- 
2.47.0


