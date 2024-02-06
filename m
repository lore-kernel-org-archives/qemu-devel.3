Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0653C48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 19:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXQqG-0004y8-Ed; Tue, 06 Feb 2024 14:10:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rXQqC-0004xt-Rp
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:10:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rXQq9-0001lQ-9C
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 14:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707246640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eyy/9fcldwhZTli69VbVGu6UmdnuSvITSI+WDrjc5O8=;
 b=J5LacTO0H3o72/BxeQu2G5NiilYfn8Df1jBIcd2lyFBFH/7kmabAg2ggXTaGC2FxgyOEo4
 +bBGg0Iins8BB14T5X+YnvHpIwaxaDxcQyhUTluW+EbeNDkrbtbXYak7Mo7K4Oj24UvwdD
 VGZoA3f2iXy+j1FnvmhFZ/aak4omS4E=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-T3d33ox5PpKx3vTP98r7pA-1; Tue, 06 Feb 2024 14:10:39 -0500
X-MC-Unique: T3d33ox5PpKx3vTP98r7pA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6e12d627a00so5800628a34.2
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 11:10:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707246638; x=1707851438;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Eyy/9fcldwhZTli69VbVGu6UmdnuSvITSI+WDrjc5O8=;
 b=IJJ+wlPq1H0qzUmZ0lQgd/PGpTupjkTUsBba7jNESWKuHzvn9I4C/8R1XAriKc1kZn
 hnFsbDp/rRRwcBmeTn+CiG1E9TDQd/Zr7CYTK2/GriuaZbE/4Kg8LDWT8BWQ5rPhKHCg
 LB3zDo0ms/n7CI+9DsSRxCxWbXIYqA0kq0L/k/cx6S07mpQejaRSzVVDcnQO/VnKJNRU
 vbkoZR5tRcKrzqmsi+Fp9E8QV6tqOzP/JFdolqriMZVwKl0ovC449d92GGMuL47k24JN
 s344aRUx6B4BkfoZ29TJOcj3eNgA+clnonZ9B9UV0i+74DMVajbZMZb7LduvipeJyjGt
 5Sog==
X-Gm-Message-State: AOJu0YzmjhOESW/5vxr8eLA4D682Eiq8dWB/hAT1pX5q10/OSX0vUjPW
 2IdSQhLrHv/b/+o/3BjnkOoVA1KqtdvwPEinbPV1tYsm0IcJnc5qVcw8E6UCZJ63vVNtw5H/By1
 3wsUOEyB+ygC2JytS9XbDOyK56ue+oTkH5R/sl748da1HmbQKJ59YvYMYvVKHFwH+m4NZbAHiQK
 4NWuGnWMDr8eCEwpYiuaaRucJ9B0c=
X-Received: by 2002:a05:6808:310:b0:3bf:d282:c89 with SMTP id
 i16-20020a056808031000b003bfd2820c89mr3528565oie.16.1707246638346; 
 Tue, 06 Feb 2024 11:10:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEShF/Mvsb/QU1bg3SlzaEtK6duZytXARfGemJw2FrJEhSoPamZhzIg9myeEzRgpNeGe7qPvIi43W+BwslJhJI=
X-Received: by 2002:a05:6808:310:b0:3bf:d282:c89 with SMTP id
 i16-20020a056808031000b003bfd2820c89mr3528556oie.16.1707246638130; Tue, 06
 Feb 2024 11:10:38 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 6 Feb 2024 11:10:36 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <20240206021002.208805-1-lixianglai@loongson.cn>
 <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABJz62MEUeWw2pL9TYKxD8E2qWOrzPegCbRVaAd0P+0=5_46mQ@mail.gmail.com>
Date: Tue, 6 Feb 2024 11:10:36 -0800
Message-ID: <CABJz62Pgp07EAgyTy1p5fGEZnTFA2byEn94_c+NQR5ELO3z7nw@mail.gmail.com>
Subject: Re: Re: [PATCH V2] loongarch: Change the UEFI loading mode to
 loongarch
To: Xianglai Li <lixianglai@loongson.cn>
Cc: qemu-devel@nongnu.org, maobibo@loongson.cn, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_SORBS_WEB=1.5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, Feb 06, 2024 at 05:38:35AM -0800, Andrea Bolognani wrote:
> On Tue, Feb 06, 2024 at 10:10:02AM +0800, Xianglai Li wrote:
> > The UEFI loading mode in loongarch is very different
> > from that in other architectures:loongarch's UEFI code
> > is in rom, while other architectures' UEFI code is in flash.
> >
> > loongarch UEFI can be loaded as follows:
> > -machine virt,pflash=3Dpflash0-format
> > -bios ./QEMU_EFI.fd
> >
> > Other architectures load UEFI using the following methods:
> > -machine virt,pflash0=3Dpflash0-format,pflash1=3Dpflash1-format
> >
> > loongarch's UEFI loading method makes qemu and libvirt incompatible
> > when using NVRAM, and the cost of loongarch's current loading method
> > far outweighs the benefits, so we decided to use the same UEFI loading
> > scheme as other architectures.
> >
> > Cc: Andrea Bolognani <abologna@redhat.com>
> > Cc: maobibo@loongson.cn
> > Cc: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Cc: Song Gao <gaosong@loongson.cn>
> > Cc: zhaotianrui@loongson.cn
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > ---
> >  hw/loongarch/acpi-build.c   |  29 +++++++++--
> >  hw/loongarch/virt.c         | 101 ++++++++++++++++++++++++++----------
> >  include/hw/loongarch/virt.h |  10 ++--
> >  3 files changed, 107 insertions(+), 33 deletions(-)
>
> For future reference, it's usually good practice to keep track of
> changes between subsequent versions of the same patchset.
>
> Can you please confirm that the build of edk2 added with [1] is
> intended to work with a version of QEMU that contains these changes?
> I'd like to test things out as soon as I get a moment.

I've tried it now with libvirt and everything worked just as I
expected it to, so

  Tested-by: Andrea Bolognani <abologna@redhat.com>

Were changes to edk2 necessary to make it boot from pflash instead of
rom? If so, have those patches already been posted?

--=20
Andrea Bolognani / Red Hat / Virtualization


