Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4E1FA3755
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 13:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp6Uf-0005Jj-5V; Fri, 13 Sep 2024 09:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sp6Ub-0005Ig-3X
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:37:45 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sp6UZ-0005Q2-8F
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 09:37:44 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2f75aaaade6so24785921fa.1
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1726234659; x=1726839459; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbzOoQxCbHX4bElBtVkSdrsCkVqd5g6yTlTlNzfuNhE=;
 b=TJTHC9frWFUf4Qo8H5XcpEJxP7MvjZ+nItHNgHlSjqVJKxaTalhLbdmSex6GDGh4Dc
 r4n0dgHrWqrUnrQ9lbhZdT9EycfzgOeCXnUornMuBcqEXodzIKgCK/WxXtj7FVBB6OcA
 giZ27FuKoAr7qQnn8BlJfEsn9O7mktluF2Pxy2b+gk/FwXT+q7GN2V6tZ9MvB2er3Dc6
 W+hQ8n+rTmRo6F6qF9UoRZV7+Gmqa4yLmb6k54mrNT4OGLDr+87tGG73Y/8A16Uz+Tk4
 74RxhuAC/pr4NxML5ektPqrp9hGSvPshYv2jGQJmYHS/LbBIyQkNgtciTuGJX2gQQVEa
 8Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726234659; x=1726839459;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wbzOoQxCbHX4bElBtVkSdrsCkVqd5g6yTlTlNzfuNhE=;
 b=DqfzNha0oCfXnKCHR2HcbF+ke6QFdWq5ZCjLXQqhY+Ub64cG2og4wFXOMUMLO0RucY
 tyOG3ZsqJF2M0vpvLgsWPs1vYfXJ7LPu/jJM5/Pxo9H6RcyuhsjPCmpMyJvo0NvUr3k6
 VXmqCTO4ckhUMTRzs39d0I3Lv/dCuPIw6TjNIBDvhUDh4ivmKdJwWatX2Qvl9bm3oPda
 AIrkOw8IKJNs4hfy2E5K/eRJMcLlv2Aka3LwF+3E/4d5Nf6TRNlnwK1bhJ89SKnQcHN+
 7nmMAIRRV2UMaQuU4Z3GC1ew2iAtfTuUB3zX731bRkmtIv401eeEpfcwqBa1HZVEcwqL
 4awA==
X-Gm-Message-State: AOJu0YxX+VYzQsDL7RpbokuTOGrJwJgyosXJZnX6xehyDjwIuz2m1dNj
 uPNmScM1+gxYeNaFoEi18gw4gzhshYPyueRr74A7oGDq6ATRW1D3HAMMp8ahjKUS+OZ0gJEhy8Z
 1J7Wz9IudcWpGnUKQ2CnENjXk4U7iR7Oz8G1Tsg==
X-Google-Smtp-Source: AGHT+IExt7tefLZSxB6SRjeCBxXTnRa7/pD9HRz/WsGOaWq1Y2XRfNRv3PgipiSClTieVJlhpHwW8EYfV3Kfpdi2HW0=
X-Received: by 2002:a2e:f01:0:b0:2f7:7cc3:306 with SMTP id
 38308e7fff4ca-2f787dc7276mr33103481fa.17.1726234657897; 
 Fri, 13 Sep 2024 06:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240912051734.5298-1-jim.shu@sifive.com>
 <5fca8390-33c8-4139-8238-caef3e3f1dbe@redhat.com>
 <CALw707pkot65Zh_kpmKjZoQcm5f=VLLAFZwGbgR3D1qoDmiUGg@mail.gmail.com>
 <92b61c0a-b770-4065-9a97-ba111fb092f6@redhat.com>
In-Reply-To: <92b61c0a-b770-4065-9a97-ba111fb092f6@redhat.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 13 Sep 2024 21:37:26 +0800
Message-ID: <CALw707q0ro3H77JF36f8xNqPtpAGXS0Ww+5Pfhg7zjSutJmt3g@mail.gmail.com>
Subject: Re: [PATCH] vfio/pci: Fix null pointer deference from error API
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=jim.shu@sifive.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 12, 2024 at 5:56=E2=80=AFPM C=C3=A9dric Le Goater <clg@redhat.c=
om> wrote:
>
> Hello Jim,
>
> On 9/12/24 08:36, Jim Shu wrote:
> > Hi C=C3=A9dric,
> >
> > Thank you very much for the quick response!
> >
> > I have checked the error API again. It seems to be my porting issue of
> > set_iommu_device() callback.
>
> Are you adding support for a new IOMMU ?

Yes, I am working on RISC-V IOMMU support, based on Zhenzhong's
iommufd nesting series [1] and RISC-V IOMMU patch v7.
[1] https://github.com/yiliu1765/qemu/commits/zhenzhong/iommufd_nesting_rfc=
v2

>
> > I think "pci_device_set_iommu_device(..., *errp)" should set 'errp' if
> > this function returns false, right?
>
> yes, this is a requirement for routines using an Error parameter.
> You can take a look at the "=3D Rules =3D" section in include/qapi/error.=
h
> for more info.

Thanks for the information! I will take a look.

>
> Thanks,
>
> C.
>

