Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB0BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 12:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFBap-0002Ss-43; Wed, 14 May 2025 08:52:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFBal-0002SS-Hk
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:52:12 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1uFBag-0007Ej-Pi
 for qemu-devel@nongnu.org; Wed, 14 May 2025 08:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
 :Subject; bh=B3E2JSocqCqYXDyRA6TovwjUWmZcV/Gq3FxDvfzoWR8=; b=Xxpzb2Y4kxgTdLei
 Z0CCWqOAH/qkwWBBxf/BFytV6FIef8QpH+N3em0CNHs2Yqud85pN4nlbHTK9/j7O08aP5OD2IAY+a
 aHJF1a8E3UaC/OkpfeoXs4AcWw+pIJmONZqC5tPhqCoewGDTylwlXZj6QVxUjU+9mBQlwkmHP4wwo
 eXrQGr6NREMHRGOgu1AEhrehxWH8Z/SBab4xZe+XGC/yAt7mBJ0p0NAILDq++XZ2oqioqWpfFDZ19
 ToEZRrGKQqvO362qOn65QRx5hg21TuE1eEtVTqdzRLsGK+Ui8Ng6dp+VqB3c3aFt4jAfu1EgR4dgA
 538sp9uK6VVSDv9r3Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
 (envelope-from <dg@treblig.org>) id 1uFBab-003VvO-1O;
 Wed, 14 May 2025 12:52:01 +0000
Date: Wed, 14 May 2025 12:52:01 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Prasad Pandit <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 1/3] migration: Allow caps to be set when preempt or
 multifd cap enabled
Message-ID: <aCSR8URGirnb8SX-@gallifrey>
References: <20250513220923.518025-1-peterx@redhat.com>
 <20250513220923.518025-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20250513220923.518025-2-peterx@redhat.com>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 12:51:53 up 16 days, 21:05, 1 user, load average: 0.01, 0.02, 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

* Peter Xu (peterx@redhat.com) wrote:
> With commit 82137e6c8c ("migration: enforce multifd and postcopy preempt to
> be set before incoming"), and if postcopy preempt / multifd is enabled, one
> cannot setup any capability because these checks would always fail.
> 
> (qemu) migrate_set_capability xbzrle off
> Error: Postcopy preempt must be set before incoming starts
> 
> To fix it, check existing cap and only raise an error if the specific cap
> changed.
> 
> Fixes: 82137e6c8c ("migration: enforce multifd and postcopy preempt to be set before incoming")
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

> ---
>  migration/options.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/migration/options.c b/migration/options.c
> index 3fcd577cd7..162c72cda4 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -568,7 +568,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>              return false;
>          }
>  
> -        if (migrate_incoming_started()) {
> +        if (!migrate_postcopy_preempt() && migrate_incoming_started()) {
>              error_setg(errp,
>                         "Postcopy preempt must be set before incoming starts");
>              return false;
> @@ -576,7 +576,7 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>      }
>  
>      if (new_caps[MIGRATION_CAPABILITY_MULTIFD]) {
> -        if (migrate_incoming_started()) {
> +        if (!migrate_multifd() && migrate_incoming_started()) {
>              error_setg(errp, "Multifd must be set before incoming starts");
>              return false;
>          }
> -- 
> 2.49.0
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

