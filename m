Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A31D38FEF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg4OA-0002i1-7c; Wed, 14 Jan 2026 12:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg4O5-0002he-WA
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:10:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vg4O4-00030t-6d
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768410627;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AI9RdcZbajsIx5VU3ZuGZoSneiPB/ulx87ArkuvAkcE=;
 b=GN9zgeI6VgRj1ZvHb/GG+s1djNrkA0Wy4mZGrjamf9Hygjh2NMKFeA4CTO8pQ2bTy90smm
 2DB9r16IU2m64gpOOuPTIvQ04+5JdeRdgSi8hSf+J0TDG2yN+v03ril0/VodqTJGLpVX54
 u5pJDGV4lhMjQADf2/gPQAcxulV9KI4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-QIrRSM3iPS2TUXF90A_gfA-1; Wed,
 14 Jan 2026 12:10:20 -0500
X-MC-Unique: QIrRSM3iPS2TUXF90A_gfA-1
X-Mimecast-MFC-AGG-ID: QIrRSM3iPS2TUXF90A_gfA_1768410619
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE30195605F; Wed, 14 Jan 2026 17:10:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.41])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE7B51955F44; Wed, 14 Jan 2026 17:10:16 +0000 (UTC)
Date: Wed, 14 Jan 2026 17:10:13 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: Re: [PATCH v2 01/13] Revert "python/aqmp: fix send_fd_scm for python
 3.6.x"
Message-ID: <aWfN9R80SPECbx8L@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-2-berrange@redhat.com>
 <750a94b8-2209-4c3e-bf69-761f33b0498c@redhat.com>
 <CAFn=p-brRTbhYHEs63Ubzw47-7wx3PwMX+RBaPFfpHROBiFyfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-brRTbhYHEs63Ubzw47-7wx3PwMX+RBaPFfpHROBiFyfA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Jan 14, 2026 at 11:57:23AM -0500, John Snow wrote:
> On Tue, Jan 13, 2026 at 2:17 AM Thomas Huth <thuth@redhat.com> wrote:
> >
> > On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> > > This reverts commit a57cb3e23d5ac918a69d0aab918470ff0b429ff9.
> > >
> > > The current code now only requires compatibility with Python
> > > 3.8 or later.
> > >
> > > The conditional usage of 'sendmsg' on the async IO socket
> > > wrapper will generate a deprecation warning on stderr
> > > every time send_fd_scm is used with older Python versions.
> > >
> > > This has the effect of breaking the QEMU I/O tests when run
> > > on Python versions before the 'sendmsg' wrapper was removed.
> > >
> > > Unconditionally accessing 'sock._sock' ensures we never use
> > > the asyncio socket wrapper, and thus never risk triggering
> > > deprecation warnings on any Python version
> > >
> > > Most notably this fixes the QEMU block I/O tests on CentOS
> > > Stream9 that use "sendmsg" for FD passing, which otherwise
> > > generate deprecation messages breaking the expected output
> > > comparison.
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >   python/qemu/qmp/qmp_client.py | 9 +++------
> > >   1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> OK, please merge this with my blessing and I will worry about the
> standalone repo afterwards.

We already merged it there with:

  https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/45

> 
> Acked-by: John Snow <jsnow@redhat.com>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


