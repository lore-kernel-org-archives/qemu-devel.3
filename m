Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535EDE77170
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 11:57:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJATc-0001EC-8F; Thu, 05 Dec 2024 06:57:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJATZ-0001Cn-Ch
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:56:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJATX-0001Lv-Ir
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 06:56:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733399814;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dYtptort2XCu9za9fsNdLONdvSRVpuu0VOjCgad4VYY=;
 b=XAYT8ZguKxKp8sgpV9QP+bwIjIc2G2/Uo+xoBk7E5xWJrCJRxM0KmmTXk+/k+dDjSV3Dq8
 0vvX/YpEHtIrZVpB9HKgWgP2oQ5SYr+Nj903Bh2Bx6SmUaFLhpj0B8RV0Y7dsqOhOf9A9C
 aSdzd0Q+pprITHUGUnrcWJEvBvWujjk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-ofM8N-qwMPaccHSP_VXAmg-1; Thu,
 05 Dec 2024 06:56:52 -0500
X-MC-Unique: ofM8N-qwMPaccHSP_VXAmg-1
X-Mimecast-MFC-AGG-ID: ofM8N-qwMPaccHSP_VXAmg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3C7D1956048; Thu,  5 Dec 2024 11:56:51 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6823D3000197; Thu,  5 Dec 2024 11:56:48 +0000 (UTC)
Date: Thu, 5 Dec 2024 11:56:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: QEMU wiki theme table of contents changes
Message-ID: <Z1GU_Md8uH0Cbesm@redhat.com>
References: <ZzXV-KyYLa-7yNdV@redhat.com>
 <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
 <ZzcMQeHfBTm2iEsc@redhat.com>
 <CAJSP0QVPiibdfs1YsYMe0Mk-DX-Xy7f+utG=W4eSpBkdzaodGg@mail.gmail.com>
 <ZzejHlGw3RJzc-Jk@redhat.com> <20241119195429.GE340853@fedora>
 <Zz9WPMgmY1aAfw8x@redhat.com> <20241204212619.GE48585@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241204212619.GE48585@fedora>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Dec 04, 2024 at 04:26:19PM -0500, Stefan Hajnoczi wrote:
> On Thu, Nov 21, 2024 at 03:48:12PM +0000, Daniel P. Berrangé wrote:
> > On Tue, Nov 19, 2024 at 02:54:29PM -0500, Stefan Hajnoczi wrote:
> > > On Fri, Nov 15, 2024 at 07:38:06PM +0000, Daniel P. Berrangé wrote:
> > > > On Fri, Nov 15, 2024 at 02:21:12PM -0500, Stefan Hajnoczi wrote:
> > > > > On Fri, 15 Nov 2024 at 03:54, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > >
> > > > > > On Thu, Nov 14, 2024 at 02:04:35PM -0500, Stefan Hajnoczi wrote:
> > > > > > > On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > > > > > >
> > > > > > > > Looking at
> > > > > > > >
> > > > > > > >   https://wiki.qemu.org/ChangeLog/9.2
> > > > > > > >
> > > > > > > > I'm thinking that I'm sure there used to be a table of contents present
> > > > > > > > at the top of pages, but none is to be seen..... until I eventually
> > > > > > > > discover that there's a bare noticable, fully collapsed ToC in the left
> > > > > > > > hand nav panel below all the general wiki nav links, partially off the
> > > > > > > > bottom of the page :-(
> > > > > > > >
> > > > > > > > If going to https://wiki.qemu.org/Special:Preferences, "Appearance" and
> > > > > > > > selecting "Vector legacy (2010)" as the "Skin" instad of "Vector (2022)"
> > > > > > > > then the full ToC re-appears at the top of page in the main body content.
> > > > > > > >
> > > > > > > > I'm presuming this style change was triggered by a software upgrade that
> > > > > > > > was done on the wiki at some point.
> > > > > > > >
> > > > > > > > IMHO this is quite a significant visual/usability regression.
> > > > > > > >
> > > > > > > > On wikipedia, they do have the same theme, with ToC in the left hand
> > > > > > > > panel, but their ToC is expanded by default, and there's no other general
> > > > > > > > navigation in the left hand panel that's displacing the ToC off the bottom
> > > > > > > > of the page. That is fairly effective as a layout.
> > > > > > > >
> > > > > > > > We can do something to the QEMU skin to improve this ? Swapping order
> > > > > > > > of the ToC & general nav blocks in the left hand panel would be a
> > > > > > > > improvement, as well making it expand at least 1 further level by
> > > > > > > > default.
> > > > > > > >
> > > > > > > > If we're going to have background colour set for the general nav block,
> > > > > > > > we should also probably do similar for the ToC nav block to make it
> > > > > > > > visually stand out to the same degree.
> > > > > > >
> > > > > > > Yes, that sounds good. The quickest would be for you to:
> > > > > > > 1. Run https://hub.docker.com/_/mediawiki/ in a container on your machine.
> > > > > > > 2. Adjust the theme CSS until you are happy.
> > > > > > > 3. Send me the tweaks and I will apply them to wiki.qemu.org.
> > > > > >
> > > > > > Is the current QEMU mediawiki code (or just theme) published anywhere
> > > > > > that I can base work off ?
> > > > > 
> > > > > The QEMU wiki runs from the vanilla mediawiki 1.39 container image.
> > > > > The Vector (2022) theme comes with Mediawiki and there are no
> > > > > QEMU-specific customizations.
> > > > > 
> > > > > You can get the same look with the vanilla Mediawiki container image
> > > > > with the following in LocalSettings.php:
> > > > > $wgDefaultSkin = "vector-2022";
> > > > > wfLoadSkin('Vector');
> > > > 
> > > > Hmm, I'm wondering where the QEMU specific left nav bar content
> > > > and styling comes from then... ? 
> > > 
> > > I'm not sure but unless there is something stored in the database, I
> > > can't imagine any customizations because there aren't any config files,
> > > themes, CSS overrides, etc to speak of in QEMU's MediaWiki installation.
> > > It's just running the vanilla container image.
> > 
> > Ah, I found out  we've done it with the side-bar addon
> > 
> >   https://wiki.qemu.org/MediaWiki:Sidebar
> 
> Is there a fix I can apply to the wiki configuration?

Not yet, as I've not been able to make time to fully investigate and
work on this.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


