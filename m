Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D3CC44501
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:26:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBEs-0001sz-14; Fri, 10 Jul 2026 09:25:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wiBEm-0001sm-GL
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:25:53 -0400
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com
 ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1wiBEj-0001jQ-7u
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:25:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3pM+/QgilCFMV4lWG+ABRRJeTf6V0S/CRQvOEQIxff1/lNnfOmkx8TMMwdf5AKqpmo5tweNbu9YbiqBsF9xNZaOA/A7zSkNrBi8wB/g/ZFBTADX4Yb3mLi/JLXgeonj3EI77IVcRNnVlis/QQ4Px/VsOksViGpIongAPy1CZghLfY+U8u1RT4irLy5gIEIcX/I+Y7N4ezderA18sHtn+dOxMMRbGjhHb8pXjxKECLWA0v1g4NSG8m4fd+2pW7O6Hwuv2aGlJaSPFXzaP8Ci93IOOpNnvFFVL/w1y7BXtAhChDnbsOeyhDIXlrnDSQhb1pQmIHKCiG4tajV93/7zSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nUwEqme/VvA+mecJgjOOTZqOFdxMB1OAf9bPAMtBr4=;
 b=SmQb27ucGmNt81V/me+ROJRBQ/z0JY5gO9LQUStDa0qmrkMktmY4FXS0uqOdyznotGlVEMMsAWtMZcNbQb6WRaZZAWOJKLCziih2dTpQiS91/gLUknrdf3MDTkA+RcZrgmvc7hbx//up5mCdaRN7E9SVZFBpIFGd7jCooiivtr0IociU4GYEcy+UnL7VDQM6drzMFvuMLYLSfDZcIg40mo/vBxHjUxvej0ITZiHV3I8QQEt0qIGCb8qwUCrDHrIEaymHpxk97oLAYLOan69QMlMCVkHAQKfKlNtA4A4bh+ycQRa0hVE2iq3fu33X/9mNDnSIUFUjAyX77sZW22Tnmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nUwEqme/VvA+mecJgjOOTZqOFdxMB1OAf9bPAMtBr4=;
 b=4EeyYHrta7Ihgdj1RHfOEHLSiVUSNgkIaevbpIWVNTPCPhARTnK4CkDTQImtQGAgkIn4pT+VDB6zxdphGBBWpFCtvXhvAIO80GXP+ORTSXuxoCJSDIlyWbQfkc5V0gvQq6elM6zjghcXBZ6JgwXon6fVNSizofKeel01f5fHsWY=
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by DM6PR12MB4249.namprd12.prod.outlook.com (2603:10b6:5:223::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Fri, 10 Jul
 2026 13:25:42 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::5f) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend Transport; Fri, 10
 Jul 2026 13:25:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 13:25:40 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 08:25:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 06:25:39 -0700
Received: from XFR-LUMICHEL-L2.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via
 Frontend Transport; Fri, 10 Jul 2026 08:25:38 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>, "Pierrick
 Bouvier" <pierrick.bouvier@oss.qualcomm.com>, Francisco Iglesias
 <francisco.iglesias@amd.com>, Frederic Konrad <frederic.konrad@amd.com>
