Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C09C54788
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 15:49:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdBJy-000069-Dv; Thu, 22 Feb 2024 10:49:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rdBJw-00005g-BG
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1rdBJu-0004Nz-CD
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 10:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708616948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pBPvmjsi3WuqvgxDx1d1tvVvUYibw1xXc9KwI4a/JCo=;
 b=E2pVo1QL2kaDGUgWHhpCnuu3IdUay7s8e6WzV+QzDivLfMjRovbQKoDkHrQKIEyFXwmypa
 WnNqu5La0v/eZ/R9Gy3ajVhBplkKnx+O30EpgMztTRaZSsHsvMNV3ysKePREgfE6P/vGfF
 QiEW7TxkQoxbbRPTkUGE0jVcVHFqE20=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-zwAyBHo4P_e6pmtuPdy92w-1; Thu, 22 Feb 2024 10:49:06 -0500
X-MC-Unique: zwAyBHo4P_e6pmtuPdy92w-1
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-47044dcf889so1154485137.3
 for <qemu-devel@nongnu.org>; Thu, 22 Feb 2024 07:49:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708616946; x=1709221746;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=pBPvmjsi3WuqvgxDx1d1tvVvUYibw1xXc9KwI4a/JCo=;
 b=vYkTVrKNc/SJAGSH4w/3Rwh5UJePhz26r4JxlbEpSa9eeBVsPazf7jRxyX21nq/Ky0
 PmtGL9nQDAW4eCqlXeRsBP7fhrcBum8+FYY60m3vULI/b9WycOTT5X+EbCkpR5cSWuOr
 FdI17VKuQLbqf/FEz5CtJhXnlepIh2zIFaHLpjeMelvRSU3Xs0f5yFv4w3hfy48WMEH/
 vUg/qreOmnbLvUjZ0OcmTPOSeeIMNtRtt94qFksmhebEGWPfpEU410umoSZ0FEnrskyP
 p9QYNV+Q1Cp42Cc1LbdUzZCBWsBy9Jx4h65InilKk397ySMp0y6JTxXGBuCHSM550Ifm
 xEpw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYGPdH7tnIpcxqsdqh6RWn75kMlWu43ZfiH3a2xtT5L/yJi6k4gnF26OFxgoTchafH+CacZDB3YDVt8cJD789OI9tvBaQ=
X-Gm-Message-State: AOJu0YyNR6ImZet4ZnYQUQ6/EfwdogFyf6QoJmAKSTscFpsgUIHfT+o5
 J0vUCiTbPpUOhACwdcKtO/eNmM79oBi6/n9BsKOtkSViRrylxcjtOIyskO/EhtiMHjX9h4Oxz7K
 UoV23FhBDn4fkVSDbpD28y9AWEjI3eM+hAJdTWpFkHD20LhU7WojSQufipEhOvCspjnZNnt5mfK
 lCiVjEDhnOhdiuRgimiAH4NK8qJPs=
X-Received: by 2002:a05:6102:11e5:b0:471:c452:8609 with SMTP id
 e5-20020a05610211e500b00471c4528609mr567719vsg.13.1708616946144; 
 Thu, 22 Feb 2024 07:49:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGmKpgb1DZ/lyF2AQXFYd/fLR9qEPP2r7KmF8UcqJbvNW83lVJnGl8iSlJtd3Elehs2YyjJXMjhdwRUoKPQ8c=
X-Received: by 2002:a05:6102:11e5:b0:471:c452:8609 with SMTP id
 e5-20020a05610211e500b00471c4528609mr567703vsg.13.1708616945789; Thu, 22 Feb
 2024 07:49:05 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 22 Feb 2024 07:49:04 -0800
From: Andrea Bolognani <abologna@redhat.com>
References: <cover.1708336919.git.lixianglai@loongson.cn>
 <0bd892aa9b88e0f4cc904cb70efd0251fc1cde29.1708336919.git.lixianglai@loongson.cn>
 <582cb02c-9778-46af-97d3-5b248b30b02e@linaro.org>
MIME-Version: 1.0
In-Reply-To: <582cb02c-9778-46af-97d3-5b248b30b02e@linaro.org>
Date: Thu, 22 Feb 2024 07:49:04 -0800
Message-ID: <CABJz62ML+ye=mwX2vfZJG==TOHLyLoFMGZaAvTS36Dcax8jcaA@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] loongarch: Change the UEFI loading mode to
 loongarch
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Xianglai Li <lixianglai@loongson.cn>, qemu-devel@nongnu.org,
 maobibo@loongson.cn, 
 Song Gao <gaosong@loongson.cn>, zhaotianrui@loongson.cn, 
 Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.002,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 04:10:20PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> On 19/2/24 11:34, Xianglai Li wrote:
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
>
> This is unfortunate, since LoongArch was a fresh new target added,
> we had the possibility to make this right. Are you saying libvirt
> didn't accept to add support for the correct HW behavior which is
> to simply load a ROM instead of a PNOR flash device? Could you
> point me to the libvirt discussion please? libvirt is very good at
> supporting a broad range of legacy options, so I'm surprise 'Doing
> The Right Thing' is too costly.
>
> What is really the problem here, is it your use of the the -bios
> CLI option?

Hi Philippe,

the thread is here:

  https://lists.libvirt.org/archives/list/devel@lists.libvirt.org/thread/7P=
V3IXWNX3UXQN2BNV5UA5ASVXNVOQIF/

Unfortunately hyperkitty makes it impossible to link to a subthread
directly, so you're going to have to scroll around. The relevant part
of the discussion happens entirely as reply to the cover letter.

You were actually CC'd to that subthread right after my first reply,
so you should be able to find the relevant messages locally as well,
which is probably going to be more convenient.

In short, the discussion is similar to the one we had a while ago
about RISC-V, and my argument in favor of this change is largely the
same: barring exceptional circumstances, the overall (maintenance,
cognitive) cost of straying from the established norm, now spanning
three existing architectures, likely outweighs the benefits.

--=20
Andrea Bolognani / Red Hat / Virtualization


