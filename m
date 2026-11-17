Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665FF606A323
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Nov 2026 04:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ePUAoeH1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTAc4-0000YZ-0W; Mon, 16 Nov 2026 23:16:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTAc1-0000Xz-Jx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 23:16:05 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xmphyr@gmail.com>) id 1xTAby-0000sT-Gd
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 23:16:04 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-3ad5529ae64so39763831fa.2
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:16:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794888959; cv=none;
 d=google.com; s=arc-20260327;
 b=XWkK2mNYluADD+2V/IPgMrMYm/lRkRlm6HfBMKMoKnVayONP2M3X/PU9rQe7Kg1MwV
 hW4rzw5/q7IxjDnt/YGkaPBzBXG5QKF1SyOp2fWVCjjV6PR2CWmzx2KKOLCdp8wIm9t0
 /VciwM2nguiz8MkOkeKf9JStXW76urq3ysV/hRgbiMwye6uv6WJ1ldS9Z5zaYqA7YZTm
 oPKY3xqG28cvHWzrVKc8vzkXH59zPiHOTslYzzzzqVdk7n1zvr4tAzDUeMRQF8a0yKh/
 +OeOUVz4v5+d5O27Nn1mu3ilftD218lnYvmipie834yXfat0GwcB0i6yC8ZB5FFGEPkE
 7SYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FgXUDwIBlkoGvQzFlFuiq7urX4SUO4MCu2VmXQfATv0=;
 fh=sep9/oU5lkjeesx9fg29gymcioB6D1L6KDh4P/xLyog=;
 b=lkR4KhGFbs97acSjyn0pu6AdxwDgsPHKbRpZD59rpp49YEh+nlXcU7psAskC1Qi8g/
 tQOdRxkmu+VrAF9Bon+Qow1XV/A8mu1I/2KQy7BRoWNx0iWpZdAccciInhb3AY1GK7lk
 aRvRQCxzj/RS7ymaPxe047mDFlDwpSvH9sSUZTsRKrGqS1dunlQVa81EMMPMwx+SV6eM
 EtuNqob+PffOZKg1Qz1mjdb6AXrGHnzamWrHHhpE39q4O/F0cphnvon6V/+wOJ1R8Z1O
 T2BseZbavcjduVuysNP8pmOFr78G/GoF23zOsm1zdriC+7j7stAkP1CexsI03c/toJuj
 qU/Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794888959; x=1795493759; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=FgXUDwIBlkoGvQzFlFuiq7urX4SUO4MCu2VmXQfATv0=;
 b=ePUAoeH1Oz3rsx5MR1KL8LwRCliH51UGVMRKLjTDOLa1BhPJ54mzuSn3H+AN/7vhP1
 DHEArt/gWQqX3u1n0FrWHu4jbq+WGu7HiXAa51J3iYF81jZHX2WvLsu49A6Nc1vsUYGl
 J8PHopjKRXn5Cx1vXasQ3uX0HVEi0DiKosv/SuwYE3QXu5nRe495xy/xu0Nk+/nMhoG4
 BlIug7K1jo3JOfapowFWvi1lh4oW1rVUvz62xCca43KaSTc8i6lCqAdVmjdLPpqt0UWa
 ySq4Rni0LttkgPa063uagSQzvJ55MM9A5Jiuq2MaocHkISovB7zAJ9zxDuGNSJlKkMAk
 86eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794888959; x=1795493759;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FgXUDwIBlkoGvQzFlFuiq7urX4SUO4MCu2VmXQfATv0=;
 b=ToqKNHgVIWtEdbrE4UXgeVxpNqSauMihV4j5306aGN8HyV5NH+/XjmCuPOmXbHBKnr
 isAJiFADAk5fL7g3htEozWR4VW3/Odn0mUbxEGJT0e9kSsZe+4oGdf8/1/NTVwUW/int
 buw6MVmDe+mMyXiAqiXcVq634VTfVpGBELf0E5Luibm4LRXRYz23wZ2iKRYsvl9oNXBO
 xOg+y+N+PPMU8J9plLOZssFiP3B1LJdRiNViVNEgMlaHWTth3IcwsYaEpciaIf/RxlAp
 iNNBZ/cYLMNQuGIRQTJqeMuRlf5nvqO2d7BbjXbnlfFDeRghnyI6Iz/nUcNN3fgRlamU
 TVXA==
X-Forwarded-Encrypted: i=1;
 AL+hErF0KvmJlyMIZhL7oDBpU6d4PklZbf2auzmUigyvuxpcae2np1U490jsve3ECtcx2Asxl+/Y41PXN6lU@nongnu.org
X-Gm-Message-State: APuU4Z9+sNFkXJqtvxTndd3lYXZ/08No3cmKmzzxkZaZrDu8jC2ZiPSa
 BcCxf+gWgW5VbbZvXajy5yBA64FZEbY9RacyT2oeGT9jmIB/tLm4fU3PU8QJNjtXCuOZMzaJWDc
 nlAVZl+SxTBvKdemJ8Dd78zFDxZMkCMU=
