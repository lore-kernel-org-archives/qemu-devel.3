Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E347606A31F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IXv/CK+w
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmhY-0004mw-5X; Fri, 30 Oct 2026 09:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMmhP-0004lt-78
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:31:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xMmhM-00077f-ED
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793367070;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=izoQHwHhiH5/xBdWc8K1PLaO00W7P3CzHjlWgRdNZYc=;
 b=IXv/CK+w11HiUHXp716hPi+nC6T36YAGNQ364O3kfblUAr41QVWxo8ywnugBEu7BZScF3/
 oik8QbNxdK3xbvYa2KhtG9jL95nKK+6pWoiEN59Df5vP4uHoN2PbiYIhmVPs++vRMYwwUE
 idtAAJK+LEJuS/fYKJ5tWc2/5qsCNjs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-394-SXjWdkgYP7qdcQIBLS_EJw-1; Fri,
 30 Oct 2026 09:31:09 -0400
X-MC-Unique: SXjWdkgYP7qdcQIBLS_EJw-1
X-Mimecast-MFC-AGG-ID: SXjWdkgYP7qdcQIBLS_EJw_1793367068
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3751919560BA
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:31:08 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F7A30001A4; Fri, 30 Oct 2026 13:31:06 +0000 (UTC)
Date: Fri, 30 Oct 2026 13:31:03 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 2/8] qapi: add 'warn' option to CompatPolicyInput
Message-ID: <auScF8ijrIuSB1PN@redhat.com>
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-3-berrange@redhat.com>
 <179336456126.3884549.17845152643994856593.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179336456126.3884549.17845152643994856593.b4-review@b4>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 04:49:21PM +0400, marcandre.lureau@redhat.com wrote:
> > This prints a warning on stderr every time a policy violation
> > is encountered, but accepts the input.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20261028133603.1893289-3-berrange@redhat.com>
> > ---
> >  qapi/compat.json |  4 +++-
> >  qapi/qapi-util.c |  4 ++++
> >  qemu-options.hx  | 12 ++++++++----
> >  3 files changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/qapi/compat.json b/qapi/compat.json
> > index 0f90ea1f5241..dfa3fea05778 100644
> > --- a/qapi/compat.json
> > +++ b/qapi/compat.json
> > @@ -17,10 +17,12 @@
> >  #
> >  # @crash: abort() the process
> >  #
> > +# @warn: Accept with a warning printed to stderr (Since: 11.2)
> > +#
> >  # Since: 6.0
> >  ##
> >  { 'enum': 'CompatPolicyInput',
> > -  'data': [ 'accept', 'reject', 'crash' ] }
> > +  'data': [ 'accept', 'reject', 'crash', 'warn' ] }
> >  
> >  ##
> >  # @CompatPolicyOutput:
> > diff --git a/qapi/qapi-util.c b/qapi/qapi-util.c
> > index 93898f57a055..f81a171a5b16 100644
> > --- a/qapi/qapi-util.c
> > +++ b/qapi/qapi-util.c
> > @@ -28,6 +28,10 @@ static bool compat_policy_input_ok1(CompatPolicyInput policy,
> >      switch (policy) {
> >      case COMPAT_POLICY_INPUT_ACCEPT:
> >          return true;
> > +    case COMPAT_POLICY_INPUT_WARN:
> > +        warn_report("%s %s %s disabled by policy",
> 
> rather: "Deprecated %s.. accepted by policy"?

Yes, it should say 'accepted'.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


