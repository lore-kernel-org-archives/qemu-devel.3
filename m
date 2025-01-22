Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFADC02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 16:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tadvD-0002Vg-Eh; Wed, 22 Jan 2025 11:49:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tadvB-0002V0-Pe
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tadv9-0005Cw-Q9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 11:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737564578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ewwt2ACOxa4uDhbRVGHGO38ZWqXmpYtep152cfUhE7o=;
 b=d6yFakRemnn3LjcjntEnwYEumxA3icGNFXy2evG1mmTiUhlWloCDqAnWHpwi3kal48oU5+
 HSe542zdTcTlzfgFaeU1Z3A4iuZTC+7vVw9qIuB91kO+fkOAnfHcLJ6GOW50qjazXMDIRr
 Mduk3GtgUme8+nzAzeKvEbwxx/iRk34=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-_1cG-jjHMeCIxHP7HsYIxw-1; Wed, 22 Jan 2025 11:49:35 -0500
X-MC-Unique: _1cG-jjHMeCIxHP7HsYIxw-1
X-Mimecast-MFC-AGG-ID: _1cG-jjHMeCIxHP7HsYIxw
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-385dcae001fso3151424f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 08:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737564574; x=1738169374;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ewwt2ACOxa4uDhbRVGHGO38ZWqXmpYtep152cfUhE7o=;
 b=knsstqd0QuhSGirV2GxzyKP+0zYtFVllQEMnBlQ9h/+xxVOjR3RErdPjH3cfWY5NW7
 6YFUop9vQXnr8HZjH7JEdOhgFzUmt9QobfiLDoRGc21WkJRZNO6+dTbaoNJAbJvDcN4p
 36wc++FyLQ/BHXuBm/e2TlnQR7btYeSo9wvOdNEP9IcDRqRCtCQDmRe+TkCHYi5odgN/
 lCSnj0hmv1IL7T5wzzjAQhFFKR7x+vRHCj+Gff3dPZ5pyBUXzk0hI3WozHQp0ciSDtUk
 XO06rS3qqqbhrRDErgUpHcanFvr/9bYoukaleRlkUZ3e08vzUgmgP2kvaKX93IiGf3Dm
 5YfA==
X-Gm-Message-State: AOJu0Yy/3uFXTkDHXwspFD5HgQKuKhgx6s0wRGbP3lc74NyJQ/mtA7Ef
 7YgAq2kR5n2QH9d4YyzdSkk0xHa6FPz2L3HoBTfrBO7LFFTt2C9cbuzwYG8kXBKztXzU4Qi5ElA
 8MnrTmglj7u0IcbyIAyzsnsHSsI1KC0PMPHxS6t8BJxEGXT1bgi6t7oGo7sZFvaBIuAoRD7cPGB
 OdiNlfGzY6jKrMBfV+VGYi21KId5k=
X-Gm-Gg: ASbGncvHjjXxAZxkU+Zcbau/pNemijo7I1Mb64CthJUJK/6zDnoy1R/AI9wUS86J45C
 qlQbWVf9lCr7DsgS0MooKlpskPBR0dBpCG7MB3kOKvTNmZyIi6FGG
X-Received: by 2002:a5d:6c68:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38bf5656ddfmr20447883f8f.1.1737564574700; 
 Wed, 22 Jan 2025 08:49:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIlUdFElqPlZD3AMZVNXG5fTQ1sRYntTeK5AVMOO8Y1xb54ZQPiE0GPkMoE9XMhk5DK8ZUZE/2ZzFpUrUaz5c=
X-Received: by 2002:a5d:6c68:0:b0:385:ef39:6cd5 with SMTP id
 ffacd0b85a97d-38bf5656ddfmr20447864f8f.1.1737564574415; Wed, 22 Jan 2025
 08:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20250117092657.1051233-1-pbonzini@redhat.com>
 <20250117092657.1051233-6-pbonzini@redhat.com>
 <Z5Eh4Yj2Mp+xQV5Z@intel.com>
In-Reply-To: <Z5Eh4Yj2Mp+xQV5Z@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 22 Jan 2025 17:49:23 +0100
X-Gm-Features: AWEUYZlBceISABhncib1v-cMxvi0U0RBkasFmvdpWFE-I2wJRl98yh0eb_vTwMg
Message-ID: <CABgObfYf4ZmFANOVja=DGVzhn9rKR6yT7tt_e6DqKTtOb5DiDQ@mail.gmail.com>
Subject: Re: [PATCH 05/10] rust: pl011: pull interrupt updates out of
 read/write ops
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003b9fba062c4e471c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
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

--0000000000003b9fba062c4e471c
Content-Type: text/plain; charset="UTF-8"

Il mer 22 gen 2025, 17:31 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> >          if event == bindings::QEMUChrEvent::CHR_EVENT_BREAK &&
> !self.loopback_enabled() {
> > -            self.put_fifo(registers::Data::BREAK.into());
> > +            let update = self.put_fifo(registers::Data::BREAK.into());
>
> We can omit this `update` variable.
>

Indeed, but sometimes I left it because of long lines or to clarify the
meaning of the "bool" (or both).

Paolo

Reviewed-by: Zhao Liu <zhao.liu@intel.com>

--0000000000003b9fba062c4e471c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il mer 22 gen 2025, 17:31 Zhao Liu &lt;<a href=3D"mail=
to:zhao1.liu@intel.com" target=3D"_blank" rel=3D"noreferrer">zhao1.liu@inte=
l.com</a>&gt; ha scritto:</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if event =3D=3D bindings::QEMUChrEve=
nt::CHR_EVENT_BREAK &amp;&amp; !self.loopback_enabled() {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.put_fifo(registers::Da=
ta::BREAK.into());<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 let update =3D self.put_fif=
o(registers::Data::BREAK.into());<br>
<br>
We can omit this `update` variable.<br></blockquote></div></div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Indeed, but sometimes I left it because =
of long lines or to clarify the meaning of the &quot;bool&quot; (or both).<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"a=
uto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">Reviewed-by: Zhao Liu &lt;<a href=3D"mai=
lto:zhao.liu@intel.com" rel=3D"noreferrer noreferrer" target=3D"_blank">zha=
o.liu@intel.com</a>&gt;</blockquote></div></div></div>

--0000000000003b9fba062c4e471c--


