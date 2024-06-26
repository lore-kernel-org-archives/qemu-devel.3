Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B26BC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 03:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMJUV-0007JS-Hu; Tue, 25 Jun 2024 23:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sMJUS-0007Ir-1Q
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:38:36 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1sMJUQ-0004JA-Gc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 23:38:35 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-70665289275so80706b3a.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719373112; x=1719977912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eoNHHT9zyf4N6gTCTPTnqnyJhow7mdYnCAlaqLYb9ac=;
 b=PoWCWfX768ct/OCK1dU0xRX//2uyrhbpSeMeL3xwwPVGfibx3LXpNhRzQNNmog48Xd
 1aiCDBh+B1tMdIwJZj29DB753WNETnGFB+5fs/wqM1F7fulDJodcON1FVsIJkxu0tbDs
 U3HOq3utD2CDeulNLUgOK2k1AJTkJNT+2EA9/1gnUrNTHzIQuT6XK6a6jYLgDmPkwHRj
 kz6mZAYIKHQXIWWv8TAlpKKKo/hz38nomfznc4AyTL8Nn9HTKDoi8iugyPmSBrplyvm7
 V2+pK4hwsnJOf2jN397LHktlWxJHEMSosX0lOWUFJ5f5iVtiPvuXRILVL3q8AGojMX0Q
 gh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719373112; x=1719977912;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eoNHHT9zyf4N6gTCTPTnqnyJhow7mdYnCAlaqLYb9ac=;
 b=hBvkE9XrrkOTerK8LwpxMzE410Bl8W+z85nHj7skdtTM1h9S5W1cuyYoajfrmJa2Ui
 TZOl9uvNM8QSjH7hqIUQ5KGhP0NCJ8duiMJjCCmezoOFrpir9at2sV00gWbPnPTQ9HQG
 CnKWFSZBNem4rxg/8CTosuVHToTXFgYgZCvzr2v3x9LFz30j4buerKKs33OA8vKC/n6Q
 EqFrRLB5MU5/N/WC1GZ+V4QiCI+wxb3gZKWuvy2tabuoVqJuI8zvajR/bkTM8KoBzFat
 qsfkFHlWNUN0u463ixbhIrKA0D7EisSbDif5Kun1iWKJgwd9bCBpkvZTsXtQXEXSIVSp
 bF2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFEdJq6F9u+PNUmOuhAKeKS62KX4S4fcOK7qIzBr+Ys8mt2Ve22jaq05Lki2Zs8Pk/GszaXHkc8AIBCn6B1EyIJPvVgUc=
X-Gm-Message-State: AOJu0YxDuHZ1d8/bBkYCHve+TDn+SiOtnQy/YvmVv9UWeSVdc5yiFLs1
 zqlJRGziXKiDcWxJmE3URxrI9chW1EChr4x1A1J6D1ygzN2fnTId
X-Google-Smtp-Source: AGHT+IEOyER7X/fFhrTqLCYuKbNH03KmNlnHLiUpKHCEjiF+DQccuXyzL84tvbLXtqgUTr6OyVLwCw==
X-Received: by 2002:a05:6a20:914d:b0:1b5:88f5:5823 with SMTP id
 adf61e73a8af0-1bceca3fba2mr15917769637.27.1719373112225; 
 Tue, 25 Jun 2024 20:38:32 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.84.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-716bb22dffesm7892241a12.83.2024.06.25.20.38.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 20:38:31 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: sgarzare@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 Sahil Siddiq <sahilcdq@proton.me>
Subject: Re: [RFC] vhost: Introduce packed vq and add buffer elements
Date: Wed, 26 Jun 2024 09:08:27 +0530
Message-ID: <12465265.O9o76ZdvQC@valdaarhun>
In-Reply-To: <CAJaqyWeXZ3HAxga1aH4hURnydwZhTMSoV65ReqiX1hVWMRYzbA@mail.gmail.com>
References: <20240618181834.14173-1-sahilcdq@proton.me>
 <3301839.44csPzL39Z@valdaarhun>
 <CAJaqyWeXZ3HAxga1aH4hURnydwZhTMSoV65ReqiX1hVWMRYzbA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi,

On Monday, June 24, 2024 5:06:42=E2=80=AFPM GMT+5:30 Eugenio Perez Martin w=
rote:
> [...]
> > > >  /* Shadow virtqueue to relay notifications */
> > > >  typedef struct VhostShadowVirtqueue {
> > > >=20
> > > > +    /* Virtio queue shadowing */
> > > > +    VirtQueue *vq;
> > > > +
> > > > +    /* Virtio device */
> > > > +    VirtIODevice *vdev;
> > > > +
> > > > +    /* SVQ vring descriptors state */
> > > > +    SVQDescState *desc_state;
> > > > +
> > > > +    /*
> > > > +     * Backup next field for each descriptor so we can recover
> > > > securely,
> > > > not +     * needing to trust the device access.
> > > > +     */
> > > > +    uint16_t *desc_next;
> > > > +
> > > > +    /* Next free descriptor */
> > > > +    uint16_t free_head;
> > > > +
> > > > +    /* Size of SVQ vring free descriptors */
> > > > +    uint16_t num_free;
> > > > +
> > >=20
> > > Why the reorder of all of the previous members?
> >=20
> > I was thinking of placing all the members that are common to packed and
> > split vring above the union while leaving the remaining members below t=
he
> > union. I did this based on our discussion here [1]. I don't think this
> > reordering serves any purpose implementation-wise. Please let me know if
> > I should revert this change.
>=20
> I'm not against the change, but removing superfluous changes helps the
> reviewing. If you send the reordering, please use a separate patch so
> it's easier to review.

Understood, I'll keep this in mind when sending patches.

Thanks,
Sahil




