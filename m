Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760ADC54E66
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 08:24:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl2qs-0007mc-Hx; Fri, 15 Mar 2024 04:23:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rl2qr-0007mS-1L
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:23:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1rl2qp-0007bi-0J
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 04:23:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710491017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vuB9NBn86L2nk0F5dZpYQULwcDYPqeXwIkteN9QKYfU=;
 b=TLVafg3Eu+cSp8T7AuRs5vwAmIotrU83U7N0SiBA4iEVdcMECkeDqR8E63nlYuRHzHhkkP
 Q1jZPZ6bo+Qd0/P0GiqH2Wx08mRt/2oPsqW5V2ekylCxbF5UlmtBgRONxLFGlVEOSSE9tb
 KJsIz0elzSBNO7KsecvzqJ01DGqWkLs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gHBZwlTZM9uquBH7ellIRw-1; Fri, 15 Mar 2024 04:23:35 -0400
X-MC-Unique: gHBZwlTZM9uquBH7ellIRw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ecf15c037so526681f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 01:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710491014; x=1711095814;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vuB9NBn86L2nk0F5dZpYQULwcDYPqeXwIkteN9QKYfU=;
 b=wtTkWM6yFS4q2Vx37B25XzprviHZsKVMsY20Q7mfKhUvINBJLzXZTJcIWnwUzFaCQf
 drWUgoJHiEh69MF24ENcpYecEBZ4BoF1jmcpNCK9YO+GpQMc0hWY6xZfy8wqfrUU1lBi
 bCCCrmhNHdDwmoXF8/02pFwRJqRiQq1iwNUtKcH7EZMlCUsHTEkyoPzzg9zQgaTc7uKx
 4BW/vbbY5oCx33JQ6UbLNZ+ZjYedrQtaTY6xvFf2U47artd9YDYteUZq+6qT2mL8WAh+
 QsczXelfPxFVo41/VST//VFQRNE+HfwjSHMpRw+0irXEmQLah1+rD/6/BSLi9Aaq4XzM
 AaTg==
X-Gm-Message-State: AOJu0YyJWomAGFOtQBkmbARpdJKz+b0WX2XH6lfIktdsSgu+75U2hkn/
 lN5tfhaajv+9KqJKkDQyd5BoNt0t4ZBpDSJlxWc9oLuBF+PIyFP81cxPDYd/Sq3ACucDszX5Yge
 ClRm5RhfwAVsI/ipicpLVb1yefPJmyDSlqvSU6h/EOYsPBtJUA6Yn
X-Received: by 2002:adf:e64c:0:b0:33e:cf4d:c583 with SMTP id
 b12-20020adfe64c000000b0033ecf4dc583mr1615553wrn.16.1710491013861; 
 Fri, 15 Mar 2024 01:23:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzJ8cB51EeoIT58TqXj3PUhRHl/f3a6su1dMqiPPNFScx0BvPHkTPhvu7zSrY/N6WqUWXVqA==
X-Received: by 2002:adf:e64c:0:b0:33e:cf4d:c583 with SMTP id
 b12-20020adfe64c000000b0033ecf4dc583mr1615535wrn.16.1710491013405; 
 Fri, 15 Mar 2024 01:23:33 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it.
 [87.12.25.33]) by smtp.gmail.com with ESMTPSA id
 m14-20020adfe94e000000b0033cf60e268fsm2583145wrn.116.2024.03.15.01.23.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 01:23:32 -0700 (PDT)
Date: Fri, 15 Mar 2024 09:23:28 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, lulu@redhat.com, 
 kwolf@redhat.com, eperezma@redhat.com
Subject: Re: [PATCH] vhost-vdpa: check vhost_vdpa_set_vring_ready() return
 value
Message-ID: <uufps7n6otfwygiszepy76ltohvsqqo45rwyc6axja3isebda2@mn4rjbji66qt>
References: <20240207092702.25242-1-sgarzare@redhat.com>
 <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvRizRGOjOz_AVQw8wsGU3g8+-yHtnKM=yn=3RtY-Hayg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Mar 14, 2024 at 11:17:01AM +0800, Jason Wang wrote:
>On Wed, Feb 7, 2024 at 5:27 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> vhost_vdpa_set_vring_ready() could already fail, but if Linux's
>> patch [1] will be merged, it may fail with more chance if
>> userspace does not activate virtqueues before DRIVER_OK when
>> VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated.
>
>I wonder what happens if we just leave it as is.

Are you referring to this patch or the kernel patch?

Here I'm just checking the return value of vhost_vdpa_set_vring_ready().
It can return an error also without that kernel patch, so IMHO is
better to check the return value here in QEMU.

What issue do you see with this patch applied?

>
>VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We do know enabling could be
>done after driver_ok.
>Without VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK: We don't know whether
>enabling could be done after driver_ok or not.

I see your point, indeed I didn't send a v2 of that patch.
Maybe we should document that, because it could be interpreted that if
VHOST_BACKEND_F_ENABLE_AFTER_DRIVER_OK is not negotiated the enabling
should always be done before driver_ok (which is true for example in
VDUSE).

BTW I think we should discuss it in the kernel patch.

Thanks,
Stefano

>
>Thanks
>
>>
>> So better check its return value anyway.
>>
>> [1] https://lore.kernel.org/virtualization/20240206145154.118044-1-sgarzare@redhat.com/T/#u
>>
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>> Note: This patch conflicts with [2], but the resolution is simple,
>> so for now I sent a patch for the current master, but I'll rebase
>> this patch if we merge the other one first.
>>
>> [2] 
>> https://lore.kernel.org/qemu-devel/20240202132521.32714-1-kwolf@redhat.com/
>> ---
>>  hw/virtio/vdpa-dev.c |  8 +++++++-
>>  net/vhost-vdpa.c     | 15 ++++++++++++---
>>  2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/hw/virtio/vdpa-dev.c b/hw/virtio/vdpa-dev.c
>> index eb9ecea83b..d57cd76c18 100644
>> --- a/hw/virtio/vdpa-dev.c
>> +++ b/hw/virtio/vdpa-dev.c
>> @@ -259,7 +259,11 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>>          goto err_guest_notifiers;
>>      }
>>      for (i = 0; i < s->dev.nvqs; ++i) {
>> -        vhost_vdpa_set_vring_ready(&s->vdpa, i);
>> +        ret = vhost_vdpa_set_vring_ready(&s->vdpa, i);
>> +        if (ret < 0) {
>> +            error_setg_errno(errp, -ret, "Error starting vring %d", i);
>> +            goto err_dev_stop;
>> +        }
>>      }
>>      s->started = true;
>>
>> @@ -274,6 +278,8 @@ static int vhost_vdpa_device_start(VirtIODevice *vdev, Error **errp)
>>
>>      return ret;
>>
>> +err_dev_stop:
>> +    vhost_dev_stop(&s->dev, vdev, false);
>>  err_guest_notifiers:
>>      k->set_guest_notifiers(qbus->parent, s->dev.nvqs, false);
>>  err_host_notifiers:
>> diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
>> index 3726ee5d67..e3d8036479 100644
>> --- a/net/vhost-vdpa.c
>> +++ b/net/vhost-vdpa.c
>> @@ -381,7 +381,10 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
>>      }
>>
>>      for (int i = 0; i < v->dev->nvqs; ++i) {
>> -        vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
>> +        int ret = vhost_vdpa_set_vring_ready(v, i + v->dev->vq_index);
>> +        if (ret < 0) {
>> +            return ret;
>> +        }
>>      }
>>      return 0;
>>  }
>> @@ -1213,7 +1216,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
>>
>>      assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
>>
>> -    vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
>> +    r = vhost_vdpa_set_vring_ready(v, v->dev->vq_index);
>> +    if (unlikely(r < 0)) {
>> +        return r;
>> +    }
>>
>>      if (v->shadow_vqs_enabled) {
>>          n = VIRTIO_NET(v->dev->vdev);
>> @@ -1252,7 +1258,10 @@ static int vhost_vdpa_net_cvq_load(NetClientState *nc)
>>      }
>>
>>      for (int i = 0; i < v->dev->vq_index; ++i) {
>> -        vhost_vdpa_set_vring_ready(v, i);
>> +        r = vhost_vdpa_set_vring_ready(v, i);
>> +        if (unlikely(r < 0)) {
>> +            return r;
>> +        }
>>      }
>>
>>      return 0;
>> --
>> 2.43.0
>>
>


