Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3096ACAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 09:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1iMK-000765-3l; Thu, 25 Sep 2025 05:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v1iM7-00075M-Vu
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:33:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v1iLw-0007xH-9j
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 05:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758792804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XGoLFtGu1inobzRhqNYbpD3J5K+B84ivcTPjNTVVQ50=;
 b=hCikiPTXsb8PqBfX+Phf+CYTaiBEoeOonYh/eZfCLPF5w1ZHch7O/apyZ5t+Kj6lXXaNgn
 4qrBw8Ifu+vjBN7sjmktiG1J7bTGxCQnXXl2HASIilyUqJ5pmiSkYn4AObEXlXOZrcMts4
 P8Y0vXkHgKn27UxPlnPTmZ48f53PIzU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-ly1fmNDQPBW5ObfWSUkIbg-1; Thu, 25 Sep 2025 05:33:17 -0400
X-MC-Unique: ly1fmNDQPBW5ObfWSUkIbg-1
X-Mimecast-MFC-AGG-ID: ly1fmNDQPBW5ObfWSUkIbg_1758792796
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45f2b9b99f0so4277475e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 02:33:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758792796; x=1759397596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XGoLFtGu1inobzRhqNYbpD3J5K+B84ivcTPjNTVVQ50=;
 b=MnhNhAuHkMhxyQUxp/DkGru7Ml9Ab2GWw9cKJngLLCXp2ocUa66jVClIOhP9fLa8zz
 oKC5gOyPmfPhmvhLHKNuh5vg8TbAy0q1N6Eojcq3c2dFzJA9XLvzp3RTrXAibdSQzBWN
 0meVrocoDOE6VAei/jFCvM4wrLdYKSTeZZngzVvdknL9HeSD2Dl/kV06fjRe58OQYRxl
 cSPVSx8pQhIy+BOvN5H5iFN+tmWFVyzQg2xxfqTqWxijRHntJCxx59A8KhJ5nv7MZfxb
 a6a9Ouk6mgy9iKdlhzkRgfQs2KrwBpXU/c2haECiYWxM7sOP776glw0fn9R+qlaucepA
 GIAA==
X-Gm-Message-State: AOJu0YyQBL5Dwp3ZmoTQiR8wOLn+5FcisDFx7GeKy7mz7ngkVxwSIwTG
 6/VBAIeTuRjak4DvJwq+EAth8nuCGnKmBz6a+23EIisPalFtVSP7ANvBoQaj4Qv6okvW8+EkhC2
 U8yIemzmnZHdcAjmadZqWQ4J4K2LeTKrRlNh79wvL/mPXkAOwYCLJbvro
X-Gm-Gg: ASbGncsoX+AeDqhGw9zys5Vc4YhbJEXabtrMVw4evrBT2nOw0rp88UtpUCHce6EMOwz
 TsNxTOjNc//5KkmydeMOJrzEuxoXAqcu7a+8KEOgxcHo2h/NFNooLcmAbxe8kFfEijf4bTufpHX
 FKdZLFw1OkxTG5mTljOMVHgN7mToFrTFzpph4PP7cbWvQxdJTZVtbN76HI2yaIhhnD4cLkLbF9o
 QDxiDXLNtHRYwQH0rUmbcjKRtuoTiIaSmJi7G7YmxiNuM+1hFIb23ugBe9o0fW75kX8K+Yzsy5j
 nyUoAnSj5Ks5rQvGqsqMXY8M/Z+ypmYulA==
X-Received: by 2002:a05:600c:4ca8:b0:45d:f7df:2735 with SMTP id
 5b1f17b1804b1-46e33c932fbmr12599525e9.16.1758792795836; 
 Thu, 25 Sep 2025 02:33:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj4hAaST3EozjyWGkAl52+53n/Ht5OF61hKGtQwg7pRXiU8Q33/DrE3bmzxlqLaGadNJYJHQ==
X-Received: by 2002:a05:600c:4ca8:b0:45d:f7df:2735 with SMTP id
 5b1f17b1804b1-46e33c932fbmr12599245e9.16.1758792795272; 
 Thu, 25 Sep 2025 02:33:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1538:2200:56d4:5975:4ce3:246f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e33baa625sm26631345e9.7.2025.09.25.02.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 02:33:14 -0700 (PDT)
