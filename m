Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82804D6DDEC
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2024 08:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBs6D-00066Y-Ll; Fri, 15 Nov 2024 03:54:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBs6A-00066D-SP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:54:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tBs68-0005mm-JA
 for qemu-devel@nongnu.org; Fri, 15 Nov 2024 03:54:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731660874;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7hY3tljoPbYDIKYavyaK8la6oO6stZraQHNVp1e0Uvk=;
 b=ivlgZacIhOn7bFHqXUzlzwHHG6hlothCHvc8sm4twvfwHnj/iouDMecxAEK3PCxuYXZJTt
 bvVW+1L+BVEWN5JXO23KKvhYZCoE8OIerSvPo5NCump24zJbZXhJSuOAluMtqCZRdAeWms
 3WUEOagGmForSTdf9skRleEMiWtugnE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-xosa2gDDOeSlxDTRpq_YWA-1; Fri,
 15 Nov 2024 03:54:31 -0500
X-MC-Unique: xosa2gDDOeSlxDTRpq_YWA-1
X-Mimecast-MFC-AGG-ID: xosa2gDDOeSlxDTRpq_YWA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E43C1955F42; Fri, 15 Nov 2024 08:54:30 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.102])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A75D91956054; Fri, 15 Nov 2024 08:54:28 +0000 (UTC)
Date: Fri, 15 Nov 2024 08:54:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: QEMU wiki theme table of contents changes
Message-ID: <ZzcMQeHfBTm2iEsc@redhat.com>
References: <ZzXV-KyYLa-7yNdV@redhat.com>
 <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUkfSO3uXPjZCxNfCfVwwWBBy6u5a=PjqqnMZSxE95YpA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 14, 2024 at 02:04:35PM -0500, Stefan Hajnoczi wrote:
> On Thu, 14 Nov 2024 at 05:51, Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > Looking at
> >
> >   https://wiki.qemu.org/ChangeLog/9.2
> >
> > I'm thinking that I'm sure there used to be a table of contents present
> > at the top of pages, but none is to be seen..... until I eventually
> > discover that there's a bare noticable, fully collapsed ToC in the left
> > hand nav panel below all the general wiki nav links, partially off the
> > bottom of the page :-(
> >
> > If going to https://wiki.qemu.org/Special:Preferences, "Appearance" and
> > selecting "Vector legacy (2010)" as the "Skin" instad of "Vector (2022)"
> > then the full ToC re-appears at the top of page in the main body content.
> >
> > I'm presuming this style change was triggered by a software upgrade that
> > was done on the wiki at some point.
> >
> > IMHO this is quite a significant visual/usability regression.
> >
> > On wikipedia, they do have the same theme, with ToC in the left hand
> > panel, but their ToC is expanded by default, and there's no other general
> > navigation in the left hand panel that's displacing the ToC off the bottom
> > of the page. That is fairly effective as a layout.
> >
> > We can do something to the QEMU skin to improve this ? Swapping order
> > of the ToC & general nav blocks in the left hand panel would be a
> > improvement, as well making it expand at least 1 further level by
> > default.
> >
> > If we're going to have background colour set for the general nav block,
> > we should also probably do similar for the ToC nav block to make it
> > visually stand out to the same degree.
> 
> Yes, that sounds good. The quickest would be for you to:
> 1. Run https://hub.docker.com/_/mediawiki/ in a container on your machine.
> 2. Adjust the theme CSS until you are happy.
> 3. Send me the tweaks and I will apply them to wiki.qemu.org.

Is the current QEMU mediawiki code (or just theme) published anywhere
that I can base work off ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


