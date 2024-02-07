Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34A3C4828D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 08:48:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdar-0006TT-5i; Wed, 07 Feb 2024 03:47:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXdap-0006So-9a
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:47:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXdam-0003Fn-6Z
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 03:47:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707295659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zEvQLM1h4MSzXSsMkzI7t4txX76UnmaBFFtX2v8zkKk=;
 b=LFazrdzuIKjSwO94QDU4bOHxA0bHrAywyfvS8WOnAtz/ZUVm7df16WFgwWc7vFJolOa78v
 V4Hrdxk+p0sBJlevBTjQAdnjYEcTYBQOULrOs1GdxVP9/TZRYijxpa+6wv9qS27Q5LaR+p
 BQPuvySbjlN3G/nJMWHWvNoPOaMOqbc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-DnxxYdiHMWioVh291YgXZw-1; Wed, 07 Feb 2024 03:47:37 -0500
X-MC-Unique: DnxxYdiHMWioVh291YgXZw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a3766d9570cso19943066b.1
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 00:47:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707295656; x=1707900456;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zEvQLM1h4MSzXSsMkzI7t4txX76UnmaBFFtX2v8zkKk=;
 b=NtEzRPvy/2utXFP5j4tpPAOwc71XG7VYAEe/P6V8qFQ2v1Mitu2XjHhPMLsuuwZA2d
 MGA0ZHPtwm2RTn4Zwjp8ZYHX62yK/fayPlxl0X8VqBPcvv88f214IBlGdGQUuNmnftCN
 hr4CG8KvFOsxYoKzjcdKkl5tIJbckmvW4WCza65yyudqWez/h/Vqs9DvM/V6I0MX8jzG
 A4c3A8JPZoITJp5ebQunmAxYx9i4qlp7lAbpN+vuvu0TorSlXyCtOP120e5FI/TO5cn/
 wpynTppZI7Tao7kiD+RGABqu9EiZC7SI6Vc/Bjpj9MX3enFmGqwyb4RQiamjtLY8Itl3
 BxZA==
X-Gm-Message-State: AOJu0YxaiCi3FHrg2nwZ6No/tJFQdPu2JZ/4lVE2d7xr0iEWJTIepBwl
 8Cv4N6RRkDR/D/KEAJM6ker/JFPzZPy0qreXfFJ4/1YQAU0COkzb30uunESHqM1oXvAiz9DTlh0
 DuKLxE68HCJ+I/sfXua23aCQQRYdnushNWrg9QDsMeR1zuI3ILDFr
X-Received: by 2002:a17:906:5ad2:b0:a38:4b66:4201 with SMTP id
 x18-20020a1709065ad200b00a384b664201mr2338901ejs.43.1707295656665; 
 Wed, 07 Feb 2024 00:47:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHGoOENiihbrqACqZ5c2nQLHKipwDQ+pRfWIwAaHXKHyfE9+R9PaBaMB1AEqP3FTTY4HFfkA==
X-Received: by 2002:a17:906:5ad2:b0:a38:4b66:4201 with SMTP id
 x18-20020a1709065ad200b00a384b664201mr2338879ejs.43.1707295656256; 
 Wed, 07 Feb 2024 00:47:36 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCX6KFpwmPzx58u4n4ZH0hp1zpNs/zUWTz5xM2x9nQHLvUgzyGVjJxntdzDe70SMuJbdVWRkfFqxmelb27AgPd3gKFUZGS9cSm7Tau38B0PEj9SAZDawrofo4BJGSAfBD+//I6OIqGvZpq8vqj5vuaEesMQFrNoo01BJf/O6/Yp/ysBGFMr8ubJvA/v8DEEYE0BTt98WrJXmQI0nH0HVY7QMsqlyCn7PJ4TDng==
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 sa5-20020a1709076d0500b00a370158ff2asm501515ejc.69.2024.02.07.00.47.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 00:47:35 -0800 (PST)
Date: Wed, 7 Feb 2024 09:47:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, 
 qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Subject: Re: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore
 VDUSE compatibility
Message-ID: <npcki5ojmtrr6znychok5l6w7zcmip347c5gd5dexlxpkac7qs@cwwyon5t4z3a>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
 <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
 <CACGkMEtODf_NGGa-XbyDMM7=z6CsCkazV9A-4z8W7oCOnu-Ybg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtODf_NGGa-XbyDMM7=z6CsCkazV9A-4z8W7oCOnu-Ybg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 07, 2024 at 11:17:34AM +0800, Jason Wang wrote:
