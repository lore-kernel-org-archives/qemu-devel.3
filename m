Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD56D5CCB4
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2024 14:35:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t69lu-0002Be-4t; Wed, 30 Oct 2024 10:34:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t69ls-0002Au-Bt
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:34:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhexu@redhat.com>) id 1t69lp-0003bp-R3
 for qemu-devel@nongnu.org; Wed, 30 Oct 2024 10:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730298838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9rfkSaI8h+VjDobPhzXllw1GtNDVTbGeWvP+C1EcWH0=;
 b=OFy26s7cMG8zv9yWNMYGppHS96aTyE4vh5DTmVlFlI6+HE35F1QxCfq9aige8W796WTBUY
 mTX1Cvpb6yxVRZAesd+ltNkX1CUldilR0joBPSN//aV4KvctV3EFTxeePq5HIgWRB4Is8/
 BXDfKf7omZDbTV7GZcFHN1QTllR/T08=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-nNGWyPxcN1OAbgyjtmi-ig-1; Wed, 30 Oct 2024 10:33:57 -0400
X-MC-Unique: nNGWyPxcN1OAbgyjtmi-ig-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7ea69eeb659so5725921a12.0
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2024 07:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730298836; x=1730903636;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9rfkSaI8h+VjDobPhzXllw1GtNDVTbGeWvP+C1EcWH0=;
 b=C/lh9JBxupwPE3SGw7MNYJtztfjT2VKrxHinsmYgdirVa+GjiK7hVOGencAUnTfYx+
 zzLX3F+AZLOvgSBvxr1q7Kh1sYCfSG+tIh00YPXRhnQhQ1tkQn0opwwv68iGiE4OrwbO
 gP5qMOPGIlmbfEOLiESX/d/R3sPkV3U9PfFkJO+Z90+FD8tK1cuxUGstUG/TnftTetpJ
 txNi3k0tJPhiFVvNNrXdh8SRr+HdgCfnlesmzf5SRnr/RSdFqW2TkhojwhA/Fsswxr0Q
 KGjEmb38Gp6lgmWUIJXK86Cl9cN+NRe4vBN/Y0su64MJgJPNE/M8JXvtDFpZtN6LeDYN
 BOkA==
X-Gm-Message-State: AOJu0YwUQvmRllbV7yeE5+auZrsV6bKu8Qm863f5BMgee1ju+sr6HJUa
 1X3MZyuhsYoBJ6DYfv3tomcf1+rM702KFtDLUo7/1o19dZ7L+fn+64Qm7x42p812YWqcCcYiCv5
 nh9mEi10wPQ74jIOW2VYHQLhxS+MNIvZKkAX9zHzloPXxUPmmJf8xRH0u8KGJZITM4sUXxURFhn
 R49Glc7/zxa495YECNeD7VpzUhe84=
X-Received: by 2002:a05:6a21:3941:b0:1d9:69cd:ae22 with SMTP id
 adf61e73a8af0-1d9a8431ab7mr16997836637.30.1730298835860; 
 Wed, 30 Oct 2024 07:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGh9fK6sY6tbHG8fyAgpnjOh4OONm6aLb72gxUx73cKaJPVhvPKYJwbi/DifSm/nSCuiF1pROXwOlN8hDdBAk0=
X-Received: by 2002:a05:6a21:3941:b0:1d9:69cd:ae22 with SMTP id
 adf61e73a8af0-1d9a8431ab7mr16997793637.30.1730298835428; Wed, 30 Oct 2024
 07:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241029211607.2114845-1-peterx@redhat.com>
 <20241029211607.2114845-6-peterx@redhat.com>
 <ZyILcz3XnwK0nRI8@redhat.com> <ZyIuD-SQA0Q2Sr7L@x1n>
 <ZyIvqQIzDq3JQNWW@redhat.com>
In-Reply-To: <ZyIvqQIzDq3JQNWW@redhat.com>
From: Peter Xu <peterx@redhat.com>
Date: Wed, 30 Oct 2024 10:33:43 -0400
Message-ID: <CADLectk-EyoMUD7j+mwwEVdUjMyKdJf0kwWUe8x0SyyO5Wb-uQ@mail.gmail.com>
Subject: Re: [PATCH RFC v2 5/7] x86/iommu: Make x86-iommu a singleton object
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Alex Williamson <alex.williamson@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000070fd550625b2975f"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=zhexu@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.366,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

