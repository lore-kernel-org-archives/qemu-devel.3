Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29861C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:35:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x27aw-00005Q-9j; Thu, 03 Sep 2026 09:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x27av-00005C-1G
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:35:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x27at-00040d-0a
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 09:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788442504;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+D1KD+FdZ6EGoWCLn7HL2iIYBLzP2KRnbEGQvWj/iH0=;
 b=Xo90NyczjJW3AGrqOoxRH5qxFKuVsf08pDbQ/MC2vn2KNth4CkViyutPr77KSRvh9gcBsa
 yjd0AxKaxNU8FxVVsNGNDC7UHWqEgldKjVElxgB/TMUHbNEXpYYdwBUVbwmf1+pNeOOkg4
 U318X0XXFEzrS3LpQzJO+nKgSd7q5F4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-6yBY7GkdNfqHm0hkby6rlg-1; Thu,
 03 Sep 2026 09:35:01 -0400
X-MC-Unique: 6yBY7GkdNfqHm0hkby6rlg-1
X-Mimecast-MFC-AGG-ID: 6yBY7GkdNfqHm0hkby6rlg_1788442498
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F931195DB9F; Thu,  3 Sep 2026 13:34:58 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14D3818001CE; Thu,  3 Sep 2026 13:34:56 +0000 (UTC)
Date: Thu, 3 Sep 2026 14:34:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [RFC PATCH v3] AGENTS.md: basic bare minimal guide
Message-ID: <apl3ftMWA44nHexR@redhat.com>
References: <20260903122516.1377717-1-alex.bennee@linaro.org>
 <CAFEAcA_TaGW+7jvtp8OXjvGeJMce75MzZrimCWyaHrfa+ttx7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_TaGW+7jvtp8OXjvGeJMce75MzZrimCWyaHrfa+ttx7w@mail.gmail.com>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Thu, Sep 03, 2026 at 02:24:39PM +0100, Peter Maydell wrote:
> On Thu, 3 Sept 2026 at 13:25, Alex Bennée <alex.bennee@linaro.org> wrote:
> >
> > Currently people may be inadvertently not following our documented
> > process for code submissions because people often don't read the docs.
> > However AI Agents do tend to try and follow instructions so lets help
> > them out.
> >
> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> > diff --git a/.claude/CLAUDE.md b/.claude/CLAUDE.md
> > new file mode 120000
> > index 00000000000..be77ac83a18
> > --- /dev/null
> > +++ b/.claude/CLAUDE.md
> > @@ -0,0 +1 @@
> > +../AGENTS.md
> > \ No newline at end of file
> 
> Missing newline, as git notes.

IIUC, that's just a result of how git represents symlinks

> 
> > +## Security Policy (see `docs/system/security.rst`)
> > +
> > +You MUST NOT report potential security vulnerabilities to the public
> > +GitLab issue tracker as a normal issue. They should be reported as a
> > +GitLab "confidential" work item, as described at
> > +https://www.qemu.org/contribute/security-process/
> > +
> > +**Crucial for AI Triage**: Not every crash, assertion failure, or
> > +buffer overrun is a security vulnerability. Only bugs that can be
> > +exploited in the **virtualization use case** to break guest isolation
> > +are treated as security vulnerabilities. In brief these are:
> > +- **Hardware Accelerators**: e.g. KVM and Xen, TCG is explicitly excluded.
> 
> "Xen. TCG", not a comma. Otherwise it's unclear whether you're
> including or excluding KVM and Xen.

If that change is made, then add

 Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


