Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA98606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 18:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=COMGbBBA;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=fg8CwWNR
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIryv-0006VI-AS; Mon, 19 Oct 2026 14:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIrye-0006PJ-M5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1xIryd-0005p7-0d
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 14:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792434050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmurfuTPfJ0EHYQXXF9xVLYCuMVwZUNsvrJgFo3xhfs=;
 b=COMGbBBA0cYPOVMyquOd792Ek6bCejncjxhydBj+2/gGwwW7XzauiznGUUFlK08cVA0OvD
 nHP0e+C54da1q33XFRMqy9GFd0S+RZOEW80MNaK0sKOXxUkrt2GQJCKV0uo7KwfDKPc4lr
 L6ObgcJ3IdOctBpVTkJqribVcivTGes=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-YYFehmVKOkS0yaQFQg1zsg-1; Mon, 19 Oct 2026 18:20:48 +0000
X-MC-Unique: YYFehmVKOkS0yaQFQg1zsg-1
X-Mimecast-MFC-AGG-ID: YYFehmVKOkS0yaQFQg1zsg_1792434048
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a01d1fb07bso27374365e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 11:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792434048; x=1793038848; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EmurfuTPfJ0EHYQXXF9xVLYCuMVwZUNsvrJgFo3xhfs=;
 b=fg8CwWNRRLDYxVieHIYhtTmbFQjaHCicD7B06OCnDFmpsnOEzbCD2x3I6Av8RcM8FF
 VL/f9dOA4V66WP3BaGMlEAJfx1tgrdgjxsPXOGXRj0bAqIFl+GTCRZlcTVr1P3L/xrXu
 Ld1lEJVcQnxk0sRFJYXJCgmtDEesehsvt+XhiHeaUb+MwERS7moFp0XR2RcByW6Wl4Z6
 wdMetew49lUgDHdiz2899F3BI08ds35Jabc3NUwi7GgIw+cgz90u3UuFi22iHNoSueUp
 66CDwuSnUbnTScU8bM8/5oRSzmIU1aEY4LlzEBNlpaymcxBZDUPwbDaoIT8v+71KOLcL
 yrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792434048; x=1793038848;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EmurfuTPfJ0EHYQXXF9xVLYCuMVwZUNsvrJgFo3xhfs=;
 b=SRJjINNsbbdCdoxfbjJRfK2nAwO4jWpUm2Vc3IWcQsEVC4Uoy1NPjfuYMzHgOQ6DTr
 nznlu0+k53FePlVt0NEjDuh+e+43q9ys2XL1+3qEuv1FAYB0JR/SlqjTU10DC/F0dxdA
 sRr3wXEQb3JekvZTrZ/+zD2V0EKexyCLeEzlOhHyGhKPEV+iukm23t+IMODm9aiWVDB6
 IZ/lUf2IJUQplyKkk+lPL3zTDRZxcbqcrS4iU+rjCRfecHmcdQx1fz0pDajuTZxtrhGD
 /d6X6h5mdWjP7p1NPZp4/mwVu0GWZL8ZnScqDT/c1JuPMLcC0F7ji1+8Ep42AZMrlISL
 w0CA==
X-Gm-Message-State: AFq9FYIqtILBRdoSLEEvVmrbMqmHHcRV+7bztPDEi/JXR4My/tTzvKtj
 cy8LJO/k1IRsvkpwmfsNaMaSrY/m6SRtxUMZydQbEjyCXB9BWA+HmlTefwoiFwQJvor+y1h2DT5
 GV0SmVUKI1DBPILNgBHi6tB1TNLWtY2N4jwt0s+uhFwqLl3aADp9zCQ2l
X-Gm-Gg: AYBFou19c064gIJ+Ek9ml4cgx9iWuGujUxJnabxktjwn59sFlpziURCHM0ic+AQsE5r
 b1dm5XS9LbXr//yFsat/zPkUubohobiVqcqRbNRZj8pMOe6DSYvZS/69CwfmZZIAXLCTU930zGL
 rur4DU4LMoRJlnpHYtVnj3QCPpYf+Qpz1qwnF+uxGaOSDjpPBrMOxU4D+dGzN+NSzn+wm1uTvPK
 jbX3qgV7juFmCw8IabdJLxtsKrqucQgAE3jYQFSFtRDoejjPmFFE0XXSNKMdmETw3OCGTUozZ00
 KfhzPjnl91dHpg4JPDo3RqB+3nW+IsM4FTno/DOXh1uSv6EGK54BIBzmtRMDLaD0NCTvtHE+Y8Y
 ySt/NBt3KOx1eqGOYvKgOT1st5hCurU+Cys/Y2IJMWGn658EdPhS8A52k
X-Received: by 2002:a05:600c:4503:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a1d7614e56mr196570475e9.18.1792434047367; 
 Mon, 19 Oct 2026 11:20:47 -0700 (PDT)
X-Received: by 2002:a05:600c:4503:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a1d7614e56mr196569955e9.18.1792434046893; 
 Mon, 19 Oct 2026 11:20:46 -0700 (PDT)
