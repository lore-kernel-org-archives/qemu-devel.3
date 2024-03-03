Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB3FC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 10:52:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgjRZ-0002Mi-Mo; Sun, 03 Mar 2024 05:51:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRY-0002MX-H5
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:44 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rgjRJ-0001yy-2T
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 05:51:44 -0500
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so2608113a12.0
 for <qemu-devel@nongnu.org>; Sun, 03 Mar 2024 02:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1709463088; x=1710067888;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ItPC9lAeHcpFUfTU9c6xUSLUEP8u71tkDj/Uzspnk/A=;
 b=WSa1u5dpR4aT63L6lq6kSm3K46aBpx3G7zSak+RGE7Bd5Zpqa86d3B/cGBszjee5HX
 M55PyXbV6sOT5iKMoOxeFsZ0dQsLeEydA/5bFTohXuPHu2wONWqNkz6nbrtNgNZJbysb
 oYrc2QOcRFnH425+OxjA9rhxAs0mdTKf8PbRsTDNY3XtbkpfGcNiuEtYqcfORUvhyoiv
 xaqwW6S1TVXW4MxEKIax0HNtPqjj3aXCu1uOkNUL1JLYOiBun/5XNJI360S7lNuhsbNB
 2AEtxPpq74JQrwTnD/O4qlyiffUGbogvzheHWyhwa+FMJkaoAMvb2Qy+O0VlUS8d9/zg
 HzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709463088; x=1710067888;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ItPC9lAeHcpFUfTU9c6xUSLUEP8u71tkDj/Uzspnk/A=;
 b=SMCX2FYxvrVaj/sehw6fyhz8FCh1KJuwXYuOx8scMnzmLnB9ivfhY65ZTMtZs0ewip
 eCRyPkBuC6ATpsNT+cMi+s25i9dl7qQaBga4jSXGEI6wSV1n77WKtSFRludvTgGimPOs
 E1M07o564cpHREL9YODxu3OBumNiIPglCwtIFpJcckhXFyd4ssMLaET0KfHTTby34bTU
 DEdaeIX9gKQ2UalvO9iyjqgFAnONmbLNP/6iZ8YQ8Zi0TBk07OJsZgOJw95zM70uxfV6
 Lhx1OMoLnxzvLpWUAfmxTlC5QfW3syL7iPecBNpRC+OjUKc3SgniaKR5VsMKWMf0pVqG
 rkmw==
X-Gm-Message-State: AOJu0Yy1LzHOU742SfiJomHyWS2GLUCD88WOl9sy+IEXnd9XP0h7Bpbt
 vHsOyq8O8xwwwyY88Nip0eLsBs4PjzYjA/arzOewfZdbEzRto4PFk+XP9cqRZUh3XtVZdQYf/6S
 i
X-Google-Smtp-Source: AGHT+IFC3GSWO77KFoKsE5qQ3U/0awI71A/bNluNpt6+9YHligzjb40Lr5A+1BCyiEfRysXy7N6WXQ==
X-Received: by 2002:a17:903:124a:b0:1dc:63b2:7c2e with SMTP id
 u10-20020a170903124a00b001dc63b27c2emr7382395plh.31.1709463087802; 
 Sun, 03 Mar 2024 02:51:27 -0800 (PST)
Received: from localhost ([2400:4050:a840:1e00:9ac7:6d57:2b16:6932])
 by smtp.gmail.com with UTF8SMTPSA id
 t18-20020a170902d21200b001dca6d1d574sm6425979ply.302.2024.03.03.02.51.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Mar 2024 02:51:27 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 03 Mar 2024 19:50:40 +0900
Subject: [PATCH 6/7] contrib/elf2dmp: Continue even contexts are lacking
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240303-elf2dmp-v1-6-bea6649fe3e6@daynix.com>
References: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
In-Reply-To: <20240303-elf2dmp-v1-0-bea6649fe3e6@daynix.com>
To: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::52a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Contexts of some CPUs may be lacking or corrupted due to premature boot,
but the output may still contain valuable information of other CPUs and
memory.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 contrib/elf2dmp/main.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
index 432f8629f321..33066310b9fa 100644
--- a/contrib/elf2dmp/main.c
+++ b/contrib/elf2dmp/main.c
@@ -332,7 +332,7 @@ static int fill_header(WinDumpHeader64 *hdr, struct pa_space *ps,
     return 0;
 }
 
-static int fill_context(KDDEBUGGER_DATA64 *kdbg,
+static void fill_context(KDDEBUGGER_DATA64 *kdbg,
         struct va_space *vs, QEMU_Elf *qe)
 {
     int i;
@@ -346,7 +346,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, kdbg->KiProcessorBlock + sizeof(Prcb) * i,
                     &Prcb, sizeof(Prcb), 0)) {
             eprintf("Failed to read CPU #%d PRCB location\n", i);
-            return 1;
+            continue;
         }
 
         if (!Prcb) {
@@ -357,7 +357,7 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
         if (va_space_rw(vs, Prcb + kdbg->OffsetPrcbContext,
                     &Context, sizeof(Context), 0)) {
             eprintf("Failed to read CPU #%d ContextFrame location\n", i);
-            return 1;
+            continue;
         }
 
         printf("Filling context for CPU #%d...\n", i);
@@ -365,11 +365,9 @@ static int fill_context(KDDEBUGGER_DATA64 *kdbg,
 
         if (va_space_rw(vs, Context, &ctx, sizeof(ctx), 1)) {
             eprintf("Failed to fill CPU #%d context\n", i);
-            return 1;
+            continue;
         }
     }
-
-    return 0;
 }
 
 static int pe_get_data_dir_entry(uint64_t base, void *start_addr, int idx,
@@ -624,10 +622,7 @@ int main(int argc, char *argv[])
         goto out_kdbg;
     }
 
-    if (fill_context(kdbg, &vs, &qemu_elf)) {
-        err = 1;
-        goto out_kdbg;
-    }
+    fill_context(kdbg, &vs, &qemu_elf);
 
     if (write_dump(&ps, &header, argv[2])) {
         eprintf("Failed to save dump\n");

-- 
2.44.0


