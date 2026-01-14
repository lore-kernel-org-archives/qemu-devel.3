Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C07D29FF8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0MH-0000xo-T8; Wed, 14 Jan 2026 07:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0Lx-0000w2-24
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:52:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg0Lv-0002q8-Gq
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:52:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768395118;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=AmBLe/Mby3+u4W+FvgPfIMFAJm2VPbqIgXd9NGsa/zE=;
 b=CIh8PP1jQ7jD539/KVE1uD9dI9Av9yfIE+oEzqC5ZKli49l1lCFx7wEvWaaIHBdAsyQmkM
 FqSSUta+l7xfATCDzvnYmjfFNWMwC47yy0khfmAlIOGziyTFg5EoqeGVFc9roJ2Gg995MY
 Dkp+ojx5Oc68TSlANNYSiD8s/IXLuKM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-C9gNiMMCNXm3YKGApnHFuA-1; Wed,
 14 Jan 2026 07:51:54 -0500
X-MC-Unique: C9gNiMMCNXm3YKGApnHFuA-1
X-Mimecast-MFC-AGG-ID: C9gNiMMCNXm3YKGApnHFuA_1768395114
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0078119560B2; Wed, 14 Jan 2026 12:51:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79AB81956053; Wed, 14 Jan 2026 12:51:52 +0000 (UTC)
Date: Wed, 14 Jan 2026 12:51:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org
Subject: Re: [PATCH 0/3] Doc fixes around "current monitor" printing
Message-ID: <aWeRZTi2SmBGeoEe@redhat.com>
References: <20260114124713.3308719-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260114124713.3308719-1-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Wed, Jan 14, 2026 at 01:47:10PM +0100, Markus Armbruster wrote:
> Daniel, these conflict with code motion in your "[PATCH v5 00/24]
> util: sync error_report & qemu_log output more closely".  Could you
> insert them at the beginning of your v6?

Sure, will do.

> 
> Markus Armbruster (3):
>   error: Fix "to current monitor if we have one" comments
>   error: Restore error_printf()'s function comment
>   qemu-print: Document qemu_fprintf(), qemu_vfprintf() failure
> 
>  include/qapi/error.h |  3 ++-
>  monitor/monitor.c    |  2 +-
>  util/error-report.c  | 29 +++++++++++++++++++----------
>  util/qemu-print.c    |  6 ++++--
>  4 files changed, 26 insertions(+), 14 deletions(-)
> 
> -- 
> 2.52.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


