Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49423C021AA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2025 10:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkhEY-0006AU-Ay; Wed, 19 Feb 2025 05:23:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkhDz-00069A-UH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:23:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkhDx-0008Sg-27
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 05:22:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739960555;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Y5oTyihlv2r1PzHzBpqIwuXf7rdx5G0OLqbsEDeG+Nk=;
 b=dsVFseAMNLqsppNMmKmpDl5tSk3WOWqxjEv1Abn6Ytsg1SGTYmDX94Np++BvbDq3ItfabB
 OxII9M90TmGrVF4ATniMyZ0Mj0Evx8/OqMAR1vjARnk/ixHsJVHNCx4xNUr8Gf9pMNH1fC
 XnXJh7YTrrz/JqpZYY6WKkEpLSoOrhk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42--WvYheAUP5KVQLkfg1fSTQ-1; Wed,
 19 Feb 2025 05:22:26 -0500
X-MC-Unique: -WvYheAUP5KVQLkfg1fSTQ-1
X-Mimecast-MFC-AGG-ID: -WvYheAUP5KVQLkfg1fSTQ_1739960545
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA22919783B2; Wed, 19 Feb 2025 10:22:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.135])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 804681955BCB; Wed, 19 Feb 2025 10:22:23 +0000 (UTC)
Date: Wed, 19 Feb 2025 10:22:19 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Faisal Al-Humaimidi <falhumai96@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: Permissively Licensing the CPU Component
Message-ID: <Z7Ww25VdhY_eDmof@redhat.com>
References: <CAMx8kb0zN7CPjuFJatoF+5UBwdLaCA_AJGcxUV8cdBoDd1RBag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMx8kb0zN7CPjuFJatoF+5UBwdLaCA_AJGcxUV8cdBoDd1RBag@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 19, 2025 at 01:59:08AM -0800, Faisal Al-Humaimidi wrote:
> Hello QEMU developers,
> 
> I understand from this page, https://wiki.qemu.org/License, that TCG is
> being licensed permissively (BSD license) so it can be integrated as a
> library in other projects, which is great!

Not so fast. Individual source files may be under the BSD license, but
those source files are rarely buildable & usable in isolation. They will
consume APIs in other parts of QEMU which are under the GPL license, and
thus the combined work will be under the GPL per that wiki License page
above.

IOW, if you wanted to takes pieces which are BSD license and use them
exclusively under BSD in a combined work, you would need to re-implement
any other code it depends on which was not also BSD licensed. This is
unlikely to be a sensible investment of time IMHO.

>                                             However, I'd like to know if the
> CPU part of QEMU, no peripherals included, is also permissively licensed
> (maybe BSD or some other permissive license such as LGPL, ...etc.)?

Again, QEMU as a whole is under the GPL-v2-only, because the process of
building QEMU into a functional binary pulls together code under many
licenses with GPL-v2-only being the one that sets the overall terms in
QEMU's case. 

> The reason I am asking this question is because projects such as the
> Unicorn Engine would greatly benefit from a permissively licensed CPU
> component so that the project itself (Unicorn Engine) is also released
> under a permissive license, which would be great for people wanting to do
> research with the Unicorn Engine but are tied with proprietary code (e.g.,
> in proprietary university research projects). I have started a discussion
> for that matter with the Unicorn Engine developers in their GitHub page,
> https://github.com/unicorn-engine/unicorn/issues/2114, and it would be
> great to have a feedback regarding this matter from the official QEMU
> developers, whether directly on the issue or a reply to this email and I'd
> relay your response.

Since AFAICT unicorn engine has copied in the entire of the QEMU source
tree, and many of the BSD bits of QEMU will consume other GPL code, I
don't see a possibility to change. Individual source files can be under
a variety of licenses, but the combined work will inevitably be under
the GPL-v2-only.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


