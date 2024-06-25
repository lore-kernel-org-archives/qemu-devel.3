Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895B5C3064D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:05:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzJ1-0004DZ-ML; Tue, 25 Jun 2024 02:05:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLzIv-0004Bl-5C
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:05:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sLzIs-0004Qz-Pk
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:05:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719295517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=73mmcmEiwcz38wndhx71jn6+9IApmb3rLIyx+uWB+rY=;
 b=JE+axHy9spVigIV/NmB/vSo1aXOb+FRZk4881+wDX+ivgUNsHbABHUBZ/j3au1j6/DKWdS
 RSFmDGWE8pxoGxbW/hTSnDz5J/FJW8DT9nkDQnInBtF4qTXUoCyuJS+puPkNjZHDSA17BA
 WEJkE1Y8QDNnGc9Pl4egwKoFZxW6VvA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-B3TjgeI5Pd-DPn12zHj-qw-1; Tue, 25 Jun 2024 02:05:15 -0400
X-MC-Unique: B3TjgeI5Pd-DPn12zHj-qw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3643d0e3831so3370042f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719295514; x=1719900314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=73mmcmEiwcz38wndhx71jn6+9IApmb3rLIyx+uWB+rY=;
 b=aoCjc74daAYcmnV7wM8T/y0lNg2Y0sl9SCM8AP0ZkrRTbutNAK5WqTbxeq2G0bJwMe
 LDwZ54U6UptJW6dNjnEXAiUPqH2XpKbsj7CCNn47bUMnfwMSx8Wi606d99mdt+Bw7vsL
 jl86WljaNr1jdm4hi44hK60U/WQqsj3CSQrYIYDeqbWwAe7WSaZIuMgZRLyPq7gZ2RRR
 WQ2JiX0sGa6eGb6G/hmD9sIh4iiaf+A/QncXENZFtxpktNrD/iR7do6FazoEKS8LJZhd
 AnhyqJio56lkPQRmvRMEV4lSA97zF3gi932JZfZ34kCAzukJLdjwWgOp1zAUkqUokBCs
 Pb+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7JiblzepWhEcAFyD+ZJZMhN5/H1nGkH1QI2zbIpP/SjDlOc21Rgz3xVPqSFZ6RYoP8oyYp2JlUJOqokH1SokXRFeH7nw=
X-Gm-Message-State: AOJu0YwYDth9/NGfmjVXNst1Wbnx8bYGxBC6RhbmZcWCjPxKkELXcsdj
 4UtB84QzYeu3G5eGpIeDspBtPuYuZCohkMv2AtTMNeRAX15wsvor262JTZ/OQF5iRGZmHTqmYSt
 QFEVOlirGb3D8lMXey9TKahjiZtf1shL7fbPc50WJEd8B5VwyrE8i6PkaacxUYZeNzF9V06LtDj
 k1H6Euc6FbogNkJ91zT9e4akUPlpo=
X-Received: by 2002:a05:6000:1847:b0:366:ec2c:8648 with SMTP id
 ffacd0b85a97d-366ec2c86camr4807692f8f.43.1719295513958; 
 Mon, 24 Jun 2024 23:05:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy4LgGsMHhf2dfdkIT6C6dQacl4vKrKS9aGBTHccTGaWIYG1Q9bLZTMN3pX7ZtQVQigYK6J5yS0nnl53s/o9E=
X-Received: by 2002:a05:6000:1847:b0:366:ec2c:8648 with SMTP id
 ffacd0b85a97d-366ec2c86camr4807674f8f.43.1719295513580; Mon, 24 Jun 2024
 23:05:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
 <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
In-Reply-To: <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Jun 2024 08:05:03 +0200
Message-ID: <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: Roman Kiryanov <rkir@google.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Felix Wu <flwu@google.com>, qemu-devel <qemu-devel@nongnu.org>, 
 "Maydell, Peter" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000059f043061bb0ae57"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

--00000000000059f043061bb0ae57
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 25 giu 2024, 04:32 Roman Kiryanov <rkir@google.com> ha scritto:

> Hi Philippe, thank you for looking.
>
> On Mon, Jun 24, 2024 at 7:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> > In particular this patch seems contained well enough
> > to be carried in forks were C++ _is_ used.
>
> Will you agree to take #ifdef __cplusplus  and #error to the QEMU side
> in atomic.h and
> we will keep atomic.hpp on our side? The error message looks better
> when atomic.hpp
> is somewhere near.
>

I think we should also move typeof_strip_qual elsewhere; I will take a
look. I think there are a couple headers that already have #ifdef
__cplusplus, but I need to check (no source code around right now).

But another good thing to do would be to avoid having atomic.h as a
rebuild-the-world header, and any steps towards that would be very welcome.

Paolo


> Regards,
> Roman.
>
>

--00000000000059f043061bb0ae57
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 25 giu 2024, 04:32 Roman Kiryanov &lt;<a href=
=3D"mailto:rkir@google.com">rkir@google.com</a>&gt; ha scritto:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi Philippe, thank you for =
looking.<br>
<br>
On Mon, Jun 24, 2024 at 7:27=E2=80=AFPM Philippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; wrote:<br>
&gt; In particular this patch seems contained well enough<br>
&gt; to be carried in forks were C++ _is_ used.<br>
<br>
Will you agree to take #ifdef __cplusplus=C2=A0 and #error to the QEMU side=
<br>
in atomic.h and<br>
we will keep atomic.hpp on our side? The error message looks better<br>
when atomic.hpp<br>
is somewhere near.<br></blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">I think we should also move typeof_strip_qual elsewhere; =
I will take a look. I think there are a couple headers that already have #i=
fdef __cplusplus, but I need to check (no source code around right now).</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">But another good thing to =
do would be to avoid having atomic.h as a rebuild-the-world header, and any=
 steps towards that would be very welcome.</div><div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"=
><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
Regards,<br>
Roman.<br>
<br>
</blockquote></div></div></div>

--00000000000059f043061bb0ae57--


