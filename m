Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49277D0BB5E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2024 06:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3qy1-0001sj-SS; Thu, 24 Oct 2024 02:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3qxy-0001qO-Mx
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t3qxv-00081U-JK
 for qemu-devel@nongnu.org; Thu, 24 Oct 2024 02:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729749894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xEDsmwraAlntcBTxwfYr9ShpYSeNjamaHdZxIFoxufE=;
 b=OggWDzXkRHCRpi4IZWM09RfrQ7x6bpksMG2RCq8++PeN4p7MvVElWTdONbBH9oEcCJJVhj
 +3I6B2BctWJnHtbtsXKmN8Q+2OtkHqKIbT2k1RwIU2JvtPA1Tnk/TgMqUM/pwEtihEDkVF
 0WvjI3P9l7vogQTAcfzCVxL7Ui0G76o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-F3kB7H-BNwaV1c_z3tgcFA-1; Thu, 24 Oct 2024 02:04:52 -0400
X-MC-Unique: F3kB7H-BNwaV1c_z3tgcFA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d95264eb4so261941f8f.2
 for <qemu-devel@nongnu.org>; Wed, 23 Oct 2024 23:04:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729749891; x=1730354691;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xEDsmwraAlntcBTxwfYr9ShpYSeNjamaHdZxIFoxufE=;
 b=wDE0Kug2tto/FN32NWILNOuDR8eGmpPvJV6/ZybdXv0aNdiy5YopjhO3KWYzQLn+48
 +1Tynl07YW2QDmbXWyGE7XC4YYM5UUSUm+TmoKkh2nDkXHBikr/Syq9IlNhsUMdUvIFN
 83oyjy8fOaHXheeowhYZUk5I0/lgIN6w6weeX5WwONk2buzaxOWrHchu67HXzn2nAeN2
 0FPG0rDf6WvvtWilyC6ZYaB6Fno7AXHtDdLio9S2uD7rj5sbuLOdNr6ghYVFTemHL8Ol
 Z2xVc3RqO3agIXAhNbT2PF7RAoFgckW4FmOhwr7egBay+3Jfx2xxejQX8lFhPUlROjlh
 o/OQ==
X-Gm-Message-State: AOJu0YyTLQfJH3MDkhEXe8B9QjPV5+fYyEu39EYIiRRk6XnXfnNSMV2P
 9rVqUveoBAv/2rKvN0MTDnpqJbDc8HPTEX5j30p5Oy1jilD0Nkyt6NdYjMTo1jcCo4a8Wf3hWhK
 5A/5vzYcyRjeIqRHDz8ERx6Kx/hWy50oQqTQEFl+zprIYER+GGCPR+kSzHqeah0dgLN4LI1Hbgk
 cxG1NNBzDNZtg5ymJMRh7qDS17ZZ8=
X-Received: by 2002:a5d:654f:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37efcc5f0e7mr3557192f8f.0.1729749891370; 
 Wed, 23 Oct 2024 23:04:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFVGTYQvgMX0m/3uCy2xNZPul386pwfY1MKoPqdcEZzLRo0lh+QtJDhj9k/JfqPhP5rC6kup2l8F7uYGYvcWY=
X-Received: by 2002:a5d:654f:0:b0:37d:4647:155a with SMTP id
 ffacd0b85a97d-37efcc5f0e7mr3557173f8f.0.1729749890964; Wed, 23 Oct 2024
 23:04:50 -0700 (PDT)
MIME-Version: 1.0
References: <20241021163538.136941-1-pbonzini@redhat.com>
 <20241021163538.136941-7-pbonzini@redhat.com>
 <ZxkWyN4OrbWlQXEa@intel.com>
In-Reply-To: <ZxkWyN4OrbWlQXEa@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 24 Oct 2024 08:04:37 +0200
Message-ID: <CABgObfai-YwC4F5oRHE0dfKBKUqEEDuJ0BkkwYjmPLGE8u=JPA@mail.gmail.com>
Subject: Re: [PATCH v2 06/13] rust: modernize link_section usage for ELF
 platforms
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>
Content-Type: multipart/alternative; boundary="000000000000cd39ae062532c796"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
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

--000000000000cd39ae062532c796
Content-Type: text/plain; charset="UTF-8"

Il mer 23 ott 2024, 17:15 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> >      let expanded = quote! {
> >          #[allow(non_upper_case_globals)]
> >          #[used]
> > -        #[cfg_attr(target_os = "linux", link_section = ".ctors")]
> > -        #[cfg_attr(target_os = "macos", link_section =
> "__DATA,__mod_init_func")]
> > +        #[cfg_attr(
> > +            not(any(target_vendor = "apple", target_os = "windows")),
>
> EMM, "apple" vendor contains macOS, iOS and other variations of iOS.
> Do we need to consider other OSs besides macOS for now?
>

Yes, UTM runs on iOS.

And it seems that the Rust people don't like "target_vendor = 'apple'".
> (https://github.com/rust-lang/rust/issues/100343). :-)
>

That would be an edition break, I think, so we can worry about it in 2028.
:)

Paolo


> Otherwise,
>
> Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
>
>

--000000000000cd39ae062532c796
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mer 23 ott 2024, 17:15 Zhao Liu &lt;<a href=3D"mailto:zhao1=
.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">&gt;=C2=A0 =C2=A0 =C2=A0 let expand=
ed =3D quote! {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #[allow(non_upper_case_globals)]<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #[used]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 #[cfg_attr(target_os =3D &quot;linux&quot=
;, link_section =3D &quot;.ctors&quot;)]<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 #[cfg_attr(target_os =3D &quot;macos&quot=
;, link_section =3D &quot;__DATA,__mod_init_func&quot;)]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 #[cfg_attr(<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 not(any(target_vendor =3D &=
quot;apple&quot;, target_os =3D &quot;windows&quot;)),<br>
<br>
EMM, &quot;apple&quot; vendor contains macOS, iOS and other variations of i=
OS.<br>
Do we need to consider other OSs besides macOS for now?<br></blockquote></d=
iv></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, UTM runs on iOS=
.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
And it seems that the Rust people don&#39;t like &quot;target_vendor =3D &#=
39;apple&#39;&quot;.<br>
(<a href=3D"https://github.com/rust-lang/rust/issues/100343" rel=3D"norefer=
rer noreferrer" target=3D"_blank">https://github.com/rust-lang/rust/issues/=
100343</a>). :-)<br></blockquote></div></div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto">That would be an edition break, I think, so we can worry ab=
out it in 2028. :)</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=
=C2=A0</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gma=
il_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Otherwise,<br>
<br>
Reviewed-by: Zhao Liu &lt;<a href=3D"mailto:zhao1.liu@intel.com" target=3D"=
_blank" rel=3D"noreferrer">zhao1.liu@intel.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--000000000000cd39ae062532c796--


