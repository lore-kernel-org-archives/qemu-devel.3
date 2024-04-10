Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2156CD1296
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2024 06:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruRSx-0001U1-EG; Wed, 10 Apr 2024 02:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruRSt-0001Sw-RP
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1ruRSr-000384-71
 for qemu-devel@nongnu.org; Wed, 10 Apr 2024 02:29:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712730584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7sW5z9x4clbiL+M9NwCEfo409NFGA1DYYVSsICqDSYQ=;
 b=K6tCT9saz0CUma9RbXmiytIjI/W2VEmyK1SZVhKc0wZu0YGNHZW8DLMPrY4qwyyswSp5+k
 0kiwlS6BJI7u9g5zxr/HUtA8MzH+IIVBiUpG97Ho8o+VZu+g/mI/DAjcC6EweFsgaDzOOh
 F4OHuUZ9et4dBReQ4hoEvm+wIs2z8Bg=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-ihkDRKtuMSW9G8GHHPcADA-1; Wed, 10 Apr 2024 02:29:42 -0400
X-MC-Unique: ihkDRKtuMSW9G8GHHPcADA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d871310b3aso40953611fa.0
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 23:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712730581; x=1713335381;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7sW5z9x4clbiL+M9NwCEfo409NFGA1DYYVSsICqDSYQ=;
 b=MPIOyBMOaaxz0Ikjs1l5Thn+PFe9X/7XI9mGjqGwY6WGWTS4kBcO0JEyHtfGyW6qce
 4F6DhN21Gjr2amdVaNwu5BDwrGDQ64UYjzvhbQkrNrl4ft2S/UjEkiy9w3OiIMLiPV0u
 LcT77oKXSbgZxAWDWl8Yim97VTJng/jXf0vjaWCi7ByDx+Kh2VdakVdKSUyCiunz601V
 oX0dKLX4OeF2sLhDm78IVsS3yqNuqTKTqtt6l2WfLlBLn3LXVrSEWcjh2HiBceENW66x
 JyQ86UfQVk2tclffuV4zUKtbwF/Fkjyhw+XlADNT9VFyZHlsX3fQK97q7VMQ/Tx/cnQI
 f2Xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX16BsfobZ8+j+uC1869q6TYUz2IZAGiguInVdQKCgnZODCPGadfE3K18g7FxaJ6EzPLB+jdzgp6OkwnHKf/HKkp6xPn3Y=
X-Gm-Message-State: AOJu0YyoLgLp89pnMXFjT8LuVJL9zW6GB6Ievq4AJ6ibwQhwtdFT1/GB
 PCmE0SYVTLs7M1Mw3gGeAM3LzhY69CziMimZa+BCDRr+Ja0igglj4dc2mcQVOeXD6y7fr5xgsFU
 LSpt3FBNKNHC3P/Al1uM/v+yWdy50cByGYMdcy3O0i+TmNbJUJTWC5W1zBbJjMKljv2jAxtoMTy
 1lxV0GmMY0lxqd7PWsnD74wzJkZTw=
X-Received: by 2002:a19:750b:0:b0:516:d232:2516 with SMTP id
 y11-20020a19750b000000b00516d2322516mr1057075lfe.6.1712730580946; 
 Tue, 09 Apr 2024 23:29:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH234h6xjSx/pPKMM02/LPlNcL3TDco/dcU2txyTqP7SWOMEH1Dk6XIco3gdZWx0aebLvniYKeVH3XFB8FO6S8=
X-Received: by 2002:a19:750b:0:b0:516:d232:2516 with SMTP id
 y11-20020a19750b000000b00516d2322516mr1057064lfe.6.1712730580645; Tue, 09 Apr
 2024 23:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240410052926.417674-1-lulu@redhat.com>
 <20240410052926.417674-2-lulu@redhat.com>
 <CACGkMEunM_JPGg82kN+SvFVeNO4jtf-PRfkEjoNkCYwxy204Mg@mail.gmail.com>
In-Reply-To: <CACGkMEunM_JPGg82kN+SvFVeNO4jtf-PRfkEjoNkCYwxy204Mg@mail.gmail.com>
From: Cindy Lu <lulu@redhat.com>
Date: Wed, 10 Apr 2024 14:29:03 +0800
Message-ID: <CACLfguW9qP+Adyv5a5KdPRH0DmcGeaGZ-nvRw7uyJd3RLd=QYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virtio-pci: Fix the crash that the vector was used
 after released.
To: Jason Wang <jasowang@redhat.com>
Cc: mst@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 10, 2024 at 1:48=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Apr 10, 2024 at 1:29=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote:
> >
> > When the guest triggers vhost_stop and then virtio_reset, the vector wi=
ll the
> > IRQFD for this vector will be released and change to VIRTIO_NO_VECTOR.
> > After that, the guest called vhost_net_start,  (at this time, the confi=
gure
> > vector is still VIRTIO_NO_VECTOR),  vector 0 still was not "init".
> > The guest system continued to boot, set the vector back to 0, and then =
met the crash.
>
> Btw, the description of the cover letter seems to be better, how about
> just using that (so there won't be a cover letter since this series
> just have 1 patch)?
>
> Thanks
>
sure will send a new version
Thanks
Cindy


