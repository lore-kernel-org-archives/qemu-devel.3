Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1BAC55171
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2026 02:38:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpzbf-0001ID-24; Fri, 31 Jul 2026 22:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbS-00019w-Of
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:37 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aadeshveer07@gmail.com>)
 id 1wpzbR-0002WO-BA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 22:37:34 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2cc7e86e7aeso16496815ad.2
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 19:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785551851; x=1786156651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=izV0tyTtzE48mde8fpzOje+esPQ2rX0ju3Y/H4E2rGw=;
 b=XpM8hZraKEOItVFw4KNMOoxGOrFkVZAWw/zKdbi5ZL+e2fa60vdRik6KpdyVMlKiFp
 PHgwwQibP22oRIrdLTHoOFNW7EQYb7FosPb+D3knvIoY+cIUAmECRv7w6bN0/3n5mKRf
 cA8v20rjY2C8UGgvKc++VrgrTBrVYxJNHXEfCvVNaiacQo7P/AIUWmrS1oyt8IVhhvyL
 uQ2DcGYzIIV142XZLy44tWYdmWU+wl026QogGe78G1Pg23SA7H60CnXNC+lYw6cvlijQ
 9pwfarPzIcQMgvuogtUIJj/aIfqzf0ABcxzqxFjjhGY7zUECdhieHggGGw3zhgWA8WsJ
 A8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785551851; x=1786156651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=izV0tyTtzE48mde8fpzOje+esPQ2rX0ju3Y/H4E2rGw=;
 b=JeaDFo4TsrNF+kbzsExh5cLrStz2crM68CblzI3NUAf/Fu3klUUZVXTCjo+H1xBYN0
 kHKkDsTq0uhiE0t7ApnFehSVcTzpO9oPKd8Qt5kchix1xnsiv+YQhkYQCKGOD5WNMsX7
 h6V6V2r6tK1O3mKNqCQlkTbmc9a9HttMXicQEWXpgIzTUM/n0jgWlPRKA/DEQ7tHxixV
 vE05Ng932jp5PiOzmnsM8CJ1A3pimAI7WMwq7UKlFeyQTwnUIHbuSfu2H8pa/STcVorK
 c2ds2jEQajFAh+KaLK+iEgq4n+6mtr78TYKFJ2GXU52Ea5x7kiEnALWaAa5xnupYmkQk
 7lHg==
X-Gm-Message-State: AOJu0YzRByNOAxpHlr5nxI+29//Jr92Pk7y98LpJWN6799PRj+OVkLoC
 JBEMDsEq+AGzSq+X73VeGE5Jba4JEX8w0Yw+/B1Bps1i0bLcUnoQWzmcuYx/K4wt
X-Gm-Gg: AR+sD10fQtBk4Q8aR8l9LjdzkaTFo7ObMs6dWCz7xpYpf6MEZzbOGJcp5G0/zK1OIoK
 1jUZKju7g+xEaRlQ314pZK08xfgOp6zYfse7nZWP36O+yAgk2KfcOr7LLGrcCwhBNT3Ji+Zl03o
 MNnhR+j0vz9UYQ0/FvQP/pczSfyXxmGCjYOYHURMrH42Dn4BtalP24zEvAKXeE9BZjSL8nxubVD
 RSklbehmvMwisHZNGUhA/29vGoEzUMm3VaArgt077b5k+EYnHDPOojRWHuh5PAhZFAANRfwUYm3
 qjOntxyQfVIklXOQ5qf918TV9oVS4uD/4SYBjXYrm9nQFtiHj682HDqDyhMSlTQ9JDgHt2mVkdE
 4ioqEEmNlwAnSYRkZkeyOWHWNMNfI5FwOCYex06BMQSGe4iQImYD2Zz0snJOHr7mieWCzXsM9LK
 7+2E1ONvUIL/Cp3/eBMKf1A8hEPmcrpmg41icSBw0YiRav9q+zGEfCUUanZg+LFlgwX7Jc1k9hn
 ng4fAL8B5wpORd6XQ==
X-Received: by 2002:a05:6a21:111:b0:3c8:e313:8d2a with SMTP id
 adf61e73a8af0-3c92a9c70dfmr1833690637.43.1785551851065; 
 Fri, 31 Jul 2026 19:37:31 -0700 (PDT)
Received: from setun ([223.228.61.127]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153dd4e47dsm15678889eec.3.2026.07.31.19.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 19:37:30 -0700 (PDT)
From: Aadeshveer Singh <aadeshveer07@gmail.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, pbonzini@redhat.com, philmd@mailo.com,
 lvivier@redhat.com, ayoub@saferwall.com, pierrick.bouvier@oss.qualcomm.com,
 Aadeshveer Singh <aadeshveer07@gmail.com>
Subject: [PATCH v4 03/11] migration: Rename postcopy_listen_thread_bh
Date: Sat,  1 Aug 2026 08:06:20 +0530
Message-ID: <20260801023628.22665-4-aadeshveer07@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260801023628.22665-1-aadeshveer07@gmail.com>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=aadeshveer07@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rename postcopy_listen_thread_bh to postcopy_incoming_complete_bh for a
more robust naming scheme. This will allow fast snapshot load to use
this bh funciton directly to cleanup the incoming state.

Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 4b8f882e1e..2e2c9fae10 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2103,7 +2103,7 @@ bool postcopy_is_paused(MigrationStatus status)
         status == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP;
 }
 
-static void postcopy_listen_thread_bh(void *opaque)
+static void postcopy_incoming_complete_bh(void *opaque)
 {
     MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
@@ -2211,7 +2211,7 @@ out:
     rcu_unregister_thread();
     postcopy_state_set(POSTCOPY_INCOMING_END);
 
-    migration_bh_schedule(postcopy_listen_thread_bh, NULL);
+    migration_bh_schedule(postcopy_incoming_complete_bh, NULL);
 
     object_unref(OBJECT(migr));
 
-- 
2.55.0


