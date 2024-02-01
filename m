Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F4AC47DDB
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 11:37:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVVNP-0005TF-HO; Thu, 01 Feb 2024 06:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVVNM-0005Rf-IU
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:37:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVVNK-00009A-9l
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 06:37:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706787417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tPH2nEDpVjBb+z7hjtSjjun7c0sDM7fw8kaOOmECzq8=;
 b=auiZB3izenEN3U+3bjHLVE1ZChFmKgCm/X5hR8hk9q3kcQzwO157qrWXA+LxO7Zwu4K6m9
 MF3q86vLTd7WCpw37p8EiT86qgNbH1HAdaNFu7rqlJR84qP7FQrcqw/FtMnLUz3O/iYKjL
 p8meTCYdwvBlKinJaGNYTraD+uvs/Eg=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-og8hrWPvNe6HODtddrN7bQ-1; Thu, 01 Feb 2024 06:36:56 -0500
X-MC-Unique: og8hrWPvNe6HODtddrN7bQ-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7d61d29a644so896905241.1
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 03:36:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706787414; x=1707392214;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPH2nEDpVjBb+z7hjtSjjun7c0sDM7fw8kaOOmECzq8=;
 b=k5BGBJ/Va+4sjvQP3eVao7NeUZUlqkyxh2YmYM2CZ5iEunxLscxhnqMY6QkDf2VTjL
 1e5zlRbMPOzLjn5Ztny7XCbHbCkMcHgk9Qnyr8g7w/m6eYwfiD6SbDIlxG6DPrtqzXuG
 VEOzYXxV9Muar3oiM1jsz7wXbYhZV2v8XOhdHlkLToOrDggjb1iPjchMxWQR3Y+hTezt
 +dkAjJVkeslas/NUb8239onwA8ay5D9ElzuYd1Oifd+vV2fkJ3SoxfZuDFfZDLRKVyHR
 CvSx3m4T1ui+AlYPq/feEvYgQ1vLN/kuokvyRghS+VJn031kQVnh8t8ChX+Teuha0sbG
 JGKg==
X-Gm-Message-State: AOJu0Yzks9dc4S1deS1P0K0IMlOKbQlCuw+q0/bi7YnczVEN68CABcuc
 J0bKMfzbW5Mr3naP/mjN8vh3HWtDuFpjW1moNkCeuIxLKbE9cfXmcUtvvB9OVG/GSOfZ2MaEGC+
 v1fzBEL8R2+TU2ZEBMr1vBmySu0Yxu9dB0tdd30w4FikBvs4WRtqDsQ5jf/N2e1h0rEiSbMlT5X
 J3/neqH3Ss5KMeBhsPsftofSLRABCC7P/m8Z6XyA==
X-Received: by 2002:a05:6102:3a77:b0:46c:9fe3:402f with SMTP id
 bf23-20020a0561023a7700b0046c9fe3402fmr3617758vsb.14.1706787414626; 
 Thu, 01 Feb 2024 03:36:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTGy6JW6p4/tAxrYaX2QEOP3n//yZvIE658ACMdqt46xiSmRLVJyX//XrM4IuxrhcsdFoQ2Y9pSCjmnU+0Mmk=
X-Received: by 2002:a05:6102:3a77:b0:46c:9fe3:402f with SMTP id
 bf23-20020a0561023a7700b0046c9fe3402fmr3617746vsb.14.1706787414317; Thu, 01
 Feb 2024 03:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20240112125420.514425-1-mark.cave-ayland@ilande.co.uk>
 <20240112125420.514425-10-mark.cave-ayland@ilande.co.uk>
 <CABgObfZ3VY84p8A=+3nOnkttQk=64vQAyNk76VRHqzURwHrYww@mail.gmail.com>
 <c9dfd1d3-c784-456f-ba6e-dc56388fd79e@ilande.co.uk>
In-Reply-To: <c9dfd1d3-c784-456f-ba6e-dc56388fd79e@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 1 Feb 2024 12:36:42 +0100
Message-ID: <CABgObfbWqHBq0udoqaPxe=H=oGQe4WwdsfU6+iJVJMF9LoGRow@mail.gmail.com>
Subject: Re: [PATCH 09/88] esp: update TC check logic in do_dma_pdma_cb() to
 check for TC == 0
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <thuth@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="00000000000089c8470610506965"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

