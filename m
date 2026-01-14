Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5686AD3900B
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 18:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg5q5-0001I5-AT; Wed, 14 Jan 2026 13:43:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vg5pj-0001ES-PN
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vg5pi-0000m0-Ar
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 13:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768416185;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9h2Tg94wNpud6IW9/rV3PHxRBqOK1S4nmqvsiYU+8s=;
 b=f2uWZRsWG99GNaEFxarW24MfbiiJ4ua78jiAbW1Tgc4sDrPlhwAI3tQ2waCnGYVaTGYWYV
 D6CBwbpw8/MSQD1IGcGvSRek3XaadaYjAyhEABgIQbjF+/eYN/HJEfgmgEQs6PCYhCTQtw
 +uAXUtdOi9J+A85/FLzJ2ASysYpGVqg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-tboi7vL5MBGE_i7HULkObw-1; Wed,
 14 Jan 2026 13:43:02 -0500
X-MC-Unique: tboi7vL5MBGE_i7HULkObw-1
X-Mimecast-MFC-AGG-ID: tboi7vL5MBGE_i7HULkObw_1768416181
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BCAA180044D; Wed, 14 Jan 2026 18:43:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.253])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7827F19560A7; Wed, 14 Jan 2026 18:43:00 +0000 (UTC)
Date: Wed, 14 Jan 2026 12:42:57 -0600
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, 
 Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/qemu-iotests: Mark 182 as Linux-only
Message-ID: <aWfjO5TxVQ0szLDy@redhat.com>
References: <20260113141744.97469-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113141744.97469-1-thuth@redhat.com>
User-Agent: NeoMutt/20251211
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 13, 2026 at 03:17:44PM +0100, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Running test 182 on FreeBSD fails with this error message in the output:
> 
>  +warning: File lock requested but OFD locking syscall is unavailable, falling back to POSIX file locks
>  +Due to the implementation, locks can be lost unexpectedly.
> 
> OFD locks seem to be only available on Linux, so let's mark this
> test as Linux-only to silence the failure.

OFD locks are part of POSIX now, so eventually new-enough BSD will
have them.  Is it worth trying to be more specific and testing for the
actual feature that we are depending on, rather than just limiting the
test to an early-adopter OS?  That said, I don't have any quick ideas
on how to do a more-specific feature test, so I don't mind this going
in as-is; we already know BSD gets less coverage for other reasons.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


