Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E76C71136
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 14:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ54t-00048N-Iy; Fri, 13 Jun 2025 10:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54p-000478-Gb
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uQ54n-0001T9-ID
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 10:08:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749823691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZtGNbngagZowlFdpcI8HvA2dIlze53B9ZOZz7ZeuxTs=;
 b=clwnNqJC9TfgPQOQIeOgyHMKM22f0uJy5i7pzK3fd1fhNagZ0ta0LYi0JrgzbeQ88oSXpI
 m9BfUh88fB56evFtIXwwPTuO6ekqm1DFcnEb9rPsSTi40FUiE6KF6Qmty+6FMEBOApF8TJ
 Gw+VWXGq+v7A3m4zLwPIjaS6rnhdv4c=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-YGTFkPfaNe-7HfssoxOZ8w-1; Fri, 13 Jun 2025 10:08:09 -0400
X-MC-Unique: YGTFkPfaNe-7HfssoxOZ8w-1
X-Mimecast-MFC-AGG-ID: YGTFkPfaNe-7HfssoxOZ8w_1749823688
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fac45de153so31329176d6.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 07:08:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749823688; x=1750428488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZtGNbngagZowlFdpcI8HvA2dIlze53B9ZOZz7ZeuxTs=;
 b=QUdPIo6iCM/S9H9bTuEucdEOe70+tPJFKKha/EH5gQ2k2x1FzbIz8OChwwgScCkt+8
 FAmjRKXe9mAOPzjSahBXL6aQvfIptpicgJj5lyoLn92Zfn33EF8eIcgnxyMm5hWp9wR8
 1w/ZOqYe/7aE064GGSsxDHnGNb066YYM9nl5LRJPZFlwxigtQ0GX2OX06JC6hOJyutia
 XBC43RhtzTw11hXG0ePBIVhilmNN9J9vdAbQgJhhVpgqXEY1eC5aV27qAldsX2/tYPpB
 koo9QudI6MJiQjr0WvWCKeC2nao5aPaW8XQ56rv0Dc7RpqncD1/mSeKuUrc5EB0JulbR
 VmaA==
X-Gm-Message-State: AOJu0YwKl6LAK8tshDjsoIApbgGZYcWn+9HIeoi5e2JvO/CB46dSA18J
 RSETHPLT9qDxRD0lrlQyDdLUE1xLeRXgS3DrDSQMnuM3FaA0HZyUT2E3XGL1wM8O8y30LLVVY8T
 m6GEQxYf5L+Jp+9Ef2Z81QDT1D938nOjJAMlkC6wvz1XbYtqziZ5zfqWWuugmDoovG9FcRCQpL/
 Oa2yEwcNtifY1JazQ52eFSzN8WPqNOoQSU7vTxdQ==
X-Gm-Gg: ASbGnctos8RELkAnTsLJsK3UZekL/cji0ntVsH0xdpeV3wtoUhFDGGHVy1u9uxqbvOt
 dTLAWXAj+PcUa3hoNl5hL94FLRCg/N2cplFe+0rfPYSiV2fjK1hq9do3yEq2SEQ5B4GqAKcck8X
 ouehTobMebUibP4cVhdrv69BKENya26VsH+nm4Bb4p33JyPSjMFeTU6UJlW1/U3Fi0M18EQ75mI
 Y4l1CsHogjOX9fUYErO+PnbIALkfXxY/iWa7Q6q0dBg9mAavRd/uYxogZxuUhcVmO17iaA6OqrX
 AEYcCP15HnE=
X-Received: by 2002:a05:622a:4816:b0:499:5503:7b2c with SMTP id
 d75a77b69052e-4a72ff18e39mr59444011cf.43.1749823687920; 
 Fri, 13 Jun 2025 07:08:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRyPdqjx1gEFBLVGZZXGwrD6+ZD+qblAgtVDjpWiXky+DIFkA0chRsMdL4GBxqbc1F9q0Yrw==
X-Received: by 2002:a05:622a:4816:b0:499:5503:7b2c with SMTP id
 d75a77b69052e-4a72ff18e39mr59443281cf.43.1749823687241; 
 Fri, 13 Jun 2025 07:08:07 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a72a52a1ddsm17384111cf.81.2025.06.13.07.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 07:08:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Mario Casquero <mcasquer@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU
 results
Date: Fri, 13 Jun 2025 10:07:52 -0400
Message-ID: <20250613140801.474264-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250613140801.474264-1-peterx@redhat.com>
References: <20250613140801.474264-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Unfortunately, it was never correctly shown..

This is only found when I started to look into making the blocktime feature
more useful (so as to avoid using bpftrace, even though I'm not sure which
one will be harder to use..).

So the old dump would look like this:

  Postcopy vCPU Blocktime: 0-1,4,10,21,33,46,48,59

Even though there're actually 40 vcpus, and the string will merge same
elements and also sort them.

To fix it, simply loop over the uint32List manually.  Now it looks like:

  Postcopy vCPU Blocktime (ms):
   [15, 0, 0, 43, 29, 34, 36, 29, 37, 41,
    33, 37, 45, 52, 50, 38, 40, 37, 40, 49,
    40, 35, 35, 35, 81, 19, 18, 19, 18, 30,
    22, 3, 0, 0, 0, 0, 0, 0, 0, 0]

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Cc: Alexey Perevalov <a.perevalov@samsung.com>
Cc: Markus Armbruster <armbru@redhat.com>
Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 367ff6037f..867e017b32 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -208,15 +208,19 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
     }
 
     if (info->has_postcopy_vcpu_blocktime) {
-        Visitor *v;
-        char *str;
-        v = string_output_visitor_new(false, &str);
-        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
-                              &error_abort);
-        visit_complete(v, &str);
-        monitor_printf(mon, "Postcopy vCPU Blocktime: %s\n", str);
-        g_free(str);
-        visit_free(v);
+        uint32List *item = info->postcopy_vcpu_blocktime;
+        const char *sep = "";
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms):\n [");
+
+        while (item) {
+            monitor_printf(mon, "%s%"PRIu32, sep, item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            sep = ((++count % 10 == 0) && item) ? ",\n  " : ", ";
+        }
+        monitor_printf(mon, "]\n");
     }
 
 out:
-- 
2.49.0


