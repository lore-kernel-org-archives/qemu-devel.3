Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F272CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKz40-0007m1-5M; Thu, 07 May 2026 09:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKz3v-0007lo-Vu
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKz3s-0004Nc-EU
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778161602;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3e8whisJbGatF2J9EbfyEEDqgIE2ddle93Z9OmMAF3U=;
 b=aAdEbhFaY4sz3E9/scpy9cbvl3q6qRxzJcqCJ/B0EckvqeGxIgvdDx3YHyQOqhrW+C7cbQ
 tALRAeY9jt8ySQluWn7urI0btTTWS0HE2io4T4hR6eMY4ptdkLL0m/zkWXPxW4eyyr1IhR
 WcfuCAmmQpGCPw1t4dgcRyA0/nyhOQQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-cSIPaSaYNxysqQiKCGDPpg-1; Thu,
 07 May 2026 09:46:36 -0400
X-MC-Unique: cSIPaSaYNxysqQiKCGDPpg-1
X-Mimecast-MFC-AGG-ID: cSIPaSaYNxysqQiKCGDPpg_1778161595
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253D8195608F; Thu,  7 May 2026 13:46:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D497F3002D2D; Thu,  7 May 2026 13:46:33 +0000 (UTC)
Date: Thu, 7 May 2026 14:46:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 08/10] .agents/skills: add qemu-issue-triage agent
 skill
Message-ID: <afyXtlC9ktQ7qa-f@redhat.com>
References: <20260505170105.228162-1-alex.bennee@linaro.org>
 <20260505170105.228162-9-alex.bennee@linaro.org>
 <afxMiS7Y5RIXPLUz@redhat.com> <87zf2bl7r8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zf2bl7r8.fsf@draig.linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, May 07, 2026 at 01:32:59PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Tue, May 05, 2026 at 06:01:03PM +0100, Alex Bennée wrote:
> >> While triaging the issue tracker I wondered if this would be a
> >> suitable job for an AI agent. Unfortunately the OSS program doesn't
> >> give any credits to run agents in gitlab. However I do have access to
> >> models from my editor and ECA so I built one and tested it on a few
> >> issues.
> >> 
> >> Obviously this can't apply as is because it probably encodes too much
> >> of my local setup (using pass for API keys) and uses the ECA as my
> >> preferred coding agent. I assume at some point there will be agreement
> >> between all the agents where skill live.
> >> 
> >> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >
> > ..snip..
> >
> >> diff --git a/.agents/skills/qemu-issue-triage/assets/labels.txt
> >> b/.agents/skills/qemu-issue-triage/assets/labels.txt
> >> new file mode 100644
> >> index 00000000000..d329f34183d
> >> --- /dev/null
> >> +++ b/.agents/skills/qemu-issue-triage/assets/labels.txt
> >
> > Seeing our labels listed like this triggers my urge to "tidy" :-)
> >
> > Don't take anything below to be a complaint / blocker about this patch.
> > This patch is fine in so much as it faithfully represents the mess we
> > have created in gitlab.
> >
> >> @@ -0,0 +1,133 @@
> >> +# SPDX-License-Identifier: GPL-2.0-or-later
> >> +ACPI                       Power Management related (ACPI / SMBIOS / HEST / GHES)
> >> +Audio Audio devices; both backend (host audio) and frontend (guest
> >> audio)
> >
> > Mixing frontend and backend is a bad idea in general IMHO.
> >
> > I feel like we should also have an explicit label for each backend, for
> > both audio and every other backend type.
> 
> Backend: chardev
> Backend: audio
> ?

No sorry, I meant  chardev:socket, chardev:stdio, chardev:mux, etc and
audio:dsound, audio:alsa, audio:pa, etc


> >> +GUI Graphical User Interface (gtk, SDL, curses, VNC, spice, ...)
> >> +GUI::Cocoa                 Cocoa
> >> +GUI::DBus                  DBus
> >> +GUI::GTK
> >> +GUI::SDL                   SDL
> >> +GUI::SPICE                 SPICE
> >
> > spice is duplicated later
> 
> Prompt: "find all the issues with the "spice" label and label them with the GUI::SPICE label instead"
> 
> the result was:
> 
>   general: relabling spice issues (5 steps, 13.5K / 1M) ✅ 1m 26s
> 
>   I have successfully relabeled all GitLab issues in the `qemu-project/qemu` repository by replacing the "spice" label with the "GUI::SPICE" label.
> 
>   ### Summary of Actions:
>   - **Total Issues Updated**: 21 (including both open and closed issues).
>   - **Relabeling**: Removed the `spice` label and applied the `GUI::SPICE` label to each identified issue.
>   - **Verification**: Confirmed that `glab issue list --label spice` now returns no results, while `glab issue list --label "GUI::SPICE"` includes all updated issues.
> 
>   ### Updated Issues:
>   The following 21 issues were updated: 
>   `3148`, `3070`, `2860`, `2667`, `2639`, `2561`, `2411`, `2335`, `2282`, `2071`, `1926`, `1829`, `1778`, `1777`, `1553`, `1549`, `1431`, `1426`, `1285`, `681`, `232`.
> 
> about 0.08p in inference costs.
> 

> > What's this for, and why : instead of :: ?
> 
> No idea - is this the mechanism we use to hide live security issues?

security issues should not be in the issue tracker at all

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


