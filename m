Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E1AC54798
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 10:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfe1I-0007zd-UQ; Thu, 29 Feb 2024 05:52:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfe1H-0007zF-FF
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:52:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1rfe1F-0004ht-Oc
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 05:52:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709203924;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o0/b36wufjiFpSkm6wzI1r8NiwQdjDt3vKAFhFqGRJ4=;
 b=DqMb7oJsBKYRkNaJ6MAJDyrKkjDFr0bIdKviVXH5Ugqphyof3WvKWThbro2HErpwUC6CGa
 bu0gX+kizPovWDr0PgEWnG4x2FVOxqJD5o3IBxYMRs952CTCAgoEWTegxTNR5dhZrkX3sE
 m49AnuT/zvo2e86G9RvkaabWrh0adZE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-HhuNYQPaOb69u4g8Gp6VjA-1; Thu, 29 Feb 2024 05:52:02 -0500
X-MC-Unique: HhuNYQPaOb69u4g8Gp6VjA-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-56451e5801dso683815a12.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 02:52:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709203921; x=1709808721;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o0/b36wufjiFpSkm6wzI1r8NiwQdjDt3vKAFhFqGRJ4=;
 b=DcZOuN3UEGeJRVvIqVVIgpBzNyEtxfL2TQpAUr33cFld2gJHxCuuhZNliXD4oPGQ4G
 UFF2THti+IyYREF3tVk2QiER6eTouqDP4/NihscG1YzuaF2HgBEnD4oAYBsElBxwP3Qk
 AS+LgEJdZNXuo+G8Wq9JHf6fFsk35/Vus8Pzx2OurUEmUa7GOEA0ofeVTO09R1oLCKjM
 BcxBJIZ6lP03PH9bNNMmgYS/tvDzV8wYcZN4IZbHq636CYYbS+GNltrG2E73qreaBlpo
 NEINhKp8ZOPk9uZEZNKRsODKkHLejR+yFF/Vs4/trRcOUs9W0m9s4D8xJuh31URDIr3B
 aNig==
X-Gm-Message-State: AOJu0YxfTQRWkcd2DjL7JhGLLJ7qOm9DdNpbgfzJb0K/v86C74kGI0k7
 pqTM0eNz++2gA+WEWG46DIWi3kRIw5zvlnvDrTH4AimGH0LAaQvPC+Z/7S15oXPk69YxKFW6m4X
 NlDaMlW+a9wzvqqASfqto/vFBmEzf43Cki9VCiM8kb7EZdS5eBrYYx12QMIiTEp23FmklyKtb2j
 D2ksusJbmqRr/8SQ9SGNCVoWZlXlI=
X-Received: by 2002:aa7:c504:0:b0:565:ffa5:becd with SMTP id
 o4-20020aa7c504000000b00565ffa5becdmr1183912edq.37.1709203920929; 
 Thu, 29 Feb 2024 02:52:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbBxTQMPCMH8DtPtKg7B70vWXXqThMrmawrQdv5750lFOoUvhpIzuHfIEs6/BNl6WmH8pF+GQTcbb66a85aAw=
X-Received: by 2002:aa7:c504:0:b0:565:ffa5:becd with SMTP id
 o4-20020aa7c504000000b00565ffa5becdmr1183906edq.37.1709203920701; Thu, 29 Feb
 2024 02:52:00 -0800 (PST)
MIME-Version: 1.0
References: <20240229104339.42574-1-thuth@redhat.com>
In-Reply-To: <20240229104339.42574-1-thuth@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Thu, 29 Feb 2024 14:51:49 +0400
Message-ID: <CAMxuvaz97MFUOPVo_8YdT9RSgM94E7xWzVAT0sxwx09o4QGwTQ@mail.gmail.com>
Subject: Re: [PATCH] chardev/char-socket: Fix TLS io channels sending too much
 data to the backend
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Antoine Damhet <antoine.damhet@shadow.tech>, 
 Charles Frey <charles.frey@shadow.tech>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

On Thu, Feb 29, 2024 at 2:43=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> Commit ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
> changed the behavior of the TLS io channels to schedule a second reading
> attempt if there is still incoming data pending. This caused a regression
> with backends like the sclpconsole that check in their read function that
> the sender does not try to write more bytes to it than the device can
> currently handle.
>
> The problem can be reproduced like this:
>
>  1) In one terminal, do this:
>
>   mkdir qemu-pki
>   cd qemu-pki
>   openssl genrsa 2048 > ca-key.pem
>   openssl req -new -x509 -nodes -days 365000 -key ca-key.pem -out ca-cert=
.pem
>   # enter some dummy value for the cert
>   openssl genrsa 2048 > server-key.pem
>   openssl req -new -x509 -nodes -days 365000 -key server-key.pem \
>     -out server-cert.pem
>   # enter some other dummy values for the cert
>
>   gnutls-serv --echo --x509cafile ca-cert.pem --x509keyfile server-key.pe=
m \
>               --x509certfile server-cert.pem -p 8338
>
>  2) In another terminal, do this:
>
>   wget https://download.fedoraproject.org/pub/fedora-secondary/releases/3=
9/Cloud/s390x/images/Fedora-Cloud-Base-39-1.5.s390x.qcow2
>
>   qemu-system-s390x -nographic -nodefaults \
>     -hda Fedora-Cloud-Base-39-1.5.s390x.qcow2 \
>     -object tls-creds-x509,id=3Dtls0,endpoint=3Dclient,verify-peer=3Dfals=
e,dir=3D$PWD/qemu-pki \
>     -chardev socket,id=3Dtls_chardev,host=3Dlocalhost,port=3D8338,tls-cre=
ds=3Dtls0 \
>     -device sclpconsole,chardev=3Dtls_chardev,id=3Dtls_serial
>
> QEMU then aborts after a second or two with:
>
>   qemu-system-s390x: ../hw/char/sclpconsole.c:73: chr_read: Assertion
>    `size <=3D SIZE_BUFFER_VT220 - scon->iov_data_len' failed.
>  Aborted (core dumped)
>
> It looks like the second read does not trigger the chr_can_read() functio=
n
> to be called before the second read, which should normally always be done
> before sending bytes to a character device to see how much it can handle,
> so the s->max_size in tcp_chr_read() still contains the old value from th=
e
> previous read. Let's make sure that we use the up-to-date value by callin=
g
> tcp_chr_read_poll() again here.
>
> Fixes: ffda5db65a ("io/channel-tls: fix handling of bigger read buffers")
> Buglink: https://issues.redhat.com/browse/RHEL-24614
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  Sorry if you've got this mail twice - I forgot to CC: qemu-devel when
>  I sent it out the first time ... *facepalm*
>
>  chardev/char-socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 67e3334423..8a0406cc1e 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -496,9 +496,9 @@ static gboolean tcp_chr_read(QIOChannel *chan, GIOCon=
dition cond, void *opaque)
>          s->max_size <=3D 0) {
>          return TRUE;
>      }
> -    len =3D sizeof(buf);
> -    if (len > s->max_size) {
> -        len =3D s->max_size;
> +    len =3D tcp_chr_read_poll(opaque);
> +    if (len > sizeof(buf)) {
> +        len =3D sizeof(buf);
>      }
>      size =3D tcp_chr_recv(chr, (void *)buf, len);
>      if (size =3D=3D 0 || (size =3D=3D -1 && errno !=3D EAGAIN)) {
> --
> 2.44.0
>


