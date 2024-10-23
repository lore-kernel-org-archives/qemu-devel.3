Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 879C8D2E01B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 07:07:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3VSN-0002wZ-BF; Wed, 23 Oct 2024 03:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3VSK-0002wH-Qh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:06:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3VSI-0004Vy-Me
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 03:06:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729667210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmAD8GQ5sS1D0XzHU8O15rbEZi8tTVhReFawoM1NxhE=;
 b=eAH8G8LOaPeJhgmt4G5i21fS2Y+8LhShVWEYoQnRn4CrnGmQlsRvLj0APU6In9ZPl0ZeCz
 kfUpYI+N6wBOal/F3fnEywXffVpCRgiVgXsiDEXOl9DkzIyCYWGvzDcNeSq/tjkj/owfuh
 wZLovNX7ZQU/y5GeEp/njF8KWW9tzMc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-SALUnQr_ORKc7px2TnW_Tw-1; Wed, 23 Oct 2024 03:06:48 -0400
X-MC-Unique: SALUnQr_ORKc7px2TnW_Tw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-37d49887a2cso272564f8f.0
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 00:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729667207; x=1730272007;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RmAD8GQ5sS1D0XzHU8O15rbEZi8tTVhReFawoM1NxhE=;
 b=bbQ2kMB6bCiWeZXzgaPGmwYCjENtNbq3Tm3+ZWk1Gz480BUPQA+3ozk7iAutjEZz90
 k90uM+kzyl5c6jdgcjtMckYsFAiOYOH+S8yBGN52ueLIgjamhZYs2rkCaI0Ypvg3PnRe
 bD87OjpOtmMfK3Xl6vBLX6pLaX7wPxPhXY2G2CdOy7hQWQ5CDjWjH1DaO+y8Dvt8309v
 dShe5WaDe/wkeXkGovDcQWjxe76P+nKA7iiqCW6cN7EpYCd1agx6J9SIeZkFDB1iRekz
 tIrm8BRMxlEFN4gx03K0S6wr4U+YXBKuYX6lBd+dZygSV5HXaif/OTcK+sqA3fJkwD8F
 5dKQ==
X-Gm-Message-State: AOJu0YzUSvPFQe4vv3jsQLPrc6NYtwBhbCFy3Y/AtfGkyCFW7kcruly/
 L/IbyJ+W2uN6oJCzj2F/WKQv5kSxgxuFGNvD3V6s/++QDmiDE12AaSchMpJ4LqwgNMtGxEg2vw/
 LIR7LOaAaRh1KPuGpQjcq6LUuasgvv5QtLW1B2GKwLMJVzc6GcLi6+3Y4jFhVPgMNPoqgQhqHvt
 z8iHXBKQwZcRdCJclrTvRZ44Cq8fs=
X-Received: by 2002:adf:a45b:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-37efc5df5bcmr791239f8f.14.1729667207168; 
 Wed, 23 Oct 2024 00:06:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMADtdM8m3MpN9M0akGXJdIck2aIQ03n3o5GxUYqOaxcxENgTDzuYRqGScLQd83cEfd7y4ENysE9Hs47b7nSU=
X-Received: by 2002:adf:a45b:0:b0:37c:ce3c:e15d with SMTP id
 ffacd0b85a97d-37efc5df5bcmr791220f8f.14.1729667206766; Wed, 23 Oct 2024
 00:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-11-pbonzini@redhat.com>
 <12b03ebb-6bc2-4ffe-99cc-4818b5d992ee@linaro.org>
 <CABgObfawNPijVE7FqdGpnpAZ2JM9puY6=PSivFR4GgbHTKE2Fg@mail.gmail.com>
 <ab4af84d-a518-406b-8dbb-513d41aa4d61@linaro.org>
In-Reply-To: <ab4af84d-a518-406b-8dbb-513d41aa4d61@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 23 Oct 2024 09:06:34 +0200
Message-ID: <CABgObfb2yX28P7wawmekjj_bkkD0_G-cELYGR2veWYdFAV5OAA@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] qdev: make properties array "const"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Content-Type: multipart/alternative; boundary="000000000000708b6306251f87cb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.697,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

--000000000000708b6306251f87cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mar 22 ott 2024, 23:43 Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> h=
a
scritto:

> On 22/10/24 02:23, Paolo Bonzini wrote:
> > At least keeping the const
> > within qdev properties makes things "safer" within that realm.
>
> Since it is only within qdev-properties.c, it is indeed reasonable to
> accept. Maybe make it explicit via a well-named macro to do the cast?
>
>    /* NON_CONST_PROP: Specific macro to this file because ... */
>    #define NON_CONST_PROP(prop) (Property *)(prop)
>

The name of the macro suggests the opposite, i.e. that you'd use it to cast
const void* to Property* in the callbacks. I would leave it as it is.

Paolo

>
> Regards,
>
> Phil.
>
>

--000000000000708b6306251f87cb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mar 22 ott 2024, 23:43 Philippe Mathieu-Daud=C3=A9 =
&lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; ha scrit=
to:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 22/10/24 =
02:23, Paolo Bonzini wrote:<br>
&gt; At least keeping the const<br>
&gt; within qdev properties makes things &quot;safer&quot; within that real=
m.<br>
<br>
Since it is only within qdev-properties.c, it is indeed reasonable to<br>
accept. Maybe make it explicit via a well-named macro to do the cast?<br>
<br>
=C2=A0 =C2=A0/* NON_CONST_PROP: Specific macro to this file because ... */<=
br>
=C2=A0 =C2=A0#define NON_CONST_PROP(prop) (Property *)(prop)<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">The name of the=
 macro suggests the opposite, i.e. that you&#39;d use it to cast const void=
* to Property* in the callbacks. I would leave it as it is.=C2=A0</div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
Phil.<br>
<br>
</blockquote></div></div></div>

--000000000000708b6306251f87cb--


