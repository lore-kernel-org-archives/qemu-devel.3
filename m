Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26418CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 13:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKygk-0000C7-Js; Thu, 07 May 2026 09:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKygj-0000Bj-4W
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wKygh-0006az-AY
 for qemu-devel@nongnu.org; Thu, 07 May 2026 09:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778160166;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+qQUmklaXvLgbnX1Kbj4dRUon0VPCwxGqUtzGnNUwiY=;
 b=gUOPxhfbtVC7zCVZf4nu7JnzQOy0tW9gGmjXuIRyHeaWvNzd5tmw9IThOYZNg9SfR8AVgw
 GrwagKyP7LaavSvtJ32unGfsGNtzlqeWxgVBq5ZqpCNfmN+FUahx9x/R/EBX+Tm+v+Y8xh
 5n5LWa4gWVENm01CJsKfqv3jatsRTcc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-0TTCfP3FPeanqQfang8YRw-1; Thu,
 07 May 2026 09:22:41 -0400
X-MC-Unique: 0TTCfP3FPeanqQfang8YRw-1
X-Mimecast-MFC-AGG-ID: 0TTCfP3FPeanqQfang8YRw_1778160159
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3BAAB19560B7; Thu,  7 May 2026 13:22:39 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1344195394A; Thu,  7 May 2026 13:22:35 +0000 (UTC)
Date: Thu, 7 May 2026 14:22:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Gustavo Bueno Romero <gustavo.romero@linaro.org>
Subject: Re: Future of target/arm "max" CPU type
Message-ID: <afySGCxI0NQdDyOG@redhat.com>
References: <CAFEAcA-WB+vfiHZpPut=AdEOCXacsTfrvxiGAmhaGH1abHD8ag@mail.gmail.com>
 <4a46393d-08be-40e9-8f52-788d46ab36cf@oss.qualcomm.com>
 <f72abfd1-bef7-407f-a62d-465d9aea0aca@linaro.org>
 <afxpc_5OvkiEyXxu@redhat.com>
 <eb9b9aa4-c590-41ad-80c6-170f0b83ed92@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9b9aa4-c590-41ad-80c6-170f0b83ed92@linaro.org>
User-Agent: Mutt/2.3.1 (2026-03-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 07, 2026 at 03:20:27PM +0200, Philippe Mathieu-Daudé wrote:
> On 7/5/26 12:29, Daniel P. Berrangé wrote:
> > On Thu, May 07, 2026 at 12:17:32PM +0200, Philippe Mathieu-Daudé wrote:
> > > On 7/5/26 00:17, Pierrick Bouvier wrote:
> > > > Hi Peter,
> > > > 
> > > > On 5/1/2026 6:26 AM, Peter Maydell wrote:
> > > > > This is something we've discussed before. I don't think I have a very
> > > > > solid grip on it and I suspect I may be missing some parts of the
> > > > > "problem description" (i.e. what are we trying to achieve) and perhaps
> > > > > some implications of the choice. Overall it feels to me like a "no
> > > > > obviously correct answer, make a tradeoff" question. I've written this
> > > > > up to try to clarify my thinking and canvass for opinions and for
> > > > > people to point out what I'm missing.
> > > > > 
> > > > > For a long time now the arm targets have defined a "max" CPU type
> > > > > whose definition is roughly "all the features that QEMU
> > > > > implements". This is helpful for:
> > > > > 
> > > > >    - giving us a way to provide newly emulated CPU features to users
> > > > >      without having to define a specific named CPU type matching some
> > > > >      hardware that implements the feature (which might not exist at the
> > > > >      point we add the emulation, or which might also need some other
> > > > >      features we don't yet support)
> > > > >    - giving users a way to say "I just want everything"
> > > > > 
> > > > > Mostly this has worked pretty well, I think. (It can cause problems
> > > > > for some workloads that break when a new feature is added; TF-A
> > > > > firmware seems particularly prone to this.)
> > > > > 
> > > > > However, it doesn't work so well if the architecture decides to drop a
> > > > > feature and mandate that newer implementations may not implement
> > > > > it. Up til now that hasn't been a big deal, as only a few very niche
> > > > > items (like FEAT_DoubleLock, an old mechanism for quiescing external
> > > > > debug before a CPU power-down) have ever been removed.
> > > > > 
> > > > > With the Armv9.0 architecture, a big feature gets removed: support for
> > > > > running in 32-bit mode at anything above userspace (EL1, EL2, EL3) is
> > > > > not allowed to be implemented.  We've got away so far with ignoring
> > > > > that requirement, but as new v9.x features are added, they are
> > > > > designed under the assumption that there is no 32-bit system mode
> > > > > code. For instance, the GICv5 CPU interface defines only 64-bit system
> > > > > registers, and our non-compliant "32-bit is actually there"
> > > > > implementation would give you a 32-bit OS that couldn't handle
> > > > > interrupts. Other similar (or harder to spot) issues are likely to
> > > > > also turn up.
> > > > > 
> > > > > So my suggestion is that we should have two new CPU types:
> > > > > 
> > > > >    v8-max : "all the features we implement that are valid
> > > > >      for the v8.x architecture"
> > > > >    v9-max : "all the features we implement that are valid
> > > > >      for the v9.x architecture"
> > > > > 
> > > > > v9-max would not implement AArch32 EL1/2/3; v8-max wouldn't implement
> > > > > any feature the architecture says is v9-or-later.
> > > 
> > > Certainly clearer than what we currently have.
> > > 
> > > > > For the existing 'max' CPU:
> > > > >    - on qemu-system-arm this would be a synonym for v8-max
> > > > >      (since it must be 32-bit)
> > > > >    - on qemu-aarch64 and qemu-system-aarch64 this would be a synonym
> > > > >      for v9-max
> > > > >    - on qemu-arm it can also be v9-max, since v9 doesn't drop 32-bit
> > > > >      usermode support. (Though we don't currently implement qemu-arm
> > > > >      max this way, so it might end up being effectively v8-max until
> > > > >      we get round to implementing support for selecting AArch64 CPUs in
> > > > >      qemu-arm.)
> > > > > 
> > > > 
> > > > This seems like a good approach. A side effect is to solve the
> > > > duplication we encounter for the single-binary also, by correctly
> > > > deduplicating QOM types associated.
> > > > 
> > > > The concept of having a "max" alias that maps to a specific type (in
> > > > this case, distinct depending on the binary) could be used for other
> > > > arch if needed also.
> > > > 
> > > > > I don't think it's worth claiming 'max' as deprecated and dropping it:
> > > > > as an alias it's trivial to support, and there are a lot of workloads
> > > > > that won't ever notice this change.
> > > 
> > > We could display a note though.
> > > 
> > >    "Using 'v9-max' for requested 'max' CPU".
> > 
> > Please don't make use of "-cpu max" print warnings.
> > 
> > IMHO "max" should remain a first class citizen across all targets,
> > because it provides a consistent approach for users.
> > 
> > What Peter describes with resolving "max" to either "v9-max" or
> > "v8-max" depending on arm vs aarch64  makes sense to me.
> 
> Effectively postponing the problem until ARMv10 gets released
> with v10-max diverging from v9-max.
> 
> Nevermind, we'll keep handling "max" alias at the machine level.

Tieing to machine type is tricky, however, as v10-max vs v9-max
will have different "runability" depending on what the host OS
is

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


