Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4F3C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 02:28:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujTsI-0003gE-OZ; Tue, 05 Aug 2025 22:27:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujTs9-0003Z0-8G
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 22:27:21 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tanishdesai37@gmail.com>)
 id 1ujTs7-0005yo-Be
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 22:27:20 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-af96524c5a9so432196366b.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 19:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754447235; x=1755052035; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JIoiXM5/mkBkzVbI1Xb7LdTocLxnCXGI+nbNqs9Nx0s=;
 b=VeuBQ2FkjT5UUg4wp+hOlBqR8Tuk0IeHKTc8iLl5yoQPdggkpo8Fgd+JUOjbS1lRt8
 9ahRVSs0TTcGidocTFsaXGPAqigFCYo3Ft2Cj3kO3dA0IgZEjvM9LF+dza5nGj6JbZ6k
 85nYWrEVs5j5yZPG2L4f1wYZOitySySHsaeRExPIuf300Z+mE8DYCaAvdxyNUQLhoRTR
 cppUIgZ0OyHKmQiGI052bm0OZOvdhKEfy8OSifgKfmt4YB7RvyFWgdUnYJdA6Whkmt2+
 /l7SylFOu0QTSGgBqmJyrBqJ1mEyNiC2fFkIN7DcNTlu1cAUldqKeZALfvP/Su5W0F0B
 9+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754447235; x=1755052035;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JIoiXM5/mkBkzVbI1Xb7LdTocLxnCXGI+nbNqs9Nx0s=;
 b=qn96gR6CqQrRbkIOrQv3Xqp3FP2k74rAgHZ7xejRI17KUrFrrTnROnHJmcDi7Ch70T
 gZuUe/ya2vgnDrhUp2Q3Eh3Ni7DNy2rBSIGp4KdJTKGIjAipRASV0dcgOQ8nokveq3qI
 /OZrlGmJHdA9fGEDMvccYoIEDGgYzrh0RbiNnINEEogPldjcS6JIK6YLO1XpkXL3w3us
 cXucBOELrVvIKevsZj8F+SqpUQHN2DtR/rKyxLXGnBhoT0EBVsFhreZb/eqRPl0P5LWZ
 L/x9NHCHmoUe8AVK321AozyGQKwc2MRruN3qY6eq4Jh1N8JACJkIAD96pSkUj4m7UZ3r
 cbPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTbXONhGVEkFb/xuSMSMLlbQFclJmdhwT0Wuky3xni/0bLBHwWK8ClJ5Usp9JM3eO3iz1eg1DF8bJ/@nongnu.org
X-Gm-Message-State: AOJu0YyTWGejTtBiOGY82n6wHfLmefCW3OodK+gMXrr5/pnex9L1j3+a
 A4MS9sfSrmC3FeyYGTKfMrdIOYl+do52migDqn6NUv50QCLqarFXH1LWzdrO3/Ahn/fNRtUulqu
 9FjtLSwm7WCt7A2Kdla4kvcsfyJgpsmo=
X-Gm-Gg: ASbGncuC7qWbwLg6GB0MxYqDdENfn36el9JpwPw/GLftGnGPUpKbzE5VWsk2Ztw8kkW
 5I8aBeWSu9g5avOl7czpz2svw6R/ZQcaa1i1fZPdFfNExVS5XCQCzvsGDB5CSCiG2hYZLZ9Wz/j
 rzK3BL8UAQKFBO0VyKe4w7P7uHei3NHmvNRyPEf/ue2xnHs5mvZnGt4k6CHPggjq1driuWDcELz
 q0szmfuVw==
X-Google-Smtp-Source: AGHT+IEWLjutcU3qf0dLA72/E0kJPguynxHnA0McPqvgeXaAS24CygDLtFUn48MLohMZKJWT9T1m2heTzhrECddip4A=
X-Received: by 2002:a17:907:7f29:b0:af9:4fa9:b0fa with SMTP id
 a640c23a62f3a-af992ade9f8mr61647866b.27.1754447234917; Tue, 05 Aug 2025
 19:27:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250804112039.16377-1-tanishdesai37@gmail.com>
 <20250804112039.16377-2-tanishdesai37@gmail.com> <aJJliv-xKgH4piH6@redhat.com>
 <3d4e5755-8512-4b01-b941-f6e763d36386@redhat.com>
In-Reply-To: <3d4e5755-8512-4b01-b941-f6e763d36386@redhat.com>
From: Tanish Desai <tanishdesai37@gmail.com>
Date: Wed, 6 Aug 2025 07:57:03 +0530
X-Gm-Features: Ac12FXxyO_YhFFtW9pvyHqrdqLC-QqAuDtAvM11gMDmAZ3AHO8jaDt5BKocuabw
Message-ID: <CAH_Y1jeK+8r6yAXCo+vk7rYG2mfY1LdxEmiR52-EaZhx9T6d8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracetool: add CHECK_TRACE_EVENT_GET_STATE
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Content-Type: multipart/alternative; boundary="00000000000036eb11063ba91451"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=tanishdesai37@gmail.com; helo=mail-ej1-x635.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--00000000000036eb11063ba91451
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for pointing out the bug and suggesting a fix for it.

On Wed, Aug 6, 2025 at 4:02=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com> =
wrote:

> On 8/5/25 22:11, Daniel P. Berrang=C3=A9 wrote:
> > Something here is broken with the "simple" trace backend, as the entire
> > '.c' file content is no longer generated, causing link errors
>
> I think the bug is here:
>
Yes this was the bug.

> +    def generate(self, event, group, check_trace_event_get_state=3DFalse=
):
> +        self._run_function("generate_%s", event, group,
> check_trace_event_get_state=3Dcheck_trace_event_get_state)
>
> The default must be None, i.e. do not filter at all, instead of False.
>
> Paolo
>
>

--00000000000036eb11063ba91451
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div>Thanks for pointing out the bug=
 and suggesting a fix for it.<div><br><div><div class=3D"gmail_quote gmail_=
quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 6, 2025 =
at 4:02=E2=80=AFAM Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com"=
>pbonzini@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">On 8/5/25 22:11, Daniel P. Berrang=C3=A9 wrote:<br>
&gt; Something here is broken with the &quot;simple&quot; trace backend, as=
 the entire<br>
&gt; &#39;.c&#39; file content is no longer generated, causing link errors<=
br>
<br>
I think the bug is here:<br></blockquote><div>Yes this was the bug.=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 def generate(self, event, group, check_trace_event_get_state=
=3DFalse):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self._run_function(&quot;generate_%s&quot;, ev=
ent, group, check_trace_event_get_state=3Dcheck_trace_event_get_state)<br>
<br>
The default must be None, i.e. do not filter at all, instead of False.<br>
<br>
Paolo<br>
<br>
</blockquote></div></div></div></div>

--00000000000036eb11063ba91451--

