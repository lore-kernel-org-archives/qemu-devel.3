Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47272FEA835
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 09:22:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5KR5-0004iD-Td; Wed, 25 Mar 2026 05:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5KR3-0004i0-E5
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:21:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w5KR1-0004kL-OX
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 05:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774430514;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=t++57YXR3NGm7wj3FYQKvoWGtRanPM09v1KrAUcKBMI=;
 b=LKBU6xowiUM9G5M3vSrxVI1UYDSaA/MYMIJCEaYRhjt7hW0yyBtQWSzg/E4a3aWZnDRMzV
 g2AlMzdLo9BFjghlpVJzM+yvPCvUFWO4fqnOfgWRfJ7BgQP7yNwro6Eiy/1qkt8g32Jvxz
 SPzzdES3ydFpuQM5n3YpgZI12WPDKP4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-bh2yHC9rMX25ExVyu3VBDQ-1; Wed,
 25 Mar 2026 05:21:53 -0400
X-MC-Unique: bh2yHC9rMX25ExVyu3VBDQ-1
X-Mimecast-MFC-AGG-ID: bh2yHC9rMX25ExVyu3VBDQ_1774430511
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 75BED1800622; Wed, 25 Mar 2026 09:21:51 +0000 (UTC)
Received: from redhat.com (unknown [10.44.34.14])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E173419560B1; Wed, 25 Mar 2026 09:21:47 +0000 (UTC)
Date: Wed, 25 Mar 2026 09:21:44 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: Re: Cleaning up contrib/ and tools/
Message-ID: <acOpKJjdPUmtWeZd@redhat.com>
References: <CAFEAcA_5HvGriDsWnb1ALuA_dgG320eKv7yuM2kThv=rfOSZQA@mail.gmail.com>
 <ef2a0d92-c7f6-438b-a15a-2712e1c4373a@linaro.org>
 <CAFEAcA-kk29mjGWLrAGjd9AiAW64v0TvWdedZypSH0i43WgQzw@mail.gmail.com>
 <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39b64118-7faa-4308-a603-d568cc78de47@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Mar 24, 2026 at 11:44:37AM -0700, Pierrick Bouvier wrote:
> On 3/24/26 11:33 AM, Peter Maydell wrote:
> > On Tue, 24 Mar 2026 at 18:28, Pierrick Bouvier
> > > Moving those sources will break build folder hierarchy also, which is an
> > > issue for all existing binaries built from contrib anyway.
> > > I'm not sure there is anything sane to do to fix that except accepting
> > > the breaking change.
> > 
> > What are we breaking here ? Nothing outside QEMU ought to be
> > depending on the layout of our source tree. When we move things
> > around we'll update the meson.build and the documentation.
> > I don't think we have 'contrib' in our installed-locations
> > layout (tools get installed into the bin/ dir, for instance),
> > but I might have missed something.
> > 
> 
> I was thinking more about users that might have custom scripts using various
> contrib plugins, or using vhost-* binaries or ivshmem-server or elf2dmp.
> They will be relocated because meson automatically uses layout of sources in
> build folder.
> It's not a big deal anyway.

If we're concerned about external users relying on stuff in contrib/,
then that is exactly the reason why contrib/ should go, and everything
be considered an officially supported deliverable of QEMU with an
appropriate home in the source tree, and covered by 'make install'.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


