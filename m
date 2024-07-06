Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD5C2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 16:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQ8Ct-0006gu-GU; Sat, 06 Jul 2024 12:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQ8Cs-0006gU-1L
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 12:24:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sQ8Cq-0005FA-DQ
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 12:24:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720283050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQtgN5C4vGeuiBZEFnljkDTG2GYt/07n67BGrft8zuI=;
 b=Na19o+j5q8LAUnsdh2RKboc2NLtBIPVdx7bqi5v84LZybJkeVh1nQPjow9iwGfROVxRQhV
 GPe1w2gSgPpCGF4mrVIlT8x30qm6X1noORs2lQvRx4eb2G0iwVDX4vwrh2jghtSIruLILx
 eZ7GrRcL8IiWOd+b4s2xXtysHlwY6Lo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-mrbgt-5GMoeaftmYHdXySA-1; Sat, 06 Jul 2024 12:23:58 -0400
X-MC-Unique: mrbgt-5GMoeaftmYHdXySA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3678f403afaso1466504f8f.0
 for <qemu-devel@nongnu.org>; Sat, 06 Jul 2024 09:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720283037; x=1720887837;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sQtgN5C4vGeuiBZEFnljkDTG2GYt/07n67BGrft8zuI=;
 b=HcpyIQFGbt9B8OWa1y3WVV/8cjNoq7D4bCsFZPdEabhnhMuzdd7pTF2rA8rZEBzIKu
 ZYqa9EKzTFiDXm5XxIoM6mSDrFRhaxqjLS485oqPM9Nfx1lCj3xfgH8gHI6E1goCrGhq
 dUSCK1/MTaaMTu9CR5QUvms4sZJ3Jly3BTjC2Ud2mGuzjmcTIH303a5PM92YLx8H39tD
 E0G1+kQvDvU0OlFFKY3AtC561het95NRKukQB70j6sHOrQTQOXSklLE2yEP3z+DHjov1
 CDL/gLG6WGhHi9xXl2p4FOn9CND1FmYQzGifaeiY1/JZ4s0zLwqfTAX/Ut0XFJ02Th5f
 uxDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW79iU7dCKVhE5BeFxAO+16NZQw8cogxGMgUCYPi3GQ+jGre9gSGhRSQ9/zbA2VZYMXxRAn0wfb1V2Xqgsk7nCN8KhGpQo=
X-Gm-Message-State: AOJu0YzilVxANw1/pseJV9q9obng3uVkLUWuWov4t50YgSZzcok30OkX
 5WwhW/sg9ciLux9/mxXP7xUj3HAu7L3GTak2JqBEP1Sb/scXPtbTo0j8B37cxa7M1Q6JpjJ/5V2
 GX6NerchoTyIsJUwrV01/JL4GPRw15toh3NYQOyjIXouKCuPZPXnbNtYcyy8zNYGrlkWB5fp0CW
 G172GeFtPjP4y3jxY+6AW1YxfkKTk=
X-Received: by 2002:adf:ebc8:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-3679dd67a0bmr6082963f8f.52.1720283037444; 
 Sat, 06 Jul 2024 09:23:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG25Aqo2u3KFBRUXfK/Cz6gLHJBzVU9mebqMj9QWzbyz3m2qBziMDgQNylMVTHTc8KRxlKJxWHcmF1pMQoKeZQ=
X-Received: by 2002:adf:ebc8:0:b0:367:9522:5e70 with SMTP id
 ffacd0b85a97d-3679dd67a0bmr6082950f8f.52.1720283037133; Sat, 06 Jul 2024
 09:23:57 -0700 (PDT)
