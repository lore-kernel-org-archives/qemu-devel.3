Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353C7F8D761
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 17:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDQOS-0005ul-2q; Thu, 16 Apr 2026 13:20:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDQOQ-0005uQ-Iz
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDQOM-00055a-Q8
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 13:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776360033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2z/O6ur1dRQQCyc6S+pH4WdXfjB7pO4l9lwKWBswRU=;
 b=N5zeE3Kfo1q1zSHguV4IpgsD89WAQMiLlIE/CG2FodrBnNFGjagk2EaqEvFM84893HgX49
 gcxnj2O7MK5CV0ZmnvK5A5xnZ0icyFaYkb+WI6R4Hsqx08sScdWbS+LHKddLYDm7FGRUje
 m2K7JT3D8BKegqAXlfsI6jljsAozvz0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-64FTXvBGMDmthlCHgjF-XA-1; Thu, 16 Apr 2026 13:20:32 -0400
X-MC-Unique: 64FTXvBGMDmthlCHgjF-XA-1
X-Mimecast-MFC-AGG-ID: 64FTXvBGMDmthlCHgjF-XA_1776360031
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8d397a12778so2368201485a.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 10:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776360031; x=1776964831; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g2z/O6ur1dRQQCyc6S+pH4WdXfjB7pO4l9lwKWBswRU=;
 b=m7mEKOerg35hwzJN5qZVSA5yS/fVLSFKBgRN1R8g8BCtcj5KqKhCO2xc5ScbkblOaI
 7bU1vmCRbWTW4NBGBPJIBGEz7ezIU0xkOI+QVZNdiDPM+QuYsDTsoSBj2L4Alj/C8YhM
 5lLtKwFbhxhZr9FmjR6G0isnCKaUK3oPcsTGB1bWusuQ/LAyW4UZ5aYG8t3IHtkCr9fy
 2nylADfgwRra8TeAnSfVbe6xjMCX92/YM0mox+ykDeAzCcNknnwhNow1vdBbqqqsI0kg
 QDL2SDRSgDXUD4/VR1tHXTtP4sQQ16twijEqH/gX6xHBEfFI6EcO9ct1qtCHH1JfmHlA
 j3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776360031; x=1776964831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2z/O6ur1dRQQCyc6S+pH4WdXfjB7pO4l9lwKWBswRU=;
 b=S0vEgsurfPgAcdbK+tNyEUXaIMIhJ/3H1WJ8PwmIgYQSEsq1oNIJglbSu89kubkHHZ
 dEmEHQjpmfDHRoXjSyAnqGj76TowG85wEq7N5f3cdFPvUk1eoEanBnyGX4jyz0ZR5aAw
 C0qrSh3gV5QhNjeBpMOAfBP+K490FMx0yz/PEECgH9TL7T4yPJG4AR/vkV8PajhZmlTe
 ZUONnibRR4A7TkW8+JeexeMQmKoELmHGz7sMY2UCg3JzyOr9woLuE7N0Ma7MnHP6Q8/a
 IfXYR67NtJUwhGkrPoBuUqIoob9AFdqWDgo2kj1kravS9NT5uTRaFyHb0Is4vAal3dsu
 Ynlg==
X-Gm-Message-State: AOJu0YwfpP9mFUJfYh/2bvONPzmQ3MNA40d4WemRYqVN4Ol37X3MMlaC
 ccKwQjwsfKkLgwodepHtZahXhoOix3NsOvbStF9kBu21REdYu3Y4VFghuy4kN9shzCU7XuZApxT
 KzjCxIShClSNHcoMHPCdIuQGdf7vxeDeKgGqUYX3s1rPaveXBMZFytj7c
X-Gm-Gg: AeBDieuc3O0MUxEA39we/AgqXBG5mFZBJ1CIFzuy3R0CRzAidf3io+l55hurpUp9thH
 eoqJ8fKfmE4pf6Yxn/cZSSlwR4GeLZvTOxL9pcW77lnF+v8K7AappTQ8XQzXms80HBCmsx2g+Te
 Ua1EQZTVks7mCJz/FQ4t9jc6eK/nzUHVGI4Eww+blb9ta09TsP8g4MgHkyeDRzpr20PRnMt+Twi
 bJwt1cz2sRUMW8KjWDG+CL4vsjFPJ02o3RMFeKVNJxmxQdSiWIn409k/PaMP9Yk9KUijVshL3uq
 p0eGj8eMc8B2bASkf0wjlq0bPt68+nKjrDxmnHDfeYHQTwEBm6SExOqKfVgqvyIPq70qyLrt/3+
 v6/lu2Ob8+2vYlRLDKaf3tVVrWwdXQJgWbAbQ37d/CiiBnJiHCtUBo4I8LQ==
X-Received: by 2002:a05:620a:4146:b0:8d9:4e4a:94ff with SMTP id
 af79cd13be357-8e74b2bbeb7mr36198185a.37.1776360031163; 
 Thu, 16 Apr 2026 10:20:31 -0700 (PDT)
