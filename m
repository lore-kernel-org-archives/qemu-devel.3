Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36DD5D65C74
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 11:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBXnL-0008JC-Qe; Thu, 14 Nov 2024 06:13:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXnL-0008J1-5T
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:13:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tBXnJ-0002Ae-IF
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 06:13:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731582828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rd9TfXx4AVSdw8dcZSg0NDdVDwa30ZWHJYtmHZBD2DE=;
 b=g4RTTo/hANEC+aI9CLj8at3g7MDvPwGpH/PHhvoqUtcBI95jzECWCvfamF+98Gv0ZnlFtF
 dsNcvcFgsRPYf3NnhXOGJXMAST2ofQe6hWm5jSamwvwIde7KLgbdFwZBRQkLBzrA2CDXHi
 7PHOfud/fz7HmgQwDbH2cVdmZ7rU5zc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-G-8sv0TGO82SnBMOPjcPNA-1; Thu,
 14 Nov 2024 06:13:47 -0500
X-MC-Unique: G-8sv0TGO82SnBMOPjcPNA-1
X-Mimecast-MFC-AGG-ID: G-8sv0TGO82SnBMOPjcPNA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5846D195604F; Thu, 14 Nov 2024 11:13:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.193.143])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BDBB1956054; Thu, 14 Nov 2024 11:13:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E74B018009A1; Thu, 14 Nov 2024 12:13:43 +0100 (CET)
Date: Thu, 14 Nov 2024 12:13:43 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] edk2: update submodule to edk2-stable202408.01
Message-ID: <m6k4oa4fnx3cm36iu3n2plewrftomdjts5ht4vmr6dlxdsm6zp@7sbnkmos7ezd>
References: <20241111100701.2620020-1-kraxel@redhat.com>
 <CAFEAcA83zip4PnAxjQp-Qiquwzqf=cVwRmxsKGeyAXvqwzg=qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA83zip4PnAxjQp-Qiquwzqf=cVwRmxsKGeyAXvqwzg=qw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.119,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.738,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Nov 13, 2024 at 03:57:58PM +0000, Peter Maydell wrote:
> On Mon, 11 Nov 2024 at 10:07, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Updates the subhook submodule to point to a edk2 mirror repo.
> > Fixes recursive cloning of the edk2 submodule.
> >
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2660
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > ---
> >  roms/edk2 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/roms/edk2 b/roms/edk2
> > index b158dad150bf..4dfdca63a934 160000
> > --- a/roms/edk2
> > +++ b/roms/edk2
> > @@ -1 +1 @@
> > -Subproject commit b158dad150bf02879668f72ce306445250838201
> > +Subproject commit 4dfdca63a93497203f197ec98ba20e2327e4afe4
> > --
> > 2.47.0
> 
> Shouldn't this also come with an update of the binaries?
> I know that in this case there's not supposed to be any
> change to the edk sources, but I kind of expected that the
> process of "update the edk submodule" ought to be
> standardised to the extent that it would produce new
> binary blobs to match the submodule bump.

That is an exception.  This adds only one commit, which changes the
'subhook' submodule URL to point to a different location (a mirror repo
in the tianocore project).  So it doesn't carry any actual code changes.

But it is needed if you want do a local build (without already having a
'subhook' submodule clone) because the old repo location is gone ...

take care,
  Gerd