--00000000000089c8470610506965
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il gio 1 feb 2024, 12:25 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
ha scritto:

> On 01/02/2024 10:46, Paolo Bonzini wrote:
>
> > On Fri, Jan 12, 2024 at 1:55=E2=80=AFPM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> Invert the logic so that the end of DMA transfer check becomes one tha=
t
> checks
> >> for TC =3D=3D 0 in the from device path in do_dma_pdma_cb().
> >>
> >> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> >> ---
> >>   hw/scsi/esp.c | 24 +++++++++++-------------
> >>   1 file changed, 11 insertions(+), 13 deletions(-)
> >>
> >> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> >> index fecfef7c89..63c828c1b2 100644
> >> --- a/hw/scsi/esp.c
> >> +++ b/hw/scsi/esp.c
> >> @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)
> >>               return;
> >>           }
> >>
> >> -        if (esp_get_tc(s) !=3D 0) {
> >> -            /* Copy device data to FIFO */
> >> -            len =3D MIN(s->async_len, esp_get_tc(s));
> >> -            len =3D MIN(len, fifo8_num_free(&s->fifo));
> >> -            fifo8_push_all(&s->fifo, s->async_buf, len);
> >> -            s->async_buf +=3D len;
> >> -            s->async_len -=3D len;
> >> -            s->ti_size -=3D len;
> >> -            esp_set_tc(s, esp_get_tc(s) - len);
> >> -            return;
> >> +        if (esp_get_tc(s) =3D=3D 0) {
> >> +            esp_lower_drq(s);
> >> +            esp_dma_done(s);
> >>           }
> >
> > I'm only doing a cursory review, but shouldn't there be a return here?
> >
> > Paolo
>
> (goes and looks)
>
> Possibly there should, but my guess is that adding the return at that
> particular
> point in time at the series broke one of my reference images. In
> particular MacOS is
> notorious for requesting data transfers of X len, and setting the TC
> either too high
> or too low and let the in-built OS recovery logic handle these cases.
>

Absolutely, just noticing that there is a functional change but the commit
message showed it as a refactoring only.

The fact that this is bisectable is quite insane, and I am not asking for
any code changes. TBH I wouldn't have blamed you if you just sent a patch
to create esp2.c and a patch to delete esp.c...

Paolo


The tricky part is that as per the cover note, making expected changes at
> an earlier
> point in the series tends to cause things to break. Another thing to bear
> in mind is
> that one of the main objectives of the series to completely remove all th=
e
> PDMA-specific callbacks including do_dma_pdma_cb(), so you'll see this
> function
> disappear completely in a later patch.
>
> It probably helps to compare the existing code at
> https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/esp.c against
> the version
> from this series at
> https://gitlab.com/mcayland/qemu/-/blob/esp-rework-v2/hw/scsi/esp.c to
> get a feeling
> where the series is going, as in order to keep my reference images
> bisectable the
> journey from start to finish occurs in a fairly roundabout way.
>
> >> -        /* Partially filled a scsi buffer. Complete immediately.  */
> >> -        esp_lower_drq(s);
> >> -        esp_dma_done(s);
> >> +        /* Copy device data to FIFO */
> >> +        len =3D MIN(s->async_len, esp_get_tc(s));
> >> +        len =3D MIN(len, fifo8_num_free(&s->fifo));
> >> +        fifo8_push_all(&s->fifo, s->async_buf, len);
> >> +        s->async_buf +=3D len;
> >> +        s->async_len -=3D len;
> >> +        s->ti_size -=3D len;
> >> +        esp_set_tc(s, esp_get_tc(s) - len);
> >>       }
> >>   }
> >>
> >> --
> >> 2.39.2
>
>
> ATB,
>
> Mark.
>
>

--00000000000089c8470610506965
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il gio 1 feb 2024, 12:25 Mark Cave-Ayland &lt;<a href=
=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.cave-ayland@ilande.co.uk</a>=
&gt; ha scritto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 01/02/2024 10:4=
6, Paolo Bonzini wrote:<br>
<br>
&gt; On Fri, Jan 12, 2024 at 1:55=E2=80=AFPM Mark Cave-Ayland<br>
&gt; &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk" target=3D"_blank"=
 rel=3D"noreferrer">mark.cave-ayland@ilande.co.uk</a>&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; Invert the logic so that the end of DMA transfer check becomes one=
 that checks<br>
