Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AEA2CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 13:53:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJBI8-0004fq-3w; Wed, 12 Nov 2025 08:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vJBBo-0006Gi-Ss
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:47:15 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vJBBm-00021W-9C
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 08:47:12 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-297ef378069so7895735ad.3
 for <qemu-devel@nongnu.org>; Wed, 12 Nov 2025 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762955229; x=1763560029; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OXK67goNHJ+P+gI6mcNs3nLm7964gi6Yk2bGPQKvNY4=;
 b=mFOcEFiOc0EffmY7mYpiIhaDgIpG32KYvQMazZeuo5NFyxRsFBubgpDGeJEA0lkjd/
 Up/LL6PGmelyzd49HoAuxMpdxY2lvGly2rofAL43KTjsGSkKB7XhtLOKzHhe7yaNcj2e
 RQqKXzsaDVa/NWv7jwu5SyIPWHImz+cMmk5VikrqzlNpM6ujbmj20grEf6WrCqRN4CNH
 rNeEvPR3yxkLmy8O0j8xKlAoFDWhBxCMDjgSNLWqhjoqTGDoKL/zKJ9CuM2Ai736iYyy
 VurWluKdZ4cuLZ/VRD4mTu/jKn9xKq7wR75y47aeNTufNLRQkhcr/LZRfe9DL9qxxUvT
 HQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762955229; x=1763560029;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OXK67goNHJ+P+gI6mcNs3nLm7964gi6Yk2bGPQKvNY4=;
 b=prJevxsIIVUoLp9Nn76XMdYd7UIUeh5lk8zBan6d18i09c9LtV190CFn5256mIRzl3
 s0ZO/YaXyahrErO6Rgx4Fs8maPQLEAgocae39WKE4bA/Lt5BLNdm9T0ZnA1u3hlnfo6d
 CrbCRlowlZYB9J/6Z31ZIY2jpXo6YhsMIdLJYRy8cYwexnOcSiTLjMBLLlGNFZqdAntm
 HxgJ8QV4AgJ1CW+Rrs9yIhXbQw9lw/QU3ke8HZPT3UR2MuLlpeSZedFZ9N6dU3RWpAIt
 Y15rIHwbzoushXW+eED0tAohcR062Q3nLyHiozjxb1awh72OhvYMpQlHCczdypjo7eWO
 xtNA==
X-Gm-Message-State: AOJu0YwQRX3BCtIglyXFYw6nAS7XThLB8JTK0/63CRqzQM0yOEmV+fxi
 Zyk+ldFWwqt4y9kp59MQa9CGQDwWSoo24xpr68EfvVdtQAYUA/7po3iNJhrdRJ/yBNPY7aqN0EB
 WdfNnpfnEiYouqaMuVtZSpEmSozmk5Bk=
X-Gm-Gg: ASbGncvhnJI372Kra/mA/TnNvwA9HoRTsBLNiZXupqK9VYtXEu8fEfmCAzG4ZFKbtFc
 ZuG+CH28jLkxYwJa3z+e1JGtPhr9C4LEb+zlv7mRUR9gpTgZUViuojQ0yzW4iGmxE/xOkgHXcrI
 pWoWhMH0dubjiZeedgxJwHq/npmFp7e5CdGGdF+tw6+vuRfcAVkf7nDzn4LLrulQAH/v+CTQV5T
 JfB2TveSoEIPi3QfxA47oTvxQRmsXekTw51TbB3HpYSU25upClEud4FzDvO
X-Google-Smtp-Source: AGHT+IG0dnbEHCEjdmS540BIepNy1Zrt0slOR9WyQlHGmpMnhiOwetJAl239WazMBflxuvTB1pxWk+RJU1z1z5kwP7c=
X-Received: by 2002:a17:902:db0a:b0:295:24ab:fb06 with SMTP id
 d9443c01a7336-2984ed92172mr40082905ad.22.1762955228645; Wed, 12 Nov 2025
 05:47:08 -0800 (PST)
MIME-Version: 1.0
References: <20251021205741.57109-1-philmd@linaro.org>
 <20251021205741.57109-7-philmd@linaro.org>
 <CAJy5ezqRdrpLvN5T_hZ2ec2FzQfQJvd+Osa9TpcFrOg=v8QW+Q@mail.gmail.com>
 <26e9622f-2390-4a30-9c63-2374a1068093@linaro.org>
In-Reply-To: <26e9622f-2390-4a30-9c63-2374a1068093@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed, 12 Nov 2025 07:46:56 -0600
X-Gm-Features: AWmQ_bnOFKCb5IBxOifMEeI4Tqo9wAjauSZHqwqeY6VtbhJGhCK-5xIMHsZntlw
Message-ID: <CAJy5ezqGwJj+pGkD1XDWLEN69B6=wQmsr7Vej6VJ41Rezz90Uw@mail.gmail.com>
Subject: Re: [PATCH v7 06/19] config/target: Implement per-binary TargetInfo
 structure (ARM, AARCH64)
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Anton Johansson <anjo@rev.ng>, 
 Peter Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>, 
 Zhao Liu <zhao1.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Content-Type: multipart/alternative; boundary="000000000000288f38064366005a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