Date: Thu, 25 Sep 2025 05:33:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Speich <c.speich@avm.de>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] virtio: vhost-user-device: Make user creatable again
Message-ID: <20250925053005-mutt-send-email-mst@kernel.org>
References: <20250919-vhost-user-device-creatable-v1-1-87eefeea7f68@avm.de>
 <20250919160526-mutt-send-email-mst@kernel.org>
 <32x5pe3iz6v2vu5imktyxwajk4vdhamhc7yhfmtzuylcvdkunl@wvdfyo23zueh>
 <20250922065614-mutt-send-email-mst@kernel.org>
 <4yg4y2miiso6c4c6qtlowji6ak3kid5g66ncen4uljsone67ta@c6s22jbk4ckz>
 <20250922103658-mutt-send-email-mst@kernel.org>
 <qvq5owxu7teejoejhoelvauiknbhd5el6qlwj3ud4bi5f7ydya@vsojjbotm44w>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qvq5owxu7teejoejhoelvauiknbhd5el6qlwj3ud4bi5f7ydya@vsojjbotm44w>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Sep 25, 2025 at 09:56:02AM +0200, Christian Speich wrote:
> On Mon, Sep 22, 2025 at 10:37:40AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Sep 22, 2025 at 01:11:33PM +0200, Christian Speich wrote:
> > > On Mon, Sep 22, 2025 at 06:56:31AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Sep 22, 2025 at 12:40:33PM +0200, Christian Speich wrote:
> > > > > On Fri, Sep 19, 2025 at 04:07:19PM -0400, Michael S. Tsirkin wrote:
> > > > > > On Fri, Sep 19, 2025 at 04:30:53PM +0200, Christian Speich wrote:
> > > > > > > This removes the change introduced in [1] that prevents the use of
> > > > > > > vhost-user-device and vhost-user-device-pci on unpatched QEMU builds.
> > > > > > > 
> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > > > 
> > > > > > > Signed-off-by: Christian Speich <c.speich@avm.de>
> > > > > > > ---
> > > > > > > vhost-user-device and vhost-user-device-pci started out as user
> > > > > > > creatable devices. This was changed in [1] when the vhost-user-base was
> > > > > > > introduced.
> > > > > > > 
> > > > > > > The reason given is to prevent user confusion. Searching qemu-discuss or
> > > > > > > google for "vhost-user-device" I've seen no confused users.
> > > > > > > 
> > > > > > > Our use case is to provide wifi emulation using "vhost-user-device-pci",
> > > > > > > which currently is working fine with the QEMU 9.0.2 present in Ubuntu
> > > > > > > 24.04. With newer QEMU versions we now need to patch, distribute and
> > > > > > > maintain our own QEMU packages, which is non-trivial.
> > > > > > > 
> > > > > > > So I want to propose lifting this restriction to make this feature
> > > > > > > usable without a custom QEMU.
> > > > > > > 
> > > > > > > [1]: 6275989647efb708f126eb4f880e593792301ed4
> > > > > > 
> > > > > > The confusion is after someone reuses the ID you are claiming without
> > > > > > telling anyone and then linux guests will start binding that driver to
> > > > > > your device.
> > > > > 
> > > > > Thanks for clarifciation, In our use-case we use mac80211_hwsim which is
> > > > > in linux upstream (with the ID 29). So I think a potential reuse here
> > > > > is something that linux upstream already deals with.
> > > > 
> > > > So just allow that one?
> > > 
> > > That would solve our problem.
> > > 
> > > However, I'm finding it somwhat odd to artifically force the user only use
> > > QEMU it the "allowed way". I'd much rather see that virtio-user-device is
> > > usuable as is (and mac80211_hwsim is not a special case and just works).
> > > 
> > > Regards,
> > > Christian
> > 
> > We can combine both. Want to try?
> 
> I'm not sure what both means here?
> 
> Greetings,
> Christian

Both add a generic device with a declaration that
it is unsupported and maybe "x-" name prefix, for developers,
and a supported mac80211_hwsim device, for users.


