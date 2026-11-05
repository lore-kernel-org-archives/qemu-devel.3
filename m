Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31271606A33E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFC/eao+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOvWT-0003P7-D1; Thu, 05 Nov 2026 06:20:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOvWO-0003Lg-4O
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:20:44 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xOvWM-00037f-8u
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 06:20:43 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6b4f7d3cd98so2052679a12.0
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 03:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877641; cv=none;
 d=google.com; s=arc-20260327;
 b=nzNGJDpJlNsGmMiyvbH+y21sYhsvhf2hbkbi0g8fLnRWazo1CsyrIKKqHhMCDXKJMV
 I3UMEDrqSpPx+U+eUdABGkDFo9f74mt3aRCAJctmnQlTpjaKNcEmS9hYT0DrlO5r/Q5Q
 4DQILwmXj/7WawDvkxbjYTmQH8mUpF+wc+Wzh7KvZHGQv+uEyM9oopULDYMA0h5XcPDG
 CErb4aQJKc+JwdC04chXd89mfIOUq/IIq56dy7nvEIPpBtSedxuJppWT+h2jb2vhOHyt
 HxYm5gDQIupAm+ufDYYbIOHOHYrH/MDMytgJV3MEqOuxveMvs2l7byfQ4oa438Y7d5xH
 I/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=PlNb1BYPWHkmMzUQSlxQ2cyH6wtWvDkLLKaViisxyso=;
 fh=Opyu6zz72KvkUOOBDEfhVcLqIpwIfdca/LhqIasCHqI=;
 b=n+r5z7CSGBb5WY5gcaCYCKqZgdmO/VSxGmtIwT/wujMR7y4b937tG/KBIa3cdyykp2
 f1o52tTRVuH8NrMOE7QHxt1YhCKh20Cg9vSIEQwYNrL5t6WszwPqpiHdvtgTjTDPwZLS
 Sj6TSD7iEGqXbxSXB2TPRla4xR11XtEOn2AStg+X5M4aeDsJ/jBo7P0AJ1sRUWccFzUB
 26moUw2HbW/0heKnCyEHSiAhCpxNZOUIwlSBM9HE70NtGYOaK3z+84dRlfMoCcowJHX3
 BX0zLOYDqlNltxXG84sASvC9Rxw0V985MeD9F9GHVdi1dKrbwFAK33GP10MUaYcuDTjB
 Uq3Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793877641; x=1794482441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=PlNb1BYPWHkmMzUQSlxQ2cyH6wtWvDkLLKaViisxyso=;
 b=eFC/eao+2kJXZNENSO03FQG1Vei22tv+e4BlLIyvWZ4PwOr9+Rr6nwU6OgQY4KKu/Q
 xWxI1VR11zDs7H94itPnKqyeTp2/u7je75n65PTuiETwqUww3mMegtEYRTHLM/L0J4Lu
 RH8Ku29jE2P3uHFOZfwP1H6taz9uvFIuVsNvGd5L2INYiBEUl+UOTLUgl7S1+DJv83/C
 ICr5dFR9ONYqqQ8yI8JVroUo4CJo80HUw+JjXzqvFwexHy3d5cKiea1zlTUGJlFjwHVN
 FNFhAlAdtv8K9yDqMsIMpebi4lyfK+TbkQXX28kWbIHHkFIfE9071ZLbjJVtkKApW7vy
 2QJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877641; x=1794482441;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PlNb1BYPWHkmMzUQSlxQ2cyH6wtWvDkLLKaViisxyso=;
 b=RxmunN0mMXuIM3cj6adSOGGfx0D3jbfCVmehVNv15F9Wl1242oUtEjg2kOBEjplmmR
 boTKa99yzdzicCxBETKUbbl5CWJSLu3Mrd1ZWpg40SxZ5B+1jSC0K94F26lH4NEGqPBQ
 E6Mj5fQEWVvI5QpgikvncicJlqx6R8bP9+hOn3Ru11/16lYEzGm/lqhVCfWrx5eR5YPD
 AGxLiDLogyF2Ae04gd0GvinfWsfVKqZtedlGn1RqfnouG8WC4Qt0WoCm48/gUriXAXds
 ttWGd4pO/j44IMymQlsp4EZOk/nTsm2AydIW9D+8at+TPSRQ/T8eyrZejIj3o3UaJh/C
 /klQ==
X-Gm-Message-State: APuU4Z8se32X1O4vEvC1PKgv9oOfV8MdKJkZ9BKdEip6Kpgu+qg1byrH
 5Nw6rC18NHOP/wCv+zvelMkgmJubQ5jj570rwPW3rp9b5HK6JR2faQ+ouFF55BfDsueGWQ8CHZ9
 A2UJvCySEIDyAxwWhkrC3+OfcxdnQOMI=
