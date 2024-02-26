Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55494C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 14:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebht-0003FU-Dt; Mon, 26 Feb 2024 09:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebho-0003ER-VT
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:47 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rebhn-00026p-CP
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 09:11:44 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a437a2a46b1so67995766b.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 06:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708956702; x=1709561502; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYUzkIrd2Io/eKJ09aaUbtIZJEnxRyBXW0AQqqMbZXw=;
 b=impZdyADCj9awrzTG6hDalX5GtWW6MJK/zbfMfW+hovc44OrHI+SnydVQT6bY59fZL
 CUwqtaHlv1Bj2NutnuJEtFaxarEelh9FLSjCDWPN/Mk6RChWtpHJjeI+VQPqVltB69UI
 vqUs9NtnxxpvLHZPooeLL4UQEcy3yqi6swYfoSa05Fy2/xWiFyYbEFANLYHg/ryz91Vj
 AfVUS9NfKNP475sDXmKVvN++nSTKAifLqlMSqOHkJ0xaPQabyCv59nvqbULfXpjWWPBR
 OQs7NAIEGk5PxELcqnvc/gUUg4H4qxh+C9Lt83spOpKMBrQ7b+ErOBY3QwHtWncp+rWn
 JiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708956702; x=1709561502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYUzkIrd2Io/eKJ09aaUbtIZJEnxRyBXW0AQqqMbZXw=;
 b=QGfKY4PvJGVL6txsxZqDoLfjk5aEJFLKjHWh9w1ktMpMXN49DueQN06I6mbslSpWMV
 jfVxh1tyOhxASN/aGsjvDLU220MDt2d9KFKZ8P6UX4xuVyYWM3hYRtGbKlnLlXS9/gLw
 RHQUy28kyvFRWYUrcEL806rzcpUk5jUAmCANfIFdwv1PtBSMAu0UjvdZJt5sVTHlTcUF
 eZHpGMotDVV2vkEBfPa6cTXIqkYa4B3dOJzJ969XoqzJuf4lOH5L9OwVk/8jxTifANBw
 K9TbtwHaIeGUXj7h+an6T9VDUTemiPfK1qFSo7sUVkHjX4WxcNlMFNxSrALz3+MljKVw
 N5/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8qekCCej40zS1RdTQENIFyTwpK2T4iWW/KrEMKj5UCXpGk+x6ZHZd93sv1HA7RGyjOHvaXcxVIxpuoXJAB13WDDSKqeE=
X-Gm-Message-State: AOJu0Yx6yAd3X7oGN0Vse0irluXQdmND7bJV+oVmI0bJRCV85fNfSMsl
 X8uYycCCmiKgRZHuKS0nM563S/sxXly2sRjlzZUkjys+4E4sh4owaaHU7xjxnmY=
X-Google-Smtp-Source: AGHT+IHYfK9hmkc4J6P7Fo51Pp0AOm8ul8y2aewVLJkMTrG1ankM5rND0PGiQl1aPxOqSROblQHjGw==
X-Received: by 2002:a17:906:c30f:b0:a43:8f7e:4249 with SMTP id
 s15-20020a170906c30f00b00a438f7e4249mr201861ejz.72.1708956701849; 
 Mon, 26 Feb 2024 06:11:41 -0800 (PST)
Received: from m1x-phil.lan ([176.187.223.153])
 by smtp.gmail.com with ESMTPSA id
 ty6-20020a170907c70600b00a4354b9893csm892192ejc.74.2024.02.26.06.11.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 06:11:41 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Steve Sistare <steven.sistare@oracle.com>
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v6 5/5] migration: simplify exec migration functions
Date: Mon, 26 Feb 2024 15:11:07 +0100
Message-ID: <20240226141108.73664-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226141108.73664-1-philmd@linaro.org>
References: <20240226141108.73664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Steve Sistare <steven.sistare@oracle.com>

Simplify the exec migration code by using list utility functions.

As a side effect, this also fixes a minor memory leak.  On function return,
"g_auto(GStrv) argv" frees argv and each element, which is wrong, because
the function does not own the individual elements.  To compensate, the code
uses g_steal_pointer which NULLs argv and prevents the destructor from
running, but argv is leaked.

Fixes: cbab4face57b ("migration: convert exec backend ...")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <1708638470-114846-6-git-send-email-steven.sistare@oracle.com>
---
 migration/exec.c | 57 +++++++-----------------------------------------
 1 file changed, 8 insertions(+), 49 deletions(-)

diff --git a/migration/exec.c b/migration/exec.c
index 47d2f3b8fb..15184096ac 100644
--- a/migration/exec.c
+++ b/migration/exec.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/strList.h"
 #include "channel.h"
 #include "exec.h"
 #include "migration.h"
@@ -39,51 +40,16 @@ const char *exec_get_cmd_path(void)
 }
 #endif
 
-/* provides the length of strList */
-static int
-str_list_length(strList *list)
-{
-    int len = 0;
-    strList *elem;
-
-    for (elem = list; elem != NULL; elem = elem->next) {
-        len++;
-    }
-
-    return len;
-}
-
-static void
-init_exec_array(strList *command, char **argv, Error **errp)
-{
-    int i = 0;
-    strList *lst;
-
-    for (lst = command; lst; lst = lst->next) {
-        argv[i++] = lst->value;
-    }
-
-    argv[i] = NULL;
-    return;
-}
-
 void exec_start_outgoing_migration(MigrationState *s, strList *command,
                                    Error **errp)
 {
-    QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    QIOChannel *ioc = NULL;
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_outgoing(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
@@ -105,19 +71,12 @@ static gboolean exec_accept_incoming_migration(QIOChannel *ioc,
 void exec_start_incoming_migration(strList *command, Error **errp)
 {
     QIOChannel *ioc;
-
-    int length = str_list_length(command);
-    g_auto(GStrv) argv = (char **) g_new0(const char *, length + 1);
-
-    init_exec_array(command, argv, errp);
+    g_auto(GStrv) argv = strv_from_strList(command);
+    const char * const *args = (const char * const *) argv;
     g_autofree char *new_command = g_strjoinv(" ", (char **)argv);
 
     trace_migration_exec_incoming(new_command);
-    ioc = QIO_CHANNEL(
-        qio_channel_command_new_spawn(
-                            (const char * const *) g_steal_pointer(&argv),
-                            O_RDWR,
-                            errp));
+    ioc = QIO_CHANNEL(qio_channel_command_new_spawn(args, O_RDWR, errp));
     if (!ioc) {
         return;
     }
-- 
2.41.0


