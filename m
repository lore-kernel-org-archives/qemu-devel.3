Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6178BC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaTO-0003WQ-VV; Tue, 19 Mar 2024 10:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmaTE-0003G9-DA
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rmaT8-00079n-To
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:29:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710858571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ec7NB2+MiS/DMWbVRGMZXRvjrpRY3OTt7saiH+5YDk4=;
 b=dwgbEGCSIdBEcgkXBjf4PwPnQWsCH2EVHsl2LvX6GP24bwZu/RC+MGuDlRHmn6mBrzvdbu
 fxqk25ndpdkBJ+7XND+YD2/ZPscuSmC+HgXZy+ssvH71ZwxHhc17nfqlWdBb3ioE+B7D2c
 Q358zm7Ounro9hMU/9QXgaooXh5Bf2E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-Sh7sD5pzMOiUmkUpJasnAQ-1; Tue, 19 Mar 2024 10:29:29 -0400
X-MC-Unique: Sh7sD5pzMOiUmkUpJasnAQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ed44854ddso1772259f8f.2
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858567; x=1711463367;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ec7NB2+MiS/DMWbVRGMZXRvjrpRY3OTt7saiH+5YDk4=;
 b=os06FPsN9O1xkeIJYl/S5T5ILpa/Sx9+UHtCLAUKrKEtNtmGOmgBuWroE+9kv+R77l
 D1DNR80VCGEaUNATUU1PZfeE+zS0Cs6H1ZbR0Pl5zhF8CM93AmWM4jDbZ2CRBMyRzlzp
 WxhqRJniDjFgEvMiCTbWJp1+Lluej6Nty+lscdw5+Z1EfyvopkQZMGJ2X/c33ciaztif
 AKJo7sCAON9Dz6lTO72d3mb0DDOnJnyoSn5bdh9OuI888nZwOcd4RoQCZWgx4bu6V32r
 1rJn9JeXLb9OaPSG+zEfX3Qluol+JVFJtiGGJIeEV/XMmZcZrY5yFkAvoXpr1nHv6rKY
 szOg==
X-Gm-Message-State: AOJu0Yz/mzk4E/vN1hYZBIVJHRi9il8Rf493y/lDiAWnyRYkHoO3/qyE
 gKroM4kW4B//4I8B9hhc/gNWWFacmvEI6o3+y7b2JH5Pc+RkG9eGyJlPzk6TSMPVj4/DMx2w5QG
 L1intG8fJ2KVqiMZmyZdM0UBKsEvSHlmZkufBxi2w+exWgYnHYuFh4UGNYNPS8hYHjNuH2U2Fm3
 9UkREjjT1ScfuYjmV9UoTcO07uXTkYUVxOlKHXGQ==
X-Received: by 2002:a05:6000:1805:b0:33e:5310:820f with SMTP id
 m5-20020a056000180500b0033e5310820fmr2012763wrh.67.1710858567384; 
 Tue, 19 Mar 2024 07:29:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+ECSOIkAiAsV0kIfj/almq4cAaxqhVJ9G0yu3y3msTgWA06CRmHGV3rfG31H5b/gw0HqrafTbcHdebFRkZdI=
X-Received: by 2002:a05:6000:1805:b0:33e:5310:820f with SMTP id
 m5-20020a056000180500b0033e5310820fmr2012746wrh.67.1710858567064; Tue, 19 Mar
 2024 07:29:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240319140000.1014247-1-pbonzini@redhat.com>
 <20240319140000.1014247-7-pbonzini@redhat.com>
 <Zfmd55tus3nV5DJV@redhat.com>
 <CABgObfZ7ikZHG3EEQHoPKoMo+1JpF6Ntb_QXsYTgEw6zF1zXmQ@mail.gmail.com>
 <ZfmgybXHbCTbisum@redhat.com>
In-Reply-To: <ZfmgybXHbCTbisum@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Mar 2024 15:29:14 +0100
Message-ID: <CABgObfaKe=EE0N6YHTqpaoK-LaACpzSWykWB+mo=_KDMCnFd1Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/i386: Implement mc->kvm_type() to get VM type
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xiaoyao.li@intel.com, michael.roth@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

On Tue, Mar 19, 2024 at 3:27=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Tue, Mar 19, 2024 at 03:25:53PM +0100, Paolo Bonzini wrote:
> > On Tue, Mar 19, 2024 at 3:15=E2=80=AFPM Daniel P. Berrang=C3=A9 <berran=
ge@redhat.com> wrote:
> > > > +int kvm_get_vm_type(MachineState *ms, const char *vm_type)
> > >
> > > The 'vm_type' parameter is never used here. What value is it expected
> > > to have, and should be diagnosing an error if some unexpected value
> > > is provided.
> >
> > It's the value of the kvm-type machine property, if any; but no x86
> > machine defines one, so right now it's always NULL. I left it in
> > because then it's clearer than this is an implementation of
> > mc->kvm_type, but I can remove it or pass it down to
> > x86_confidential_guest_kvm_type().
>
> If we expect it to always be NULL, lets validate that is the
> case and error_report + exit, if not.

I think it's enough to have an assertion in x86_kvm_type():

    /*
     * No x86 machine has a kvm-type property.  If one is added that has
     * it, it should call kvm_get_vm_type() directly or not use it at all.
     */
    assert(vm_type =3D=3D NULL);

Paolo


