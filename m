Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F94CDE00E
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrVT-0000tH-4V; Thu, 25 Jun 2026 17:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVM-0000cV-Iv
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrVK-0003hX-3X
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:21:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OSY4Du+wThReu2l3luDB3PBkWNSPdVplZPiWAY+h5N0=;
 b=TQdayiZ+UmtNGPmq2cVNfe7V48LxV9qmXk0Y4A/vA3C3Zr1f4LADA+Oq9MUFlebyioDDd/
 KIphEyGi7DFlMoFr9SZAfy5O4I/WjipEan8/2+NLpHYzKT6KllWYXAAdhQlS63bSztrFav
 1qudvXYtB0ndEgUppsHbyiNHxNGiM+c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-507-_oY5XN5AMbGW1FXRjkpKkw-1; Thu,
 25 Jun 2026 17:20:49 -0400
X-MC-Unique: _oY5XN5AMbGW1FXRjkpKkw-1
X-Mimecast-MFC-AGG-ID: _oY5XN5AMbGW1FXRjkpKkw_1782422448
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 77F671800366; Thu, 25 Jun 2026 21:20:48 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36E5F414; Thu, 25 Jun 2026 21:20:46 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:15 +0400
Subject: [PATCH v2 14/39] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-14-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1682;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=AvhBD7LC8S+UUVLOR6honVVMWXRDaIcekyjM+15DjDg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtdDPaAkj72s+CTx+lAtUfGpo/5ERUKWCTXd
 n++zzewLTOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXQAKCRDa6OEJdZac
 5RskEACWNGAJDsnrcCnremHbffnlY5u5gjDFMgQpYMzQ48XqvO8Ehml4Hn8y9BwZWoaHL6lJ79s
 OBtkT+TC6wfNXlmskUt75eRS1R5e76tf60ajImv03n4i/KkFQZX00433dmWzhhlftAoZyqtldOV
 Fjk/bnd5hOmhilfBxyEEFqZokYVo3D7LZnD4KzzXasZlNQ6qQh8JaMumOtQU3k5M2mhY0Cy11Po
 AohsX0726l0Jzq52myjUdUaptmZ9fcXvTmsEGLdIU6CJpGrUoElNj5TIeWxEEADLHudm0vQoNs9
 v/Vq2nqVRUpuK1pj/Ztanmi9CD5w/SoYuddTWEUBJnhCarxNtYo1XDdTTy4FWgwM1UgxRpIEqlq
 sRNFYLf7to97FRhR5HzaQ5H4Vx2/Hi7Vvp41nti+oYBg1IZ/XlEQU+JSdiChG94fbIBTCsrpuTN
 mUBBdcDayZfUOMH9He9FikpghgOUCGjYco+s1YRYRqiWpR4qatwbgs+MKTdHPT/ffFmdNPrb7cB
 NwCG07eE0Arc+/dkoLQ+qXy86RdqpV6xdgkR0k68v8D2q6sZcCdKXlD0Ak8fhNzX++qbyEL7KuY
 WUgGu2VVhQHcyyfumV0j7EQzKMHp5TQRidt0rarWfbHujwtCVhA+NFoNXazbzINpOSnxluTfWVw
 +5egzcM9PyDiaqA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The pnv-xive2-test and pnv-host-i2c-test pass "-serial mon:stdio"
but never use HMP commands. The "mon:" chardev prefix creates an
HMP monitor mux, which fails when HMP is disabled. Other pnv tests
(e.g. pnv-spi-seeprom-test) don't specify -serial at all.

Drop the unnecessary -serial mon:stdio option.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/pnv-host-i2c-test.c | 2 +-
 tests/qtest/pnv-xive2-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 51e613ebdcb..368d1a91401 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -415,7 +415,7 @@ static void test_host_i2c(const void *data)
     }
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors",
                       machine, SMT, SMT);
 
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 5313d4ef18b..b4f4b601c2a 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -549,7 +549,7 @@ static void test_xive(void)
     QTestState *qts;
 
     qts = qtest_initf("-M powernv10 -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors -trace '*xive*'",
                       SMT, SMT);
     init_xive(qts);

-- 
2.54.0


