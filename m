Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4ACDCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:43:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xC3wV-0004KC-7c; Wed, 30 Sep 2026 19:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xC3wT-0004Ju-6u
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 19:42:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xC3wQ-0004n2-VY
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 19:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790811744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iv79iUg1JQF/pZMh5rGcoowAclxH86ovbLiSbuAFt7U=;
 b=Kw1Iu2fogMWW5rzL+Ocrad7hAk//abYS4pJ8lIY/oKRgq0Kv2Q2VWd/b5XN7W1nAVqNfXZ
 Py8cCkIWSObGbEThYxn9icjPI4ZOzQr2HjqDO3Mkk1iCrDwsz83yGPZpgkeKnNswyLjfx0
 1zrdZj8yWOTpuwoOgTXQWirB/nsLW9U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-txQOtm45P0CQand-FdHV7Q-1; Wed, 30 Sep 2026 19:42:22 -0400
X-MC-Unique: txQOtm45P0CQand-FdHV7Q-1
X-Mimecast-MFC-AGG-ID: txQOtm45P0CQand-FdHV7Q_1790811741
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a0023f2b60so22607385e9.2
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 16:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790811741; x=1791416541; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iv79iUg1JQF/pZMh5rGcoowAclxH86ovbLiSbuAFt7U=;
 b=ZIXJf6OIf4qi6RgTDnD/ZrpeI8dR28KDQa5nvYgm/htzdRyoCJs7DueVrQ5CpUL4TP
 Lo8LgOzwSnmeQmzJOPjkZBUiaQfL45UJ52Jmi0TuygjyPTouMSUOAo1sx6IXnxtLJ8TT
 IXV5N3t2O48QcTNwNMX0Xwq7hAKra+ATMQN2yvT1ykTrMqk47vrkbNKEKE+YTVCGTz9W
 YzZFUyok8nIqYf2Ua+dkfq951gqCrD6VGwj+FifV3U1tJKI/+TYJHAYIM2FWDcxM98dQ
 TtBSnOQK9qq3zIXlUfIfloe1oe+xG8kouL2kpW/+cuCh6RL0f6ac8dohctj7nyjS48m2
 oZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790811741; x=1791416541;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iv79iUg1JQF/pZMh5rGcoowAclxH86ovbLiSbuAFt7U=;
 b=0vpE+2XxLZBbXoo/TpZ64XIbhGiAc4VVzhRymnryM1S6xrDiyTggKjo4SVyHRBnafU
 8ZQ/r7+tJdB+DVGrj/c35pXLW3y9rF4wWKxHzn8rh/Ak4xypidur0pmUhqXV3ZcIEiEZ
 djFqj4SeNggP91xU2ddAzDhkzpsmf33jOCmnkWhLhul66R3GvuyrTfIMaVK7GqGnhbdZ
 yBEj6DgRggDeaLQL4XBzTuEZrungxDOg/lSKB4tQn/fWOwqBDeYs25ITULqnioYI4Uua
 6UBGZf6tb6tkQWVaNzeTfxuCBSsII2mxwN2VOw8BBzg75iYqz0ghog1Oftdr6R9dcPpe
 IE7Q==
X-Gm-Message-State: AFuF++l6lAeE3swhheRwEzyzt3mg/rWMqxMqAOJN/Mt0u4eFH4fkVOkT
 LPowJCOdHh/oQtqZ09GoSJIIHPvR1c9wV3Lb/1rErHIOsi9d6NZkj7yjJXQKwNMLUd5KTaw6VbT
 yhwYGV8CFyMc9yYc9WTwkULLkLxDJCKAU+dZYSpdeeI5tZ9cz1HROs3pr
X-Gm-Gg: AYBFou279W31PnONw94xEqQQEe5nJCg883jPneCeTOgWyKpO6G8QV9qeoJIvcvGYYnF
 YV/nuDRSaIOUUigEKrKJkbAly023auBuF+qVDvVOlyHbpipKZZt3jz0c+teitlgZeTwjb+ajisP
 XSyDSRCNnUMQZLO39+XeZbqmXM1v/1G3EjbRFt75gmBulwVKvAEEqI7FX3g9/XvEpRLR8hX+Wi6
 Dco8WhodiEq/YcKp41yzgp4CJ9TU8QUpYqDzjTJTiNe/xQIYhN4zxQs0A317Kmz+He0aZDpiQgK
 XIf9vW35Ea8/GYGr8Q001TiPqqP3kaLFO3gMyGGSz7MpcsOtlDueChmnstXw56E7/iuy9g==
X-Received: by 2002:a05:600c:3486:b0:4a0:1d2:1a8a with SMTP id
 5b1f17b1804b1-4a01afdd2bbmr35415815e9.16.1790811741409; 
 Wed, 30 Sep 2026 16:42:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3486:b0:4a0:1d2:1a8a with SMTP id
 5b1f17b1804b1-4a01afdd2bbmr35415525e9.16.1790811740870; 
 Wed, 30 Sep 2026 16:42:20 -0700 (PDT)
