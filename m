Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA16FD877E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:22:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2VJX-0002bq-1y; Tue, 17 Mar 2026 10:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2VJT-0002bf-FO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:22:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1w2VJP-0003KP-KU
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773757341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LJTHVlgYFuGVuI2BP5SAMvMD7PrNFlErCSIeFbabkDU=;
 b=ikXfxDaLzG8PnMJ1MZCaYGLtzGxInuc4CR+681Ksf03LtP1vRqfNZhK3GIwepe7LJaTDPc
 k/MpokkHsGuMcNvhDSkxNxzAM5K3gV+yP2vYp75aOIhWCoMeK2OfkSgBVxtYrzP9fYC3/Z
 atpwUh4MT/xhn1nMmBiYYSZMU5baIAY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-OBHeAxcnN3Kc9yd0KEccng-1; Tue, 17 Mar 2026 10:22:18 -0400
X-MC-Unique: OBHeAxcnN3Kc9yd0KEccng-1
X-Mimecast-MFC-AGG-ID: OBHeAxcnN3Kc9yd0KEccng_1773757338
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-89c53a0264cso10592666d6.0
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 07:22:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773757338; cv=none;
 d=google.com; s=arc-20240605;
 b=aN6DmdISRsNIzt2lO8kYVSyDxpa0rymGUrzfjRCgCA2NyUvl85FfptgbuaR4yP3yy6
 xphZsvFFj7Fn/D4VvCxtDOYUWjEi8jpIuY8njLYLXxwsIhMGdmg6p73jT2Rsoaok3wvq
 rpasXiVI9OWYB97O0HNu/BQfZY5xmwrcDEyjjUZG7ThuwYRbZWmTGryy53Et0uFxT5iB
 Y1kY4FHOxNnpxeBFGTvmZAMPPqdr3Ac5dhMdE7+8Sgfga9IC7adBQeMmtJqoHREM7nrn
 6FDnsyyF2xqBpnzE93oAo+4cCDYgyqYVUNvGYT0NnBFxUVIHIZ+FMD8QHvpJabyumHfl
 gZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=LJTHVlgYFuGVuI2BP5SAMvMD7PrNFlErCSIeFbabkDU=;
 fh=mgsnKftZWTYb0SkVeAnY4uRPrS867bYfRpFufIGJzGE=;
 b=EymtZ6e+uIlTBW/Px0zEsjY8AOOXTKS1sUzNBv5lkaPSyBFcLuAmtaPShGe4a6Mf+z
 J/PrgwkPEnMdY25zXCEX0bGBVCGKIeQoZAc+637ElC+gQi6b+JGa5w2zVArVGkU6dxvh
 A8LM6yV8uDVA5x1CpVJsitFH0mTHO1tTMHq13zwUhyrgyCnexOnBEjYVqyJLv4ltp5eF
 1aiFOvL8FoPqVAgg2qlGRlR0G9Pv2K1d0W0dUS4HrEV03JGs8Ec/lCAiHjzMenAMkxBY
 CyaN69DrJtTUyyVOR4AOMgYERwwDnZ9pEYu/eYiE4U0bFMXWe/4Mo/XOfepvjVsSiFWA
 px+A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773757338; x=1774362138; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LJTHVlgYFuGVuI2BP5SAMvMD7PrNFlErCSIeFbabkDU=;
 b=myHTBdxARvvtZbBdqt5y9Cxg5LX/7xlpnYXs/mv9diTvwkl+NQYE/HWRRq10rZZu2V
 VWfOAAP+BOdWDaQvTgFPsQxNrw7mB3KutvzVU4kzs4D3IZvilxscqYj0fNfIJC/ASnC3
 rlSMNrWjzecFCtUcVZ7/+OEC5Rb4Utr/oTMDpE6RgszaBBQYbjxL45FeJO1264VHuxUu
 NktzhDHQWM2sEUCFSSvr3lcgkhwFpdRcQChJ6DVCLaWwr0SmXGtmLBIwCbTrd2+yM+/u
 dmWXrOsjFZfC/n6x4T/etMipp9Zx8ozFjjNU1vFLerZkPtEuB6FQDB0wf0oRn/KqlOMr
 6zJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773757338; x=1774362138;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJTHVlgYFuGVuI2BP5SAMvMD7PrNFlErCSIeFbabkDU=;
 b=hjKggjMXivKvCqUVzYZQ+XTTE/IQNlvMLnRtu1rUxEquRIjvnojE4TfCrQuIqieG6V
 1mjA1VCfx+EnbZQzMu8637/vHWdSmlqZ7ZN/znymr2b9XewbFstFtLsJyj13fmhR0aRF
 7PTYEj/n8EV65JCAIVbFxQGBwfYhD3H5jt7CFas+ojz26dVAGoX64a1e+7B3wukhx6+g
 0S79K5cdMfW6ML2JKBkpj8zewuAQGcWXCTGmfeI8N7E04UQ57bilPVRg+ImBHJzaA5q9
 s/ME7tU5q0RNfDTbCcv+CT4XPWn0m4hk3udK7W1to08UIb37S8xIjDooZ8GHxIzEL2qT
 n2sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO9hd+9ONlWzrIMShCDXLlw9lrxu/ue/gpRbZNPXT/dxlnmLENuhOtedCsacib6nNw2GISmUL8snDP@nongnu.org
