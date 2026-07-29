Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55298C53200
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wp5ET-0006ZS-M7; Wed, 29 Jul 2026 10:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp5ES-0006YJ-4M
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wp5EP-0003I9-Er
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 10:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785335160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6QryGasT4Mo8tarHnnMetaDz53xCcR1o/CI956oni98=;
 b=UUKw9bqC6jSbBzKtgylZZKbHjHriyulD2aoQYq4uogupeT43/Q2VEDN4uMnwYyjdBbVt8T
 MmWnHjHQ/cBagbq+CZOnhVsPy2/G0LqmzcMI3Lkkpbs9ZqV61EJKfZr8lH4fKRiw7cFM+8
 DQIDn/N7gHfxLlkz7P27+8MxS8bAlqI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-sb28Y5D0OIKY8i3fpHw17w-1; Wed, 29 Jul 2026 10:25:56 -0400
X-MC-Unique: sb28Y5D0OIKY8i3fpHw17w-1
X-Mimecast-MFC-AGG-ID: sb28Y5D0OIKY8i3fpHw17w_1785335155
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-69c2f98aa9fso1179094a12.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 07:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785335155; x=1785939955; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6QryGasT4Mo8tarHnnMetaDz53xCcR1o/CI956oni98=;
 b=GawXvd1AQ2+/pNpieb/np53rN6xfsHQb+5yzsGMexR4XoqvRir7ffFl7B4+5ztde+A
 4saIJ2NW3so9iWSSqSlAR40d0gw1YFsKSsPGAForGEbw1KWS8MZBZxrFFjQwHP68Y9yP
 Xe4XWQY/GYRD1VzORsKnygZW0sTzEAydDnXYYiK+nAA/9DvzVIMXW6M7uqT8S/asScQr
 FIkbt4isi55Tpek2vqmSlkcQG22N1Z5UUfvPoDBRyD+tbsZEBHg2PJEz/XTBDVB6RAkK
 +xJFVuNjsO40YBbLif/z2DgqIXMmmB8CXV6wHBWNTvEQqkceb+CXuJpsTmhkLZQk3j3s
 bKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785335155; x=1785939955;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6QryGasT4Mo8tarHnnMetaDz53xCcR1o/CI956oni98=;
 b=LGZcTWKlcAxI5rUwfWtCYaMf0r/yZPYiXGwn4kKFgh+yqGaPSm8zkJrNmZinMv2puC
 vsjy1qU3lJw2CKvHCLFAH0LAx0oeLRYSP833ZO9Np6nZjUKXFelaAFh6JRwrq3FR24W3
 8iUL83jnl4DrVzCAr8tQYTVIWOEnMZK23sp6FCXTvi7oyeF9bk1k6pCVNXf2Tp9Wxkf/
 ebqd/G6CVEeNU5UPZAM5s0Qus6If0emBvX7ZNgYytzMtTT7GDTgq8sZe7wJ2RjTccSU7
 JKKbpB6OZC0i6O8mvShEGFO5vntrYjzrgBpPa85FmsZOw5EXvYufVikuTSa2V4JowMBj
 yrIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhcxTOjIuhJVX8d1m2ZQqSPBmST3QS/LUvWI+p2nULxfRVmRlx/bpB56pO0hfCX+ojJdVW87R03eKg@nongnu.org
X-Gm-Message-State: AOJu0YxeyOGnQ/WOgsqwx1oGmsb4smYVlIRMpVRuSBFH3MVtcR7qX1xG
 wYuxS6wQDJEzeLD8lEU8TPMWkuDd6uwU4XLE70odFmtkyoLTMhBYVgpYODd2WznL2san5a/WscD
 76WNjBQp5GtS1K9G9mWmDQ+AgF+ImaDQOAUNqd6m1ATThfT9p1BB2LSBd
