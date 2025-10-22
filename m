Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFB2CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 14:04:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBZS0-0000pb-3l; Wed, 22 Oct 2025 10:04:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBZRw-0000ob-CT
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:04:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1vBZRs-0001rv-KY
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 10:04:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761141857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3f2OUDR112NmZck0HsfQv4HaovnvMIHW0Tp8HbDWliE=;
 b=MgDjQtlsy4bmmKH9FITPI+uxY5kUF+tARJG27ra8TuFElnDOqZivwj1alHkcre3EraLxUu
 vfjMbRbchHWc5S7jPCujJuu/kVDz6e4OJEZRxhXIGtuPQixwAECG/eb7O6Je1npEd+nnHM
 UthrqYmClSUbrspvqyp/NTKAvEz5qmI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-xrlC1dwLNnC1sNwZNex62g-1; Wed, 22 Oct 2025 10:04:15 -0400
X-MC-Unique: xrlC1dwLNnC1sNwZNex62g-1
X-Mimecast-MFC-AGG-ID: xrlC1dwLNnC1sNwZNex62g_1761141855
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47111dc7c5dso5516405e9.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 07:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761141855; x=1761746655;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3f2OUDR112NmZck0HsfQv4HaovnvMIHW0Tp8HbDWliE=;
 b=IRHI4DY9TpeRpacq36lKK4ZObf61gzCl42udLL4Cd/2nGMXuBJ1US1r8fvAKdo9ezm
 8Cxkfwm4y1aAybFh5h+29QBmOzp+9R5FnkDnPtCfFv6bpcPMc9lJQjcdhhDGVPpgK3x6
 4V44VuOcd3XA6l9krtKxxnUPVmC25AFT+ek9+GODGN90e4Mryh5ArbLMMlfIeRq78Uf2
 Gf53ukM3/iTLbQtWO8P/z21PmyXbrMZqNIgh6aVTnXgDnFcoGrNCOkgrq6PVoiq7t9ms
 HG3igWsZcifKq4yzOG45E4PHAEVnKp7EjCBqp02GCCvXG3mfIjzf5DoV3alzWvSkxALt
 VS+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF94uXFPSGXLJZ5VN7oMgOHLe552ZHgXF+pgddy/hwE/Cp5STo05CBtxABQELyTfiidYonh9hRdK7q@nongnu.org
X-Gm-Message-State: AOJu0Yz8Ft6WERdiv6E8+Q+qv+5uO2BDk3Bk9npU3h99jfXh31Ezqpzd
 34d1ynnlb93STZfwuiSxETmE5OTYrWcPkjLOOazHbVo0L+ETQzbaYq2MS6Gcj/rB9B907g3mgqn
 U94YD0pQKTyHTgXeNG49wfCHxHxMSLLNQOKgOwT46jM21VMo727tic1vj
X-Gm-Gg: ASbGnctdmvyNuS54s2IEQym/KY/Xbk33tZ3Ha5ojotm4JxwbOrbteMO6Tmcjbsg1osl
 R139mv3uFV+sBuu0iU7UqAtsj3szWEtVNckHHt0OMK0uxUXOCtjNnfc7kDhlcyIX9FlxqaF0R5B
 c9MA/8drLYPtngOz7zo+KuLfmvKawz2HcYBIf8sfJxY+DNUjQASxBBu39OTyZUpDkGcdK3ZOQVk
 XY8f/lgOjjqKCfBhEfeizKI13iiZ32WwE3xtaaFZNe7KGRxHKpUepwg3TznCaK3BOlS69tP5dFX
 uXKDfxZn8E6OEmx5NkN+H0KToBYkfUn4E1Lf8A/1NB4ls1KQ8Mf1UqdWT/A+LbMBUdtdgIOjwsy
 rrYfCf/JwZVVfw9Oixqc1KEivis3XRFcBVm/Ji+0xdS5I3AXkJT8=
X-Received: by 2002:a05:600c:4f89:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-475c3fb3166mr24788435e9.7.1761141854699; 
 Wed, 22 Oct 2025 07:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJmiO5JnwdruSiDU/vbc+5vTNb+0xrONa4IFl3TILKAzQS6QNnBBYd3cq9+ALmkIMSbvcrjA==
