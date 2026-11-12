Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C925606A882
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a6KVj/GA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYiM-0004Y8-TI; Thu, 12 Nov 2026 12:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRYiL-0004Xx-Tk
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:35:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRYiK-0007zx-2Z
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:35:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794504953;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3UIWWApkEK/+mdVOJppXLWJ6X2pvNKR7xYYA2tnfBKY=;
 b=a6KVj/GAjL1gNyQIY79Ly2B695ordsofIUPvQHQ/mpO5E3SS0Mo+WAjvbQi+EmwYTqpuYq
 nQ9w+SXpmR28GAVyVwsP1wkpi9/RtVKoN7BT30lF+GgvK22udlL/VCWrUjO4QextX2z1kK
 F9es4bYuBDBWQSdRTcHjE5FKF3Lg1kQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-103-qOo5JPrqPlCpZACZhnVgOg-1; Thu,
 12 Nov 2026 12:35:50 -0500
X-MC-Unique: qOo5JPrqPlCpZACZhnVgOg-1
X-Mimecast-MFC-AGG-ID: qOo5JPrqPlCpZACZhnVgOg_1794504949
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5844A19560B8
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:35:49 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99DC330000E5; Thu, 12 Nov 2026 17:35:48 +0000 (UTC)
Date: Thu, 12 Nov 2026 17:35:45 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] .claude: delete obsolete/redundant link to AGENTS.md
Message-ID: <avX48aE_IBbaoy0O@redhat.com>
References: <20261013134936.1012354-1-berrange@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261013134936.1012354-1-berrange@redhat.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping for any review/acks

On Tue, Oct 13, 2026 at 02:49:36PM +0100, Daniel P. Berrangé wrote:
> From the release notes for Claude Code 2.1.277:
> 
>   https://github.com/anthropics/claude-code/blob/main/CHANGELOG.md
> 
>   "Added AGENTS.md support: in a project with no CLAUDE.md,
>    Claude Code reads AGENTS.md instead"
> 
> Version 2.1.281 fixed a few further bugs
> 
>   "Changed AGENTS.md support to also work on Amazon Bedrock,
>    Google Vertex AI, Microsoft Foundry, LLM gateways, and sessions
>    with telemetry disabled"
> 
> If we assume people will keep their Claude Code updated, then the
> .claude rules we added to link to AGENTS.md are now redundant, or
> very soon will be.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  .claude/rules/agents-md.md | 1 -
>  1 file changed, 1 deletion(-)
>  delete mode 100644 .claude/rules/agents-md.md
> 
> diff --git a/.claude/rules/agents-md.md b/.claude/rules/agents-md.md
> deleted file mode 100644
> index 43c994c2d36..00000000000
> --- a/.claude/rules/agents-md.md
> +++ /dev/null
> @@ -1 +0,0 @@
> -@AGENTS.md
> -- 
> 2.56.0
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


