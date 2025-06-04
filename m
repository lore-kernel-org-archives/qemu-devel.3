Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B7BC5B549
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 18:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMsv9-0005l5-9Y; Wed, 04 Jun 2025 14:33:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMsv4-0005iM-4K
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1uMsv2-0001R2-FV
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 14:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749061974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O03OutEU4kkaELZ0kHhwMzV+M17BOPMLYvfO51huIsk=;
 b=UIkrwV8i2/isqYeoGv/vQ1SlcL8w/4ISWydqod1iiDqxA3DIf5ZOu0Z3AH0lYpozDIa+DG
 uytmQO31JfCK+QQbBMUMt8MQxS67QUBC5eo9i6Pb6MPDGRAF8c/MWOR/YyH+KyDw863hDJ
 rnASqBAb8Xo0Y8jDvCfYltjg0N4wJ/w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-iVdePQGoN829x0CDJat2sA-1; Wed, 04 Jun 2025 14:32:52 -0400
X-MC-Unique: iVdePQGoN829x0CDJat2sA-1
X-Mimecast-MFC-AGG-ID: iVdePQGoN829x0CDJat2sA_1749061972
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4a43f155708so1598951cf.2
 for <qemu-devel@nongnu.org>; Wed, 04 Jun 2025 11:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749061972; x=1749666772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O03OutEU4kkaELZ0kHhwMzV+M17BOPMLYvfO51huIsk=;
 b=n/yraM5aUT14ImZbhE8AhipPsi0vThA0hveHM2KrmnkdvfUVqeQGj394+/qPTFUjCS
 GowtUu/VYvgdyo9SOJqbfx5xj3xrb/3W8m+YsOP2QgiIurAlXVPiGqIisKaycFSbe0sP
 Ny8bwMY8dq5pb61HjdYww20jdEUADYfDJkwdtqMxYui/ww9qeeML0eWYLNk2iIX714jg
 A7AL557rsjjaEz/xhiec1FNjlPe89xKETcHV5gHnunZc2VIPQpPpW1yV4AqomdmLe5LL
 yNEnjKzOxZdwY4N1y16gjex3Azz1bD9lqDAlC/qw3MVrbFmXUU98XsK7v9SzmRTqjrIO
 smjg==
X-Gm-Message-State: AOJu0Yzv9VI6yEBrl0oPBF2hITVbeTgGC/NXUmzSEsL5WosCeHXq7zT4
 JM8a60SrIvrXLYt40x4P4fKaLrP8IlEsIwlsy/UplFu6ydU6rvYgWsSwCELQySMQ/d8S39ZPMIH
 zHGh13rXHmfLc3pJVFDu9DqdyR2ESo8hNhQNADS9QERxFkhdt+cxOFhzGcExeakYjHcNrPCBzgW
 c14La8K3Kyifu41gfTsIDfN9MRmf6JmW8=
X-Gm-Gg: ASbGnctn1W8uP+ALB1cfzfWxq3v/4iz56Z357MenvR8YYz23p6C8uNbtas/v6fiPwpB
 XpBCR6RP3Mw7+5EECsDAKdIoLCXV5u0AcOJsAwYjqLCYJOVX6URAreAlfbDJ9eCMDQJeUjEhOCO
 pZQOCrzDSUa443BlxbX1sPZsoAaw==
X-Received: by 2002:a05:622a:2289:b0:4a4:3079:55e2 with SMTP id
 d75a77b69052e-4a5a5885018mr62286961cf.41.1749061972220; 
 Wed, 04 Jun 2025 11:32:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwa8AMoIywpzQvGUYmA9erFb76tpI/2wTsa6O2HuZmdzT02VqnUTSwIUhllPfjXHYeirSb4QE75GhIFJk6HLI=
X-Received: by 2002:a05:622a:2289:b0:4a4:3079:55e2 with SMTP id
 d75a77b69052e-4a5a5885018mr62286641cf.41.1749061971885; Wed, 04 Jun 2025
 11:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250604162243.452791-1-berrange@redhat.com>
In-Reply-To: <20250604162243.452791-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 4 Jun 2025 22:32:41 +0400
X-Gm-Features: AX0GCFsNwEHFqykU-V69ACegaTVZtGoKzmhNCCObMbkxxgS-E2uIdDQAZ3wC-y0
Message-ID: <CAMxuvazWE5ouoHvV-eQhCsTh1VDhTqc0-C2vS-v9xUxyr74mOw@mail.gmail.com>
Subject: Re: [PATCH 0/2] ui: fix VNC endian regression & improve tracing
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000008653110636c3396e"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--0000000000008653110636c3396e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 4, 2025 at 8:22=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@re=
dhat.com>
wrote:

>
>
> Daniel P. Berrang=C3=A9 (2):
>   ui: fix setting client_endian field defaults
>   ui: add trace events for all client messages
>
>  ui/trace-events | 14 +++++++++++++
>  ui/vnc.c        | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 67 insertions(+)
>

Series:
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


>
> --
> 2.49.0
>
>

--0000000000008653110636c3396e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 4, =
2025 at 8:22=E2=80=AFPM Daniel P. Berrang=C3=A9 &lt;<a href=3D"mailto:berra=
nge@redhat.com">berrange@redhat.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><br>
<br>
Daniel P. Berrang=C3=A9 (2):<br>
=C2=A0 ui: fix setting client_endian field defaults<br>
=C2=A0 ui: add trace events for all client messages<br>
<br>
=C2=A0ui/trace-events | 14 +++++++++++++<br>
=C2=A0ui/vnc.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 53 ++++++++++++++++++++++++++++=
+++++++++++++++++++++<br>
=C2=A02 files changed, 67 insertions(+)<br></blockquote><div><br></div><div=
>Series:</div><div>Reviewed-by: Marc-Andr=C3=A9 Lureau &lt;<a href=3D"mailt=
o:marcandre.lureau@redhat.com">marcandre.lureau@redhat.com</a>&gt;</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>

--0000000000008653110636c3396e--


