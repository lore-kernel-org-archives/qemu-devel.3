Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30E8CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr6N-00057B-5F; Fri, 31 Oct 2025 11:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr63-00050x-5q
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5v-0001jP-TB
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cR4x05WPwAVhawGwIdsuecwnBrXA3X1lJbtLTXJTbOo=;
 b=Fd+AwWW5A6V0xdgyec1OPOBUCSFx7MQZ27FFa2APw6Sy7nckS6zQpLF7G9DnyTPWdXbAxP
 sFQNh03C+DODC4DlWQmqrlwxgIZE16Wd5gYihIhz24Tc7BruZcZsH93gpl7gHTnH6XJxY4
 A0J3Y5zEhwKak0N1+mMToW6ovxVd2YY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-pJHYMRjJOy2d-QdjL32F9g-1; Fri,
 31 Oct 2025 11:31:07 -0400
X-MC-Unique: pJHYMRjJOy2d-QdjL32F9g-1
X-Mimecast-MFC-AGG-ID: pJHYMRjJOy2d-QdjL32F9g_1761924667
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B30B1956094; Fri, 31 Oct 2025 15:31:07 +0000 (UTC)
Received: from toolbx.lcy.redhat.com (dhcp-17-192.lcy.redhat.com
 [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 47AE019560A2; Fri, 31 Oct 2025 15:31:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 4/5] crypto: bump min nettle to 3.7.3
Date: Fri, 31 Oct 2025 15:30:55 +0000
Message-ID: <20251031153056.296078-5-berrange@redhat.com>
In-Reply-To: <20251031153056.296078-1-berrange@redhat.com>
References: <20251031153056.296078-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Per repology, current shipping versions are:

                 RHEL-9: 3.10.1
              Debian 13: 3.10.1
       openSUSE Leap 15: 3.9.1
       Ubuntu LTS 22.04: 3.7.3
                FreeBSD: 3.10.2
              Fedora 42: 3.10.2
                OpenBSD: 3.10.2
         macOS HomeBrew: 3.10.2

Ubuntu 22.04 is our oldest constraint at this time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ab1ff373e6..ad0aa6ccc0 100644
--- a/meson.build
+++ b/meson.build
@@ -1869,7 +1869,7 @@ if not gnutls.found()
     crypto_sm3 = gcrypt
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
-    nettle = dependency('nettle', version: '>=3.4',
+    nettle = dependency('nettle', version: '>=3.7.3',
                         method: 'pkg-config',
                         required: get_option('nettle'))
     if nettle.found() and not cc.has_header('nettle/xts.h', dependencies: nettle)
-- 
2.51.1


