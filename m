Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A543CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 18:34:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqzzL-0007WU-HL; Sun, 31 Mar 2024 14:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzJ-0007W7-GL
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rqzzH-0007Lv-Sb
 for qemu-devel@nongnu.org; Sun, 31 Mar 2024 14:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711909979;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdvcfx+995KAqXrPTvBS9OuqsS4SSCOb7pX7oQH0nBw=;
 b=PXC85ITLE5J5bZyEGj8tyjPjfh6GzxigbIuEXS/2xNgBZOG/IorGhaTUbsOjjB/wtLZv5T
 KHomiLVKJia9AB1lyonEFnWODU1o/tMHU1pGakms7Df+RGeAyVRtGdcx+OcNXqKUgAu2Oy
 qTA2Z1BotkW7i+meAKtwQj6JbushCwg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-uKxnNqp1PXSErTMSCAOAbg-1; Sun, 31 Mar 2024 14:32:55 -0400
X-MC-Unique: uKxnNqp1PXSErTMSCAOAbg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-69672754479so9884846d6.1
 for <qemu-devel@nongnu.org>; Sun, 31 Mar 2024 11:32:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711909975; x=1712514775;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kdvcfx+995KAqXrPTvBS9OuqsS4SSCOb7pX7oQH0nBw=;
 b=mzJvgHba4WYBFs4i8aghPj++MgScbG0iLXsRtYnB8al2QaTNxn7SYUCTk7Er5fNmoq
 /ZmY1YWLhZSVIrpBzrqlzoAMI2FlBGYLmWNh58NUx3FNZvFKSR8Xfw1o8OsAtcMN5r4m
 JSwCgZXExO28LvTUS/NiQfgalkZ4V8FMHtpyoskh1i3B5TuxuDcA+LACVYIQjI5aU/4u
 PtTGZXK3MNTn49rS1ULxfwnC/gqo7Dyq20RZKE34+aHvFVceOmEOCVTiIy/IFfyWYi30
 UdXCH0VEucPOwd+Ljd7iZ3o4T20+yxSHR9Gb9PPlwsEGqWcbuiAssiC7bpd9PgENwPhW
 kK5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpq+dyX3UqlfiR/UL3UxF/iTSnxoN0yxSPFE2bi/iGN5FY9CH8orj7tXq1K76SCKN+4SNlcA1E7lHxqi8b/N8le+xW+TE=
X-Gm-Message-State: AOJu0YyCCh2Hle5GVWHJfHOSy466r0Jjmje0bkCbb4niRRRsy1CF+Bvr
 vBAS6Rn9MUDCHh4mSVaxpYfJCjrhfghNYK6YtZzJxU5CBt926vosm8XJMiDLDMdYoe1k44w99SC
 lSlg24YHf7zQmX0QjVL4RjEg3odyBJSXftPKpOFi/M09wSmyxU0gj
X-Received: by 2002:ad4:5a53:0:b0:691:456f:415a with SMTP id
 ej19-20020ad45a53000000b00691456f415amr7385335qvb.4.1711909975087; 
 Sun, 31 Mar 2024 11:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtpMO1Yxx7e6k5J0CJgBKrjtHX+kCnesg/hWprDTyspfpJsvB3Hc09041AvpZj3V/dSITMFA==
X-Received: by 2002:ad4:5a53:0:b0:691:456f:415a with SMTP id
 ej19-20020ad45a53000000b00691456f415amr7385313qvb.4.1711909974512; 
 Sun, 31 Mar 2024 11:32:54 -0700 (PDT)
Received: from x1n.. ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 u10-20020ad45aaa000000b00696a47179a1sm3748823qvg.14.2024.03.31.11.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 11:32:54 -0700 (PDT)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Avihai Horon <avihaih@nvidia.com>
Subject: [PULL 1/2] migration: Set migration error in migration_completion()
Date: Sun, 31 Mar 2024 14:32:50 -0400
Message-ID: <20240331183251.1045817-2-peterx@redhat.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240331183251.1045817-1-peterx@redhat.com>
References: <20240331183251.1045817-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Avihai Horon <avihaih@nvidia.com>

After commit 9425ef3f990a ("migration: Use migrate_has_error() in
close_return_path_on_source()"), close_return_path_on_source() assumes
that migration error is set if an error occurs during migration.

This may not be true if migration errors in migration_completion(). For
example, if qemu_savevm_state_complete_precopy() errors, migration error
will not be set.

This in turn, will cause a migration hang bug, similar to the bug that
was fixed by commit 22b04245f0d5 ("migration: Join the return path
thread before releasing to_dst_file"), as shutdown() will not be issued
for the return-path channel.

Fix it by ensuring migration error is set in case of error in
migration_completion().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Fixes: 9425ef3f990a ("migration: Use migrate_has_error() in close_return_path_on_source()")
Acked-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/r/20240328140252.16756-2-avihaih@nvidia.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 9fe8fd2afd..b73ae3a72c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2799,6 +2799,7 @@ static void migration_completion(MigrationState *s)
 {
     int ret = 0;
     int current_active_state = s->state;
+    Error *local_err = NULL;
 
     if (s->state == MIGRATION_STATUS_ACTIVE) {
         ret = migration_completion_precopy(s, &current_active_state);
@@ -2832,6 +2833,15 @@ static void migration_completion(MigrationState *s)
     return;
 
 fail:
+    if (qemu_file_get_error_obj(s->to_dst_file, &local_err)) {
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    } else if (ret) {
+        error_setg_errno(&local_err, -ret, "Error in migration completion");
+        migrate_set_error(s, local_err);
+        error_free(local_err);
+    }
+
     migration_completion_failed(s, current_active_state);
 }
 
-- 
2.44.0


