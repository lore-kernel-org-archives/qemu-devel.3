Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4666CD0E6F0
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:47:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pwA-00017J-Hh; Mon, 21 Oct 2024 06:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2pw8-000176-Pj
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:46:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t2pw6-0003XR-Hd
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729507612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2XTDE69lU6wHVViIexu/TcDJqXZ1NzHfBgSwaHK3G70=;
 b=HgibfZI5bU9d/UNHkwMpZGMoJAc9MKsYnk/m+6xCZICzY+22DNvYOnUOKCT8uwFszmPtoH
 0hUErL43sNFMwkQucVtJhwOqI5I5FXMVoAUBrQk5+uR/k+pHqFkq9ArOcqAde6Pl0Oy3xx
 NSEQu0KGygIDihiMksg8N5psNUKzPe0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-Oo7hlqtvOQiPOzH-JoEyGg-1; Mon, 21 Oct 2024 06:46:50 -0400
X-MC-Unique: Oo7hlqtvOQiPOzH-JoEyGg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-431673032e6so17210365e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729507609; x=1730112409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2XTDE69lU6wHVViIexu/TcDJqXZ1NzHfBgSwaHK3G70=;
 b=sIJTFzvk0mddPgChe3KK3tbaWgBSZMpQ6B/5lTZU7r0k+Gx8utNht9dlwvxljU9s0a
 ebqYKiZH4tKi3XJeE1k+QsHYuZFQUnE4J1JZvdVHDYC89+JBvGTadG98NCp92VGsvmZ+
 vKQ0p9sghWILE2xRY04d26vSeos/vacf8iXI5vHABINYnZABwBwztWQdQMDPiWDvWpDP
 czRqvFpOr/SPSO4XRvreUyzrOWInczgThc09tQVRPPiGq7bBsYVrhIntSPqMkklFqgZh
 7lkvrMbxVwI9q0fDg9M7QPk8VqBf6BUfcg+PXZ5W8l0adbO4y4gzpj7DPaYVKJGhEOms
 URxA==
X-Gm-Message-State: AOJu0YwCZE/e94U8lKsSTt2ecEe1EgA/9hw8PKFInODeCbAERXJVZGWb
 9tmYcqyUHYT2QYBKNe1sW9/MtLQXjZl3zTHsRi+0QdkSNxFcdjJzjiX8TVo2Gk9optQEEN573Rd
 oMbORVDvsKK7w9/A0WilqAwXh097w3QlsMp2lbd0cjyRC+OgqwCRxf/k6l7p+Xf8ArWKPox/kv0
 bZSZK7DjYyu0Z0jDpo8iG3B7ZqTrs=
X-Received: by 2002:a5d:4d03:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-37eb487a49amr7814224f8f.40.1729507609308; 
 Mon, 21 Oct 2024 03:46:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtTf10O2OoORD+Vey4c4EfsjTjeqeXzcPBJJcnkjRk8VUkBGtARkEWXCnsCSxZCepGx+CFZ/0S4pdvrnuDbYM=
X-Received: by 2002:a5d:4d03:0:b0:374:b35e:ea6c with SMTP id
 ffacd0b85a97d-37eb487a49amr7814210f8f.40.1729507608922; Mon, 21 Oct 2024
 03:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20241018144306.954716-1-pbonzini@redhat.com>
 <20241018144306.954716-7-pbonzini@redhat.com>
 <SY0P300MB10265F36FDD39FD0B258F37795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
In-Reply-To: <SY0P300MB10265F36FDD39FD0B258F37795432@SY0P300MB1026.AUSP300.PROD.OUTLOOK.COM>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Oct 2024 12:46:38 +0200
Message-ID: <CABgObfYqBVRjynXWSY08=p49zk9wnfBe8xwhNtMY5FGDZtC0jA@mail.gmail.com>
Subject: Re: [PATCH 06/13] rust: remove unused macro module_init!
To: Junjie Mao <junjie.mao@hotmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000aaaa720624fa5e70"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000aaaa720624fa5e70
Content-Type: text/plain; charset="UTF-8"

Il lun 21 ott 2024, 12:19 Junjie Mao <junjie.mao@hotmail.com> ha scritto:

>
> Paolo Bonzini <pbonzini@redhat.com> writes:
>
> > Registering the object is now done by the #[derive(Object)] macro.
>
> The module_init! macro is still necessary when a device needs more logic
> (in addition to a single type registration) in module init. That is not
> rare among the devices in C we have today.
>
> Manos and I had a conversation on this. He mentioned that he had a
> second Rust device that needs this macro [1].
>

Ok, I will change derive(Object) to use module_init! instead. What matters
is that module_init! is also fixed to not use the .ctors section.

Paolo


> [1] https://lore.kernel.org/qemu-devel/itblf.by425lac4ow@linaro.org/
>
> --
> Best Regards
> Junjie Mao
>
> >
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  rust/qemu-api/src/definitions.rs | 43 --------------------------------
> >  1 file changed, 43 deletions(-)
>
>

--000000000000aaaa720624fa5e70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 21 ott 2024, 12:19 Junjie Mao &lt;<a href=3D"ma=
ilto:junjie.mao@hotmail.com">junjie.mao@hotmail.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com" target=3D"_blank" =
rel=3D"noreferrer">pbonzini@redhat.com</a>&gt; writes:<br>
<br>
&gt; Registering the object is now done by the #[derive(Object)] macro.<br>
<br>
The module_init! macro is still necessary when a device needs more logic<br=
>
(in addition to a single type registration) in module init. That is not<br>
rare among the devices in C we have today.<br>
<br>
Manos and I had a conversation on this. He mentioned that he had a<br>
second Rust device that needs this macro [1].<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Ok, I will change derive(Objec=
t) to use module_init! instead. What matters is that module_init! is also f=
ixed to not use the .ctors section.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
[1] <a href=3D"https://lore.kernel.org/qemu-devel/itblf.by425lac4ow@linaro.=
org/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lore.kernel.o=
rg/qemu-devel/itblf.by425lac4ow@linaro.org/</a><br>
<br>
--<br>
Best Regards<br>
Junjie Mao<br>
<br>
&gt;<br>
&gt; Signed-off-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com=
" target=3D"_blank" rel=3D"noreferrer">pbonzini@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 rust/qemu-api/src/<a href=3D"http://definitions.rs" rel=3D"noref=
errer noreferrer" target=3D"_blank">definitions.rs</a> | 43 ---------------=
-----------------<br>
&gt;=C2=A0 1 file changed, 43 deletions(-)<br>
<br>
</blockquote></div></div></div>

--000000000000aaaa720624fa5e70--


