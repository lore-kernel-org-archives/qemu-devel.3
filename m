Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F78C47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:26:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXGT-0002rd-Gi; Mon, 29 Jan 2024 14:25:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUXGR-0002qy-BL
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:25:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rUXGL-0003BL-IM
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:25:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706556343;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1a5lq3tGezRxBJk/+LVp2UFAB6jyIEd+6CeAHZ7V4hk=;
 b=c2b3FxTKMt7u0Os7rzLcTV4NGH+kZAITAph/3qkWQo9m5u/5ezHzS+mv89Gr7McbIgZjr7
 se3XIa6js9S20/HmXff62YoTX1FQWL9u6X9MKEwdcwcelFJiQTXCKhYgDMk/aMVzqOi1Xp
 0EJB5qndze1QIm4BltTxDlbBNDdcM4I=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-9MmrefunNZWNMbDCYgjBpg-1; Mon, 29 Jan 2024 14:25:42 -0500
X-MC-Unique: 9MmrefunNZWNMbDCYgjBpg-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-46b4fe9f352so206072137.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:25:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706556341; x=1707161141;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1a5lq3tGezRxBJk/+LVp2UFAB6jyIEd+6CeAHZ7V4hk=;
 b=E6ecJm0+sZGzCthuTc7JYq0Zjp6UfACDRfTLYRbapmiudtco5oxSOn4cVCduxCLtLC
 Mt9vxqVCQjkU64ToIHTJMhUIwGAwLqhGMIPvLDLqVcS5Cf/d0ivYtweKEZ/s+gIxu0bI
 3+lHM5WH/XUJHOZEy4FTCZpNfqe2/9qAAcqbwBBQLSeWvEJZ7kAmuWEgJAvvNprac9ET
 gHU10qXgbzwSON0eZZPvQmBMyFBrv9hoeytSy9oMxKV1SQ7ioATS7JNaFMdi2aOG4QwY
 BUFXCxtVAdRCpUhB4yOKFdpjoOog7zlUTm3jxhIqEoaLTlBh83fAITrokLrz+b7VmsCn
 kV4w==
X-Gm-Message-State: AOJu0Yx7w9hccu55sOjqP5dMga4WtPu+CFgbqP7/bUF8j/nkDva/MmVD
 DhyRT10eIs1nFsuPUhBJu27UNJPGffTEDlHtLAjuIkuSYZhOcidVr3CWjGTMTH0ye9P9MTe21kB
 SLWr6RulZyiEyywRQLuP/e3k9sTg36N6t5bWie4IJgwFj+LOCF93iuRue7w+V7Uyj2WlVqpkbP2
 fwRNUG9n477p0xI66lqzKASTedvnA=
X-Received: by 2002:a05:6102:d8f:b0:46b:5e9d:9a9f with SMTP id
 d15-20020a0561020d8f00b0046b5e9d9a9fmr1764887vst.10.1706556341520; 
 Mon, 29 Jan 2024 11:25:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvPdGGuT874QLT7+ArfLxsB3CXun/zgAKBd7efUmi4Sz4+zcEw95/qD9gvuUgnn6D6JO/WIHFaJzLNdn+Fp2U=
X-Received: by 2002:a05:6102:d8f:b0:46b:5e9d:9a9f with SMTP id
 d15-20020a0561020d8f00b0046b5e9d9a9fmr1764876vst.10.1706556341269; Mon, 29
 Jan 2024 11:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20240125072214.318382-1-aharivel@redhat.com>
 <20240125072214.318382-2-aharivel@redhat.com>
 <ZbKOZpi0v3sdKV8q@redhat.com>
In-Reply-To: <ZbKOZpi0v3sdKV8q@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 29 Jan 2024 20:25:29 +0100
Message-ID: <CABgObfYbGHS_2drz31kGd_KbQKNwaFVSL4TxoE=AJj-W6jqAAg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] qio: add support for SO_PEERCRED for socket channel
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Anthony Harivel <aharivel@redhat.com>, mtosatti@redhat.com,
 qemu-devel@nongnu.org, vchundur@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.29,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Jan 25, 2024 at 5:38=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
> > +static void
> > +qio_channel_socket_get_peerpid(QIOChannel *ioc,
> > +                               unsigned int *pid,
> > +                               Error **errp)
> > +{
> > +#ifdef CONFIG_LINUX
> > +    QIOChannelSocket *sioc =3D QIO_CHANNEL_SOCKET(ioc);
> > +    Error *err =3D NULL;
> > +    socklen_t len =3D sizeof(struct ucred);
> > +
> > +    struct ucred cred;
> > +    if (getsockopt(sioc->fd,
> > +               SOL_SOCKET, SO_PEERCRED,
> > +               &cred, &len) =3D=3D -1) {
> > +        error_setg_errno(&err, errno, "Unable to get peer credentials"=
);
> > +        error_propagate(errp, err);
> > +    }
> > +    *pid =3D (unsigned int)cred.pid;
> > +#else
> > +    *pid =3D 0;
>
> Defaulting 'pid' to 0 is potentially unsafe, because to a caller it
> now appears that the remote party is 'root' and thus implied to be
> a privileged account.

This is a pid, so 0 cannot be confused; however, I agree that
returning an error is better.

Paolo


