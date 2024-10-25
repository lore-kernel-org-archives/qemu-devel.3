Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6334AD149F1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Qp1-0000U6-6O; Fri, 25 Oct 2024 16:22:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qoz-0000Tc-80
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:22:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qox-0003AW-FH
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:22:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729887725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0978w3aST41QOLq/hPX3iakJZtBOoQor5vEInkaHBHg=;
 b=ZF8AuGZ9QBYnKqcdmmzabDc0wEvGxrlh2F7Vz/UuL3vfEnUfDA1iNDcD66MsAO6xoiZSu+
 dgO+0bSMlYNK3aI6/vqZSeEGntBQTNvyguZeP1sB66RQgUs1s8aP5JV5HB7yyX4pQjqBIi
 d8M7vEbAOvMLbtzqvd7TIdyct9wiV1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-ANInCKLLNaOIUStmcaGBrQ-1; Fri, 25 Oct 2024 16:22:02 -0400
X-MC-Unique: ANInCKLLNaOIUStmcaGBrQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so1222418f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:22:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729887722; x=1730492522;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0978w3aST41QOLq/hPX3iakJZtBOoQor5vEInkaHBHg=;
 b=nsoTSLGxKmf2z93npp/kIdvl1IBGJGt7NBMvIWYyDMPPq/H1+hM2CYG9ifdqCyLKbF
 Dy/exNi9ELOGlfqL1nAV+jthcsIrnA+RjKvmz5l88JsywNfvaDERfKP5V0SBCIIBeeVF
 DTRes6FbX8zoWsFwy+JpW+EvDqf61TeJysyDQ09zJUzsXXOqFI6VboP3+OhcbDnBp9t3
 8LyNx3ZyhhHvXZHtUBIAFwwXQ9g2QWuc/RDT6gj5Nyvy21DlpXdF3frYvRl8fiBaR94B
 Hz+YXashutcu5NpSn4ZfqBppw9uyR7niWJUZrcHtETkmaBZgtM4bmUd/1Satj09Js+EG
 UtYw==
X-Gm-Message-State: AOJu0YwUKQUv8FnIoYL1cWCVBDDsAJhQYxFp+7OyNrMqDR4XjZHqKOmK
 DRisS0ndZb6zBz2kCr5m4mY0B+ZqILyAGkp8x4tjSDlMoEZrO2Np7wXopOAkX5+YFx0ENuD0F/c
 Sv73KbHjY860iEg76YkfWoxltQA8W76TwjulxKqkMCIgQWBoDhWrxzyIA1yyicPIfWgmiMzBM/9
 q0WZyk8x30DMAWy0i/FMXs6/Bi97Q=
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-380611585f8mr445365f8f.23.1729887721702; 
 Fri, 25 Oct 2024 13:22:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTtb6XEg1nb/54rr1bH/IVxpOqCOxGpsjte5kWNRCmy1rJa9vYRZCYt28wizRY0BdMwg4bPQM7qvz5huOFsWM=
X-Received: by 2002:a5d:4a11:0:b0:374:c92e:f6b1 with SMTP id
 ffacd0b85a97d-380611585f8mr445351f8f.23.1729887721297; Fri, 25 Oct 2024
 13:22:01 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
 <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
 <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
 <91bedb1f-8c66-4dac-ae1f-bbf0769293b6@linaro.org>
 <CABgObfZAccOxgDDGcgM9nNWbg5rTng-eddLGY60=Bdn2FVzcOQ@mail.gmail.com>
 <20e6ac63-3580-4472-a6c4-b43df2ca3269@linaro.org>
In-Reply-To: <20e6ac63-3580-4472-a6c4-b43df2ca3269@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 22:21:50 +0200
Message-ID: <CABgObfYtfeMNR00p+6CL2Fp5HOW2UnFV7NScLyu_QDyh1533mA@mail.gmail.com>
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000002141ff062552dfab"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

--0000000000002141ff062552dfab
Content-Type: text/plain; charset="UTF-8"

Il ven 25 ott 2024, 22:14 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> > Here:
> >
> https://lore.kernel.org/qemu-devel/20241015133925.311587-2-berrange@redhat.com/
>
> Good. As there is no based-on tag in the cover letter, I expected this
> to apply on current master.
>

Yes, it's based on my next pull request but I didn't have time to post it
yet (see cover letter).

Paolo


> > Without this series, that patch was already installing bindgen and rustc
> > to test that --enable-rust was not enabled implicitly.
> >
> > Paolo
> >
> >      > On the other hand I expect that users will just do "cargo install
> >      > bindgen-cli", and Ubuntu is a pretty common distro, so that's
> what I
> >      > went for here.
> >
> >     It's a reasonable expectation indeed.
> >
>

--0000000000002141ff062552dfab
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 ott 2024, 22:14 Pierrick Bouvier &lt;<a href=
=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt=
; Here: <br>
&gt; <a href=3D"https://lore.kernel.org/qemu-devel/20241015133925.311587-2-=
berrange@redhat.com/" rel=3D"noreferrer noreferrer" target=3D"_blank">https=
://lore.kernel.org/qemu-devel/20241015133925.311587-2-berrange@redhat.com/<=
/a><br>
<br>
Good. As there is no based-on tag in the cover letter, I expected this <br>
to apply on current master.<br></blockquote></div></div><div dir=3D"auto"><=
br></div><div dir=3D"auto">Yes, it&#39;s based on my next pull request but =
I didn&#39;t have time to post it yet (see cover letter).</div><div dir=3D"=
auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><d=
iv dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
<br>
&gt; Without this series, that patch was already installing bindgen and rus=
tc <br>
&gt; to test that --enable-rust was not enabled implicitly.<br>
&gt; <br>
&gt; Paolo<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; On the other hand I expect that users will ju=
st do &quot;cargo install<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; bindgen-cli&quot;, and Ubuntu is a pretty com=
mon distro, so that&#39;s what I<br>
&gt;=C2=A0 =C2=A0 =C2=A0 &gt; went for here.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0It&#39;s a reasonable expectation indeed.<br>
&gt; <br>
</blockquote></div></div></div>

--0000000000002141ff062552dfab--


