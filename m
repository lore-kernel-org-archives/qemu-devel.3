Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69C0C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:17:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8c0m-0000jK-Eo; Mon, 21 Sep 2026 07:16:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8c0k-0000j6-E0
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:16:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x8c0i-0002WU-Ma
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 07:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789989395;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=tID12N1c3DcQUupjdK3Rrv1gQhgS9idSgGCeD/+qvzU=;
 b=bxyj+FhWsbrTyGSWcvPeEJKON9CKNM0zvbjyJbMj2BKjVeZuCczgVmMleexBmTeSfcjRS8
 lou44wViEt1IWWnM1YOAf+xShLr2CMiY9JRIXwiJZy4ly7g5WungUW1XIPR8wWhHqskdsZ
 5xMHAFZMS67ZrkBBBf3KHP9WYGEUwmg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-3rUeOPR0M7msmcWccTHc5Q-1; Mon,
 21 Sep 2026 07:16:32 -0400
X-MC-Unique: 3rUeOPR0M7msmcWccTHc5Q-1
X-Mimecast-MFC-AGG-ID: 3rUeOPR0M7msmcWccTHc5Q_1789989390
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55354195423C; Mon, 21 Sep 2026 11:16:30 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AAD49300106B; Mon, 21 Sep 2026 11:16:27 +0000 (UTC)
Date: Mon, 21 Sep 2026 12:16:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] AGENTS.md: make the human part of the design process
Message-ID: <arESCDXvbT7FtV92@redhat.com>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921075251.12831-5-pbonzini@redhat.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Sep 21, 2026 at 09:52:51AM +0200, Paolo Bonzini wrote:
> This came out of the experiment with the first version of the AGENTS.md
> file.  This addition improved the behavior of the agent from the very
> beginning.  The very first answer to the same prompt was "I'll orient
> in the codebase first, then we should talk about design choices before
> I write anything".
> 
> In fact, after thinking it pointed out from the start that this requires
> pre-arrangement and asked two questions (how to represent the pressure and
> temperature in the QOM properties, how much of the behavior to implement).
> Even with a single data point it seems worth trying.
> 
> When asked to commit autonomously, the LLM also clarified that it
> wouldn't add S-o-b trailers and that pre-arrangement was on me.
> It included "Message written by an AI and to be rewritten by hand; not
> for submission as is" in the commit message, a "handover notes"
> section about design choices that were made without the user input,
> and the umpteenth reminder that the work may only be posted if a
> maintainer has agreed beforehand to review them.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  AGENTS.md | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/AGENTS.md b/AGENTS.md
> index 816ba7646c1..cb3e6087ee0 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -52,6 +52,9 @@ QEMU's policy for AI-assisted work requires the human to develop in depth
>  familiarity with contributions and disclose use of agents to write parts
>  of the code.
>  
> +The golden rule: **The human should know the alternatives before
> +implementation. ASK before choosing for them**.

I'd suggest   "ASK instead of choosing for them"

> +
>  ### Human must demonstrate understanding
>  
>  Staying familiar with what's going on requires constant effort on part of
> @@ -72,6 +75,22 @@ In order to protect the project's scarcest resource, which is review time:
>  - You must **tell humans about these expectations** at handover.  Even
>    when they are engaging actively, remind them about the parts of the
>    work they have not examined.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


