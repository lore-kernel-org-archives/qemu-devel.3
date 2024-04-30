Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D302C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kGN-0006f2-7h; Tue, 30 Apr 2024 05:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kGL-0006ZB-F7
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s1kGF-0000S8-Ag
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714471134;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kU9pPNikDf5lRccmsUFAiHv61aQpHgC9/O4y40MQER0=;
 b=PV9GYxF8jZhfjkGEzjcl4QZJjiK/pRbJ9oDKzwRGDYpQJfJ+8auwx0KH2Dhy2LBzD4Xgni
 Z9YXDYLJkg20u9CvYWIP/oD+qbLDW5kkoM7DWBJm5yR3OiJlw33gMBtePfGnJPJy9Vy77q
 lDX40gd6hDWf6d7r9GTtsAvyxLXPCn0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-na2ixJT1OwGlPqBXRFTMlg-1; Tue, 30 Apr 2024 05:58:50 -0400
X-MC-Unique: na2ixJT1OwGlPqBXRFTMlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D82580591B;
 Tue, 30 Apr 2024 09:58:49 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.59])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D28161C0F141;
 Tue, 30 Apr 2024 09:58:47 +0000 (UTC)
Date: Tue, 30 Apr 2024 10:58:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, devel@lists.libvirt.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] docs/about: Automatically deprecate versioned machine
 types older than 6 years
Message-ID: <ZjDA1BFQwo19FLam@redhat.com>
References: <20240430064529.411699-1-thuth@redhat.com>
 <e0e836cf-f080-45f4-a71b-060dd2c90279@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e0e836cf-f080-45f4-a71b-060dd2c90279@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Apr 30, 2024 at 11:40:42AM +0200, Philippe Mathieu-Daudé wrote:
> Hi Thomas,
> 
> On 30/4/24 08:45, Thomas Huth wrote:
> > Old machine types often have bugs or work-arounds that affect our
> > possibilities to move forward with the QEMU code base (see for example
> > https://gitlab.com/qemu-project/qemu/-/issues/2213 for a bug that likely
> > cannot be fixed without breaking live migration with old machine types,
> > or https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg04516.html or
> > commit ea985d235b86). So instead of going through the process of manually
> > deprecating old machine types again and again, let's rather add an entry
> > that can stay, which declares that machine types older than 6 years are
> > considered as deprecated automatically. Six years should be sufficient to
> > support the release cycles of most Linux distributions.
> 
> Thanks for taking that out of my plate :)
> 
> IIRC 6 years was because of some old RHEL version, otherwise could
> 5 years be enough? (maybe it could be good enough for this old RHEL
> version as of QEMU v10.0).

With my RHEL hat on, 6 years gives an approximate alignment with
RHEL lifecycles, which have ended up being roughly 3 years apart.
RHEL-N, wants to support all machine types from RHEL-(N-1), so
in the worst case that gives up to 6 years worth of QEMU versions.

5 years could well be enough in many cases, depending on how
frequently RHEL rebases QEMU, but could also trip us up if the
timelines do something unexpected. So 6 years is a bit safer
from Red Hat's POV, if the community is willing.

> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   docs/about/deprecated.rst | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 6d595de3b6..fe69e2d44c 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -220,6 +220,17 @@ is a chance the code will bitrot without anyone noticing.
> >   System emulator machines
> >   ------------------------
> > +Versioned machine types older than 6 years
> > +''''''''''''''''''''''''''''''''''''''''''
> > +
> > +Starting with the release of QEMU 10.0, versioned machine types older than
> 
> Why can't we start with QEMU 9.1?
> 
> > +6 years will automatically be considered as deprecated and might be due to
> > +removal without furthor notice. For example, this affects machine types like
> > +pc-i440fx-X.Y, pc-q35-X.Y, pseries-X.Y, s390-ccw-virtio-X.Y or virt-X.Y where
> > +X is the major number and Y is the minor number of the old QEMU version.
> > +If you are still using machine types from QEMU versions older than 6 years,
> > +please update your setting to use a newer versioned machine type instead.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


