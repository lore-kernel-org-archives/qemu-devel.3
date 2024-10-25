Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4516DD149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 20:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Qc0-00015y-UW; Fri, 25 Oct 2024 16:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qbz-00015U-Ag
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t4Qbx-00011F-Mc
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 16:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729886919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tUSdDWohaFsSrSkrk8bCfmP1qrtEJ4bnO7m+zDZglBM=;
 b=TfmqubY8mgg1wAz2VdjR5PLphqWyw0NM2GqTS4W2nCJIaC4KG4o+27w5z5WMRrbMO1nOaP
 7k5+UwLrMVaXu/lLVC0Fc9YEOYU9SOmYPirJAPeBGAm/13x/2eS4+wPl7o4Rd5byhr1SLm
 QOAky8LGGugNzjfw23V2c21Xur6A5IM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-2KgsB-UYNAeXZArP0NVisA-1; Fri, 25 Oct 2024 16:08:36 -0400
X-MC-Unique: 2KgsB-UYNAeXZArP0NVisA-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4316300bb15so16591835e9.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 13:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729886915; x=1730491715;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tUSdDWohaFsSrSkrk8bCfmP1qrtEJ4bnO7m+zDZglBM=;
 b=p35R/tayWyjZUsf95Uth9BaNB85yg+VJ+RCPMFGdtIwdY8ixYAM3QfNfamu4baVIxN
 mg7BoobwOquXFFDaAG7U2fUgyVAo6/K5plYG4mU41L8ofAJCY5HVOMvMg4trZmVoac+q
 4FaVrw8cXcpWhs0qPeFCEpH68tXZkpLzX+Cy+vwj/JvfDwcz6i5l0B7a2cNmfnJwXl+z
 8l+9jOJplvbPSzj+rZHkqT34HOyldcEmHN/IKzwCbE1RSaPsWfkHjZyVP6DoW/7BZ93Z
 VDuoYU5rPyUX1Tg7k8i2N0OuE9ZAzGIix3/FbSBGNNTDNLdTPhpFfrIU3KqT2a29PtZ3
 uWdA==
X-Gm-Message-State: AOJu0YzihPIRUAlIEfi9a7cF2pTnu21UifihBMfI5ljp8aDSppRXbVNn
 0Zk/18o1BjgJn1DGlWr+TdbN/URyCppj9+JvtGT/Ijo1scOZb7/dJJB9rDb91/jnWBYB0rXjHs2
 M3JJCqveVerQnQN+zoSUg1eSfVGeI4cQdLhuCTRC9xhhy+Ln1x75KITFNBnm9oFF+x+WNqm1cG8
 OpTVT5fnpnVIGS3JC8MJsovv3nh1E=
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr2905445e9.25.1729886914959; 
 Fri, 25 Oct 2024 13:08:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFTT8nImP0tZV1c9zdRaABwEZ4P0irQwyaVVCLt6VHOZdbwWBlXU+XkYflVL8XerzUO7TK7wLHk6IGyjHhivAA=
X-Received: by 2002:a05:600c:1d01:b0:42c:a6da:a149 with SMTP id
 5b1f17b1804b1-4319ad048cdmr2905265e9.25.1729886914582; Fri, 25 Oct 2024
 13:08:34 -0700 (PDT)
MIME-Version: 1.0
References: <20241025160209.194307-1-pbonzini@redhat.com>
 <20241025160209.194307-23-pbonzini@redhat.com>
 <580f10bc-4d37-4ece-b9d8-496ba66b7966@linaro.org>
 <CABgObfbhJLeAon9rfpSpFG4cwDvCEMnK+1tkmOR5-+mkSdGOUQ@mail.gmail.com>
 <91bedb1f-8c66-4dac-ae1f-bbf0769293b6@linaro.org>
In-Reply-To: <91bedb1f-8c66-4dac-ae1f-bbf0769293b6@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Oct 2024 22:08:23 +0200
Message-ID: <CABgObfZAccOxgDDGcgM9nNWbg5rTng-eddLGY60=Bdn2FVzcOQ@mail.gmail.com>
Subject: Re: [PATCH 22/23] dockerfiles: install bindgen from cargo on Ubuntu
 22.04
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, 
 Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, 
 Junjie Mao <junjie.mao@hotmail.com>, "P. Berrange,
 Daniel" <berrange@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000000bb9e1062552af30"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.454,
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

--0000000000000bb9e1062552af30
Content-Type: text/plain; charset="UTF-8"

Il ven 25 ott 2024, 21:47 Pierrick Bouvier <pierrick.bouvier@linaro.org> ha
scritto:

> >  in the end the operation of bindgen is quite deterministic, so if
> > the coverage is improved we can indeed install 0.60.x. For example, if
> > we think that user on Debian 12 might use distro bindgen together with a
> > recent rustc (in their case, rustup-installed), then installing bindgen
> > 0.60.x on Ubuntu would provide a similar effect.
> >
>
> I missed that the debian job covers this use case. So indeed, we can use
> a recent one on ubuntu.
>
> Where is the change for the debian container?
>

Here:
https://lore.kernel.org/qemu-devel/20241015133925.311587-2-berrange@redhat.com/

Without this series, that patch was already installing bindgen and rustc to
test that --enable-rust was not enabled implicitly.

Paolo

> On the other hand I expect that users will just do "cargo install
> > bindgen-cli", and Ubuntu is a pretty common distro, so that's what I
> > went for here.
>
> It's a reasonable expectation indeed.
>

--0000000000000bb9e1062552af30
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il ven 25 ott 2024, 21:47 Pierrick Bouvier &lt;<a href=
=3D"mailto:pierrick.bouvier@linaro.org">pierrick.bouvier@linaro.org</a>&gt;=
 ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt=
;=C2=A0=C2=A0in the end the operation of bindgen is quite deterministic, so=
 if <br>
&gt; the coverage is improved we can indeed install 0.60.x. For example, if=
 <br>
&gt; we think that user on Debian 12 might use distro bindgen together with=
 a <br>
&gt; recent rustc (in their case, rustup-installed), then installing bindge=
n <br>
&gt; 0.60.x on Ubuntu would provide a similar effect.<br>
&gt; <br>
<br>
I missed that the debian job covers this use case. So indeed, we can use <b=
r>
a recent one on ubuntu.<br>
<br>
Where is the change for the debian container?<br></blockquote></div></div><=
div dir=3D"auto"><br></div><div dir=3D"auto">Here: <a href=3D"https://lore.=
kernel.org/qemu-devel/20241015133925.311587-2-berrange@redhat.com/">https:/=
/lore.kernel.org/qemu-devel/20241015133925.311587-2-berrange@redhat.com/</a=
></div><div dir=3D"auto"><br></div><div dir=3D"auto">Without this series, t=
hat patch was already installing bindgen and rustc to test that --enable-ru=
st was not enabled implicitly.</div><div dir=3D"auto"><br></div><div dir=3D=
"auto">Paolo</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; On the other hand I expect that users will just do &quot;cargo install=
 <br>
&gt; bindgen-cli&quot;, and Ubuntu is a pretty common distro, so that&#39;s=
 what I <br>
&gt; went for here.<br>
<br>
It&#39;s a reasonable expectation indeed.<br>
</blockquote></div></div></div>

--0000000000000bb9e1062552af30--