X-Gm-Gg: AR+sD13PcTzhMx12L/c9uughhc9KQiZZo08BD8t46hCk71ryKVo4WDUhm5Hg8lSbszL
 Lu54vS0dJOkQi6+rXwKRrpVgZyG8em29MZEpeDSMMgZn5lKtVu0j3gqSLTwNf445TdUtC8nqgW4
 0xxWg+yexkVZW14Ql8bf3e4ALqyyWXwk6rhiwhLf2wZ/zbh/I8t6itI5FznURDkaeM0vcXUWVrt
 3Y+uLuw7ee3iejgVarhw6MxHnmguz/RlNH20fzR2O0F5FApnpg9rVtiK4kxktzcrR15zicCOC8e
 UC8EZFlp36fjinvxfVu4T+u7EIQQw0tl20LvoGQ/h0gaxdx5ub39r4CsVFfrIaDMucvP9Q==
X-Received: by 2002:a05:6402:5191:b0:6a0:d72:2e1d with SMTP id
 4fb4d7f45d1cf-6a034a8a428mr3729744a12.29.1785335155199; 
 Wed, 29 Jul 2026 07:25:55 -0700 (PDT)
X-Received: by 2002:a05:6402:5191:b0:6a0:d72:2e1d with SMTP id
 4fb4d7f45d1cf-6a034a8a428mr3729708a12.29.1785335154615; 
 Wed, 29 Jul 2026 07:25:54 -0700 (PDT)
Received: from redhat.com ([186.247.166.227]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a050ae95ffsm960852a12.0.2026.07.29.07.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:25:54 -0700 (PDT)
Date: Wed, 29 Jul 2026 10:25:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <20260729100135-mutt-send-email-mst@kernel.org>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <87jyqeomqz.fsf@suse.de> <amoHbVsgzkYclCt2@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amoHbVsgzkYclCt2@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 29, 2026 at 10:00:13AM -0400, Peter Xu wrote:
> On Tue, Jul 28, 2026 at 05:57:56PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> > > uint64_t, as vmstate core only treats the size as 32bits, and maximum
> > > INT32_MAX (see vmstate_size()).
> > >
> > > Considering that we do not need real 64bits for the size, stick with the 2G
> > > limit, converting the size field into 32bits.
> > >
> > > Since we can't touch the wire protocol on migration from an old QEMU, we
> > > can't directly modify the type of size to uint32_t.  Instead, we need to
> > > introduce a temporary variable for this extremely rare issue __size_32bits
> > > to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
> > > weird enough so people won't get confused on having two size variables.
> > >
> > > Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
> > > be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.
> > >
> > > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > > Reported-by: 김승중 <seungjung0711@gmail.com>
> > > Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Fabiano Rosas <farosas@suse.de>
> > > Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >
> > > PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> > > Please kindly try it out if possible. In general, migrations from older
> > > QEMU should work even after applied.  One can also treat this as partly-RFC
> > > from that.
> > >
> > > PS2: Michael, we have just discussed what we should define as CVE for
> > > migration, and this one shouldn't fall into CVE category, please refer to:
> > >
> > > https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
> > >
> > > So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
> > > ---
> > >  include/hw/virtio/vhost.h   |  5 +++++
> > >  include/migration/vmstate.h | 10 ----------
> > >  hw/virtio/vhost.c           | 19 ++++++++++++++-----
> > >  3 files changed, 19 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > > index 684bafcaad..1d1cc24c04 100644
> > > --- a/include/hw/virtio/vhost.h
> > > +++ b/include/hw/virtio/vhost.h
> > > @@ -17,6 +17,11 @@ struct vhost_inflight {
> > >      int fd;
> > >      void *addr;
> > >      uint64_t size;
> > > +    /*
> > > +     * This is a temporary variable only used during migration loading to
> > > +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
> > > +     */
> > > +    uint32_t __size_32bits;
> > >      uint64_t offset;
> > >      uint16_t queue_size;
> > >  };
> > > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > > index 1b7f295417..a349b2d84a 100644
> > > --- a/include/migration/vmstate.h
> > > +++ b/include/migration/vmstate.h
> > > @@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> > >      .offset       = offsetof(_state, _field),                        \
> > >  }
> > >  
> > > -#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
> > > -    .name         = (stringify(_field)),                             \
> > > -    .version_id   = (_version),                                      \
> > > -    .field_exists = (_test),                                         \
> > > -    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> > > -    .info         = &vmstate_info_buffer,                            \
> > > -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> > > -    .offset       = offsetof(_state, _field),                        \
> > > -}
> > 
> > Why don't you just leave this macro around, put a "do not use" comment
> > above it and remove the type check for this one instance? You're already
> > checking against INT32_MAX during pre_load.
> 
> What's the benefit of keeping this global macro if we only allow one user
> to use it?
> 
> Commenting to say "don't use" is not guaranteeing anything, at least we
> should also rename the macro to some weird name to make people notice.
> Keeping the macro name like this OTOH suggests abuse.  But if we think it
> should only be used in 1 place, fixing the one place might be better?
> 
> > 
> > We could even lift that check up into vmstate_pre_load and reject
> > there globally, don't even touch the virtio code.
> 
> Personally, I don't like the idea leaking VBUFFER impl details into
> vmstate_pre_load() which is so far only a wrapper, especially only for this
> one instance.. which we do not suggest future users to use.
> 
> If we go this route, I'd rather merge Michael's version to support u64,
> even if we don't need a u64 size.  But I really don't want to introduce yet
> another VMS flag just for this... we'll have no real use if we have noticed
> this problem when the vhost inflight patch was reviewed.  It will be a
> uint32_t or int32_t already.  I just can't come up with some users need
> size >2G.


