Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6339D149EB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:12:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Qf3-0003iJ-Ch; Fri, 25 Oct 2024 16:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qf1-0003hv-DU
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qez-0001Xn-OY
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729887107;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OHDOcyPfOFgO6bWvoZpBHME4TzQRzjTPWiHANMuyQUU=;
 b=GcrrLyI8yzisHl361kwalplTX4V5VgbWqX5nqoMQtI6xF95WS17MxsDjhdVRDPbUFDt1fO
 qJmkxVn+0FAZL5sVkT/1uf/lBuseanHFHDyr85cbKluk71ywqKqqhgUamqoaFVdBia6o5Y
 NpxintoYPb/Yu5XqoAxm4fBN6TPsRmQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-W2qMyCNYNemj8f4ebdWe7A-1; Fri, 25 Oct 2024 16:11:44 -0400
X-MC-Unique: W2qMyCNYNemj8f4ebdWe7A-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d5a3afa84so1321247f8f.3
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729887103; x=1730491903;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OHDOcyPfOFgO6bWvoZpBHME4TzQRzjTPWiHANMuyQUU=;
 b=WLvXWOHUu3dO2wkCBAr64hYm86R5mJf7ZQ4+S7P0xYacQkXUQ3mEdiGFP3JfT5Ako4
 Zhd5oww/wNUXuzFXmBcNDrFnMnHw/O3vpGITz8iIt2v9ajITTm0um9ZL4wYm9dTBYMWM
 b2JX5oaPpa6/r5ktNdpuJEezUZap1jroP8WbRNV60Qi0AhjOV5IXmbYZL248tt0N8bCd
 GzZIjzLKSuHmxlZ8XTBHwociXzwZvvjtLk2pDsgqSVEADx/2x9yvxu2O+DtG8nM6PpVA
 XgAHrVrle5jVfAaGQBHc7F3HiI6s9Zoh6mmKZ9inDtZW5d4mOfZ1S/eyX4v+8crMu2XD
 e1tg==
X-Gm-Message-State: AOJu0Yxd+Au46JSmavB8qmy6wiW9K5zBfsqp42XaciNM7uMijggwzEIE
 JzOSgAoKYMn2O8vYVBd7cGFe5MUC/O+nbaa0gWq1EQklSzl15bEq9reNakw9Qf2IWE07+JWYKry
 8hIY5EsZUVlZWSscoYy0MFXs1hH0aig7RD9+pHxa7sTYs6L8ceLe4bEJpr1wCvNub/X1oyyhV28
 dI5hyBISkY2gADujq/o0lRoJmqCHw=
X-Received: by 2002:a05:6000:e04:b0:37d:4c8f:2e1 with SMTP id
 ffacd0b85a97d-38061137605mr442239f8f.22.1729887103392; 
 Fri, 25 Oct 2024 13:11:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKlpsOVoElcQqcrPw5R5cim+fNeOybZXP/8bJxd/zJ070exVl9H0xh2SSZgx0X7qipfdeVKF7yRPG6Andc534=
X-Received: by 2002:a05:6000:e04:b0:37d:4c8f:2e1 with SMTP id
 ffacd0b85a97d-38061137605mr442226f8f.22.1729887103063; Fri, 25 Oct 2024
 13:11:43 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-20-pbonzini@redhat.com>
 <b86de87b-99f3-4fce-9a33-3580d37d90dc@tls.msk.ru>
In-Reply-To: <b86de87b-99f3-4fce-9a33-3580d37d90dc@tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 22:11:32 +0200
Message-ID: <CABgObfbYf8vEJd=QhvXvhy0o0Xt5-bPJ7jdd0NRVUh_-tXApuQ@mail.gmail.com>
Subject: Re: [PATCH 19/23] rust: do not use --generate-cstr
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000047b73f062552ba76"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
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

--00000000000047b73f062552ba76
Content-Type: text/plain; charset="UTF-8"

Il ven 25 ott 2024, 22:03 Michael Tokarev <mjt@tls.msk.ru> ha scritto:

> 25.10.2024 19:02, Paolo Bonzini wrote:
> > --generate-cstr is a good idea and generally the right thing to do,
> > but it is not available in Debian 12 and Ubuntu 22.04.  Work around
> > the absence.
>
> Can't we just install a more recent bindgen and use all the current
> features of it, like it's done in patch 22 for ubuntu?
>

The idea is that Ubuntu will get the memo and add an updated bindgen, since
they did update rustc to 1.75.0... so hopefully even that change in patch
22 is temporary.

This patch is only a minor nuisance and we'll only need it for about a year.

Paolo

/mjt
>
>

--00000000000047b73f062552ba76
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 ott 2024, 22:03 Michael Tokarev &lt;<a href=
=3D"mailto:mjt@tls.msk.ru">mjt@tls.msk.ru</a>&gt; ha scritto:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">25.10.2024 19:02, Paolo Bonzi=
ni wrote:<br>
&gt; --generate-cstr is a good idea and generally the right thing to do,<br=
>
&gt; but it is not available in Debian 12 and Ubuntu 22.04.=C2=A0 Work arou=
nd<br>
&gt; the absence.<br>
<br>
Can&#39;t we just install a more recent bindgen and use all the current<br>
features of it, like it&#39;s done in patch 22 for ubuntu?<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The idea is that =
Ubuntu will get the memo and add an updated bindgen, since they did update =
rustc to 1.75.0... so hopefully even that change in patch 22 is temporary.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">This patch is only a min=
or nuisance and we&#39;ll only need it for about a year.</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><di=
v dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
/mjt<br>
<br>
</blockquote></div></div></div>

--00000000000047b73f062552ba76--


