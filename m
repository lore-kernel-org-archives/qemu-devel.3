Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78496CA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrin-0001ND-MN; Wed, 30 Sep 2026 06:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrii-0001JA-HV
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrie-0006jj-NA
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d1aw4n5wQ2Xh5HvenlAQuEzx8Tb9XtdaynrcfjrBslU=;
 b=FNiNz7du9bA+ix2TFD0vmAGEfBUromkg10opPVJKxBpFyc1c5HpNWgdwHclUt+D7F2eANR
 YYAgOJgFLrDmlkBd0gzQ5AMCmL0odpDGFfpaQITrV+gU23Cg4U/hZEgK4Zny1EQrn+Lmvt
 m3maw4luZca3pgB83YbMvDU8m3rJVDI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-94-m4NxnnycOp6fGUUxTbgzlA-1; Wed,
 30 Sep 2026 06:39:20 -0400
X-MC-Unique: m4NxnnycOp6fGUUxTbgzlA-1
X-Mimecast-MFC-AGG-ID: m4NxnnycOp6fGUUxTbgzlA_1790764759
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0BC91955F7A; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46791773; Wed, 30 Sep 2026 10:39:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E3FD21E68A6; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 033/105] qapi: convert trivial intro sections for crypto.json
Date: Wed, 30 Sep 2026 12:37:58 +0200
Message-ID: <20260930103910.3934848-34-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260831201945.287730-34-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Straightforward semantic conflict with commit bbd049411f
(qapi/crypto: Add ECDSA algorithm and curve id) resolved]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/crypto.json | 106 +++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 68 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index cae2c678cb..f8ff87ec0e 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -26,8 +26,7 @@
 
 ##
 # @QCryptoSecretFormat:
-#
-# The data format that the secret is provided in
+#     The data format that the secret is provided in
 #
 # @raw: raw bytes.  When encoded in JSON only valid UTF-8 sequences
 #     can be used
@@ -41,8 +40,7 @@
 
 ##
 # @QCryptoHashAlgo:
-#
-# The supported algorithms for computing content digests
+#     The supported algorithms for computing content digests
 #
 # @md5: MD5.  Should not be used in any new code, legacy compat only
 #
@@ -68,8 +66,7 @@
 
 ##
 # @QCryptoCipherAlgo:
-#
-# The supported algorithms for content encryption ciphers
+#     The supported algorithms for content encryption ciphers
 #
 # @aes-128: AES with 128 bit / 16 byte keys
 #
@@ -110,8 +107,7 @@
 
 ##
 # @QCryptoCipherMode:
-#
-# The supported modes for content encryption ciphers
+#     The supported modes for content encryption ciphers
 #
 # @ecb: Electronic Code Book
 #
@@ -150,8 +146,7 @@
 
 ##
 # @QCryptoBlockFormat:
-#
-# The supported full disk encryption formats
+#     The supported full disk encryption formats
 #
 # @qcow: QCow/QCow2 built-in AES-CBC encryption.  Use only for
 #     liberating data from old images.
@@ -165,8 +160,8 @@
 
 ##
 # @QCryptoBlockOptionsBase:
-#
-# The common options that apply to all full disk encryption formats
+#     The common options that apply to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -177,8 +172,7 @@
 
 ##
 # @QCryptoBlockOptionsQCow:
-#
-# The options that apply to QCow/QCow2 AES-CBC encryption format
+#     The options that apply to QCow/QCow2 AES-CBC encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -191,8 +185,7 @@
 
 ##
 # @QCryptoBlockOptionsLUKS:
-#
-# The options that apply to LUKS encryption format
+#     The options that apply to LUKS encryption format
 #
 # @key-secret: the ID of a QCryptoSecret object providing the
 #     decryption key.  Mandatory except when probing image for
@@ -205,8 +198,7 @@
 
 ##
 # @QCryptoBlockCreateOptionsLUKS:
-#
-# The options that apply to LUKS encryption format initialization
+#     The options that apply to LUKS encryption format initialization
 #
 # @cipher-alg: the cipher algorithm for data encryption.  Currently
 #     defaults to 'aes-256'.
@@ -239,9 +231,8 @@
 
 ##
 # @QCryptoBlockOpenOptions:
-#
-# The options that are available for all encryption formats when
-# opening an existing volume
+#     The options that are available for all encryption formats when
+#     opening an existing volume
 #
 # Since: 2.6
 ##
@@ -253,9 +244,8 @@
 
 ##
 # @QCryptoBlockCreateOptions:
-#
-# The options that are available for all encryption formats when
-# initializing a new volume
+#     The options that are available for all encryption formats when
+#     initializing a new volume
 #
 # Since: 2.6
 ##
@@ -267,9 +257,8 @@
 
 ##
 # @QCryptoBlockInfoBase:
-#
-# The common information that applies to all full disk encryption
-# formats
+#     The common information that applies to all full disk encryption
+#     formats
 #
 # @format: the encryption format
 #
@@ -280,8 +269,7 @@
 
 ##
 # @QCryptoBlockInfoLUKSSlot:
-#
-# Information about the LUKS block encryption key slot options
+#     Information about the LUKS block encryption key slot options
 #
 # @active: whether the key slot is currently in use
 #
@@ -301,8 +289,7 @@
 
 ##
 # @QCryptoBlockInfoLUKS:
-#
-# Information about the LUKS block encryption options
+#     Information about the LUKS block encryption options
 #
 # @cipher-alg: the cipher algorithm for data encryption
 #
@@ -340,8 +327,7 @@
 
 ##
 # @QCryptoBlockInfo:
-#
-# Information about the block encryption options
+#     Information about the block encryption options
 #
 # Since: 2.7
 ##
@@ -352,8 +338,7 @@
 
 ##
 # @QCryptoBlockLUKSKeyslotState:
-#
-# Defines state of keyslots that are affected by the update
+#     Defines state of keyslots that are affected by the update
 #
 # @active: The slots contain the given password and marked as active
 #
@@ -367,9 +352,8 @@
 
 ##
 # @QCryptoBlockAmendOptionsLUKS:
-#
-# This struct defines the update parameters that activate/de-activate
-# set of keyslots
+#     This struct defines the update parameters that
+#     activate/de-activate set of keyslots
 #
 # @state: the desired state of the keyslots
 #
@@ -409,9 +393,8 @@
 
 ##
 # @QCryptoBlockAmendOptions:
-#
-# The options that are available for all encryption formats when
-# amending encryption settings
+#     The options that are available for all encryption formats when
+#     amending encryption settings
 #
 # Since: 5.1
 ##
@@ -423,8 +406,7 @@
 
 ##
 # @SecretCommonProperties:
-#
-# Properties for objects of classes derived from secret-common.
+#     Properties for objects of classes derived from secret-common.
 #
 # @format: the data format that the secret is provided in
 #     (default: raw)
@@ -465,8 +447,7 @@
 
 ##
 # @SecretKeyringProperties:
-#
-# Properties for secret_keyring objects.
+#     Properties for secret_keyring objects.
 #
 # @serial: serial number that identifies a key to get from the kernel
 #
@@ -479,8 +460,7 @@
 
 ##
 # @TlsCredsProperties:
-#
-# Properties for objects of classes derived from tls-creds.
+#     Properties for objects of classes derived from tls-creds.
 #
 # @verify-peer: if true the peer credentials will be verified once the
 #     handshake is completed.  This is a no-op for anonymous
@@ -505,8 +485,7 @@
 
 ##
 # @TlsCredsAnonProperties:
-#
-# Properties for tls-creds-anon objects.
+#     Properties for tls-creds-anon objects.
 #
 # Since: 2.5
 ##
@@ -516,8 +495,7 @@
 
 ##
 # @TlsCredsPskProperties:
-#
-# Properties for tls-creds-psk objects.
+#     Properties for tls-creds-psk objects.
 #
 # @username: the username which will be sent to the server.  For
 #     clients only.  If absent, "qemu" is sent and the property will
@@ -531,8 +509,7 @@
 
 ##
 # @TlsCredsX509Properties:
-#
-# Properties for tls-creds-x509 objects.
+#     Properties for tls-creds-x509 objects.
 #
 # @sanity-check: if true, perform some sanity checks before using the
 #     credentials (default: true)
@@ -552,8 +529,7 @@
 
 ##
 # @QCryptoAkCipherAlgo:
-#
-# The supported algorithms for asymmetric encryption ciphers
+#     The supported algorithms for asymmetric encryption ciphers
 #
 # @rsa: RSA algorithm
 #
@@ -566,8 +542,7 @@
 
 ##
 # @QCryptoCurveID:
-#
-# The supported elliptic curves.
+#     The supported elliptic curves.
 #
 # @prime256v1: NIST P-256 curve (prime256v1)
 #
@@ -580,8 +555,7 @@
 
 ##
 # @QCryptoAkCipherKeyType:
-#
-# The type of asymmetric keys.
+#     The type of asymmetric keys.
 #
 # @public: public key
 #
@@ -594,8 +568,7 @@
 
 ##
 # @QCryptoRSAPaddingAlgo:
-#
-# The padding algorithm for RSA.
+#     The padding algorithm for RSA.
 #
 # @raw: no padding used
 #
@@ -608,8 +581,7 @@
 
 ##
 # @QCryptoAkCipherOptionsRSA:
-#
-# Specific parameters for RSA algorithm.
+#     Specific parameters for RSA algorithm.
 #
 # @hash-alg: `QCryptoHashAlgo`
 #
@@ -623,8 +595,7 @@
 
 ##
 # @QCryptoAkCipherOptionsECDSA:
-#
-# Specific parameters for the ECDSA algorithm.
+#     Specific parameters for the ECDSA algorithm.
 #
 # @curve-id: the elliptic curve to use
 #
@@ -635,9 +606,8 @@
 
 ##
 # @QCryptoAkCipherOptions:
-#
-# The options that are available for all asymmetric key algorithms
-# when creating a new QCryptoAkCipher.
+#     The options that are available for all asymmetric key algorithms
+#     when creating a new QCryptoAkCipher.
 #
 # @alg: encryption cipher algorithm
 #
-- 
2.55.0


