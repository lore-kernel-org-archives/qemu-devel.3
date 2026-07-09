Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CA0C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 08:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whjjG-00034B-7c; Thu, 09 Jul 2026 04:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whjjE-00033p-Kk
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:03:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1whjjC-0000QK-Ce
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 04:03:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783584203;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPit7spSbc+ma1sq5uy8doSD2ETBEPaaArgmHi2+kJo=;
 b=J+eBMmUlioJcDMmkT2AaVpkvQTK2cE22Pd//RtAGb0pnLdnJzexzNgez1fZ16+PxyWyLoX
 2ZciSV2n9Cx+g6Wbdq17gRBA2Y/4RiWQud/AyE4zJ+rbpXtaawlnbASOl/2AavSTHYi6F7
 7A72C8ll8XQcce5EFAiGn3bTDtucs7g=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-6F6ZNjTqMkW8GR2c1BCURA-1; Thu,
 09 Jul 2026 04:03:20 -0400
X-MC-Unique: 6F6ZNjTqMkW8GR2c1BCURA-1
X-Mimecast-MFC-AGG-ID: 6F6ZNjTqMkW8GR2c1BCURA_1783584199
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF84D19560B5; Thu,  9 Jul 2026 08:03:18 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.59])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC42D180058F; Thu,  9 Jul 2026 08:03:17 +0000 (UTC)
Date: Thu, 9 Jul 2026 09:03:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PULL 0/4] Misc patches queues
Message-ID: <ak9VwgV77sETy5CM@redhat.com>
References: <20260707175027.3029620-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260707175027.3029620-1-berrange@redhat.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Note, I have updated my PGP key with a new signing sub-key,
so it will need refreshing from keys.opengpg.org, under
the same primary key ID as you already have for me.

On Tue, Jul 07, 2026 at 06:50:23PM +0100, Daniel P. Berrangé wrote:
> The following changes since commit 94826ec1370328375c3b6d1e80fdc94c8f46c348:
> 
>   Merge tag 'accel-20260706' of https://github.com/philmd/qemu into staging (2026-07-06 18:38:14 +0200)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/berrange/qemu tags/misc-next-pull-request
> 
> for you to fetch changes up to 64d0d2efdd2822c827aa7cd276e15c7cefaccb95:
> 
>   docs: outline some guidelines for security classification (2026-07-07 18:36:15 +0100)
> 
> ----------------------------------------------------------------
> * Outline security classification guidelines
> * Use QEMU lock guards in inotify code
> * Fix certificate error checking
> 
> ----------------------------------------------------------------
> 
> Daniel P. Berrangé (1):
>   docs: outline some guidelines for security classification
> 
> Evgeny Kolmakov (1):
>   util/filemonitor-inotify: Use QEMU_LOCK_GUARD()
> 
> Peter Maydell (1):
>   io/channel-socket: Document why we can ignore socket_set_cork() errors
> 
> yujun (1):
>   crypto/x509-utils: fix gnutls error code in crt_init failure path
> 
>  crypto/x509-utils.c        |  3 +-
>  docs/system/security.rst   | 63 ++++++++++++++++++++++++++++++++++++++
>  io/channel-socket.c        |  6 ++++
>  util/filemonitor-inotify.c | 28 +++++------------
>  4 files changed, 79 insertions(+), 21 deletions(-)
> 
> -- 
> 2.55.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


