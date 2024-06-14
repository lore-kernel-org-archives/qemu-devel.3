Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55B5C27C75
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2024 08:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sI2VM-0000Ry-75; Fri, 14 Jun 2024 04:41:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI2VL-0000Rn-41
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:41:51 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1sI2VI-0006Un-UJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2024 04:41:50 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-440530cadc7so11936781cf.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2024 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718354507; x=1718959307; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=msD9ilvCdfTxa40DHO/CKyaJuFefzvmRy2mej3mOpA4=;
 b=ibq37MLs5IsdURYbssqlsIerJQk76WOETijgsMhX9vQHneb6wMeG7TsWehzOB48Coe
 qGcc+0X+RdWK0lvlAS2/r7PZvE4V0BYKof4E3RN2Igxx3DC8I9hpctSSFWSrZ6ASRuKv
 5+An9PmeeXD2eycQxSCmdvpPZJ/dqw26JDwS4sTW9ahME4WnNMTi5IWMgSqLq1b0WxND
 wqJTP8qdhY0FjnEPO3o5m4Bs1X64BB6fOFy9bMlK7V/R9LO+se3t460fuFGbABssF6ek
 aR6LglEZS7qFg7pYAm7oXmpjCpP3rpf/Dk3yuI7G2sZY/A4E+fA6QQfSDmKeG9vd4K+M
 DMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718354507; x=1718959307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=msD9ilvCdfTxa40DHO/CKyaJuFefzvmRy2mej3mOpA4=;
 b=cZdsMYY1e+JlJ6Ha23LT+AiZPoXL9CDlSto3K1xexktrQqCutIsCy8tFPot0FTQt1g
 LknkuqLhKrRUP7aG4DJVQ1B8ih61tvzt88Yo2UOJnZ+A5P+5A+DzA5NUQbJDNdTezNmN
 fCXREOck/b+fKPPx9tr47V2GVprudlV4JDMDqp3GhOh0HBjb+k7hsWphrrNB/wXQr2lA
 IK61olf2u2dIUgrWvnuRPYRWI2wvSEpf51jyoTc65zdp7ITmaqrgBPgtfyf+agxZ9KS7
 JMNlANElWZa/jHuhP1lS9+1gs5goMO7IOBm6o1YpAeQeiR/Wkol0ObPswOXRfaYwDukT
 nguA==
X-Gm-Message-State: AOJu0Yyi+k+w3gLghhrjq+dl9lnmBhZoASnkI3WWsvQEr1qElMFFFdtu
 KbCgPnE/wN4znbbtJ4mIyKZT/4ISYUUT1s4tZggKn9nSZLzbbq32nem1Lr6uCou51WlYOPJ9D54
 XrL/fBpizSD83QQMiAAygbz5eNAEr/Gfb
X-Google-Smtp-Source: AGHT+IHI32pfMwCPg4QGSu2IvIwDOR9oKORKkWCqvHCrmmbqrWeRB8SDglt4bwo4dq6rJpRrG6SEXwQoFQbec4qYiMk=
X-Received: by 2002:a05:622a:488:b0:43e:e6e:21bf with SMTP id
 d75a77b69052e-442168fc0c9mr23163921cf.1.1718354507530; Fri, 14 Jun 2024
 01:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <20240531185804.119557-1-dongwon.kim@intel.com>
 <CAJ+F1C+PG-Tf-ADFTgBGq5nvJSCEVhFW0Pk6a2Pf7gVurbJeuw@mail.gmail.com>
 <a89b283a-24e3-4117-b465-ab8d79252625@intel.com>
 <CAJ+F1CJ-4cWV81_YTit5jTEoY6FPTeu7u177pZzb61FhXw_j0Q@mail.gmail.com>
 <fa43009f-1292-49f5-bab0-618028c16045@intel.com>
 <CAJ+F1CLAJTZLHKa9_zVo=-GLRw8JHnzJT=G4fdLLsaS1sK2HUg@mail.gmail.com>
 <0fe76150-c347-40df-8d69-18a5d132d8bc@intel.com>
 <CAJ+F1CKsboFZ-fWUXrf5BSMKCY6boRAoTMVRLaHgGja2Eppx8g@mail.gmail.com>
 <d5c18317-da45-4751-8392-56acf8e87ad9@intel.com>
In-Reply-To: <d5c18317-da45-4751-8392-56acf8e87ad9@intel.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 14 Jun 2024 12:41:35 +0400
Message-ID: <CAJ+F1CKOcw_cfCHj7vOYOcBs22=yqokS7Wmxk+WY06a1Mk60sQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/2] ui/gtk: Introduce new param - Connectors
To: "Kim, Dongwon" <dongwon.kim@intel.com>
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000050bf3061ad5966a"
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x832.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000050bf3061ad5966a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Thu, Jun 13, 2024 at 9:08=E2=80=AFPM Kim, Dongwon <dongwon.kim@intel.com=
> wrote:

