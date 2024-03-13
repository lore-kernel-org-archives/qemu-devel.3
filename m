Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4035FC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 07:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkIkk-0001fM-Sh; Wed, 13 Mar 2024 03:10:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkIkh-0001f3-Fk
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:10:15 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rkIkb-0004Qi-FP
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 03:10:14 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3c1f55ba3ecso3389344b6e.3
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 00:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710313807; x=1710918607; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdn44JYXk3eGxTrsImHQsvnR7Y61B+Gm56qbaEmQCn8=;
 b=XOwIzkE+PmczCC4WfnKt7l8QWcEXYz/VC/boWIyyqbDCa4L4GP++9gNa7K53/xl3rH
 VQKGwZ5yEXYcgt/6h+mCzNpoJp/GN/gq+qzAr64DFpo+TEnGSGL5ri1qKwrB2mV1G/jH
 KgvCkHTLiQ/tOYIpNIlRBXuAaBHYs5cmawPyjwMAxFFSQ+E/Wk5pMb4ldmjHSNnMnz8Z
 MrxRfYVM+39jilBBDHCUSaTOQQTAg6kaILwz/jKlqsPj4TV6DaQYh74VOhUTiA1H6Z0c
 JXECRcivSYwChBXjR6ftgA+BUEEgoAazw18KgUGp6roIjB2yjdxfI1tVT5JgxOqpUDfL
 52hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710313807; x=1710918607;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rdn44JYXk3eGxTrsImHQsvnR7Y61B+Gm56qbaEmQCn8=;
 b=bMaD5q6Kn1K6yTeRKUS8O9ynt6KOhPaNA+J1z++6C+85TdVYbT8DzlQRWD8tuopj8f
 +cTgNTYBDm0bgUOS9FJ1IkuMl5RSrgszh3Wp8SR8/J2ylieyOjET4TbmqyFO4lsY8JYL
 hUwjjw6vwP94hQgbe4qXBn+EMqXJ/gbJ2AcL18x7mpIhUNjTA3ybW8IXkP/ftsv1OuVf
 VVJpp02yeQriBCVasRpeuOJMsNXq1Yyy+OOwEDtb0sb/D5u0tPQU9OqC0Y4Lfzg8EPm8
 qpN4WKo86A54HtXt2egsLSvVlow5Z5bRdMl8QQUo9i8/1qETUmRr/C6dJppdxrG6W9Kb
 Xzcg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYleZrvUsWedPgn8UblAcAipeYmto298cJ9+8OS7vAIgCLrWTP0W/JyxBB0DtcKPiJmFdaf91XdgAVmcGLV9/K9P/mZkc=
X-Gm-Message-State: AOJu0Yy+2SOke9MyYYMKjqx2Ff3pNEVOu1rY+e9mjXUbO4/mbj+XhLMZ
 wGD813AoKxJmkMpKP3rmgiTN4P728Ki9qZvMn2bkNTGaCXR/uwGT
X-Google-Smtp-Source: AGHT+IHkmLXtjPYmilXeGfWvklF97n9eodjYtof8tZa9bWpt2DYtADQp///JvPblq+3aOT9EeXVd1w==
X-Received: by 2002:a05:6870:9a23:b0:221:6e57:ec3b with SMTP id
 fo35-20020a0568709a2300b002216e57ec3bmr13283663oab.54.1710313807552; 
 Wed, 13 Mar 2024 00:10:07 -0700 (PDT)
Received: from localhost ([1.146.20.17]) by smtp.gmail.com with ESMTPSA id
 e26-20020aa78c5a000000b006e4e616e520sm1496426pfd.72.2024.03.13.00.10.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 00:10:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Mar 2024 17:09:51 +1000
Message-Id: <CZSFN14FTTV7.301WQADD9I5AN@wheely>
Subject: Re: [PATCH v4 11/24] net: Use virtual time for net announce
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, <qemu-devel@nongnu.org>
Cc: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, "Richard
 Henderson" <richard.henderson@linaro.org>, =?utf-8?q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>, "John
 Snow" <jsnow@redhat.com>, "Cleber Rosa" <crosa@redhat.com>, "Wainer dos
 Santos Moschetta" <wainersm@redhat.com>, "Beraldo Leal" <bleal@redhat.com>,
 "Michael Tokarev" <mjt@tls.msk.ru>
X-Mailer: aerc 0.15.2
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-12-npiggin@gmail.com>
 <6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru>
 <CZRQ0IX3UQRZ.KXS6OX3HY1RD@wheely>
 <13c1e838-0c0a-42e9-baa4-2418569311d5@ispras.ru>
In-Reply-To: <13c1e838-0c0a-42e9-baa4-2418569311d5@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue Mar 12, 2024 at 9:12 PM AEST, Pavel Dovgalyuk wrote:
> On 12.03.2024 14:05, Nicholas Piggin wrote:
> > On Tue Mar 12, 2024 at 7:09 PM AEST, Pavel Dovgalyuk wrote:
> >> This won't work, as needed. Announce timer can't be enabled, because
> >> it is set in post_load function. Therefore announce callbacks break
> >> the replay, when virtio-net is used with snapshots.
> >=20
> > I see. Is that somehow marked as being incompatible with rr?
>
> Here's the prior discussion on it:=20
> https://lore.kernel.org/qemu-devel/8735ovx0zd.fsf@linaro.org/t/

Actually I don't know if it's so simple. If VIRTIO_NET_F_GUEST_ANNOUNCE
is clear then AFAIKS it sends a RARP packet instead. Also the timer can
be triggered for other reasons than migration. Not quite sure how that
all fits together.

I guess record/replay would just have to disable it entirely. We could
support it if we had a ANNOUNCE event I guess.

Thanks,
Nick

