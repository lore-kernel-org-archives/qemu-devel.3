Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB38EC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:13:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1hxJ-00047Z-K7; Wed, 02 Sep 2026 06:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1hxH-00047B-SL
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:12:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x1hxF-0004PU-Of
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788343948;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97U8n991h2NfS/j2xnUcvJSMR/3Dp+GGPIWP9x/B4s8=;
 b=LbK9FmRK1dKSSrqPL24fub0Fo/JKPJS3DSgia4s7Oe88tNT6kE4sAQA8YN6WuSSGUficuF
 PDfL/5FO/ORAgNGfqYpC5TJrUx7uIyTlkieA+BuQBzZgtf7xaTQwvsMHq05uTyZtMjz0D3
 dGfRxGIkia+8uEM+kqXXz78IEDb2rUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-DwX99NKTPYmmQM1hdVhdJA-1; Wed,
 02 Sept 2026 06:12:25 -0400
X-MC-Unique: DwX99NKTPYmmQM1hdVhdJA-1
X-Mimecast-MFC-AGG-ID: DwX99NKTPYmmQM1hdVhdJA_1788343943
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8DE3419560B1; Wed,  2 Sep 2026 10:12:23 +0000 (UTC)
Received: from redhat.com (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F04177D7; Wed,  2 Sep 2026 10:12:20 +0000 (UTC)
Date: Wed, 2 Sep 2026 11:12:17 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/4] agents: add CLAUDE.md and GEMINI.md
Message-ID: <apf2gT5GBD6HZosQ@redhat.com>
References: <20260901161422.314581-1-pbonzini@redhat.com>
 <20260901161422.314581-5-pbonzini@redhat.com>
 <20260902054543-mutt-send-email-mst@kernel.org>
 <CABgObfacwO0bx+wc2s=5aiaEbQghvt-gZc77D6eDigf88mS1zA@mail.gmail.com>
 <20260902060604-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260902060604-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

On Wed, Sep 02, 2026 at 06:06:14AM -0400, Michael S. Tsirkin wrote:
> On Wed, Sep 02, 2026 at 11:56:46AM +0200, Paolo Bonzini wrote:
> > On Wed, Sep 2, 2026 at 11:46 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Tue, Sep 01, 2026 at 06:14:22PM +0200, Paolo Bonzini wrote:
> > > > diff --git a/GEMINI.md b/GEMINI.md
> > > > new file mode 100644
> > > > index 00000000000..43c994c2d36
> > > > --- /dev/null
> > > > +++ b/GEMINI.md
> > > > @@ -0,0 +1 @@
> > > > +@AGENTS.md
> > >
> > > gemini seems to support agents.md - r u at the latest version?
> > 
> > I tested and it doesn't load it for me.
> 
> ok then sorry.

It appears to be doable via a custom setting:

  https://geminicli.com/docs/cli/gemini-md/#customize-the-context-file-name

IOW, we could add a .gemini/settings.json that points it to AGENTS.MD
instead of having a top level GEMINI.md file. Both are somewhat
unpleasant given they're tool specific, but I'd have a slight preference
towards the .gemini solution as dotfiles are a hidden files in many
contexts.

Similarly IIUC it would be possible to have a  .claude/CLAUDE.MD
file instead of the top level one.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


