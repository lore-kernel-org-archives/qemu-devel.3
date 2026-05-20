Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C40CD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 15:10:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPiYL-0002jp-60; Wed, 20 May 2026 11:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPiYI-0002ij-1i
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:09:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wPiYG-00055W-8J
 for qemu-devel@nongnu.org; Wed, 20 May 2026 11:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779289779;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rv9GtLeWxe0ClU2DCPkBaE8lanr00CqwNOhE4GLUwFw=;
 b=WsAPyL8oqms2Lv6lT+mihBGstJAy17TQU+p5blPjFw3P9oFh+AN4oPFYdQRcRWN0Dt1wIf
 YpJ+Z0YoXUK98xClR9tRTWdNbdQCteQrG9AtiWljF1YtLCFZQN4UuvwKXi4NVs9MVpbONV
 +bBqaA6cZQ7uDELb7HaduGuE2usKVY0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-YPDsO7L1NwqMwv1imk5Rdw-1; Wed,
 20 May 2026 11:09:30 -0400
X-MC-Unique: YPDsO7L1NwqMwv1imk5Rdw-1
X-Mimecast-MFC-AGG-ID: YPDsO7L1NwqMwv1imk5Rdw_1779289768
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A27119560B9; Wed, 20 May 2026 15:09:28 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.211])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C4F641800352; Wed, 20 May 2026 15:09:25 +0000 (UTC)
Date: Wed, 20 May 2026 16:09:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: RFC: GitLab issues for security disclosures
Message-ID: <ag3OopKwGVUjSrrV@redhat.com>
References: <agxzKzzDOJm1EU_v@redhat.com>
 <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c9cd8228-0a18-49f7-b403-445affeaf972@oss.qualcomm.com>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 20, 2026 at 10:01:14AM -0500, Pierrick Bouvier wrote:
> Hi Daniel,
> 
> On 5/19/2026 9:26 AM, Daniel P. Berrangé wrote:
> > The qemu-security mailing list was created several years back now and
> > traditionally saw 1-2 disclosures a month at worst. This was manageable.
> > 
> > Since approx March 1st, the new normal is to see as many as 20 disclosures
> > in one single day, more than 200 in total now. This is unsustainable.
> > I was thinking we needed more people on qemu-security to triage, but IMHO
> > this won't really fix the problem.
> >
> 
> Considering the increase in number of issues, would that be possible to
> make stricter rules about what is expected?
> 
> For instance, asking for a working exploit and optionally a VM image +
> instructions to reproduce it. I am not expert on the topic, but what I
> see is that if we have this, all duplicates would be eliminated at once.

With the new crop of AI assisted disclosures there is absolutely no
lack of data provided.

Most come with reproducible exploits, detailed descriptions and analysis,
and more - everything you could conceivably need to triage the disclosure.
Reading and interpreting this takes significant mental effort and there's
too much data to quickly/easily eliminate dupes.

> > This needs an issue tracker to cope with & email is not an issue tracker.
> > We faked an issue tracker with a shared spreadsheet to prevent us drowning
> > these past few months, but this is still not sustainable & probably won't
> > ever be.
> >
> 
> Overall, you're right.
> However, changing the tool won't solve the number of issues sent, and
> for that, something additional is needed.

I don't expect there to be any change in submission rate. The proposal
is based on the expectation that the submission rate will continue at
a high level for a long time. Primarily the goal is to reduce the
tracking and triage work overhead and to eliminate/reduce single person
bottlenecks in the process

> I wonder also what is the percentage of duplicates there is from what
> you observed in the last 2 months. Any rough idea of the number?

Definitely at least 10%, probably closer to 15%.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