It's not that size needs to be >2G. But it might be nice for some code
to keep it as u64 for its own reasons to avoid issues like overruns
during math ops.

> 
> The recent AI reports just make such feeling stronger: we just used the
> reason "max 2G, should be fine" when AI reports that unlimited size
> allocation problem, now we will need to wait for another AI report which
> says "it's not 2G anymore, 1<<64-1 that is", if we don't come up with a
> proper limit for VMSD field allocations.
> 
> > 
> > 
> > /rant
> > ... what's even the point of having per-type variants of VMSTATE macros
> > that exist just to type-check the extra offsets (.num_offset,
> > .size_offset as opposed to .offset)?
> > 
> > For instance, look at vmstate_n_elems casting opaque data to 32 and
> > sub-32bit size and assigning to an int! What do we gain from that? It's
> > circular reasoning that does nothing aside from bothering the person
> > writing the vmstate.
> > 
> > Right? Maybe I'm missing something, it's the end of the day already.
> 
> I can also only guess, which is.. I believe Michael was right, the initial
> vmstate code was simply broken where it should have considered the type of
> size fields of all kinds, but forgot, and it just worked because nobody
> needed u64 for a size field.
> 
> Said that, I still want to see if we can avoid introducing that at all.  To
> me, I still prefer this patch (after fixing pre_save()..).  But let me know
> if I didn't convince any of you.. we can discuss.
> 
> Thanks,


The issue is that 2G is not a sane limit either.

So what we really want is a macro that supplies
a size limit. That would be an improvement.

> > 
> > > -
> > >  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
> > >                                       _test, _field_size) {           \
> > >      .name         = (stringify(_field)),                             \
> > > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > > index af41841b52..e7c570d0f5 100644
> > > --- a/hw/virtio/vhost.c
> > > +++ b/hw/virtio/vhost.c
> > > @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
> > >  static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> > >  {
> > >      struct vhost_inflight *inflight = opaque;
> > > -
> > >      int fd = -1;
> > > -    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > > -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > > -                                  &fd, errp);
> > > +    void *addr;
> > > +
> > > +    if (inflight->size > INT32_MAX) {
> > > +        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
> > > +                   "migration limit '%"PRIu32"'", inflight->size, INT32_MAX);
> > > +        return false;
> > > +    }
> > > +
> > > +    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > > +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > > +                            &fd, errp);
> > >      if (!addr) {
> > >          return false;
> > >      }
> > >  
> > > +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> > > +    inflight->__size_32bits = inflight->size;
> > >      inflight->offset = 0;
> > >      inflight->addr = addr;
> > >      inflight->fd = fd;
> > > @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
> > >      .name = "vhost-inflight-region/buffer",
> > >      .pre_load_errp = vhost_inflight_buffer_pre_load,
> > >      .fields = (const VMStateField[]) {
> > > -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> > > +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
> > >          VMSTATE_END_OF_LIST()
> > >      }
> > >  };
> > 
> 
> -- 
> Peter Xu


