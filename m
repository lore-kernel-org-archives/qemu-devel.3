Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A740C25B77
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 12:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7wf3-0004xl-NX; Fri, 17 May 2024 08:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wez-0004rc-8u
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s7wex-0006Gu-Sw
 for qemu-devel@nongnu.org; Fri, 17 May 2024 08:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715948763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9fqBm4xPOtPk/y269nox0D6RplzlnU3rP1d08/jfSQE=;
 b=KYnFVcOvnUkLQngsTqapXkvyO5exQgzq5a3CPchmQhurHhklsKBXP9QNgUYKjDDLuCZKzG
 yC+EFD3hO2cJwhUPK4rN63uS4I0FOBoESWU8ZM3Ec2tRq9AoHi8lriL2zkb/QkY/2jk/Ta
 3WUDTRPx+NM7rj8UNqXNE98FWjxp/bo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-SdGc5MUGOUKtttxp3dCQAg-1; Fri,
 17 May 2024 08:25:57 -0400
X-MC-Unique: SdGc5MUGOUKtttxp3dCQAg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DCE6B1C0513D;
 Fri, 17 May 2024 12:25:56 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.132])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 459AE1050173;
 Fri, 17 May 2024 12:25:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 2/6] tests/lcitool: Remove 'xfsprogs' from QEMU
Date: Fri, 17 May 2024 14:25:48 +0200
Message-ID: <20240517122552.584215-3-thuth@redhat.com>
In-Reply-To: <20240517122552.584215-1-thuth@redhat.com>
References: <20240517122552.584215-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.996,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

QEMU's commit a5730b8bd3 ("block/file-posix: Simplify the
XFS_IOC_DIOINFO handling") removed the need for the 'xfsprogs'
package.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[thuth: Adjusted the patch from the lcitools repo to QEMU's repo]
Message-ID: <20240516084059.511463-3-thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/lcitool/projects/qemu.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 149b15de57..9173d1e36e 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -121,7 +121,6 @@ packages:
  - vte
  - which
  - xen
- - xfsprogs
  - xorriso
  - zstdtools
  - zlib
-- 
2.45.0


