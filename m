Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91A9AD609B0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 08:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGDSg-0002XK-9r; Wed, 27 Nov 2024 03:31:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGDSd-0002WW-VK
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:31:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tGDSc-000358-41
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:31:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732696304;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i/kAF2bOR3Sw21jrF8mK8kWHFTspNBiObUReESKuk1Q=;
 b=SGDr3oNM7ynjet38OSRjHjD00XQo6eErwtDMLpFGdjVS6f6Hy4slI/kcPhQmO6PIzqUb3x
 pdOq2Ksi4ntwg0hTa8ROnuBvbarU5sXGSxKb2QGJ0T1fL28bsXDnP2/xmP5KQQFYG9iy6w
 p5M1U81N/6KnsfEQvurhAfKrqWfWEMQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Fb9dmCcDNtSsNzQo9sdGbg-1; Wed, 27 Nov 2024 03:31:42 -0500
X-MC-Unique: Fb9dmCcDNtSsNzQo9sdGbg-1
X-Mimecast-MFC-AGG-ID: Fb9dmCcDNtSsNzQo9sdGbg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4349e97bfc4so31034815e9.3
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 00:31:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732696300; x=1733301100;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/kAF2bOR3Sw21jrF8mK8kWHFTspNBiObUReESKuk1Q=;
 b=godXp5PLxFbKNozTu9VlDuaZPk+cHVRslekSn+Oj5QM3JiJ/kBHWB0Y4qK4Y1p4EJ2
 KOOKuyB5gcLFNe6MfysvB5TetGDagG7y8U2UyoCPSTM/3jLeU6ZkNykJFStx0zsffPUY
 IRTA6VY5bUZI6u9tvbDAnIadMkUP8Kpic1mh6LF4i30+RKr3TiUI4FdRusxG4MPXwMk2
 pOoSyr9iaQr7sDvOSaqtnZw+FvuMpQc4ZgPN3QRziAz5O0jL1L3kDOPwJF4TseS9iBNG
 yE/wBXE9Pk8OsIsEZdMJFExBZMQdcOkPbv1tMjNlVwAzywYJCm0T/DUArk4Kd8jKl6NS
 SL5A==
X-Gm-Message-State: AOJu0Ywffqp0sio4e/oam9jc9+eHJDOEuvB+R8nuByjZJYM2IxDNPk/8
 MM+RZnPdw5FECtUvGslDZiwHSeIqwyx+x6ckYLlhf8ezGm5LB+2ZdBZELkefed7XVzdTYjADx2S
 zOOP3kYSw7SXhWGlzfBgZorwnsG2xZd1vCGWV4dkPcpzZaJBfelxnxt5+bK+Mrp5l8pDwW6FkcQ
 2vDRV+XeeWOdxtVu8cI6EXFE8fzJv+3OzB4kA=
X-Gm-Gg: ASbGncuuO2Bu42jMURy85OPVG7ncXW/ngzqdZvW9w4mQstF0lzqpcJCWlCg2noS7awt
 hs9ExGIAcfen+I9fUB8AitXydQVA0sStu
X-Received: by 2002:a05:600c:1d20:b0:434:a5c2:53c1 with SMTP id
 5b1f17b1804b1-434a9de8bd4mr17157285e9.23.1732696300568; 
 Wed, 27 Nov 2024 00:31:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGq6omVHiWBtSHZjX4Rp2nSfSgl/KPxs++Gih4btMPvj4/HWJcjSfWGP4rJgEaqXixC+mYDYpzWsqtfk06uw/g=
X-Received: by 2002:a05:600c:1d20:b0:434:a5c2:53c1 with SMTP id
 5b1f17b1804b1-434a9de8bd4mr17157105e9.23.1732696300197; Wed, 27 Nov 2024
 00:31:40 -0800 (PST)
MIME-Version: 1.0
References: <20241122074756.282142-1-pbonzini@redhat.com>
 <20241122074756.282142-2-pbonzini@redhat.com>
 <Z0XhhB48W4Nqagku@intel.com> <1d0e1b5f-36ad-41d4-b526-260fa5cd0b34@redhat.com>
 <Z0a9uPLxrGyVJJwB@intel.com>
In-Reply-To: <Z0a9uPLxrGyVJJwB@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 27 Nov 2024 09:31:28 +0100
Message-ID: <CABgObfZXWKZ8hhH4FmZjZg+9VkSh1+DXPzDs0sMzFyd+yaTuTA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: add BQL-enforcing Cell variant
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-rust@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000007a2f700627e0cba1"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
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

--0000000000007a2f700627e0cba1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il mer 27 nov 2024, 07:17 Zhao Liu <zhao1.liu@intel.com> ha scritto:

> > and a single "regs: BqlRefCell<PL011Registers>" in PL011State.
>
> Here I have a possibly common question about the choice of BqlCell and
> future BqlRefCell. Pls refer my comment below...
>
> I understand we need BqlRefCell instead of BqlCell for registers since
> there may be more than one reference, e.g., callbacks from CharBackend
> and MemoryRegion may hold multiple references at the same time, right?
>
> If right, like HPET, with only MemoryRegion callbacks, reads and writes
> I guess which should not be able to happen at the same time, so BqlCell
> is also feasible, as is Irq?
>

