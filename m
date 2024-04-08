Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2326BC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 06:43:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtiiB-0003Nz-D8; Mon, 08 Apr 2024 02:42:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtii7-0003NJ-7E
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:42:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1rtii4-0002MI-Hl
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 02:42:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712558547;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w1qvTtlpT1KzE7Xq3Qei/2L4rKRFN96m0iOMuUSXDMQ=;
 b=a7wS6OE3blQOCeULpuoCItdidO88+R8/VbbhVqBNFbAv95nLeIbm0yPGppVMZklt9CXzSz
 Yfh8XVODhuXYN9Pev4dKTydc+dNMyolotCSAIDDapiZnn76K5XqMLJbH36lsgUyzYBFhhU
 4+cR0OeiYdN0+mfPXD886+x1mdrLZHY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-zwML1871PiSX_vcDOofk_A-1; Mon, 08 Apr 2024 02:42:25 -0400
X-MC-Unique: zwML1871PiSX_vcDOofk_A-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5c5c8ef7d0dso3433523a12.2
 for <qemu-devel@nongnu.org>; Sun, 07 Apr 2024 23:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712558544; x=1713163344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=w1qvTtlpT1KzE7Xq3Qei/2L4rKRFN96m0iOMuUSXDMQ=;
 b=SakywbgkjDH/me8vjpEqPXuE0Fe5Uu3xC6mt0XJwlE0TNGpCQkDoFxvakczDxL6RE1
 xPxmpGbdlZIYdyTW/MaF+hkgRYQUqeuYuXweYzmm9r5PZeZfZcwxyTQH1PNJk5qqMfYL
 lDNVYjLNboneXWaX9pMWrGTFFc5km/6TNohOBQd4Yo7buKKYx7JJZxCKI2K1o0jhtysI
 3SDWJDxe02yyEUi2zumRUSnjQuJhocmOhpvI3pX9Yr4OU/Tqriiy59vyuUHWG8JMDAlk
 zhj8TGuCvN1gsZ87mbA7GfM3eTBksKUcRO6HnyexoxJOWat3lfpUB9Loa84ICFZbrF2V
 tJiw==
X-Gm-Message-State: AOJu0YyXEj8YwV+sXpZGq/XHLQNORC0/CqD37p2x+vSGdL6wrV+qUqXX
 CqFrS+kBK3F7R7D4yutw/p1qK9omblZbYJmKFSmT+Yt25GOl+AowyR+EgZ1+SgFhf4Hf9Cv0fT6
 SkA2MMquPmC0Dcb8lw4VdVK/Ouq5TKyf3uO4G8TljA2krngJSMPtcSqSffM0JLx5bA2kl2e3nTy
 yAVYZ7L0VXDj9MgwB9afwHApgVgzPZMYAWwao=
X-Received: by 2002:a05:6a20:9758:b0:1a7:3e78:cc7e with SMTP id
 hs24-20020a056a20975800b001a73e78cc7emr6444410pzc.14.1712558544570; 
 Sun, 07 Apr 2024 23:42:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn+4s/DRqERiWhRZiAtXxKldhh3sLtAkIFv5qr5dm7YldLfFvGzksLmslukXyXwVofMczrao0vmamdjsVR8LE=
X-Received: by 2002:a05:6a20:9758:b0:1a7:3e78:cc7e with SMTP id
 hs24-20020a056a20975800b001a73e78cc7emr6444403pzc.14.1712558544323; Sun, 07
 Apr 2024 23:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240329071100.31376-1-jasowang@redhat.com>
 <cf941815-b1e1-4a1b-8a36-ddbc04f43990@tls.msk.ru>
In-Reply-To: <cf941815-b1e1-4a1b-8a36-ddbc04f43990@tls.msk.ru>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 Apr 2024 14:42:13 +0800
Message-ID: <CACGkMEtstb8OrzVAUK1jLLZzUoEof86cqhbyvSRDKSxKaXC6BA@mail.gmail.com>
Subject: Re: [PULL 0/5] Net patches
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Apr 1, 2024 at 3:21=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> 29.03.2024 10:10, Jason Wang:
>
> > Akihiko Odaki (5):
> >        virtio-net: Fix vhost virtqueue notifiers for RSS
> >        ebpf: Fix indirections table setting
> >        hw/net/net_tx_pkt: Fix virtio header without checksum offloading
> >        tap-win32: Remove unnecessary stubs
> >        Revert "tap: setting error appropriately when calling net_init_t=
ap_one()"
>
>  From the above, I'm picking up
>
>    virtio-net: Fix vhost virtqueue notifiers for RSS
>    hw/net/net_tx_pkt: Fix virtio header without checksum offloading

Yes.

>
> for stable.  Not yet sure about
>
>    Revert "tap: setting error appropriately when calling net_init_tap_one=
()"
>
> as it's been with us for a long time.

It probably isn't worth bothering.

>
> Please Cc: qemu-stable@ for changes which should be picked for stable
> series.
>

Right.

Thanks

> Thanks,
>
> /mjt
>


