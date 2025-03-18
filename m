Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1539BC28B28
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 06:36:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuQXo-00034N-V2; Tue, 18 Mar 2025 02:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuQXn-00033m-64
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 02:35:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuQXl-00033R-FG
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 02:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742279715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s5UkrF1x6raNDOo6sMVfKp2F/qceTUz7oGaJDjt6D84=;
 b=Qj6Df6hCwnvBdae9fuNNRLD2mTNml/mK3S3dQuKBXMJKYWvRmm9jvYsddX8+7yl7AOkzi1
 P4bLPeYiBah9THP2WNbsBkt6nvF/zvjOR5NlcfPJjD2gTckqPguIA6zFSbMudQ+7163EJl
 qONZTiU8Crw5t8l8rRpA77DQIIZobMU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-3NCfGmsmP9-1Eub0T6_5Hw-1; Tue, 18 Mar 2025 02:35:13 -0400
X-MC-Unique: 3NCfGmsmP9-1Eub0T6_5Hw-1
X-Mimecast-MFC-AGG-ID: 3NCfGmsmP9-1Eub0T6_5Hw_1742279712
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3913f97d115so2463148f8f.0
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 23:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742279710; x=1742884510;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s5UkrF1x6raNDOo6sMVfKp2F/qceTUz7oGaJDjt6D84=;
 b=Fje35UJQiIdQC3j5JXsuRvQQ7+xY12pHxFGUp+/V9vvW/pgYRAVkGebVBXVIsfqhtj
 Z0IZpSEyLrzpVwCD/U5mTTjRnKXADOm5aXUJz233ChoWdJLi3Rj4eQF6pgSBq05A/dt7
 7RXfcLyfEup7+Nv/ts93uf3H90+2bEY59jGuB/vlWbjxeWp5TxtjTUh2Mp6I/AYut6nH
 CtYCyGb3ANb2T8sanT0KX+q0kj+c17eG1qZqM6xve0peKyMebleINfuh44Pj5xWXgT/5
 6bNUlq0T1ci0fXByFTv+cPQ5gXuCrNv7TnZMo3e7T9/dhI23liGUtGE1L3Hh2x+OopKS
 erWQ==
X-Gm-Message-State: AOJu0Yz4T1vQj81fWIvW3WyNJ7crC7bJVWqAANGQY+WruOBuqI+4JV8k
 q9/vvcKTY8XY9OAumE6cKRIQOsRwJat8pS//BDM53uOvkwIISLhq4djYUACnDC6gyQLDzJEcrbI
 ATfWcjhA7TM24CPHydkSbrQVV8D8BLltKG7eod5lUCdohQrVjt50VO6q4/1W0FboCED+IV5xZJX
 0+Om6nWtYcKPliWsts0yv2FiVGQW5nLbKSwEo=
X-Gm-Gg: ASbGncsXRCezFUuAQrzzVnOUu5dCrE2oXtz/bw/heGLGNH/BG6LeMFmi5KCVrhD32+b
 n+VO/N6So2qaUK10aPIdaixe1NcTKUoJHcnENt8gfhCvdW67o3TsNLdd6ABIGUHjd5gCkkxJyXg
 ==
X-Received: by 2002:a5d:6c6e:0:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-3996b92ca42mr1774350f8f.1.1742279710155; 
 Mon, 17 Mar 2025 23:35:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPP6dS3GYeVr74+FuPmXa2eYi/WtP+nxO/osna7UNTn0t+a65GNkLlNL6LHJmyyWMQV2zAVyuWxQXAg4varBU=
X-Received: by 2002:a5d:6c6e:0:b0:38a:4184:14ec with SMTP id
 ffacd0b85a97d-3996b92ca42mr1774330f8f.1.1742279709817; Mon, 17 Mar 2025
 23:35:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250317151236.536673-1-zhao1.liu@intel.com>
 <20250317151236.536673-14-zhao1.liu@intel.com>
 <CABgObfauvyAbmt7GewurAEw9d+HanhjvDa1tT=S_4Oo9Huty0g@mail.gmail.com>
 <Z9kUdJUP0JrkcKMJ@intel.com>
In-Reply-To: <Z9kUdJUP0JrkcKMJ@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Mar 2025 07:34:58 +0100
X-Gm-Features: AQ5f1JpQ5NdFhOqqnujIQvIIju01LE5FSOgsL4cCIajwnBGxaYlHdXnUmioQQj0
Message-ID: <CABgObfZgpYa6CohM7t=1mnoJh3mZ++QqzZw9gFCabiHL8wOoBg@mail.gmail.com>
Subject: Re: [PATCH 13/17] rust/vmstate: Support vmstate_validate
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000003414f60630981b70"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--0000000000003414f60630981b70
Content-Type: text/plain; charset="UTF-8"

