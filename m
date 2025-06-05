Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8580EC5B559
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 11:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN9D0-0001xp-Ty; Thu, 05 Jun 2025 07:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN9Cr-0001x9-Jk
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uN9Cm-0003JD-7V
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 07:56:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749124577;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=YrkTxdXamU05DnncyUIY611x66dhDAlB/L2mdIrIAx4=;
 b=GSTzPaccRhtWFgNSXncdUvEtPsSe0wJXfANWQYiRN4dgyrm6mvsLst4hxSID59YHmIXrB6
 K5xZkWUeXFDeoPsOO7lTAejyGT8QhUKrme2y+ANPSepxUcvfKMy8avHyyyzyYawsrFtnnq
 scQy7+2/zfZbj9szR32bx70jKDkyQXw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-TDXmr4bsPkyhmtDh_2jcmw-1; Thu,
 05 Jun 2025 07:56:14 -0400
X-MC-Unique: TDXmr4bsPkyhmtDh_2jcmw-1
X-Mimecast-MFC-AGG-ID: TDXmr4bsPkyhmtDh_2jcmw_1749124572
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 50753195608A; Thu,  5 Jun 2025 11:56:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.159])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 800E5195609D; Thu,  5 Jun 2025 11:56:07 +0000 (UTC)
Date: Thu, 5 Jun 2025 12:56:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v4 2/3] docs: define policy limiting the inclusion of
 generated files
Message-ID: <aEGF1FVWyIWNVamw@redhat.com>
References: <20250605105219.261925-1-armbru@redhat.com>
 <20250605105219.261925-3-armbru@redhat.com>
 <CAFEAcA-QPO4jPEs9ZbS3ed0LARe4caFnNC54zi=+XsFdS0Wz7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA-QPO4jPEs9ZbS3ed0LARe4caFnNC54zi=+XsFdS0Wz7g@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Jun 05, 2025 at 12:38:09PM +0100, Peter Maydell wrote:
> On Thu, 5 Jun 2025 at 11:52, Markus Armbruster <armbru@redhat.com> wrote:
> > +At times contributors may use or create scripts/tools to generate an initial
> > +boilerplate code template which is then filled in to produce the final patch.
> > +The output of such a tool would still be considered the "preferred format",
> > +since it is intended to be a foundation for further human authored changes.
> > +Such tools are acceptable to use, provided they follow a deterministic process
> > +and there is clearly defined copyright and licensing for their output.
> 
> For the case where there's a one-off generation step and then the
> intent is purely human-authored changes from there onwards, why
> do we care whether the tool followed a deterministic process or
> not? As long as the copyright/licensing situation is clear and
> the submitter has checked tha the generation is what they want,
> what does determinism get us?

The copyright/licensing is important, but it was trying to say
more than that to limit the scenarios in which generated code
would be contributed. I think determinism in the tool's operation
is valuable, but probably not the key point to get across here.

We don't want a free for all in hand editting and then contributnig
any auto-generated content. We only want generated content included
where it was explicitly intended that it serve as a "template" for
human refinement.

Determinisism in the sense that if a 2nd person used the same
tool to auto-generate the base template for editting, they would
be starting from the same place as the original contributior.

> As a trivial example, this rules out a hacky one-off python
> script that produces output by iterating through a hashtable
> if you forgot to add a "sort" to that ordering to make it
> deterministic.

NB it is trying to say that the way the tool operates is determinstic,
not that its output is neccessarily stable wrt things like sorting.
ie you can rationalize about what the tool is going to emit, but.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


