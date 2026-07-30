Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD462C55167
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 00:30:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpb8a-0002oL-9E; Thu, 30 Jul 2026 20:30:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <github@me.samiser.xyz>)
 id 1wpZjn-0006sI-CZ; Thu, 30 Jul 2026 19:00:28 -0400
Received: from fhigh-b4-smtp.messagingengine.com ([202.12.124.155])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <github@me.samiser.xyz>)
 id 1wpZjl-00086p-1c; Thu, 30 Jul 2026 19:00:27 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 37F627A00BF;
 Thu, 30 Jul 2026 19:00:22 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
 by phl-compute-01.internal (MEProxy); Thu, 30 Jul 2026 19:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samiser.xyz; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:message-id:mime-version:reply-to
 :subject:subject:to:to; s=fm2; t=1785452422; x=1785538822; bh=iv
 4Oe/AnM0yPB7D4mqPwwlLCYXgJke8vGTKjJD+LGDU=; b=GPhHxFQ9uRuNcoSkMn
 KRmBk3Rj4OokqvVh6QXrff6Uy5psNuGQ3ER+B4Zgax0MBSmPFJvJ6HpD45L6jubS
 OMALIDyfgWqOv0st1SBhzhzLpO5P5ZYoMK4IQdT39TSiB/2iTangv4ddm88WsPp2
 BkHGBajfuEPeNeifEnzUrexLi4m5E9jMp1AIdULcnB0yIq3GqRdxO2hgF13KSrY6
 +XdShZzrrm2Om/939BH//pYIDZ684GMnYjdvSHhJ4gQO7zNqIp2blh49waJ1ChFO
 50GSDGkW3O7N82q3eF5AkBJX7gmCvdmIbQWsk16Xy6qiUwVJGgOrFtUBR/+lZtxn
 jwUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:message-id:mime-version:reply-to:subject
 :subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; t=1785452422; x=1785538822; bh=iv4Oe/AnM0yPB7D4mqPwwlLCYXgJ
 ke8vGTKjJD+LGDU=; b=LDsNIUMFK4gg6uh6QLx0p/Q+x/CyYJy2ME24Yv1SFi3j
 yRuxA9zpJhnidzAP6ndke7TE4yL5YH9GFMZhpb0XeHMOTiVE+eAU4CCPmQgKmXhE
 vQPmQCri11bwEji1cKbq1jMe7gDnlTbvN4Ob6cBB+bRa6DDKO5edS1mpSbVs+w/T
 ASAlJd8JbUNJBQXTI1acdMOqnNE5/I0RAH6ziX6UO8HRSaRGEUXwOJ83+OEvQRTf
 wZDKmHumGmruKzS8dTlNDgk2+OLR/rBM37GBVOSqOX3UG9RGqQoFakV86vWCQh9n
 7wC/HGdB1jUnfOjr7jG4zjGnLzCT16iqNijUKAmgzA==
X-ME-Sender: <xms:hddrasQpPLgWWCharpZ8tssqumb8ihUjzGwywSayjTirrIdpLGHzYA>
 <xme:hddrakm0YtOTEs16BvCAUJEXEfTsxWB4PaYG22_MjGkAEVl-xN9WTGjnmfNy1HFqs
 QZiN9D4EVBWHiogDvEl-uF5Jv9LWG3R7kVyOpx1Kh1cXAILskBq2Txk>
X-ME-Proxy-Cause: dmFkZTEySoZUukO9JNiKHFlFpVcz1T0J3ydTsJc0bYDgl7U6DDAU1kD+v+81pMVIeCUtyK
 I4qUae06yfblVx/jvmB2mFtCyc7G8IEd4s5CahSvVR2hTZbfiLufz+8QSW9FVRAWNPiFjc
 55AqfLTUvlTgDLnY7nwfwXF3N2katalpCG+WpW9sFTtIyU9hEGi/qLEm1COk27J6VTEDgg
 yRz/ufKuGUmRHmm4v5EXEEZur1mY//5RhynYRTw9tjnPoFqBXELKfubUpFJjYViOu6/G3W
 Zma/XTM+dkNlWAwRSM7laDnhxGaHgYGbVGwx+BUrQ0W/CbJWH1gH3UZYL8XGPgyfSlMTqc
 3fRVguKSDdH+w0HjUfylQDldXjsOIUA6kXV9uTSjL8o92kynxx+1vQIpJwjD7U4BWpHhf0
 S5AWOSu+UYtbjsoA5jOILVprZthYjBPz18CqfiQWG3m1eso50AlEeonIeL7umhcknwfnuk
 PZi5BRvXRTxE0h0H33ptgqeHlN4euGukAjrNLkQlItDlyHEBngJxHxm5HEDFtsKsBljp6O
 x0MtmvIdF7TOEwm3K/LHVRqivMY2W7IvcLpfCKh9BIq1htD8j3DDcLu8c4NjO702FGdPrJ
 MtD1osnDPMMeEHJ8Dd2VR2aHYR/CeOs7LDEq+JCJpnsB7mGAzsb8TI8fW9JA
