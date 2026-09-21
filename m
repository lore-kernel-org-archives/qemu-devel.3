Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB3C3C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 14:11:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ek1-0005PF-0u; Mon, 21 Sep 2026 10:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8ejn-0005Oi-5M
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:11:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8eji-0006fz-JX
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 10:11:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789999872;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=574dJ54/5tbI9jn5orKTrTsulz4voPRM1lggfxHOrys=;
 b=HiEquh4+LlvjHZ2qtmsBbuwoaPRpxAgpIzFFWx0zyRvC57sLa+yzZwN0dioLpajzlaSgA2
 7vLAoD3Qrg8wl7GmjuGA0283Oa3Uc1ZM+ZH+kax8Iv4Qx593k9VN6ra/KObQctDYvq+9j5
 azhyG8QMpwXxxyNBu5fRM4fves+RQ1M=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-283-BCyadbEsP7S5AlkjYqXq7w-1; Mon,
 21 Sep 2026 10:11:08 -0400
X-MC-Unique: BCyadbEsP7S5AlkjYqXq7w-1
X-Mimecast-MFC-AGG-ID: BCyadbEsP7S5AlkjYqXq7w_1789999867
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 192811828BB2; Mon, 21 Sep 2026 14:11:07 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0936E18002B7; Mon, 21 Sep 2026 14:11:03 +0000 (UTC)
Date: Mon, 21 Sep 2026 15:11:01 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <arE69Y-yvdWbgcF-@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <87jyof0xij.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyof0xij.fsf@draig.linaro.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 21, 2026 at 10:22:28AM +0100, Alex Bennée wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
> > Until now QEMU's code provenance policy declined any contribution
> > believed to include or derive from AI-generated content.  A blanket ban
> > was easy to maintain while LLM output was rarely usable on its own, but
> > as the tools improved an absolute prohibition has become harder to
> > justify and enforce.
> <snip>
> > +Commit messages for AI-assisted changes
> > +'''''''''''''''''''''''''''''''''''''''
> > +
> > +In order to disclose your usage of AI/LLM tools, add an ``AI-used-for:``
> > +line before the :ref:`Signed-off-by <code-provenance>` line.  The trailer
> > +is both a reminder of your DCO obligations and a guide to reviewers.  The
> > +text is one or more of ``code``, ``tests``, ``docs``, ``research``, possibly
> > +followed by an explanation in parentheses:
> > +
> > +.. code-block:: none
> > +
> > +     AI-used-for: tests, docs
> > +     AI-used-for: code
> > +     AI-used-for: code (refactoring)
> > +     AI-used-for: code (prototype)
> > +     AI-used-for: research
> > +
> > +``AI-used-for`` should not be included for "background" usage such as
> > +autocomplete or obtaining a pre-review of the patch.
> 
> While experimenting with these tags I had done a patches with:
> 
>   AI-used-for: created qtest boilerplate based on bug report
>   AI-used-for: importing and validating test case
>   AI-used-for: initial prototype changes
>   AI-used-for: initial draft of test
>   AI-used-for: fetch issue, apply proposed patch, verify build and qtests
> 
> Of the last one I expect "fetch issue, apply proposed patch, verify
> build" is superfluous as its really just automation but the converting a
> bug test case into a proper qtest case is worth flagging as it is a
> transformation worth getting called out?

IMHO "AI-used-for"  only needs to call out things that directly resulted
in code being authored, so I'd agree that the last one is out of scope.

For the others, my benchmark would be, if a reviewer points out a mistake
in the patch, is the contributor going to want to blame the AI. If so,
then the use of AI should have been disclosed.

They shouldn't be blaming the AI anyway, as they need to take responsibility
for explaining all decisions, but that's a tangent :-)

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


