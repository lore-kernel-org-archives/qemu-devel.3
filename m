Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B785ACCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 15:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEr6H-00054l-1A; Fri, 31 Oct 2025 11:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5x-0004vV-Al
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEr5o-0001i0-9h
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 11:31:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761924664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YussPNtO8ZUhnG6uL8x+91ilyd8r+sNcvOI7j4FiXPg=;
 b=h6f6w3kh6GSK3s5dRlDQnik1qRzfrcC8EECsdex0qJkE1hxUBF6/Mws8BJ8439MP++6vsk
 1RB2MDllem/SFuo1pGAhVpXsXTd+ojSOm1V/mWTWmk419nOi36qunNzKMIIy7K+1wTNMf6
 E1vK4Gm6bIj52oU+zBTM9tl2HRiFEsw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-ebm9hZ33Ow6y2Bk9huNojQ-1; Fri,
 31 Oct 2025 11:31:02 -0400
X-MC-Unique: ebm9hZ33Ow6y2Bk9huNojQ-1
X-Mimecast-MFC-AGG-ID: ebm9hZ33Ow6y2Bk9huNojQ_1761924661
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20418195605C; Fri, 31 Oct 2025 15:31:01 +0000 (UTC)
Received: from toolbx.lcy.redhat.com (dhcp-17-192.lcy.redhat.com
 [10.42.17.192])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A81F319560A2; Fri, 31 Oct 2025 15:30:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/5] crypto: bump min gnutls to 3.7.5
Date: Fri, 31 Oct 2025 15:30:52 +0000
Message-ID: <20251031153056.296078-2-berrange@redhat.com>
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
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Per repology, current shipping versions are:

                 RHEL-9: 3.8.3
              Debian 13: 3.8.9
       openSUSE Leap 15: 3.8.3
       Ubuntu LTS 22.04: 3.7.5
                FreeBSD: 3.8.10
              Fedora 42: 3.8.10
                OpenBSD: 3.8.10
         macOS HomeBrew: 3.8.10

Ubuntu 22.04 is our oldest constraint at this time.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/cipher.c                |  2 +-
 crypto/meson.build             |  2 +-
 meson.build                    | 37 ++++------------------------------
 tests/unit/test-crypto-block.c |  3 +--
 4 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/crypto/cipher.c b/crypto/cipher.c
index 229710f76b..515165e0dc 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -142,7 +142,7 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo alg,
 #include "cipher-gcrypt.c.inc"
 #elif defined CONFIG_NETTLE
 #include "cipher-nettle.c.inc"
-#elif defined CONFIG_GNUTLS_CRYPTO
+#elif defined CONFIG_GNUTLS
 #include "cipher-gnutls.c.inc"
 #else
 #include "cipher-stub.c.inc"
diff --git a/crypto/meson.build b/crypto/meson.build
index 735635de1f..dd61ed9174 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -38,7 +38,7 @@ if nettle.found()
   endif
 elif gcrypt.found()
   crypto_ss.add(gcrypt, files('hash-gcrypt.c', 'hmac-gcrypt.c', 'pbkdf-gcrypt.c'))
-elif gnutls_crypto.found()
+elif gnutls.found()
   crypto_ss.add(gnutls, files('hash-gnutls.c', 'hmac-gnutls.c', 'pbkdf-gnutls.c'))
 else
   crypto_ss.add(files('hash-glib.c', 'hmac-glib.c', 'pbkdf-stub.c'))
diff --git a/meson.build b/meson.build
index df876c72f0..b67e14f630 100644
--- a/meson.build
+++ b/meson.build
@@ -1823,33 +1823,11 @@ if not get_option('libcbor').auto() or have_system
 endif
 
 gnutls = not_found
-gnutls_crypto = not_found
 gnutls_bug1717_workaround = false
 if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_system)
-  # For general TLS support our min gnutls matches
-  # that implied by our platform support matrix
-  #
-  # For the crypto backends, we look for a newer
-  # gnutls:
-  #
-  #   Version 3.6.8  is needed to get XTS
-  #   Version 3.6.13 is needed to get PBKDF
-  #   Version 3.6.14 is needed to get HW accelerated XTS
-  #
-  # If newer enough gnutls isn't available, we can
-  # still use a different crypto backend to satisfy
-  # the platform support requirements
-  gnutls_crypto = dependency('gnutls', version: '>=3.6.14',
-                             method: 'pkg-config',
-                             required: false)
-  if gnutls_crypto.found()
-    gnutls = gnutls_crypto
-  else
-    # Our min version if all we need is TLS
-    gnutls = dependency('gnutls', version: '>=3.5.18',
-                        method: 'pkg-config',
-                        required: get_option('gnutls'))
-  endif
+  gnutls = dependency('gnutls', version: '>=3.7.5',
+                      method: 'pkg-config',
+                      required: get_option('gnutls'))
 
   #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
     # XXX: when bug 1717 is resolved, add logic to probe for
@@ -1874,12 +1852,7 @@ if get_option('nettle').enabled() and get_option('gcrypt').enabled()
   error('Only one of gcrypt & nettle can be enabled')
 endif
 
-# Explicit nettle/gcrypt request, so ignore gnutls for crypto
-if get_option('nettle').enabled() or get_option('gcrypt').enabled()
-  gnutls_crypto = not_found
-endif
-
-if not gnutls_crypto.found()
+if not gnutls.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.8',
                         required: get_option('gcrypt'))
@@ -2606,7 +2579,6 @@ config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_GNUTLS', gnutls.found())
-config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
 config_host_data.set('CONFIG_GNUTLS_BUG1717_WORKAROUND', gnutls_bug1717_workaround)
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
@@ -4906,7 +4878,6 @@ summary_info = {}
 summary_info += {'TLS priority':      get_option('tls_priority')}
 summary_info += {'GNUTLS support':    gnutls}
 if gnutls.found()
-  summary_info += {'  GNUTLS crypto':   gnutls_crypto.found()}
   summary_info += {'  GNUTLS bug 1717 workaround': gnutls_bug1717_workaround }
 endif
 summary_info += {'libgcrypt':         gcrypt}
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 3ac7f17b2a..218e585f98 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -31,8 +31,7 @@
 #endif
 
 #if (defined(_WIN32) || defined RUSAGE_THREAD) && \
-    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT) || \
-     defined(CONFIG_GNUTLS_CRYPTO))
+    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
-- 
2.51.1


