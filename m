Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66945C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:12:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme6-0005B2-Hc; Tue, 16 Jul 2024 14:11:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmdN-0001U5-V1
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sTmdM-0001J6-2R
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721153437;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=eK53RFe3Lr7Z4MN6VDoqBnIHRIZNVcloMZhH+vMF/O0=;
 b=P+kTXfL70hOL/Z+DVH4xHttLYUexMU+qKz06Da97XGfJHGRzFGYeMR+K1qtYd+8MwGY6cC
 VrgC+FMm9Rjxs8DaGJJ3LDUnceSeI+tVptPQvJHqg6S1+m4q2MZ9sIMEuwBaF5kK23EKzT
 yR402qM1C+MjUHFLa8/5cgg0F5t5BHs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-KQ22eXmBMsG3JeFQaU14Nw-1; Tue,
 16 Jul 2024 14:10:33 -0400
X-MC-Unique: KQ22eXmBMsG3JeFQaU14Nw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C2D2B1955D52; Tue, 16 Jul 2024 18:10:31 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.46])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 551951955D42; Tue, 16 Jul 2024 18:10:28 +0000 (UTC)
Date: Tue, 16 Jul 2024 19:10:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RFC PATCH 0/8] Convert avocado tests to normal Python unittests
Message-ID: <Zpa3kFjfNMf-ZDi1@redhat.com>
References: <20240711115546.40859-1-thuth@redhat.com>
 <CAFn=p-bMXm9qCD0hWiikyOmagFRryCZWrTx8xne9+x5j0QeNYQ@mail.gmail.com>
 <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbVdSDiJxNzv5TdUfOLLB=dLCkB0KgFQOxAcnG02gpDLA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 16, 2024 at 08:03:54PM +0200, Paolo Bonzini wrote:
> Il mar 16 lug 2024, 18:45 John Snow <jsnow@redhat.com> ha scritto:
> 
> > My only ask is that we keep the tests running in the custom venv
> > environment we set up at build time
> >
> 
> Yes, they do, however pytest should also be added to pythondeps.toml if we
> go this way.

Done in this patch:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg03596.html

> 
> > If we move to pytest, it's possible we can eliminate that funkiness, which
> > would be a win.
> >
> 
> There is the pycotap dependency to produce TAP from pytest, but that's
> probably something small enough to be vendored. And also it depends on what
> the dependencies would be for the assets framework.



> 
> > I'm also not so sure about recreating all of the framework that pulls vm
> > images on demand, that sounds like it'd be a lot of work, but maybe I'm
> > wrong about that.
> >
> 
> Yep, that's the part that I am a bit more doubtful about.

Pulling & caching VM images isn't much more than a URL download to 
a local file, not very complex in python. Assuming that's what you
are refering to, then it is already done in this patch:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg03598.html

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


