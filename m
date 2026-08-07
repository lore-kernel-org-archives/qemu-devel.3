Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F15F6C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsLnB-0007Gr-H1; Fri, 07 Aug 2026 10:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wsLmu-00077o-LI
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:43:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wsLmr-0006hi-Io
 for qemu-devel@nongnu.org; Fri, 07 Aug 2026 10:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786113783;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=vgNFX4HzkNxpyzsnMTcaUAc4H2+UACW68n3BtkAdPVU=;
 b=dZgZcOki85HEiPWPDZbiAyHFdUs62BHtTEUTdmqFoG1va7FfH9G/LigNyZYO3V/Zi4zQBL
 /CBPaJ9K7O68Cmgcx6Q9bPfPxlX0Xrr59XVdb/Lqf94iHb+Qd6qkWzTHDM3uqgJqJE081p
 zhrA/TfRgvHhERDhu8NymxrMk7oQ7sk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-cFZ3T0YgNkafQW23abMwgw-1; Fri,
 07 Aug 2026 10:41:54 -0400
X-MC-Unique: cFZ3T0YgNkafQW23abMwgw-1
X-Mimecast-MFC-AGG-ID: cFZ3T0YgNkafQW23abMwgw_1786113713
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CEF5195608F; Fri,  7 Aug 2026 14:41:52 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6A7B1800347; Fri,  7 Aug 2026 14:41:48 +0000 (UTC)
Date: Fri, 7 Aug 2026 15:41:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <bonzini@gnu.org>
Subject: Re: [PATCH v2] docs/devel: relax policy on AI-generated contributions
Message-ID: <anXuqbBXERqn4lPu@redhat.com>
References: <20260529094619.1034458-1-pbonzini@redhat.com>
 <20260802154350-mutt-send-email-mst@kernel.org>
 <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-VB7kNn6MM4cF7Pz356KgkyKRaK0xMC2PTXYYCVVfLyg@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Aug 07, 2026 at 01:39:32PM +0100, Peter Maydell wrote:
> On Sun, 2 Aug 2026 at 20:51, Michael S. Tsirkin <mst@redhat.com> wrote:
> > So GCC has now decided that 15 lines or so is ok, if a maintainer
> > decides so, and that one
> > should only count significantly different changes, what they call,
> > following the gnu maintainer guidelines "legally significant contributions":
> >
> >         A change of just a few lines (less than 15 or so) is not legally
> >         significant for copyright. A regular series of repeated changes, such as
> >         renaming a symbol, is not legally significant even if the symbol has to
> >         be renamed in many places.
> 
> That is more that the GNU project already had a level they defined
> as legally significant, because they wanted it to determine whether
> they needed copyright assignment or not. So it's natural for GCC to
> use it also in their AI policy.

None the less that is an interesting benchmark.

A key challenge we've always had in these discussions is how
to draw a line on what "legally signicant" means in practice.

The fact that the GNU project has used the "15 lines" rule
for copyright assignment is quite a useful benchmark to take
in to account precisely because they've used that for years
(presumably decades?). To me the longevity gives it weight
because it isn't something made up recently to suit the needs
of those pushing use AI/LLM tools, and has had long term
practical application in many real world OSS projects.


> > GCC also makes an exception for tests and I guess we could make
> > an exception for internal developer docs?
>
> I don't think we should have AI generated docs, including
> developer docs, as I noted somewhere up thread. That's not for
> any particular copyright reasons, it's because we need actual
> humans to be understanding and writing the documentation,
> because it can't be easily cross-checked by tests.

IME, it is by writing docs for a feature, that you come to learn about
the flaws / gaps in the thing that is implemented, which feeds back to
improve the code.  Generating docs you're just going get text that
reflects the state of the code without the learning & improvement
experiance.

I don't think we should have an exception for tests either. If we
have code in the tests directory that is generalized to become
part of the broader codebase, we shouldn't have to think about the
history of whether the tests code was AI generated.

The boundary between docs and code is also not entirely clear cut
and intermingled in areas like command line help, QAPI inline
docs, API doc comments,and so on.

IMHO all content in the repository should be treated the equivalently
and held to a common standard. IOW, *if* we decide it is reasonable to
allow limited AI/LLM usage in some manner, prefer to do that universally
rather than trying to be very selective across sub-directories/files.

Simplicity & clarity of rules makes it more likely that people will
actually be able to follow them.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


