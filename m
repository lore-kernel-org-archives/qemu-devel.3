Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 417D5CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 16:17:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBy01-0006Bs-P4; Thu, 23 Oct 2025 12:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBxzv-0006BL-Vl
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBxzt-0000YL-Jd
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 12:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761236223;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KD3gwizD3hGZK/AzUEZJ3OZsksNKF5sDZP18KcplOw4=;
 b=fnhhPESzA79ihlnIQo3CdlynQ7Xqk2VIZdd6874ZWXxuOpNbQ5DN3LKuNtN4by5iD/M4pX
 ncWP5hqsFKYHgvuBaYxZ0FuLVYs1ewdCqwy8DHouUUxVifKKct3m+60Dg+FLhzN8iLdI8m
 BQsyCTf5GnqzDTJVDXTAfEv7DFt/yzQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-leRcPeu5PA6Wh-LXMv7sAw-1; Thu, 23 Oct 2025 12:17:01 -0400
X-MC-Unique: leRcPeu5PA6Wh-LXMv7sAw-1
X-Mimecast-MFC-AGG-ID: leRcPeu5PA6Wh-LXMv7sAw_1761236221
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-7848168dffaso11266677b3.2
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 09:17:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761236220; x=1761841020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KD3gwizD3hGZK/AzUEZJ3OZsksNKF5sDZP18KcplOw4=;
 b=JG5n4Jyd7wuxWtkZ+h9VgBqr0Inv2tqQCB/Hry4WWfZ2a5lU32x0keVLkA0lu8EatD
 qzXuyxVjUqBjvlbDZwrV0zZ2XOBw9LVExgUqOFWkmxbgMBtC4W1JjqP+GJZbGzYaHjwY
 4P0j44GaVf8QJ4C5Pw6qjgpxKvfwqDRGNkLq2D6QgrIGhg3jsWeS3Wvpig4B54dMNaFD
 QpkFfDSpSGiiarTd+fMjgxMDiLazb1PbU0B8msuTYBD8LMUUrXbB5C/UC4h2jHuSInep
 C0skDJ8Cm5Ds6cCgYrZPmNN4ldktKyzYLzMHiyRxWoGeZ4gsLfxbu5cCBuybx+QgbWWs
 WxQg==
X-Gm-Message-State: AOJu0YzSjxw1UXUzpeKDYjQXh23MbDXxoM8MSLV+v3zpXgtJ8IKbMW0a
 pnlnZ4nI0MMQ5/qVsqbeEvICGhgH6QTtP6QtX6/zayuL97LErE93xytWs23gW0LmERvahHjVYfE
 FxzA0O2gKRx/wYevnj2oQNdi8zFPq249Z71bBWrSPmqChWuCOHKR8ycnLh42azHmbWGadkGWG+d
 c/Bk62VZg1kWZ6JgOeyaxL8tHHLNi1rqEojKUedQ==
X-Gm-Gg: ASbGncvNAQ1FnjteFwsfvXuH3X4UWLSTONuWpmytYnsBfJeTuZVE2JcwkyMXSzgzl9A
 Gz5JCEdAGpaP5RO/im2CVgJ03jvS97+pvVkGKHOI2Jl5qRhVHihMLEGgTrqzj297gBInto9JYug
 9RZw4Id5txIV9AHccgEvFaanC263CBelJk8pWW0FllkvCCtRKXhlvZxEI3/1wqwqOp17VPHLrD+
 9hWvhNDu+TAXdawfO5CxqovnLQVT2sUe9UkFMz/OyS0XQ/NgVrBktF6FMwUxtDfYIYOMiYis5/B
 NAxw/B9cGnKsCXGYG2R+ALGnuEJdD7DxvWo7KxrgXnez+ucLhi9VaXi+LYfAJ4ap
X-Received: by 2002:a05:690c:6f05:b0:781:465e:c346 with SMTP id
 00721157ae682-7836d30e7fbmr201089807b3.37.1761236220590; 
 Thu, 23 Oct 2025 09:17:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSxDPCoDKYKlhrf8YB+W+8cIGU2CnzCC1f/AAHujMzLtNJzvsAOvI0kNY2BRw7ZgwBm/UyTA==
X-Received: by 2002:a05:690c:6f05:b0:781:465e:c346 with SMTP id
 00721157ae682-7836d30e7fbmr201089497b3.37.1761236220060; 
 Thu, 23 Oct 2025 09:17:00 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89c1254676esm186087085a.57.2025.10.23.09.16.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Oct 2025 09:16:59 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH] migration/cpr: Document obscure usage of g_autofree when
 parse str
Date: Thu, 23 Oct 2025 12:16:57 -0400
Message-ID: <20251023161657.2821652-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

HMP parsing of cpr_exec_command contains an obscure usage of g_autofree.
Provide a document for it to be clear that it's intentional, rather than
memory leaked.

Cc: Dr. David Alan Gilbert <dave@treblig.org>
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-hmp-cmds.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 847d18faaa..79426bf5d7 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -734,6 +734,12 @@ void hmp_migrate_set_parameter(Monitor *mon, const QDict *qdict)
         visit_type_bool(v, param, &p->direct_io, &err);
         break;
     case MIGRATION_PARAMETER_CPR_EXEC_COMMAND: {
+        /*
+         * NOTE: g_autofree will only auto g_free() the strv array when
+         * needed, it will not free the strings within the array. It's
+         * intentional: when strv is set, the ownership of the strings will
+         * always be passed to p->cpr_exec_command via QAPI_LIST_APPEND().
+         */
         g_autofree char **strv = NULL;
         g_autoptr(GError) gerr = NULL;
         strList **tail = &p->cpr_exec_command;
-- 
2.50.1


