Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEAAC7115B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:19:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhon-0001Ur-CL; Thu, 26 Jun 2025 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUhol-0001UZ-FV
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:18:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUhoe-0000ju-2K
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750925918;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZII6pwIZHcjn10bvI0HrhQOeLlFOkL2hrp0dcR05Mck=;
 b=GoNtZ1+2Xb7xRhM8YV8QVHltZWGc2kKDMe8r18IiH4phsrRUBY6Hzv3A99lHVvt06r0hgb
 FL2nc1qwuN1ayYe/TC4SqsmCcE0sHrtM6eG+oDp9YQMtc7UNccJ6PIsDGYGCfwXTVBazA7
 mVL3cZH0bc+zWC4V8WcOulNzgQX+Rb8=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-qIyt81rDN_ufCZixBhOV3A-1; Thu,
 26 Jun 2025 04:18:34 -0400
X-MC-Unique: qIyt81rDN_ufCZixBhOV3A-1
X-Mimecast-MFC-AGG-ID: qIyt81rDN_ufCZixBhOV3A_1750925913
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A9C381954215; Thu, 26 Jun 2025 08:18:32 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.58])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F2D419560B3; Thu, 26 Jun 2025 08:18:25 +0000 (UTC)
Date: Thu, 26 Jun 2025 09:18:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <aF0CTtZfBHFpolZM@redhat.com>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
 <aFxePYi6bzLQ8UvN@redhat.com>
 <CAJSP0QXG_QD+ZWsRgpxSNyXYBooMkfX+gSOOFE8XWghv1E-htw@mail.gmail.com>
 <20250625164902-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625164902-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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

On Wed, Jun 25, 2025 at 04:49:17PM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 25, 2025 at 04:47:06PM -0400, Stefan Hajnoczi wrote:
> > On Wed, Jun 25, 2025 at 4:39 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > >
> > > Am 25.06.2025 um 21:16 hat Michael S. Tsirkin geschrieben:
> > > > On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > > > > From: Daniel P. Berrangé <berrange@redhat.com>
> > > > >
> > > > > There has been an explosion of interest in so called AI code
> > > > > generators. Thus far though, this is has not been matched by a broadly
> > > > > accepted legal interpretation of the licensing implications for code
> > > > > generator outputs. While the vendors may claim there is no problem and
> > > > > a free choice of license is possible, they have an inherent conflict
> > > > > of interest in promoting this interpretation. More broadly there is,
> > > > > as yet, no broad consensus on the licensing implications of code
> > > > > generators trained on inputs under a wide variety of licenses
> > > > >
> > > > > The DCO requires contributors to assert they have the right to
> > > > > contribute under the designated project license. Given the lack of
> > > > > consensus on the licensing of AI code generator output, it is not
> > > > > considered credible to assert compliance with the DCO clause (b) or (c)
> > > > > where a patch includes such generated code.
> > > > >
> > > > > This patch thus defines a policy that the QEMU project will currently
> > > > > not accept contributions where use of AI code generators is either
> > > > > known, or suspected.
> > > > >
> > > > > These are early days of AI-assisted software development. The legal
> > > > > questions will be resolved eventually. The tools will mature, and we
> > > > > can expect some to become safely usable in free software projects.
> > > > > The policy we set now must be for today, and be open to revision. It's
> > > > > best to start strict and safe, then relax.
> > > > >
> > > > > Meanwhile requests for exceptions can also be considered on a case by
> > > > > case basis.
> > > > >
> > > > > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > > > > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > > > > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > > > > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> > > >
> > > > Sorry about only reacting now, was AFK.
> > > >
> > > > So one usecase that to me seems entirely valid, is refactoring.
> > > >
> > > > For example, change a function prototype, or a structure,
> > > > and have an LLM update all callers.
> > > >
> > > > The only part of the patch that is expressive is the
> > > > actual change, the rest is a technicality and has IMHO nothing to do with
> > > > copyright. LLMs can just do it with no hassle.
> > > >
> > > >
> > > > Can we soften this to only apply to expressive code?
> > > >
> > > > I feel a lot of cleanups would be enabled by this.
> > >
> > > Hasn't refactoring been a (deterministically) solved problem long before
> > > LLMs became capable to do the same with a good enough probability?
> > 
> > It's easier to describe a desired refactoring to an LLM in natural
> > language than to figure out the regexes, semantic patches, etc needed
> > for traditional refactoring tools.
> > 
> > Also, LLMs can perform higher level refactorings that might not be
> > supported by traditional tools. Things like "split this interface into
> > callbacks that take a Foo * argument and implement the callbacks for
> > both a.c and b.c".
> > 
> > I think what Daniel mentioned is a good guide: if it's something that
> > you think it copyrightable, then avoid it.
> 
> Right. Let's put that in the doc?

In terms of mitigating risk I think it is better to avoid saying that
explicitly, and be seen to actively encourage acceptance of AI generated
code. The boundary between copyrightable and non-copyrightable code is
always pretty fuzzy and a matter of differing opinions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


