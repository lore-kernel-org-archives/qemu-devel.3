Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C41C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riANr-0001St-Cp; Thu, 07 Mar 2024 04:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riANn-0001SZ-Rl
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:49:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1riANY-0005fU-3F
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:49:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709804971;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hf4Yl1Z60vx3adXFbcF04S2ZKeeZUYQeQHs1dpLD1sU=;
 b=BxcDvtXlz88dLMBImYqmnMZvvJMfORO6B75q3fEewrMkEJugw1xcfJN3RmgSY4pT9nWHmr
 hdoofte9bxfyrKz0uxlWEhL4SZa7wgYze32kt9V/miIohqpFe6k/HZm000WBvPAhrDhDry
 Fb8YVRe4lVb09VDj6KdQIzX7N+KokkM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-qIX3gfGoMzqUBOSmYL8VhA-1; Thu, 07 Mar 2024 04:49:28 -0500
X-MC-Unique: qIX3gfGoMzqUBOSmYL8VhA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45DE2101A552;
 Thu,  7 Mar 2024 09:49:28 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A35751121306;
 Thu,  7 Mar 2024 09:49:27 +0000 (UTC)
Date: Thu, 7 Mar 2024 09:49:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: "Kim, Dongwon" <dongwon.kim@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH 0/3] ui/gtk: introducing vc->visible
Message-ID: <ZemNpZGubF2rj-BM@redhat.com>
References: <20240130234840.53122-1-dongwon.kim@intel.com>
 <PH8PR11MB6879F0CB84091A8436C3B891FA5E2@PH8PR11MB6879.namprd11.prod.outlook.com>
 <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvay8Gir6r4EWE0L=Y_YxGUxu9WS3TwNyUMe5vYX8Qt2SyA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 05, 2024 at 04:18:18PM +0400, Marc-André Lureau wrote:
> Hi Kim
> 
> I am uncomfortable with the series in general.
> 
> Not only we don't have the means to draw dmabuf/scanout "when
> required", so resuming drawing won't work until the guest draws (this
> is already a problem but you are only making it worse). And I also
> think reconfiguring the guest by merely minimizing or switching
> window/tabs isn't what most users would expect.
> 
> Daniel, could you have a look too?

I'm similarly pretty uncomfortable with the proposed behaviour
as it feels like it would be introducing a whole new set of
unfortunate side-effects/problems.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


