Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C289BE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 12:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNsq8-0005tI-WC; Wed, 18 Dec 2024 07:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNsq4-0005qw-3U
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:07:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNsq1-0007ai-Up
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 07:07:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734523656;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=zBx34bAnM4fq5RPj1b54Tw4uYjFqy+1DwbUSbg5n7fQ=;
 b=EYWjILq7XOKPvakITRn2Px7QVn3/Mcc5gZ9vwIreiYSSTLDs+rC+r+xLRncTtcGweYuQEp
 RfekQ2JcwIcieX9Mi/V6BnQ/NRLo3kY0G2Z1H3pUzHfrp8o/BfgjiOEE2Ipn78K1GHaior
 nNwcjUnV74BOUOfGVYZHJAmtaX476fg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-ejUbMcs8PrqU0YLYsy1WpA-1; Wed,
 18 Dec 2024 07:07:34 -0500
X-MC-Unique: ejUbMcs8PrqU0YLYsy1WpA-1
X-Mimecast-MFC-AGG-ID: ejUbMcs8PrqU0YLYsy1WpA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B069E1954B0E; Wed, 18 Dec 2024 12:07:33 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.61])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0230E195608A; Wed, 18 Dec 2024 12:07:30 +0000 (UTC)
Date: Wed, 18 Dec 2024 12:07:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Konstantin Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PULL 0/3] Misc QGA patches for 2024-12-18
Message-ID: <Z2K6_ftN9J2Uo4pV@redhat.com>
References: <20241218120321.34998-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241218120321.34998-1-kkostiuk@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Any reason this skipped inclusion of my patch:

  Subject: [PATCH] qga: implement a 'guest-get-load' command

which you already acked ?

On Wed, Dec 18, 2024 at 02:03:18PM +0200, Konstantin Kostiuk wrote:
> The following changes since commit 8032c78e556cd0baec111740a6c636863f9bd7c8:
> 
>   Merge tag 'firmware-20241216-pull-request' of https://gitlab.com/kraxel/qemu into staging (2024-12-16 14:20:33 -0500)
> 
> are available in the Git repository at:
> 
>   https://github.com/kostyanf14/qemu.git tags/qga-pull-2024-12-18
> 
> for you to fetch changes up to 2657a92b5479c8705b128ed1e55feb8960ed498a:
> 
>   qga: Don't access global variable in run_agent_once() (2024-12-18 13:46:16 +0200)
> 
> ----------------------------------------------------------------
> qga-pull-2024-12-18
> 
> ----------------------------------------------------------------
> Dehan Meng (1):
>       qemu-ga-win: Fix a typo error
> 
> Jean-Louis Dupond (1):
>       qga: skip bind mounts in fs list
> 
> Michal Privoznik (1):
>       qga: Don't access global variable in run_agent_once()
> 
>  qga/commands-linux.c | 25 +++++++++++++++++++++++++
>  qga/commands-win32.c |  2 +-
>  qga/main.c           |  2 +-
>  3 files changed, 27 insertions(+), 2 deletions(-)
> 
> --
> 2.47.1
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


