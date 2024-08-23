Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F6D8C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 06:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shNYq-0003dR-V7; Fri, 23 Aug 2024 02:14:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYo-0003Yt-QU
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:14:10 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1shNYn-0003DT-60
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 02:14:10 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7141b04e7a3so1343288b3a.3
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 23:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1724393647; x=1724998447;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TCWqBNLN76lvDt02Z9O72XGpvlEOCWgTyfhqZXKjDaw=;
 b=tkEQIl/8nJAQAZb9O3Q84H+Ds+tyJ4rlz4/GAyLSCeA8o8SpeL66vShDQzudPIPXSi
 zBFHxXHzSjuhhwTzQBQqSJ4Q6JZ8xQKpGWGEZYz5hixUWETWfgPm9BFUejQ0M6LsRtuH
 tH35Dmm58QdQayVCTV3WDZfMR7DDcRbSG4Ws3mhqE6ZnOQ+sFFLs1r2VWIPNGOrFBkcQ
 4jkTmicKJPD0xjVcN9aVfP5A4oghLqm7tXoFxuIrv1WcZXT/S8I5m3BmErNIL9lDULwv
 xe0RkHVVatItEO7PtuKqfKjyYU/Uv6s1z7wnQN5JgS999bSBvwOcxQ6OeZR5QYbO31LJ
 fnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724393647; x=1724998447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCWqBNLN76lvDt02Z9O72XGpvlEOCWgTyfhqZXKjDaw=;
 b=i4ZL2FxpUrzDlKKHVEVmOk+5GbFS8ftnPPr20hHUtBrxlstmJvU5RxktY6b1Vcx0fV
 DhyQn+/sydjKHdw6zu+GnNNmUtXYLHJxb5kXjbpWmBHjgw6fHVsAD629H0Iyl2agllRX
 FwViusBEaWnvifhniUPZYCmteyT7R8MDh/InjBMprfDtNDW3j3i8I3h0YoDVshfh+pui
 OEmv9ZS6tJ/ZW06lub5dxJIeL2b2O7aK/Z6BKoara0FZWza6rcuZzT9Kixo+rtwmpw8E
 uusyRUY4M8ZIXkbN/GVdA8Qb1dxCVIBzwurL3PxscnaTJq/lHRLcdwQv3nnFMAptVkVG
 WIWw==
X-Gm-Message-State: AOJu0YwVtGuOBCWLz3nZ4bFmzpMndRtqlmamrlvOrxcem9FIJ+4zJH5c
 KKQyZbVpeyRubeUxi0N0mQLQmax0jC31pyZSyKMHQana+js/MZUhgYRQs8ArAJM=
X-Google-Smtp-Source: AGHT+IHQAQTjyHnSxviZgtgI0vIuOZfZH2ixcOe5Tj2LMg+WQaj65xPn4VkB/GO1BZ89fiRkpEeF7A==
X-Received: by 2002:a05:6a00:1a8e:b0:710:4d08:e094 with SMTP id
 d2e1a72fcca58-7144573cd07mr1253784b3a.2.1724393647393; 
 Thu, 22 Aug 2024 23:14:07 -0700 (PDT)
Received: from localhost ([157.82.207.23]) by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-7143431052bsm2316219b3a.181.2024.08.22.23.14.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Aug 2024 23:14:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Fri, 23 Aug 2024 15:13:12 +0900
Subject: [PATCH v4 7/7] tests/qtest: Delete previous boot file
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240823-san-v4-7-a24c6dfa4ceb@daynix.com>
References: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
In-Reply-To: <20240823-san-v4-0-a24c6dfa4ceb@daynix.com>
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

A test run may create boot files several times. Delete the previous boot
file before creating a new one.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/migration-test.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
index 70b606b88864..6c06100d91e2 100644
--- a/tests/qtest/migration-test.c
+++ b/tests/qtest/migration-test.c
@@ -144,12 +144,23 @@ static char *bootpath;
 #include "tests/migration/ppc64/a-b-kernel.h"
 #include "tests/migration/s390x/a-b-bios.h"
 
+static void bootfile_delete(void)
+{
+    unlink(bootpath);
+    g_free(bootpath);
+    bootpath = NULL;
+}
+
 static void bootfile_create(char *dir, bool suspend_me)
 {
     const char *arch = qtest_get_arch();
     unsigned char *content;
     size_t len;
 
+    if (bootpath) {
+        bootfile_delete();
+    }
+
     bootpath = g_strdup_printf("%s/bootsect", dir);
     if (strcmp(arch, "i386") == 0 || strcmp(arch, "x86_64") == 0) {
         /* the assembled x86 boot sector should be exactly one sector large */
@@ -177,13 +188,6 @@ static void bootfile_create(char *dir, bool suspend_me)
     fclose(bootfile);
 }
 
-static void bootfile_delete(void)
-{
-    unlink(bootpath);
-    g_free(bootpath);
-    bootpath = NULL;
-}
-
 /*
  * Wait for some output in the serial output file,
  * we get an 'A' followed by an endless string of 'B's

-- 
2.46.0


