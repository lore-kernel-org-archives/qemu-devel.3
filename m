Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18C05FEC0E1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 17:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w55by-0001sZ-O1; Tue, 24 Mar 2026 13:32:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w55bW-0001p5-Ez
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:31:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w55bT-00071z-Su
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 13:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774373502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=RoB/uuLiTjhAzjCcEzUUQx4HxuGNwGYCT5cS/EFgH34=;
 b=K081LtNds58ENf94+rwT8L+heUpNp6Ftx9v8skDj6mQ6h3LAoB6f6a8W/8HMvbP8lLwJjY
 bAipl/qGNjQy0dlNlgizxHZaaSG51jZwm+s4VYqppeLoSFo9NdpQx19uViLducF+vy+W2P
 p0gtHawz0vcvn68DPlVJhMRkW6RorHk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-PxiEX-UTM367cPx0Z391qw-1; Tue,
 24 Mar 2026 13:31:38 -0400
X-MC-Unique: PxiEX-UTM367cPx0Z391qw-1
X-Mimecast-MFC-AGG-ID: PxiEX-UTM367cPx0Z391qw_1774373497
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8CA2F19560A1; Tue, 24 Mar 2026 17:31:37 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.93])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 232951800107; Tue, 24 Mar 2026 17:31:33 +0000 (UTC)
Date: Tue, 24 Mar 2026 17:31:30 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
Message-ID: <acLKch9REjQ94Y1d@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, Mar 24, 2026 at 05:09:33PM +0000, Peter Maydell wrote:
> So, starting with tools/:
> 
>  * tools/ebpf/ is the source for the pre-generated
>    ebpf/rss.bpf.skeleton.h ; it should move to ebpf/
>  * tools/i386/qemu-vmsr-helper.c is the source for the
>    qemu-vmsr-helper tool; it can stay (should it lose its
>    i386/ subdir ?)

Given it is a single source file and we don't have a big
collection of other i386-only tools, I think we loose
nothing by removing the extra i386 subdir.

>  * the tools which currently are in the top level directory
>    should move into tools/:
>     - qemu-bridge-helper.c
>     - qemu-edid.c
>     - qemu-img.c
>     - qemu-io.c
>     - qemu-keymap.c
>     - qemu-nbd.c

ack

> And for contrib/, easy ones first:
>  * contrib/vhost-user-{blk,bridge,gpu,input,scsi} move to tools/
>  * contrib/elf2dmp moves to tools/
>  * contrib/ivshmem-client and contrib/ivshmem-server move to tools/
>  * contrib/plugins moves to plugins/plugins (or a different subdir
>    name of your choice)

plugins/demos or plugins/examples or are they more formal than
demo-ware ?

> For contrib/, ones I'm less sure about:
> 
>  * contrib/vmapple/uuid.sh is a one-liner; we should either commit to
>    having this, by giving it a better name and documentation and
>    installing it in 'make install', or else junk it and have
>    docs/system/arm/vmapple.rst give you the plutil command and tell
>    you to run it directly.

Earlier versions of the vmapple patch series had the command
listed in the rst docs, but it was then pulled out into the
script to make it easier for users.

Rename to qemu-vmapple-extract-uuid  or something less verbose ?

>  * contrib/gitdm moves to scripts/ ? It's just config data for
>    generating statistics about patches, so with other
>    developer-related stuff makes sense.

Yes, scripts seems reasonable for that.

>  * contrib/systemd -- we don't do anything with these (e.g.
>    'make install' ignores them), so I am sceptical about their
>    usefulness. We could drop them, or move them to scripts/, or put
>    them in tools/ and qga/ with the tools that they are systemd
>    scripts for.

I think they should probably move to the respective dir
that contains the tool source, and be installed.

The qga one differs from what Fedora ships, but by adding
them as installed files, we likely motivate someone to
care more about what they contain.

> (scripts/ is also in danger of being "miscellaneous dumping
> ground", of course. I have tried not to suggest it as the
> destination when I could think of an alternative.)

One problem at a time :-) Unlike contrib/, scripts/ is not end-user
facing it is just a grab bag of tools targetted at QEMU contributors
or the build system. So those only need to stay working & supported
to the extent that we're using them ourselves.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


