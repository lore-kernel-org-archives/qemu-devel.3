Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E650DD44D55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 12:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8ej7-0003R1-6v; Wed, 06 Nov 2024 07:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8ej4-0003Qd-3V
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1t8ej1-0004u7-KF
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 07:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730894486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lRidEWTVj+gNMObIJEyuCAZaedeEWXpAJmamgXEgCoI=;
 b=iF80hIbRl5Prc1iUu9AczRw4opAAscUuaiGxXvA62zPDnWHoeuLbnv1qXg+rq4iYdvdmg7
 3uhA0z/9R1k1or9aVxLyiwws8iD2DFBTgZWcVLiTgUZq05JZgegiAhIpXq0D1qNgYcJs96
 bAGzti5zGHdr4gQHPvb4hRV4/ayoDsA=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-RLfu92yFOh-CEcKLd_SMZQ-1; Wed, 06 Nov 2024 07:01:23 -0500
X-MC-Unique: RLfu92yFOh-CEcKLd_SMZQ-1
X-Mimecast-MFC-AGG-ID: RLfu92yFOh-CEcKLd_SMZQ
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7187cd3b2c6so5868122a34.2
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 04:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730894481; x=1731499281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lRidEWTVj+gNMObIJEyuCAZaedeEWXpAJmamgXEgCoI=;
 b=QeQpHKxb+g8Si02YoDCgifiXFc3dhc7vgqlHlu9fVWcgq89D9jXeo4j6A/Zgryk3HB
 RdpedbtmsV+8SsJE1JBRgxpCiHzcqvpWOK8fm3qWoNdSXhtpqtbsv5A4UASzVomfBYcc
 ECCVTBM8FYjG71wevg4uvdLTH3Y35bE3aWO7NkxNjTJvpjM6n5Hp1xacK0WGMDfr4FGD
 E+9zXicjiy6Xc9++53uKxNT3QgGRCT0m5QhVTpoZV3Rxm3cQDiWH3dPbkTRhSv0sbkof
 BtRffKdq58adj/DPxvbS2QQkKkgeNS6UWrSFukluxWtsxi6qD3PNc70LYlnQDT13RDLX
 +YZQ==
X-Gm-Message-State: AOJu0Yw3ax3rhbLKKpMOKJ6/X9c2PA7rY/9qk9EucdIJgOAyW2ggO4zT
 2wy7eIGfWzJbGJnDTxTmjNuK9vcxQbp/s2JBdBB96memu1ZLIWjRUIAk4cZkbZjBONzQ1ibyoMe
 TCDk2BPCsRAWJWiPbrQrThrYfMaK9uO1OzN2CFF8FV93OaXmBzhft
X-Received: by 2002:a05:6870:1699:b0:288:6a16:fe1 with SMTP id
 586e51a60fabf-29051b73046mr32204753fac.18.1730894481105; 
 Wed, 06 Nov 2024 04:01:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGWJasPpc3LTsAcnx1PAO4T3ww7Zn51IoS8+FiWxtgGmEGiNN4Kdocl0/j3OgQ14SzCvhLRNQ==
X-Received: by 2002:a05:6870:1699:b0:288:6a16:fe1 with SMTP id
 586e51a60fabf-29051b73046mr32204660fac.18.1730894480216; 
 Wed, 06 Nov 2024 04:01:20 -0800 (PST)
Received: from sgarzare-redhat ([5.77.86.226])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2948711bf9fsm4282573fac.0.2024.11.06.04.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 04:01:19 -0800 (PST)
Date: Wed, 6 Nov 2024 13:01:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Prasad Pandit <ppandit@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>, Jason Wang <jasowang@redhat.com>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: Re: [PATCH] vhost: fail device start if iotlb update fails
Message-ID: <p4ryblk3o63lao45cplo2ws6l5thcmt52phue63benvwhjrdud@53ta327k6mhj>
References: <20241105060053.61973-1-ppandit@redhat.com>
 <a664pk3wefui7tyvs6rjln2tm2fxwir6yvshffwkjypksechjj@3amhddyqxwiz>
 <CAE8KmOxHTx=ZxTWype-YVizogDEVVXVg=jRdYU8eRtHP7ngr9w@mail.gmail.com>
 <kxiffscfbs4njd6cfuebstpm5yrp7jdkgulcwbsmsyyxfowixw@yrhyrmhaj7da>
 <CAE8KmOwWDw7fxbLcVLo1BwkLYfi4X_9mKP73MaZz177LNgaaJg@mail.gmail.com>
 <ez2fb2yg7zha6ccdey47zxhaxcgwim7f6p4zzj4ucrgjnbavyk@mrnhs47uyx5e>
 <CAE8KmOy48HPqW4VLJmf+ofZq+K1nM3tza3Sp4nX6sAreV0bxOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAE8KmOy48HPqW4VLJmf+ofZq+K1nM3tza3Sp4nX6sAreV0bxOg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 06, 2024 at 05:14:24PM +0530, Prasad Pandit wrote:
>On Wed, 6 Nov 2024 at 16:05, Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >+fail_iotlb:
>> >+    hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
>> > fail_start:
>> >+    hdev->vhost_ops->vhost_dev_start(hdev, false);
>>
>> This should go before the fail_start label, since it should not be
>> called when vhost_dev_start() fails.
>
>* I see, okay.
>
>> Also we need to check if that callback is defined.
>
>* That check is already done while reaching the 'goto fail_iotlb;'
>statement, no? OR maybe we only check for:
>hdev->vhost_ops->vhost_dev_start() function?

For vhost_set_iotlb_callback() that is true because for now we go to 
that label only if the callback is defined, but this is not the case for 
hdev->vhost_ops->vhost_dev_start().

Anyway if in the future we add a new step that need to go on that label 
we may forgot to remember that, so since it's not a hot path, I'd add 
both checks as we do in vhost_dev_stop().

>
>> >* Looking at the vhost_vdpa_dev_start(), when it is called with
>> >'started=false' parameter, it calls the vdpa_suspend, vdpa_stop etc.
>> >functions. ie. probably other ->vhost_dev_start() and
>> >->vhost_set_iotlb_callback() functions need to take appropriate action
>> >when called with 'started/enabled=false' parameter.
>>
>> We already call them in vhost_dev_stop(), so I guess we are fine.
>
>* I meant vhost device functions like vhost_user_dev_start() and
>vhost_user_set_iotlb_callback() need to take action when called with a
>'false' parameter.

IIUC in vhost_dev_stop() we already call both of them with a 'false' 
parameter, so that functions should be already prepared or am I missing 
something?

Thanks,
Stefano


