Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 11:27:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfI5H-0005qv-5c; Wed, 28 Feb 2024 06:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfI5F-0005qc-Ag
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rfI59-00014E-PV
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 06:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709119598;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2boBlAIdQGW99B9NyppKH+iB948ITS1Bah1dSbUTotw=;
 b=Hx/Oj4i04vQMDDbRulqK+xpkF/I6w1NxPLKoGq3/pdNnmG1fmntk/2Bf8Bonmcoj9XubYF
 6C1uSA5lng7xbb0kFj+f0S+izCepB49yZ7QKO71fhwrfEXNfamHLQ4MTHNvlRgclq/Jwtv
 n2w2mztygjPKfXTXvrnV1cQks/icqQU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-qJ6AnODiNmSiruokNLt6Qw-1; Wed, 28 Feb 2024 06:26:37 -0500
X-MC-Unique: qJ6AnODiNmSiruokNLt6Qw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1BB585A58B;
 Wed, 28 Feb 2024 11:26:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 931B6492BC7;
 Wed, 28 Feb 2024 11:26:35 +0000 (UTC)
Date: Wed, 28 Feb 2024 11:26:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
 Yong Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qapi: Craft the BlockdevCreateOptionsLUKS comment
Message-ID: <Zd8YaQ28Fu_JqPYW@redhat.com>
References: <91c52e03e46ff0a96559b4e7d66ded582b2ec4e1.1708486450.git.yong.huang@smartx.com>
 <874je22u83.fsf@pond.sub.org>
 <CAK9dgmZkLZiT_W0UjB+=EN9_vAK5Qy5XKRMBhHBQ98sRBbiAQw@mail.gmail.com>
 <875xyiz0ho.fsf@pond.sub.org>
 <CAK9dgmZOEqd=EgBjsiZZoK3R+VQRMqSdUrK_WwKHfP7LiWzQMQ@mail.gmail.com>
 <87v8693x7c.fsf@pond.sub.org> <Zd8IQShNrGeXEnLz@redhat.com>
 <Zd8JhTXhT8HvS55A@redhat.com> <Zd8XHph05UnZWliz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd8XHph05UnZWliz@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 28, 2024 at 12:21:02PM +0100, Kevin Wolf wrote:
