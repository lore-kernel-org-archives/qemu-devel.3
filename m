Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE21CA0ED3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2024 08:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sl2ma-00068T-CE; Mon, 02 Sep 2024 04:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sl2mS-00067O-CP
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:51:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sl2mP-0005Ok-Fi
 for qemu-devel@nongnu.org; Mon, 02 Sep 2024 04:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725267077;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=jnlzECUY+Se6ZSTUhm9tRkIgyL1Xrghqr8SNsnO6MdI=;
 b=XTTT8TWxT0HzErmmqb4mYUprKcVjQDnd34gCKWgPkeeTtRLo5wAzsmsjcrdE+qAzrY/nwf
 e8WBssmRZKcsxxZYKZu0CCh/8hwwXROPHz3fw+CBsyx6pcce370hdj5J2QWno/XgBhuCOJ
 PlMxCwIZnUeC7NkP3McS64IGsOInOEQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-104-wxJDNr3FO_ePfimQPZg1Bw-1; Mon,
 02 Sep 2024 04:51:14 -0400
X-MC-Unique: wxJDNr3FO_ePfimQPZg1Bw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9536C19560B7; Mon,  2 Sep 2024 08:51:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C89031956052; Mon,  2 Sep 2024 08:51:08 +0000 (UTC)
Date: Mon, 2 Sep 2024 09:51:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Beraldo Leal <bleal@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 7/8] python/qapi: move scripts/qapi to python/qemu/qapi
Message-ID: <ZtV8eQfPyuuwHHkq@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
 <20240820002318.1380276-8-jsnow@redhat.com>
 <87bk1acl4s.fsf@pond.sub.org>
 <CAFn=p-a=ob68-_8fkfFMj2AkVtOgL081j4d385n1qXMsN+ehFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFn=p-a=ob68-_8fkfFMj2AkVtOgL081j4d385n1qXMsN+ehFQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Fri, Aug 30, 2024 at 02:22:50PM -0400, John Snow wrote:
> Gave Dan a related answer. For you, my explanation is:
> 
> - It's nice to have just one configuration for static analysis in just one
> place
> - It's nice to have that configuration follow python ecosystem norms
> - It's nice to use standard python management tools to configure and test
> the supported versions of static analysis tools, again kept in one place.
> - Just moving the folder costs virtually nothing.
> - Moving it here makes it easier for me to test the eventual integration
> with make check in one place.
> - I like being able to say that anything under `python/` is fiercely
> guarded by high standards (and the gitlab pipelines) and everything else is
> not. I consider this to be organizationally simple and easy to communicate.
> i.e., I find it attractive to say that "python is maintained, scripts are
> YMMV." I am *not* willing to maintain everything under `scripts/` with the
> same level of effort I apply to `python/`. I think it's important to allow
> people to commit low-development-cost scripts ("contrib quality") that they
> can run from time to time and not everything needs to be held to a
> crystalline perfect standard, but some stuff does.

FYI, I was NOT suggesting that you maintain anything under scripts/.

Rather I'm saying that if we want to apply python code standards, we
should (ultimately) apply them to all python code in the tree, and
that *ALL* maintainers and contributors should comply.

Consider our C standards - we don't apply them selectively to a subset
of the tree - we expect all maintainers to comply. I'd like us to have
the same be true of Python.

The only real issue we have with python standards is bringing existing
code upto par, before we can enable the checks.

Currently we have no easy way for other maintainers to enable their
python code be checked, without moving their code under python/ which
is undesirable IMHO.

If we move the python coding standards to meson.build, such that apply
to all of the source tree, and then exclude everything except python/,
we make it easier for other maintainers to bring stuff upto par. All
need do at that point is remove the exclusion rule for files incrementally
as they fix them.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


