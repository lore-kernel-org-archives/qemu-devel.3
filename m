Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5816FD77882
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 16:59:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjKUG-0004kG-3V; Fri, 23 Jan 2026 11:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vjKUE-0004jV-7w
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vjKUC-00020f-DC
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 11:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769187492;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KmU3auN+ZIG9hR9PS3SrPhBEox0Lj47kZarCBttL2KQ=;
 b=jIHXxVJS3uvR7Ez5p0XF4n6w1CiAkkPh2rX5S3QHhGgz4vMDwChPvCzSFrlsB9lTXD7k6k
 GWnTziE4g5ljriUGSL5bfyXTmSnPRLvPbWcLq8MDN1owACY/AIFyzw6zV7GlXmzIrdQ26Z
 X6oiiH+fOnUvOBZ6+KYLFXuSD1Uc64k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-xYSeuAryMFyyUzi3FReVNg-1; Fri,
 23 Jan 2026 11:58:04 -0500
X-MC-Unique: xYSeuAryMFyyUzi3FReVNg-1
X-Mimecast-MFC-AGG-ID: xYSeuAryMFyyUzi3FReVNg_1769187482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 585F818003FD; Fri, 23 Jan 2026 16:58:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.199])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6B81C1800998; Fri, 23 Jan 2026 16:57:59 +0000 (UTC)
Date: Fri, 23 Jan 2026 16:57:55 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Warner Losh <imp@bsdimp.com>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: Re: [RFC PATCH v2 08/16] MAINTAINERS: be realistic about *-user
Message-ID: <aXOok4KRTvgwx7GJ@redhat.com>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
 <20260123145750.1200879-9-alex.bennee@linaro.org>
 <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANCZdfo3yz=aC-EOxd2LYBX=tf=RQTY6ibCpj-fCfGHZtH6WTw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.079,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 23, 2026 at 08:12:33AM -0700, Warner Losh wrote:
> On Fri, Jan 23, 2026 at 8:00 AM Alex Bennée <alex.bennee@linaro.org> wrote:
> 
> > We should reflect the current status so users don't have unrealistic
> > expectations of how quickly things can get reviewed and merged.
> >
> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> >
> 
> Reviewed-by: Warner Losh <imp@bsdimp.com>

snip
 
> A lot of the upstreaming work that's stalled would be ideal to tell claude
> to do,
> but I'm unsure the project's stance on using claude to move code, and git
> log
> 5 different trees to get the original author(s) of the code and make
> trivial compile
> tweaks.

The critical thing we don't want is such tools making changes to the
contents of source files.

Automating the moving around of files is a non-issue.

The use of AI for writing commit messages is arguably in scope of QEMU's
AI policy given that is part of "the contribution", but it is less serious
there, since commit messages don't have a copyright implication on what we
host & distribute.

More important is that the commit messages are accurate and well written.
LLMs have a tendancy to be overly verbose about irrelevant stuff, and of
course the well known danger of hallucinating nonsense. IME that makes it
challenging to benefit from an LLM, due to review & re-writing overheads
you then incurr to validate and fix their output.

I'd be wary of relying on an AI to extract and report on authorship of
code. Accuracy is important there since it implies copyright ownership
associations. Likewise a Signed-off-by tag should be added by humans
only since it is a statement they are complying with the DCO policy.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


