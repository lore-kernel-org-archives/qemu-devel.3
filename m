Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D661310ED64A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:11:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w655f-0004SF-RY; Fri, 27 Mar 2026 07:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w655c-0004RX-8d
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:10:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w655Z-0004Rf-Ht
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774609847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YNrQ9fGOgSEmmEXyUUUztygH9ekXzrPv1+8v7QJQS9M=;
 b=RsUWZ/NoJGGqFJ2MesGXFC2qNHHUBAETzjVd70upjLoh8EcyCzHKhhhB7TC1VAxg52A9XR
 sMIyT2Y6hyaRnv8Xk7NztqWvROPwdWwFC1hitK3XXNt5LXV97HT0lT/Cn5lcpKT++u1eaj
 e+PGnRJ6VNRIdHGY/6TgUJ2zXbtX3L8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-1zObm-RrO7yDOu-4EAhSiQ-1; Fri, 27 Mar 2026 07:10:45 -0400
X-MC-Unique: 1zObm-RrO7yDOu-4EAhSiQ-1
X-Mimecast-MFC-AGG-ID: 1zObm-RrO7yDOu-4EAhSiQ_1774609845
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89cc5305180so67262036d6.0
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 04:10:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774609845; cv=none;
 d=google.com; s=arc-20240605;
 b=GNV4Ux0eAE1crTbY8X1KfFAXkAfMU59PCU1HYWEo2IHw8FEjtLcJbIXG5fqQS+MRHC
 Fr1vcdY0nMtmt1NBTMN1jDBsL8lUG9MLyQco3s/bANWpP7QQ3jbTwH6nHf4juBVaDbZl
 /xRilE/XttGDLPFR5ZJwomJYkBBPriphBhszFBSNUZ0FR2u7FddisfVLGh/YZmntgDOj
 9ZWtUj4Nj+4TE4QfEW71JYk9UE7ecghIRB2qIIW5v6HxCwyljMf/u6rt+krsMmfQ3Ca9
 lLhWOmvLfLUuT7Wp2rG/1UqcuV+HUAz5YxduWPUB/hdzLDUpbiHzWbTKHDI5VG3Np9Zb
 1EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=YNrQ9fGOgSEmmEXyUUUztygH9ekXzrPv1+8v7QJQS9M=;
 fh=XahCUQgq1HJlyTR+xv125W3jiTsFAxTXaLVQz+UPLmY=;
 b=PDDGTvGZ8i22RIPGjo8VFpHiR+weCotsWrK4pN/dymGpaWMznHRl8YNmA2lR4hw8wH
 Bqb5mm5MLz3fxQTLBNxAgclr/qysKY1ohkKV4K002SrqlvTixz1OPrc+DwtY1yNv6V3r
 QaUQHBgNEtM2seMzHTBFuo3pybHWsvPP2WX2W2KpLIoV5NcJiqHNRuTQ1k0yrbmpUfZv
 /RPZq1QUSg3Novm7W48lP+LwkDAZsMGnrXuS5SPrYesEeiaQoHdY+6zBJ4qSnxICwS9H
 nh0W8cPj4MIui0llRfCIobhCDYEvp5SQCavG/MKZi8296KWhd6MEfrlibd1diCCrExaf
 wPjw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774609845; x=1775214645; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YNrQ9fGOgSEmmEXyUUUztygH9ekXzrPv1+8v7QJQS9M=;
 b=Mnc4o5u8AFMXpDSJI/2hvQzkCbwuVsdsM7leCNLpk6Z8QIpO9vPkyJz2w+Vl28tXOw
 wz52ytQuQC8Hlyt2gtuKKFX2sXq/gVMUXylzBQ+nutsJOSOGL3qfaApbnaRJC3KUrxJZ
 XNmhXL2wG4lSZEJthvH1qam1A8Q8ebAgyyPb4eGxg0Rty/SgrOr0U4ovz842Uo2Wb9QZ
 YIp5NJ5Tuzic7M2CR2XoAt5r5HSOQZikeBzHVPNSGH7eJcb0YJMBGxavWhz9Ckv/qgB5
 k1tCR1Ug0djpj+djo0shSUpuxfBqDO4nVQ/N7N5pB/6Zg1AWfy+8j1ui/Mlv84nx0iUn
 92Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774609845; x=1775214645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YNrQ9fGOgSEmmEXyUUUztygH9ekXzrPv1+8v7QJQS9M=;
 b=lwrLOOoej0LoycNds71k4xRJt8QF+IWehXCWwc5ZtF5GIug001SloOg4XXprMvylvC
 L0Znnldk0cSPvEhoA61aaqvcdrF7szr435suVlNj/yEzmwanfHcv2IVUCG2CcUkCuBXw
 mKtoeZNeZKBrMiz7qHWkUZHRhryu077sEjjsEr211DxKg+sAcPAMFotPoLQ4/907bNOR
 rw5FVk75VPmfFKVlMCPPNWzl5o3WCN2Rkch2IaJKR8UIle+jbjzarPoRAwHT8crI8kNu
 2uREZO0xmOhg1YLgUBdJ7gheLpLvqCPNi5kXbzT+K9NAwKkMtdG6H1N9i9J4vmCmWl7C
 dZyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbj4tk5VJhXae82PeLQOlDHhC8PsbpxJDvzChIyFwaTMahQMUE4xfvR2JZaBsYxDblsUBWewTgPWy2@nongnu.org