Subject: [PATCH v2] meson.build: re-add explicit gcrypt/nettle request check
Date: Fri, 10 Jul 2026 15:25:30 +0200
Message-ID: <20260710132531.97844-1-luc.michel@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|DM6PR12MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d9774e2-f2f9-48d8-2c47-08dede86bcf9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 8uQK6IyIyKjaOEXZjXZRTeEU/HVQMSvIPzAXSgngeaULj0hGVHmdMsMfnJHvYlmByy6AqmuGlBw8j7rTmZS7Mexqd+ifggn9NbyTbmGPjNnK/WYzvTdtJQVB7L9zYEa99yz2mbRd5XHp7WauQlU8jvdRIUMMbJ8Nx2rpLKG6dSSY2aWn7L6mu0pD7+FsVkMlE/8ZYz6FrsgZ09SrQvJ0lQ3uChRegcKNuHVD2nsrr4peouyQPbjaU029TZ6XfcFEBm+7pa/bSgoQS/ApCZC4gOFdDPIkqFZ27B0gHAfEmKNiynaEZ+Qw0CJZQOOowA79chVOlnKxPxjDCDJduWBZDWvqXgVRZLXluJ1JuP1mk2BWSrFD/2uaXH1o6TFbkTqZM7KTfGfkDSyq0VFAqcg8+PS8jeMKw7zCmejKEFIFPWT7mLfHrUSgUJfPjynYCVKOwTInAeMspN8WRBzD+Ynjl/bxpJIK09K8dE5Rf3vsN8Qmu1uOs52xIwm5UbkrY2zzZEQ3PRBy5ObxGnMYlXJc0DvwutrDihHxaI4Jxxtm11FXg8hT2psFWVwFLAv/rNGeRov6n/7R87t5pPUfCthmy0lgTXur8LLDSnAcp8lU/wumT/0Pk/oi8Dj1MS8N8gio/1LnqBiJFIctSRdYu211v0RtQbWkt1sFxg0dNpWq0Q9ShIIRdFexAQDIJPQSxXS/EXJzTW1HhZatJBnhAaDhMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aan9NjBnq9vYeMNb/VEvZEUfvYEtkxtgCSe0R7C7yg6EYvkhizFgBTykJHZc1WACmQqmx1OEHqtQQfJ9peogFmjo62xXfG3z6g5Xxw7Orufe+fnRIKfwlACVzZ+j3XG1sD7Zm+FIFF6pGqlzFp4yNUkVsJs2BXJXrdfmb6RtFTd2C6dF1p4i/RgpzPJ0DudzJPfMODhidy767cLqQmHWjh/sMjWJ1T66afl6mgxYUFPH6Sl5nyMNck5AlX5ZMr7uY6xYXHsR+UoIPvCj5gsdU/4JoRhXFseJcySpVJybygFOh5/zgEuSG8lzZ8MgD+4+tzEyuac7J4UvXYYBjdAdGX+KFVq8yNkwqCdP2nxKpMM3enCMuAB5XUrOqrZWuuK1IfTzIJ0HUNZSA4pgavpH33NRQ2Z7/jSVrjJSd3DO5Rd0VDaZLzvDjUKjjfomVHP1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 13:25:40.9287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d9774e2-f2f9-48d8-2c47-08dede86bcf9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
Received-SPF: permerror client-ip=2a01:111:f403:c100::f;
 envelope-from=Luc.Michel@amd.com;
 helo=BL2PR02CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

c4b3d0074 removed the check that nettle or gcrypt were explicitly
requested as the crypto library to use, breaking the --enable-nettle and
--enable-gcrypt options. Re-add the logic to force usage of nettle or
gcrypt for crypto operations, while still keeping gnutls for TLS.

Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
Signed-off-by: Luc Michel <luc.michel@amd.com>
---
v2:
   - Revert more of c4b3d0074 to restore the gnutls_crypto logic to
     disable gnutls only for crypto ops but keep it for TLS [Daniel]
---
 meson.build                    | 11 ++++++++++-
 crypto/cipher.c                |  2 +-
 tests/unit/test-crypto-block.c |  3 ++-
 crypto/meson.build             |  2 +-
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 164328ded83..06c43b43581 100644
--- a/meson.build
+++ b/meson.build
@@ -1781,15 +1781,17 @@ if not get_option('libcbor').auto() or have_system
   libcbor = dependency('libcbor', version: '>=0.7.0',
                        required: get_option('libcbor'))
 endif
 
 gnutls = not_found
+gnutls_crypto = not_found
 gnutls_bug1717_workaround = false
 if get_option('gnutls').enabled() or (get_option('gnutls').auto() and have_system)
   gnutls = dependency('gnutls', version: '>=3.7.5',
                       method: 'pkg-config',
                       required: get_option('gnutls'))
+  gnutls_crypto = gnutls
 
   #if gnutls.found() and not get_option('gnutls-bug1717-workaround').disabled()
     # XXX: when bug 1717 is resolved, add logic to probe for
     # the GNUTLS fixed version number to handle the 'auto' case
   #  gnutls_bug1717_workaround = true
@@ -1809,11 +1811,16 @@ crypto_sm3 = not_found
 
 if get_option('nettle').enabled() and get_option('gcrypt').enabled()
   error('Only one of gcrypt & nettle can be enabled')
 endif
 
