Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1E4CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr6I-00054t-Or; Fri, 31 Oct 2025 11:31:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr64-00051P-R7
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5u-0001jX-7e
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GPB47mRIRrYyRFaATCNngcDhuQU4g7StGx5+h9qlZA0=;
 b=V8TZhPMov8ob7ZE5EzKPolSMRs+H1zVzu6iVsGtAG7ykY2S3tJn43WDClGXUdh9p9rmzE6
 wPuBNQ8QY6spwycqPw/40sqbnxJr7A8XQxls71i1m1ogQ9TPLnPPVkvdvNTly4QFhQk+tG
 nbFRTqYT3DaF8nACMRUc6HXA/FUfM1U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-120-XCF1R2DtNNWzn1Bd-Oi5yA-1; Fri,
 31 Oct 2025 11:31:05 -0400
X-MC-Unique: XCF1R2DtNNWzn1Bd-Oi5yA-1
X-Mimecast-MFC-AGG-ID: XCF1R2DtNNWzn1Bd-Oi5yA_1761924665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0230C19560AE; Fri, 31 Oct 2025 15:31:05 +0000 (UTC)
Received: from toolbx.lcy.redhat.com (dhcp-17-192.lcy.redhat.com
 [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5CCC619560A2; Fri, 31 Oct 2025 15:31:03 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 3/5] crypto: bump min libgcrypt to 1.9.4
Date: Fri, 31 Oct 2025 15:30:54 +0000
Message-ID: <20251031153056.296078-4-berrange@redhat.com>
In-Reply-To: <20251031153056.296078-1-berrange@redhat.com>
References: <20251031153056.296078-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

                 RHEL-9: 1.10.0
              Debian 13: 1.11.0
       openSUSE Leap 15: 1.10.3
       Ubuntu LTS 22.04: 1.9.4
                FreeBSD: 1.11.2
              Fedora 42: 1.11.1
                OpenBSD: 1.11.2
         macOS HomeBrew: 1.11.2

Ubuntu 22.04 is our oldest constraint at this time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/meson.build b/meson.build
index b67e14f630..ab1ff373e6 100644
--- a/meson.build
+++ b/meson.build
@@ -1854,7 +1854,7 @@ endif
 
 if not gnutls.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
-    gcrypt = dependency('libgcrypt', version: '>=1.8',
+    gcrypt = dependency('libgcrypt', version: '>=1.9.4',
                         required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
@@ -1866,27 +1866,7 @@ if not gnutls.found()
         version: gcrypt.version())
     endif
     crypto_sm4 = gcrypt
-    # SM4 ALG is available in libgcrypt >= 1.9
-    if gcrypt.found() and not cc.links('''
-      #include <gcrypt.h>
-      int main(void) {
-        gcry_cipher_hd_t handler;
-        gcry_cipher_open(&handler, GCRY_CIPHER_SM4, GCRY_CIPHER_MODE_ECB, 0);
-        return 0;
-      }''', dependencies: gcrypt)
-      crypto_sm4 = not_found
-    endif
     crypto_sm3 = gcrypt
-    # SM3 ALG is available in libgcrypt >= 1.9
-    if gcrypt.found() and not cc.links('''
-      #include <gcrypt.h>
-      int main(void) {
-        gcry_md_hd_t handler;
-        gcry_md_open(&handler, GCRY_MD_SM3, 0);
-        return 0;
-      }''', dependencies: gcrypt)
-      crypto_sm3 = not_found
-    endif
   endif
   if (not get_option('nettle').auto() or have_system) and not gcrypt.found()
     nettle = dependency('nettle', version: '>=3.4',
-- 
2.51.1