&gt;&gt; for TC =3D=3D 0 in the from device path in do_dma_pdma_cb().<br>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Mark Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ay=
land@ilande.co.uk" target=3D"_blank" rel=3D"noreferrer">mark.cave-ayland@il=
ande.co.uk</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0hw/scsi/esp.c | 24 +++++++++++-------------<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 11 insertions(+), 13 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c<br>
&gt;&gt; index fecfef7c89..63c828c1b2 100644<br>
&gt;&gt; --- a/hw/scsi/esp.c<br>
&gt;&gt; +++ b/hw/scsi/esp.c<br>
&gt;&gt; @@ -602,21 +602,19 @@ static void do_dma_pdma_cb(ESPState *s)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (esp_get_tc(s) !=3D 0) {<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Copy device data to =
FIFO */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D MIN(s-&gt;async=
_len, esp_get_tc(s));<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D MIN(len, fifo8_=
num_free(&amp;s-&gt;fifo));<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_push_all(&amp;s-&=
gt;fifo, s-&gt;async_buf, len);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;async_buf +=3D le=
n;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;async_len -=3D le=
n;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ti_size -=3D len;=
<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_set_tc(s, esp_get_t=
c(s) - len);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (esp_get_tc(s) =3D=3D 0) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_lower_drq(s);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_dma_done(s);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; I&#39;m only doing a cursory review, but shouldn&#39;t there be a retu=
rn here?<br>
&gt; <br>
&gt; Paolo<br>
<br>
(goes and looks)<br>
<br>
Possibly there should, but my guess is that adding the return at that parti=
cular <br>
point in time at the series broke one of my reference images. In particular=
 MacOS is <br>
notorious for requesting data transfers of X len, and setting the TC either=
 too high <br>
or too low and let the in-built OS recovery logic handle these cases.<br></=
blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Absolu=
tely, just noticing that there is a functional change but the commit messag=
e showed it as a refactoring only.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">The fact that this is bisectable is quite insane, and I am not a=
sking for any code changes. TBH I wouldn&#39;t have blamed you if you just =
sent a patch to create esp2.c and a patch to delete esp.c...</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">Paolo=C2=A0</div><div dir=3D"auto"><b=
r></div><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_q=
uote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
The tricky part is that as per the cover note, making expected changes at a=
n earlier <br>
point in the series tends to cause things to break. Another thing to bear i=
n mind is <br>
that one of the main objectives of the series to completely remove all the =
<br>
PDMA-specific callbacks including do_dma_pdma_cb(), so you&#39;ll see this =
function <br>
disappear completely in a later patch.<br>
<br>
It probably helps to compare the existing code at <br>
<a href=3D"https://gitlab.com/qemu-project/qemu/-/blob/master/hw/scsi/esp.c=
" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/qemu-p=
roject/qemu/-/blob/master/hw/scsi/esp.c</a> against the version <br>
from this series at <br>
<a href=3D"https://gitlab.com/mcayland/qemu/-/blob/esp-rework-v2/hw/scsi/es=
p.c" rel=3D"noreferrer noreferrer" target=3D"_blank">https://gitlab.com/mca=
yland/qemu/-/blob/esp-rework-v2/hw/scsi/esp.c</a> to get a feeling <br>
where the series is going, as in order to keep my reference images bisectab=
le the <br>
journey from start to finish occurs in a fairly roundabout way.<br>
<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Partially filled a scsi buffer. Co=
mplete immediately.=C2=A0 */<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_lower_drq(s);<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_dma_done(s);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Copy device data to FIFO */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D MIN(s-&gt;async_len, esp_get_=
tc(s));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 len =3D MIN(len, fifo8_num_free(&amp;=
s-&gt;fifo));<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 fifo8_push_all(&amp;s-&gt;fifo, s-&gt=
;async_buf, len);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;async_buf +=3D len;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;async_len -=3D len;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;ti_size -=3D len;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 esp_set_tc(s, esp_get_tc(s) - len);<b=
r>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; --<br>
&gt;&gt; 2.39.2<br>
<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div></div>

--00000000000089c8470610506965--


