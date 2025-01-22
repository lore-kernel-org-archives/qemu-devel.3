Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF14C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadmG-0007aT-75; Wed, 22 Jan 2025 11:40:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tadmA-0007Zr-NT
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:40:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tadm6-0003MZ-J7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737564016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s7FXfjhNE42rwKWKgzXOoZyoZvfkqN5Prnao7VTqtss=;
 b=ZebYiKDjJniqXRPa8u26LpByHzkTHNqp1zkElV1F5xNhN2X6dA2K4NO6IJ8yJttLbP+Lax
 AyMI/C7tdHZ1mP2LQGNAdTLJlApnvPQc7JcY8YNtYnPH4DVl/Qh4VmKhyJq8TEc0pScdQO
 xvZuwauLSCyZ3CSQ6YKTmd7YQyXsrg4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-K7q6ByglPGWPLJoOZLLwcg-1; Wed, 22 Jan 2025 11:40:14 -0500
X-MC-Unique: K7q6ByglPGWPLJoOZLLwcg-1
X-Mimecast-MFC-AGG-ID: K7q6ByglPGWPLJoOZLLwcg
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6c6429421so1156906785a.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564013; x=1738168813;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s7FXfjhNE42rwKWKgzXOoZyoZvfkqN5Prnao7VTqtss=;
 b=Q/O9g9c4OxeAi2V+YzejuxxBVSY5b81F/eQ8xbOsks3AgPXKOxPgvsgnjiUrRdu8/y
 EVybi/qUPTEpX+gHSoFnAnuA4noKaKAIn+bwEJy7ZdCEeNadT2IBTmktBv0feqWIUOO0
 4FnlkbpYrnmghezE1kKeiA98aaIh1SAR2k54+SAsriVWTnn5P3Q0VSnp0nxhYrWMop56
 bbv1Ply32jRdhIr2FIpsV5SQO0zqmP08r+vktHE8DM0U1EpdIRrKgYJqId9rC0X5S/wQ
 xsKP1VjUCBNB32ISyNrduEl2gECL1Ynt00em5z9dg9eSYacQaXtTjhoWLuuLzjk6ftgI
 GiGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBTxIHXyFwuQwst6EMF12zblAlHNnPUwHySlvQT2C78B9GUBLHp4rIIDFoD8J5xxuGBipPTG0y2U0Y@nongnu.org
X-Gm-Message-State: AOJu0YyizN9RnLg1h9NLKzhQ2roak3+DCSqP70z5Rph+tikDDziJu0tM
 XA3I0WyfvvgPJCC5Hgj4I2Qg0NwBbxgSFaAG8IB+LxyUeHwoeXAY7hHmAXKUjn07el9Yo9vIEhn
 4NRxHzgZc4r/iWTeiKxe19hhGFa/EPSPnijBjHFPyUbY/QUvq458SJFP0BIyc
X-Gm-Gg: ASbGncvxH+YlbhB3vfmTbpBeSKimqLudx08FUiY9WSmhKQ6pBy0AEuGKJbz6TUZa3di
 pR8DqJL/I9U1A72Fts7ZJFvZkrJ4f4byrMRgcEql1Mfzsrm6CgWeKuDV8yXp3EqNj2tySmg5xOP
 4WormYfSsI7z1ZncHi36KQXzycl8p0ylhw6F4LYkUgUF9FWeZmo6JrPEmOrJkp38MdRlxpTJeJ7
 5gvS+/L0GgUEtNJfDRQN5HjH7c2MMf4dUXpSDLX7tOc6WexsrPYK0ckalGhV+R2sopF9xVO3c6T
 TCIHohywc71zWR3ES3Q3IAv9Q2uEY2I=
X-Received: by 2002:a05:620a:288a:b0:7b6:6d99:ecfc with SMTP id
 af79cd13be357-7be6318ac7amr3300920485a.0.1737564013660; 
 Wed, 22 Jan 2025 08:40:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTto66wpN4Xl4z+TFxOWYxjbdcDmFpIP7PSZD/qwEtr1lDNq0JtCcluPWoNHv+um/PFpnfpA==
