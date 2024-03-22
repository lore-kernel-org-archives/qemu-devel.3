Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52071C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 14:54:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rngGr-0007Ki-Ou; Fri, 22 Mar 2024 10:53:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rngGf-0007I4-Ad
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:53:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rngGd-0005Fc-6e
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 10:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711119189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7n7PuZV2/93N+zK5VFTJkGxWNzTWQ3HcuWp4pnh1fvE=;
 b=WHod4N8kg4P4Etyw9PChyi6lUIPd7nI34oanFHG9AqvH8cJIZAaqXY9yLER2p9kGDUvR3P
 keGzpJwXD1OmfgicA0B4r1OlJ9hHq6V/o9PEXBRFCatXo9VMH3NqGNckWMrt7imyyfudZZ
 T3OEIKhmuTAEiSqwWWNvqvb+z/xIt3w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-KT3DSMVbOfWLhBY8RtgL-Q-1; Fri, 22 Mar 2024 10:53:07 -0400
X-MC-Unique: KT3DSMVbOfWLhBY8RtgL-Q-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7830635331bso53461585a.1
 for <qemu-devel@nongnu.org>; Fri, 22 Mar 2024 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711119187; x=1711723987;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7n7PuZV2/93N+zK5VFTJkGxWNzTWQ3HcuWp4pnh1fvE=;
 b=IGzOtbqhcV+bQjT0p/G78pKKFOQU1Ik5tQvcfz3hOrkTXAxzNW2Cf1FO4C5C7HkHZ9
 JX3wHWBZfsLnSu82KV/NOcihiAG/txr7+vcXNvfs3mKcrU/OkpZM/UZyGYUF+t3Izy2x
 /rUl/TzO5LLuBb0eFoGU2k4yBJeV0r3RxQwp2CkMMT+BpkzwD12J5/vs41f1bD3/ooAs
 UuE4acauS0ZG0xrHkkJbxogT1Sy6Y0G5UaB8zBkfZk3w87Sjf6bAnWz0XZf5rPvcz7WQ
 CNTfajFWAa/0FG9B4AKxRnLjJQIOkp8z7s5ghJW9+8jSnksPR8w25Tw6UDRz7iM2bqjZ
 Pisw==
X-Gm-Message-State: AOJu0YwKGvrqOiB305NCb4HZdKYpyyedAiJ14xPAkJ1jIdNfdi1n+OmD
 /4hkTt/tI4curwNyw76HUFd6Gzc8NTw6+nPZO51s+Qy+5HS0DxIN9nurreStkL0oD9XJz1pioFB
 gWOyjrbxZbMgzXaav0RCTWAy1AFimOSXSc0pz9oCuswTq0nqmKWsiOvD72XreW5EzP2dh/+WCoa
 qD7wlRRRIEUgOEQ9ePWsu98kg54RtYcUmW1g==
X-Received: by 2002:a05:620a:1653:b0:789:e743:dbf4 with SMTP id
 c19-20020a05620a165300b00789e743dbf4mr2453965qko.2.1711119186719; 
 Fri, 22 Mar 2024 07:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmu6dn8LEidR1RXCgRyv8bop+6sBsya94OPUuuaMIF0NIVoEEnfiB57cyUqmBtl9uCi0f+5A==
X-Received: by 2002:a05:620a:1653:b0:789:e743:dbf4 with SMTP id
 c19-20020a05620a165300b00789e743dbf4mr2453929qko.2.1711119186030; 
 Fri, 22 Mar 2024 07:53:06 -0700 (PDT)
