Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB2CCCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:35:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJ4A-0007w3-0e; Tue, 21 Oct 2025 16:34:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBJ47-0007vB-GX
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1vBJ42-000752-Kr
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:34:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761078874;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eLGZPMigpqGeQruhx1VYFKrmXHkE3IUce5uAUSUojaE=;
 b=IqGSNB6OXOYdzmAps0EkQu966Z2PL6SXLfPlhMo2JcHBkWXgAhjCM7jo995zW5rmEcFYvb
 5Tc4d7pCiXUdhh2/iT9VkrKDbh5dtGfdfuc+1OynWJPNWWrRq0nVsfE0XO+2xk3nCvM1ox
 tA+HwUt1/727V4i9/kVuRFQfdUjBeIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-QH-e8jpmOMuIk0A-Ng-iuA-1; Tue,
 21 Oct 2025 16:34:32 -0400
X-MC-Unique: QH-e8jpmOMuIk0A-Ng-iuA-1
X-Mimecast-MFC-AGG-ID: QH-e8jpmOMuIk0A-Ng-iuA_1761078871
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 617EE1800C32; Tue, 21 Oct 2025 20:34:31 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.155])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCFBD19560B0; Tue, 21 Oct 2025 20:34:28 +0000 (UTC)
Date: Tue, 21 Oct 2025 15:34:26 -0500
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH] iotests: Adjust nbd expected outputs to match current
 behavior
Message-ID: <63gbembud7tdis4trz5o3e4ff5moztigiplhhzefjxe5jqhazo@7hyeihr6or2n>
References: <20251013213638.494193-2-eblake@redhat.com>
 <aO3w4NoXneWRPSHQ@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aO3w4NoXneWRPSHQ@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
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

On Tue, Oct 14, 2025 at 08:42:40AM +0200, Kevin Wolf wrote:
> Am 13.10.2025 um 23:36 hat Eric Blake geschrieben:
> > 'git bisect' confirms that the NBD iotests 94 and 119 have been broken
> > since commit effd60c8 in v9.0.0; but as Dan Berrange's efforts to
> > improve CI have proven, we haven't been reliably running them to
> > notice.  The change was good (moving coroutine commands to run in the
> > right context), but it meant that "execute":"quit" now waits to
> > complete until the coroutines tearing down NBD have first reported the
> > SHUTDOWN event, in the opposite order of what happened pre-patch.
> > 
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > Fixes: effd60c8 ("monitor: only run coroutine commands in qemu_aio_context", v9.0.0)
> > Reported-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Thanks, applied to the block branch.

Looks like iotest fuse-allow-other suffers from the same problem
(skipped on -nbd, passes for -raw and -qcow2 in v8.2.0, and fails with
reordered output in v9.0.0).  I'll submit a followup patch for that
one as well.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