X-Received: by 2002:a05:620a:288a:b0:7b6:6d99:ecfc with SMTP id
 af79cd13be357-7be6318ac7amr3300917485a.0.1737564013357; 
 Wed, 22 Jan 2025 08:40:13 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614eee4bsm676589285a.91.2025.01.22.08.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 08:40:12 -0800 (PST)
Date: Wed, 22 Jan 2025 11:40:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Shivam Kumar <shivam.kumar1@nutanix.com>
Cc: Fabiano Rosas <farosas@suse.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] Fix race in live migration failure path
Message-ID: <Z5EfapuXuV7oFL7A@x1n>
References: <20250110100707.4805-1-shivam.kumar1@nutanix.com>
 <87frlqerxp.fsf@suse.de> <Z4U_emPVDfTb1VmF@x1n>
 <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0C92F4E5-56EE-4036-927C-2F06F9F29252@nutanix.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

Hi, Shivam,

On Wed, Jan 22, 2025 at 10:54:17AM +0000, Shivam Kumar wrote:
> There is one place where we set the migration status to FAILED but we don’t set
> s->error, i.e. in save_snapshot workflow, please check qemu_savevm_state but
> not sure setting s->error in this case is possible (or required), as it seems a
> different workflow to me.

Yes it's very different indeed.  I may not yet fully get the challenge on
how switching to s->error (implies FAILING) would affect this one, though.
I mean, in qemu_savevm_state() it tries to fetch qemufile errors with:

    ret = qemu_file_get_error(f);

IIUC we could also try to fetch s->error just like what migration thread
does, and if it sets means it's failing?

> 
> In addition, one potentially real problem that I see is this comment in
> migration_detect_error:
> /*
>  * For postcopy, we allow the network to be down for a
>  * while. After that, it can be continued by a
>  * recovery phase.
>  */
> Let's say if we set s->error at some place and there was a file error on either
> source or destination (qemu_file_get_error_obj_any returns a positive value

This is trivial, but I suppose you meant s/positive/negative/ here.. as
qemufile's last_error should always be negative, iiuc.

> when called by migration_detect_error). We expect migration to fail in this
> case but migration will continue to run since post-copy migration is tolerant
> to file errors?

Yes it can halt at postcopy_pause().  I'm not yet understand why it's an
issue to using s->error, though.

In general, I'm thinking whether we could also check s->error in detect
error path like this:

===8<===
diff --git a/migration/migration.c b/migration/migration.c
index 2d1da917c7..fbd97395e0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3015,17 +3015,17 @@ static MigThrError migration_detect_error(MigrationState *s)
     ret = qemu_file_get_error_obj_any(s->to_dst_file,
                                       s->postcopy_qemufile_src,
                                       &local_error);
-    if (!ret) {
-        /* Everything is fine */
-        assert(!local_error);
-        return MIG_THR_ERR_NONE;
-    }
-
-    if (local_error) {
+    if (ret) {
+        /* Passover qemufile errors to s->error */
+        assert(local_error);
         migrate_set_error(s, local_error);
         error_free(local_error);
     }
 
+    if (!migrate_has_error(s)) {
+        return MIG_THR_ERR_NONE;
+    }
+
     if (state == MIGRATION_STATUS_POSTCOPY_ACTIVE && ret) {
         /*
          * For postcopy, we allow the network to be down for a
@@ -3037,6 +3037,8 @@ static MigThrError migration_detect_error(MigrationState *s)
         /*
          * For precopy (or postcopy with error outside IO), we fail
          * with no time.
+         *
+         * TODO: update FAILED only until the end of migration in BH.
          */
         migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
         trace_migration_thread_file_err();
===8<===

I kept a TODO above, I would hope if you reworked everything to route
errors to s->error, then we can move this to the cleanup BH to avoid the
race.

Do you think that could work?

Thanks,

-- 
Peter Xu


