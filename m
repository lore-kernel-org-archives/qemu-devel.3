Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3956CC47DDB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 09:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUNzp-00011e-6K; Mon, 29 Jan 2024 04:32:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUNzm-00011V-Nt
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:32:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rUNzk-00087U-QU
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 04:32:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706520719;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6S88MYTq/jM4Z3WtQ5AVZMrM5wW7noNLAgUsQ1FPFZk=;
 b=N0GEwwgvN/l7nSQ4sR3OpAztcQHzvYhgbkAiq8kTeuWn1aAtfLGeGm88NqTmvewA+BvLaT
 frlMQejaF+hZ58/mRTJhBlCEpVr4cHsXx1YKsmVLLQjcYk6XM2S33kf/v0qtK65qHnWjTr
 SSY5ylu16TbpEXH5LSJIn3UdExerytU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-hbVcXaTBMzuhohKvvwOtiA-1; Mon, 29 Jan 2024 04:31:54 -0500
X-MC-Unique: hbVcXaTBMzuhohKvvwOtiA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D77E685CBA3;
 Mon, 29 Jan 2024 09:31:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78309492BE2;
 Mon, 29 Jan 2024 09:31:51 +0000 (UTC)
Date: Mon, 29 Jan 2024 09:31:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/2] docs: introduce dedicated page about code provenance
 / sign-off
Message-ID: <ZbdwhR6h6T97vR8J@redhat.com>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-2-berrange@redhat.com>
 <ZbUU6CTgxgCLG0a9@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbUU6CTgxgCLG0a9@intel.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.485,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, Jan 27, 2024 at 10:36:24PM +0800, Zhao Liu wrote:
> Hi Daniel,
> 
> On Thu, Nov 23, 2023 at 11:40:25AM +0000, Daniel P. Berrangé wrote:
> > +Multiple authorship
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +It is not uncommon for a patch to have contributions from multiple
> > +authors. In such a scenario, a git commit will usually be expected
> > +to have a ``Signed-off-by`` line for each contributor involved in
> > +creatin of the patch. Some edge cases:
> > +
> > +  * The non-primary author's contributions were so trivial that
> > +    they can be considered not subject to copyright. In this case
> > +    the secondary authors need not include a ``Signed-off-by``.
> > +
> > +    This case most commonly applies where QEMU reviewers give short
> > +    snippets of code as suggested fixes to a patch. The reviewers
> > +    don't need to have their own ``Signed-off-by`` added unless
> > +    their code suggestion was unusually large.
> > +
> > +  * Both contributors work for the same employer and the employer
> > +    requires copyright assignment.
> > +
> > +    It can be said that in this case a ``Signed-off-by`` is indicating
> > +    that the person has permission to contributeo from their employer
> > +    who is the copyright holder. 
> 
> For this case, maybe it needs the "Co-developed-by"?

If you're going to go to the trouble of adding multiple tags
to the commit for each author who participated, then IMHO they
should all be Signed-off-by. IOW, either just have S-o-B from
the main author within a company, or have S-o-B for every
author. Co-developed-by doesn't have value IMHO.

> > It is none the less still preferrable
> > +    to include a ``Signed-off-by`` for each contributor, as in some
> > +    countries employees are not able to assign copyright to their
> > +    employer, and it also covers any time invested outside working
> > +    hours.
> > +
> > +Other commit tags
> > +~~~~~~~~~~~~~~~~~
> > +
> > +While the ``Signed-off-by`` tag is mandatory, there are a number of
> > +other tags that are commonly used during QEMU development
> > +
> > + * **``Reviewed-by``**: when a QEMU community member reviews a patch
> > +   on the mailing list, if they consider the patch acceptable, they
> > +   should send an email reply containing a ``Reviewed-by`` tag.
> 
> Maybe just a question, the people should drop the Reviewed/ACKed/Tested
> tags that have been obtained if he make the any code changes (including
> function/variable renaming) as well as commit message changes during
> the patch refresh process, am I understand correctly? ;-)

It is a judgement call as to whether a Reviewed-by/etc should be
kept or dropped. It depends on the scale of the changes that
were made to the commit since the Reviewed-by/etc was first given.

> > +   NB: a subsystem maintainer sending a pull request would replace
> > +   their own ``Reviewed-by`` with another ``Signed-off-by``
> > +
> > + * **``Acked-by``**: when a QEMU subsystem maintainer approves a patch
> > +   that touches their subsystem, but intends to allow a different
> > +   maintainer to queue it and send a pull request, they would send
> > +   a mail containing a ``Acked-by`` tag.
> > +   
> > + * **``Tested-by``**: when a QEMU community member has functionally
> > +   tested the behaviour of the patch in some manner, they should
> > +   send an email reply conmtaning a ``Tested-by`` tag.
> 
> Is there any requirement for the order of tags?
> 
> My previous understanding was that if the Reviewed-by/Tested-by tags
> were obtained by the author within his company, then those tags should
> be placed before the signed-off-by of the author. If the Reviewed-by/
> Tested-by were acquired in the community, then they should be placed
> after the author's signed-off-by, right?

Common practice is for Signed-off-by tags to be kept in time order
from earliest author to latest author / maintainer. Common case is
2 S-o-B, the first from the patch author, and the last from the
sub-system maintainer who sends the pull request.

For other tags I don't see any broadly acceptable pattern. Some people
add Reviewed-by before the S-o-B, others add Reviewed-by after the
S-o-B. Either is fine IMHO.


> > +Re-starting abandoned work
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +For a variety of reasons there are some patches that get submitted to
> > +QEMU but never merged. An unrelated contributor may decide (months or
> > +years later) to continue working from the abandoned patch and re-submit
> > +it with extra changes.
> > +
> > +If the abandoned patch already had a ``Signed-off-by`` from the original
> > +author this **must** be preserved.
> 
> I find some people added Originally-by, e.g., 8e86851bd6b9.
> 
> I guess if the code has been changed very significantly, or if the
> original implementation has just been referenced and significantly
> refactored, then Originally-by should be preferred instead of
> Signed-off-by from the original author, right?

If patch submitted still contains any code that can be considered
copyrightable (ie anything non-trivial) from the original author,
then I would expect the original authors Signed-off-by to be retained.

I think the cases where it is ok to use Originally-by, without a
Signed-off-by, would be exceedingly.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


