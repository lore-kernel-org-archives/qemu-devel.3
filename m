Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82DFFEBFD30
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 10:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCEDO-0005nc-Dz; Mon, 13 Apr 2026 06:08:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCEDN-0005nN-0k
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:08:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wCEDK-0004lk-Pq
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 06:08:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776074897;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bfTHQHpUP9ySQfwMjr4iGjVYctMlmpIUy9jXtfesxt4=;
 b=hHgeVfAv/nTg+cM7KHjd/CpxmgaRzbgfziOg7mfRA7TByeA13hzecUASQL9cV0sqj07rDW
 NPc9G5D4B4sRTlDziwqCSooJHhkyhTHMiayA2P3J7rQQJ/8WjyNnZF0vq+Od1hzsgGmIxO
 69RvH0AvruVNp77Mc5UXUq1zQLyizd8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-0PAFdo-yPHe1vBQP91MQOA-1; Mon,
 13 Apr 2026 06:08:12 -0400
X-MC-Unique: 0PAFdo-yPHe1vBQP91MQOA-1
X-Mimecast-MFC-AGG-ID: 0PAFdo-yPHe1vBQP91MQOA_1776074891
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B5AB318002C0; Mon, 13 Apr 2026 10:08:10 +0000 (UTC)
Received: from redhat.com (headnet01.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.101])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D6121955D88; Mon, 13 Apr 2026 10:08:08 +0000 (UTC)
Date: Mon, 13 Apr 2026 11:08:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: Cirrus CI about to shut down
Message-ID: <adzAhSbs21GGVCUv@redhat.com>
References: <b8a73eb5-aa21-481b-9120-aa6277492b26@redhat.com>
 <CAJSP0QXJs33g1=yG9c5KSWzdsVpxmF-zSs=xQpPV-hn7rR5giQ@mail.gmail.com>
 <7d223288-dab5-48d3-940a-f4a3ac252d0c@redhat.com>
 <87qzojtbuv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87qzojtbuv.fsf@draig.linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Apr 13, 2026 at 11:04:40AM +0100, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
> > On 12/04/2026 16.28, Stefan Hajnoczi wrote:
> >> On Sun, Apr 12, 2026, 08:45 Thomas Huth <thuth@redhat.com
> >> <mailto:thuth@redhat.com>> wrote:
> >>        Hi,
> >>     according to https://cirruslabs.org/ <https://cirruslabs.org/> :
> >>        Cirrus CI will shut down effective Monday, June 1, 2026.
> >>     I guess that means we have to find an alternative for doing the
> >> builds on
> >>     macOS and FreeBSD?
> >> It may be possible to use QEMU's AWS hosting where we already run
> >> Linux x86-64 private runners. EC2 can run FreeBSD and Mac instances.
> >> Sponsorship is on an annual basis though and it would be a shame to
> >> redo the setup work once AWS sponsorship ends.
> >> If we decide to use AWS then I can help provide access.
> >
> > It seems like gitlab.com also at least features macos runners nowadays:
> >
> >  https://docs.gitlab.com/ci/runners/hosted_runners/macos/
> >
> > ... however, they are limited to Premium & Ultimate tiers, so the
> > normal developer cannot use these anymore.
> >
> > But since QEMU is part of the "GitLab for Open Source" program, maybe
> > at least the qemu-project can use these? ... It would be great if one
> > of the qemu-project Maintainers or Owners could check this! (I only
> > have the "Reporter" role in the project, so I cannot help here)
> 
> Probably - I can have a look and try it out.
> 
> Not sure what to do about FreeBSD though. Ideally we want hosted runners
> so we can exercise the hypervisor (ditto Windows x86 and Arm).

For the various BSDs we have  VMs for QEMU builds, which (in
theory) we could run from regular gitlab Linux jobs. Running them
with TCG is rather unpleasant though. Do our private upstream
runners have nested-virt available to let us use KVM ?


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


