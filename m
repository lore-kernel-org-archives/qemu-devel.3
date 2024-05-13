Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8048FC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 18:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6a20-0000Jv-Bd; Mon, 13 May 2024 14:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s6a1x-0000Je-Vf
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:04:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <icegambit91@gmail.com>)
 id 1s6a1w-0004EP-8t
 for qemu-devel@nongnu.org; Mon, 13 May 2024 14:04:09 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-6f4603237e0so3216179b3a.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715623446; x=1716228246; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejsZGMwZ+0lfG7HPyu8xjpUh5a5Te0fdK8srj8OEzVI=;
 b=F3AA2KKNujAUMaMxY5pRGNDEpyTtZp97CDC4xflns59JZYx7qeiZSrd5DObK1sthj4
 Iv/3R1a9927/a04qGYtA4ayeqHlZMYbtLk5Y+aXzYajTmA+HQjD0mbe9ADv9eFdKCcIK
 gim0LWvwOPiO3fpWlSBWtwPM18x60yEAharptnfo8KoDV8xEBFQ9jOimlXYEgTzgwUiG
 A5Qq8hRHRKIkcfZHvgX4pMAZvnEOKqBotoS2rfIwyjjOEVlQuOwhe0PGPqSUW+IPmMhA
 9QkP1XO8q33jUr/5Yxk8wPgBSDGjZa24Wgt2AuV6pWE1k3EoF3BYDdQ6rM893XUHiiU2
 KjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715623446; x=1716228246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ejsZGMwZ+0lfG7HPyu8xjpUh5a5Te0fdK8srj8OEzVI=;
 b=hPnTD/mnc9s1yaQV834bzGW0cgZI6qdDapsID+TZOPqye3kJrB4Ku3G37JclozL75W
 /5AGetOAXq10v4g89wfX5Q+7lStNrSdDZNFCY0siDdXHjjlKCIka7MocHfHfvs2VxZjn
 ODGK9yYmzE0s2PfeXJeSOO7T4glxY1tdQ9AONOebbHJPyZPx1WhT20FB9l0vtvBHwV48
 1hoVDZ7ePCTI0Z3byx3Rr0I1un6ouTH0HnReUomZ29A4RR5KfFHvy+MiCdTHrLlMW9p8
 hkeIVn/CL0BCYEE5UdV9kG+yB2GLoKtCF9UbdmuUVv9IAjfwlIzgToNEYUPFyNGdI3x5
 jUYg==
X-Gm-Message-State: AOJu0YwM6xiHmSKkydj9nm68c43OSdR+teSwZ5rRpl5rh13DFw7S8fIQ
 +F9bpj2RUHfCtSSPvx+g/8gfMt0pDGylG+kkm9lF+xV3DL6iStBN
X-Google-Smtp-Source: AGHT+IH8QcI0ZYuQXynHaAPoZ/e7URcE6wd3JOZgRC9WTNInl/eWodUz7txqdk6ymlxhL24/VKBYNg==
X-Received: by 2002:a05:6a21:9988:b0:1af:8df6:bdbb with SMTP id
 adf61e73a8af0-1afd142f058mr21152202637.11.1715623446502; 
 Mon, 13 May 2024 11:04:06 -0700 (PDT)
Received: from valdaarhun.localnet ([223.233.86.42])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-63411346d46sm6973339a12.79.2024.05.13.11.04.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 May 2024 11:04:06 -0700 (PDT)
From: Sahil <icegambit91@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: qemu-level <qemu-devel@nongnu.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: Intention to work on GSoC project
Date: Mon, 13 May 2024 23:34:02 +0530
Message-ID: <3823673.kQq0lBPeGt@valdaarhun>
In-Reply-To: <CAJaqyWfbHgVA7f81C6phouSUEb7bVwXFRDWTHeie7Vax13zWZw@mail.gmail.com>
References: <13625712.uLZWGnKmhe@valdaarhun> <2282965.iZASKD2KPV@valdaarhun>
 <CAJaqyWfbHgVA7f81C6phouSUEb7bVwXFRDWTHeie7Vax13zWZw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=icegambit91@gmail.com; helo=mail-pf1-x430.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi,

On Monday, May 13, 2024 7:53:40=E2=80=AFPM GMT+5:30 Eugenio Perez Martin wr=
ote:
> [...]
> > I have started working on implementing packed virtqueue support in
> > vhost-shadow-virtqueue.c. The changes I have made so far are very
> > minimal. I have one confusion as well.
> >=20
> > In "vhost_svq_add()" [1], a structure of type "VhostShadowVirtqueue"
> > is being used. My initial idea was to create a whole new structure (eg:
> > VhostShadowVirtqueuePacked). But I realized that "VhostShadowVirtqueue"
> > is being used in a lot of other places such as in "struct vhost_vdpa" [=
2]
> > (in "vhost-vdpa.h"). So maybe this isn't a good idea.
> >=20
> > The problem is that "VhostShadowVirtqueue" has a member of type "struct
> > vring" [3] which represents a split virtqueue [4]. My idea now is to
> > instead wrap this member in a union so that the struct would look
> > something like this.
> >=20
> > struct VhostShadowVirtqueue {
> >         union {
> >                 struct vring vring;
> >                 struct packed_vring vring;
> >         }
> >         ...
> > }
> >=20
> > I am not entirely sure if this is a good idea. It is similar to what's
> > been done in linux's "drivers/virtio/virtio_ring.c" ("struct
> > vring_virtqueue" [5]).
> >=20
> > I thought I would ask this first before continuing further.
>=20
> That's right, this second option makes perfect sense.
>=20
> VhostShadowVirtqueue should abstract both split and packed. You'll see
> that some members are reused, while others are only used in one
> version so they are placed after a union. They should follow the same
> pattern, although it is not a problem if we need to divert a little
> bit from the kernel's code.
>=20

Understood, thank you for the reply.

Thanks,
Sahil



