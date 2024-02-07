Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EECC4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:54:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdgS-0000bH-5u; Wed, 07 Feb 2024 03:53:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXdgN-0000aT-Nj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:53:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXdgL-000447-UN
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:53:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707296004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hroAqgfaG7sf6mzX2d4PZoHSpHaHy608KvZiOeGVQbg=;
 b=Rrm9VE/s2jQV0jhPZs09oTmfUM+rGz/u6ppsh7P8psz6cMlj/rqZzoUUNEwXgenGTa7JWz
 DPDYIoRAjJlIrTU/MOOxjdh2+niPbTSFeh4cTE7PnP/18BtZVYKH8f/qkB50nI0enGzcWF
 Yt38QRYG+T73AuRkxktVcNUvWPC9eSs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-_zbN5sl5NoKf9NtdHK4MSQ-1; Wed, 07 Feb 2024 03:53:23 -0500
X-MC-Unique: _zbN5sl5NoKf9NtdHK4MSQ-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2d0c3f8d557so3214721fa.3
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:53:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707296001; x=1707900801;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hroAqgfaG7sf6mzX2d4PZoHSpHaHy608KvZiOeGVQbg=;
 b=gl7Z78cEImSJfvyQjwjUjyjkO1NgBA9BHJPXSBYi9oLppb5ca43/omy0oZXcxA3Mws
 CXWzzvG6tYJGXWo9Awazw/v3NixjkiLroc9h7wxgRrEOFXNcwgQmbAIqrKvjgiBJ+vlR
 MQ0wOH5qcEXDR+1VYpRilZiZaxKfEhNuZcYacNsqZk2Vnd3k29gfhpbUDR6jTvPzFI79
 GGfka2T/g60RcmPrAptvUXtTIpFLQYr5uLFAT+YJPZlZXOjxhb09MS0g+bqVIaddMJhs
 LLP/bBqHXkeykLOgBbzv+Gc+AM4WNDJFyaxuthCKXHoWBDhR78GjWjXtc0IfABUTtNYe
 +ptQ==
X-Gm-Message-State: AOJu0YwTE4IeQJMQVz0P1fvJ09sfvZKNjZ/+QP4pjgDhgIAKq8LHMBWK
 gPVgFr8KcQ8kkeLDfKhBLOypYXBdAqPQoyVItGc37ZdwQJxMe6oGdwyC0179/ibXcGaIEqRwXFw
 sJWb8L3+tNx4U2f+ID05zoSkCNqoSnZZ4xTuVqNIFri61qNr7TJK/
X-Received: by 2002:a2e:8ed8:0:b0:2d0:b663:5093 with SMTP id
 e24-20020a2e8ed8000000b002d0b6635093mr3774324ljl.23.1707296001418; 
 Wed, 07 Feb 2024 00:53:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGhbydCLd+2TP7kmJdFl41lbp1VrmfhEL+Q/Gkn6fwnyMeJuTaIi12IkAfKJ4jNZmLTfUexuw==
X-Received: by 2002:a2e:8ed8:0:b0:2d0:b663:5093 with SMTP id
 e24-20020a2e8ed8000000b002d0b6635093mr3774308ljl.23.1707296001057; 
 Wed, 07 Feb 2024 00:53:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVGeqZ/jHgh3t/ccBMN9MCJpjePVSxkTkqE0K4RsZVoTuGUFC35EwqfUMvY+vLNZ37HR7cGeGbHWiTb89Fph8rWPhizUM5qAso8j1h9U2tRVJOrLTKokVzuPUwB1fBU5TCgroJMXe+vvIGPQuoWhfdQzXm5C+yN/fwEBKyRHStOKQirtzStKXBo934/roNKbCHq60OPOEZQHz3wRAX+bryaAPc664yGnABSVz0=
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 d23-20020aa7c1d7000000b0056022d78141sm442980edp.56.2024.02.07.00.53.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 00:53:20 -0800 (PST)
Date: Wed, 7 Feb 2024 09:53:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <xlk2pspyo4gwguxopm6k534nzjei5y3m6zbh2l6dagmuwpamtk@dtkgca6yppce>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
 <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
 <CACGkMEtODf_NGGa-XbyDMM7=z6CsCkazV9A-4z8W7oCOnu-Ybg@mail.gmail.com>
 <CACLfguUmPpnjTgLcATFHjMDDT_FbNZM4uHc8mLp5CpofC6nECQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACLfguUmPpnjTgLcATFHjMDDT_FbNZM4uHc8mLp5CpofC6nECQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 07, 2024 at 04:05:29PM +0800, Cindy Lu wrote:
