Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D89EB28D6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 08:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voHFS-00067X-ID; Fri, 06 Feb 2026 03:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voHFL-00062b-4i
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:31:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1voHFJ-0002Mn-5F
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 03:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770366678;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=cUx/pXQT3kGMZklXaBFrGsNcnwsqfMvZ6eQN9v7GuOM=;
 b=KihQnyLDURglwE/526TQJmsbwqm6XBtAFzY+s7CkT5ZAwptR9DQVDOiAuZj1kZHfw8FicA
 kdKU/uCVqNsFfXi/Y/eyrobK6pBla5TtpO2+aLdG7iTTlh95IZNPewzedqoUd5j5xCIXa/
 IoVEYwO6ziSHpRQf0ZLJsh+k3xmmX+4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-NAbZOMN2PEqHtHnQGJh9nA-1; Fri,
 06 Feb 2026 03:31:14 -0500
X-MC-Unique: NAbZOMN2PEqHtHnQGJh9nA-1
X-Mimecast-MFC-AGG-ID: NAbZOMN2PEqHtHnQGJh9nA_1770366674
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C32B11956059; Fri,  6 Feb 2026 08:31:13 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.75])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C6F919560A7; Fri,  6 Feb 2026 08:31:12 +0000 (UTC)
Date: Fri, 6 Feb 2026 08:31:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Subject: Re: bsd-user: Dropping the NetBSD and OpenBSD code
Message-ID: <aYWmzBy9TMQd0cra@redhat.com>
References: <CANCZdfq74R8fLc9+NURynkKz+D1FOtxKRGno9EwjN--hPpdf6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANCZdfq74R8fLc9+NURynkKz+D1FOtxKRGno9EwjN--hPpdf6Q@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Feb 05, 2026 at 06:03:56PM -0700, Warner Losh wrote:
> So, it's been years since this code compiled by default, and even more
> years since they compiled at all.
> 
> Maybe 5 years ago, I contacted the OpenBSD folks, who said it had decayed
> beyond uselessness. So I plan on just removing the bsd-user/openbsd code
> shortly.
> 
> Maybe 4 years ago, someone from NetBSD popped up and said they had a fork
> and they'd share it with me, but they never did, and we never reconnected
> despite some email attempts since then. So, I'd like to remove the netbsd
> directory as well.
> 
> Both of these are finally getting enough in the way that they are causing
> me problems with upstreaming the bsd-user stuff. Now that I have a good
> head of steam on doing that, I'd like to finish that process. Expect me to
> flood your email in the coming months with way too many patches now that
> I've found a way to streamline the process enough for me to sneak it into
> what would otherwise be lost Friday afternoons...
> 
> Before I send the patch series to do this, I'd like to do a last and final
> call for collaboration. I kept it around for this long in the hopes someone
> would show up, but nobody ever did.

We probably should have marked the feature deprecated a while ago, but since
you indicate it can't even compile, I think that's sufficient justification
to simply delete it. The period of time when it failed to compile can be
considered to count as the deprecation count down

Personally I'd suggest just sending the patches to do the deletion, and
CC'ing the relevant people on those.  An actual deletion proposal is more
likely to wake any interested person from their slumber. If someone does
show up we can debate whether to none the less go ahead with deletion,
and let someone pull it back out of git history later if they want to
work on making it build again.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


