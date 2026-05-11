Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1CCFCD37BE
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 17:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMUVC-00063h-0u; Mon, 11 May 2026 13:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMUV6-00062M-5q
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:33:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wMUV4-00027P-ER
 for qemu-devel@nongnu.org; Mon, 11 May 2026 13:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778520781;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eklJSWeh/+HlCaCa015LzkbUWF+FvRwUjYwQztd8asw=;
 b=Scf21+IGznSdsJ0l9mtI1e/WPJHxrRVLuf/crF5yU2770xofHtoNm3tDUN5M5iktCnKdLg
 YfCf5mQpIi0UzDkXMgqu3o0wiDRrw2LH69S4pD1xPdnV9b3JPRTyWqGwubKAtqWfOp3TGj
 TloXBFD0wZnSMzxLjrMv7hKv0WcLmts=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-692-24fKK-yhNyixZfpr1suKfQ-1; Mon,
 11 May 2026 13:32:59 -0400
X-MC-Unique: 24fKK-yhNyixZfpr1suKfQ-1
X-Mimecast-MFC-AGG-ID: 24fKK-yhNyixZfpr1suKfQ_1778520778
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96DD4195608A; Mon, 11 May 2026 17:32:58 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F06931800349; Mon, 11 May 2026 17:32:56 +0000 (UTC)
Date: Mon, 11 May 2026 18:32:53 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: Re: [RFC PATCH v2 03/10] .agents/skills: add qemu-code-explorer skill
Message-ID: <agISxb-entwoYzzF@redhat.com>
References: <20260511170500.124211-1-alex.bennee@linaro.org>
 <20260511170500.124211-4-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511170500.124211-4-alex.bennee@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, May 11, 2026 at 06:04:52PM +0100, Alex Bennée wrote:
> This provides a skill detailing how to explore the QEMU code base. It
> guides the agents to use the tags and git-grep by default and outlines
> some of the confusions that can occur with multiple build directories.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - remove personal gtag skill references, add global stanzas directly
>   - moved macro information from AGENTS.md into code explorer
>   - more imperative language to trigger its use
>   - add section on using scripts/expand_macro.py
>   - remove eca reference from evals.json (maybe we should just drop this)
> ---
>  .agents/skills/qemu-code-explorer/SKILL.md    | 119 ++++++++++++++++++
>  .../qemu-code-explorer/evals/evals.json       |  26 ++++
>  AGENTS.md                                     |   1 +
>  3 files changed, 146 insertions(+)
>  create mode 100644 .agents/skills/qemu-code-explorer/SKILL.md
>  create mode 100644 .agents/skills/qemu-code-explorer/evals/evals.json
> 
> diff --git a/.agents/skills/qemu-code-explorer/SKILL.md b/.agents/skills/qemu-code-explorer/SKILL.md
> new file mode 100644
> index 00000000000..d5b7d6a35cd
> --- /dev/null
> +++ b/.agents/skills/qemu-code-explorer/SKILL.md
> @@ -0,0 +1,119 @@
> +---
> +name: qemu-code-explorer
> +description: Systematic framework for deep-diving into the QEMU codebase. Use this to find precise symbol definitions (functions, structs, globals), locate all call sites or references, explore subsystem architectures, or search generated code in build directories. You MUST use this skill when exploring code flow and dependencies.
> +license: GPL-2.0-or-later

Is "license:" a mandatory tag from a schema we're following here,
or can be used "SPDX-License-Identifier:" instead ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


