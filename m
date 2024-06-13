Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48A90C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 17:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHoJI-0008Ke-7c; Thu, 13 Jun 2024 13:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sHoJG-0008KR-PW
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:32:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sHoJF-0007cj-5k
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 13:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718299944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zKh/P7RJPSG/d8nE1bOm8cMkIcdgv0hpKYhA/Hxxt24=;
 b=eAcL0gBYeyG2F6QO8rkBSge4zigc0SyjqSw9WDOa2QIP+mGYgu3HjlzTFA/tigPSnfbwtg
 A2GLsQ7QozLNPI3rgoWd2PzzYmipjzs7Rzh7jpjhynU7Ay5h14ok6vdxkX+KAIv/nPir2Q
 FYeykB5o+upgLWE7b6fZV9/m2Xo8wBE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-qHCjcgd6OZuX-A8yVbrqfw-1; Thu,
 13 Jun 2024 13:32:20 -0400
X-MC-Unique: qHCjcgd6OZuX-A8yVbrqfw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ED9719560B8; Thu, 13 Jun 2024 17:32:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.192.41])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9B371955E82; Thu, 13 Jun 2024 17:32:17 +0000 (UTC)
Date: Thu, 13 Jun 2024 19:32:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Amjad Alsharafi <amjadsharafi10@gmail.com>
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-devel@nongnu.org,
 "open list:vvfat" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 5/5] iotests: Add `vvfat` tests
Message-ID: <ZmstH_zGvS-HKtUn@redhat.com>
References: <cover.1718195956.git.amjadsharafi10@gmail.com>
 <0aa2f5704890e20e3dcb4f33ce68a8fb7393e2f2.1718195956.git.amjadsharafi10@gmail.com>
 <Zmr9M3lw_xLcy2ok@amjad-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmr9M3lw_xLcy2ok@amjad-pc>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
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

Am 13.06.2024 um 16:07 hat Amjad Alsharafi geschrieben:
> On Wed, Jun 12, 2024 at 08:43:26PM +0800, Amjad Alsharafi wrote:
> > Added several tests to verify the implementation of the vvfat driver.
> > 
> > We needed a way to interact with it, so created a basic `fat16.py` driver
> > that handled writing correct sectors for us.
> > 
> > Added `vvfat` to the non-generic formats, as its not a normal image format.
> > 
> > Signed-off-by: Amjad Alsharafi <amjadsharafi10@gmail.com>
> > ---
> >  tests/qemu-iotests/check           |   2 +-
> >  tests/qemu-iotests/fat16.py        | 673 +++++++++++++++++++++++++++++
> >  tests/qemu-iotests/testenv.py      |   2 +-
> >  tests/qemu-iotests/tests/vvfat     | 457 ++++++++++++++++++++
> >  tests/qemu-iotests/tests/vvfat.out |   5 +
> >  5 files changed, 1137 insertions(+), 2 deletions(-)
> >  create mode 100644 tests/qemu-iotests/fat16.py
> >  create mode 100755 tests/qemu-iotests/tests/vvfat
> >  create mode 100755 tests/qemu-iotests/tests/vvfat.out
> 
> Btw Kevin, I'm not sure if I should add myself to the MAINTAINERS file
> for the new files (fat16.py and vvfat) or not

You can if you really want to, but there is no need.

Basically if you see yourself maintaining these files for a long time
instead of just contributing them now and you want to be contacted
when they are changed in the future, that's when you could consider it.
But the patches will still go through my or Hanna's tree and we already
cover all of qemu-iotests, so we don't have to have a formal
maintainership definition for these files specifically.

Kevin