--00000000000070fd550625b2975f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024, 9:08=E2=80=AFa.m. Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com>
wrote:

> On Wed, Oct 30, 2024 at 09:01:03AM -0400, Peter Xu wrote:
> > On Wed, Oct 30, 2024 at 10:33:23AM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Tue, Oct 29, 2024 at 05:16:05PM -0400, Peter Xu wrote:
> > > > X86 IOMMUs cannot be created more than one on a system yet.  Make i=
t
> a
> > > > singleton so it guards the system from accidentally create yet
> another
> > > > IOMMU object when one already presents.
> > > >
> > > > Now if someone tries to create more than one, e.g., via:
> > > >
> > > >   ./qemu -M q35 -device intel-iommu -device intel-iommu
> > > >
> > > > The error will change from:
> > > >
> > > >   qemu-system-x86_64: -device intel-iommu: QEMU does not support
> multiple vIOMMUs for x86 yet.
> > > >
> > > > To:
> > > >
> > > >   qemu-system-x86_64: -device intel-iommu: Class 'intel-iommu' only
> supports one instance
> > > >
> > > > Unfortunately, yet we can't remove the singleton check in the machi=
ne
> > > > hook (pc_machine_device_pre_plug_cb), because there can also be
> > > > virtio-iommu involved, which doesn't share a common parent class ye=
t.
> > > >
> > > > But with this, it should be closer to reach that goal to check
> singleton by
> > > > QOM one day.
> > >
> > > Looking at the other iommu impls, I noticed that they all have
> something
> > > in common, in that they call pci_setup_iommu from their realize()
> > > function to register their set of callback functions.
> > >
> > > This pci_setup_iommu can happily be called multiple times and just
> > > over-writes previously registered callbacks. I wonder if this is a
> better
> > > place to diagnose incorrect usage of multiple impls. If pci_setup_iom=
mu
> > > raised an error, it wouldn't matter that virtio-iommu doesn't share
> > > a common parent with intel-iommu. This would also perhaps be better f=
or
> > > a future heterogeneous machine types, where it might be valid to have
> > > multiple iommus concurrently. Checking at the resource
> setup/registration
> > > point reflects where the physical constraint comes from.
> >
> > There can still be side effects that vIOMMU code, at least so far,
> consider
> > it the only object even during init/realize.  E.g. vtd_decide_config()
> has
> > kvm_enable_x2apic() calls which we definitely don't want to be triggere=
d
> > during machine running.  The pci_setup_iommu() idea could work indeed b=
ut
> > it might still need cleanups here and there all over the places.
>
> The side effects surely don't matter, because when we hit the error
> scenario, we'll propagate that up the stack until something calls
> exit(), since this is a cold boot path, rather than hotplug ?
>

Yes, intel iommus are not hot pluggable so it shouldn't be a major concern.
But my point is we could have similar devices that either operate on
globals or system wide behaviors.  Singleton may properly protect it from
ever being created.


> With regards,
> Daniel
> --
> |: https://berrange.com      -o-
> https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-
> https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-
> https://www.instagram.com/dberrange :|
>
>

--00000000000070fd550625b2975f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Wed, Oct 30, 2024, 9:08=E2=80=AFa.m. Daniel P. =
Berrang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com">berrange@redhat.co=
m</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Wed, Oct 30, 20=
24 at 09:01:03AM -0400, Peter Xu wrote:<br>
&gt; On Wed, Oct 30, 2024 at 10:33:23AM +0000, Daniel P. Berrang=C3=A9 wrot=
e:<br>
&gt; &gt; On Tue, Oct 29, 2024 at 05:16:05PM -0400, Peter Xu wrote:<br>
&gt; &gt; &gt; X86 IOMMUs cannot be created more than one on a system yet.=
=C2=A0 Make it a<br>
&gt; &gt; &gt; singleton so it guards the system from accidentally create y=
et another<br>
&gt; &gt; &gt; IOMMU object when one already presents.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Now if someone tries to create more than one, e.g., via:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0./qemu -M q35 -device intel-iommu -device intel-=
iommu<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; The error will change from:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0qemu-system-x86_64: -device intel-iommu: QEMU do=
es not support multiple vIOMMUs for x86 yet.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; To:<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt;=C2=A0 =C2=A0qemu-system-x86_64: -device intel-iommu: Class &=
#39;intel-iommu&#39; only supports one instance<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; Unfortunately, yet we can&#39;t remove the singleton check i=
n the machine<br>
&gt; &gt; &gt; hook (pc_machine_device_pre_plug_cb), because there can also=
 be<br>
