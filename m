Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E868C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 23:08:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXq1E-000204-VH; Tue, 14 Jan 2025 18:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq19-0001ze-2u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXq17-000478-A2
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 18:08:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736896091;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7tDkWWg6+jos1+qRgaPmbYXKxwn6YXWcJ9OlhS4rNJA=;
 b=hjQbJBRdGo9RQWUCZqbqXTkuAmSgIDOEcMQGbLV8xJNCMGNZKXqj4RMqSQub5+oI96sOS3
 kh+XeMooEqFO+L/P6MtoWdOBquHvZNFFY9zks1omQKznz32btHQUzpXeChWN2mS5geNdK7
 +krGuCgDo9VeQpDA66yE6CDJYMCOLq4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-Vd6OOj2ONEyiIyGW-8ujAA-1; Tue, 14 Jan 2025 18:08:07 -0500
X-MC-Unique: Vd6OOj2ONEyiIyGW-8ujAA-1
X-Mimecast-MFC-AGG-ID: Vd6OOj2ONEyiIyGW-8ujAA
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d92efa9ff4so92717156d6.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 15:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736896087; x=1737500887;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7tDkWWg6+jos1+qRgaPmbYXKxwn6YXWcJ9OlhS4rNJA=;
 b=MNr7c1Doc8XW48lb3rfognaaqpCwiJjV8X7uBMsSZkVWuREnsQM4MdT7ky11ZHq0uZ
 AsM42HoGOXbjOcCCIAlOXX1+s5fSv00PbczWqSa/aUi2BPWVQQ8wQG/7wR3etGLsPQeX
 EnGSFEpWaILG3bsVFOBRxQ6gaW0MFAd6D7zanzHDJHo08il0DeD5/iPYPx20/0CEdBIx
 Ow5kLTrgj50QtfYjwYqLwQ12yYh2WnhDbspC24uA9Y7EO62zV1K6KhNasy3OTU5r9iBc
 LmJTeyxMnESuewZcg7WIRN+kqaayTwhZI7Fe7S9ZGxAD8kqyxRLfl5E0Uh9fBRf4bPn4
 UiIQ==
X-Gm-Message-State: AOJu0Yyjv+wclgyhBi8z5OgqgaCA0gzmsFD/363DBqV2d/gFnkseWx1z
 lCHGN3O9hJEAaxbiDjP8WW4v/tPkVPEiUmp+9PcPmwkpmxFq9sLhmeMAuGV06OUdTXwTygLz3nn
 /JGX/iEWSgBy9tVbB/A2QuvPA10jiPbu6aPSSh52DmbV0vDolskji7GoXahgrGfTAzeW3iqFZfC
 eQWDGJwhhEbDrFRb7PWkclEWkTGzMQLuVJtQ==
X-Gm-Gg: ASbGncvJsDMxQAq1dCG83TRf23hod3dP5q6do0HyV6k5yHY+g+ClgiI0nzEvszO5Pum
 P5bTMrjaIStHi29McHrXTLbqJNSYOavc3GuvF4ZbmKZkUEFrdkfOyPSoXR/y7VrFSnHQC/JLyYB
 LrFMIzxV2ww4cm1xl+WHL+Dcxav9hB2vTKDg7WGIduUgBCDqfyecTQjS6M1OYkLmx822oye/9yo
 tpN+GbZb3f7fGk4InttSVxGw8rA9jFlae2CReAkh7GA83NUh6/flFN1Ne04vz0fY07WiZoCn0yw
 JF0iebHpcHI67KNN1aJ6C9B9JRbDj364
X-Received: by 2002:a05:6214:e83:b0:6d4:3437:d858 with SMTP id
 6a1803df08f44-6df9b22e404mr410183856d6.25.1736896087067; 
 Tue, 14 Jan 2025 15:08:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEspMYjE2J2V7F2QCz2ZDLl4X3BwYy/S9aH7DTn3ewShqr7tTWsK7nWJCVDOHTbAH7K80ptyA==
X-Received: by 2002:a05:6214:e83:b0:6d4:3437:d858 with SMTP id
 6a1803df08f44-6df9b22e404mr410183496d6.25.1736896086719; 
 Tue, 14 Jan 2025 15:08:06 -0800 (PST)
Received: from x1n.redhat.com (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm59268971cf.49.2025.01.14.15.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 15:08:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>,
 Julia Suvorova <jusual@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH 10/16] migration: Take BQL slightly longer in postcopy_start()
Date: Tue, 14 Jan 2025 18:07:40 -0500
Message-ID: <20250114230746.3268797-11-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250114230746.3268797-1-peterx@redhat.com>
References: <20250114230746.3268797-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

This paves way for some follow up patch to modify migration states at the
end of postcopy_start(), which should better be with the BQL so that
there's no way of concurrent cancellation.

So we'll do something slightly more with BQL but they're really trivial,
hopefully nothing will really chance with this.

A side benefit is we can drop another explicit lock() in failure path.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5850c90c9f..f644a6306b 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2626,8 +2626,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 
     migration_downtime_end(ms);
 
-    bql_unlock();
-
     if (migrate_postcopy_ram()) {
         /*
          * Although this ping is just for debug, it could potentially be
@@ -2643,7 +2641,6 @@ static int postcopy_start(MigrationState *ms, Error **errp)
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
         error_setg_errno(errp, -ret, "postcopy_start: Migration stream error");
-        bql_lock();
         goto fail;
     }
     trace_postcopy_preempt_enabled(migrate_postcopy_preempt());
@@ -2654,6 +2651,8 @@ static int postcopy_start(MigrationState *ms, Error **errp)
      */
     migration_rate_set(migrate_max_postcopy_bandwidth());
 
+    bql_unlock();
+
     return ret;
 
 fail_closefb:
-- 
2.47.0


