Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFEECC87FCB
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Aug 2025 09:27:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukfqZ-0002My-8i; Sat, 09 Aug 2025 05:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukfqY-0002Lc-9I
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 05:26:38 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ukfqU-0002vF-PB
 for qemu-devel@nongnu.org; Sat, 09 Aug 2025 05:26:37 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61571192c3aso3467843a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Aug 2025 02:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754731593; x=1755336393; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jUsyLeMcjo0obv2tl0deW5AH4ur98BKlIJokAb6Rhfo=;
 b=uD4r8479kL9Mzr9jb2ncQfbO0FWOuUjSdpeTvOrXp6JFMsr8eU4qsuqKX0cfh+OAPD
 Yw28gcE92Cv9uDEzUYdoSPWiN+OR8PDCYqIOJjtpoyPXfONV2Nc4+SpN+WV0mc9b+Q7b
 rPmZ1OFqe6UvpE23k3vleZd+fIrH5oiSBOgIrWzPO/WeteSpEMZmNTVgdlmnYh0K8ZMO
 uJziBCBzw4semzCR8qn+o4EgW1KtCWhAUqFDGKqUd1OO1ijCKmr8rQwQmMtNzuJTABQI
 F/w52qTxzqfXKVBNznQKrR2xMt78d3ltEkyW/dahcriNoqsebPLMKCX+heAkr/V81j3q
 MQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754731593; x=1755336393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jUsyLeMcjo0obv2tl0deW5AH4ur98BKlIJokAb6Rhfo=;
 b=H06YMahURr10xanpaEw0ZeyxMtQzmsFor/fuTIS9psdYq1UHLqzm0Yyvdq3/AhjiwK
 +7v0f7ZMch3LyEmgLAs2+q6mzeAkB8Vfz3sWfGYKLHemHdQoBIcTPPePeYnZlAeOj0Fn
 iofeCy6ftEDkbw+jWoAKT2YvYhG/cBdr/JPmCF7IsNjd5URf3WCv2ya+F4iXqMJ6E6NU
 iGApnoK3Aa8WFDaaaEDnnXla9l0rB/vkZhdf5t2hTR82AKRF9tmVkZvQZokXqASUrR9z
 jfnOoPIWH5vaGHwn3jMAjSjhlveo4PNsin3KvUXpdwpGq3C6qa7m57GRsZRKzuI7fVlM
 4vWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW48dtS7Uz0jN8iyx3kHxMcDjGySqB7JqdVjmVFxz2q+dzWW8amT1c+xGdFCoRcS1ERka2zYLJ2sdV7@nongnu.org
X-Gm-Message-State: AOJu0YyoKMAEryVvyYzhwi3qTsaFAPfZA0JiH657rs3otZzrXMoxTf9S
 2DEfnaBTplT+aQq3HvcEazGJl15riwK0Cx6uqEZDh+EQ3whziJN6AU6RDmcwfgA7yIe/nZdVDG1
 COopyfFYGyET+b34zxQDOb3I2hhyWK3DytJSDKJV21A==
X-Gm-Gg: ASbGncsvu6M7SsM4uILY2ZsN+KAIa6iGEjcU5BZujJRT4OjuG2csNkNXAUkCJJiU83G
 uVmMvmd1s6nl9fDsxlC2gKAjGlJDPRr8T2swTttpnQsmy2BG7EVXVo6RLnvwiYp878AwRSUxtjC
 gcBjD39oVV5q98CPPfSKsfRixrQQIzqUPNaskCzvVVvnusCjARGkae3F0SUgxnXxUSqufT3Ib0a
 cDeWI86puEO2U6R1RsqT/TO4yztSUYkfw5Q92Y=
X-Google-Smtp-Source: AGHT+IHCxPYB+yrG1oYIRgnyfrsnRfmCjaMy5oLq1sBiHxuro4UBb6ZEO61vAoV/jhnqx05JIIMy1/4SHQS7sMioxDQ=
X-Received: by 2002:a05:6402:1d50:b0:618:13d0:93e2 with SMTP id
 4fb4d7f45d1cf-61813d0a197mr108054a12.9.1754731592931; Sat, 09 Aug 2025
 02:26:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
 <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com> <aJb3C8qbXQ1zx306@intel.com>
 <CABgObfaVoYi09-HkwojkJT_-AJosdKNPwxMySHn6yn2cuS1Z5g@mail.gmail.com>
In-Reply-To: <CABgObfaVoYi09-HkwojkJT_-AJosdKNPwxMySHn6yn2cuS1Z5g@mail.gmail.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sat, 9 Aug 2025 12:26:20 +0300
X-Gm-Features: Ac12FXxeNrZjgSNWAZbp1R4IcB95KRnfOyV27uiYoVxS5-R_lud7nxBU-KTcS0E
Message-ID: <CAAjaMXbHOTj1ed=sbkvR=4Uhgk2TyrqaAsXAgZ6uH622cart9w@mail.gmail.com>
Subject: Re: [RFC 13/26] rust: Add RCU bindings
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>, 
 qemu-devel <qemu-devel@nongnu.org>, qemu-rust@nongnu.org, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