>Jason Wang <jasowang@redhat.com> 于2024年2月7日周三 11:17写道：
>>
>> On Tue, Feb 6, 2024 at 4:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
>> > >On Mon, Feb 5, 2024 at 6:51 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >>
>> > >> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
>> > >> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>> > >> >status flag is set; with the current API of the kernel module, it is
>> > >> >impossible to enable the opposite order in our block export code because
>> > >> >userspace is not notified when a virtqueue is enabled.
>> > >
>> > >Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?
>> >
>> > It's not specific to virtio-blk, but to the generic vdpa device we have
>> > in QEMU (i.e. vhost-vdpa-device). Yep, after commit
>> > 6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after
>> > DRIVER_OK.
>>
>> Right.
>>
>> >
>> > >Sepc is not clear about this and that's why we introduce
>> > >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
>> >
>> > Ah, I didn't know about this new feature. So after commit
>> > 6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not
>> > complying with the specification, right?
>>
>> Kind of, but as stated, it's just because spec is unclear about the
>> behaviour. There's a chance that spec will explicitly support it in
>> the future.
>>
>> >
>> > >
>> > >>
>> > >> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
>> > >
>> > >I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
>> > >negotiated.
>> >
>> > At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not
>> > negotiated, should we return an error in vhost-vdpa kernel module if
>> > VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?
>>
>> I'm not sure if this can break some setups or not. It might be better
>> to leave it as is?
>>
>> Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't know if
>> parent support vq_ready after driver_ok.
>> With VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we know parent support
>> vq_ready after driver_ok.
>>
>> >
>> > >If this is truth, it seems a little more complicated, for
>> > >example the get_backend_features needs to be forward to the userspace?
>> >
>> > I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURES
>> > for this? Or do you mean userspace on the VDUSE side?
>>
>> Yes, since in this case the parent is in the userspace, there's no way
>> for VDUSE to know if user space supports vq_ready after driver_ok or
>> not.
>>
>> As you may have noticed, we don't have a message for vq_ready which
>> implies that vq_ready after driver_ok can't be supported.
>>
>> >
>> > >This seems suboptimal to implement this in the spec first and then we
>> > >can leverage the features. Or we can have another parameter for the
>> > >ioctl that creates the vduse device.
>> >
>> > I got a little lost, though in vhost-user, the device can always expect
>> > a vring_enable/disable, so I thought it was not complicated in VDUSE.
>>
>> Yes, the problem is assuming we have a message for vq_ready, there
>> could be  a "legacy" userspace that doesn't support that.  So in that
>> case, VDUSE needs to know if the userspace parent can support that or
>> not.
>>
>> >
>> > >
>> > >> I'll start another thread about that, but in the meantime I agree that
>> > >> we should fix QEMU since we need to work properly with old kernels as
>> > >> well.
>> > >>
>> > >> >
>> > >> >This requirement also mathces the normal initialisation order as done by
>> > >> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
>> > >> >changed the order for vdpa-dev and broke access to VDUSE devices with
>> > >> >this.
>> > >> >
>> > >> >This changes vdpa-dev to use the normal order again and use the standard
>> > >> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>> > >> >used with vdpa-dev again after this fix.
>> > >>
>> > >> I like this approach and the patch LGTM, but I'm a bit worried about
>> > >> this function in hw/net/vhost_net.c:
>> > >>
>> > >>      int vhost_set_vring_enable(NetClientState *nc, int enable)
>> > >>      {
>> > >>          VHostNetState *net = get_vhost_net(nc);
>> > >>          const VhostOps *vhost_ops = net->dev.vhost_ops;
>> > >>
>> > >>          nc->vring_enable = enable;
>> > >>
>> > >>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>> > >>              return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>> > >>          }
>> > >>
>> > >>          return 0;
>> > >>      }
>> > >>
>> > >> @Eugenio, @Jason, should we change some things there if vhost-vdpa
>> > >> implements the vhost_set_vring_enable callback?
>> > >
>> > >Eugenio may know more, I remember we need to enable cvq first for
>> > >shadow virtqueue to restore some states.
>> > >
>> > >>
>> > >> Do you remember why we didn't implement it from the beginning?
>> > >
>> > >It seems the vrings parameter is introduced after vhost-vdpa is
>> > >implemented.
>> >
>> > Sorry, I mean why we didn't implement the vhost_set_vring_enable
>> > callback for vhost-vdpa from the beginning.
>>
>> Adding Cindy who writes those codes for more thoughts.
>>
>it's a really long time ago, and I can't remember it clearly. It seems
>like there might be an issue with the sequence being called for
>dev_start and vhost_set_vring_enable?
>I have searched my mail but find nothing. I think we should do a full
>test if we want to this

IMHO in hw/net/vhost_net.c we should check the type of backend (e.g. 
vhost-vdpa) to decide whether to call 
vhost_ops->vhost_set_vring_enable() or not, instead of just checking 
whether the callback is implemented or not, because in the future we 
might have other backends (e.g. a native vdpa-blk driver) that might 
want that callback implemented.

Something like this (untested):

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index e8e1661646..1fea678e29 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -543,7 +543,8 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)

      nc->vring_enable = enable;

-    if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
+    if (nc->info->type != NET_CLIENT_DRIVER_VHOST_VDPA &&
+            vhost_ops && vhost_ops->vhost_set_vring_enable) {
          return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
      }

WDYT?

Thanks,
Stefano