Il mar 18 mar 2025, 07:16 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > Would it be possible, or make sense, to move most of the code for
> > field_exists inside .with_exist_check()?
> >
>
> If so, the method would be like:
>
>     pub fn with_exist_check<T, F>(
>          mut self,
>          _cb: F
>      ) -> Self
>      where
>          F: for<'a> FnCall<(&'a T, u8), bool>,
>
> Then the use case could be like:
>
>     vmstate_struct!(HPETState, timers[0 .. num_timers],
> &VMSTATE_HPET_TIMER,
> BqlRefCell<HPETTimer>).with_exist_check<HPETState, _>(foo_field_check),
>
> Here we need to specify the structure type in with_exist_check, though it's
> already specified in vmstate_struct as the first field.
>
> In this way, I understand with_exist_check() doesn't need phantom__()
> trick.
>
> Instead, (after I dropped the few patches you mentioned,) now vmstate_of
> & vmstate_struct could accept the optional "test_fn" field (luckily, at
> least test_fn can still be parsed!), then the example would be:
>
>     vmstate_struct!(HPETState, timers[0 .. num_timers],
> &VMSTATE_HPET_TIMER,
> BqlRefCell<HPETTimer>, foo_field_check)
>
> And in this way, phantom__() is necessary.
>
> So I think the main issue is the format, which do you prefer?
>

For now I would leave out a generic field-exists check, and keep the
implementation of vmstate_validate as you did it in v1.

Once we look more in the builder concept we can think of adding also a
VMStateField<T> (with a PhantomData<fn(&T) -> bool> inside) and add
with_field_exists().

Paolo


> Thanks,
> Zhao
>
>

--0000000000003414f60630981b70
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">Il mar 18 mar 2025, 07:16 Zhao L=
iu &lt;<a href=3D"mailto:zhao1.liu@intel.com">zhao1.liu@intel.com</a>&gt; h=
a scritto:</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; Would it be possible, or make sense, to move most of the code for<br>
&gt; field_exists inside .with_exist_check()?<br>
&gt; <br>
<br>
If so, the method would be like:<br>
<br>
=C2=A0 =C2=A0 pub fn with_exist_check&lt;T, F&gt;(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mut self,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_cb: F<br>
=C2=A0 =C2=A0 =C2=A0) -&gt; Self<br>
=C2=A0 =C2=A0 =C2=A0where<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0F: for&lt;&#39;a&gt; FnCall&lt;(&amp;&#39=
;a T, u8), bool&gt;,<br>
<br>
Then the use case could be like:<br>
<br>
=C2=A0 =C2=A0 vmstate_struct!(HPETState, timers[0 .. num_timers], &amp;VMST=
ATE_HPET_TIMER,<br>
BqlRefCell&lt;HPETTimer&gt;).with_exist_check&lt;HPETState, _&gt;(foo_field=
_check),<br>
<br>
Here we need to specify the structure type in with_exist_check, though it&#=
39;s<br>
already specified in vmstate_struct as the first field.<br>
<br>
In this way, I understand with_exist_check() doesn&#39;t need phantom__()<b=
r>
trick.<br>
<br>
Instead, (after I dropped the few patches you mentioned,) now vmstate_of<br=
>
&amp; vmstate_struct could accept the optional &quot;test_fn&quot; field (l=
uckily, at<br>
least test_fn can still be parsed!), then the example would be:<br>
<br>
=C2=A0 =C2=A0 vmstate_struct!(HPETState, timers[0 .. num_timers], &amp;VMST=
ATE_HPET_TIMER,<br>
BqlRefCell&lt;HPETTimer&gt;, foo_field_check)<br>
<br>
And in this way, phantom__() is necessary.<br>
<br>
So I think the main issue is the format, which do you prefer?<br></blockquo=
te></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">For now I woul=
d leave out a generic field-exists check, and keep the implementation of vm=
state_validate as you did it in v1.</div><div dir=3D"auto"><br></div><div d=
ir=3D"auto">Once we look more in the builder concept we can think of adding=
 also a VMStateField&lt;T&gt; (with a PhantomData&lt;fn(&amp;T) -&gt; bool&=
gt; inside) and add with_field_exists().</div><div dir=3D"auto"><br></div><=
div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><=
div class=3D"gmail_quote gmail_quote_container"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">
<br>
Thanks,<br>
Zhao<br>
<br>
</blockquote></div></div></div>

--0000000000003414f60630981b70--


