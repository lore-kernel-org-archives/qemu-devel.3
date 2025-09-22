Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2973CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:48:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0e5b-0005s3-Gw; Mon, 22 Sep 2025 06:48:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0e5Z-0005rc-5o
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:48:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0e5T-0006fe-1b
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758538081;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=WORoLsoj0sPuQBAA6v1y9xG6PaRABbxQin0DlUaVmyE=;
 b=Xixf2RhaICvmaL1M2CwkcV34W4eVXyZQ2t2J6WmkKt4q1r1oAXDeHrTdn/u5I3wMPelpv/
 IeEI8jqoHQ9QD9yBGNfsi81SrneHgVzyiYnMVuwlhEq6ESWGymxluiPPjaa/1/ovuq1cOl
 bD+nCRwPgspwLKUDBa+jfIDsCYquTm4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-317-GvSh-fMMN6-ZwEE2hzhwFg-1; Mon,
 22 Sep 2025 06:47:57 -0400
X-MC-Unique: GvSh-fMMN6-ZwEE2hzhwFg-1
X-Mimecast-MFC-AGG-ID: GvSh-fMMN6-ZwEE2hzhwFg_1758538076
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A152A19560A0; Mon, 22 Sep 2025 10:47:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EA7E1954128; Mon, 22 Sep 2025 10:47:53 +0000 (UTC)
Date: Mon, 22 Sep 2025 11:47:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Alessandro Ratti <alessandro@0x65c.net>, alex.bennee@linaro.org,
 alessandro.ratti@gmail.com, philmd@linaro.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
Message-ID: <aNEpVhkZ2r5e2Z9X@redhat.com>
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
 <87h5wulqm2.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h5wulqm2.fsf@pond.sub.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Mon, Sep 22, 2025 at 12:37:57PM +0200, Markus Armbruster wrote:
> Alessandro Ratti <alessandro@0x65c.net> writes:
> 
> > Replace virtio_error() with a macro that automatically prepends the
> > calling function name to error messages. This provides better context
> > for debugging virtio issues by showing exactly which function
> > encountered the error.
> >
> > Before: "Invalid queue size: 1024"
> > After:  "virtio_queue_set_num: Invalid queue size: 1024"
> >
> > The implementation uses a macro to insert __func__ at compile time,
> > avoiding any runtime overhead while providing more specific error
> > context than a generic "virtio:" prefix.
> 
> A need for function names and such in error messages suggests the error
> messages are crap.

I pretty much agree. If we take that view forwards, then I think our
coding guidelines should explicitly state something like

 "Function names must never be included in error messages.

  The messages need to be sufficiently descriptive in their
  text, such that including function names is redundant"

> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230

This is interesting as it shows a link to a previously proposed patch:

  https://patchwork.kernel.org/project/qemu-devel/patch/20220414112902.41390-1-codeguy.moteen@gmail.com/

this old patch just expanded the error messages to include 'Virtio '
in their text. I'm not going to claim this made new error messages
hugely user friendly, but I think that old patch approach was at
least conceptually better & preferrable to the function name
addition.

> > Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
> >
> > Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


