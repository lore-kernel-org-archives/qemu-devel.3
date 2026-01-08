Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33707D1D460
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrEA-0000vM-Ge; Thu, 08 Jan 2026 09:43:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdrE3-0000uy-1W
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:42:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdrDz-0002jn-Qx
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 09:42:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767883373;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qyYIeyzi3hr3tWTYkOfKT+pJUO3Jqt9iKGwUlkCKDUY=;
 b=Bl9YDWWNDY4xlStHq1iKy86BLkl+pU0iRX1++uFzvBGuIJE8vTVdeZZnHWL1E6fj21oe5W
 LUIlJu/K3syyOnAi5jCHUjGEQkLqCaIr/qT8tPP1sUFQfT6C+XJPkVuyuETxKlQCZlEtUO
 wFVeuKHFOtI3nRdBCxSBO72E+TA9tGc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-lagW5iAqNlusN7BkIEAOHQ-1; Thu,
 08 Jan 2026 09:42:51 -0500
X-MC-Unique: lagW5iAqNlusN7BkIEAOHQ-1
X-Mimecast-MFC-AGG-ID: lagW5iAqNlusN7BkIEAOHQ_1767883370
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3B9F19560B7
 for <qemu-devel@nongnu.org>; Thu,  8 Jan 2026 14:42:50 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.44])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48AE2180066A; Thu,  8 Jan 2026 14:42:49 +0000 (UTC)
Date: Thu, 8 Jan 2026 14:42:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: checkpatch.pl warning on "added, moved or deleted" messed up
Message-ID: <aV_CZYA3KokrT4xh@redhat.com>
References: <87ms2o6z3f.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87ms2o6z3f.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jan 08, 2026 at 01:57:56PM +0100, Markus Armbruster wrote:
> I ran checkpatch on my
> 
>     [PATCH 0/2] migration: Drop deprecated QMP stuff
>     Message-ID: <20260108125512.2234147-1-armbru@redhat.com>
> 
> and got
> 
>     $ scripts/checkpatch.pl --terse *patch
>     0001-migration-Drop-deprecated-QMP-command-query-migratio.patch:290: WARNING: added, moved or deleted file(s):
>     total: 0 errors, 1 warnings, 129 lines checked
> 
> The culprit seems to be commit 1d745e6d963 (scripts/checkpatch: use new
> hook for MAINTAINERS update check).  If I use the version immediately
> preceding it, I get:
> 
>     0001-migration-Drop-deprecated-QMP-command-query-migratio.patch:105: WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>     total: 0 errors, 1 warnings, 129 lines checked

Hmm, the problem is the --terse command is rather crude and simply
throws away everything except the first line of text. My commit made
the verbose output multi-line to improve readability

$ ./scripts/checkpatch.pl  ~/dep
WARNING: added, moved or deleted file(s):

  migration/threadinfo.h
  migration/threadinfo.c

Does MAINTAINERS need updating?

total: 0 errors, 1 warnings, 193 lines checked

/var/home/berrange/dep has style problems, please review.  If any of these errors
are false positives report them to the maintainer, see
CHECKPATCH in MAINTAINERS.


but this inadvertantly made terse output worse :-(

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


