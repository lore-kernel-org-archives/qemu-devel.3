Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959D6C5478C
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 18:01:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZrB-00019w-UM; Fri, 23 Feb 2024 13:01:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdZeP-0006yG-KS
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:47:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rdZeN-0005An-Rp
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 12:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708710473;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7cvdgryGcHw2BgFEqhrc3X4HJjtp4nyyGuI0Ti03T4w=;
 b=VFYl/fECwV7/nW1HVdG7XJXBsQFu0mrU9eNs60OooZ2VRrBTgvAC1ti636An1AvrRHS2nR
 4/WbusOL20h8i23haGK6SnIKuOkPBwhJOxL44rm8joiOLjYdMUGZryTuLSI6A+7Lp4Zfp4
 Dq40dHfVSPpUMJhiM03EOjx6IcN6f3E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-oNOjBb1wOBmbb0b3B8G1TA-1; Fri, 23 Feb 2024 12:47:52 -0500
X-MC-Unique: oNOjBb1wOBmbb0b3B8G1TA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-412892aff01so5796105e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 09:47:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708710471; x=1709315271;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7cvdgryGcHw2BgFEqhrc3X4HJjtp4nyyGuI0Ti03T4w=;
 b=ahPCGkwuTM8PiKwukNOmPFBS3OwwlczW9hD5yZTXHOncMyOFoWUW4TB6Jt9FvN4dTf
 SlUAnmnbDQ7lfKQUYn+/ge1kIsSdzA4hCKxpwjozUlV0ixIvSGXvqv9A3sNy2kToV2bX
 +CUErtVrHjebqgPcJrIxKZaZH9NUJtFce1hIxrjPXFn3sNshb1WtlYTUOju/0d2RT/qe
 LxM5ApwLCbPaAo8X1OVn+a8+tHEVWHQ+ogUgsMBHPcBYbJ9Z+2tanGEwyseXwfNkpFFW
 gwG6pb+p6K97M8+kZHqg7/KXXURaeuwYBFOx7YN2wu/VRwnCcRmEbMx5Y9KXiaHkpj3z
 N9mw==
X-Gm-Message-State: AOJu0YwOCzlbIyplbgWWjN29TZgtMw1cQCCvIJP86/v1zm6kWZP5FpbL
 dNsp75HkSbEUtRfhma+s+otdFyYIRAUTXzexLFrLtNZJ6nkTPktqT+aa1M1VteUJrFtDCbO5qbj
 8mHJGe+I9M0iMXuIvocYVmYuJjQ1Bu9SzjMMp9Jgh3sDodIfhJq8MlRup6pItMOtdv7C0v3CmHZ
 EQOBSu6Gqn2vrZdHeh8Ev9r67DFHM=
X-Received: by 2002:a05:600c:4202:b0:411:e2bf:73b9 with SMTP id
 x2-20020a05600c420200b00411e2bf73b9mr303055wmh.39.1708710470884; 
 Fri, 23 Feb 2024 09:47:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE52zYJZb5if7DcOne5Hl8fzAGvYzllx96CoMej6OXSHwkLpzPh8P05+eMB4HwNU24zPbLqNYljpNPsnB6VHJg=
X-Received: by 2002:a05:600c:4202:b0:411:e2bf:73b9 with SMTP id
 x2-20020a05600c420200b00411e2bf73b9mr303049wmh.39.1708710470591; Fri, 23 Feb
 2024 09:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20240223124406.234509-1-pbonzini@redhat.com>
 <20240223124406.234509-8-pbonzini@redhat.com>
 <8341e152-1002-4350-8f23-2ab80ed253eb@linaro.org>
In-Reply-To: <8341e152-1002-4350-8f23-2ab80ed253eb@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 18:47:38 +0100
Message-ID: <CABgObfYvHf6U18rYuwvmv263qh0DZ5R_6okCrrsEjF8BcSiANw@mail.gmail.com>
Subject: Re: [PATCH 07/10] pseries: do not require CONFIG_USB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, balaton@eik.bme.hu, qemu-ppc <qemu-ppc@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.066,
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

On Fri, Feb 23, 2024 at 6:33=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 23/2/24 13:44, Paolo Bonzini wrote:
> > With --without-default-devices it is possible to build a binary that
> > does not include any USB host controller and therefore that does not
> > include the code guarded by CONFIG_USB.  While the simpler creation
> > functions such as usb_create_simple can be inlined, this is not true
> > of usb_bus_find().  Remove it, replacing it with a search of the single
> > USB bus on the machine.
> >
> > Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >   hw/ppc/spapr.c | 7 +++----
> >   hw/ppc/Kconfig | 1 +
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0d72d286d80..44d339982da 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3024,10 +3024,9 @@ static void spapr_machine_init(MachineState *mac=
hine)
> >           }
> >
> >           if (has_vga) {
>
> Pre-existing, don't we want defaults_enabled() instead of has_vga here?

Yeah, but I am not sure it can be changed since pseries machine types
are versioned.

Paolo