-if not gnutls.found()
+# Explicit nettle/gcrypt request, so ignore gnutls for crypto
+if get_option('nettle').enabled() or get_option('gcrypt').enabled()
+  gnutls_crypto = not_found
+endif
+
+if not gnutls_crypto.found()
   if (not get_option('gcrypt').auto() or have_system) and not get_option('nettle').enabled()
     gcrypt = dependency('libgcrypt', version: '>=1.9.4',
                         required: get_option('gcrypt'))
     # Debian has removed -lgpg-error from libgcrypt-config
     # as it "spreads unnecessary dependencies" which in
@@ -2511,10 +2518,11 @@ config_host_data.set('CONFIG_VIRTFS', have_virtfs)
 config_host_data.set('CONFIG_VTE', vte.found())
 config_host_data.set('CONFIG_XKBCOMMON', xkbcommon.found())
 config_host_data.set('CONFIG_KEYUTILS', keyutils.found())
 config_host_data.set('CONFIG_GETTID', has_gettid)
 config_host_data.set('CONFIG_GNUTLS', gnutls.found())
+config_host_data.set('CONFIG_GNUTLS_CRYPTO', gnutls_crypto.found())
 config_host_data.set('CONFIG_GNUTLS_BUG1717_WORKAROUND', gnutls_bug1717_workaround)
 config_host_data.set('CONFIG_TASN1', tasn1.found())
 config_host_data.set('CONFIG_GCRYPT', gcrypt.found())
 config_host_data.set('CONFIG_NETTLE', nettle.found())
 config_host_data.set('CONFIG_CRYPTO_SM4', crypto_sm4.found())
@@ -4863,10 +4871,11 @@ summary(summary_info, bool_yn: true, section: 'Block layer support')
 # Crypto
 summary_info = {}
 summary_info += {'TLS priority':      get_option('tls_priority')}
 summary_info += {'GNUTLS support':    gnutls}
 if gnutls.found()
+  summary_info += {'  GNUTLS crypto':   gnutls_crypto.found()}
   summary_info += {'  GNUTLS bug 1717 workaround': gnutls_bug1717_workaround }
 endif
 summary_info += {'libgcrypt':         gcrypt}
 summary_info += {'nettle':            nettle}
 summary_info += {'SM4 ALG support':   crypto_sm4}
diff --git a/crypto/cipher.c b/crypto/cipher.c
index 515165e0dc0..229710f76b4 100644
--- a/crypto/cipher.c
+++ b/crypto/cipher.c
@@ -140,11 +140,11 @@ qcrypto_cipher_validate_key_length(QCryptoCipherAlgo alg,
 
 #ifdef CONFIG_GCRYPT
 #include "cipher-gcrypt.c.inc"
 #elif defined CONFIG_NETTLE
 #include "cipher-nettle.c.inc"
-#elif defined CONFIG_GNUTLS
+#elif defined CONFIG_GNUTLS_CRYPTO
 #include "cipher-gnutls.c.inc"
 #else
 #include "cipher-stub.c.inc"
 #endif
 
diff --git a/tests/unit/test-crypto-block.c b/tests/unit/test-crypto-block.c
index 218e585f988..3ac7f17b2a0 100644
--- a/tests/unit/test-crypto-block.c
+++ b/tests/unit/test-crypto-block.c
@@ -29,11 +29,12 @@
 #ifndef _WIN32
 #include <sys/resource.h>
 #endif
 
 #if (defined(_WIN32) || defined RUSAGE_THREAD) && \
-    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT))
+    (defined(CONFIG_NETTLE) || defined(CONFIG_GCRYPT) || \
+     defined(CONFIG_GNUTLS_CRYPTO))
 #define TEST_LUKS
 #else
 #undef TEST_LUKS
 #endif
 
diff --git a/crypto/meson.build b/crypto/meson.build
index b51597a8792..6ac83857aaa 100644
--- a/crypto/meson.build
+++ b/crypto/meson.build
@@ -36,11 +36,11 @@ if nettle.found()
   if hogweed.found()
     crypto_ss.add(gmp, hogweed)
   endif
 elif gcrypt.found()
   crypto_ss.add(gcrypt, files('hash-gcrypt.c', 'hmac-gcrypt.c', 'pbkdf-gcrypt.c'))
-elif gnutls.found()
+elif gnutls_crypto.found()
   crypto_ss.add(gnutls, files('hash-gnutls.c', 'hmac-gnutls.c', 'pbkdf-gnutls.c'))
 else
   crypto_ss.add(files('hash-glib.c', 'hmac-glib.c', 'pbkdf-stub.c'))
 endif
 
-- 
2.53.0


