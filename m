Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C6AC3271E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 18:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQtQA-0000wv-Jm; Mon, 08 Jul 2024 14:49:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQtQ8-0000uK-BM
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQtQ5-00059X-Ik
 for qemu-devel@nongnu.org; Mon, 08 Jul 2024 14:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720464540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XCKeTPJM1uOgiEAYLdi2zdyuXjCbfePxhCULzW8U4yI=;
 b=GtNLalKR0HQ0UlrxTM2h6A1OUo5z4kNLEmlGj/NET3YSy2iTkYETywD1H9pnoiJJeqwFws
 +QxajtR2dnnAFE0XlmLR3cSzuQlfeuqOuICuphCDFkruVqMMGCdIb1I9J9+S3AZ18lL48Q
 Y/DlQgcRPzNIvnBYxIRDLhcuGhaua+E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-VoLm7bkDMVKbJMOciG0o7Q-1; Mon, 08 Jul 2024 14:48:58 -0400
X-MC-Unique: VoLm7bkDMVKbJMOciG0o7Q-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-36789dfcc8bso2685039f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2024 11:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720464537; x=1721069337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCKeTPJM1uOgiEAYLdi2zdyuXjCbfePxhCULzW8U4yI=;
 b=RTKJ9ReCfjrnVeWRIERX6Aa0FxFbbnB6BJUNvldYhpzGpCC683OdvQSFxrcDqOsyHN
 LGaKW25ZtgDjDqmeLmRSLTL/OUBCbCFB75hkXG/6EvdOZ/jdgk1jr3sbIZWOk7MZNqtq
 PI9RvtnBZrPrxSFaXJUEMjZopAbmKmda2DpdXnhUem2SdKHVwZvBNbPh7vM2NPQqxCES
 Gh2ZHLNSeQpoGq6WJw3xYj9dCFJWPvClsFxd8byvbAsBPEbk7pZYdKuYaGorIySDm1is
 ObPNwODekKl/5APtuu1KLgj7Jtsx5qUxgGo5W+L0DUWUwTr+lAguJevL7FXarZtBMLhS
 crHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbgdBByWRux/zYEUpm8K7OSCURM4ia889zpQLStuModfq/HfZNeYNJKvHb4X5LBwc1P1s6DrUwQMFHB+YpyLNpZUSLBMA=
X-Gm-Message-State: AOJu0YxOM012JJ1o1ptPevs1r3PiE0SguAaRJn8SoDw7n6i5ewyplOL9
 EiyRdKFJjaj/Qo3QXZH4qUNJ8CS/2OcwUBOubhlMsSXksNoTiFZb8gRFZ/k1uLHBCnrbJUdJJLg
 hacJkWKde6RDw7W98Q4j9v757I7ZOivZ7EsyKhiytcU0w0zotyueYNYgLu5O0PFffTWgLMJt6SM
 JNGeeu1J3vmrxFsY2O16b1UTHNmHk=
X-Received: by 2002:a5d:5f88:0:b0:367:402f:805b with SMTP id
 ffacd0b85a97d-367cea46b51mr406481f8f.2.1720464537394; 
 Mon, 08 Jul 2024 11:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtod3DKVgmGTdIozSlSCF8PM97gw4/o3du1gYSnm6trVTT+pwUyF3N1e/Xht5EsVgfeUxqMP6HqrOoae7LzC4=
X-Received: by 2002:a5d:5f88:0:b0:367:402f:805b with SMTP id
 ffacd0b85a97d-367cea46b51mr406469f8f.2.1720464537096; Mon, 08 Jul 2024
 11:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <rust-pl011-rfc-v4.git.manos.pitsidianakis@linaro.org>
 <8dfd1047-436d-4157-83cb-9cad399544fe@redhat.com>
 <ZowUyFX7zcK1FvuG@redhat.com>
 <CABgObfZfQNSeYeCqcuNHcu=pyKz+f_MUc=9rZGRYxaPNBO-U4A@mail.gmail.com>
 <Zowd-UxAnPmJSA0G@redhat.com>
 <CABgObfaDKhKBcpmgypST=bo2KSqoNMCLKP-8oAvppxt9GDxBPA@mail.gmail.com>
 <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
