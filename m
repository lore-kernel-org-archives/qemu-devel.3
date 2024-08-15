Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F72C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:21:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebKt-0008El-Fs; Thu, 15 Aug 2024 10:20:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sebKr-000874-Dc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:20:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sebKj-0003nj-Lc
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723731606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u3WtZSMfl6JPJqz6Df7WnUwGWmzMJu9W4hqDL+r9wuY=;
 b=NV7omrLNr7xy9YF+7vvg5EOxW3HMCInv9FBIN8NP2uVaPderNN3qO7B8tkT9SOlkBm4EV1
 pdUuI7n2NbS6H7TypdtNBFCXbDfgdfHJ7l2cIcCJwiIeEaclKzuVWA9QEJP8zIx2ZVttpG
 LhS402VIdY3t8QnsyIiVFmTljH0IgqE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-mWDn-J6iOyex7PxOiIePtw-1; Thu, 15 Aug 2024 10:20:04 -0400
X-MC-Unique: mWDn-J6iOyex7PxOiIePtw-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-7a3c6dd559aso835539a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723731603; x=1724336403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u3WtZSMfl6JPJqz6Df7WnUwGWmzMJu9W4hqDL+r9wuY=;
 b=Y8DECuHoSiAcw+YaXoLI3X4ea/xYoR7+JENfTbgBgLpHeD2jdiW260KqZnVOjs20K3
 25akcq9cK3LrcIP+7tAPxYeJTny9bLVoM2nSXIaE66mSIPmRTtChVXkaKAxneyx2hC03
 onc8TxDzMNjAegqYSkcgp315vF+Ladiq4hc5dp5t+Ri1fyxlxznkl4tAxKoQfQIryu49
 EPyg/gANo2D3sLUPQV6Wyynn7VI3ShPMzQP0Icq/dtwgKbiQSBlnEZXvagdjHsvnGI8O
 Nhr92poZq5UtYQ8HVUir8+PiNi4ogOM9dFWYUcONzSik0snDDQ40xYHZHeRQD2S0nA/h
 4DCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgeJNut5rPGL5FhfInz1QUcnaXCI5ZEeLKF3t754sFFkQBO2sTYel3VjLUbmV1Pw4+kuxHq2mWWopDlE5XkPVXRqeEIMQ=
X-Gm-Message-State: AOJu0Yw6seADvjcSDPfhjjLNtMT4KyVxgc6dAjJeKKScoCUC0Y3k4lu9
 xkHm8FhzTVl+m54t6EYPtAO+n9tVG3tZTQmYM36FM4R0B+z1xy+w7UPoNSWi2w+okkHj2LDmlLO
 Ubx2DuBdmAVGvizRFFRKIoRYA8HfRVDjjBY7/N7udCuJRkezOFZ6CFKl+zv+zdamA9S51ODeioA
 sTTV0OesOR5xGQJaS6heNlvhUJpMk=
X-Received: by 2002:a17:902:db06:b0:1fb:a2c0:53b1 with SMTP id
 d9443c01a7336-201d63c5056mr69449725ad.13.1723731603429; 
 Thu, 15 Aug 2024 07:20:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOfqinU5+WEdzq3/ImY5/eAVPDpEQSM2Yx3Xy+9B2h2XWstzZ2SCM/aG0dr7UdYkzoPLNVQ03PXa8kZmf0aWQ=
X-Received: by 2002:a17:902:db06:b0:1fb:a2c0:53b1 with SMTP id
 d9443c01a7336-201d63c5056mr69449415ad.13.1723731602944; Thu, 15 Aug 2024
 07:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <CAFn=p-ZJZ1BScebJtgGmFBwV4n2Yhyha6WFAmVe9_T2c4ML7Dw@mail.gmail.com>
 <b5587a20-d2ad-4dfa-aba5-0154ebe8c61d@linaro.org>
In-Reply-To: <b5587a20-d2ad-4dfa-aba5-0154ebe8c61d@linaro.org>
From: John Snow <jsnow@redhat.com>
Date: Thu, 15 Aug 2024 10:19:50 -0400
Message-ID: <CAFn=p-aNvr3i-SvhR-x8s1UEg8TdZgZBBPg4cOou8TUjby9JOA@mail.gmail.com>
Subject: Re: Removing python/qemu/qmp
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000e1cd20061fb98936"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

--000000000000e1cd20061fb98936
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024, 10:18=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd@=
linaro.org>
wrote:

> On 15/8/24 15:58, John Snow wrote:
> > Hi Paolo,
> >
> > Let's discuss finally dropping the qemu.qmp lib out of qemu.git in favo=
r
> > of using the standalone package at
> > https://gitlab.com/qemu-project/python-qemu-qmp/
> > <https://gitlab.com/qemu-project/python-qemu-qmp/>
>
>
> > Thoughts? Lets schedule a call to discuss if we can. (Anyone else
> > interested can join if they want.)
>
> Next community call is next week on Tuesday 20, 2pm UTC.
> (https://meet.jit.si/kvmcallmeeting)
>

Sure, if Paolo can join - he's technically on PTO :)

>

--000000000000e1cd20061fb98936
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">On Thu, Aug 15, 2024, 10:18=E2=80=AFAM Philippe Mathie=
u-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">philmd@linaro.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 15/8/24 15:58, John =
Snow wrote:<br>
&gt; Hi Paolo,<br>
&gt; <br>
&gt; Let&#39;s discuss finally dropping the qemu.qmp lib out of qemu.git in=
 favor <br>
&gt; of using the standalone package at <br>
&gt; <a href=3D"https://gitlab.com/qemu-project/python-qemu-qmp/" rel=3D"no=
referrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-project/pyth=
on-qemu-qmp/</a> <br>
&gt; &lt;<a href=3D"https://gitlab.com/qemu-project/python-qemu-qmp/" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-projec=
t/python-qemu-qmp/</a>&gt;<br>
<br>
<br>
&gt; Thoughts? Lets schedule a call to discuss if we can. (Anyone else <br>
&gt; interested can join if they want.)<br>
<br>
Next community call is next week on Tuesday 20, 2pm UTC.<br>
(<a href=3D"https://meet.jit.si/kvmcallmeeting" rel=3D"noreferrer noreferre=
r" target=3D"_blank">https://meet.jit.si/kvmcallmeeting</a>)<br></blockquot=
e></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Sure, if Paolo =
can join - he&#39;s technically on PTO :)</div><div dir=3D"auto"><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000e1cd20061fb98936--


