Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AA5C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 08:31:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXGrh-0007rU-Fo; Tue, 06 Feb 2024 03:31:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXGrU-0007fI-WD
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:31:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rXGrT-0002bq-6q
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 03:31:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707208282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/o9d28TUFO9oadJVio0nOCvoub6sEtdWA44mbSMp6k=;
 b=QCViTmNqGZYwXirnEYFq2YhUKYWpavG8LQPCAw/cdIi9UapaGDnrFE1E3lKlGy9hVcj75l
 VoQgCwVMJGhMwkTLgkl7hU8MuX3p6XbBaDX8DMq+t7wimRJUvHAk05pe1lZXeYRgK3khgF
 k0KMVHynprtmL/NNhmc/NXVma7fpeck=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-CPfFnlbuP5GiYp4FxjXnjA-1; Tue, 06 Feb 2024 03:31:21 -0500
X-MC-Unique: CPfFnlbuP5GiYp4FxjXnjA-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a382663cfa1so15670166b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 00:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707208280; x=1707813080;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q/o9d28TUFO9oadJVio0nOCvoub6sEtdWA44mbSMp6k=;
 b=qBmvG+gRDhPd+6iy2J2sR88IcGWIIPbq8+U+HN1buA1xB0t55G9ZGmIDdLbPnB81KI
 6sKqmJo1L000JwEAt2jSftklKNmnLHRpzLmVoyxeS90sO7HI3AxSBQ/5ZW8Pti4AITEC
 fWpWqdI0DNcGIKHl3xtay4yAa3wLXfNpXOcr+TGJnNl1aeY4INhyCJV5b+2qi11Oc9kn
 Q0cRTkdEfzZodebDeqn8G0f40S7J/7r+YnDEwJ/YAajvnWBR6/8y9U0ZK88tdJjimJsk
 9wowNEfFMzw/72Wrzxis3ET2mXEN8Ccjy3NVCyCeimXeS644ONP1nd9+robAHH+AKKhq
 kmqA==
X-Gm-Message-State: AOJu0Yw5zXtDsh24g4q28FoTdSEy0BzzRdSueVau3c92d2G4IcAJs57L
 6qbSFgiBMTwqQDTlWcGtn93USFeEAQo87UJZiQb8kd9GY2CBa3CSzsQCitJUrvtD2F0g6rzhk5f
 ae5fjCtfCxACsng8kLJ8sd5USlsd21X2eRRwLNirzqJso1zIQ0JLK
X-Received: by 2002:a17:906:5398:b0:a38:2664:f1d with SMTP id
 g24-20020a170906539800b00a3826640f1dmr561066ejo.57.1707208279835; 
 Tue, 06 Feb 2024 00:31:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYmPkq3n8CeGpo205SN7eZ9VH8OWoUodpY++O0VM1mf8Hm+5/zj8Wt43oYGhq3Rx3KoEU6gQ==
X-Received: by 2002:a17:906:5398:b0:a38:2664:f1d with SMTP id
 g24-20020a170906539800b00a3826640f1dmr561054ejo.57.1707208279451; 
 Tue, 06 Feb 2024 00:31:19 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX4EPl0zMAklQC4hfyG6ads7+LE6Alb/aCfoSg+wCUAOQYK2TSauhhQeMPA4tjbZdkUd0eXjNaR7d7FxDGJOQlRt4hjeQ+I4CukuH/r7ZoLisaiPlncvdUabj1fLwq94YHxvi/VEqkQ7XBk5wSR1gOMYytOygCABb+3h4dujwqQFRbwE8vygYq7h/jlNSQuQgtX6hU3NlikSbY=
Received: from sgarzare-redhat (host-87-12-25-87.business.telecomitalia.it.
 [87.12.25.87]) by smtp.gmail.com with ESMTPSA id
 h26-20020a1709062dda00b00a3683b565fbsm855718eji.187.2024.02.06.00.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 00:31:18 -0800 (PST)
Date: Tue, 6 Feb 2024 09:31:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, qemu-block@nongnu.org,
 mst@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org
Subject: Re: Re: [PATCH] vdpa-dev: Fix initialisation order to restore VDUSE
 compatibility
