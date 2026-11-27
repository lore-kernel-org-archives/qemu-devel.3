Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25028606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=btJ2gyJi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWs8K-0006YM-01; Fri, 27 Nov 2026 04:20:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWs8E-0006Y7-S7
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:20:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xWs8B-0001UD-T1
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 04:20:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795771234;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=dUSGmyWmzpM8FwLm9wcojhOBrOPDCyz66rk8FibV0vg=;
 b=btJ2gyJigDik96u4ZU8jsv1aLBDFBYaUbUBfYACHtHYiqG9mapnv9G1NV1q4N+0YJD1ZcS
 QKy+xHhqEFNnAyt0+D8+OoBW9FCbGOQbcl2a0DvDRTbYGOllJ9cUyOhYdlwB/Me/PrLW99
 WLxN0R/kfhxSUcIBgNf2OjzLJzBItm0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-5vFrzwmoPNudg6f8G31jHw-1; Fri,
 27 Nov 2026 09:20:32 +0000
X-MC-Unique: 5vFrzwmoPNudg6f8G31jHw-1
X-Mimecast-MFC-AGG-ID: 5vFrzwmoPNudg6f8G31jHw_1795771231
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8EB4180133F; Fri, 27 Nov 2026 09:20:31 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1533C1956086; Fri, 27 Nov 2026 09:20:29 +0000 (UTC)
Date: Fri, 27 Nov 2026 09:20:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Andrija Panic <andrija.panic@gmail.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, kkostiuk@redhat.com,
 armbru@redhat.com
Subject: Re: qemu-ga: safer default command policy? (re: "Improve mechanism
 for configuring allowed commands", June 2024)
Message-ID: <awlLW-Gr30ZTIMEp@redhat.com>
References: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMvtBPPveK4wH+P9bhWtWk-i9S-xBP-nggvWppFkJ7P=++0D5g@mail.gmail.com>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 27, 2026 at 06:30:27AM +0100, Andrija Panic wrote:
> Hi Daniel, Michael, Kostiantyn, all,
> 
> I would like to revisit Daniel's series from June 2024:
> 
>   [PATCH 00/14] Improve mechanism for configuring allowed commands
>   https://patchwork.kernel.org/project/qemu-devel/cover/20240604153242.251334-1-berrange@redhat.com/
> 
> As far as I can see in the archive, it stopped after the branch
> request in July 2024, there was no v2, and current master still has
> "allow everything" as the fallback policy in ga_command_is_allowed().
> Is the idea still wanted? I would be glad to help with testing.
> 
> Why I am asking now: I work on Apache CloudStack and on VMware-to-KVM
> migration tooling. Until a few years ago qemu-ga was installed on
> relatively few guests. That is changing quickly. Management stacks
> now use it for IP reporting, boot readiness checks and quiesced
> snapshots, and migration guides tell users to install it. Many guests
> that never ran the agent are getting it now, usually from distro
> packages, with whatever the distro default is.
> 
> Those defaults differ a lot today (read from each packaging source):
> 
>   - QEMU upstream: everything allowed.
>   - Debian and Ubuntu: the unit runs plain /usr/sbin/qemu-ga and no
>     qemu-ga.conf is shipped, so everything is allowed. Debian bug
>     #1076139 (July 2024) asked for a change; it was marked wishlist,
>     with the service file taken from upstream as-is.
>   - Fedora rawhide: a block list is shipped but commented out, so
>     everything is allowed.

This is an oversight I noticed a while ago, but didn't want to
change until my new patches were merged. IMHO it should have
been following RHEL's policy all this time.

>   - openSUSE Factory: blocks guest-exec and guest-exec-status only;
>     guest-file-* stay enabled.

Pointless, as you just use guest-file-write to the qga config file
to re-enable guest-exec

>   - RHEL 9/10 and rebuilds: an --allow-rpcs list without guest-exec*
>     and guest-file-*. That list still includes guest-set-user-password
>     and guest-ssh-add-authorized-keys, i.e. the "user auth" group the
>     --no-user-auth flag was meant to cover.
> 
> So no distribution I checked blocks password and SSH-key injection,
> and only one blocks file access.
> 
> I understand the usual answer: without confidential computing the
> host can read guest RAM and disks anyway. I think that undersells two
> things:
> 
>   1. Cost and visibility. Reading secrets out of RAM or editing an
>      offline disk is deliberate, specialised work. guest-exec is one
>      JSON line, gives a root shell, and looks like routine management
>      traffic. Least privilege still matters when the attacker is a
>      stolen operator credential or a compromised management service
>      rather than a determined host admin.

Yes, I feel the same way. QGA makes it waaaaay to easy for a host
admin to compromise a guest.

>   2. Confidential guests. As Daniel's cover letter says, with SEV-SNP or
>      TDX the host is not trusted, and an agent with every command
>      enabled undoes the protection. Guest images are increasingly
>      built once and run both ways.

Any confidential guest image running the QGA today needs to have
a CVE filed against it, unless they've blocked a vast number of
APIs manually.

> Concretely:
> 
>   - Is there interest in a v2 of the series? Was there a design
>     objection, or did it run out of review time?

This is just my fault for switching priorities, but also partly
because I wasn't entirely happy with the design. I wanted to
have  it "do the right thing(tm)" out of the box when running
on a confidential VM. With my patches in v2, it required having
two separate systemd services, one confidential and one not, or
writing a bunch of preexec code to change what features were
asked for.  I was thinking about revisiting recently to try for
a v3.

>   - Would the maintainers consider changing the built-in default
>     (for example blocking the "unrestricted" and "user auth" groups
>     unless explicitly allowed), or is that seen as a distro decision?

For a confidential VM, we clearly need to strictly lock it down
out of the box, otherwise it completely undermines confidentiality.
This needs to "do the right thing", as there's way too high risk
of users or distros installing QGA in a confidental guest and not
realizing the consequences.

For non-confidential VMs, it is harder to argue what the default
behaviour is. On the one hand I think we shouldn't expose APIs to
the host admin to directly compromise a running guest. On the
other hand, any restrictions we put in place are somewhat like
snake-oil, since if they try hard enough a host admin can do
anything they like to a non-confidential guest.

On balance I feel like we shouldn't be handing over the keys on a
platter out of the box, and that we should cut out arbitrary file
read/write arbitrary exec, and password/ssh key injection by default.

> 
> I can test a v2 on Debian, Ubuntu and RHEL-family guests against
> libvirt and Apache CloudStack, and report which management features
> keep working with each group blocked. CloudStack, for example, only
> needs guest-ping, guest-sync, guest-network-get-interfaces and the
> guest-fsfreeze-* commands for its core features.



With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