X-ME-Proxy: <xmx:hddrat3SFvKnQYqly19S3K4OgKmQsXs4G9e32AlgQsjlm-v5iGvjjg>
 <xmx:hddrarEWFQK6TY6FhPiX6umqdpMHMQpTSgV1kYw464IegUD4w3pY4Q>
 <xmx:hddrai69c6yQ_88ugcfrRxWqXCHkhc0sNEwOPY-LweKtpoHKJIoEmg>
 <xmx:hddrapvuxoxTro4DD9461_IlnioQBqIt5-NjkEGGqIcw6BoW6X7nwg>
 <xmx:htdrar8EHKbKuIqmWcbzPmt125GQhb_6X0aN_gMQ_gDwlgCdOTxuQ3XC>
Feedback-ID: if6a9495e:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
 id 9BCB21EA006C; Thu, 30 Jul 2026 19:00:21 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
Date: Thu, 30 Jul 2026 23:59:44 +0100
From: "Sam Heney" <github@me.samiser.xyz>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, qemu-trivial@nongnu.org
Message-Id: <5f24de0e-49af-45a7-927f-f79b203bb335@app.fastmail.com>
Subject: [PATCH] tests/qtest/migration: Only build tls_no_hostname test with
 TASN1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=202.12.124.155;
 envelope-from=github@me.samiser.xyz; helo=fhigh-b4-smtp.messagingengine.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FROM_SUSPICIOUS_NTLD=0.5,
 FROM_SUSPICIOUS_NTLD_FP=1.999, PDS_OTHER_BAD_TLD=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 30 Jul 2026 20:30:05 -0400
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

The test_precopy_tcp_tls_no_hostname test and its start hook use
TestMigrateTLSX509 and migrate_hook_start_tls_x509_common(), which
are only defined when CONFIG_TASN1 is set. This means building with
gnutls enabled but libtasn1 unavailable fails:

  ../tests/qtest/migration/tls-tests.c: In function 'migrate_hook_start_tls_x509_no_host':
  ../tests/qtest/migration/tls-tests.c:510:5: error: unknown type name 'TestMigrateTLSX509'

Guard the test with CONFIG_TASN1 like the other x509 tests.

Fixes: df9c38b19af8 ("tests/qtest/migration: Add a NULL parameters test for TLS")
Signed-off-by: Sam Heney <github@me.samiser.xyz>
---
 tests/qtest/migration/tls-tests.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
index 827cc7bcf8..9bdb1165af 100644
--- a/tests/qtest/migration/tls-tests.c
+++ b/tests/qtest/migration/tls-tests.c
@@ -492,6 +492,7 @@ static void test_precopy_tcp_no_tls(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }

+#ifdef CONFIG_TASN1
 static void *
 migrate_hook_start_tls_x509_no_host(QTestState *from, QTestState *to)
 {
@@ -519,7 +520,6 @@ static void test_precopy_tcp_tls_no_hostname(char *name, MigrateCommon *args)
     test_precopy_common(args);
 }

-#ifdef CONFIG_TASN1
 static void test_precopy_tcp_tls_x509_default_host(char *name,
                                                    MigrateCommon *args)
 {
@@ -719,8 +719,10 @@ void migration_test_add_tls(MigrationTestEnv *env)

     migration_test_add("/migration/precopy/tcp/no-tls",
                        test_precopy_tcp_no_tls);
+#ifdef CONFIG_TASN1
     migration_test_add("/migration/precopy/tcp/tls/no-hostname",
                        test_precopy_tcp_tls_no_hostname);
+#endif /* CONFIG_TASN1 */

     migration_test_add("/migration/precopy/unix/tls/psk",
                        test_precopy_unix_tls_psk);

