Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1908C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 06:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4afr-0008J2-Df; Wed, 08 May 2024 02:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s4afp-0008Ih-FP
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:21:05 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rkir@google.com>) id 1s4afn-00050q-Rb
 for qemu-devel@nongnu.org; Wed, 08 May 2024 02:21:05 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1eed90a926fso11535ad.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 23:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1715149261; x=1715754061; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DiGcICBTm+6CxJfmmLlVa8Yjz8KMoEMfYLkOT1sTTL0=;
 b=iZecP1lKSrqqV6i2M1GpsmWKBrfLHkxkZBL8+P0t7vKTaw+zsIRwd4XSE7+R3qHKcY
 LT7FTLuGISAx5uhE5VWRL0vmxNH8FRZ7b/6S707BRF04LAK31sn/bXGulUjm8uLC7DxI
 flnCQxf2c4tUTmc7jyxy7GtgetydTvXoxgqZZvlqynuilvHSg059MfD86Q2xhlUmIyEQ
 aqEX8JkCCLNcATgPshnbW96zUlj6M+Zbu72cIJ16IkBa4fFb+G1myGZ1wuMxn8mugu7b
 wICLNBxtSfcXygRvAfa3+MJuRCTjcx1iwXDfaP/YN1zxnsTMEM9oNpuIc+Z+RiV30YdB
 BSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715149261; x=1715754061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiGcICBTm+6CxJfmmLlVa8Yjz8KMoEMfYLkOT1sTTL0=;
 b=Qv79CAdfoTwahvQghcAAJ9YUZttiD7o72q91nbNVfDzc9iOhBdW8mTEbCOjC/Rf1Eg
 txtZi3Kr8GWW0cFQ5/sgoFAoQRVW5KW5biOmLfxsSQsrvBaFq00lLGI98SsbqwIF4eP0
 ykTxNNgoRsQ0NKJ6fjQV91vXnMNjC7VYkWI/e7oDh6d4VVv7WD94+NVUPX2+jO9RqppM
 1QIjVxtVWVKPTX/M0nLyx/cEfDB/bww0N7pQwOao8817UxwF2b5pSXRfOK4ohiGytilk
 LwYN+OiFpxccS4nQIcdJFYxHzRJUy8wvstGtgc9j9SEPlPxbx5QzeMvkqOuvnrB6MYVw
 jHzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxU8spocRjjQNjfs8kAw+pR3CV8T+08IppYlVPmGvFAeDSEXn3A3zk/+pTcug4QYOvGfAc45UeMuBHYQEfoSiHSrpkET4=
X-Gm-Message-State: AOJu0YwM/6XysdLO1EIxk0ntkc7YMMLcF9FTLbtBQjsmyJ3lM6ZW2oMG
 fNzLtRMiYfqgjmfIuFtVaVU4BojdoeVgGSqas8Ft2DkyiRwSs7msSEX5YayCnWgKrg4/SNWaLKa
 mdbhCytQFQ+OCXwjQ6VRipXU1Q8QGP5oM5A7l
X-Google-Smtp-Source: AGHT+IEdtQ0Kjr88rACZNhNtGB4a/IAZ6XnOWGvaj+4gZP4WE4fvvWvsDGTirQmtEsQjPaHDJwEkPN45blXK+RK6ZFk=
X-Received: by 2002:a17:902:d587:b0:1e8:88b2:17cd with SMTP id
 d9443c01a7336-1eeb58bfb7amr1777155ad.12.1715149261115; Tue, 07 May 2024
 23:21:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOGAQeqOVAHJ4VxQNKqO43hmLJdxpA6E_JEQrfL380SwT4Y73w@mail.gmail.com>
 <Zh0NiI9ZfS5uzs5Z@redhat.com>
 <CAOGAQerx0DmHvJNf05wuJFOtXVwDFTt7fy0-GmBZ7xKoLAHTKQ@mail.gmail.com>
 <ZiDpM7ZusU0SvH7K@redhat.com>
 <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
In-Reply-To: <nga2k5uuvpqm2sovguofglw6u3reiqqurbn7vbdexanzrhmw42@vuje72e57egu>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 7 May 2024 23:20:50 -0700
Message-ID: <CAOGAQeqU692hHf3dU7udz8hwzP6KuFTNWir0mLcV-URF-JkFnA@mail.gmail.com>
Subject: Re: Hermetic virtio-vsock in QEMU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org, 
 QEMU Developers <qemu-devel@nongnu.org>, JP Cottin <jpcottin@google.com>, 
 Erwin Jansen <jansene@google.com>, Mehdi Alizadeh <mett@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=rkir@google.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
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

Hi Stefano,

On Tue, May 7, 2024 at 1:10=E2=80=AFAM Stefano Garzarella <sgarzare@redhat.=
com> wrote:
> I have no experience with Windows, but what we need for vhost-user is:
>
> - AF_UNIX and be able to send file descriptors using ancillary data
>    (i.e. SCM_RIGHTS)

As far as I understand, Windows does NOT support SCM_RIGHTS over AF_UNIX.

Regards,
Roman.

