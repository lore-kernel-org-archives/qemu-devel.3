Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C762CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 10:47:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhmm9-0006W2-7N; Mon, 19 Jan 2026 05:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmm5-0006UM-Gk
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:46:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vhmm3-0003tF-A8
 for qemu-devel@nongnu.org; Mon, 19 Jan 2026 05:46:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768819577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7EqoF3VLYqgRpCFAULfgIQ/I8BD/WzeG5ImtSd811HQ=;
 b=IcRluPg79o6IUzxUDDlqVxq34Y632FDlkGNZ8lgcR1f0twCWGCMru2Zm7EmEteDXh102Rn
 NNbjGumDnNTHBBx3iNm0dfdnBiLZsvTIvn7vSAhW+pi6zzJAn8kTSasvjqLkTn6jOJ2GA2
 jen70M6qmxLGwO1Aki/P/d+y682GC2U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-Bjd4WQakMkGEBjdGuj1xtA-1; Mon,
 19 Jan 2026 05:46:14 -0500
X-MC-Unique: Bjd4WQakMkGEBjdGuj1xtA-1
X-Mimecast-MFC-AGG-ID: Bjd4WQakMkGEBjdGuj1xtA_1768819573
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96B1919560A7
 for <qemu-devel@nongnu.org>; Mon, 19 Jan 2026 10:46:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5836B1955F22; Mon, 19 Jan 2026 10:46:12 +0000 (UTC)
Date: Mon, 19 Jan 2026 10:46:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 0/5] Clean up header guards again
Message-ID: <aW4LcOkEqpPCq9sH@redhat.com>
References: <20260119100537.463312-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119100537.463312-1-armbru@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.077,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On Mon, Jan 19, 2026 at 11:05:32AM +0100, Markus Armbruster wrote:
> Our use of header guards is rather sloppy.  Sloppiness there can lead
> to confusing compilation errors.  This series cleans up existing
> header guards.  In particular, it normalizes guard symbols to follow a
> common pattern, in the hope of making clashes less likely.  It doesn't
> add new header guards.  We have more than 300 headers without a
> recognizable header guard.  A few of them are for multiple inclusion,
> many don't need header guards because they don't do anything but
> include, but quite a few probably should have one.  Left for another
> day.
> 
> Previously cleaned up in merge commit ec11dc41eec (2022), merge commit
> 01807c8b0e9 (2019), and merge commit ca3d87d4c84 (2016).

No objection to applying these fixups since you've done the work
already.

Based on the repeated cleanups, and your notes above that we still
have many problems though, can I again suggest we just adopt the
GCC/CLang extension of adding

  #pragma once

at the top of every header and burn all the #ifdefs.

It is easy & cheap to verify that it is present on every single .h file,
and there are no style variations to get wrong, or closing statements to
make inconsistent.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


