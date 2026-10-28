Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CC0606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 17:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=K2vUO77Z;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=HQJ8r0fa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM7FB-0006ET-Vn; Wed, 28 Oct 2026 13:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F3-0005o3-0B
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM7F1-0003jE-07
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 13:15:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793207710;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kjrOcUIrh6tbOIuFtEN4gX0rItng5RDIBljnwF3FosI=;
 b=K2vUO77ZwZDjcEi0X4l8T80UiwovQg0HBZ9+xFQZ2WBAhaKJnSMA5wexljQ5gehdm6M3mA
 lOm7G4ZbLulETaFXGhloBtkU3d0k6ylOg5CLl+lB94p6I8F/PYnrvvjd2JB3iB3I3rMZyK
 exkgXa7pdOXDC9w6S+es1Y2rWB9Nw/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-jiCPfCGjNdWjZDxJms5wpg-1; Wed, 28 Oct 2026 13:15:08 -0400
X-MC-Unique: jiCPfCGjNdWjZDxJms5wpg-1
X-Mimecast-MFC-AGG-ID: jiCPfCGjNdWjZDxJms5wpg_1793207707
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a16dc2323cso11056315e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793207707; x=1793812507; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kjrOcUIrh6tbOIuFtEN4gX0rItng5RDIBljnwF3FosI=;
 b=HQJ8r0faMj/suB9qTacD+g3MavQOAG1JNSbPlj7pLFbtei9O5BX0jWy36OGwkRgLO9
 kIQX/qnHtgxt1fiOAMPfxueFmwtEm26MAi05LhmOqK102RgGpmQJgRnuh8l7FeThPqRE
 v8PQaPIH0J40Lu4gjfeA4qW4sFOSRYLCI6cv0v7sMAipNNimjbUYQZjHNVAP1AtUdLmD
 P/QQKcm5hNwIFSHNCALyOD2EPFocwzP6o6+poCpv1Al4zuhM9Jlqbk7beLcLIIOasgts
 49OPUFysZUQVDk04mhzq+JsLoBfzy32kiCAd+7ytSExgVj8VD8PMO8mbrD3hzvtUreOt
 b7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793207707; x=1793812507;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=kjrOcUIrh6tbOIuFtEN4gX0rItng5RDIBljnwF3FosI=;
 b=eQrksDnrks7lFWD+93xIf2T1biF8YpUnIOReyphiNzCVdpXVeGDBoi65/Qo/zaQB57
 alx7WYgdFPDtINDnHTSZUlqT5ANQ1DhTXsDWE41lTssDCIAwGcJ6U1pOUHH8vF5asOZd
 Qy1+tG+sR7Cvo4BWKnOC6oh6vYXnoICr3thWLlJCxgYTiTwldrMMxSrPGrn1EWCEve+W
 sykFSUuBszzijsy8+1u+ojEnCKbRakHf73fUwPSbLwnuIaGQEk814if4ECb0Tghqoaa0
 anpwyKlpT1t2ydvUBYd1WxN4dikXHijPxiXfqWWM7TrVFg5Bki0OyCj/M0XsZF7uN7oO
 WeQA==
X-Gm-Message-State: AFq9FYIgunTaSTqzxD20Wd1jT3sOCrpXLJxzfyA301BiXb6FlQWpxIgR
 MpLVTcZ221yr0/bCrGJ+af6UzzOxcKyoekLiccrvKBvz1MozFdKprosohf3Xrb2Z2O0IKejWatc
 aQR95gPFWQuUFMFsv3/lBR1BpZTTheTdgVXyQNV9ly6zOhJp+1UiR0/yeSKgOfTTVv+DwT/7MLE
 py65UUEkuIohqYu95GPIfR+rQ2pTddHA9ynw==
