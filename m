Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5612CCC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:34:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGYtC-0004Mi-BL; Tue, 13 Oct 2026 05:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGYtA-0004MK-8U
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:33:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xGYt7-00055K-Mg
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 05:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791884016;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fw7CuU3u88H/K8nC8gcPmxBvp9WckL8MhUyeKygmuXI=;
 b=FsdQidZCt+cSXUsvgTbIG9Zh6QRUzd/+pvRh9FQ6M7JT533WvIKRIPm3SWnWI6rG8LeM6u
 wVjNLInJsNmraPR/hmsCsABuVwuS8KIgkmRz06Gh9ZDfdnnFNbsxrsxV98uPXjQdZl/Fe5
 AtA92DXlCQYvb+j91csvcHDSm3KzHoY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-GXE23TynOjixqRhhFph5vQ-1; Tue,
 13 Oct 2026 09:33:32 +0000
X-MC-Unique: GXE23TynOjixqRhhFph5vQ-1
X-Mimecast-MFC-AGG-ID: GXE23TynOjixqRhhFph5vQ_1791884011
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4427F1800DA1; Tue, 13 Oct 2026 09:33:31 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3368130001B9; Tue, 13 Oct 2026 09:33:27 +0000 (UTC)
Date: Tue, 13 Oct 2026 10:33:25 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 3/4] AGENTS.md: let agents know what the participation
 rules are
Message-ID: <as365R8TTit-dYno@redhat.com>
References: <20260930085433.830743-1-pbonzini@redhat.com>
 <20260930085433.830743-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930085433.830743-4-pbonzini@redhat.com>
User-Agent: Mutt/2.4.2 (2026-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 30, 2026 at 10:54:32AM +0200, Paolo Bonzini wrote:
> Humans seem to be extremely unreliable in following rules around this,
> even after being told directly and repeatedly. Telling agents what to
> do seems to yield better results.
> 
> The starting point for this document is GStreamer's AGENTS.md file, as
> of commit d08375499c279a56c0e77c928fbeae0d80cdf937.  I used GStreamer's
> agent instructions in the context of Meson, which uses a very similar
> file, and it's both annoying and too willing to take the lead once the
> model decides that it likes you.
> 
> To avoid this, the text tries to favor cooperation between agent and user.
> It suggests that the agent includes the state of the work when committing,
> so that contributors have the material they need to review the agent's
> work.
> 
> To test it I tried the following prompt:
> 
>   Hi, i am doing my first AI assisted contribution to QEMU. i am familiar
>   with the project, but would nevertheless like to experiment. please
>   generate a sample implementation of a pressure sensor, of any model,
>   of a kind that is commonly used with Arduino or ESP32 microcontrollers.
> 
> The agent did read llm-usage.rst and after doing the work (implementing
> a BMP280 pressure/temperature sensor) it noticed:
> 
>   Policy, before this goes anywhere near the list. A new device model plus
>   qtest is the fourth bucket in docs/devel/llm-usage.rst: large, heavily
>   LLM-assisted, allowed only if pre-arranged — a maintainer has to say on
>   IRC or the list beforehand that they'll review it. hw/sensor is Philippe
>   Mathieu-Daudé (Odd Fixes), with Corey Minyard on I2C. I should have
>   flagged this before writing rather than after; that's on me. Disclosure
>   would be AI-used-for: code, tests above your Signed-off-by, and the
>   commit message and any list replies have to be yours, not edited from mine.
> 
> I then asked "Can you provide a draft of the commit message with all the
> sources (datasheet, etc.)?" The agent complied but noticed:
> 
>   AGENTS.md and docs/devel/llm-usage.rst state that commit messages MUST
>   be written by humans — an AI-drafted one must not reach the list
>   even lightly edited. So treat the below as scaffolding for facts and
>   sources, and write the final text yourself.
> 
> After some editing I asked "ok, will you please commit for me?" and
> it did so with basically my text, while also reminding me about the need
> for maintainer pre-arrangement.
> 
> I asked "assuming pre-arrangement is this ok according to the policy?"
> and this was the assessment:
> 
>   "Well-tested" — held to a higher standard, and here's what's actually
>   missing: [...] the vmstate (no migration test), reading past 0xFC and
>   reserved registers, the pointer_valid error path, oversampling/filter
>   fields beyond one readback, and behavior against a real driver — Linux
>   bmp280 was never run against this. None of those is hard; whether the
>   current set clears the higher bar is a judgment call I'd rather hand
>   you than make.
> 
>   "High-quality" is the open one. The doc asks that you have reviewed and
>   curated the contribution and can explain the changes and the rationale
>   in depth. In this session you engaged with the commit message and the
>   sources — and caught my datasheet error, which I got wrong — but the
>   design decisions were mine and unexamined by you [...]
> 
> Overall, the files do affect the behavior of the agent.  The agent
> however made too many design decisions on its own.  This will be fixed
> in a separate step.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  AGENTS.md | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 66 insertions(+)
> 
> diff --git a/AGENTS.md b/AGENTS.md
> index 6d2c7e1580b..8c7407b908e 100644
> --- a/AGENTS.md
> +++ b/AGENTS.md
> @@ -8,12 +8,73 @@ is **a scarce resource**.
>  There are strictly-enforced rules for you, the agent, to participate in the
>  project.
>  
> +## Interactions with maintainers must be human-human
> +
> +The QEMU project has strict rules on what AI-generated material can
> +reach the maintainers.
> +
> +### No automated posting
> +
> +Agents **must not** use any API, CLI, or web UI automation to:
> +
> +- Interact on the QEMU mailing lists
> +- Create, edit, or close **issues ("work items")**
> +- Post **comments** on merge requests, issues or commits
> +- Open or update **merge requests (MRs)**.  QEMU does not use merge requests anyway.

This needs to repeat the exception for "project official agents" that
is mentioned in llm-usage.rst, because later on this doc it says:

 "In case of contradiction consider `AGENTS.md` authoritative on how to behave,
  since it is crafted specifically for agents."

so the exception in llm-usage.rst can't override this AGENTS.md  rule
forbidding API usage


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