--000000000000288f38064366005a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 2:21=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi Edgar,
>
> On 11/11/25 22:28, Edgar E. Iglesias wrote:
> > On Tue, Oct 21, 2025 at 2:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> > <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
> >
> >     Implement the TargetInfo structure for qemu-system-arm
> >     and qemu-system-aarch64 binaries.
> >
> >     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org
> >     <mailto:philmd@linaro.org>>
> >     Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org
> >     <mailto:pierrick.bouvier@linaro.org>>
> >     Reviewed-by: Richard Henderson <richard.henderson@linaro.org
> >     <mailto:richard.henderson@linaro.org>>
> >
> >
> >
> > Hi Phil!
> >
> > Trying to run xenpvh guests with latest QEMU but running into trouble,
> > the xenpvh does get built into qemu-system-aarch64 any more.
> > Bisecting pointed me to this patch.
> >
> > To reproduce --enable-xen, and see if xenpvh shows up in -M \? or not.
> >
> > Any ideas?
>
> Oops, sorry for that :/
>
> I suppose I missed the following in commit 38c5ab40031 ("hw/arm: Filter
> machine types for qemu-system-arm/aarch64 binaries"):
>
> -- >8 --
> diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
> index 1a9eeb01c8e..86a02966161 100644
> --- a/hw/arm/xen-pvh.c
> +++ b/hw/arm/xen-pvh.c
> @@ -12,2 +12,3 @@
>   #include "hw/xen/xen-pvh-common.h"
> +#include "hw/arm/machines-qom.h"
>
> @@ -97,2 +98,3 @@ static const TypeInfo xen_arm_machine_type =3D {
>       .instance_init =3D xen_arm_instance_init,
> +    .interfaces =3D arm_aarch64_machine_interfaces,
>   };
> ---
>
> I don't have a handy Aarch64 machine with Xen anymore, I'll see
> tomorrow if I can get access to one. Do you mind testing this hunk
> meanwhile?
>

Thanks Phil!

Yes, that fixes it!

Cheers,
Edgar



>
> Thanks,
>
> Phil.
>

--000000000000288f38064366005a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Wed, Nov 12, 2025 at 2:21=E2=80=AFAM P=
hilippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@=
linaro.org</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">Hi Edgar,<br>
<br>
On 11/11/25 22:28, Edgar E. Iglesias wrote:<br>
&gt; On Tue, Oct 21, 2025 at 2:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <b=
r>
&gt; &lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@lina=
ro.org</a> &lt;mailto:<a href=3D"mailto:philmd@linaro.org" target=3D"_blank=
">philmd@linaro.org</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Implement the TargetInfo structure for qemu-system-=
arm<br>
&gt;=C2=A0 =C2=A0 =C2=A0and qemu-system-aarch64 binaries.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a h=
ref=3D"mailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a><br=
>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:philmd@linaro.org" tar=
get=3D"_blank">philmd@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Pierrick Bouvier &lt;<a href=3D"mailto=
:pierrick.bouvier@linaro.org" target=3D"_blank">pierrick.bouvier@linaro.org=
</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:pierrick.bouvier@linar=
o.org" target=3D"_blank">pierrick.bouvier@linaro.org</a>&gt;&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0Reviewed-by: Richard Henderson &lt;<a href=3D"mailt=
o:richard.henderson@linaro.org" target=3D"_blank">richard.henderson@linaro.=
org</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:richard.henderson@lina=
ro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;&gt;<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; Hi Phil!<br>
&gt; <br>
&gt; Trying to run xenpvh=C2=A0guests with latest QEMU but running into tro=
uble, <br>
&gt; the xenpvh=C2=A0does get built into qemu-system-aarch64 any more.<br>
&gt; Bisecting pointed me to this patch.<br>
&gt; <br>
&gt; To reproduce --enable-xen, and see if xenpvh shows up in -M \? or not.=
<br>
&gt; <br>
&gt; Any ideas?<br>
<br>
Oops, sorry for that :/<br>
<br>
I suppose I missed the following in commit 38c5ab40031 (&quot;hw/arm: Filte=
r<br>
machine types for qemu-system-arm/aarch64 binaries&quot;):<br>
<br>
-- &gt;8 --<br>
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c<br>
index 1a9eeb01c8e..86a02966161 100644<br>
--- a/hw/arm/xen-pvh.c<br>
+++ b/hw/arm/xen-pvh.c<br>
@@ -12,2 +12,3 @@<br>
=C2=A0 #include &quot;hw/xen/xen-pvh-common.h&quot;<br>
+#include &quot;hw/arm/machines-qom.h&quot;<br>
<br>
@@ -97,2 +98,3 @@ static const TypeInfo xen_arm_machine_type =3D {<br>
=C2=A0 =C2=A0 =C2=A0 .instance_init =3D xen_arm_instance_init,<br>
+=C2=A0 =C2=A0 .interfaces =3D arm_aarch64_machine_interfaces,<br>
=C2=A0 };<br>
---<br>
<br>
I don&#39;t have a handy Aarch64 machine with Xen anymore, I&#39;ll see<br>
tomorrow if I can get access to one. Do you mind testing this hunk<br>
meanwhile?<br></blockquote><div><br></div><div>Thanks Phil!</div><div><br><=
/div><div>Yes, that fixes it!</div><div><br></div><div>Cheers,</div><div>Ed=
gar</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
<br>
Thanks,<br>
<br>
Phil.<br>
</blockquote></div></div>

--000000000000288f38064366005a--