> >     "hotplug" functionality where a Guest display/window is deeply tied
> to a
> >     physical monitor to make it appear to the guest that it is dealing
> with
> >     a real physical monitor.
> >
> >     In other words, when the physical monitor is unplugged, the
> associated
> >     guest display/window gets destroyed/hidden and gets recreated/shown
> >     when
> >     the monitor is hotplugged again.
> >
> >
> > Interesting case that could be added to virt-viewer if it's necessary.
> >
> > The subject is sufficiently complex that there is already additional
> > documentation/specification in:
> >
> https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=3D=
heads
> <
> https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=3D=
heads
> >
> >
> > Honestly, I don't support the idea of duplicating this effort in QEMU.
>
> Marc-Andr=C3=A9,
>
> My assumption is virt-viewer might not be able to completely replace
> GTK-UI path in terms of performance and smoothness of display update as
> (I think) frame copy between processes is implied, which is same as
>

There is no frame copy when using DMABUF scanouts between qemu and client.

Iow, the performance difference is negligible / noise level.

spice-remote viewer. What about display-bus that you have been working
> on? Would it be a good alternative w.r.t perf concern that I specified
> above?
>

There shouldn't be much difference for the local DMABUF display case.


>
> >
> > --
> > Marc-Andr=C3=A9 Lureau
>
>

--=20
Marc-Andr=C3=A9 Lureau

--000000000000050bf3061ad5966a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi<br></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Jun 13, 2024 at 9:08=E2=80=
=AFPM Kim, Dongwon &lt;<a href=3D"mailto:dongwon.kim@intel.com">dongwon.kim=
@intel.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
&gt;=C2=A0 =C2=A0 =C2=A0&quot;hotplug&quot; functionality where a Guest dis=
play/window is deeply tied to a<br>
&gt;=C2=A0 =C2=A0 =C2=A0physical monitor to make it appear to the guest tha=
t it is dealing with<br>
&gt;=C2=A0 =C2=A0 =C2=A0a real physical monitor.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0In other words, when the physical monitor is unplug=
ged, the associated<br>
&gt;=C2=A0 =C2=A0 =C2=A0guest display/window gets destroyed/hidden and gets=
 recreated/shown<br>
&gt;=C2=A0 =C2=A0 =C2=A0when<br>
&gt;=C2=A0 =C2=A0 =C2=A0the monitor is hotplugged again.<br>
&gt; <br>
&gt; <br>
&gt; Interesting case that could be added to virt-viewer if it&#39;s necess=
ary.<br>
&gt; <br>
&gt; The subject is sufficiently complex that there is already additional <=
br>
&gt; documentation/specification in:<br>
&gt; <a href=3D"https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/do=
cs?ref_type=3Dheads" rel=3D"noreferrer" target=3D"_blank">https://gitlab.co=
m/virt-viewer/virt-viewer/-/tree/master/docs?ref_type=3Dheads</a> &lt;<a hr=
ef=3D"https://gitlab.com/virt-viewer/virt-viewer/-/tree/master/docs?ref_typ=
e=3Dheads" rel=3D"noreferrer" target=3D"_blank">https://gitlab.com/virt-vie=
wer/virt-viewer/-/tree/master/docs?ref_type=3Dheads</a>&gt;<br>
&gt; <br>
&gt; Honestly, I don&#39;t support the idea of duplicating this effort in Q=
EMU.<br>
<br>
Marc-Andr=C3=A9,<br>
<br>
My assumption is virt-viewer might not be able to completely replace <br>
GTK-UI path in terms of performance and smoothness of display update as <br=
>
(I think) frame copy between processes is implied, which is same as <br></b=
lockquote><div><br></div><div>There is no frame copy when using DMABUF scan=
outs between qemu and client.<br></div><div>=C2=A0</div><div>Iow, the perfo=
rmance difference is negligible / noise level.<br></div><div><br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
spice-remote viewer. What about display-bus that you have been working <br>
on? Would it be a good alternative w.r.t perf concern that I specified <br>
above?<br></blockquote><div><br></div><div>There shouldn&#39;t be much diff=
erence for the local DMABUF display case.=C2=A0 <br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
&gt; <br>
&gt; -- <br>
&gt; Marc-Andr=C3=A9 Lureau<br>
<br>
</blockquote></div><br clear=3D"all"><br><span class=3D"gmail_signature_pre=
fix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature">Marc-Andr=C3=
=A9 Lureau<br></div></div>

--000000000000050bf3061ad5966a--