X-Gm-Message-State: AOJu0YxOF6T4XaNNVAtDTFw86Edl5epyEceMb+cx13foZw06oSQbnOZy
 Tojo9x5/XTudLXF7+XsroHQ8E/u+UGC0Hktmr1qUemi+2e2Gz//SiVRV3btF1zAQ7TBb8eW0cON
 M4ROPOqthcR0DTnB+NioTMJQPm9txvUFZX6O8goBrFdY2oSC5nFkO2CXFRa4c14ATHU37qKcShP
 8hxaJyl694zoqUFYu6D/Y94mvYGCMCixk=
X-Gm-Gg: ATEYQzz62W3w8e02Z69jZ7tmrrGFaSb759XJgglEekZvhSFZ/g+pFZMFzYN3wLl/EZG
 HmDQcWP1DvVnUM/QEryVFC5Y6UpuBvfrvipnM+MrBY1Z1S77Cde6wzVdUlJw9onuCfXh2nOxSfI
 +U9img0jlCO2T6++QupqfjYbbd+YfCsh8XaGZCg5fuUhallfSuAbTzbXGl6hw0Zlqp4MbpqVcuF
 k6H7OjH
X-Received: by 2002:a05:6214:d0c:b0:89c:4d0f:d7d1 with SMTP id
 6a1803df08f44-89c4d0fe7c1mr126393726d6.33.1773757337785; 
 Tue, 17 Mar 2026 07:22:17 -0700 (PDT)
X-Received: by 2002:a05:6214:d0c:b0:89c:4d0f:d7d1 with SMTP id
 6a1803df08f44-89c4d0fe7c1mr126393056d6.33.1773757337211; Tue, 17 Mar 2026
 07:22:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260317094806.1944053-1-peter.maydell@linaro.org>
 <20260317094806.1944053-4-peter.maydell@linaro.org>
 <460dcf4f-e5da-4365-8924-8fd0231abe7b@linaro.org>
In-Reply-To: <460dcf4f-e5da-4365-8924-8fd0231abe7b@linaro.org>
From: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Date: Tue, 17 Mar 2026 16:22:06 +0200
X-Gm-Features: AaiRm528SxBzwV0tSPwKKTunaM0AY0xBu3d48Ug-z1oB1JmXz7puMby1djgF-DA
Message-ID: <CAPMcbCqXyz8nQsFTqobeYRW0gNmZbW6zuaFxqnhOw=3nt2DROQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] scripts/qemu-guest-agent/fsfreeze-hook: Fix
 syslog-fallback logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Michael Roth <michael.roth@amd.com>
Content-Type: multipart/alternative; boundary="00000000000000aa61064d3910ec"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

--00000000000000aa61064d3910ec
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

On Tue, Mar 17, 2026 at 11:54=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philm=
d@linaro.org>
wrote:

> On 17/3/26 10:48, Peter Maydell wrote:
> > In the fsfreeze script we attempt to implement "log to a file if we
> > can, and fall back to syslog if we cannot".  We do this with:
> >
> >    [ ! -w "$LOGFILE" ] && USE_SYSLOG=3D1
> >    touch "$LOGFILE" >/dev/null 2>&1 || USE_SYSLOG=3D1
> >
> > This has a weird behaviour if it is run in a setup where we have
> > permissions that would allow us to write to $LOGFILE but it does not
> > currently exist.  On the first execution, the '-w' fails and so we
> > set USE_SYSLOG=3D1.  But since we also do the "touch $LOGFILE" step we
> > create an empty logfile.  Then on the second time the script is
> > executed, we see a writeable logfile and will use it.  The effect is
> > "log to syslog once, then to the logfile thereafter", which is not
> > likely to be what anybody wants.
> >
> > Update the condition of the first check to only pick syslog if
> > the logfile exists but is not writable. This means that:
> >   * if the logfile doesn't exist but we are able to create it,
> >     we will create it and use it
> >   * if the logfile already exists and we can write to it,
> >     we will use it
> >   * if the logfile already exists but we can't write to it,
> >     we will fall back to syslog
> >   * if the logfile doesn't exist and we can't create it,
> >     we will fall back to syslog
> >
> > Cc: qemu-stable@nongnu.org
> > Fixes: 85978dfb6b1c133 ("qemu-ga: Optimize freeze-hook script logic of
> logging error")
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   scripts/qemu-guest-agent/fsfreeze-hook | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>
>

--00000000000000aa61064d3910ec
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Reviewed-by: Kostiantyn Kostiuk &lt;<a href=3D"mailto:kkos=
tiuk@redhat.com" target=3D"_blank">kkostiuk@redhat.com</a>&gt;</div><br><di=
v class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gma=
il_attr">On Tue, Mar 17, 2026 at 11:54=E2=80=AFAM Philippe Mathieu-Daud=C3=
=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>&gt; wrot=
e:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 17/3/26 10=
:48, Peter Maydell wrote:<br>
&gt; In the fsfreeze script we attempt to implement &quot;log to a file if =
we<br>
&gt; can, and fall back to syslog if we cannot&quot;.=C2=A0 We do this with=
:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 [ ! -w &quot;$LOGFILE&quot; ] &amp;&amp; USE_SYSLOG=3D1<b=
r>
&gt;=C2=A0 =C2=A0 touch &quot;$LOGFILE&quot; &gt;/dev/null 2&gt;&amp;1 || U=
SE_SYSLOG=3D1<br>
&gt; <br>
&gt; This has a weird behaviour if it is run in a setup where we have<br>
&gt; permissions that would allow us to write to $LOGFILE but it does not<b=
r>
&gt; currently exist.=C2=A0 On the first execution, the &#39;-w&#39; fails =
and so we<br>
&gt; set USE_SYSLOG=3D1.=C2=A0 But since we also do the &quot;touch $LOGFIL=
E&quot; step we<br>
&gt; create an empty logfile.=C2=A0 Then on the second time the script is<b=
r>
&gt; executed, we see a writeable logfile and will use it.=C2=A0 The effect=
 is<br>
&gt; &quot;log to syslog once, then to the logfile thereafter&quot;, which =
is not<br>
&gt; likely to be what anybody wants.<br>
&gt; <br>
&gt; Update the condition of the first check to only pick syslog if<br>
&gt; the logfile exists but is not writable. This means that:<br>
&gt;=C2=A0 =C2=A0* if the logfile doesn&#39;t exist but we are able to crea=
te it,<br>
&gt;=C2=A0 =C2=A0 =C2=A0we will create it and use it<br>
&gt;=C2=A0 =C2=A0* if the logfile already exists and we can write to it,<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0we will use it<br>
&gt;=C2=A0 =C2=A0* if the logfile already exists but we can&#39;t write to =
it,<br>
&gt;=C2=A0 =C2=A0 =C2=A0we will fall back to syslog<br>
&gt;=C2=A0 =C2=A0* if the logfile doesn&#39;t exist and we can&#39;t create=
 it,<br>
&gt;=C2=A0 =C2=A0 =C2=A0we will fall back to syslog<br>
&gt; <br>
&gt; Cc: <a href=3D"mailto:qemu-stable@nongnu.org" target=3D"_blank">qemu-s=
table@nongnu.org</a><br>
&gt; Fixes: 85978dfb6b1c133 (&quot;qemu-ga: Optimize freeze-hook script log=
ic of logging error&quot;)<br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0scripts/qemu-guest-agent/fsfreeze-hook | 4 ++--<br>
&gt;=C2=A0 =C2=A01 file changed, 2 insertions(+), 2 deletions(-)<br>
<br>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linar=
o.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
<br>
</blockquote></div>

--00000000000000aa61064d3910ec--