>On Tue, Feb 6, 2024 at 4:31 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
>> >On Mon, Feb 5, 2024 at 6:51 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >>
>> >> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
>> >> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>> >> >status flag is set; with the current API of the kernel module, it is
>> >> >impossible to enable the opposite order in our block export code because
>> >> >userspace is not notified when a virtqueue is enabled.
>> >
>> >Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?
>>
>> It's not specific to virtio-blk, but to the generic vdpa device we have
>> in QEMU (i.e. vhost-vdpa-device). Yep, after commit
>> 6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after
>> DRIVER_OK.
>
>Right.
>
>>
>> >Sepc is not clear about this and that's why we introduce
>> >VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.
>>
>> Ah, I didn't know about this new feature. So after commit
>> 6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not
>> complying with the specification, right?
>
>Kind of, but as stated, it's just because spec is unclear about the
>behaviour. There's a chance that spec will explicitly support it in
>the future.
>
>>
>> >
>> >>
>> >> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
>> >
>> >I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
>> >negotiated.
>>
>> At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not
>> negotiated, should we return an error in vhost-vdpa kernel module if
>> VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?
>
>I'm not sure if this can break some setups or not. It might be better
>to leave it as is?

As I also answered in the kernel patch, IMHO we have to return an error, 
because any setups are broken anyway (see the problem we're fixing with 
this patch), so at this point it's better to return an error, so they 
don't spend time figuring out why the VDUSE device doesn't work.

>
>Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we don't know if
>parent support vq_ready after driver_ok.

So we have to assume that it doesn't support it, to be more 
conservative, right?

>With VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK, we know parent support
>vq_ready after driver_ok.
>
>>
>> >If this is truth, it seems a little more complicated, for
>> >example the get_backend_features needs to be forward to the userspace?
>>
>> I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURES
>> for this? Or do you mean userspace on the VDUSE side?
>
>Yes, since in this case the parent is in the userspace, there's no way
>for VDUSE to know if user space supports vq_ready after driver_ok or
>not.
>
>As you may have noticed, we don't have a message for vq_ready which
>implies that vq_ready after driver_ok can't be supported.

Yep, I see.

>
>>
>> >This seems suboptimal to implement this in the spec first and then we
>> >can leverage the features. Or we can have another parameter for the
>> >ioctl that creates the vduse device.
>>
>> I got a little lost, though in vhost-user, the device can always expect
>> a vring_enable/disable, so I thought it was not complicated in VDUSE.
>
>Yes, the problem is assuming we have a message for vq_ready, there
>could be  a "legacy" userspace that doesn't support that.  So in that
>case, VDUSE needs to know if the userspace parent can support that or
>not.

I think VDUSE needs to negotiate features (if it doesn't already) as 
vhost-user does with the backend. Also for new future functionality.


>
>>
>> >
>> >> I'll start another thread about that, but in the meantime I agree that
>> >> we should fix QEMU since we need to work properly with old kernels as
>> >> well.
>> >>
>> >> >
>> >> >This requirement also mathces the normal initialisation order as done by
>> >> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
>> >> >changed the order for vdpa-dev and broke access to VDUSE devices with
>> >> >this.
>> >> >
>> >> >This changes vdpa-dev to use the normal order again and use the standard
>> >> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>> >> >used with vdpa-dev again after this fix.
>> >>
>> >> I like this approach and the patch LGTM, but I'm a bit worried about
>> >> this function in hw/net/vhost_net.c:
>> >>
>> >>      int vhost_set_vring_enable(NetClientState *nc, int enable)
>> >>      {
>> >>          VHostNetState *net = get_vhost_net(nc);
>> >>          const VhostOps *vhost_ops = net->dev.vhost_ops;
>> >>
>> >>          nc->vring_enable = enable;
>> >>
>> >>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>> >>              return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>> >>          }
>> >>
>> >>          return 0;
>> >>      }
>> >>
>> >> @Eugenio, @Jason, should we change some things there if vhost-vdpa
>> >> implements the vhost_set_vring_enable callback?
>> >
>> >Eugenio may know more, I remember we need to enable cvq first for
>> >shadow virtqueue to restore some states.
>> >
>> >>
>> >> Do you remember why we didn't implement it from the beginning?
>> >
>> >It seems the vrings parameter is introduced after vhost-vdpa is
>> >implemented.
>>
>> Sorry, I mean why we didn't implement the vhost_set_vring_enable
>> callback for vhost-vdpa from the beginning.
>
>Adding Cindy who writes those codes for more thoughts.

Thanks,
Stefano


