Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75255C25B7A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:53:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdA-0005Ca-Tg; Tue, 14 May 2024 08:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rcz-0005AJ-GI
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rcx-0005Dx-St
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MHS61uEHiJWOSV9T9AGgCqJCHnwiKNHXqdTx6hcnOtg=;
 b=SHRbL9D7RiGy8rbI6MQb2aTHgqpCEj3EZz/0JPfoXXbXqU75qOXIxEDVF9L9bqNL2sNaWv
 Z5yDlkIb82MRHi0tlh2tBJ6wOcbQ/2+3txfbX54pF78yOC/sc0CjjRM95YA3iE5tpp568z
 adrX7QOE0e9ZbPshHbfsJ9uLUz2iTKY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-YNR1eoliM3isD6ZAxZXGYg-1; Tue, 14 May 2024 08:51:28 -0400
X-MC-Unique: YNR1eoliM3isD6ZAxZXGYg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2605101A52C;
 Tue, 14 May 2024 12:51:28 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 107A3400EAC;
 Tue, 14 May 2024 12:51:27 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 06/11] Remove glib compatibility code that is not required
 anymore
Date: Tue, 14 May 2024 14:51:14 +0200
Message-ID: <20240514125119.284638-7-thuth@redhat.com>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Now that we bumped the minimum glib version to 2.66, we can drop
the old code.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20240418101056.302103-9-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qga/commands-posix-ssh.c |  8 --------
 util/error-report.c      | 10 ----------
 2 files changed, 18 deletions(-)

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 866afe6741..246171d323 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -243,7 +243,6 @@ qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
 }
 
 #ifdef QGA_BUILD_UNIT_TEST
-#if GLIB_CHECK_VERSION(2, 60, 0)
 static const strList test_key2 = {
     .value = (char *)"algo key2 comments"
 };
@@ -439,11 +438,4 @@ int main(int argc, char *argv[])
 
     return g_test_run();
 }
-#else
-int main(int argc, char *argv[])
-{
-    g_test_message("test skipped, needs glib >= 2.60");
-    return 0;
-}
-#endif /* GLIB_2_60 */
 #endif /* BUILD_UNIT_TEST */
diff --git a/util/error-report.c b/util/error-report.c
index 6e44a55732..1b17c11de1 100644
--- a/util/error-report.c
+++ b/util/error-report.c
@@ -172,18 +172,8 @@ static void print_loc(void)
 static char *
 real_time_iso8601(void)
 {
-#if GLIB_CHECK_VERSION(2,62,0)
     g_autoptr(GDateTime) dt = g_date_time_new_now_utc();
-    /* ignore deprecation warning, since GLIB_VERSION_MAX_ALLOWED is 2.56 */
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
     return g_date_time_format_iso8601(dt);
-#pragma GCC diagnostic pop
-#else
-    GTimeVal tv;
-    g_get_current_time(&tv);
-    return g_time_val_to_iso8601(&tv);
-#endif
 }
 
 /*
-- 
2.45.0