X-Gm-Gg: AYBFou3PZJlFLenBz2lyTL22JGp25wsuJ//W/aW/R3YSg2wh8QPWVPC3tuh7Xj6Th0S
 VDOIQc1FFW1j05d5TK38HBowxVwBVadui0y1wjc1pyIHkuUr/TkfdY4kT2tkfzW+D7Akhkx7xs4
 tzkjOzFD9mL+/kSTwLWJ7gbbMVVVC6ii3hUl0LHrdNYwW8GeftXN5YKiPXAdhzvBFPpw3sDhyFw
 VGvJo3Ml9vu0hisSRiMMxjvFX14GBRqEUVTgjc8l3aLl4ju1hV7AGUwMXVxt4O5tZksBiyGffZE
 L9ispEUEMn0UkeNEHRU05X5/Oz+2zVucGjoTfgtNpipnm3nMrNh645bDFuKaj4e5q3i/gOmbmQx
 kUXGK6k3YFlL31iFu/iebdaRuNiX4pzPj7LYXJghrUXlsrkezEidrfY+/bw==
X-Received: by 2002:a05:6402:13c2:b0:6b4:20bc:f97 with SMTP id
 4fb4d7f45d1cf-6b4d4687f36mr12944657a12.9.1793877640500; Thu, 05 Nov 2026
 03:20:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261031164009.2048-1-luoyonggang@gmail.com>
 <20261031164009.2048-10-luoyonggang@gmail.com>
 <auxigHswmymEQogo@redhat.com>
In-Reply-To: <auxigHswmymEQogo@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Thu, 5 Nov 2026 19:20:27 +0800
X-Gm-Features: AclHuK8JaCBfq2iHM6_gWbf_I2SMsgzy25i8IgvXVSDpbsJRrDcKVJDcV5gKWqs
Message-ID: <CAE2XoE86xX=Vzb9K-qREB+zSosq1SiZvbgV_5TaOGTC-XEp3ng@mail.gmail.com>
Subject: Re: [PATCH v2 09/12] hw/virtio: register s390x virtio-blk-pci and
 virtio-net-pci variants
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Song Gao <17746591750@163.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, 
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Eric Farman <farman@linux.ibm.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 5, 2026 at 7:03=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com> wrote:
>
> On Sun, Nov 01, 2026 at 12:40:04AM +0800, Yonggang Luo wrote:
> > virtio-blk-pci and virtio-net-pci added the s390x loadparm property
> > from class_init when target_s390x() was true. Register each
> > VirtioPCIDeviceTypeInfo twice. The s390x variant calls
> > pci_qdev_property_add_specifics(), which now always adds loadparm,
> > and the other variant does not. target_s390x() and target_not_s390x() s=
elect
> > the two.
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  hw/pci/pci.c               | 13 +++++--------
> >  hw/virtio/virtio-blk-pci.c | 27 ++++++++++++++++++++++++++-
> >  hw/virtio/virtio-net-pci.c | 27 ++++++++++++++++++++++++++-
> >  3 files changed, 57 insertions(+), 10 deletions(-)
> >
> > diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> > index 2d2fe02c68e..b5ea0b049aa 100644
> > --- a/hw/pci/pci.c
> > +++ b/hw/pci/pci.c
> > @@ -2901,14 +2901,11 @@ void pci_qdev_property_add_specifics(DeviceClas=
s *dc)
> >  {
> >      ObjectClass *oc =3D OBJECT_CLASS(dc);
> >
> > -    /* The loadparm property is only supported on s390x */
> > -    if (target_s390x()) {
> > -        object_class_property_add_str(oc, "loadparm",
> > -                                      pci_qdev_property_get_loadparm,
> > -                                      pci_qdev_property_set_loadparm);
> > -        object_class_property_set_description(oc, "loadparm",
> > -                                              "load parameter (s390x o=
nly)");
> > -    }
> > +    object_class_property_add_str(oc, "loadparm",
> > +                                  pci_qdev_property_get_loadparm,
> > +                                  pci_qdev_property_set_loadparm);
> > +    object_class_property_set_description(oc, "loadparm",
> > +                                          "load parameter (s390x only)=
");
> >  }
> >
> >  MemoryRegion *pci_address_space(PCIDevice *dev)
>
> Again this is the only bit that we need IMHO, as it is harmless to
> register these properties unconditionally.

Hi that's the first choice of mine, I have did it a long ago

https://patchew.org/QEMU/20261013200525.1340-1-luoyonggang@gmail.com/

>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