Choose between BqlCell/BqlRefCell like you would choose between
Cell/RefCell. They result in different code so pick what looks better.

That said for HPET you have the array of timers structs, and these structs
are not Copy, and therefore BqlRefCell is almost the only choice for that
array. With BqlRefCell used for the timers you might as well put the other
registers in the same BqlRefCell.

(This piece of the thread model is a bit more complex, and I'm fully
> aware that the right TYPE relies a lot on understanding the underlying
> mechanism, which I'm not yet familiar enough with :-) ).
>

It's not too complex=E2=80=94the point is to make it as similar as possible=
 to
normal single threaded Rust.

However, all in all, using BqlRefCell for register fields looks to be
> always better than BqlCell.
>

Yep :)

Thank you! I'll change the current code to support this. Instead of
> implementing a register space like PL011, I continue to handle registers
> with u64 variables and bit macro definitions like the C version


That's fine. Experimenting in different directions makes it easier for
future developers to evaluate the tradeoffs.

Also related to the above question, I'm a bit hesitant to use BqlCell
> directly
> or RefCell for such u64 fields...
>

Do whatever looks best to you!

> Plus, speaking in general, "it does something in a different way than the
> > pl011 device model" is a good reason to merge the HPET model earlier
> too. :)
>
> There must be a lot more opens :-(, such as the memattrs/timer binding,
> which I hope to discuss with you at the later RFC!
>

Yes, but stuff like "correctly uses interior mutability" is a very good
reason to include the HPET early.

I will send the next version and include BqlRefCell once I incorporate
Junjie's feedback, in the meanwhile I will send you the BqlRefCell patch
off list.

Paolo

--0000000000007a2f700627e0cba1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D=
"gmail_attr">Il mer 27 nov 2024, 07:17 Zhao Liu &lt;<a href=3D"mailto:zhao1=
.liu@intel.com">zhao1.liu@intel.com</a>&gt; ha scritto:<br></div><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">&gt; and a single &quot;regs: BqlRe=
fCell&lt;PL011Registers&gt;&quot; in PL011State.<br>
<br>
Here I have a possibly common question about the choice of BqlCell and<br>
future BqlRefCell. Pls refer my comment below...<br>
<br>I understand we need BqlRefCell instead of BqlCell for registers since<=
br>
there may be more than one reference, e.g., callbacks from CharBackend<br>
and MemoryRegion may hold multiple references at the same time, right?<br>
<br>
If right, like HPET, with only MemoryRegion callbacks, reads and writes<br>
I guess which should not be able to happen at the same time, so BqlCell<br>
is also feasible, as is Irq?<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Choose between BqlCell/BqlRefCell like you woul=
d choose between Cell/RefCell. They result in different code so pick what l=
ooks better.</div><div dir=3D"auto"><br></div><div dir=3D"auto">That said f=
or HPET you have the array of timers structs, and these structs are not Cop=
y, and therefore BqlRefCell is almost the only choice for that array. With =
BqlRefCell used for the timers you might as well put the other registers in=
 the same BqlRefCell.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
(This piece of the thread model is a bit more complex, and I&#39;m fully<br=
>
aware that the right TYPE relies a lot on understanding the underlying<br>
mechanism, which I&#39;m not yet familiar enough with :-) ).<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">It&#39;s not to=
o complex=E2=80=94the point is to make it as similar as possible to normal =
single threaded Rust.</div><div dir=3D"auto"><br></div><div dir=3D"auto"><d=
iv class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:=
0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">=
However, all in all, using BqlRefCell for register fields looks to be<br>
always better than BqlCell.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Yep :)</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Thank you! I&#39;ll change the current code to support this. In=
stead of<br>
implementing a register space like PL011, I continue to handle registers<br=
>
with u64 variables and bit macro definitions like the C version</blockquote=
></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">That&#39;s fine.=
 Experimenting in different directions makes it easier for future developer=
s to evaluate the tradeoffs.</div><div dir=3D"auto"><br></div><div dir=3D"a=
uto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">Also related to the above question, I&#39;m a bit hesitant to use Bq=
lCell directly<br>
or RefCell for such u64 fields...<br></blockquote></div></div><div dir=3D"a=
uto"><br></div><div dir=3D"auto">Do whatever looks best to you!</div><div d=
ir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">&gt; Plus, speaking in general, &=
quot;it does something in a different way than the<br>
&gt; pl011 device model&quot; is a good reason to merge the HPET model earl=
ier too. :)<br>
<br>
There must be a lot more opens :-(, such as the memattrs/timer binding,<br>
which I hope to discuss with you at the later RFC!<br></blockquote></div></=
div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, but stuff like &quot=
;correctly uses interior mutability&quot; is a very good reason to include =
the HPET early.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I will s=
end the next version and include BqlRefCell once I incorporate Junjie&#39;s=
 feedback, in the meanwhile I will send you the BqlRefCell patch off list.<=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div></div>

--0000000000007a2f700627e0cba1--


