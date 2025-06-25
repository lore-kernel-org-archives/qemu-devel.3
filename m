Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16944C7EE2A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:48:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUW5U-0004pn-Dx; Wed, 25 Jun 2025 15:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUW5S-0004pM-NJ
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:47:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uUW5Q-0006zi-Iq
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:47:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750880828;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aHMoqjFSP+5QoeYbIOVh0M/IP7ZrrAmbWTeaOLD30sQ=;
 b=hsUd7rQ6iBOvmlEwMDkQFmYKynoQ2NKV4CV4B0Ux5xCx6rAPgV1UmBMVu/4OFE/d+ml/rr
 nbIOUsl/ikf9BEETCRhnRGzpHfV929vcNoQevBFtz+bHvw8C4RhOaesvf1ANlpZ9+M9pto
 JwG4Youjsevmd7TR3eWOCrQ5hHFLQoQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-S5gfFGS6NMqFjzljAnXnxg-1; Wed,
 25 Jun 2025 15:47:04 -0400
X-MC-Unique: S5gfFGS6NMqFjzljAnXnxg-1
X-Mimecast-MFC-AGG-ID: S5gfFGS6NMqFjzljAnXnxg_1750880823
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA1E19560A2; Wed, 25 Jun 2025 19:47:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 348D51956094; Wed, 25 Jun 2025 19:46:57 +0000 (UTC)
Date: Wed, 25 Jun 2025 20:46:54 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <aFxRUFIfuDdRYA2m@redhat.com>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
 <20250625150941-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250625150941-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jun 25, 2025 at 03:16:52PM -0400, Michael S. Tsirkin wrote:
> On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> > From: Daniel P. Berrangé <berrange@redhat.com>
> > 
> > There has been an explosion of interest in so called AI code
> > generators. Thus far though, this is has not been matched by a broadly
> > accepted legal interpretation of the licensing implications for code
> > generator outputs. While the vendors may claim there is no problem and
> > a free choice of license is possible, they have an inherent conflict
> > of interest in promoting this interpretation. More broadly there is,
> > as yet, no broad consensus on the licensing implications of code
> > generators trained on inputs under a wide variety of licenses
> > 
> > The DCO requires contributors to assert they have the right to
> > contribute under the designated project license. Given the lack of
> > consensus on the licensing of AI code generator output, it is not
> > considered credible to assert compliance with the DCO clause (b) or (c)
> > where a patch includes such generated code.
> > 
> > This patch thus defines a policy that the QEMU project will currently
> > not accept contributions where use of AI code generators is either
> > known, or suspected.
> > 
> > These are early days of AI-assisted software development. The legal
> > questions will be resolved eventually. The tools will mature, and we
> > can expect some to become safely usable in free software projects.
> > The policy we set now must be for today, and be open to revision. It's
> > best to start strict and safe, then relax.
> > 
> > Meanwhile requests for exceptions can also be considered on a case by
> > case basis.
> > 
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> > Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> > Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
> 
> Sorry about only reacting now, was AFK.
> 
> So one usecase that to me seems entirely valid, is refactoring.
> 
> For example, change a function prototype, or a structure,
> and have an LLM update all callers.
> 
> The only part of the patch that is expressive is the
> actual change, the rest is a technicality and has IMHO nothing to do with
> copyright. LLMs can just do it with no hassle.

Well the policy is defined in terms of requirements to comply with
the DCO, and that implicitly indicates that the code in question
is eligible for copyright protection to begin with.

IOW, if a change is such that it is not considered eligible for
copyright protection, then you can take the view that it is trivially
DCO compliant, whether you wrote the code, an arbitrary 3rd party
wrote the code, or whether an AI wrote the code. 
 
> Can we soften this to only apply to expressive code?
> 
> I feel a lot of cleanups would be enabled by this.

Trying to detail every possible scenario is impractical and would
make the document too onerous for people to read, remember & apply.
It is better to leave it up to the contributor to decide whether a
change is non-copyrightable, than to try to draw that line crudely
in text. Even for refactoring that line will be fuzzy and contextual,
so not a scenario where we should say any use of AI for reactoring
is OK, as that will lull contributors into having a false sense of
acceptibility, rather than being aware of need to question it. 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


