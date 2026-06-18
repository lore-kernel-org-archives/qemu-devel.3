Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE1DCD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 14:22:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waDcJ-0000nY-FV; Thu, 18 Jun 2026 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waDcH-0000nL-Vt
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waDcF-0004Tc-T9
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 10:21:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781792469;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GYLKdRjzMo6We7N4zoFEw5MLfsgpyL733EZcmvhPDKA=;
 b=ZeJ5XVOG/EKPGR+ha8FVoQeVGqTH9tiIPdsgyRQBFlfmOutqnr5XyjbCmvszMm+mb1k3ZH
 1o34GyTecCzPRYm5b6hSaOWFWLpK02o0sOaSBhu/dUGARKEj1Rgh3FrcvGc+x/eU/P/yjX
 HDWJ3epIGhJwzmMmdApIdYRiI8whopQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-7FAAwE_fN4yc2LNN0NzU1w-1; Thu,
 18 Jun 2026 10:21:07 -0400
X-MC-Unique: 7FAAwE_fN4yc2LNN0NzU1w-1
X-Mimecast-MFC-AGG-ID: 7FAAwE_fN4yc2LNN0NzU1w_1781792466
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D969180057E; Thu, 18 Jun 2026 14:21:06 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00F9F180056E; Thu, 18 Jun 2026 14:21:02 +0000 (UTC)
Date: Thu, 18 Jun 2026 15:20:59 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <ajP-y4C93kc_jcae@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <4420c1d2-0a4f-4a99-814e-f7b27a38b03c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4420c1d2-0a4f-4a99-814e-f7b27a38b03c@oss.qualcomm.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jun 18, 2026 at 04:07:44PM +0200, Philippe Mathieu-Daudé wrote:
> On 18/6/26 15:20, Daniel P. BerrangÃ© wrote:
> > It is no longer viable to handle the incredible volumes of
> > AI assisted security disclosures via email, nor are extended
> > embargos practical or useful.
> > 
> > Remove all information about the current security process and
> > instruct reporters to use 'confidential' issues. In contrast
> > to the old highly restrictive "need to know" approach, the
> > new approach makes all security issues visible to all QEMU
> > maintainers immediately.
> > 
> > The focus is on making issues public as soon as possible with
> > a viable patch. Co-ordinated disclosure will no longer be
> > attempted and nor will requests to embargoes be accepted.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >   contribute/report-a-bug.md     |   9 +-
> >   contribute/security-process.md | 309 +++++++++++++++------------------
> >   2 files changed, 148 insertions(+), 170 deletions(-)
> 
> 
> > +**The QEMU project no longer accepts security issue disclosures via email.**
> > +
> > +New disclosures must follow the [report a bug](report-a-bug.html)
> > +process to file a GitLab issue (work item) for each potential issue,
> > +***marking it as "*confidential*" prior to submission.***
> > +
> > +Some important notes when disclosing potential security issues:
> > +
> > +* The QEMU project cannot provide an SLA for response to security
> > +  disclosures, or any bug reports in general. Issues will be
> > +  responded to at the discretion of maintainers, subject to their
> > +  available time.
> > +
> > +* Attachments added to GitLab *confidential* issues are not themselves
> > +  confidential. If someone knows the randomly generated URL for the
> > +  attachment, they can view the content. Thus be careful where attachment
> > +  URLs are shared, while the issue remains confidential.
> > +
> > +* All disclosures will eventually be made public. Thus the content
> > +  or attachments for any issue must not contain data that the reporter
> > +  considers to be sensitive / private.
> > +
> > +* Not all areas of QEMU are considered to provide a security
> > +  boundary. Consult the [security guide](https://www.qemu.org/docs/master/system/security.html)
> > +  for details on how QEMU classifies features.
> > +
> > +* If an issue affects a feature within the QEMU security boundary,
> > +  but the reporter is unsure of the security implications, err on
> > +  the side of caution and mark it as "*confidential*" initially.
> > +
> > +* All important information must be disclosed in the issue description,
> > +  minimizing use of attachments to what is strictly needed. There is
> > +  a strong preference for individual files to be attached directly.
> > +  Avoid the use of archives (zip, tar, 7z, etc) to bundle files where
> > +  practical.
> 
> Except this bullet point, everything LGTM. Here I'd enforce reporters to
> attach a reproducer (in command line form, with image attached, pointing
> to requiered public images to trigger the issue).

FWIW, I don't think we're going to have a significant problem of
insufficient info with current disclosure practices.

We've not required this historically but none the less most of the AI
assisted disclosures have contained more than enough information to
easily reproduce the issues. Either clearly describing the steps in
the issue description, or shell/python scripts or qtests to exercise
it.

Out of ~300 disclosures this year, only a couple have needed a disk
image to demonstrate and those were stll trivial.

Also note that elsewhere in the file I also explicitly note that
the reporter must personally acknowledge that they reproduced the
problem, so they should be validating the instructions the AI
spat out.

> If not provided, personally as a maintainer I'd like -- or let scripts --
> the ability to discard the *confidential* tag to issue with no
> reproducer attached, as I don't want to waste time guessing / poking
> around, possibly realizing the issue is not reachable.

I very much doubt this is going to be a significant problem for any
confidential issues we get.

The doc is biased towards prompt disclosure though, with the maintainer
having the discretion to decide when to do that now.  Even if it is a
valid security issue a maintainer can decide it should be made public
without waiting for a patch if low severity.

We don't want issues to remain confidential for more than $SMALL number
of days.


> Otherwise,
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


