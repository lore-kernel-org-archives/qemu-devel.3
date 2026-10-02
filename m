Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2574FCA5FC4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCbBy-0005GH-5l; Fri, 02 Oct 2026 07:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCbBw-0005G8-6N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:12:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xCbBu-0001fB-EJ
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 07:12:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790939557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLI//WotJhIQlBsZsR2L+Hnovnv3hUq9L5d9YQuUiDQ=;
 b=GBzVEmDYQjMxewCRdxDOj+lN4/CbGBSwM3mL/pvO4Vs7U/fAtKEpM3Up+kQ53dNEgzVsqa
 JvEpWkMpqbykZh2HhBj+J5fR+I+aLK3votcGiQf5hW8N+ACTEUKorufQ2+bGWiViV2kQEI
 y2+tpnq2NQaLNKKmbYLnGphiDV52cBo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-fevGItdyPqCakQThqNNH7A-1; Fri,
 02 Oct 2026 07:12:33 -0400
X-MC-Unique: fevGItdyPqCakQThqNNH7A-1
X-Mimecast-MFC-AGG-ID: fevGItdyPqCakQThqNNH7A_1790939553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6630195423D; Fri,  2 Oct 2026 11:12:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6AE441956095; Fri,  2 Oct 2026 11:12:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C2BA21E6A04; Fri, 02 Oct 2026 13:12:30 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [qemu-web PATCH] contribute: define clear limits on bug report
 volume
In-Reply-To: <arVB8e0Rzuiu6ZT7@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 24 Sep 2026 16:29:53 +0100")
References: <20260924135634.2626603-1-berrange@redhat.com>
 <877bkaznst.fsf@draig.linaro.org> <arVB8e0Rzuiu6ZT7@redhat.com>
Date: Fri, 02 Oct 2026 13:12:30 +0200
Message-ID: <87mrsw2w69.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Sep 24, 2026 at 04:12:02PM +0100, Alex Benn=C3=A9e wrote:
>> It comes across as quite a draconian limit but to be honest after a 6
>> months of dealing with this flood I'm less inclined to be polite about
>> it:
>
> Yes it is draconian.  Aside from the periodic "mass filing"
> incidents, what prompted me is seeing the graph you produced
> at:
>
> https://www.qemu.org/screenshots/2026-09-culm-issues.svg

We're pulling the emergency brake.  Minor injuries must be accepted in
order to avoid major ones.

I'm not sure the policy gets that across.  "Not a benefit to the
project" and "place an unsustainable burden on maintainers" feel to me
like British understatement for "harm the project" and "threaten to
destroy the maintainer community".

> We see the increasing gap between open & closed bugs from
> March, where we failed to keep up with the flow arriving
> on qemu-security@nongnu.org
>
> In July we bulk imported the mails to gitlab, and between
> many maintainers we resolved alot over a month. After that
> first month though, we reverted to the widening gap, at
> the same rate we saw when triage was limited to just
> qemu-security@nongnu.org
>
> My reading of that is that even opening up triage to all
> QEMU maintainers has not fixed our scaling problem. We
> already burnt people out from dealing with these reports
> from automated tools.
>
> Ideally I would like reporters to put in more personal effort
> beyond the initial bug filing. If they do that then bugs might
> get through triage and patch review more effectively and get
> closed quicker, allowing filing of more reports.
>
> If reporters put in that more sustained patch curation effort
> instead of fire-and-forget, then I expect they wouldn't have
> time for filing so many bugs to begin with, making the limit
> less of a problem.

Wouldn't it be nice.

> Also if they're putting in greater effort, I'd be amenable to
> granting them an exception to exceed the limits on bug filing.
> IMHO any regular maintainers are implicitly exempt from the
> limits given their ongoing beneficial work for the project.
>
> IOW, the bug limit should be a problem primarily for people
> working on a "file-and-forget" basis.
>
>
> Still, I welcome suggestions for other ideas, or if we should
> have different limits in some level ?=20

Submitters submit when they expect the effort to be worth their while.
I call this friction.  It helps deter low-value contributions.  It's
more effective when it can be felt upfront.

AI has lowered upfront friction for bug submitters.

AI has not yet materially lowered the cost of triage, review, etc.

The policy change doesn't restore upfront friction, it merely gives us
license to ignore certain submitters who flood us.

Sadly, I don't have any bright ideas on how to restore friction.