> > 
> > 
> > > > 
> > > > > > 
> > > > > > 
> > > > > > We want people doing this kind of thing to *at a minimum*
> > > > > > go ahead and register a device id with the virtio TC,
> > > > > > but really to write and publish a spec.
> > > > > 
> > > > > I understand this desire, I'm not sure how this relates with the ability
> > > > > to let a user create a vhost-user-device or not.
> > > > > 
> > > > > Kind Regards,
> > > > > Christian
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > ---
> > > > > > >  docs/system/devices/vhost-user.rst | 10 ----------
> > > > > > >  hw/virtio/vhost-user-device-pci.c  |  3 ---
> > > > > > >  hw/virtio/vhost-user-device.c      |  3 ---
> > > > > > >  3 files changed, 16 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> > > > > > > index 35259d8ec7c666aa0c56497b8261f48d77216ad5..2d130f9767dbb1cbb85cef43c63dc9a8d7b30d4a 100644
> > > > > > > --- a/docs/system/devices/vhost-user.rst
> > > > > > > +++ b/docs/system/devices/vhost-user.rst
> > > > > > > @@ -73,16 +73,6 @@ all the required parameters including:
> > > > > > >    - The ``num_vqs`` it needs and their ``vq_size``
> > > > > > >    - The ``config_size`` if needed
> > > > > > >  
> > > > > > > -.. note::
> > > > > > > -  To prevent user confusion you cannot currently instantiate
> > > > > > > -  vhost-user-device without first patching out::
> > > > > > > -
> > > > > > > -    /* Reason: stop inexperienced users confusing themselves */
> > > > > > > -    dc->user_creatable = false;
> > > > > > > -
> > > > > > > -  in ``vhost-user-device.c`` and ``vhost-user-device-pci.c`` file and
> > > > > > > -  rebuilding.
> > > > > > > -
> > > > > > >  vhost-user daemon
> > > > > > >  =================
> > > > > > >  
> > > > > > > diff --git a/hw/virtio/vhost-user-device-pci.c b/hw/virtio/vhost-user-device-pci.c
> > > > > > > index f10bac874e78429c633752a4ce9db28385b3bb07..c76a856c9b9a67d941a93929244216658ff2a156 100644
> > > > > > > --- a/hw/virtio/vhost-user-device-pci.c
> > > > > > > +++ b/hw/virtio/vhost-user-device-pci.c
> > > > > > > @@ -38,9 +38,6 @@ static void vhost_user_device_pci_class_init(ObjectClass *klass,
> > > > > > >      VirtioPCIClass *k = VIRTIO_PCI_CLASS(klass);
> > > > > > >      PCIDeviceClass *pcidev_k = PCI_DEVICE_CLASS(klass);
> > > > > > >  
> > > > > > > -    /* Reason: stop users confusing themselves */
> > > > > > > -    dc->user_creatable = false;
> > > > > > > -
> > > > > > >      k->realize = vhost_user_device_pci_realize;
> > > > > > >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > > > > > >      pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
> > > > > > > diff --git a/hw/virtio/vhost-user-device.c b/hw/virtio/vhost-user-device.c
> > > > > > > index 3939bdf755222a281da8ca22243d7d4f16990a66..1bea496afd0137ba9b42009f6252acf6800528d1 100644
> > > > > > > --- a/hw/virtio/vhost-user-device.c
> > > > > > > +++ b/hw/virtio/vhost-user-device.c
> > > > > > > @@ -41,9 +41,6 @@ static void vud_class_init(ObjectClass *klass, const void *data)
> > > > > > >  {
> > > > > > >      DeviceClass *dc = DEVICE_CLASS(klass);
> > > > > > >  
> > > > > > > -    /* Reason: stop inexperienced users confusing themselves */
> > > > > > > -    dc->user_creatable = false;
> > > > > > > -
> > > > > > >      device_class_set_props(dc, vud_properties);
> > > > > > >      dc->vmsd = &vud_vmstate;
> > > > > > >      set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
> > > > > > > 
> > > > > > > ---
> > > > > > > base-commit: e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6
> > > > > > > change-id: 20250919-vhost-user-device-creatable-b7f9b7b5bfb2
> > > > > > > 
> > > > > > > Best regards,
> > > > > > > -- 
> > > > > > > Christian Speich <c.speich@avm.de>
> > > > > > 
> > > > > > 
> > > > 
> > > > 
> > 
> > 