Received: from localhost
 (p200300cfd705ccf50633a9a8543b8b67.dip0.t-ipconnect.de.
 [2003:cf:d705:ccf5:633:a9a8:543b:8b67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d6db78csm594439f8f.2.2026.10.19.11.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 11:20:46 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 05/12] qapi/run-state: Add io-hang state
Date: Mon, 19 Oct 2026 20:20:21 +0200
Message-ID: <20261019182028.45305-6-hreitz@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019182028.45305-1-hreitz@redhat.com>
References: <20261019182028.45305-1-hreitz@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This state is similar to io-error, but is not entered on I/O errors but
instead when a request takes longer than a user-defined time (set via
the delay-stop-ns property on a block device, which is not yet available
but will be added by a future patch in this series).

In contrast to other stop states, this state does not drain block
devices.  That is because it is entered only when a request hangs, which
means that draining would be counter-productive.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 qapi/run-state.json |  7 ++++++-
 system/runstate.c   | 25 ++++++++++++++++++-------
 2 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index 8bbd9884087..cf3f43579de 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -53,12 +53,17 @@
 # @colo: guest is paused to save/restore VM state under colo
 #     checkpoint, VM can not get into this state unless colo
 #     capability is enabled for migration.  (since 2.8)
+#
+# @io-hang: An I/O operation has been delayed for too long and the
+#     device is configured to stop the VM when that happens.  In
+#     contrast to other paused states, the VM's block devices will not
+#     be drained when entering this run state.  (since 11.2)
 ##
 { 'enum': 'RunState',
   'data': [ 'debug', 'inmigrate', 'internal-error', 'io-error', 'paused',
             'postmigrate', 'prelaunch', 'finish-migrate', 'restore-vm',
             'running', 'save-vm', 'shutdown', 'suspended', 'watchdog',
-            'guest-panicked', 'colo' ] }
+            'guest-panicked', 'colo', 'io-hang' ] }
 
 ##
 # @ShutdownCause:
diff --git a/system/runstate.c b/system/runstate.c
index 7b3233f77f6..c5b56308735 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -98,6 +98,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_INMIGRATE, RUN_STATE_PRELAUNCH },
     { RUN_STATE_INMIGRATE, RUN_STATE_POSTMIGRATE },
     { RUN_STATE_INMIGRATE, RUN_STATE_COLO },
+    { RUN_STATE_INMIGRATE, RUN_STATE_IO_HANG },
 
     { RUN_STATE_INTERNAL_ERROR, RUN_STATE_PAUSED },
     { RUN_STATE_INTERNAL_ERROR, RUN_STATE_FINISH_MIGRATE },
@@ -135,6 +136,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_SUSPENDED },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_WATCHDOG },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_GUEST_PANICKED },
+    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_IO_HANG },
 
     { RUN_STATE_RESTORE_VM, RUN_STATE_RUNNING },
     { RUN_STATE_RESTORE_VM, RUN_STATE_PRELAUNCH },
@@ -155,6 +157,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_RUNNING, RUN_STATE_WATCHDOG },
     { RUN_STATE_RUNNING, RUN_STATE_GUEST_PANICKED },
     { RUN_STATE_RUNNING, RUN_STATE_COLO},
+    { RUN_STATE_RUNNING, RUN_STATE_IO_HANG },
 
     { RUN_STATE_SAVE_VM, RUN_STATE_RUNNING },
     { RUN_STATE_SAVE_VM, RUN_STATE_SUSPENDED },
@@ -175,6 +178,7 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_SUSPENDED, RUN_STATE_RESTORE_VM },
     { RUN_STATE_SUSPENDED, RUN_STATE_SHUTDOWN },
     { RUN_STATE_SUSPENDED, RUN_STATE_IO_ERROR },
+    { RUN_STATE_SUSPENDED, RUN_STATE_IO_HANG },
 
     { RUN_STATE_WATCHDOG, RUN_STATE_RUNNING },
     { RUN_STATE_WATCHDOG, RUN_STATE_FINISH_MIGRATE },
@@ -185,6 +189,11 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_GUEST_PANICKED, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_GUEST_PANICKED, RUN_STATE_PRELAUNCH },
 
+    { RUN_STATE_IO_HANG, RUN_STATE_RUNNING },
+    { RUN_STATE_IO_HANG, RUN_STATE_FINISH_MIGRATE },
+    { RUN_STATE_IO_HANG, RUN_STATE_PRELAUNCH },
+    { RUN_STATE_IO_HANG, RUN_STATE_SUSPENDED },
+
     { RUN_STATE__MAX, RUN_STATE__MAX },
 };
 
@@ -445,13 +454,15 @@ static int do_vm_stop(RunState state, bool send_stop)
         }
     }
 
-    bdrv_drain_all();
-    /*
-     * Even if vm_state_notify() return failure,
-     * it would be better to flush as before.
-     */
-    ret |= bdrv_flush_all();
-    trace_vm_stop_flush_all(ret);
+    if (state != RUN_STATE_IO_HANG) {
+        bdrv_drain_all();
+        /*
+         * Even if vm_state_notify() return failure,
+         * it would be better to flush as before.
+         */
+        ret |= bdrv_flush_all();
+        trace_vm_stop_flush_all(ret);
+    }
 
     return ret;
 }
-- 
2.55.0


