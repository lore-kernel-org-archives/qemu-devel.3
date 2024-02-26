Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BFCC5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 19:59:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reh6w-00017b-N9; Mon, 26 Feb 2024 14:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6r-000108-PS
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:59 -0500
Received: from mail-ua1-x92f.google.com ([2607:f8b0:4864:20::92f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1reh6q-0004ud-6x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 14:57:57 -0500
Received: by mail-ua1-x92f.google.com with SMTP id
 a1e0cc1a2514c-7d5bbbe592dso1778231241.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 11:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708977475; x=1709582275; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUMxmmc1oEZ/KucWH0CWtubboX9PrDgWV4N0uAYEoGg=;
 b=HVtSYtchGyq4O6gUwgITjQkcH+ReblbqRiYhTuc0o20lDL6bKcIgA5mnSuJusMptTt
 WynHrRH8pq7abWHCiCCNM+tW+TaDaPTvvq7Zpf9KsAxDnHXjGpkd3ApXw9QcAbSCTJDK
 C+CrpEodkI6bmEOLzsEGj/BGssKwn7qYKMXIy0WHabt2bXWKb+MwtJlv5MUPubxmv5G5
 iDH/yruO6dscVBLf2BXxrS32SoYiO0Qg+u3xuMPPBasNoInxUPWcJVXCoSC8xR5DVf8j
 rqz6EJZoeBx1wMtdx4MtsMAKgfopIrRYwQArmmr29h9BquOzCEyEVlP+fHaUG3k3wPbd
 4gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708977475; x=1709582275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VUMxmmc1oEZ/KucWH0CWtubboX9PrDgWV4N0uAYEoGg=;
 b=eGWzsA6Vmw43TKqnvSriyxyxaTYZ9zH+0+kIfgFdpq8BmyLx4jrWZ+qXDPvJX/qAXo
 Ekt73mphJvZcZYoQpTbT0PwPdy8uhuevxbFDOKhnFyOsVLyZK/ZlIjYE5qOlII3Nryfs
 /isDMHRof1tnUh0IWi+Q5wvnLOyjpjTtrRLfP8WdwhCKz8eeOoPP2aOPggeVtHTDOGuR
 UzohsQstbge04nx6kX9b/gtL0+AfaKOVnWJ2VUoBP7tIqINCcs0a042AKnAZ6Dqr0IO6
 QS5KbH+l6cpzpMv4E+sxv+r6bMkt/17k4FRAy35c4jiVnNBSVnj3lPPyApuzZhLzeSC/
 OFLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWo6TZ0blxq3IoiOl735Cy98X2YD5xQ3aRerMzoj1wokup7PA3rQxZwkiBZz14en4ECOy+GxbjbtUdWyWsBPdDkB/2jZ/I=
X-Gm-Message-State: AOJu0Yz2UeM1R5JnQbFMM9+PL/ukV4NAegXf8cxAITpc4KU+5AcWnUum
 Mrncj1dSOGPVRFRmyRaARtXe0hnOlettBbNh8CHfZ+A9yOQ/b3lHzlrL3dTtwm8=
X-Google-Smtp-Source: AGHT+IH+8rm2SL6IP+KLTyud81Z8gEdlCxyY3qFbwCoO7e7ZB83fzdGVEXhgg9WFroVvvt2tNDolfg==
X-Received: by 2002:a1f:e701:0:b0:4c9:c252:6afb with SMTP id
 e1-20020a1fe701000000b004c9c2526afbmr4506813vkh.10.1708977474987; 
 Mon, 26 Feb 2024 11:57:54 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.95])
 by smtp.gmail.com with ESMTPSA id
 ej5-20020a056122270500b004ca3dc45886sm712738vkb.47.2024.02.26.11.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 11:57:54 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, jdenemar@redhat.com,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v3 4/7] migration/multifd: Enable multifd zero page checking
 by default.
Date: Mon, 26 Feb 2024 19:56:51 +0000
Message-Id: <20240226195654.934709-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240226195654.934709-1-hao.xiang@bytedance.com>
References: <20240226195654.934709-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::92f;
 envelope-from=hao.xiang@bytedance.com; helo=mail-ua1-x92f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Set default "zero-page-detection" option to "multifd". Now zero page
checking can be done in the multifd threads and this becomes the
default configuration. We still provide backward compatibility
where zero page checking is done from the migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/options.c | 2 +-
 qapi/migration.json | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 3c603391b0..3c79b6ccd4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -181,7 +181,7 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_LEGACY),
+                       ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
diff --git a/qapi/migration.json b/qapi/migration.json
index 5a1bb8ad62..a0a85a0312 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -890,7 +890,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages. More details
-#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#     see description in @ZeroPageDetection. Default is 'multifd'.  (since 9.0)
 #
 # Features:
 #
@@ -1086,7 +1086,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages. More details
-#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#     see description in @ZeroPageDetection. Default is 'multifd'.  (since 9.0)
 #
 # Features:
 #
@@ -1318,7 +1318,7 @@
 #        (Since 8.2)
 #
 # @zero-page-detection: Whether and how to detect zero pages. More details
-#     see description in @ZeroPageDetection. Default is 'legacy'.  (since 9.0)
+#     see description in @ZeroPageDetection. Default is 'multifd'.  (since 9.0)
 #
 # Features:
 #
-- 
2.30.2