X-Received: by 2002:a05:600c:4f89:b0:45f:29eb:2148 with SMTP id
 5b1f17b1804b1-475c3fb3166mr24788045e9.7.1761141854144; 
 Wed, 22 Oct 2025 07:04:14 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it.
 [79.46.200.153]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c4342368sm46475225e9.9.2025.10.22.07.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 07:04:13 -0700 (PDT)
Date: Wed, 22 Oct 2025 16:04:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: gmaglione@redhat.com, qemu-devel@nongnu.org, 
 Hanna Czenczek <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] Make vhost_set_vring_file() synchronous
Message-ID: <den4gz23dnkg6eyjmfoflujd2oimw7ktxoz6ha727ei576w2iw@ei6aogzv6bt6>
References: <20251022133228.301365-1-gmaglione@redhat.com>
 <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJaqyWccaCUfQLzQXdX+3+sQNz+-AjSvqmCignXR+URfz7FHww@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Oct 22, 2025 at 03:49:25PM +0200, Eugenio Perez Martin wrote:
>On Wed, Oct 22, 2025 at 3:32 PM <gmaglione@redhat.com> wrote:
>>
>> From: German Maglione <gmaglione@redhat.com>
>>
>> QEMU sends all of VHOST_USER_SET_VRING_KICK, _CALL, and _ERR without
>> setting the NEED_REPLY flag, i.e. by the time the respective
>> vhost_user_set_vring_*() function returns, it is completely up to chance
>> whether whether the back-end has already processed the request and
>> switched over to the new FD for interrupts.
>>
>> At least for vhost_user_set_vring_call(), that is a problem: It is
>> called through vhost_virtqueue_mask(), which is generally used in the
>> VirtioDeviceClass.guest_notifier_mask() implementation, which is in turn
>> called by virtio_pci_one_vector_unmask().  The fact that we do not wait
>> for the back-end to install the FD leads to a race there:
>>
>> Masking interrupts is implemented by redirecting interrupts to an
>> internal event FD that is not connected to the guest.  Unmasking then
>> re-installs the guest-connected IRQ FD, then checks if there are pending
>> interrupts left on the masked event FD, and if so, issues an interrupt
>> to the guest.
>>
>> Because guest_notifier_mask() (through vhost_user_set_vring_call())
>> doesn't wait for the back-end to switch over to the actual IRQ FD, it's
>> possible we check for pending interrupts while the back-end is still
>> using the masked event FD, and then we will lose interrupts that occur
>> before the back-end finally does switch over.
>>
>> Fix this by setting NEED_REPLY on those VHOST_USER_SET_VRING_* messages,
>> so when we get that reply, we know that the back-end is now using the
>> new FD.
>>
>
>Fixes: 5f6f6664bf24 ("Add vhost-user as a vhost backend.") ?
>
>> Signed-off-by: German Maglione <gmaglione@redhat.com>
>> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
>> ---
>>  hw/virtio/vhost-user.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
>> index 36c9c2e04d..641960293b 100644
>> --- a/hw/virtio/vhost-user.c
>> +++ b/hw/virtio/vhost-user.c
>> @@ -1327,8 +1327,11 @@ static int vhost_set_vring_file(struct vhost_dev *dev,
>>                                  VhostUserRequest request,
>>                                  struct vhost_vring_file *file)
>>  {
>> +    int ret;
>>      int fds[VHOST_USER_MAX_RAM_SLOTS];
>>      size_t fd_num = 0;
>> +    bool reply_supported = virtio_has_feature(dev->protocol_features,
>> +                                              VHOST_USER_PROTOCOL_F_REPLY_ACK);
>
>Why not use vhost_user_write_sync directly?

I was about to suggest the same thing, but IIUC does not support passing 
fds.

However, yes, I agree that we should extend vhost_user_write_sync() in 
another patch and then use it either here and in other places (e.g.  
vhost_user_set_mem_table(), vhost_setup_backend_channel()).

But maybe that could be a follow-up later, since this is a fix to 
backport without touching too much code around. Up to German and you, 
I'm fine with both.

Thanks,
Stefano