Received: from x1n ([99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 z21-20020a05620a101500b00789ecd8e2absm822103qkj.5.2024.03.22.07.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Mar 2024 07:53:05 -0700 (PDT)
Date: Fri, 22 Mar 2024 10:53:03 -0400
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH] migration/postcopy: Fix high frequency sync
Message-ID: <Zf2bT3q5ThxXQvD4@x1n>
References: <20240320214453.584374-1-peterx@redhat.com> <ZfxeUDcS8OswQht_@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZfxeUDcS8OswQht_@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 21, 2024 at 12:20:32PM -0400, Peter Xu wrote:
> On Wed, Mar 20, 2024 at 05:44:53PM -0400, peterx@redhat.com wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > On current code base I can observe extremely high sync count during
> > precopy, as long as one enables postcopy-ram=on before switchover to
> > postcopy.
> > 
> > To provide some context of when we decide to do a full sync: we check
> > must_precopy (which implies "data must be sent during precopy phase"), and
> > as long as it is lower than the threshold size we calculated (out of
> > bandwidth and expected downtime) we will kick off the slow sync.
> > 
> > However, when postcopy is enabled (even if still during precopy phase), RAM
> > only reports all pages as can_postcopy, and report must_precopy==0.  Then
> > "must_precopy <= threshold_size" mostly always triggers and enforces a slow
> > sync for every call to migration_iteration_run() when postcopy is enabled
> > even if not used.  That is insane.
> > 
> > It turns out it was a regress bug introduced in the previous refactoring in
> > QEMU 8.0 in late 2022. Fix this by checking the whole RAM size rather than
> > must_precopy, like before.  Not copy stable yet as many things changed, and
> > even if this should be a major performance regression, no functional change
> > has observed (and that's also probably why nobody found it).  I only notice
> > this when looking for another bug reported by Nina.
> > 
> > When at it, cleanup a little bit on the lines around.
> > 
> > Cc: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> > Fixes: c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> queued for 9.0-rc1.

When I was testing today on an old 8.2.0 binary I found that it's actually
working all fine..

It's because 28ef5339c3 ("migration: fix ram_state_pending_exact()")
actually fixed exactly the same issue, though that was a partial fix, which
I'll consider it as a "workaround" (because it only fixed RAM, while the
issue lies in the core calculations), which was overlooked in the cleanup
patch I did..  This patch should provide the complete fix.  I didn't check
whether other iterators can be affected, though.

To make it clearer, I'll change the Fixes to point to my cleanup patch, as
that's indeed the first commit to expose this issue again at least for a
generic postcopy use case (aka, my fault to break it..).  Then it also
means stable branches are all fine.  I also rewrote the commit log.
Attaching the updated version here just for reference (no code changes).

====8<====
From 32e3146be16fef9d0fe7b0818265c9d07bb51de3 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Wed, 20 Mar 2024 17:44:53 -0400
Subject: [PATCH] migration/postcopy: Fix high frequency sync

With current code base I can observe extremely high sync count during
precopy, as long as one enables postcopy-ram=on before switchover to
postcopy.

To provide some context of when QEMU decides to do a full sync: it checks
must_precopy (which implies "data must be sent during precopy phase"), and
as long as it is lower than the threshold size we calculated (out of
bandwidth and expected downtime) QEMU will kick off the slow/exact sync.

However, when postcopy is enabled (even if still during precopy phase), RAM
only reports all pages as can_postcopy, and report must_precopy==0.  Then
"must_precopy <= threshold_size" mostly always triggers and enforces a slow
sync for every call to migration_iteration_run() when postcopy is enabled
even if not used.  That is insane.

It turns out it was a regress bug introduced in the previous refactoring in
8.0 as reported by Nina [1]:

  (a) c8df4a7aef ("migration: Split save_live_pending() into state_pending_*")

Then a workaround patch is applied at the end of release (8.0-rc4) to fix it:

  (b) 28ef5339c3 ("migration: fix ram_state_pending_exact()")

However that "workaround" was overlooked when during the cleanup in this
9.0 release in this commit..

  (c) b0504edd40 ("migration: Drop unnecessary check in ram's pending_exact()")

Then the issue was re-exposed as reported by Nina [1].

The problem with (b) is that it only fixed the case for RAM, rather than
all the rest of iterators.  Here a slow sync should only be required if all
dirty data (precopy+postcopy) is less than the threshold_size that QEMU
calculated.  It is even debatable whether a sync is needed when switched to
postcopy.  Currently ram_state_pending_exact() will be mostly noop if
switched to postcopy, and that logic seems to apply too for all the rest of
iterators, as sync dirty bitmap during a postcopy doesn't make much sense.
However let's leave such change for later, as we're in rc phase.

So rather than reusing commit (b), this patch provides the complete fix for
all iterators.  When at it, cleanup a little bit on the lines around.

[1] https://gitlab.com/qemu-project/qemu/-/issues/1565

Reported-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Fixes: b0504edd40 ("migration: Drop unnecessary check in ram's pending_exact()")
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240320214453.584374-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 047b6b49cf..9fe8fd2afd 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3199,17 +3199,16 @@ typedef enum {
  */
 static MigIterateState migration_iteration_run(MigrationState *s)
 {
-    uint64_t must_precopy, can_postcopy;
+    uint64_t must_precopy, can_postcopy, pending_size;
     Error *local_err = NULL;
     bool in_postcopy = s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE;
     bool can_switchover = migration_can_switchover(s);
 
     qemu_savevm_state_pending_estimate(&must_precopy, &can_postcopy);
-    uint64_t pending_size = must_precopy + can_postcopy;
-
+    pending_size = must_precopy + can_postcopy;
     trace_migrate_pending_estimate(pending_size, must_precopy, can_postcopy);
 
-    if (must_precopy <= s->threshold_size) {
+    if (pending_size < s->threshold_size) {
         qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
         pending_size = must_precopy + can_postcopy;
         trace_migrate_pending_exact(pending_size, must_precopy, can_postcopy);
-- 
2.44.0


-- 
Peter Xu


