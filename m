Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9645BCD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGi1-00053u-Am; Wed, 10 Jun 2026 07:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGhz-00052v-GO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:02:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wXGhx-0004N5-QJ
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 07:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089372;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FdKsL6j7ngjF3pQpTSGIhwO53MqddBOta+dgAMr4kRs=;
 b=SttfuqD92Qp2Ueka0qBZQR2CqHFtjZjuGK0ls5zDAvMA+49Z7L51MxFVK+dymzLXBCr6uo
 zj/efc1NuwoPmMzucvJYzhcR4EGkyWZqkySI+PQNmMQur1RpaAKEt9hB5WsThCRnsju2f8
 9rWhn5qAXnu6EC9cV/nSyGKoJtIgHT4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-m7lLEmXgNJ-m0qe3Xse48Q-1; Wed,
 10 Jun 2026 07:02:51 -0400
X-MC-Unique: m7lLEmXgNJ-m0qe3Xse48Q-1
X-Mimecast-MFC-AGG-ID: m7lLEmXgNJ-m0qe3Xse48Q_1781089370
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE8C9180035C; Wed, 10 Jun 2026 11:02:49 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7A5291954B0B; Wed, 10 Jun 2026 11:02:47 +0000 (UTC)
Date: Wed, 10 Jun 2026 12:02:43 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web RFC 3/3] contribute: switch security process to gitlab
 confidential issues
Message-ID: <ailEU05AQzlm1fTl@redhat.com>
References: <20260604165048.457860-1-berrange@redhat.com>
 <20260604165048.457860-4-berrange@redhat.com>
 <20260610061728-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260610061728-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Jun 10, 2026 at 06:18:39AM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 04, 2026 at 05:50:48PM +0100, Daniel P. Berrangé wrote:
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
> >  contribute/report-a-bug.md     |   9 +-
> >  contribute/security-process.md | 280 ++++++++++++++-------------------
> >  2 files changed, 119 insertions(+), 170 deletions(-)
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
> 
> Do we want to do like linux does, and make AI found issues public,
> on the assumption that bad guys can find them just as easily?

I'm pretty sympathetic to the idea that AI discovered issues
are "effectively public", but IMHO that's not quite the same
as "actually public".

While people can re-discover things, that doesn't mean we should
do the job for them by publicising everything immediately.

To me, the main implications of the "effectively public" view
point are

 * Minimizing time-to-fix is the core priority
 * Process needs to be low cost minimal external dependencies

Delaying disclosure to suit arbitrary downstream vendor's or user's
update schedules is not helpful. The only delays to publication should
be to allow a maintainer to get a patch prepared, nothing beyond that.
"Low" severity bugs can be public immediately regardless of a patch.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


