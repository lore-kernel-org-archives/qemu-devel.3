Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8D9C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdnx-00063w-CM; Mon, 29 Jul 2024 23:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdnu-0005xH-Fg
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sYdns-0005LF-Re
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722311136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bXJNjky8EefqMLiwUpRfOObSGdedE0BP/ZPWloO0qjA=;
 b=e9IDOCn2Iha82Cf+J4Isy3Wc1BHFCE8IqQuLLuW50OB1tit68e5hLPzS58lOZ/A3zGO/QS
 Md5k1S2yeV3R2fLkMKVZqAvKaknRbj/wV7AWVaF62GmNc8rjIJ4igY94tioGrLVIUGH1FA
 xD0EEpVvBx+qdeJi2YqZhKxUr+pm3+U=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-Tg7PxrVKNV25HXIOexYVLg-1; Mon, 29 Jul 2024 23:45:33 -0400
X-MC-Unique: Tg7PxrVKNV25HXIOexYVLg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2cb5ba80e77so5237304a91.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 20:45:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722311132; x=1722915932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bXJNjky8EefqMLiwUpRfOObSGdedE0BP/ZPWloO0qjA=;
 b=NJQoHT8/9VmqCOJs2koymbCDDngu30BJWMARDnayxSyRWu2oPy4z1iw2LPPYhIv9Mv
 8SzRQXiBB20CX4n/PLUvecYTXlNH1kueKA0YMbHP2tm/W/menUzXqu2/iJwPfx0WVLUA
 eZRWsVTqdjFi43ENSKLSWGdT0YfY7RGwoZqbOx0399wjiiZ7BQJf2WXk/ySyKrBvqasw
 yd+4yw7iMtSWeihfH6GLZ5tdktfI08Gc4RRUN2uQvULOmTBJ9OrLo2PxLS6B7o4SR18N
 Cg1GJebxe1qjiaxO2/mhGNZI2mv7oSvynq4opeG6zcdhEaBj7c5V4DLcchZBFlUpG+2E
 /bjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR0VTeWVPGnV05+AloBnYMVmoxqngTKEzOBK75iiJ+jwapRhTNcxuwErgrdKD6e+tHPE4WB/CBJ87DZ+E1XPQiZK7UfCc=
X-Gm-Message-State: AOJu0Yw6y3vC6zjQ1O3OeyAQyreNDFQlTJIAdxTwY9lSKRw/twhOVonT
 JDodkd4PAoN4tRb/4Qvwqe1MSQwi2c9tnA/uW6gL7UP1ga5XKIPRL8m7Bi/EIVddOIVlvqUFyYf
 /2xLeab3hi//8gjVZDWzmDidX0Ntl3oRZoUPVaQ/cZBASJJb68x9gpkR+KzTp5Lagz9dQUf9UQf
 XfBuPAhzVrDmOAV8LAOpMPWMX5L7I=
X-Received: by 2002:a17:90a:1c17:b0:2cb:5678:7a1c with SMTP id
 98e67ed59e1d1-2cf7e1e1e69mr11933278a91.18.1722311131986; 
 Mon, 29 Jul 2024 20:45:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGd6vw/rBrRerbfBAm+yBhRqY7rgAK5UBbOS+OQx23lyHGKA9xXIMF5+7Yitk+KRhqgZvJWmCozOiEe2YCnp8=
X-Received: by 2002:a17:90a:1c17:b0:2cb:5678:7a1c with SMTP id
 98e67ed59e1d1-2cf7e1e1e69mr11933257a91.18.1722311131530; Mon, 29 Jul 2024
 20:45:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240708092630.2596945-1-zhao1.liu@intel.com>
 <ZpdlQDIjGp4wR8aR@intel.com>
 <CACGkMEsGyKb932T_AJ63sWFObYSJRvghTYywvbDT0BpVV-c9Vw@mail.gmail.com>
 <Zqhhv3lnyMfxLCvV@intel.com>
In-Reply-To: <Zqhhv3lnyMfxLCvV@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 30 Jul 2024 11:45:20 +0800
Message-ID: <CACGkMEvSYA1bJu6bV55MauYNHhpcyTjP6DjM5ruNf87rY4FHcg@mail.gmail.com>
Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description to
 avoid short-form use
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 11:29=E2=80=AFAM Zhao Liu <zhao1.liu@intel.com> wro=
te:
>
> On Tue, Jul 30, 2024 at 10:54:07AM +0800, Jason Wang wrote:
> > Date: Tue, 30 Jul 2024 10:54:07 +0800
> > From: Jason Wang <jasowang@redhat.com>
> > Subject: Re: [PATCH] doc/net/l2tpv3: Update boolean fields' description=
 to
> >  avoid short-form use
> >
> > On Wed, Jul 17, 2024 at 2:15=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> =
wrote:
> > >
> > > Hi Jason,
> > >
> > > Just a kind ping. Does this update satisfy you?
> > > Since the original example generates the warning.
> > >
> > > Thanks,
> > > Zhao
> >
> > Queued.
> >
> > Thanks
> >
>
> Hi Jason, thank you! I noticed Michael has already helped me merge this
> (commit cb8de74ac6df "doc/net/l2tpv3: Update boolean fields' description
> to avoid short-form use").

Great, so I dropped it.

Thanks

>
> Best Regards,
> Zhao
>


