Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A14BC27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 17:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKhya-0002FW-Hv; Fri, 21 Jun 2024 13:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sKhyY-0002Ey-5O
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:23:02 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <venture@google.com>)
 id 1sKhyW-0006IO-Ig
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 13:23:01 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57d119fddd9so4732a12.1
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1718990579; x=1719595379; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZfJVKCP3gxPj4RaxvqxpsswToWsIVv6r8LhmjkSuP9Q=;
 b=Pdjgnt+5ra0hLIzo3DVkUsdzggyl9yP1nxqbYuoeBJpr0MKDWkwFvZwu56JIcbGCXj
 5kf1LHGZayEnWtHv/7UMBq0AvokoMBiEFhRQSWIkp7PeOrhMd37SPGL/XII1XOaqIyYb
 ycPtrxExzZCUO7QjL1KFWczPdPRoSR8bn6OBLVJvpjcMQmz61nNMsbh8Nt4d+0pnTajw
 rVCs6cby3/AZlKlBOcfwsojc1J0Uru8C6+JEdXk1p6yye3A0/jaSLEE3EiKbgSOGON56
 l4PpSNQXaWptIEHI50MLR/WZsGZGusyBWqk/cdAXCZsMhOWVJOfud1hdrnXeOdeaAKM+
 pOfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718990579; x=1719595379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZfJVKCP3gxPj4RaxvqxpsswToWsIVv6r8LhmjkSuP9Q=;
 b=JHyhdss9HE8a3Lx/P+xa4rS45chuYOS5LMf/2YU54vvfAI43++b0rU/8OZtW6M4bnT
 7Mq21K8f4bf4zTn9KCpVUAxC4K4q7933gTYcpfpJ5gfCQ/oKvK9xbveeR/mxKqnnQABa
 5yuyFwsSAKuHy7OU3dQa65PCVQE4svq8+QEJ3zHsin0o/bdRQr6abYwSgsxo7SqRJT0Q
 uxjINkAL8t2l4ueUQE6EpIr+1AXqnUzcSOlbL9PVePgU9mDIzJNBxMS9g2/wyAGRiPc5
 LYpYC9tZDIm3jsd1x5l6oUDDyhZf150apx1rqV9bRbr4hmlxJnBiX4ozSRxsUoT1N5l4
 VQcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKNYpJ3+pNDWCVDZh0+Dc/+1uye3eT6sJM4RwX8F86YaS3oivnthFiTHmrR8Y7eDh7Oe+d9Wr0rS0t8jLqOO085JVIE9Y=
X-Gm-Message-State: AOJu0YzhrqbGcJnzEfnrXFo+SUB0LeW38U3SrFatxfQcAzsbfwl9fCnb
 OioVmtTYQ8xpjV8Sru/LVS5ZuoNqA8Xus65SxcDGc321RNcQgl5/atYTZxLty6loJH6ciHMyjLJ
 5rQNvWNSqzxgKvsQh5vLuHDmy76SKkSuUSq9D
X-Google-Smtp-Source: AGHT+IFcrSN0r26RMZPikCWWv7o8p97I9vyAgpmWo6ASkVI/PRDVXFAFSQEewnAhi0VqnksCtOq/DF897Al5K6h709o=
X-Received: by 2002:a05:6402:520a:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-57d3f6385dfmr11701a12.6.1718990578681; Fri, 21 Jun 2024
 10:22:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
 <6297a086-7e59-4299-aabd-68cf14fc42bd@linaro.org>
In-Reply-To: <6297a086-7e59-4299-aabd-68cf14fc42bd@linaro.org>
From: Patrick Leis <venture@google.com>
Date: Fri, 21 Jun 2024 10:22:45 -0700
Message-ID: <CAO=notxkpV3cchJ4LycrOnUXkCRbtJaMroe0urLHBg5OQX1U_A@mail.gmail.com>
Subject: Re: standardizing i2c device ids
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 QEMU Developers <qemu-devel@nongnu.org>, Corey Minyard <cminyard@mvista.com>, 
 Titus Rwantare <titusr@google.com>, Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000d16304061b69aed4"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=venture@google.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

--000000000000d16304061b69aed4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 11:26=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> Hi Patrick,
>
> On 21/6/24 00:03, Patrick Leis wrote:
> > Corey and Peter,
> >
> > My team builds lots of configurations for Qemu boards, and one pain
> > point has been that the qom path for a device depends on the device
> > insertion order, child[0], child[1] and the like.  I noticed that the
> > qdev paths for devices also exist by their device id property.  By
> > default, this ends up being the device type name.  I was wondering if i=
t
> > made sense to override this with the device type plus the smbus
> > address?  I did something similar with the i2c mux device, to resolve
> > part of this issue.
>
> Including Markus since we discussed this with him last year, but
> I don't remember correctly what was agreed / decided :S
>

Thanks :)

I'd really like to be able to access devices with paths that specify the
device I want specifically :)


>
> Regards,
>
> Phil.
>

--000000000000d16304061b69aed4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 20, 2024 at 11:26=E2=80=
=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">=
philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Hi Patrick,<br>
<br>
On 21/6/24 00:03, Patrick Leis wrote:<br>
&gt; Corey and Peter,<br>
&gt; <br>
&gt; My team builds lots of configurations for Qemu boards, and one pain <b=
r>
&gt; point has been that the=C2=A0qom path for a device depends on the devi=
ce <br>
&gt; insertion order, child[0], child[1] and the like.=C2=A0 I noticed that=
 the <br>
&gt; qdev paths for devices also exist by their device id property.=C2=A0 B=
y <br>
&gt; default, this ends up being the device type name.=C2=A0 I was wonderin=
g if it <br>
&gt; made sense to override this with the device type plus the smbus <br>
&gt; address?=C2=A0 I did something similar with the i2c mux device, to res=
olve <br>
&gt; part of this issue.<br>
<br>
Including Markus since we discussed this with him last year, but<br>
I don&#39;t remember correctly what was agreed / decided :S<br></blockquote=
><div><br></div><div>Thanks :)</div><div><br></div><div>I&#39;d really like=
 to be able to access devices with paths that specify the device I want spe=
cifically :)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
</blockquote></div></div>

--000000000000d16304061b69aed4--