&gt; &gt; &gt; virtio-iommu involved, which doesn&#39;t share a common pare=
nt class yet.<br>
&gt; &gt; &gt; <br>
&gt; &gt; &gt; But with this, it should be closer to reach that goal to che=
ck singleton by<br>
&gt; &gt; &gt; QOM one day.<br>
&gt; &gt; <br>
&gt; &gt; Looking at the other iommu impls, I noticed that they all have so=
mething<br>
&gt; &gt; in common, in that they call pci_setup_iommu from their realize()=
<br>
&gt; &gt; function to register their set of callback functions.<br>
&gt; &gt; <br>
&gt; &gt; This pci_setup_iommu can happily be called multiple times and jus=
t<br>
&gt; &gt; over-writes previously registered callbacks. I wonder if this is =
a better<br>
&gt; &gt; place to diagnose incorrect usage of multiple impls. If pci_setup=
_iommu<br>
&gt; &gt; raised an error, it wouldn&#39;t matter that virtio-iommu doesn&#=
39;t share<br>
&gt; &gt; a common parent with intel-iommu. This would also perhaps be bett=
er for<br>
&gt; &gt; a future heterogeneous machine types, where it might be valid to =
have<br>
&gt; &gt; multiple iommus concurrently. Checking at the resource setup/regi=
stration<br>
&gt; &gt; point reflects where the physical constraint comes from.<br>
&gt; <br>
&gt; There can still be side effects that vIOMMU code, at least so far, con=
sider<br>
&gt; it the only object even during init/realize.=C2=A0 E.g. vtd_decide_con=
fig() has<br>
&gt; kvm_enable_x2apic() calls which we definitely don&#39;t want to be tri=
ggered<br>
&gt; during machine running.=C2=A0 The pci_setup_iommu() idea could work in=
deed but<br>
&gt; it might still need cleanups here and there all over the places.<br>
<br>
The side effects surely don&#39;t matter, because when we hit the error<br>
scenario, we&#39;ll propagate that up the stack until something calls<br>
exit(), since this is a cold boot path, rather than hotplug ?<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, intel iom=
mus are not hot pluggable so it shouldn&#39;t be a major concern. But my po=
int is we could have similar devices that either operate on globals or syst=
em wide behaviors.=C2=A0 Singleton may properly protect it from ever being =
created.=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
With regards,<br>
Daniel<br>
-- <br>
|: <a href=3D"https://berrange.com" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://berrange.com</a>=C2=A0 =C2=A0 =C2=A0 -o-=C2=A0 =C2=A0 <a h=
ref=3D"https://www.flickr.com/photos/dberrange" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://www.flickr.com/photos/dberrange</a> :|<br>
|: <a href=3D"https://libvirt.org" rel=3D"noreferrer noreferrer" target=3D"=
_blank">https://libvirt.org</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-o-=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://fstop138.berrange.com=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://fstop138.berrange=
.com</a> :|<br>
|: <a href=3D"https://entangle-photo.org" rel=3D"noreferrer noreferrer" tar=
get=3D"_blank">https://entangle-photo.org</a>=C2=A0 =C2=A0 -o-=C2=A0 =C2=A0=
 <a href=3D"https://www.instagram.com/dberrange" rel=3D"noreferrer noreferr=
er" target=3D"_blank">https://www.instagram.com/dberrange</a> :|<br>
<br>
</blockquote></div></div></div>

--00000000000070fd550625b2975f--


