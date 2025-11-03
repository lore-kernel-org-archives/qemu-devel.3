Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A561ECCF9FE
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 13:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFum9-0005h0-Ap; Mon, 03 Nov 2025 08:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFum2-0005gL-Sj
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vFult-0004QK-QY
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 08:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762177132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rhniv0q17E9S24xaQWsNgYNGFr1qYwCkCI1iwOyc7+s=;
 b=FvvB5jETlDRjYXoyoMBXVKBnAqSa5+9HQ+PosG6Rc1iopZfjNAaEXtVcBSRzterWOwqvrB
 yJOQJc9kVIyqqdWWQid3IfTovlTcgptJumzXJvGdVnsf6M1fcAwMrb2ofSKJuCyuBiHQt6
 L/0GGF/4AiVc+skPPgvPRd8iOQIDpws=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-159-uWgiS8D4OsiPi8FiNmDPHA-1; Mon,
 03 Nov 2025 08:38:49 -0500
X-MC-Unique: uWgiS8D4OsiPi8FiNmDPHA-1
X-Mimecast-MFC-AGG-ID: uWgiS8D4OsiPi8FiNmDPHA_1762177128
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F04E195608D; Mon,  3 Nov 2025 13:38:48 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.202])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1909A1800576; Mon,  3 Nov 2025 13:38:42 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org, Laurent Vivier <lvivier@redhat.com>
Subject: [PULL 09/32] crypto: bump min libgcrypt to 1.9.4
Date: Mon,  3 Nov 2025 13:37:03 +0000
Message-ID: <20251103133727.423041-10-berrange@redhat.com>
In-Reply-To: <20251103133727.423041-1-berrange@redhat.com>
References: <20251103133727.423041-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

                 RHEL-9: 1.10.0
              Debian 13: 1.11.0
       openSUSE Leap 15: 1.10.3
       Ubuntu LTS 22.04: 1.9.4
                FreeBSD: 1.11.2
              Fedora 42: 1.11.1
                OpenBSD: 1.11.2
         macOS HomeBrew: 1.11.2

Ubuntu 22.04 is our oldest constraint at this time.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


