Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8ABDC61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:13:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZd-0001rN-W9; Tue, 25 Aug 2026 15:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZI-0000zz-IQ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZD-0004NC-EH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eFke7uYqhjOsM9VFIgL5HFp+d3kDilCmv27jgoE026Q=;
 b=Wq1mfxdbDrqyZxU+rvhOYxSkUfCmheeAO373agOU7R/1CInaelsejXK4MBYg5E+xaN41zw
 rWuaSJsM0J1Bi5nPE//Fx9jd+p5TAdMDgMJd3XQeWdugU6SZP7VVgZWLWM4CMECxgsCgTD
 5dtrAoyJz12nczMckp/ykGjft3Rsu9A=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-357-9zVFXM_SNdmHPQkKJJxx6A-1; Tue,
 25 Aug 2026 15:12:12 -0400
X-MC-Unique: 9zVFXM_SNdmHPQkKJJxx6A-1
X-Mimecast-MFC-AGG-ID: 9zVFXM_SNdmHPQkKJJxx6A_1787685131
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D54F91921ED0; Tue, 25 Aug 2026 19:12:11 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D80F27D6; Tue, 25 Aug 2026 19:12:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:40 +0400
Subject: [PATCH v4 33/49] qemu-print: document HMP/QMP behaviour better
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-33-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=968;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Mo8cBdHqWinpU57ZVLGO0vQPm4yx6iOLD7L3h7acAqw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIltuVcGz6TfC8icyJkF9WEDf4iTDg83vgh
 DTF5Y8q/omJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5XoSEACQ7sXpr3hYIbmN7f3BobOZhppRzhVcgOGErF3DAdo9VnGXx4Z2hMq5H1dfui5UNBvUSvT
 c+7fNe0oLhBay/NZkoBTM3v5NH7bgoSFvAS/55D8UqxdLVqvF9sT/MWNHU1lySN5/dyssnPIql0
 trmFHPfdEuGEmRy6TaMa+/1A6ViJdUakyL/DdSyDJgcBM0b/1w8b0LjMYVCYFL5kaKT04UXkNUm
 +I/NejzXZJh4bfmNPGb7aVBgf7vFdU/LuLKZZazSzlr/AP2PAaiMamKmwg4HfsjuV3ZYhTIoHia
 P4zbN6mwe3U/5xDRw2fkMIYRd3uTsYWkTHG9crWKtZn4wr68H3paFlqa7Kq85I8Eekt39oHFSf7
 wOq/mT4gv/KgxVbaNwq6EPoebMBtPlJZGvddEoKVd/40bmmcFuFCI2+LHX8tRZ+gx1MI5WgC5KH
 IoqnsY/pyy/F2v7KMSEX45lFMGb7+ra/1G/pmfwgDdzzvlazzweXAO7/cH4eegTmEe9Xrt4nQs5
 ngAQUNCTG4RN1l0mNYAxkKLbGyWqHdiVmO7W6lnFksfqXlyojEjIItCf8yHyiatwds14rX+jRaM
 ZEz4POKeLJ21VCo8xTgtz7HclX0aTnM96tpT+ADq64N0kz6Od25bnCFZ0IMsP8Y2QX01Xnq6q2j
 BpaJG4FUoLZScdA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 util/qemu-print.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index a2d1f0244168..5d4143d425a1 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -17,7 +17,8 @@
 
 /*
  * Print like vprintf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_vprintf(const char *fmt, va_list ap)
 {
@@ -30,7 +31,8 @@ int qemu_vprintf(const char *fmt, va_list ap)
 
 /*
  * Print like printf().
- * Print to current HMP monitor if we have one, else to stdout.
+ * Print to current monitor if we have one, else to stdout.
+ * (if the monitor is QMP, fail without printing anything)
  */
 int qemu_printf(const char *fmt, ...)
 {

-- 
2.55.0.543.g5ebe2ebe4ea8