X-Gm-Gg: AYBFou1hoAS2vCYLMsi5j1IWZTS58MNYVZp03k6+FOjnULCpxsX2FAmKcc0pH1dlmJ5
 3vaWqnZsIjYzldwkQq6EKuQ2tnfh2E83DzXyyyGYywKKQs+sbQy5GEPsmJfv5wyYcMzU+NEQHQ0
 oLNrdzx3okkJBh52wPgUNXUuCiojEv4pq3A5Afw46ldDbqAcDNmKP9pD9qQoAkGoEEKiATpi1Ei
 XXp+zZtfvel648JttsHu9TPhCuyq7A5QmgsJPqLPjBzh4vFWoCm+h5eH7lE7S+8Q6HOWb4lzfGF
 aV6cKVSPSTHsvhvulS/LKC+PDs8kyBRwGuuGUm7JLgrQEWRYAcOspl5BDXRc5MKAFFFVPWjRLI3
 W1d5e+L+e1OxOC9gJyUkXtOInbylbLFCK0VimUA==
X-Received: by 2002:a05:651c:b0b:b0:3ac:c6e7:f5f with SMTP id
 38308e7fff4ca-3ae2b4cd7dcmr43123271fa.14.1794888959031; Mon, 16 Nov 2026
 20:15:59 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261115-4836-cpu-host-error-v1-1-fdf0eb56ba8a@gmail.com>
 <CAFEAcA_dyd8Y5mJc_J7dtDwLL3eDaEo1P8fx01Rjkgah+q4Dvw@mail.gmail.com>
 <ae1a4df8-e52a-45c8-b723-60d86931f286@oss.qualcomm.com>
In-Reply-To: <ae1a4df8-e52a-45c8-b723-60d86931f286@oss.qualcomm.com>
From: xmphyr <xmphyr@gmail.com>
Date: Mon, 16 Nov 2026 22:15:49 -0600
X-Gm-Features: AclHuK-TULmQB2yd4dZBPilB6X96PFuu0aQ8IuIUPTY96nEV3__sniOSChoHIZE
Message-ID: <CA+hLWEGpkbvcyYV+u_keidnXE2yRrnkbqAEMy9=PkYvV3He_MQ@mail.gmail.com>
Subject: Re: [PATCH] target/i386: make error message for -cpu host more
 informative
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: multipart/alternative; boundary="000000000000d07c14066071263e"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=xmphyr@gmail.com; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000d07c14066071263e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I appreciate the both of you for the feedback.

As Philippe has suggested, I will add hwaccel_enabled() as a condition in
order to check for KVM, HVF, or WHPX.

To Peter, instead of explicitly printing the list of accelerators, maybe I
should add a macro of a string that's something like "KVM, HVF, or WHPX"?
This would be in include/system/hw_accel.h.

As a sidenote, this is my first patch. When I receive feedback, should I
reply first with my plan and get feedback on that before sending a revision=
?

---
Thanks,
Andrew Nguyen

On Mon, Nov 16, 2026 at 8:10=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <
philmd@oss.qualcomm.com> wrote:

> Hi Andrew,
>
> On 16/11/26 10:38, Peter Maydell wrote:
> > On Mon, 16 Nov 2026 at 03:38, Andrew Nguyen <xmphyr@gmail.com> wrote:
> >>
> >> Included the mention of WHPX when the option -cpu host doesn't have
> >> an accelerator option.
> >>
> >> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> >>
> >> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4836
> >> ---
> >> This is a resolution for issue #4836:
> https://gitlab.com/qemu-project/qemu/-/work_items/4836.
> >> "-cpu host" by itself is not permitted; an accelerator must be
> specified as well. For Linux,
> >> it is KVM. macOS is HVF and Windows is WHPX.
> >>
> >> Previously, QEMU would only tell the user to use either KVM or HVF,
> essentially excluding
> >> Windows users. This patch adds WHPX to the error message. A similar
> patch was made seven
> >> months ago in target/arm/cpu.c:1861.
> >>
> >> Signed-off-by: Andrew Nguyen <xmphyr@gmail.com>
> >> ---
> >> Changes:
> >> - cpu.c:10229: added WHPX to the error message when "-cpu host" doesn'=
t
> include an accelerator
> >> ---
> >>   target/i386/cpu.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> >> index eab0d5a4d4..7dd5535f80 100644
> >> --- a/target/i386/cpu.c
> >> +++ b/target/i386/cpu.c
> >> @@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState *dev=
,
> Error **errp)
> >>
> >>       if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
> >>           g_autofree char *name =3D x86_cpu_class_get_model_name(xcc);
> >> -        error_setg(&local_err, "CPU model '%s' requires KVM or HVF",
> name);
> >> +        error_setg(&local_err, "The '%s' CPU type can only be used
> with KVM,
> >> +            HVF or WHPX", name);
> >>           goto out;
> >>       }
> >
> > The code isn't checking "is this KVM, HVF or WHPX", though.
> > accel_uses_host_cpuid() is checking "not TCG" (also "not qtest" but as
> > that's a test facility we don't need to mention it here). Listing
> > an explicit set of accelerators means it gets out of date whenever
> > a new one is added (as has already happened here once when the
> > WHPX accelerator was added and the message not updated).
>
> See commit f7fa2b88084c22299b347cea8fd9fadb0b136b22 for an example
> of the hwaccel_enabled() method.
>

