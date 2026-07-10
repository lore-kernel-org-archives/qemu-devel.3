Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543E0C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi9mr-0007Hi-KF; Fri, 10 Jul 2026 07:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi9mq-0007Ha-Nm
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wi9mo-0001lL-Fn
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783684372;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LEa01INMihHi059pGwxFYkZWJiK7YNE/HE+jsCKqSto=;
 b=Xeubw7UzFLXjyHRs0Cc3dXZGBq3mJJ+vwFeK6iNZsahCChkN6MqQHZ0onXp85Af+PnegEx
 a3YdRL2iUXQEflk1+IbzYntkjRDdgtTBmBIKg+DlLDv+CweqwCyPtRLQSkEGG1llRHwzvQ
 dAt3n8lQi6YHFamJGudLZjreOr/N/bo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-453-U9kXZRDLM1uGgSWLulc7SA-1; Fri,
 10 Jul 2026 07:52:49 -0400
X-MC-Unique: U9kXZRDLM1uGgSWLulc7SA-1
X-Mimecast-MFC-AGG-ID: U9kXZRDLM1uGgSWLulc7SA_1783684368
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1302A19560B9; Fri, 10 Jul 2026 11:52:48 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B6631180058D; Fri, 10 Jul 2026 11:52:45 +0000 (UTC)
Date: Fri, 10 Jul 2026 12:52:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
Message-ID: <alDdCh7zfJvdD0tn@redhat.com>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_IsMGkkMY8wERc@redhat.com>
 <947a4843-34ae-43f7-8fbc-80109bc0c077@oss.qualcomm.com>
 <alCoHiXzBAcwnOxJ@redhat.com> <87ldbjqd67.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ldbjqd67.fsf@draig.linaro.org>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jul 10, 2026 at 12:47:28PM +0100, Alex Bennée wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> (added Edgar for Microblaze)
> 
> > On Thu, Jul 09, 2026 at 09:24:12AM -0700, Pierrick Bouvier wrote:
> >> On 7/9/2026 9:13 AM, Daniel P. Berrangé wrote:
> >> > On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
> >> >> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
> >> >>> When a developer's environment is already within a podman container it
> >> >>> is not possible to use 'podman' again to create containers. It will
> >> >>> usually result in wierd errors such as:
> >> >>>
> >> >>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
> >> >>>
> >> >>> Podman offers the ability to talk to a daemon outside the container,
> >> >>> however, which could be leveraged by QEMU.
> >> >>>
> <snip>
> >> >> Taking a look at why tcg tests are slow to compile, I reached this
> >> >> commit. It seems like that calling 'podman info' is 5 to 10 times slower
> >> >> than calling 'podman version'.
> >> >> Thus, a container run now takes +1s when it was 0.2 before.
> >> > 
> >> > Hmmm, but we call 'docker.py probe' in configure and cache the result,
> >> > so that probe should only be done once.  0.2 vs 1s is just noise in
> >> > the context of configure.
> >> > 
> >> > That you're seeing any negative effects suggests that we've got
> >> > something not using the cached probe result, which we should fix.
> >> >
> >> 
> >> Not really, docker.py --engine X still calls X info.
> >> 
> >> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L675
> >> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L78
> >> 
> >> Maybe the fix is to remove the check if user specified an explicit
> >> engine. But in this case, there is a problem with podman-remote not
> >> being detected anymore.
> >> 
> >> We can fix this by introducing engine=podman-remote, and skip the check
> >> if engine is explicitly set.
> >> What do you think?
> >
> > Urgh, so i see now we have two code paths / make variables
> >
> >   RUNC=podman --remote
> >   CONTAINER_ENGINE=auto
> >
> > Sometimes we'll invoke docker.py --engine $(CONTAINER_ENGINE)
> > and sometimes we'll directly invoke $(RUNC).
> 
> Yeah that could do with cleaning up. I suspect the only places we
> actually still need the script is where we are doing binfmt_misc enabled
> containers unless there is a way to emulate the copying of qemu into the
> container with a plain call? Maybe all the systems now have the
> persistent flags which would skip this.

Yeah, I'd be inclined to say this is a job for the distros to have
qemu-user integration, and simplify our life. THe docker.py script
always confuses me.  We could choose podman vs podman --remote vs
docker simply in the meson.build file, as we do for other dev env
choices.

> The toolchain case could be skipped if we could find hosted compilers
> for microblaze. However I do see we have a patch in there.
> 
> >
> > The result of "probe" cannot be fed back in to "--engine" which
> > is a bit of a mess. I think the "engine" concept should not be
> > exposed on the cli, and instead have a "--runc" arg which takes
> > the full arg(s), since we need probe to report the runc args
> > for other reasons.
> >
> > With regards,
> > Daniel
> 
> -- 
> Alex Bennée
> Virtualisation Tech Lead @ Linaro
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


