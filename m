Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780ACC61DFD
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 09:36:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hNz-0006C7-Py; Wed, 02 Sep 2026 05:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1hNy-0006Bf-Em
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:36:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1x1hNx-0005gr-1m
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 05:36:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788341759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fSKlYalIr8CXzsdUebQ4zmK3fM5ZaWDf9UccwwZL6HI=;
 b=RCb+8NFWKbatTaF9u4xrjuiVpLXJdXo4dMWo/sh//2OKwnEZToSVm2X2VzgcxKWRODC+YU
 jMHgfwuqa6kT5nqwwXhJBeHnW/MG7esW7tqLpqwI4nnVXQxz3yAZnpep6EGVLAtld535yQ
 wbrYoWrY6fXqLYo9glY3a3kPTow9veY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-680-p5iYfGbSMIOXCYh2YGhqkw-1; Wed,
 02 Sept 2026 05:35:57 -0400
X-MC-Unique: p5iYfGbSMIOXCYh2YGhqkw-1
X-Mimecast-MFC-AGG-ID: p5iYfGbSMIOXCYh2YGhqkw_1788341756
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81B951944CFF
 for <qemu-devel@nongnu.org>; Wed,  2 Sep 2026 09:35:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.41])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 41C557D7; Wed,  2 Sep 2026 09:35:56 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CB8E718007B6; Wed, 02 Sep 2026 11:35:54 +0200 (CEST)
Date: Wed, 2 Sep 2026 11:35:54 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Daniel =?utf-8?B?QmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: Async machine appliance for testing (python)
Message-ID: <apftNyHCjxBCheyK@sirius.home.kraxel.org>
References: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFn=p-aVpKptC=G6yTWWuQoeG+peChgw60uJdOXr7B8r=m=iBQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

  Hi,

> Before I dig in, I wanted to ask if this would be a helpful project.
> The main selling points would be:
> 
> (1) Ability to split it out from the main QEMU tree, like QMP was, for
> use in external testing

I'd still love to see this happening.

> (4) Ability to add listeners/event handlers to watch for specific
> patterns and trigger asynchronously when they occur; i.e. ability to
> handle and watch for specific patterns in an arbitrary order without
> deadlocking your test

That sounds very useful to me.

take care,
  Gerd


