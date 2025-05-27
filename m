Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DBEC5B542
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 22:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uK2Mo-0002nV-C1; Tue, 27 May 2025 18:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2Mm-0002nM-Se
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uK2Mk-0008W2-R1
 for qemu-devel@nongnu.org; Tue, 27 May 2025 18:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748383305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIQUQu1vYHi5+Y1RGwPEL/5Si8sso3uQAGDJxQ7r36k=;
 b=Rh+mjaXbURt7RTlJJIrfH6b6Qe8VsOsvgIPs/C7xc857cdjw6ALTVpUFTBuxryhChYelpy
 IKHLU1V4bfKepE3uFG7wOO/+eFaBWezlU4t82izQ54e3eAJB27Lr9OA4HJxRTsuDOBrRBt
 l8N4yEEoc9vbCCaw9Qf9ysjsq+GrfAY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-NEvSyinTOKuIx8JP9n3TXQ-1; Tue, 27 May 2025 17:58:58 -0400
X-MC-Unique: NEvSyinTOKuIx8JP9n3TXQ-1
X-Mimecast-MFC-AGG-ID: NEvSyinTOKuIx8JP9n3TXQ_1748383138
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f8e1d900e5so66764806d6.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 14:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748383137; x=1748987937;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIQUQu1vYHi5+Y1RGwPEL/5Si8sso3uQAGDJxQ7r36k=;
 b=a6dKZbAV2a/5MYbxovHmVV1Y0OQU+LEBcFMw2N1TE9d5Rq28bjYRgIeHJVx2PgSlup
 idwkM+a9IDpJhdjfDTXih/S2pmcD/FDBw0mWJqDaes1kNBH6JLifiqs0JQ+HF83Gm1of
 A7SFt9j6fhHOcDPqAAtGcD52nznTpQlCXIPy9U89Pjyzf8rfXrBD06b13tdk0A2avSQP
 9Rud4JTnkuqgtPK8Z+i4ZTr7DToMBKpif1cvMs6deUFACSNn5+VyuTTeDAG5EbGUclK7
 h4OhSoSCIYvvBCmscTMI5BMTCC/4JtFNLQeStxuV0M5SB/0SXel0XfJGphapdBdKHhaJ
 IZLg==
X-Gm-Message-State: AOJu0YzaiJOrPZxB9NGkEhcQh4DrC5xipQWcdq6hYK72b89/eI9MmF2f
 iNEkUI1uW3Fm4a004eQw+HWyaeA1A9/RHKm8csA9Y2D06pq6EmpZx+Vr32oLmteQby4L+6R4OYs
 LqcPE83tr2fecoYkfJ8jEEsDptZQEALg8JFEefAuOuGUBccVwSpLwqJYs8FjaHz7l0w3Gbtgf+J
 YTqXYtS/YOsOjRGkCkiSmrZaDNMpgNQNeBb0ylHQ==
X-Gm-Gg: ASbGncv2XbmfqmX4tuDll5MiM7Q57wuJLIVN+UbLwIplp+1jYorYA2SFdFQJKljwfrt
 zjFbajErq/9v56c/eTzfOs8OHeHal6u2gFSdLBvTQr/VxTU3yr7NZCDBBEK+ftdYL5AeH5CkFgi
 M0mtFNhriK6ZZk2+fgJXWn9mCyNJb0QSivtv7/xmYjhkA+/OpczC+3GSRsv/JuKI71KkDjrMW71
 /FvA+LdUktoZQ0wm9Od79cnsyrb/9dBDokzOIdMFvyyDBwXDR1VngYuPKyGnTcWnvalUgIUbdGn
X-Received: by 2002:a05:6214:f04:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6fa9d0269b2mr213412816d6.15.1748383137278; 
 Tue, 27 May 2025 14:58:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUSi3UJJeg77h5NJfX4md6xlEHNDNDhxGEJU9Lw5CnjoWlsEfi3FWQn2Oh1nn6hz74t3N6Qg==
X-Received: by 2002:a05:6214:f04:b0:6e8:f4d3:e8a5 with SMTP id
 6a1803df08f44-6fa9d0269b2mr213412476d6.15.1748383136828; 
 Tue, 27 May 2025 14:58:56 -0700 (PDT)
Received: from x1.com ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fabe4f27cdsm914516d6.49.2025.05.27.14.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 14:58:55 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Alexey Perevalov <a.perevalov@samsung.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 02/11] migration/hmp: Fix postcopy-blocktime per-vCPU results
Date: Tue, 27 May 2025 17:58:41 -0400
Message-ID: <20250527215850.1271072-3-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527215850.1271072-1-peterx@redhat.com>
References: <20250527215850.1271072-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.907,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 367ff6037f..3cf890b887 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -208,15 +208,20 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
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
+        int count = 0;
+
+        monitor_printf(mon, "Postcopy vCPU Blocktime (ms): \n [");
+
+        while (item) {
+            monitor_printf(mon, "%"PRIu32", ", item->value);
+            item = item->next;
+            /* Each line 10 vcpu results, newline if there's more */
+            if ((++count % 10 == 0) && item) {
+                monitor_printf(mon, "\n  ");
+            }
+        }
+        monitor_printf(mon, "\b\b]\n");
     }
 
 out:
-- 
2.49.0


