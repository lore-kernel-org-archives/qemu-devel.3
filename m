Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A28C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 08:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2ROn-0000BR-T5; Thu, 02 May 2024 04:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2ROa-0008Vp-Gy
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:02:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s2ROU-0004Ou-Cx
 for qemu-devel@nongnu.org; Thu, 02 May 2024 04:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714636937;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=sTYqKAsLt+lilyQHaj+g3hcdqUQUcGZgiXD8ewuOT88=;
 b=hVzN8AgBTEPV4P2B8iYVL+B23M+6Rwf8Wu/gbuqrwgiSJyEevG34u/DVZDeeVvePgLxTFg
 vMwwb8FovjMTV7zjUfrOC7UP789nyGjyOn5o7Xa/Orv+YGr3xQ97ySTb6EursMMWrUx8Hq
 WYbg5/YTwju5EzxiaGpulliARzsnnC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-59-R1eyhP2CJpiJAt-LJBQ-1; Thu, 02 May 2024 04:02:13 -0400
X-MC-Unique: 59-R1eyhP2CJpiJAt-LJBQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67E4381F454;
 Thu,  2 May 2024 08:02:13 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8964E40ED31;
 Thu,  2 May 2024 08:02:12 +0000 (UTC)
Date: Thu, 2 May 2024 09:02:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roman Kiryanov <rkir@google.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 JP Cottin <jpcottin@google.com>, Erwin Jansen <jansene@google.com>
Subject: Re: QEMU headers in C++
Message-ID: <ZjNIOfJdmLGAJnKh@redhat.com>
References: <CAOGAQeq+Wu9wiBj+tF0PJHMZS-F4KnVBOXCyXhYQsm+REyLUpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOGAQeq+Wu9wiBj+tF0PJHMZS-F4KnVBOXCyXhYQsm+REyLUpg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, May 01, 2024 at 09:40:16PM -0700, Roman Kiryanov wrote:
> Hi QEMU,
> 
> I work in Android Studio Emulator and we would like to develop devices
> in C++. Unfortunately, QEMU headers cannot be used with C++ as is
> (e.g. they use C++ keywords as variable names or implicitly cast void*
> to T*).

NB, in recent past QEMU explicitly eliminated almost[1] all C++ code from
the tree, because the consensus was to be exlcusively a C project. 

> Will QEMU be open to accept patches from us to make QEMU headers C++
> compatible?

Personally I think that'd be a retrograde step. Any downstream development
fork that made use of that facility would be not be able to feed changes
/ additions back into upstream QEMU codebase at a later date, without QEMU
accepting C++ code once again.

We'll never control what forks can do, and many will never feed back code
regardless, but IMHO we should be steering external developers in a way
that keeps open the door for their changes to be merged back upstream.

With regards,
Daniel

[1] Only some minor windows installer code remains C++.
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