In-Reply-To: <CAAjaMXa6E0koPXcytY9hEuUbhLeFcJqZsA3fz10q_HF0grz24w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 8 Jul 2024 20:48:45 +0200
Message-ID: <CABgObfa8KQOu6RPs1aqKww8qPeOjHppbH15aBCN+KvaOL=_W9A@mail.gmail.com>
Subject: Re: [RFC PATCH v4 0/7] Add Rust support, implement ARM PL011
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 Mads Ynddal <mads@ynddal.dk>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Gustavo Romero <gustavo.romero@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, rowan.hart@intel.com, 
 Richard Henderson <richard.henderson@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000095266d061cc0ddab"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

--00000000000095266d061cc0ddab
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 8 lug 2024, 20:39 Manos Pitsidianakis <manos.pitsidianakis@linaro.or=
g>
ha scritto:

>
>
> On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, <pbonzini@redhat.com> wrote:
>
>>
>>
>> Il lun 8 lug 2024, 19:12 Daniel P. Berrang=C3=A9 <berrange@redhat.com> h=
a
>> scritto:
>>
>>> That's exactly why I suggest its a pre-requisite for merging
>>> this. Unless we're able to demonstrate that we can enable
>>> Rust on all our CI platforms, the benefits of Rust will
>>> not be realized in QEMU, and we'll have never ending debates
>>> about whether each given feature needs to be in C or Rust.
>>>
>>
>> In that case we should develop it on a branch, so that more than one
>> person can contribute (unlike if we keep iterating on this RFC).
>>
>
> If you do, I'd really appreciate it if you did not use any part of my
> patches.
>

"We" means that you would accept patches, review them and apply them until
any agreed-upon conditions for merging are satisfied, and then send either
a final series or a pull request for inclusion in QEMU.

Paolo

--00000000000095266d061cc0ddab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 8 lug 2024, 20:39 Manos Pitsidianakis &lt;<a hr=
ef=3D"mailto:manos.pitsidianakis@linaro.org">manos.pitsidianakis@linaro.org=
</a>&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:=
1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"=
ltr" class=3D"gmail_attr">On Mon, 8 Jul 2024, 21:34 Paolo Bonzini, &lt;<a h=
ref=3D"mailto:pbonzini@redhat.com" target=3D"_blank" rel=3D"noreferrer">pbo=
nzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><=
div dir=3D"ltr" class=3D"gmail_attr">Il lun 8 lug 2024, 19:12 Daniel P. Ber=
rang=C3=A9 &lt;<a href=3D"mailto:berrange@redhat.com" rel=3D"noreferrer nor=
eferrer" target=3D"_blank">berrange@redhat.com</a>&gt; ha scritto:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">That&#39;s exactly why I=
 suggest its a pre-requisite for merging<br>
this. Unless we&#39;re able to demonstrate that we can enable<br>
Rust on all our CI platforms, the benefits of Rust will<br>
not be realized in QEMU, and we&#39;ll have never ending debates<br>
about whether each given feature needs to be in C or Rust.<br></blockquote>=
</div></div><div dir=3D"auto"><br></div><div dir=3D"auto">In that case we s=
hould develop it on a branch, so that more than one person can contribute (=
unlike if we keep iterating on this RFC).</div></div></blockquote></div></d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto">If you do, I&#39;d really =
appreciate it if you did not use any part of my patches.</div></div></block=
quote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">&quot;We&qu=
ot; means that you would accept patches, review them and apply them until a=
ny agreed-upon conditions for merging are satisfied, and then send either a=
 final series or a pull request for inclusion in QEMU.</div><div dir=3D"aut=
o"><br></div><div dir=3D"auto">Paolo</div></div>

--00000000000095266d061cc0ddab--


