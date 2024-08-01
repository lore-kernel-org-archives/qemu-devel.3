Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E89BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 03:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZMFK-0001QK-FB; Wed, 31 Jul 2024 23:12:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMFI-0001OC-OB
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:12:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sZMFG-00014N-Uq
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 23:12:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722481969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D7AlDUN6nl/SKMwnnn5iGJ6hY5cYu+29jn1yx4r42g4=;
 b=d7kUDhEiDx4vAJAm3iTkyawDaBDMDMc4eEvT+B3ecP3GvuMcjtG1T8sGqbE0rdahbaoUri
 FoKK+0qA6NKPnH5RSSJ7DBO85N4X9y1hV54R8A0EvdpdW+roWeqsnd3yxxzZX7EA52QKzZ
 l846GXyKP0lTxbOXn5DRtZF5+d1PNIA=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-K33qwyXCPD-aS6WX9fUXIg-1; Wed, 31 Jul 2024 23:12:46 -0400
X-MC-Unique: K33qwyXCPD-aS6WX9fUXIg-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-664fc7c4e51so121878907b3.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 20:12:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722481965; x=1723086765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D7AlDUN6nl/SKMwnnn5iGJ6hY5cYu+29jn1yx4r42g4=;
 b=dVxWPIJ1l2mWsZGP/a9a5VFQZUs8ykkJi7aYtTqRwq3Tk5fhq7Ym9/oOfJnG/KlyoE
 oSe42eZbYxvuM6cuD0rHqyCLOBLLfdAVP2CXjZyBVSdc8jl55DSIbJyUCDV+ddf1mm2K
 f6zHfKFTZFn3hjClf90AK+WGKwdi6yatrWl/2MbFcFrx589fsifs2AinZJsBdZk7k6Mn
 g/Re5ofX2RZ12vXw3GFFt9UnfQxOyzppfqFd6i1/8Ae3C9+t/C3D3SltKhEUbL6kmDdz
 MmN/hhvNPpHImx9skIQilqfMq7FhddyuRtjLNRflVuMJm3vSloZoAZViTS54T+S8xEB+
 jGYQ==
X-Gm-Message-State: AOJu0YxnLz2nl6vfevi1TZwc8Y+2cD+vxb3n4L0tuRfwx3E3qVjJlVrW
 rG/EwEDTzfhAy5mgCjZQH6oS0HUj4UoPTCezplLATDVRuBF+2Q5MbtUbVlAXxAzdgIQcmtSYCI8
 gOzNTj3Kj24dWz5e4u2BVTAJ8NxqfhG9Zc+ppqsXYg//Gw0rnlFER8bK9+zKiSKloIcaQsFi1B7
 XMi6t1yt4wGsa9IDT2tlYtQ2nMXOo=
X-Received: by 2002:a0d:f585:0:b0:64a:7d9b:934 with SMTP id
 00721157ae682-6874d2e3abamr4444157b3.16.1722481965505; 
 Wed, 31 Jul 2024 20:12:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAtv7kCWV3oVHIdQcaCXNmd2TKjKkFdRj11szEZCl3bJFmCFQcKkRHN7vjCjvo+95JppXOHh/yFFds3bIY3LA=
X-Received: by 2002:a0d:f585:0:b0:64a:7d9b:934 with SMTP id
 00721157ae682-6874d2e3abamr4443887b3.16.1722481965238; Wed, 31 Jul 2024
 20:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-7-crosa@redhat.com>
 <ZqdzqnpKja7Xo-Yc@redhat.com>
In-Reply-To: <ZqdzqnpKja7Xo-Yc@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Wed, 31 Jul 2024 23:12:34 -0400
Message-ID: <CA+bd_6JjpHe=DJZMJb7x-bu_-i8X2Z4LCuk-Mz-2_LbqtUKYNQ@mail.gmail.com>
Subject: Re: [PATCH 06/13] tests/avocado: use more distinct names for assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Mon, Jul 29, 2024 at 6:49=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Jul 26, 2024 at 09:44:31AM -0400, Cleber Rosa wrote:
> > Avocado's asset system will deposit files in a cache organized either
> > by their original location (the URI) or by their names.  Because the
> > cache (and the "by_name" sub directory) is common across tests, it's a
> > good idea to make these names as distinct as possible.
> >
> > This avoid name clashes, which makes future Avocado runs to attempt to
> > redownload the assets with the same name, but from the different
> > locations they actually are from.  This causes cache misses, extra
> > downloads, and possibly canceled tests.
> >
> > Signed-off-by: Cleber Rosa <crosa@redhat.com>
> > ---
> >  tests/avocado/kvm_xen_guest.py  | 3 ++-
> >  tests/avocado/netdev-ethtool.py | 3 ++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_gue=
st.py
> > index f8cb458d5d..318fadebc3 100644
> > --- a/tests/avocado/kvm_xen_guest.py
> > +++ b/tests/avocado/kvm_xen_guest.py
> > @@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
> >          url =3D base_url + name
> >          # use explicit name rather than failing to neatly parse the
> >          # URL into a unique one
> > -        return self.fetch_asset(name=3Dname, locations=3D(url), asset_=
hash=3Dsha1)
> > +        return self.fetch_asset(name=3Df"qemu-kvm-xen-guest-{name}",
> > +                                locations=3D(url), asset_hash=3Dsha1)
>
> Why do we need to pass a name here at all ? I see the comment here
> but it isn't very clear about what the problem is. It just feels
> wrong to be creating ourselves uniqueness naming problems, when we
> have a nicely unique URL, and that cached URL can be shared across
> tests, where as the custom names added by this patch are forcing
> no-caching of the same URL between tests.
>

Now with your comment, I do agree that this adds some unneeded
maintenance burden indeed.  Also, this was part of my pre-avocado bump
patches that would work around issues present in < 103.0.  But let me
give the complete answer.

Under 88.1 the "uniqueness" of the URL did not consider the query
parameters in the URL.  So, under 88.1:

   avocado.utils.asset.Asset(name=3D'bzImage',
locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?path=
=3D%2Fkvm-xen-guest&files=3DbzImage',
...)
   avocado.utils.asset.Asset(name=3D'bzImage',
locations=3D['https://fileserver.linaro.org/s/kE4nCFLdQcoBF9t/download?path=
=3D%2Fnetdev-ethtool&files=3DbzImage',
...)

Would save content to the same location:
/tmp/cache_old/by_location/2a8ecd750eb952504ad96b89576207afe1be6a8f/downloa=
d.

This is no longer the case on 103.0 (actually since 92.0), the
contents of those exact assets would be saved to
'/by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fkvm-xen-gu=
est&files=3DbzImage'
and /by_location/415c998a0061347e5115da53d57ea92c908a2e7f/path=3D%2Fnetdev-=
ethtool&files=3DbzImage'.

I personally don't like having the files named, although uniquely,
after the query parameters.  But, If this doesn't bother others more
than the maintenance burden, and Avocado version bump is applied, this
patch can be dropped.