X-Gm-Gg: AYBFou2lN1l9zUhuP0IRSEBPcmDCOKhGFvh8hXTDzyD8zs6IUFnmGqf/MYGtfw+NoGy
 7MAh0EaC8bnVuIzHXPakqF5JNk4VQp4jkl/C5+EjjXtFkGIWkh7wKjeOsAHs7vcca+DcmNVtI4t
 ACejky7garizihi8nULHTRNfEhGoKP6mHcUpNldl5ptkL4hDhg9yOkD7wDYrC8YRMlnUAGzsLMp
 DsaTUD3ZHL3nrJmdZFokqjQpyKVtYoPUazcPnuU2XEmNn88Zo80S9vg0uhKcjGfr5/pAFsuUpQj
 b4RSMDuR36oPtscgkGURZh5oGIsUbWT5hN6lsHUCa04nN5fCQeexSzPHE+P7mjw5k9VYAfT5Ill
 sU0VcNOCtFz02tHkjwwnEx2qR9NTenEzqEmbsdwVd
X-Received: by 2002:a05:600c:3516:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4a966c4175cmr66811235e9.18.1793207706676; 
 Wed, 28 Oct 2026 10:15:06 -0700 (PDT)
X-Received: by 2002:a05:600c:3516:b0:4a8:cb23:f71b with SMTP id
 5b1f17b1804b1-4a966c4175cmr66809935e9.18.1793207706071; 
 Wed, 28 Oct 2026 10:15:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96a8f28a1sm36060975e9.4.2026.10.28.10.15.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 10:15:05 -0700 (PDT)
Date: Wed, 28 Oct 2026 13:15:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 25/78] migration: add MIG_EVENT_INCOMING_FAILED
Message-ID: <d5527772b0229c4cbd6d7ba6c9b33378ced2920d.1793207602.git.mst@redhat.com>
References: <cover.1793207602.git.mst@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1793207602.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

A device may take over a resource from the source in post_load(), e.g.
vhost-vsock acquires the device ownership on a CPR target.  If the
incoming migration fails afterwards, there's currently no way for the
device to give that resource back before the failure is published, i.e.
before the source is told about it over the return path and resumes, or
the management sees the MIGRATION event on the target and resumes the
source, or the target exits.

Add a migration event for that, sent to the migration notifiers from
the failure path of process_incoming_migration_co() before the failure
is published.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261012-up-vsock-vhost-v5-v16-16-36c38bd15ffc@virtuozzo.com>
---
 include/migration/misc.h |  5 +++++
 migration/migration.c    | 10 ++++++++++
 2 files changed, 15 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 019717f4cd..86cc7eefd6 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -65,12 +65,17 @@ bool migration_thread_is_self(void);
  *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_DONE
  *    - MIG_EVENT_SETUP [-> MIG_EVENT_POSTCOPY_START] -> MIG_EVENT_FAILED
  *    - MIG_EVENT_FAILED
+ *
+ * MIG_EVENT_INCOMING_FAILED is currently the only event sent on the
+ * incoming side, when the incoming migration fails and before the failure
+ * is published.
  */
 typedef enum MigrationEventType {
     MIG_EVENT_SETUP,
     MIG_EVENT_POSTCOPY_START,
     MIG_EVENT_DONE,
     MIG_EVENT_FAILED,
+    MIG_EVENT_INCOMING_FAILED,
     MIG_EVENT_MAX
 } MigrationEventType;
 
diff --git a/migration/migration.c b/migration/migration.c
index fab7949fe1..82a8a25228 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -815,6 +815,16 @@ process_incoming_migration_co(void *opaque)
     goto out;
 
 fail:
+    /*
+     * Allow the devices which have registered their callbacks for
+     * migration target failure to undo the changes they may have
+     * done in post_load().
+     *
+     * Do that before the failure is published in any way: the MIGRATION
+     * event emitted by migrate_set_state() below, the return path (if
+     * present) in migration_incoming_state_destroy(), or the exit().
+     */
+    migration_call_notifiers(MIG_EVENT_INCOMING_FAILED, NULL);
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
                       MIGRATION_STATUS_FAILED);
     migrate_error_propagate(s, local_err);
-- 
MST


