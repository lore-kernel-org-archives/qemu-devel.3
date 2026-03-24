Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CECE9A741
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:16:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4xrl-0002ay-3v; Tue, 24 Mar 2026 05:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4xri-0002Vf-Go
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:15:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w4xre-0001U7-4c
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 05:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774343753;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qowj+XaNeD3DaWz8Tj9ccUkjLVLVDqMxxb8CylqCGtI=;
 b=cXpMg3gpQJ7ZtYMljvlSqD674znuNlYhVBd3nZqBQnaga0Dc9RTyeNTP3oFOP4fDiHJjBp
 CEk2GgVRJAYfBxCchJZC7LLPeZMe5S1BooNNjs6deOjXdbQrdFwL8LVfnYdYDR5LHpyBYO
 1eQgnJ0k3AqXpRQThrSl16QpKUzgTE0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-hoXvn6XIM1SJzSOfGeXtlA-1; Tue,
 24 Mar 2026 05:15:50 -0400
X-MC-Unique: hoXvn6XIM1SJzSOfGeXtlA-1
X-Mimecast-MFC-AGG-ID: hoXvn6XIM1SJzSOfGeXtlA_1774343749
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B84A1955E79; Tue, 24 Mar 2026 09:15:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F12B180058C; Tue, 24 Mar 2026 09:15:46 +0000 (UTC)
Date: Tue, 24 Mar 2026 09:15:43 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>,
 Michael Roth <michael.roth@amd.com>, devel@lists.libvirt.org
Subject: Re: [PATCH-for-11.0] qapi: Remove deprecated
 SchemaInfoEnumMember::values field
Message-ID: <acJWPxbjZIcA3cuF@redhat.com>
References: <20260323152124.93051-1-philmd@linaro.org>
 <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
 <c935883f-66d1-42fd-bb19-9c0b59c9493e@linaro.org>
 <87qzp9vhev.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzp9vhev.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 24, 2026 at 08:02:48AM +0100, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
> 
> > On 24/3/26 04:19, Pierrick Bouvier wrote:
> >> On 3/23/26 8:21 AM, Philippe Mathieu-Daudé wrote:
> >>> SchemaInfoEnumMember::values field has been deprecated for
> >>> more than 5 years (see commit 75ecee72625 "qapi: Enable enum
> >>> member introspection to show more than name"), it should be
> >>> safe enough to remove.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> >>> ---
> >>>   docs/about/deprecated.rst       |  6 ------
> >>>   docs/about/removed-features.rst |  7 +++++++
> >>>   qapi/introspect.json            | 12 +-----------
> >>>   scripts/qapi/introspect.py      |  3 +--
> >>>   4 files changed, 9 insertions(+), 19 deletions(-)
> >>>
> >> By curiosity, is this patch goal is simply to remove a deprecated feature/code, or does it unlock something beyond it?
> >> No judgment here, that's a genuine question, and both are valid reasons!
> >
> > In a previous thread Daniel said past deprecation period, feature
> > must be removed, otherwise undeprecated and re-introduced.
> 
> I think that's too rigid.

Definitely s/must/should/.

> 
> Why do we deprecate features?  Reasons include:
> 
> * A feature may have become too much of a burden to support.  We
>   deprecate it with the firm intent to remove it at the earliest
>   opportunity.  The motivation is to help developers, and deprecation is
>   the means to do so without inflicting unnecessary pain on users.
> 
> * A certain interface has turned out to be too limited, necessitating a
>   more expressive one.  Now we have two ways to do the same thing.  We
>   deprecate the limited one to guide users to the new one, because
>   that's the one we think they should use for their own good.  The
>   motivation is to help users, and deprecation is the means.  Removing
>   the old interface later on helps future users a bit more.  It also
>   inconveniences any remaining users of the old interface.
> 
> Mixed reasons are possible.  For instance, we might start for the second
> reason (need a new interface), then find the first reason now applies
> (maintaining the old interface in addition is bothersome).
> 
> Removing a deprecated feature is always a tradeoff, and time is commonly
> a factor.  The deprecation grace period is merely a lower bound we
> commit to so we don't surprise users.  docs/about/deprecated.rst:
> 
>     The [deprecated] feature will remain functional for the release in
>     which it was deprecated and one further release. After these two
>     releases, the feature is liable to be removed.
> 
> Note "liable".
> 
> >                                                            I'm just
> > trying to be consistent with the deprecation process, removing what
> > doesn't seem worth to re-introduce (for the code I'm able to figure
> > out at least).
> >
> > Maybe we should clarify the deprecation process, clarifying that,
> > and mentioning that maintainers sending pull request to commit
> > patches with deprecations are also a commitment to remove code
> > when the proper released is out.
> 
> I believe that wouldn't be a clarification of actual practice, it would
> be a change of practice.  We can certainly debate such a change.

Yes, that's too rigid. Some of the things are very complicated to remove
from the code and so it is valid for maintainers to want to focus on
other things as a higher priority. It is upto maintainers to decide
what priorities deliver most value.  I've tried several times to remove
some of the very old deprecated block features, and it is very hard to
untangle the deps and get tests fixed.

The deprecation process is there to put users on notice, and give
maintainers a clear date, after which they have the freedom to
choose to break / remove things.

The ideal situation is that things are removed promptly after the
2 release cycle marker, but sometimes reality intervenes, sometimes
for a very long time.

I think it is unhelpful to let things fester in a deprecated state
for many years though, as it potentially leads to a situation where
users cease to believe they'll ever be removed, undermining the goal
of deprecation.


Perhaps we could open tickets for each deprecated item. That would
give us a place to record some of the info about the removal process
that contributors need to remember, and any related discussion around
the process. ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


