Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1AE606A31E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.a=rsa-sha256 header.s=google header.b=CKN6W6jW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWIiI-0004mG-2W; Wed, 25 Nov 2026 14:31:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIi3-0004eA-5D
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:17 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xWIhz-0001Bd-WF
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 14:31:14 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso4711012f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 11:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1795635066; x=1796239866; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CWTF2fvC/MnpsPQZp3jq+QdltlhQdqrWCGLfbImsjx0=;
 b=CKN6W6jWQ9sMpuDsjWaLOlvqVxxHHuCCOleLZviWW5+iovv5RPifGFT9ji6eQdm8vu
 agz+4jUakznGtTxOBhAcPZAoHXhf41TaOzN/7RldrhiSjpZvuaR33d57zgVK5KMRIDax
 oN6EsdYwdRIzvt12R57VOLVL8x84wq74DctzpCG32jTbwG89AEnGNUJdlA6QwlKFiLKL
 A9mPsp94PMOLx48ThjYWVOEv3mc0QnTUgTfjAEwGCycmfDKBEwBvSPIMoSGaT2EFTFcj
 A8yUb5KFrR+79ppF1+E1qZT/HSlUzG9jlBpXxsMHO465RL/8MSzrJGTVt3nJYZE+R9BK
 DL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795635066; x=1796239866;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CWTF2fvC/MnpsPQZp3jq+QdltlhQdqrWCGLfbImsjx0=;
 b=WDKWI7e+zFsx81vVcC7oK2vZJq41GduSLOWWzXfSMLMSgpo6MN2NF/D+DigJt6XIj6
 if+dbfAfuqoyGNWSU8graBJF/Wc7ArMOt4h+I16Il3S4gI+tpgSP6nwhxX2DEjqq+kCJ
 2m+vVrt3inKAO5TJlklslEky4p98nKDcaeNTn6SYndY7UpwqlXqgK/JIMrHsJjVBv3wB
 lK89smuG2Bx9nQoSFVIEBxdp0y6/+fwtwIBuK34wIChqK1IxbVmU/st7f84FC0qkwaSm
 QMA5W1TJ4U6EwmReAOVE/KUAD5AU0ElV8BxmD+42IC1C4LTBX82fW3cS9FMhOA9CW08i
 p37g==
X-Gm-Message-State: APuU4Z+weJVY/5dUfV2uPCgGuyH9zsYS9HPiHXF6pLPEpdaTLCvoZFbO
 Falk+PFxuAQXJHnQhB89TJaofXkuO8v2BPoczS62osKdfTuYV1lVZW8wxflhioxqpxf35VnjaVi
 w6nI0
X-Gm-Gg: AZFdTZcMWMBUX6MI60+kcIzkMqml7eEdR+baoNqp7WsRQNusNZ/UJMG4beS2n8rhBHd
 TWIUawK6quSSWnzhRYgCbhKsh1kXyUt31/Ec4JdOCxBB4ELb4xxaJCwrEH5ZkmAstXvyxUlImbU
 mHWvt40uFOoORIMVOTKFTrPlay36Zbs2N35yX6/azHtlxV93hRD8MUS/Pu73xagLMYUhF2GnsFq
 2JGLsqGvgiu/wQnt4DTbQxnl3To4/NQJwpuwEZq5S29mfFMRgypPFl7ySixqsy/10YbpzD8JWOA
 1BlCSY/VUVWHvNhlZDGTN4SuWaZXiQkOuglsNGaPjpSIWZ981TcWl2Sbn+fBZTtoIMT52qDdmmM
 Ml4dpgqA9Iw9QcUTDRKWwaU/R+TQ3S7kq9C38DWjnNVFYoscHGS96M+iDpLb7ffvodjvM2Ab6pr
 5saa+19O/Z1Jt12yATD3ivt0F2oBee77cyqW1B3wa2U3tWu9WKNGJjoYcddJe2tmPGe8Q4azWjS
 6zwrdQgMd1kDhHS1oqjl0De2+JLYzXZcKVwW8JbJiH7HsgVQAP/hvBudhGPjeUa8WlPvfZoyYNs
 qSLqXuiHfb2gHHW+wPYBbJZxLm62FGvJN6uAZGtShab5WOzZ