X-Received: by 2002:a05:620a:4146:b0:8d9:4e4a:94ff with SMTP id
 af79cd13be357-8e74b2bbeb7mr36192185a.37.1776360030635; 
 Thu, 16 Apr 2026 10:20:30 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e4f243f1fbsm390941485a.31.2026.04.16.10.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 10:20:29 -0700 (PDT)
Date: Thu, 16 Apr 2026 13:20:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>, Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 06/14] migration: Introduce stopcopy_bytes in
 save_query_pending()
Message-ID: <aeEaXLXGokjjODKR@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-7-peterx@redhat.com>
 <adfhtgEeWtsMxEmv@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adfhtgEeWtsMxEmv@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 09, 2026 at 07:36:51PM +0200, Juraj Marcin wrote:
> Hi Peter,
> 
> actually, I do have one question, see inline

[...]

> shouldn't also the condition that triggers postcopy migration be updated?
> As total_bytes is calculated as sum of all three
> (precopy_bytes + stopcopy_bytes + postcopy_bytes), this implies to me
> that stopcopy_bytes is not subset of precopy_bytes and would also need
> to be migrated during switchover before postcopy.

For now it shouldn't matter when VFIO never works with postcpoy yet, but
it's a good point. We'd better make it right from the start.

When looking at this, I also found we may be reporting wrong things in the
query results when pmem is available on postcopy bits, it's about when this
hits:

static bool ram_has_postcopy(void *opaque)
{
    RAMBlock *rb;
    RAMBLOCK_FOREACH_NOT_IGNORED(rb) {
        if (ram_block_is_pmem(rb)) {
            info_report("Block: %s, host: %p is a nvdimm memory, postcopy"
                         "is not supported now!", rb->idstr, rb->host);
            return false;
        }
    }

    return migrate_postcopy_ram();
}

So I think we should also report differently based on whether pmem is
present in ramblocks.. IOW, I think the module should make sure its
save_query_pending() to match its has_postcopy() when they're both present.
Or, maybe we don't even need has_postcopy()..

If it's a problem, it should be an old problem.  Let me address the
comments so far on this patch, so a fixup planned to be squashed (I also
added the trace parameter Avihai requested), feel free to comment before I
repost, thanks.

From 594b85b66b2d1abd9a38fae4051e01ffc73aa8ff Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Apr 2026 13:09:16 -0400
Subject: [PATCH] fixup! migration: Introduce stopcopy_bytes in
 save_query_pending()

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c  | 13 +++++++++++--
 migration/savevm.c     |  3 ++-
 migration/trace-events |  2 +-
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index c2aa145106..62299ff3c0 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3276,6 +3276,16 @@ static void migration_iteration_go_next(MigPendingData *pending)
     }
 }
 
+static bool postcopy_should_start(MigrationState *s, MigPendingData *pending)
+{
+    /* If postcopy's switchver will violate user specified downtime, stop */
+    if (pending->precopy_bytes + pending->stopcopy_bytes > s->threshold_size) {
+        return false;
+    }
+
+    return qatomic_read(&s->start_postcopy);
+}
+
 /*
  * Return true if continue to the next iteration directly, false
  * otherwise.
@@ -3323,8 +3333,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
         }
 
         /* Should we switch to postcopy now? */
-        if (pending.precopy_bytes <= s->threshold_size &&
-            can_switchover && qatomic_read(&s->start_postcopy)) {
+        if (can_switchover && postcopy_should_start(s, &pending)) {
             if (postcopy_start(s, &local_err)) {
                 migrate_error_propagate(s, error_copy(local_err));
                 error_report_err(local_err);
diff --git a/migration/savevm.c b/migration/savevm.c
index 1d3fce45b9..7f38be0ee1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1804,7 +1804,8 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
 
     trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
                                     pending->stopcopy_bytes,
-                                    pending->postcopy_bytes);
+                                    pending->postcopy_bytes,
+                                    pending->total_bytes);
 }
 
 void qemu_savevm_state_cleanup(MigrationState *s)
diff --git a/migration/trace-events b/migration/trace-events
index 2f86ad448e..d2134af862 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -7,7 +7,7 @@ qemu_loadvm_state_section_partend(uint32_t section_id) "%u"
 qemu_loadvm_state_post_main(int ret) "%d"
 qemu_loadvm_state_section_startfull(uint32_t section_id, const char *idstr, uint32_t instance_id, uint32_t version_id) "%u(%s) %u %u"
 qemu_savevm_send_packaged(void) ""
-qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64
+qemu_savevm_query_pending(bool exact, uint64_t precopy, uint64_t stopcopy, uint64_t postcopy, uint64_t total) "exact=%d, precopy=%"PRIu64", stopcopy=%"PRIu64", postcopy=%"PRIu64", total=%"PRIu64
 loadvm_state_switchover_ack_needed(unsigned int switchover_ack_pending_num) "Switchover ack pending num=%u"
 loadvm_state_setup(void) ""
 loadvm_state_cleanup(void) ""
-- 
2.53.0


-- 
Peter Xu


