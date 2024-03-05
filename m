Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AE3C54E41
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 19:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhaGS-0005bJ-ST; Tue, 05 Mar 2024 14:15:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhaGQ-0005ap-EY
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:15:46 -0500
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rnn59437@gmail.com>)
 id 1rhaGO-0003HY-TW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 14:15:46 -0500
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-21fed501addso3409306fac.2
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 11:15:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709666143; x=1710270943; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9/ihvTwChu9fLBn1SiTMhnwk+6YX44290mJbtPdZ0U=;
 b=ORcvQqaaNN+mzEMXIsDopmRsTXquq2qLyAtAIFd1spOKA4sP6NFlpEaAKZPxVoJCNc
 M/BWCHQ9b9gP72gQgrcL5vosMrpOnolv3lTQcOsWtzCAbvmlJ8TxOjEwNXHaALyHbiy8
 2ugKH53iU5dB+dzDvLhhF8k7GStAr5DKLFIEKl1uYNPu8yi0+q0R36BZxpIFaRkfRrkg
 8ja9PYb3BWG1Cul+CB99PQ6aY0tUeUgR1aL17V7Q4LVPVeZJWX5/rX2MhWkzpwJFySn2
 R/NUKErMEQ0sjEJSS23FICKapX9Gkpd/fI3GGjRjb4nVa5Mdv2h/q7PCNNQQnvjn0MkD
 8u6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709666143; x=1710270943;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9/ihvTwChu9fLBn1SiTMhnwk+6YX44290mJbtPdZ0U=;
 b=HMpH6tgm4EYlpdLoeWmDDekfBYljYj6l8VBLuzWV+TgT0aNqNCKDtrIopz8hizzRJl
 vktDTgGkAInykTupG3mc+j6U3gJgowv+PXmH/s0/wswvzOtjHQbdxoHB78e3XcexoYy/
 NWWTUH3NdjLzenachAbN5ZcBZLQR0VMpZh2VE6qfpFEsTPEfkHoQQ+8dkkzT2hAXhIoQ
 kppCFNpuL1YmT7RpV2GuPrnjIVTv2DWzX7BoCnfkFtIKTRkJjcG0KDnwmlAwauGCrw92
 2zD1kfKleq8yn2YgVSjHuHEfC6dM+VoUcQEjksptu0k+6Z7hnCnqmsa6UymM7xgXDlb0
 dbhA==
X-Gm-Message-State: AOJu0YxADlaaS0uVm/Sp0htdEJ95ibNnF8DHQv+6H17yr6ap4FFCR+z5
 1TeKab6VjYkBDfUvQD+N8kVKuJbWWZ0nUYIJH4nicC2p16rzG0GlzFVTNYsQBd3Dwz2k5RcKCPR
 KEbKJYSIc8gzMqoHXaRsMwcoGPvs0KmTs57Xl3f08cM2w7dATe1I6/FobFrk/omz/IgHADggZoB
 MSuw==
X-Google-Smtp-Source: AGHT+IF4hfQVFrrQmCOkyUZPqgTcD8uOvVoka2vGOerojdOyfA4TOmGopbfhKG+zHGGnUAj7qYin7FwgVNWZe45wYkNzTFT49eI+75nJ
X-Received: by 2002:a05:6870:82ab:b0:21e:c594:7515 with SMTP id
 q43-20020a05687082ab00b0021ec5947515mr3065609oae.28.1709666143344; Tue, 05
 Mar 2024 11:15:43 -0800 (PST)
MIME-Version: 1.0
References: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
 <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
 <CAK4oD7AJYesHPRY3ft3cXQkqW9RAvCZVcnLSC-rfFbnpUGykAQ@mail.gmail.com>
In-Reply-To: <CAK4oD7AJYesHPRY3ft3cXQkqW9RAvCZVcnLSC-rfFbnpUGykAQ@mail.gmail.com>
From: RR NN <rnn59437@gmail.com>
Date: Tue, 5 Mar 2024 22:45:32 +0330
Message-ID: <CAK4oD7BPnGaPR5QzXGYdEqYyXTB5Pt4SYjHzHzLV_S+Mg3cwXw@mail.gmail.com>
Subject: Re: ARM hypervisors
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000289c7c0612eeab3a"
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=rnn59437@gmail.com; helo=mail-oa1-x34.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_KAM_HTML_FONT_INVALID=0.01,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000289c7c0612eeab3a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=F0=9F=92=96

RR reacted via Gmail
<https://www.google.com/gmail/about/?utm_source=3Dgmail-in-product&utm_medi=
um=3Det&utm_campaign=3Demojireactionemail#app>

On Tue, Mar 5, 2024, 22:44 RR NN <rnn59437@gmail.com> wrote:

> Awesome, thanks for the info!
>
> On Tue, Mar 5, 2024, 17:29 Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
>> On Tue, 5 Mar 2024 at 13:40, RR NN <rnn59437@gmail.com> wrote:
>> >
>> > Hello
>> > ARM hypervisors (pKVM, Gunyah) can run x86 OSs?
>>
>> No. A hypervisor uses the host CPU's virtualization extensions
>> to allow the guest code to run directly on the host CPU. This
>> is why they're fast. This also means that they only work when
>> the guest CPU is the same architecture as the host CPU.
>> So you can run an x86 OS on an x86 host CPU, or an Arm
>> OS on an Arm host CPU using a hypervisor, but you can't run
>> a guest of the "wrong" architecture.
>>
>> thanks
>> -- PMM
>>
>

--000000000000289c7c0612eeab3a
Content-Type: text/vnd.google.email-reaction+json; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

{
  "emoji": "=F0=9F=92=96",
  "version": 1
}
--000000000000289c7c0612eeab3a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><p style=3D"font-size:50px;margin-top:0;margin-bottom:0">=F0=9F=92=96<=
/p><p style=3D"margin-top:10px;margin-bottom:0">RR reacted via <a style=3D"=
color:unset;text-decoration:underline" href=3D"https://www.google.com/gmail=
/about/?utm_source=3Dgmail-in-product&amp;utm_medium=3Det&amp;utm_campaign=
=3Demojireactionemail#app">Gmail</a></p></div><br><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Mar 5, 2024, 22:44 RR NN &l=
t;<a href=3D"mailto:rnn59437@gmail.com">rnn59437@gmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><div dir=3D"auto">Awesome, thanks fo=
r the info!=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Tue, Mar 5, 2024, 17:29 Peter Maydell &lt;<a href=3D"ma=
ilto:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.m=
aydell@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Tue, 5 Mar 2024 at 13:40, RR NN &lt;<a href=3D"mailto:rnn59437@gmail.com" =
rel=3D"noreferrer noreferrer" target=3D"_blank">rnn59437@gmail.com</a>&gt; =
wrote:<br>
&gt;<br>
&gt; Hello<br>
&gt; ARM hypervisors (pKVM, Gunyah) can run x86 OSs?<br>
<br>
No. A hypervisor uses the host CPU&#39;s virtualization extensions<br>
to allow the guest code to run directly on the host CPU. This<br>
is why they&#39;re fast. This also means that they only work when<br>
the guest CPU is the same architecture as the host CPU.<br>
So you can run an x86 OS on an x86 host CPU, or an Arm<br>
OS on an Arm host CPU using a hypervisor, but you can&#39;t run<br>
a guest of the &quot;wrong&quot; architecture.<br>
<br>
thanks<br>
-- PMM<br>
</blockquote></div>
</blockquote></div>

--000000000000289c7c0612eeab3a--

