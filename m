Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D92CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 15:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waEKB-0007Os-L1; Thu, 18 Jun 2026 11:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waEKA-0007NR-1d
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:06:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1waEK7-0006iu-Us
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 11:06:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781795190;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfQV+qC0uI7mNS+aeb2PYooYO5vSgyTPAKpYYDo5pn8=;
 b=eUjDqE5Ch0Hyn7hmjAaFu9d4zsOJaDlxvBnPw1JXEblZYV7xVvfwlQVX+MlZCUEr4fd2pR
 fvqJwjMGUDsxOMEsnr3vKHXpBmHB7sXIkDr5aIUBgyfZ/4fZCwnmcl74wC3WlKkuU79FlX
 wFyVxOSEbFirb0DZ2eXrSWVEyDf63WQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-ZfPzi8DoOKS-dd3MQ3385Q-1; Thu,
 18 Jun 2026 11:06:26 -0400
X-MC-Unique: ZfPzi8DoOKS-dd3MQ3385Q-1
X-Mimecast-MFC-AGG-ID: ZfPzi8DoOKS-dd3MQ3385Q_1781795185
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86CA51956044; Thu, 18 Jun 2026 15:06:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.28])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1081D1688; Thu, 18 Jun 2026 15:06:22 +0000 (UTC)
Date: Thu, 18 Jun 2026 16:06:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>, Mauro Matteo Cascella <mcascell@redhat.com>
Subject: Re: [qemu-web PATCH v2 3/3] contribute: switch security process to
 gitlab confidential issues
Message-ID: <ajQJa0N54Ges2-f2@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
 <20260618132058.1044341-4-berrange@redhat.com>
 <20260618104051-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260618104051-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Thu, Jun 18, 2026 at 10:42:15AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 18, 2026 at 02:20:58PM +0100, Daniel P. Berrangé wrote:
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
> 
> Thanks for taking on this. One question:
> 
> 
> > ---
> >  contribute/report-a-bug.md     |   9 +-
> >  contribute/security-process.md | 309 +++++++++++++++------------------
> >  2 files changed, 148 insertions(+), 170 deletions(-)
> > 
> > diff --git a/contribute/report-a-bug.md b/contribute/report-a-bug.md
> > index fd3bc6b..b506f9f 100644
> > --- a/contribute/report-a-bug.md
> > +++ b/contribute/report-a-bug.md
> > @@ -11,6 +11,11 @@ on GitLab, taking into account the following guidance.
> >    requested pieces of information that are relevant to the
> >    discovered bug.
> >  
> > +* Bugs which are suspected, or known, to have security implications
> > +  **must** be marked as "*confidential*" prior to submitting the
> > +  disclosure. Consult the [security process](../security-process)
> > +  for further guidance on security issue handling.
> > +
> >  * Reproduce the problem with the latest upstream QEMU release.
> >    Reports against older versions may not be acted upon with
> >    with the same priority.
> 
> 
> There's a problem here in that confidential marking is later
> erased. I feel would is benefitial to tag the security bugs
> in some way that does not go away so easily. Any idea?

Yes, see this paragraph....

> > + * If confirmed as a security flaw, a maintainer will add the
> > +   **"Kind::Security"**, **"Workflow::Confirmed"** and
> > +   **"CVE::Required"** labels.. The latter indicates the need
> > +   for a CNA to allocate a CVE.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