Received: from redhat.com ([2a02:586:1d05:2c0:d92a:1b52:ee3f:b73d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01f99a96fsm20987265e9.13.2026.09.30.16.42.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 16:42:19 -0700 (PDT)
Date: Wed, 30 Sep 2026 19:42:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 0/4] docs/devel, AGENTS.md: a completely new policy on
 AI-generated contributions
Message-ID: <20260930194157-mutt-send-email-mst@kernel.org>
References: <20260930085433.830743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930085433.830743-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Sep 30, 2026 at 10:54:29AM +0200, Paolo Bonzini wrote:
> Based on the previous discussions, I am finally attempting a non-RFC
> version of the new AI policy.  Discussion on v3 introduced interesting
> points on attestation and I think a consensus is forming.
> 
> Why review the policy?  The blanket ban no longer reflects reality, since
> contributors have been posting AI-generated patches or even larger series.
> This was done most likely in good faith, as these submissions predated
> the introduction of an AGENTS.md file, and it shows that AI can be used
> for useful and creative work on QEMU.
> 
> Rather than expecting maintainers to police these contributors, the new
> policy seeks to ensure that AI usage helps us produce better code rather
> than simply move faster and flood us with dubious work.  In the words
> of Warner Losh, we want to avoid "free as in puppy" contributions[1]
> that increase the load of present and future maintainers by adding
> technical debt.
> 
> This is not a free-for-all.  To avoid maintainer burnout, AI
> contributions must be grounded in respect for maintainers and in the
> existing contribution process.  Large, heavily AI-assisted contributions
> require pre-arrangement with the relevant subsystem maintainers, and
> will be held to a higher standard.
> 
> One of the reasons for the old policy was the issue of code provenance
> and the impossibility to certify the originality of code created by
> AI/LLM tools.  The new policy tries to adopt a "Swiss cheese"
> approach to mitigating the risks implicit in accepting AI-generated code
> in three ways:
> 
> 1) by requiring pre-arrangement for larger contributions, and making
> maintainers free to apply their own considerations (see [2] for a good
> list).  Maintainers' preferences bring experience and creative thought
> into the process, and contributors must take them into account.
> 
> 2) by introducing agent instructions that help the contributor drive
> the design and understand the code produced by the LLM;
> 
> 3) by introducing an "AI-used-for" trailer that scopes areas where
> Signed-off-by cannot guarantee full control of provenance.
> 
> This series reflects feedback from earlier requests for comments, and
> even earlier discussions with members of the QEMU community.  Thanks to
> everyone who provided feedback on earlier drafts.
> 
> Paolo

things i care about are here so

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> v3->v4:
> - rework opening text [Daniel]
> - exempt "official project agents" from not being able to post to
>   GitLab [Alex]
> - explicitly forbid clean room reimplementation [Kevin/Daniel]
> - remove "The DCO still certifies that the contributor has the legal
>   right to submit code in general" paragraph, replace with a note
>   that "AI-used-for" attests respecting the policies and is considered
>   enough for DCO [Daniel, Kevin]
> - make the requirement to "understand and explain your changes"
>   more prominent
> - small edits for grammar and clarity
> 
> v2->v3:
> - remove parser example, replace with "adaptations of existing code"
> - when LLMs are used for boilerplate, "highly recommend" disclosure
>   for "non-trivial, functional code".  The idea here is to avoid
>   having to disclose using AI to apply e.g. changes related to
>   automatic code review, and leaving people some leeway.
> - clarify split between DCO (legal right to submit code in general)
>   and AI-used-for acknowledging that the submitter cannot audit LLM
>   output against e.g. the training data.
> - clarify the defense-in-depth/swiss-cheese approach to limit the
>   risk of copyright violations from LLM output
> - mention that pre-arrangement is not an entirely new concept
> - mention that maintainers can demand larger changes than for human-written code
> - do not mention inclusion of the prompt
> - add checkpatch.pl hunk, changing the phrasing of "no AI" lint
> - rebase AGENTS.md on top of existing file, split
> - drop CLAUDE.md/GEMINI.md symlinks, already done via .claude/.gemini
> 
> [1] https://lore.kernel.org/qemu-devel/CANCZdfrTwfrK0wnuL2cPVF_9W2-8PXtJeHkgkTP+Uv2sT8s0Ng@mail.gmail.com/
> [2] https://lore.kernel.org/qemu-devel/CAFEAcA860fF_+ffk=cXiYyFoQo0wCSUJ6b=7nVLLCwKhP6Nwxw@mail.gmail.com/
> 
> Paolo Bonzini (4):
>   docs/devel: relax policy on AI-generated contributions
>   AGENTS.md: add final instructions
>   AGENTS.md: let agents know what the participation rules are
>   AGENTS.md: make the human part of the design process
> 
>  docs/devel/code-provenance.rst |  71 +----------
>  docs/devel/index-process.rst   |   1 +
>  docs/devel/llm-usage.rst       | 213 +++++++++++++++++++++++++++++++++
>  AGENTS.md                      | 137 +++++++++++++++++++--
>  scripts/checkpatch.pl          |   5 +-
>  5 files changed, 347 insertions(+), 80 deletions(-)
>  create mode 100644 docs/devel/llm-usage.rst
> 
> -- 
> 2.55.0


