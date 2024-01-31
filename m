Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74554C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 15:23:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVCQM-0007Dd-FS; Wed, 31 Jan 2024 10:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVCQF-0007Bh-EH
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rVCQD-00073U-9z
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 10:22:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706714559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NFS1hnVdyyBfAftv4YLN9PhOlVC7c4KyfDHCOLNRUwQ=;
 b=KYB8Otc5JU1z8G4RtxPNYuP36BZN0sWyYFqMegvuw9Ry8kTKPkiZH7G6J/kQu+3ShTkZyj
 3iGNgRw2fcK1MZ9YIxfC1F+KzcNSHGdz4+TRlQZrBI3Dh6uD3V+ha4pZsXH9oEkml+Gz81
 kVH4+ERha7B/g9k5p+5MPxbw1a6H8XI=
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-o6ajJPmrO-KvAcMB211afg-1; Wed, 31 Jan 2024 10:22:37 -0500
X-MC-Unique: o6ajJPmrO-KvAcMB211afg-1
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-46b17994ddbso1287682137.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jan 2024 07:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706714557; x=1707319357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NFS1hnVdyyBfAftv4YLN9PhOlVC7c4KyfDHCOLNRUwQ=;
 b=l2azKiwrVq2FvKOpSbDwOo1y7Av6bpsL+7S8HOG5GisKk/Csci+I9s+ytuoAnIGeSI
 mSwbxxMsW2jdeuxRY8L286SaYbdvQ3zf/KaNTjwnfzmjIPVmoHJnDYdG1IrvvFl1EB0w
 VGjCSy11PleiBnXejTtOAlU7Crds9Ceb2xWWK0cFizBJ8xkqjVAR+hhla8V7Mstjn0YE
 hiSFD3Y+7IRNqYbftK/WGRmrBXmTeGFwzPLlbq4zkHPNeqwUSWbQtOxSCxYS13QUa0o9
 ZebqMW9R4jdkbDi8zToDesaPfNyFdlLAQGuNsp2Chh9PjsFyb8kfyrX2iz2ne22dtrqZ
 T/Zw==
X-Gm-Message-State: AOJu0YxzPq62lFiLdUWgqayGNJiwMzFhjhOUq2E3DoiM9jakrFUsPZ9l
 Rf4JOc9ADqig+2bhlHLLr6lYAuzDVrDFUuqf88QPjP3NLOnB++M12lx4BlDqjvhv5glVmJVOFIb
 dDrOiEKP/f1Ub6UyD5BTxHAJoMCMFgPEjByVSQUeBsfTqmnX4Uoc+/slblPSvwAwPKrdK0vybPZ
 EyIZKmz7nr70s6D+szSes0a0mEUUtA8Her7ig=
X-Received: by 2002:a67:eec8:0:b0:469:4f37:8a10 with SMTP id
 o8-20020a67eec8000000b004694f378a10mr1615930vsp.11.1706714556875; 
 Wed, 31 Jan 2024 07:22:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6eUqNuajVvDowBAVSfLk2z4yOlJgZVwM223RYdaBv/cIWoMRGuPM5nXiNL4MWlG01NjipI/s7neOt4ePF3KU=
X-Received: by 2002:a67:eec8:0:b0:469:4f37:8a10 with SMTP id
 o8-20020a67eec8000000b004694f378a10mr1615917vsp.11.1706714556580; Wed, 31 Jan
 2024 07:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20240129121312.1057281-1-pbonzini@redhat.com>
 <1ff4b856-352b-4eb0-944e-67ab75474be8@linaro.org>
 <CABgObfZ5r9DRjaxWZcOJ4u5+8zz8LmKtY562-6phu6FiYBV7bA@mail.gmail.com>
In-Reply-To: <CABgObfZ5r9DRjaxWZcOJ4u5+8zz8LmKtY562-6phu6FiYBV7bA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 Jan 2024 15:25:41 +0100
Message-ID: <CABgObfZeykpBx0fPLfa-11eUdM=qMY4mVNA_co1E4Wxq8TVsbA@mail.gmail.com>
Subject: Re: [PATCH] mips: allow compiling out CONFIG_MIPS_ITU
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000e0e2e506103f724c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001,
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

--000000000000e0e2e506103f724c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 29 gen 2024, 14:31 Paolo Bonzini <pbonzini@redhat.com> ha scritto:

> On Mon, Jan 29, 2024 at 2:30=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > Hi Paolo,
> >
> > On 29/1/24 13:13, Paolo Bonzini wrote:
> > > itu_reconfigure() is referenced from TCG, provide a stub if needed.
> >
> > s/itu_reconfigure/itc_reconfigure/
> >
> > What are you trying to achieve?
>
> I'm trying to build all MIPS boards one by one (to clean up
> configs/devices/mips*).
>

Is this okay? It's not *required* in order to clean up
configs/devices/mips*, but it's still a bug.

Paolo


> Paolo
>

--000000000000e0e2e506103f724c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 29 gen 2024, 14:31 Paolo Bonzini &lt;<a href=3D=
"mailto:pbonzini@redhat.com">pbonzini@redhat.com</a>&gt; ha scritto:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">On Mon, Jan 29, 2024 at 2:30=E2=80=AFPM P=
hilippe Mathieu-Daud=C3=A9<br>
&lt;<a href=3D"mailto:philmd@linaro.org" target=3D"_blank" rel=3D"noreferre=
r">philmd@linaro.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi Paolo,<br>
&gt;<br>
&gt; On 29/1/24 13:13, Paolo Bonzini wrote:<br>
&gt; &gt; itu_reconfigure() is referenced from TCG, provide a stub if neede=
d.<br>
&gt;<br>
&gt; s/itu_reconfigure/itc_reconfigure/<br>
&gt;<br>
&gt; What are you trying to achieve?<br>
<br>
I&#39;m trying to build all MIPS boards one by one (to clean up<br>
configs/devices/mips*).<br></blockquote></div></div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Is this okay? It&#39;s not *required* in order to cl=
ean up configs/devices/mips*, but it&#39;s still a bug.</div><div dir=3D"au=
to"><br></div><div dir=3D"auto">Paolo</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Paolo<br>
</blockquote></div></div></div>

--000000000000e0e2e506103f724c--