X-Received: by 2002:a05:600c:a087:b0:4a2:5267:3cd4 with SMTP id
 5b1f17b1804b1-4bb887c9fbamr400466305e9.3.1795635065827; 
 Wed, 25 Nov 2026 11:31:05 -0800 (PST)
Received: from artemis.sw.ru ([2a06:5b06:b600:300:73c7:7c5f:a985:743e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm18133069f8f.43.2026.11.25.11.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 11:31:05 -0800 (PST)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] migration: fix source hang on cancel before the channel
 connects
Date: Wed, 25 Nov 2026 20:31:01 +0100
Message-ID: <20261125193102.1423555-2-den@openvz.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125193102.1423555-1-den@openvz.org>
References: <20261125193102.1423555-1-den@openvz.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=den@openvz.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Denis V. Lunev <den@openvz.org>

Cancelling a migration while the source is still connecting to the
destination hangs the source QEMU forever if the connection then
succeeds. It hangs with the BQL held, so the monitor stops answering
too.

When the cancel arrives there is no connection yet and nothing to shut
down. Since 4f08b870f8fd, migration_cancel() only marks the migration as
cancelling and leaves the rest to the code that runs when the connect
completes, and that code finishes the cancel only when the connect
fails.

When the connect succeeds, the migration starts anyway. The return path
thread starts and waits for the destination. The migration thread sees
the cancel and quits. The cleanup then waits for the return path thread
to exit, and that never happens: the destination has nothing to send
and keeps the connection open, and a cancel, unlike a failure, does not
make the cleanup shut the return path down.

Check for the cancel as soon as the connection is up, in
migration_channel_connect_outgoing(), and clean up there before
anything is started. A cancel during the TLS handshake gets there too,
once the handshake is done. migration_cleanup() is no longer static so
that channel.c can call it.

Fixes: 4f08b870f8fd ("migration: Fix crash on second migration when cancel early")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 migration/channel.c   | 6 ++++++
 migration/migration.c | 2 +-
 migration/migration.h | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/channel.c b/migration/channel.c
index 1aeb881485..6e2bf9ad39 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -563,6 +563,12 @@ void migration_channel_connect_outgoing(MigrationState *s, QIOChannel *ioc)
 {
     trace_migration_outgoing_channel_set(ioc, object_get_typename(OBJECT(ioc)));
 
+    /* migration_cancel() leaves a cancel during connect for us to finish */
+    if (s->state == MIGRATION_STATUS_CANCELLING) {
+        migration_cleanup(s);
+        return;
+    }
+
     if (migrate_channel_requires_tls_upgrade(ioc)) {
         Error *local_err = NULL;
 
diff --git a/migration/migration.c b/migration/migration.c
index 5686209ab1..4fc1ca9fd2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1378,7 +1378,7 @@ void migration_cleanup_json_writer(MigrationState *s)
     g_clear_pointer(&s->vmdesc, json_writer_free);
 }
 
-static void migration_cleanup(MigrationState *s)
+void migration_cleanup(MigrationState *s)
 {
     QEMUFile *tmp = NULL;
 
diff --git a/migration/migration.h b/migration/migration.h
index 057c85d611..b3067536cb 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -594,6 +594,7 @@ bool migration_incoming_setup(QIOChannel *ioc, uint8_t channel, Error **errp);
 void migration_outgoing_setup(QIOChannel *ioc);
 
 void migration_connect_error_propagate(MigrationState *s, Error *error);
+void migration_cleanup(MigrationState *s);
 void migrate_error_propagate(MigrationState *s, Error *error);
 bool migrate_has_error(MigrationState *s);
 
-- 
2.55.0


