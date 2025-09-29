Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FDBCAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 18:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3IkK-00007S-W1; Mon, 29 Sep 2025 14:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3Ijf-0008DA-Hu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:36:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v3IjV-0004c5-Dy
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 14:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759170976;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ORldVlEKF333lxBysYN83P/OO2VtGQCEyZIslWCiNpc=;
 b=KaPDCvCwnBvEBiFo2QTBmcFUCfjkQ8RCbJbalNIOgtTKrJv97JhcJ5gufY7HXilqzcmkdw
 2EvzNI8lgO7ROz9Bp8DqOJNmSxQ0YmYDLW/E06t3amAyNqaA18K2qeIeyoHcq3YHFGGbmZ
 Wq5nlQgdozC/BfO9q/0BLZwUbHRF5CE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-nBnSvYRLPU2Ath4wbjP4Lg-1; Mon,
 29 Sep 2025 14:36:13 -0400
X-MC-Unique: nBnSvYRLPU2Ath4wbjP4Lg-1
X-Mimecast-MFC-AGG-ID: nBnSvYRLPU2Ath4wbjP4Lg_1759170972
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE3D219560A5; Mon, 29 Sep 2025 18:36:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 83E9B30002C5; Mon, 29 Sep 2025 18:36:09 +0000 (UTC)
Date: Mon, 29 Sep 2025 19:36:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com, alex.bennee@linaro.org
Subject: Re: [PATCH] docs/code-provenance: add an exception for non-creative
 AI changes
Message-ID: <aNrRlUUFm64pQMyn@redhat.com>
References: <20250925075630.352720-1-pbonzini@redhat.com>
 <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_6nf6zAK9=VZE9kCXUvYcZhxAgPUN=0gxtun7ip6b7ig@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Sep 26, 2025 at 03:38:49PM +0100, Peter Maydell wrote:
> 
> I'm not enthusiastic. The current policy is essentially
> "the legal risks are unclear and the project isn't willing
> to accept them".

Broadly speaking the legal risks are unclear. The challenge from Paolo
though is there are some usage scenarios where the legal risks are
negligible, even in today's murky situation wrt training material
license laundering

>                 That's a straightforward rule to follow
> that doesn't require either the contributor or the reviewer
> or the project to make a possibly difficult judgement call on
> what counts as not in fact risky. As soon as we start adding
> exceptions then either we the project are making those
> judgement calls, or else we're pushing them on contributors
> or reviewers. I prefer the simple "'no' until the legal
> picture becomes less murky" rule we have currently.

The simplicity of the current rule is very appealing, but at the same time
I find it hard to justify why we should reject usage in some of these
scenarios.

So we have a choice of deciding we're going to accept the collatoral
damage of rejecting what are almost certainly low risk contributions,
or tolerate a little more complexity in our policy via exceptions.

I'm willing to entertain the idea of exceptions, as long as we don't
make it too onerous for our maintainers to evaluate patches with a
reasonable consistency across our different maintainers.

Something should be able to pass an obvious & simple "sniff test" to
be able to qualify under an exception. If we find ourselves having
to debate & ponder applicability, then the exception would be unworkable.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


