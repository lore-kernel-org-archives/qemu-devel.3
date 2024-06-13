Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B12C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 11:49:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHiwn-0001KR-3Q; Thu, 13 Jun 2024 07:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHiwk-0001Jy-Nw
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHiwi-0007zg-Ms
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 07:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718279326;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gi9kgl7VIhJKsb/4QodTRYyEiDMEhPf2l0Y5ncVCTP4=;
 b=Fu9rXNvTunjNyBehmsmUP5napAbRPIkqet2d8d9KGuDb+k129o+GuKrEwim7ueLSfCKL7s
 bpQsn0s8ZqOuw4upfhv1v0gLadn/dVMqNOROZKh0a7huElZAxuVvvhqOfZSPt7rsKh8/j1
 y0C6drQb9q7HVfprg0UP07vc+NptwM8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-439-EoTygGLvPTiMxLKeSjaN-A-1; Thu,
 13 Jun 2024 07:48:43 -0400
X-MC-Unique: EoTygGLvPTiMxLKeSjaN-A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE3BA19560AE; Thu, 13 Jun 2024 11:48:42 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.52])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7BF1A1956087; Thu, 13 Jun 2024 11:48:39 +0000 (UTC)
Date: Thu, 13 Jun 2024 12:48:35 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 18/20] qga: add note about where to disable commands for
 a platform
Message-ID: <ZmrckxgV0Qeljm-2@redhat.com>
References: <20240604134933.220112-1-berrange@redhat.com>
 <20240604134933.220112-19-berrange@redhat.com>
 <87msnrlx57.fsf@pond.sub.org> <ZmgPqjfWKsf6JgB9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZmgPqjfWKsf6JgB9@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Jun 11, 2024 at 09:49:46AM +0100, Daniel P. Berrangé wrote:
> On Tue, Jun 11, 2024 at 10:08:20AM +0200, Markus Armbruster wrote:
> > Daniel P. Berrangé <berrange@redhat.com> writes:
> > 
> > > Any command that is known to be unimplemented on a given build target
> > > must be disabled using a QAPI schema conditional. Only use dynamidc
> > 
> > Suggest "should be disabled", for consistency with the comment below.
> > 
> > s/dynamidc/dynamic/
> > 
> > > disabling for commands that require a runtime feature check.
> > >
> > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > ---
> > >  qga/commands-posix.c | 8 +++++++-
> > >  qga/commands-win32.c | 8 +++++++-
> > >  2 files changed, 14 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/qga/commands-posix.c b/qga/commands-posix.c
> > > index f4104f2760..8f09162562 100644
> > > --- a/qga/commands-posix.c
> > > +++ b/qga/commands-posix.c
> > > @@ -1136,7 +1136,13 @@ error:
> > >  
> > >  #endif /* HAVE_GETIFADDRS */
> > >  
> > > -/* add unsupported commands to the list of blocked RPCs */
> > > +/*
> > > + * Add commands that cannot be supported based on the results of
> > > + * dynamic check of the running OS installation.
> > > + *
> > > + * Commands that cannot be supported at all on a given platform
> > > + * should be disabled with a condition in the QAPI schema.
> > > + */
> > >  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> > >  {
> > >      return blockedrpcs;
> > > diff --git a/qga/commands-win32.c b/qga/commands-win32.c
> > > index 2533e4c748..0198e37a96 100644
> > > --- a/qga/commands-win32.c
> > > +++ b/qga/commands-win32.c
> > > @@ -1958,7 +1958,13 @@ done:
> > >      g_free(rawpasswddata);
> > >  }
> > >  
> > > -/* add unsupported commands to the list of blocked RPCs */
> > > +/*
> > > + * Add commands that cannot be supported based on the results of
> > > + * dynamic check of the running OS installation.
> > > + *
> > > + * Commands that cannot be supported at all on Wnidows
> > 
> > s/Wnidows/Windows/
> > 
> > > + * should be disabled with a condition in the QAPI schema.
> > > + */
> > >  GList *ga_command_init_blockedrpcs(GList *blockedrpcs)
> > >  {
> > >      if (!vss_init(true)) {
> > 
> > Both functions will be unused after PATCH 20.  Remove them there, and
> > drop this patch?
> 
> Hmm, they shouldn't be unused. I've made a mistake in Patch 20.
> 
> We still need to run these methods, since the Windows impl has todo
> a runtime check to determine whether snapshot APIs are supported by
> the system or not - that's the vss_init() call just seen in the
> diff context here.

Based on our discussion about vss_init() handling, these methods will
indeed end up unused, so I will delete them entirely in the last
patch which removes their only usage.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


