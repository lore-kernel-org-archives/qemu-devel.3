Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67680D232ED
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7Zs-0003oc-BZ; Fri, 09 Jan 2026 03:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ve7Z9-0003Mu-N2
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:09:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ve7Z7-00070t-2C
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767946187;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xemmz6EL4+Z/U31D6nh2YQuqL7drn0x0Qpe/B63UNEQ=;
 b=SBjW5yLEaVjxq9BCQp/MAJ47oMFTp+X7vT25ghINvoyaqxzZsJvI75hP0RUluj3OMM8ve+
 O+JkU4v83b+3G/xPH+6c1L/fRLXo6d4czFfpf6Mjg733T980FzJ5k2mkoyPeFaTlqmGB65
 7NfVQPNV2Y6mwIaLOBO/vYo5Tw1SQgI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-482vDB9wONCpLB00iJ1qXw-1; Fri,
 09 Jan 2026 03:09:44 -0500
X-MC-Unique: 482vDB9wONCpLB00iJ1qXw-1
X-Mimecast-MFC-AGG-ID: 482vDB9wONCpLB00iJ1qXw_1767946183
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B9C51955E7E; Fri,  9 Jan 2026 08:09:43 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.39])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99AF019560B4; Fri,  9 Jan 2026 08:09:41 +0000 (UTC)
Date: Fri, 9 Jan 2026 08:09:38 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, clg@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH] scripts/checkpatch: Fix MAINTAINERS update warning with
 --terse
Message-ID: <aWC3sHN4vP-N0ee4@redhat.com>
References: <20260109071217.2326194-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109071217.2326194-1-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 09, 2026 at 08:12:17AM +0100, Markus Armbruster wrote:
> We recently improved the MAINTAINERS update warning to show the files
> that trigger it.  Example:
> 
>     WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>     #105:
>     deleted file mode 100644
> 
> improved to
> 
>     WARNING: added, moved or deleted file(s):
> 
>       migration/threadinfo.h
>       migration/threadinfo.c
> 
>     Does MAINTAINERS need updating?
> 
> Unfortunately, this made things worse with --terse, as only the first
> line of each warning is shown then.
> 
>     WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> became
> 
>     WARNING: added, moved or deleted file(s):
> 
> Adjust the warning text to
> 
>     WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>       migration/threadinfo.h
>       migration/threadinfo.c
> 
> so we get the exact same warning as we used to with --terse.
> 
> Fixes: 1d745e6d9635 (scripts/checkpatch: use new hook for MAINTAINERS update check)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  scripts/checkpatch.pl | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