MIME-Version: 1.0
References: <SA1PR11MB6734CC22FDFD4F85E7887553A8D82@SA1PR11MB6734.namprd11.prod.outlook.com>
In-Reply-To: <SA1PR11MB6734CC22FDFD4F85E7887553A8D82@SA1PR11MB6734.namprd11.prod.outlook.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 6 Jul 2024 18:23:43 +0200
Message-ID: <CABgObfaG1HVQ4YEHOGy=6rX_a3cVEq5-255U6XEPSvvX0rRrwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] target/i386: add support for VMX FRED controls
To: "Li, Xin3" <xin3.li@intel.com>
Cc: "Gao, Chao" <chao.gao@intel.com>, Eduardo Habkost <eduardo@habkost.net>, 
 "Anvin, H. Peter" <hpa@zytor.com>, kvm <kvm@vger.kernel.org>,
 qemu-devel <qemu-devel@nongnu.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sean Christopherson <seanjc@google.com>, 
 "Li, Xiaoyao" <xiaoyao.li@intel.com>
Content-Type: multipart/alternative; boundary="0000000000005787af061c969be9"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

--0000000000005787af061c969be9
Content-Type: text/plain; charset="UTF-8"

Il sab 6 lug 2024, 17:57 Li, Xin3 <xin3.li@intel.com> ha scritto:

> >> The bits in the secondary vmexit controls are not supported, and in
> general the same
> >> is true for the secondary vmexit case.  I think it's better to not
> include the vmx-entry-
> >> load-fred bit either, and only do the vmxcap changes.
>
> > Right, we don't need it at all.
>
> Hi Paolo,
>
> We actually do need the following change for nested FRED guests to boot:
>
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 227ee1c759..dcf914a7ec 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -1285,7 +1285,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, "vmx-entry-ia32e-mode", NULL, NULL,
>              NULL, "vmx-entry-load-perf-global-ctrl",
> "vmx-entry-load-pat", "vmx-entry-load-efer",
>              "vmx-entry-load-bndcfgs", NULL, "vmx-entry-load-rtit-ctl",
> NULL,
> -            NULL, NULL, "vmx-entry-load-pkrs", NULL,
> +            NULL, NULL, "vmx-entry-load-pkrs", "vmx-entry-load-fred",
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>          },
>
> Or do you think it's not the root cause?
>

The patch is correct but is FRED supported in nested VMX? Or is it with not
yet merged patches?

Paolo



> Thanks!
>     Xin
>
>

--0000000000005787af061c969be9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il sab 6 lug 2024, 17:57 Li, Xin3 &lt;<a href=3D"mailt=
o:xin3.li@intel.com">xin3.li@intel.com</a>&gt; ha scritto:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">&gt;&gt; The bits in the seconda=
ry vmexit controls are not supported, and in general the same<br>
&gt;&gt; is true for the secondary vmexit case.=C2=A0 I think it&#39;s bett=
er to not include the vmx-entry-<br>
&gt;&gt; load-fred bit either, and only do the vmxcap changes.<br>
<br>
&gt; Right, we don&#39;t need it at all.<br>
<br>
Hi Paolo,<br>
<br>
We actually do need the following change for nested FRED guests to boot:<br=
>
<br>
diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
index 227ee1c759..dcf914a7ec 100644<br>
--- a/target/i386/cpu.c<br>
+++ b/target/i386/cpu.c<br>
@@ -1285,7 +1285,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] =3D =
{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &quot;vmx-entry-ia32e=
-mode&quot;, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, &quot;vmx-entry-load-=
perf-global-ctrl&quot;, &quot;vmx-entry-load-pat&quot;, &quot;vmx-entry-loa=
d-efer&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;vmx-entry-load-bndcfg=
s&quot;, NULL, &quot;vmx-entry-load-rtit-ctl&quot;, NULL,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &quot;vmx-entry-load=
-pkrs&quot;, NULL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 NULL, NULL, &quot;vmx-entry-load=
-pkrs&quot;, &quot;vmx-entry-load-fred&quot;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL, NULL, NULL, NULL,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
<br>
Or do you think it&#39;s not the root cause?<br></blockquote></div></div><d=
iv dir=3D"auto"><br></div><div dir=3D"auto">The patch is correct but is FRE=
D supported in nested VMX? Or is it with not yet merged patches?=C2=A0</div=
><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"=
><br></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Thanks!<br>
=C2=A0 =C2=A0 Xin<br>
<br>
</blockquote></div></div></div>

--0000000000005787af061c969be9--