--000000000000d07c14066071263e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I appreciate the both of you for the feedback. <br><br>As =
Philippe has suggested, I will add hwaccel_enabled() as a condition in <br>=
order to check for KVM, HVF, or WHPX. <br><br>To Peter, instead of explicit=
ly printing the list of accelerators, maybe I<br>should add a macro of a st=
ring that&#39;s something like &quot;KVM, HVF, or WHPX&quot;?<br>This would=
 be in include/system/hw_accel.h.<br><br>As a sidenote, this is my first pa=
tch. When I receive feedback, should I<br>reply first with my plan and get =
feedback on that before sending a revision?<br><br>---<br>Thanks,<br>Andrew=
 Nguyen</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=
=3D"ltr" class=3D"gmail_attr">On Mon, Nov 16, 2026 at 8:10=E2=80=AFAM Phili=
ppe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@oss.qualcomm.com">philm=
d@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Hi Andrew,<br>
<br>
On 16/11/26 10:38, Peter Maydell wrote:<br>
&gt; On Mon, 16 Nov 2026 at 03:38, Andrew Nguyen &lt;<a href=3D"mailto:xmph=
yr@gmail.com" target=3D"_blank">xmphyr@gmail.com</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Included the mention of WHPX when the option -cpu host doesn&#39;t=
 have<br>
&gt;&gt; an accelerator option.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andrew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.co=
m" target=3D"_blank">xmphyr@gmail.com</a>&gt;<br>
&gt;&gt;<br>
&gt;&gt; Resolves: <a href=3D"https://gitlab.com/qemu-project/qemu/-/work_i=
tems/4836" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/qemu-pro=
ject/qemu/-/work_items/4836</a><br>
&gt;&gt; ---<br>
&gt;&gt; This is a resolution for issue #4836: <a href=3D"https://gitlab.co=
m/qemu-project/qemu/-/work_items/4836" rel=3D"noreferrer" target=3D"_blank"=
>https://gitlab.com/qemu-project/qemu/-/work_items/4836</a>.<br>
&gt;&gt; &quot;-cpu host&quot; by itself is not permitted; an accelerator m=
ust be specified as well. For Linux,<br>
&gt;&gt; it is KVM. macOS is HVF and Windows is WHPX.<br>
&gt;&gt;<br>
&gt;&gt; Previously, QEMU would only tell the user to use either KVM or HVF=
, essentially excluding<br>
&gt;&gt; Windows users. This patch adds WHPX to the error message. A simila=
r patch was made seven<br>
&gt;&gt; months ago in target/arm/cpu.c:1861.<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Andrew Nguyen &lt;<a href=3D"mailto:xmphyr@gmail.co=
m" target=3D"_blank">xmphyr@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt; Changes:<br>
&gt;&gt; - cpu.c:10229: added WHPX to the error message when &quot;-cpu hos=
t&quot; doesn&#39;t include an accelerator<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0target/i386/cpu.c | 3 ++-<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/target/i386/cpu.c b/target/i386/cpu.c<br>
&gt;&gt; index eab0d5a4d4..7dd5535f80 100644<br>
&gt;&gt; --- a/target/i386/cpu.c<br>
&gt;&gt; +++ b/target/i386/cpu.c<br>
&gt;&gt; @@ -10229,7 +10229,8 @@ static void x86_cpu_realizefn(DeviceState =
*dev, Error **errp)<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (xcc-&gt;host_cpuid_required &amp;&am=
p; !accel_uses_host_cpuid()) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_autofree char *name =3D =
x86_cpu_class_get_model_name(xcc);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err, &quot;CPU =
model &#39;%s&#39; requires KVM or HVF&quot;, name);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(&amp;local_err, &quot;The =
&#39;%s&#39; CPU type can only be used with KVM,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 HVF or WHPX&quot;, name=
);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; The code isn&#39;t checking &quot;is this KVM, HVF or WHPX&quot;, thou=
gh.<br>
&gt; accel_uses_host_cpuid() is checking &quot;not TCG&quot; (also &quot;no=
t qtest&quot; but as<br>
&gt; that&#39;s a test facility we don&#39;t need to mention it here). List=
ing<br>
&gt; an explicit set of accelerators means it gets out of date whenever<br>
&gt; a new one is added (as has already happened here once when the<br>
&gt; WHPX accelerator was added and the message not updated).<br>
<br>
See commit f7fa2b88084c22299b347cea8fd9fadb0b136b22 for an example<br>
of the hwaccel_enabled() method.<br>
</blockquote></div>

--000000000000d07c14066071263e--

