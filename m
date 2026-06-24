Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1EC6CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcMkt-0006aG-Fq; Wed, 24 Jun 2026 08:30:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMko-0006PP-7M
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:30:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wcMkl-0004N9-TG
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 08:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782304251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwmtkIwBbraDh4cI8RTGYyouLgt3/7528pT26yA/XW8=;
 b=UoM+LHo5TE48lyq5XlFr6w3zcG+m5Q1sktATt5I10XFVn2qadewk3FfvxiSJZM36g8muZU
 OwXzRwNR57rZ4vvi4pr+CRiA79Zndjf/qq1zFXxmnA59cs42intZJhe3j07WWKbZPRfoGs
 cJjcIcuGhP8fOcIuuca3eeUSTy3blFI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-ld3-FQw4N1uMiwjNE-E_GQ-1; Wed,
 24 Jun 2026 08:30:48 -0400
X-MC-Unique: ld3-FQw4N1uMiwjNE-E_GQ-1
X-Mimecast-MFC-AGG-ID: ld3-FQw4N1uMiwjNE-E_GQ_1782304246
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C7A118009D4; Wed, 24 Jun 2026 12:30:46 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.57])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8383930001A7; Wed, 24 Jun 2026 12:30:45 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:30:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] MAINTAINERS: record known Git Lab handles for all
 maintainers
Message-ID: <ajvN8nluiWdpeI3t@redhat.com>
References: <20260622113152.1710585-1-berrange@redhat.com>
 <20260622113152.1710585-3-berrange@redhat.com>
 <55d966a8-7698-421a-8265-2235d5fe104a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <55d966a8-7698-421a-8265-2235d5fe104a@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 22, 2026 at 10:36:43PM +0200, Philippe Mathieu-Daudé wrote:
> Hi Daniel,
> 
> On 22/6/26 13:31, Daniel P. BerrangÃ© wrote:
> > This updates MAINTAINERS with a "G:" line corresponding to every
> > "M:" line that can be identified with a match against
> > 
> >    https://gitlab.com/qemu-project/qemu/-/project_members
> > 
> > This update was done using a largely automated process based on
> > the data extracted with
> > 
> >    $ glab api --paginate /projects/qemu-project%2fqemu/members | jq -c '.[] | {username, name}'
> >    $ glab api --paginate /groups/qemu-project/members | jq -c '.[] | {username, name}'
> > 
> > Some Git Lab accounts had real names that didn't have an exact
> > match in MAINTAINERS so the glab api data was manually pre-processed
> > to change those names.
> > 
> > A Perl script was then used to insert "G:" lines for every "M:"
> > lines.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   MAINTAINERS | 332 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 332 insertions(+)


> > @@ -84,13 +92,16 @@ Responsible Disclosure, Reporting Security Issues
> >   -------------------------------------------------
> >   W: https://wiki.qemu.org/SecurityProcess
> >   M: Michael S. Tsirkin <mst@redhat.com>
> > +G: @mstredhat
> >   L: qemu-security@nongnu.org
> >   Trivial patches
> >   ---------------
> >   Trivial patches
> >   M: Michael Tokarev <mjt@tls.msk.ru>
> > +G: @mjt0k
> >   M: Laurent Vivier <laurent@vivier.eu>
> > +G: @lvivier
> >   S: Maintained
> >   L: qemu-trivial@nongnu.org
> >   K: ^Subject:.*(?i)trivial
> 
> This is an approach, and it does the job, but I'm worried about its
> maintainability. Since there is 1 handle per email, what about a
> .gitlabmap similar to .mailmap, a key:value mail:gitlab handle?

I've sent a v2 which tries this approach and I think it is somewhat
nicer.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


