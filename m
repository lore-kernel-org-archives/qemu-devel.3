Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF75FC71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 07:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR4bA-0004Fu-DC; Mon, 16 Jun 2025 03:49:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR4Zs-000448-Tp
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:48:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uR4Zq-0004xf-SU
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 03:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750060100;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=REhh6BnMuO0AtIs8st8xmYg7lyktGJF4vBrLxn2DujA=;
 b=WpLd0D4NdSKUUIKb0W9W5UQHMkHLr23vBPjiqivIEOjLin4Wva6FHo2lM8RdzLTtvqej3U
 pu9gHMmrHT++xTXdbvM1MCou7WxT+3HvDBzd/RO/up0fE3xKZSsnP61MZA1InnrZNjTgmj
 xF2WPsYAcn2BEkBXjOrcPqgphiLNozc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-532-KbUv7A4vM-2bDoLQMrwlNg-1; Mon,
 16 Jun 2025 03:48:14 -0400
X-MC-Unique: KbUv7A4vM-2bDoLQMrwlNg-1
X-Mimecast-MFC-AGG-ID: KbUv7A4vM-2bDoLQMrwlNg_1750060092
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C55E180135B; Mon, 16 Jun 2025 07:48:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02A5518003FC; Mon, 16 Jun 2025 07:48:02 +0000 (UTC)
Date: Mon, 16 Jun 2025 08:47:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Sean Wei <me@sean.taipei>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>
Subject: Re: [PATCH 05/12] include/hw: replace FSF postal address with
 licenses URL
Message-ID: <aE_ML3jtVgweJMid@redhat.com>
References: <20250613.qemu.patch@sean.taipei>
 <20250613.qemu.patch.05@sean.taipei>
 <3aa8de03-911e-4906-a0c5-5b8ea269ad28@kaod.org>
 <aE_D5zVzf3qHRP-2@redhat.com>
 <accf0fab-782d-4e0a-9f13-f6a940fc86a1@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <accf0fab-782d-4e0a-9f13-f6a940fc86a1@kaod.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 16, 2025 at 09:29:35AM +0200, Cédric Le Goater wrote:
> On 6/16/25 09:13, Daniel P. Berrangé wrote:
> > On Sat, Jun 14, 2025 at 07:29:09AM +0200, Cédric Le Goater wrote:
> > > Hello Sean,
> > > 
> > > On 6/13/25 18:44, Sean Wei wrote:
> > > > Some of the GPLv2 boiler-plate still contained the
> > > > obsolete "51 Franklin Street" postal address.
> > > > 
> > > > Replace it with the canonical GNU licenses URL recommended by the FSF:
> > > > https://www.gnu.org/licenses/
> > > > 
> > > > Signed-off-by: Sean Wei <me@sean.taipei>
> > > 
> > > Instead,  I would remove the license boiler plate and add :
> > > 
> > >    SPDX-License-Identifier: GPL-2.0-or-later
> > 
> > This is *NOT* something we are doing for existing code sources,
> > unless the person removing it is the exclusive copyright
> > holder on the file.
> Ah. So I misunderstood.
> 
> How is license boiler plate different from the SPDX identifier tag ?

It achieves the same aims, but notice GPL clause 1

  "keep intact all the notices that refer to this License and
   to the absence of any warranty;"

and yes, some projects have none the less done a wholesale replacement of
boilerplate. I don't know how they rationalized ignoring this license
requirement. It is simpler to just preserve boilerplate as-is that to
debate the legal nuances of this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


