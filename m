Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D9606A336
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=jkX9AQXl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRrj2-0000ur-KC; Fri, 13 Nov 2026 08:53:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <renyanyi@foxmail.com>)
 id 1xRing-0007cl-Jy
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:22:08 -0500
Received: from out162-62-57-137.mail.qq.com ([162.62.57.137])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <renyanyi@foxmail.com>)
 id 1xRind-0006ne-5s
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 23:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1794543717;
 bh=nk/RSqpOyF9AOGqJ6mmCpMEm64x3V7XBHMBN8Roqm0Y=;
 h=From:To:Cc:Subject:Date;
 b=jkX9AQXlGlN4F4krD2plpBwRC/Y5L+mHaG0qMzLFZp5orXlM1AA58YTzg2CZ72i9N
 7zShVbxSgf4cn7flS/BbisT512CtHWRZKYek3uSNbaRQH0bperzhH0Zcma46RGh9PX
 Bgzb1ngMlv64eYZ+wkwSKUONuC+SicN3l97rVylk=
Received: from renyanyi-Z8000 ([124.70.231.38])
 by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
 id 3981FA72; Fri, 13 Nov 2026 12:14:24 +0800
X-QQ-mid: xmsmtpt1794543264tbkaqdj83
Message-ID: <tencent_F51096E1B3E61DE34EB79721F55551866805@qq.com>
X-QQ-XMAILINFO: NGZp1yYNf7Y+3U3yWVqfMm5BM87WFRtmINO3MRoxcBv1h/ep5aF65N9sWItjnz
 Jc9ZtYFphttDYWDncKp234dcq213RdOlkhMbG23JZDH+PBDos0VGoonlcQHQkQEiJOTlVEL8mMEM
 DNSi1W6LblpMJ/avi8tGQvU8bkbqBh2ue8itM7r5xEwhZc94FCayLoqIqmRCo7QyJwoBaWjMKzjx
 DCm8K7C3PogeEc2zYzhCuefe9XSGkOSCaKsernxHGA56MVd7ggBBEH8tV3/KrYk1vLbm0vEn1Z/J
 C+JQAzCLpHnJRUq4K38pDNezDk5pWCqiPgvaxd/dpyDGmakhGtEy/LHd8ws3zvnQg8KgxJLzaLvN
 A73EwBasi71Un5wugBHOK7SieGO9JRTxwSA40n3Ihly8/teCGDqA5I+111x8cNo4v0Fx/oNC/f62
 HcN2QkSicoNTmIiF+m86zTTD/YPEfE3sA1D1teZkNlBOrQOJIGRZfViRupP/l4qdQMx0wf5ubYqX
 MTAppeTDJwr/JPfeI/e/cJzwRbjSGss93NhqRPhTEV9BkY9oXuF1knhOcXVhSKaK+kudTeF5PJNX
 iifBVT3qJjhzY/WjgDYtuLUYkFlWTXoGkH8Wa4jYK2mBQM0oUMK62TGFwCBO27/q7G/U9z3vpOnO
 +wb8fxOxiBaTzPuwqz75rkqapd4V+V4Yn6jH4QYKh1uDBvmXO1Y8UT8700GMhiU+/wUqTYNPFQ4n
 WKRRzbdXNBHzFQZIJiuXnnoCSbzETQQ63WXgH9MI2uHwMQNZmecFYVLGGapp/RwYyoIsq+ID/k4E
 Nofd/77AdGkPc++NhEbDzSsXBpWM3VV716pJB0SihM0elg0steAkNATgMEnac1AcimdwgDCjP/DS
 3FfGKKzZyfK5EufVx9jh9YHRXqGZNQVY0s0aQAt/QlJzSYOTJrLFOcHroFXYQ56rndaODRwMUUOl
 PGvxO4mkM8H+RE3XR1YUML5L8E/pndeXthr2nBxregAFIe8jmHENBE0zk3Rzhd+VBWj8dR9561sE
 9KdReP2wEtFE/8VbwxeAGPDm4/oxtyJD7jqDGlTFgUyNxAm0ECFw7bQTmCoxZKtxGHN/jLdg==
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Ren Yanyi <renyanyi@foxmail.com>
To: qemu-devel@nongnu.org
Cc: mchehab+huawei@kernel.org, mst@redhat.com, imammedo@redhat.com,
 anisinha@redhat.com, Ren Yanyi <renyanyi@foxmail.com>
Subject: [PATCH] acpi/ghes_cper: report errors in the QMP injection path
Date: Fri, 13 Nov 2026 12:14:23 +0800
X-OQ-MSGID: <20261113041423.680377-1-renyanyi@foxmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=162.62.57.137; envelope-from=renyanyi@foxmail.com;
 helo=out162-62-57-137.mail.qq.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HELO_STATIC_HOST=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Nov 2026 08:53:46 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

qmp_inject_ghes_v2_error() fails to report two error conditions:

- When acpi_ghes_get_state() returns NULL (no ACPI GED device, or the
  firmware has not yet reported the GHES addresses) the function
  returns without setting errp, so the QMP caller sees a spurious
  success although nothing was injected.  Report it with
  "GHES is not available".

- When qbase64_decode() fails, it has already stored an error in errp
  describing the actual problem.  Calling error_setg() again on the
  same errp violates the Error API contract: an errp that already
  holds an error must not be overwritten, since that leaks the first
  Error object and discards the accurate message.  Drop the redundant
  error_setg() and let the decode error propagate unchanged.

With this, the QMP command reliably fails with a meaningful error
message whenever injection is not possible.

Fixes: ddd8f3baa27d ("qapi/acpi-hest: add an interface to do generic CPER error injection")
Signed-off-by: Ren Yanyi <renyanyi@foxmail.com>
---
 hw/acpi/ghes_cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/ghes_cper.c b/hw/acpi/ghes_cper.c
index 31cb2ffabe..1516a7eb24 100644
--- a/hw/acpi/ghes_cper.c
+++ b/hw/acpi/ghes_cper.c
@@ -25,12 +25,12 @@ void qmp_inject_ghes_v2_error(const char *qmp_cper, Error **errp)
 
     ags = acpi_ghes_get_state();
     if (!ags) {
+        error_setg(errp, "GHES is not available");
         return;
     }
 
     cper = qbase64_decode(qmp_cper, -1, &len, errp);
     if (!cper) {
-        error_setg(errp, "missing GHES CPER payload");
         return;
     }
 