Content-Type: multipart/alternative; boundary="00000000000045effb063beb492d"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000045effb063beb492d
Content-Type: text/plain; charset="UTF-8"

On Sat, 9 Aug 2025, 12:13 Paolo Bonzini, <pbonzini@redhat.com> wrote:

>
>
> Il sab 9 ago 2025, 09:00 Zhao Liu <zhao1.liu@intel.com> ha scritto:
>
>> >     pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
>> >         unsafe {
>> >             self.raw_get().as_ref()
>> >         }
>> >     }
>> > }
>> >
>> > Using this is a bit ugly, because you need transmute, but it's isolated:
>> >
>> > impl AddressSpace {
>> >    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {
>>
>> IIUC, this lifetime is using the "branded type" pattern as ParentInit.
>>
>
> No, it's much simpler (that one uses the combination of for<'identity> and
> PhantomData as explained in the comment). It says that the lifetime of the
> returned reference cannot exceed the guard. It's just like
>
> pub fn get_item(&self, array: &'g [u8]) -> &'g u8 {
>    &array[self.0]
> }
>
> Except that the guard is only there to limit the lifetime and not to hold
> data.
>
> In addition, about rcu_read_lock_held(), I thought at C side, there're
>> so many comments are saying "Called within RCU critical section" but
>> without any check.
>>
>> So I wonder whether we should do some check for RCU critical section,
>> just like bql check via `assert!(bql_locked())`. Maybe we can have a
>> Rcu debug feature to cover all these checks.
>>
>
> In Rust you would just pass a &RcuGuard into the function (or store it in
> a struct) for a zero-cost assertion that you are in the RCU critical
> section.
>

Agreed. You could put debug_asserts for sanity check for good measure.

Paolo
>
>
>> Thanks,
>> Zhao
>>
>>
>>

--00000000000045effb063beb492d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, 9 Aug 2025, 12:13 Paolo =
Bonzini, &lt;<a href=3D"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">Il sab 9 ago 2025, 09:00 Zhao Liu &lt;<a href=3D"mailto:zh=
ao1.liu@intel.com" target=3D"_blank" rel=3D"noreferrer">zhao1.liu@intel.com=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex">&gt;=C2=A0 =C2=A0 =C2=A0pub fn get&lt;&#39;g&gt;(&amp;self, _: &amp;&#=
39;g RcuGuard) -&gt; Option&lt;&amp;&#39;g T&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0unsafe {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.raw_get().as_ref()=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0}<br>
&gt; }<br>
&gt; <br>
&gt; Using this is a bit ugly, because you need transmute, but it&#39;s iso=
lated:<br>
&gt; <br>
&gt; impl AddressSpace {<br>
&gt;=C2=A0 =C2=A0 pub fn get_flatview(&amp;self, rcu: &amp;&#39;g Guard) -&=
gt; &amp;&#39;g FlatView {<br>
<br>
IIUC, this lifetime is using the &quot;branded type&quot; pattern as Parent=
Init.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"a=
uto">No, it&#39;s much simpler (that one uses the combination of for&lt;&#3=
9;identity&gt; and PhantomData as explained in the comment). It says that t=
he lifetime of the returned reference cannot exceed the guard. It&#39;s jus=
t like</div><div dir=3D"auto"><br></div><div dir=3D"auto">pub fn get_item(&=
amp;self, array: &amp;&#39;g [u8]) -&gt; &amp;&#39;g u8 {</div><div dir=3D"=
auto">=C2=A0 =C2=A0&amp;array[self.0]</div><div dir=3D"auto">}</div><div di=
r=3D"auto"><br></div><div dir=3D"auto">Except that the guard is only there =
to limit the lifetime and not to hold data.</div><div dir=3D"auto"><br></di=
v><div dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">In addition, about rcu_read_lock_held(), I thought at=
 C side, there&#39;re<br>
so many comments are saying &quot;Called within RCU critical section&quot; =
but<br>
without any check.<br>
<br>
So I wonder whether we should do some check for RCU critical section,<br>
just like bql check via `assert!(bql_locked())`. Maybe we can have a<br>
Rcu debug feature to cover all these checks.<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">In Rust you would just pass a &=
amp;RcuGuard into the function (or store it in a struct) for a zero-cost as=
sertion that you are in the RCU critical section.</div></div></blockquote><=
/div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Agreed. You could =
put debug_asserts for sanity check for good measure.</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_containe=
r"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"auto"><div=
 dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks,<br>
Zhao<br>
<br>
<br>
</blockquote></div></div></div>
</blockquote></div></div></div>

--00000000000045effb063beb492d--