Message-ID: <nvk6n7ln3ryga2ww4a6evbprauptzcn7uz34ar3uecbxjfre2z@msikqqpuk2vh>
References: <20240202132521.32714-1-kwolf@redhat.com>
 <zmopxf5zt6m36nfujntn72idlinm7qmx23wjvwiazmq4b75lsa@a2omit34pjif>
 <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvLpg+nPgHsE_6stFM1OGXbHpuE=j7XLwt_YxpxhWJgZw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 06, 2024 at 10:47:40AM +0800, Jason Wang wrote:
>On Mon, Feb 5, 2024 at 6:51 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, Feb 02, 2024 at 02:25:21PM +0100, Kevin Wolf wrote:
>> >VDUSE requires that virtqueues are first enabled before the DRIVER_OK
>> >status flag is set; with the current API of the kernel module, it is
>> >impossible to enable the opposite order in our block export code because
>> >userspace is not notified when a virtqueue is enabled.
>
>Did this mean virtio-blk will enable a virtqueue after DRIVER_OK?

It's not specific to virtio-blk, but to the generic vdpa device we have 
in QEMU (i.e. vhost-vdpa-device). Yep, after commit 
6c4825476a4351530bcac17abab72295b75ffe98, virtqueues are enabled after 
DRIVER_OK.

>Sepc is not clear about this and that's why we introduce
>VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK.

Ah, I didn't know about this new feature. So after commit 
6c4825476a4351530bcac17abab72295b75ffe98 the vhost-vdpa-device is not 
complying with the specification, right?

>
>>
>> Yeah, IMHO the VDUSE protocol is missing a VDUSE_SET_VQ_READY message,
>
>I think you meant when VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is
>negotiated.

At this point yes. But if VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not 
negotiated, should we return an error in vhost-vdpa kernel module if 
VHOST_VDPA_SET_VRING_ENABLE is called when DRIVER_OK is already set?

>If this is truth, it seems a little more complicated, for
>example the get_backend_features needs to be forward to the userspace?

I'm not understanding, don't we already have VHOST_GET_BACKEND_FEATURES 
for this? Or do you mean userspace on the VDUSE side?

>This seems suboptimal to implement this in the spec first and then we
>can leverage the features. Or we can have another parameter for the
>ioctl that creates the vduse device.

I got a little lost, though in vhost-user, the device can always expect 
a vring_enable/disable, so I thought it was not complicated in VDUSE.

>
>> I'll start another thread about that, but in the meantime I agree that
>> we should fix QEMU since we need to work properly with old kernels as
>> well.
>>
>> >
>> >This requirement also mathces the normal initialisation order as done by
>> >the generic vhost code in QEMU. However, commit 6c482547 accidentally
>> >changed the order for vdpa-dev and broke access to VDUSE devices with
>> >this.
>> >
>> >This changes vdpa-dev to use the normal order again and use the standard
>> >vhost callback .vhost_set_vring_enable for this. VDUSE devices can be
>> >used with vdpa-dev again after this fix.
>>
>> I like this approach and the patch LGTM, but I'm a bit worried about
>> this function in hw/net/vhost_net.c:
>>
>>      int vhost_set_vring_enable(NetClientState *nc, int enable)
>>      {
>>          VHostNetState *net = get_vhost_net(nc);
>>          const VhostOps *vhost_ops = net->dev.vhost_ops;
>>
>>          nc->vring_enable = enable;
>>
>>          if (vhost_ops && vhost_ops->vhost_set_vring_enable) {
>>              return vhost_ops->vhost_set_vring_enable(&net->dev, enable);
>>          }
>>
>>          return 0;
>>      }
>>
>> @Eugenio, @Jason, should we change some things there if vhost-vdpa
>> implements the vhost_set_vring_enable callback?
>
>Eugenio may know more, I remember we need to enable cvq first for
>shadow virtqueue to restore some states.
>
>>
>> Do you remember why we didn't implement it from the beginning?
>
>It seems the vrings parameter is introduced after vhost-vdpa is 
>implemented.

Sorry, I mean why we didn't implement the vhost_set_vring_enable 
callback for vhost-vdpa from the beginning.

Thanks,
Stefano


