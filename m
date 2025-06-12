Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C42AC71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 14:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPj6u-0004gZ-Ew; Thu, 12 Jun 2025 10:40:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPj6r-0004ej-Tx
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:40:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uPj6q-0001BA-1J
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 10:40:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749739250;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dJapHiBn49sRKRzhx/LxPxMXqNyHC+xklEK5reZxTr8=;
 b=DI/kTdrPJZzXkIC+ST5E7enwM0EH8Vb6uvZcCMYrmPtpXAsdvAZw86Jpta2sWVRM2jUW9i
 HQzg3uuSwLa3eAEoQYABEiHGhUCUT1heSy4R1wmtlzbvE6WWgtyWILe2j2y61ANvMTY6pz
 dsKIjYTZwX8DC+XCb7o4pn7k/T70tmE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-SaXLKfmsNImr0aSMM-_SQA-1; Thu,
 12 Jun 2025 10:40:49 -0400
X-MC-Unique: SaXLKfmsNImr0aSMM-_SQA-1
X-Mimecast-MFC-AGG-ID: SaXLKfmsNImr0aSMM-_SQA_1749739248
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E40919560AE; Thu, 12 Jun 2025 14:40:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.113])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD22F195E340; Thu, 12 Jun 2025 14:40:45 +0000 (UTC)
Date: Thu, 12 Jun 2025 15:40:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
Message-ID: <aErm6omt7VSljvwJ@redhat.com>
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
 <4ftyylwfpk2d6xioduftadbbwq3cydjmzeaqivksseem4a2h5d@xg7u6y6qaaak>
 <CAJSP0QU-msg=bTwODkB5VPoiwMcDC_ozN=7MuG5tFDNiNDNOKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QU-msg=bTwODkB5VPoiwMcDC_ozN=7MuG5tFDNiNDNOKg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 12, 2025 at 10:33:03AM -0400, Stefan Hajnoczi wrote:
> On Thu, Jun 12, 2025 at 10:16 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> >   Hi,
> >
> > > I didn't fix it. GitLab's mirror operation is still failing. Your
> > > suggestion of force pushing should fix it, but I want to understand
> > > why a commit was lost first.
> > >
> > > The issue is that QEMU's mirror and upstream have diverged. The
> > > following commit is only in QEMU's mirror repo:
> > >
> > > commit 44693a974cd90917f81a7d0310df4b592edd7e09
> > > Author: Christopher Lentocha <christopherericlentocha@gmail.com>
> > > Date:   Tue Jan 21 11:59:14 2025 -0500
> > >
> > >     Fix AHCI Disk Detection when using EDK2 CSM
> > >
> > > It is not possible to fast-forward to upstream's master due to this difference.
> > >
> > > Gerd: Do you know what happened to this commit upstream?
> >
> > Hmm, no idea.  Didn't notice it got lost until now.  Also can't remember
> > having seen a non-ff update on the seabios master branch when pulling.
> >
> > Either me or Kevin must have deleted it by accident, or something went
> > wrong with the coreboot git server (where seabios git repo is hosted).
> >
> > Guess we must do a forced update once to get them back in sync.
> 
> Do you still want me to go ahead with the SeaBIOS update you posted?
> 
> I'm asking because if QEMU drops the commit I mentioned above, then I
> guess EDK2 CSM AHCI detection will break. That would be a regression.

AFAICT it wouldn't be a regression from QEMU's POV.

The original git submodule hash pre-dates this EDK2 CSM commit, and
the new git submodule hash references a history that doesn't include
this EDK2 CSM commit. So nothing in qemu ever referenced this commit.

The only way anyone would have ever used this EDK2 CSM commit is
if they built directly from our mirrored seabios.git, instead of
using our git submodule with roms/Makefile, or the official
upstream seabios.git

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