> Am 28.02.2024 um 11:23 hat Daniel P. Berrangé geschrieben:
> > On Wed, Feb 28, 2024 at 11:17:37AM +0100, Kevin Wolf wrote:
> > > Am 28.02.2024 um 07:43 hat Markus Armbruster geschrieben:
> > > > Yong Huang <yong.huang@smartx.com> writes:
> > > > 
> > > > > On Wed, Feb 21, 2024 at 4:26 PM Markus Armbruster <armbru@redhat.com> wrote:
> > > > >
> > > > >> Yong Huang <yong.huang@smartx.com> writes:
> > > > >>
> > > > >> > On Wed, Feb 21, 2024 at 2:43 PM Markus Armbruster <armbru@redhat.com>
> > > > >> wrote:
> > > > >> >
> > > > >> >> Hyman Huang <yong.huang@smartx.com> writes:
> > > > >> >>
> > > > >> >> > Add comment in detail for commit 433957bb7f (qapi:
> > > > >> >> > Make parameter 'file' optional for
> > > > >> >> > BlockdevCreateOptionsLUKS).
> > > > >> >> >
> > > > >> >> > Signed-off-by: Hyman Huang <yong.huang@smartx.com>
> > > > >> >> > ---
> > > > >> >> >  qapi/block-core.json | 20 +++++++++++++++++++-
> > > > >> >> >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > >> >> >
> > > > >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > > > >> >> > index ab5a93a966..42b0840d43 100644
> > > > >> >> > --- a/qapi/block-core.json
> > > > >> >> > +++ b/qapi/block-core.json
> > > > >> >> > @@ -4973,7 +4973,25 @@
> > > > >> >> >  ##
> > > > >> >> >  # @BlockdevCreateOptionsLUKS:
> > > > >> >> >  #
> > > > >> >> > -# Driver specific image creation options for LUKS.
> > > > >> >> > +# Driver specific image creation options for LUKS. Note that
> > > > >> >> > +# @file is required if @preallocation is specified and equals
> > > > >> >> > +# PREALLOC_MODE_ON. The following three scenarios determine how
> > > > >> >> > +# creation logic behaves when @preallocation is either equal to
> > > > >> >> > +# PREALLOC_MODE_OFF or is not given:
> > > > >> >> > +#
> > > > >> >> > +#  1) When @file is given only, format the block device referenced
> > > > >> >> > +#     by @file as the LUKS specification and trunk it to the @size.
> > > > >> >>
> > > > >> >> Do you mean "truncate it to @size"?
> > > > >> >>
> > > > >> > Yes, :( sorry for the spelling mistake.
> > > > >>
> > > > >> Writing good documentation in a second language is *hard*.  All we can
> > > > >> reasonably expect from contributors to try their best.  And then we
> > > > >> improve the text together in review.  Just like we do for code :)
> > > > >>
> > > > >> >> > +#     In this case, the @size should reflect amount of space made
> > > > >> >> > +#     available to the guest, so the trunk size must take account
> > > > >> >> > +#     of that which will be used by the crypto header.
> > > > >> >> > +#
> > > > >> >> > +#  2) When @header is given only, just format the block device
> > > > >> >> > +#     referenced by @header as the LUKS specification.
> > > > >> >> > +#
> > > > >> >> > +#  3) When both @file and @header are given, block device
> > > > >> >> > +#     referenced by @file should be trunked to @size, and block
> > > > >> >> > +#     device referenced by @header should be formatted as the LUKS
> > > > >> >> > +#     specification.
> > > > >> >> >  #
> > > > >> >> >  # @file: Node to create the image format on, mandatory except when
> > > > >> >> >  #        'preallocation' is not requested
> > > > >> >>
> > > > >> >> Let's see whether I understand.
> > > > >> >>
> > > > >> >> blockdev-create with "driver": "luks" can work in three different ways:
> > > > >> >>
> > > > >> >> 1. Create an image with a LUKS header
> > > > >> >>
> > > > >> >> 2. Create just a detached LUKS header
> > > > >> >>
> > > > >> >> 3. Create an image and a detached LUKS header
> > > > >> >>
> > > > >> >> Correct?
> > > > >> >>
> > > > >> >
> > > > >> > Yes
> > > > >> >
> > > > >> >
> > > > >> >> @file and @header are BlockdevRef, which means they refer to existing
> > > > >> >> images with arbitrary driver.  Could be "file", "qcow2", or anything.
> > > > >> >>
> > > > >> >> Correct?
> > > > >> >>
> > > > >> > Yes
> > > > >> >
> > > > >> >
> > > > >> >>
> > > > >> >> To get 1., specify @file, but not @header.
> > > > >> >>
> > > > >> >> To get 2., specify @header, but not @file.
> > > > >> >>
> > > > >> >> To get 3., specify both.
> > > > >> >>
> > > > >> >> Specifying neither is an error.
> > > > >> >>
> > > > >> >> Correct?
> > > > >> >>
> > > > >> >
> > > > >> > Yes
> > > > >> >
> > > > >> >
> > > > >> >> In any case, @size is the logical size of the image (how much data it
> > > > >> >> can hold).
> > > > >> >>
> > > > >> >
> > > > >> > Yes
> > > > >> >
> > > > >> >
> > > > >> >>
> > > > >> >> With 1., the actual image size is a bit larger due to the LUKS header.
> > > > >> >> The @file image is resized to that size: if it's shorter, it's grown, if
> > > > >> >> it's longer, it's truncated.
> > > > >> >>
> > > > >> >
> > > > >> > Yes
> > > > >> >
> > > > >> >
> > > > >> >> With 2., @size is merely recorded in the detached LUKS header.
> > > > >> >>
> > > > >> >
> > > > >> > In LUKS1 specification, payload data size is not contained in the header,
> > > > >> > so in this case, @size is not recorded in the detached LUKS header.
> > > > >> > The creation logic just does the LUKS header formatting only.
> > > > >>
> > > > >> Is @size unused then?
> > > > >>
> > > > >
> > > > > IIUC, yes. Creation logic will ignore the @size. See the following code
> > > > > in function block_crypto_co_create_luks:
> > > > >
> > > > >     if (luks_opts->header) {
> > > > >         /* LUKS volume with detached header */
> > > > >         hdr_bs = bdrv_co_open_blockdev_ref(luks_opts->header, errp);
> > > > >         if (hdr_bs == NULL) {
> > > > >             return -EIO;
> > > > >         }
> > > > >
> > > > >         cflags |= QCRYPTO_BLOCK_CREATE_DETACHED;
> > > > >
> > > > >         /* Format the LUKS header node, here just ignore the size
> > > > >           * and passed zero to block_crypto_co_create_generic */
> > > > >         ret = block_crypto_co_create_generic(hdr_bs, 0, &create_opts,
> > > > >                                              PREALLOC_MODE_OFF, cflags, errp);
> > > > >         if (ret < 0) {
> > > > >             goto fail;
> > > > >         }
> > > > >
> > > > >         /* Format the LUKS payload node */
> > > > >         if (luks_opts->file) {
> > > > >             ret = block_crypto_co_format_luks_payload(luks_opts, errp);
> > > > >             if (ret < 0) {
> > > > >                 goto fail;
> > > > >             }
> > > > >         }
> > > > 
> > > > @size is a required argument, but silently ignored when @header is
> > > > present and @file is absent (2. Create just a detached LUKS header).
> > > > Feels awkward.
> > > > 
> > > > Should @size be optional, absent when and only when @header is present
> > > > and @file is absent?
> > > > 
> > > > Kevin or Hanna, got an opinion?
> > > 
> > > What is the use case for creating a header without a corresponding
> > > image?
> > 
> > eg you're creating a detached LUKS header that will be used in
> > combination with a block device, or an NBD export, or some other
> > storage that was pre-created in some manner, and onto which you
> > now want to store LUKS encrypted data.
> 
> Why don't you pass a host_device/nbd/... node as @file then?

It is possible of course, but it serves no functional purpose. The
act of formatting the LUKS volume would never touch that data payload
storage, unless preallocation is requested. IOW, aside from QEMU
opening the @file (which proves it exists) it would be ignored.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


