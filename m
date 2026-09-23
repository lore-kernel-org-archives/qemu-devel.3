Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8905BC9830B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9PGq-0000FB-SH; Wed, 23 Sep 2026 11:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9PGp-0000AC-9T
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x9PGn-000107-Is
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 11:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790178747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w7JAv1yfMeIHP4umHuje27v+JmlYoyUvqMf0XuefKyc=;
 b=VS91KtUQAx0M8/wU87mNORryHOV/lfAOC2ojZGs7X8GWouUpOVYDrt0tQWdnQoyfgQnmdg
 NHtqraRQToRRFyvRuRdY/5usHbbDQfBR2vZ1JvVXKOZtYHSs8B9eAgKn5A9jN5ctxqGHIo
 RLLmgua+1B/cYAZlwQnYhpGrFVb4DFA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-478-smvVcwWlNemJc0d91aR89Q-1; Wed,
 23 Sep 2026 11:52:24 -0400
X-MC-Unique: smvVcwWlNemJc0d91aR89Q-1
X-Mimecast-MFC-AGG-ID: smvVcwWlNemJc0d91aR89Q_1790178743
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7367E18301D3; Wed, 23 Sep 2026 15:52:22 +0000 (UTC)
Received: from redhat.com (unknown [10.44.48.191])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 779FC19539A7; Wed, 23 Sep 2026 15:52:18 +0000 (UTC)
Date: Wed, 23 Sep 2026 17:52:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
Message-ID: <arP1sJTXU7pZGRiI@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com>
 <87jyof0xij.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jyof0xij.fsf@draig.linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Am 21.09.2026 um 11:22 hat Alex Bennée geschrieben:
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

I feel this is way too verbose. It almost looks like a version history
of the work submitted in the patch. I'm not interested in this at all,
I'm only interested in the final result and which parts I have to assume
to contain AI generated content.

> Of the last one I expect "fetch issue, apply proposed patch, verify
> build" is superfluous as its really just automation but the converting a
> bug test case into a proper qtest case is worth flagging as it is a
> transformation worth getting called out?

If I understand correctly what really happened there, it could be:

    AI-used-for: tests (based on bug #1234)

With the wordy, but unspecific tags above, I'm not completely sure if
"code" ought to be included, too. It gives a lot of irrelevant
information that I have to filter out when reading, but it missed the
important part.

Kevin


