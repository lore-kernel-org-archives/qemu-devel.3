Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F178CC67861
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 20:12:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtvLI-0005rX-BD; Mon, 08 Apr 2024 16:11:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtvLG-0005rK-Ts
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 16:11:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rtvL7-0002QL-94
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 16:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712607095;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oGF6gKaVaBSEYUj48POHTKU7GEAd7D7Iask/0Lli+uM=;
 b=RMsi4gFiFF0ccdfCU4y+gxVjOIbWZsdqVxpSe6pwcU005o8QO8TkEtOyJ5gF5ua/gZWouY
 KSmxVUZxVlxLiLEj/9bjz8LVOlIN0bXEnhX9wpHjvR6BY185oM3crPp8uvo8PQMq8IfkWt
 T4DZQtz8fIw1yx5hyIhSVoconrpoZF4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-XaMGPOiKOPeaAL1edZZhyg-1; Mon, 08 Apr 2024 16:11:32 -0400
X-MC-Unique: XaMGPOiKOPeaAL1edZZhyg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-343f08542f8so2218749f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 13:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712607091; x=1713211891;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oGF6gKaVaBSEYUj48POHTKU7GEAd7D7Iask/0Lli+uM=;
 b=X+2D1UreoqLCo7FoRvXmjqhoymdDusPlcOqWflDVPrJaIeMctHUoYqx4uEuLQI+Ibf
 4jdAPHkx97QyYODRmGVXLY+uqL7yfCoa/uqNcDR+MGV0fxJlzvVGb6hnEyhiyI/BkBIk
 LaH46D5F5AkwgqRMqo1naLHdA2x2PfDBrai0jgrDRpcryij7+g4Ta72L9fg+vlPL5eLd
 vUrIIExG+VOUImLGo+V93C4/Rvg7mFscw6KDEdNpHSMtd49rw1Uylab69095abukV7pD
 KCNqphE0iWtX7UBPJZu6PrrKXY1w1dsjyLACb3kRypgAOee9dMrGti24pzzzGPo8ARfR
 lCXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXN/g3DusO5jgWd9HpsBrSmFCdITbXLaROM6jI6CqkgWPnJ0avQ0IKDKrf9OmMOQCHvKonF/FknCVXMZEJx/v96fQxFc8E=
X-Gm-Message-State: AOJu0YxbE6+iXrQW2GIeWXWuhYhu38wQ6rbzlUdRogmuEDoQCiSv/fXT
 JWPNIY0VzRX3OVhyTgeazH11kUMBYu8AOMYbRi8iVHclMmHdpu0M6q6II/Fy0P9cBrjZKD3T1Mv
 IX/O4Z1IOVfYjQGuAB2bdXzG2I4NQ1WC8ZjvwL6XY+U3SHFNy6PsdSDee4lqsiv22jRtgV5UMFb
 wP5ah5AVcfKDaXvcjYpRmxu5M1m6I=
X-Received: by 2002:adf:f48e:0:b0:341:bdd4:aedf with SMTP id
 l14-20020adff48e000000b00341bdd4aedfmr5687907wro.25.1712607090922; 
 Mon, 08 Apr 2024 13:11:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgoGAaxxQxqbRO+Ji4QNXQeffXB8gHZEwqgEkWrhjAGzpTeHpopwOkWMyBHOdSj0hVjvaKGZ4HDcezNXNv5PM=
X-Received: by 2002:adf:f48e:0:b0:341:bdd4:aedf with SMTP id
 l14-20020adff48e000000b00341bdd4aedfmr5687900wro.25.1712607090625; Mon, 08
 Apr 2024 13:11:30 -0700 (PDT)
MIME-Version: 1.0
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
 <CAFEAcA9_mLQ=jWNEHBVLJKHST4X=QVdpgPCTh1mRSSiea7ruzw@mail.gmail.com>
 <20240408061752-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240408061752-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Apr 2024 22:11:18 +0200
Message-ID: <CABgObfbfi-LiV0_BfK78-53kfTg+z3zX3sfBDAJqr5GxOWiOMA@mail.gmail.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000046e6b706159b692e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.494,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000046e6b706159b692e
Content-Type: text/plain; charset="UTF-8"

Il lun 8 apr 2024, 12:18 Michael S. Tsirkin <mst@redhat.com> ha scritto:

> On Mon, Apr 08, 2024 at 10:51:57AM +0100, Peter Maydell wrote:
> > On Mon, 8 Apr 2024 at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
> > >
> > > The patch adds non-upstream code in
> > > include/standard-headers/linux/virtio_pci.h
> > > which would make maintainance harder.
> > >
> > > Revert for now.
>

As long as it is part of the spec, why not just move the problematic parts
to a QEMU specific header? As far as I understand the kernel is never going
to consume these constants anyway.

Paolo

> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >
> > Are you intending to target this revert for 9.0 ?
> >
> > -- PMM
>
> Yes.
>
>

--00000000000046e6b706159b692e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 apr 2024, 12:18 Michael S. Tsirkin &lt;<a hre=
f=3D"mailto:mst@redhat.com" target=3D"_blank" rel=3D"noreferrer">mst@redhat=
.com</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On Mon, =
Apr 08, 2024 at 10:51:57AM +0100, Peter Maydell wrote:<br>
&gt; On Mon, 8 Apr 2024 at 10:48, Michael S. Tsirkin &lt;<a href=3D"mailto:=
mst@redhat.com" rel=3D"noreferrer noreferrer" target=3D"_blank">mst@redhat.=
com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.<br>
&gt; &gt;<br>
&gt; &gt; The patch adds non-upstream code in<br>
&gt; &gt; include/standard-headers/linux/virtio_pci.h<br>
&gt; &gt; which would make maintainance harder.<br>
&gt; &gt;<br>
&gt; &gt; Revert for now.<br></blockquote></div></div><div dir=3D"auto"><br=
></div><div dir=3D"auto">As long as it is part of the spec, why not just mo=
ve the problematic parts to a QEMU specific header? As far as I understand =
the kernel is never going to consume these constants anyway.=C2=A0</div><di=
v dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
&gt; &gt; Suggested-by: Jason Wang &lt;<a href=3D"mailto:jasowang@redhat.co=
m" rel=3D"noreferrer noreferrer" target=3D"_blank">jasowang@redhat.com</a>&=
gt;<br>
&gt; &gt; Signed-off-by: Michael S. Tsirkin &lt;<a href=3D"mailto:mst@redha=
t.com" rel=3D"noreferrer noreferrer" target=3D"_blank">mst@redhat.com</a>&g=
t;<br>
&gt; <br>
&gt; Are you intending to target this revert for 9.0 ?<br>
&gt; <br>
&gt; -- PMM<br>
<br>
Yes.<br>
<br>
</blockquote></div></div></div>

--00000000000046e6b706159b692e--


