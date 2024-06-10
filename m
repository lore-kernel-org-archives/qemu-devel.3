Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C8BAC27C55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 16:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGiEW-0000P0-6y; Mon, 10 Jun 2024 12:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sGiEU-0000OG-GA
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:50:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sGiET-0004JJ-3q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 12:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718038256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e1Ijq/lGfj/V6YGjpGO925dOps2bJrqu6jLcCVnK19U=;
 b=KekkUKKyK9iLR7RKnpfHUGPvvEvtQKmkMEo6D4TJXkdset6KXG9s2MU5BliM2Y76SaByXN
 li5oPT5Yyc5zkaBPXxBgD2fn/aVqh8RG0Bf9DrWiVgWeVvKXX3CxVZov0RMSkIvK+wfoiC
 OyLS6YguEvWXKHb5xIXcAd8y6GCw/Sk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-424-2BOK8aETPk671C1jM1VSWg-1; Mon,
 10 Jun 2024 12:50:53 -0400
X-MC-Unique: 2BOK8aETPk671C1jM1VSWg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75FF119560B9; Mon, 10 Jun 2024 16:50:51 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.31])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD05C19560AA; Mon, 10 Jun 2024 16:50:48 +0000 (UTC)
Date: Mon, 10 Jun 2024 18:50:40 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v4 4/4] iotests: Add `vvfat` tests
Message-ID: <Zmcu4BKW2fdVvyLM@redhat.com>
References: <cover.1717549035.git.amjadsharafi10@gmail.com>
 <5780279cb6d0ac2a25b359ab9bbd480f34a4265f.1717549035.git.amjadsharafi10@gmail.com>
 <ZmbrFAOjpuFB_pQG@redhat.com> <ZmcJeXwQZIaK3UCQ@amjad-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmcJeXwQZIaK3UCQ@amjad-pc>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Am 10.06.2024 um 16:11 hat Amjad Alsharafi geschrieben:
> On Mon, Jun 10, 2024 at 02:01:24PM +0200, Kevin Wolf wrote:
> > With the updated test, I can catch the problems that are fixed by
> > patches 1 and 2, but it still doesn't need patch 3 to pass.
> > 
> > Kevin
> > 
> 
> Thanks for reviewing, those are all mistakes, and I fixed them (included
> a small patch to fix these issues at the end...).
> 
> Regarding the failing test, I forgot to also read the files from the fat
> driver, and instead I was just reading from the host filesystem.
> I'm not sure exactly, why reading from the filesystem works, but reading
> from the driver (i.e. guest) gives the weird buggy result. 
> I have updated the test in the patch below to reflect this.
> 
> I would love if you can test the patch below and let me know if the
> issues are fixed, after that I can send the new series.

Yes, that looks good to me and reproduces a failure without patch 3.

Kevin