X-Gm-Message-State: AOJu0Yw7ekyc+Lq/L1MFzevRJu3vpD5A7t+qOJ97guPtnFAwBexqzl4g
 +7kgpjZO4LiFskltncdSfrbze2g53+wgzAbSLfUkofm6ypAuajCWKH4oSbRvmMgrA6g15fNuJw3
 iPmFDTspuEIBqAbi3wucIxqYZoTzLfad9lOOLjF4oyic6O1quWPrc9rtHDLkrp2ZiVkQK4y3E4W
 py1H89b+Z786Yh7V0Utmxo0c4k66BxwjU=
X-Gm-Gg: ATEYQzy74kMRVu49PF2YioG/JeLoX6My/aYsfDlv1y53TluYcbP6YK667CWmkOpHqHS
 OzpRcxoWotjKKheDJ7CtP8uRI6A3pfOycgVcPJqxfudB5VPl9t+4yEOle9rFRq6kofZcjkp3baD
 4eF2sxMp7Or2LVoIASqYZBbaNat/wvVpbFhpQ3JZWfkNu9Jwufw2UyVwZUV/oxG6esZfLinmkAO
 pmwQfz9
X-Received: by 2002:a05:6214:5a03:b0:89c:d50e:b57 with SMTP id
 6a1803df08f44-89ce8d98ca8mr22936176d6.15.1774609844917; 
 Fri, 27 Mar 2026 04:10:44 -0700 (PDT)
X-Received: by 2002:a05:6214:5a03:b0:89c:d50e:b57 with SMTP id
 6a1803df08f44-89ce8d98ca8mr22935766d6.15.1774609844456; Fri, 27 Mar 2026
 04:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <20260326160033.68318-8-kkostiuk@redhat.com>
 <acVonq8XqzPItFxx@redhat.com>
 <a5a61b29-adea-457d-a3e8-c62e88cf8ff6@redhat.com>
 <acZkNMFwyT6hz4-C@redhat.com>
In-Reply-To: <acZkNMFwyT6hz4-C@redhat.com>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Fri, 27 Mar 2026 13:10:24 +0200
X-Gm-Features: AQROBzDdx-Cq1pQNUbDBVwCGywhB_c4Za-LIVSpaZ0YoSXkzRu1cxgBIYht9nBw
Message-ID: <CAPMcbCo5SLnh=YV=QxE67X4wNz9UFFgR8sL13j0ODA_PPFQBtw@mail.gmail.com>
Subject: Re: [PATCH 7/7] meson: Build block_syms and qemu_syms only when
 enable_modules
To: Kevin Wolf <kwolf@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yan Vugenfirer <yvugenfi@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000064e1da064dff8dcc"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000064e1da064dff8dcc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 1:04=E2=80=AFPM Kevin Wolf <kwolf@redhat.com> wrote=
:

> Am 27.03.2026 um 11:47 hat Paolo Bonzini geschrieben:
> > On 3/26/26 18:10, Kevin Wolf wrote:
> > > Am 26.03.2026 um 17:00 hat Kostiantyn Kostiuk geschrieben:
> > > > Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> > >
> > > I'm not a meson expert, but the change itself looks ok to me.
> > >
> > > However, the commit message is definitely a bit too empty. It should
> say
> > > why you want to make this change.
> >
> > Agreed, I *think* it's because scripts/undefsym.py would immediately ex=
it
> > here:
> >
> >     if len(args) <=3D 3:
> >         sys.exit(0)
> >
> > but it should be spelled out.
>
> If that's a problem, why doesn't ./configure --disable-modules fail on
> Linux?
>

It does not fail because it exits with 0, no error.
Problem in my environment because nm is missing,
but at the same time, running undefsym when modules
are disabled has zero sense because nothing will be generated


>
> Kevin
>
>

--00000000000064e1da064dff8dcc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 27,=
 2026 at 1:04=E2=80=AFPM Kevin Wolf &lt;<a href=3D"mailto:kwolf@redhat.com"=
>kwolf@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Am 27.03.2026 um 11:47 hat Paolo Bonzini geschrieben:<br>
&gt; On 3/26/26 18:10, Kevin Wolf wrote:<br>
&gt; &gt; Am 26.03.2026 um 17:00 hat Kostiantyn Kostiuk geschrieben:<br>
&gt; &gt; &gt; Signed-off-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;<br>
&gt; &gt; <br>
&gt; &gt; I&#39;m not a meson expert, but the change itself looks ok to me.=
<br>
&gt; &gt; <br>
&gt; &gt; However, the commit message is definitely a bit too empty. It sho=
uld say<br>
&gt; &gt; why you want to make this change.<br>
&gt; <br>
&gt; Agreed, I *think* it&#39;s because scripts/undefsym.py would immediate=
ly exit<br>
&gt; here:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0if len(args) &lt;=3D 3:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(0)<br>
&gt; <br>
&gt; but it should be spelled out.<br>
<br>
If that&#39;s a problem, why doesn&#39;t ./configure --disable-modules fail=
 on<br>
Linux?<br></blockquote><div><br></div><div>It does not fail because=C2=A0it=
 exits with 0, no error.<br></div><div>Problem in my environment because nm=
 is missing,</div><div>but at the=C2=A0same time, running undefsym when mod=
ules</div><div>are disabled has zero sense=C2=A0because nothing=C2=A0will b=
e generated=C2=A0</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<br>
Kevin<br>
<br>
</blockquote></div></div>

--00000000000064e1da064dff8dcc--


