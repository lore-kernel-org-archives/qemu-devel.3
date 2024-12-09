Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C27E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 16:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKgpl-0007NX-FS; Mon, 09 Dec 2024 11:42:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgpd-0007N9-Tw
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tKgpb-0005gO-Ou
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 11:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733762518;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q9MacFyGwwzAJdWpb86VGf8s3l5d57vU4b1QCnUIxjM=;
 b=QwwyT6yliXFzVeD7p47RjTIakGaLpTZpauuHCMLn9RhEhxKWOw/vaNegGOmuKUWOaQjnkF
 l8/O4xrgmD+a9yW+LdztojXY8UUVmWQuJzE/Jyms9C5u6r6bkmgnkyvrauMffNBkSVSDPt
 zEdUaGS71zFePtm6Hb1rAAm8GxDYEBc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-pYzJKqE1PeaPdefAs7kmHQ-1; Mon,
 09 Dec 2024 11:41:54 -0500
X-MC-Unique: pYzJKqE1PeaPdefAs7kmHQ-1
X-Mimecast-MFC-AGG-ID: pYzJKqE1PeaPdefAs7kmHQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A58B71944B0A; Mon,  9 Dec 2024 16:41:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A5F719560A2; Mon,  9 Dec 2024 16:41:52 +0000 (UTC)
Date: Mon, 9 Dec 2024 16:41:48 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH] docs: replace 'Edit on GitLab' with 'View page source'
Message-ID: <Z1cdzHSY60vznLEf@redhat.com>
References: <20241209163506.2089961-1-berrange@redhat.com>
 <f56fe179-0c48-45ac-b85d-6fbbe27de991@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f56fe179-0c48-45ac-b85d-6fbbe27de991@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.489,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Dec 09, 2024 at 05:38:49PM +0100, Philippe Mathieu-Daudé wrote:
> On 9/12/24 17:35, Daniel P. Berrangé wrote:
> > QEMU takes contributions via the mailing list, so while you can edit a
> > file on gitlab and then switch to the terminal to send a patch, the
> > wording 'Edit on GitLab' strongly suggests we take merge requests.
> > 
> > Switching back to "View page source" is a more agnostic term that does
> > not imply a particular contribution approach, that we had used in QEMU
> > before:
> > 
> >    commit 73e6aec6522e1edd63f631c52577b49a39bc234f
> >    Author: Marc-André Lureau <marcandre.lureau@redhat.com>
> >    Date:   Tue Mar 23 15:53:28 2021 +0400
> > 
> >      sphinx: adopt kernel readthedoc theme
> > 
> 
> Is this:
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2709
> ?

I won't really claim it resolves that, as that issues is showing
lots of user confusion, most of which is not in our control.

> 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   docs/conf.py | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/docs/conf.py b/docs/conf.py
> > index c11a6ead8a..164a8ee8b2 100644
> > --- a/docs/conf.py
> > +++ b/docs/conf.py
> > @@ -186,7 +186,7 @@
> >   ]
> >   html_context = {
> > -    "display_gitlab": True,
> > +    "source_url_prefix": "https://gitlab.com/qemu-project/qemu/-/blob/master/docs/",
> >       "gitlab_user": "qemu-project",
> >       "gitlab_repo": "qemu",
> >       "gitlab_version": "master",
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


