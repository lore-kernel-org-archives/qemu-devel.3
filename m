Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0514C61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:45:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzeAI-0008Ie-V8; Thu, 27 Aug 2026 13:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzeAE-0008H6-C9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:45:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wzeAB-0003UB-FT
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 13:45:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787852718;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6A30C1ujsSebqZkTi1CcnKUO51zVIUrVexkSzbPjNE8=;
 b=UexI52I2HfaMlMx/vcamOuCrLDEpPKW/EEztQi5xEVmtEJYGmzh2V0o+2C4WLv6RUhHMFP
 fFLGKEJacQ8r9yce2474XxN4cctdmXjFo6zMFe1EPwU072F+t9J0idkPLDPnB7zZDxTvIQ
 6Ss+uNZm0eNk/p91bfgbsetAtm068E4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-N-SI4FJxO_urmYp5WTv0bg-1; Thu,
 27 Aug 2026 13:45:13 -0400
X-MC-Unique: N-SI4FJxO_urmYp5WTv0bg-1
X-Mimecast-MFC-AGG-ID: N-SI4FJxO_urmYp5WTv0bg_1787852711
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 309C21800A33; Thu, 27 Aug 2026 17:45:11 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B819A1955F70; Thu, 27 Aug 2026 17:45:08 +0000 (UTC)
Date: Thu, 27 Aug 2026 18:45:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
Message-ID: <apB3oX536mOoPoXt@redhat.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
 <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 27, 2026 at 06:32:43PM +0100, Peter Maydell wrote:
> On Thu, 27 Aug 2026 at 17:09, Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
> >
> > Hi Thomas,
> >
> > On 27/8/26 14:54, Thomas Huth wrote:
> > > On 09/10/2023 21.39, Mark Cave-Ayland wrote:
> > >> On 07/10/2023 08:23, Thomas Huth wrote:
> > >>
> > >> (added Natalia who was the GSoC mentor for the NeXT cube work)
> > >>
> > >>> The machine is incomplete, and unfortunately the hoped-for improvements
> > >>> never happened. So it's maybe best if we mark this machine as deprecated
> > >>> and finally remove it again in case it gets into the way of a code
> > >>> refactoring or other reasons.
> 
> > >> I'm torn a bit by this one - on the one hand the NeXT code could do
> > >> with some love, but then given that the code already uses qdev/QOM
> > >> then there isn't really much in the way of maintenance burden. The
> > >> main concern for me at the moment is the use of the old-style memory
> > >> accessors that pre-date the memory API.
> > >>
> > >> With my latest ESP patches I think it shouldn't be too hard to update
> > >> the NeXT DMA controller to get SCSI working, so perhaps we can leave
> > >> it for now if it doesn't cause too many problems?
> 
> > > Almost three years later, the world changed quite a bit. We're getting
> > > flooded with AI-generated bug reports now, and of course people are
> > > discovering problems in this old and neglected code, e.g.:
> > >
> > >   https://gitlab.com/qemu-project/qemu/-/work_items/4303
> > >   https://gitlab.com/qemu-project/qemu/-/work_items/4304
> > >   https://gitlab.com/qemu-project/qemu/-/work_items/4305
> >
> > Hobbyist motivated machine emulations never committed to be
> > secure. While I appreciate these bug reports for the overall
> > quality of the project, I'm taking these one as lowest priority.
> > I wouldn't even mind of closing them as WONTFIX "Thanks ...".
> 
> I agree, but also they can prompt us to look and say "actually
> this machine is no longer used / never got sufficiently
> implemented to be useful / has no maintainer" (cf musicpal).
> So the questions here are:
>  * is the machine's functionality better than it was in 2023:
>    can we boot something beyond just the firmware now?
>  * is anybody planning to actively work on it?
>  * is anybody using it?

I don't mind about the quality, as we never claim this stuff
is providing a security boundary, but I do wonder whether the
bar for merging a machine should have been higher than
"shows firmware prompt" ?

Are there other machines we have merged with that level of
very limited functionality ? 

Is it reasonable to say "boot a guest OS" is a criteria for
merging machines in future ?

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


