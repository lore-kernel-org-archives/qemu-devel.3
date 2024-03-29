Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497B4CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 21:43:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqK0I-0007Qf-U5; Fri, 29 Mar 2024 17:43:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqK06-0007Mq-Px; Fri, 29 Mar 2024 17:43:04 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqK05-00025V-69; Fri, 29 Mar 2024 17:43:02 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0d82d441bso21775285ad.3; 
 Fri, 29 Mar 2024 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711748579; x=1712353379; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pArEAfcBoWRoLTw+9rpQkn+sA7AYtKP30pTkmab58vU=;
 b=PKfqINoKt1W6SFL62/PzjoHfbHPFQvpbsfTxlWVhhcGIoqyfhTfZOvlCT8Y4O2bBqQ
 1xsMHfQjM7R8bPh6JZ6i0YI8bcojuWsd2MuESie/GjCLqfMAtbQlhl/yOc7Wkh18L1FL
 /qRnS/bUi/DmMNXi1c45YbQPExZCyJZ0P8vbDw6gmrCGnyxGg512Rc13mxqD4xfHsfT+
 lspCv+Y0mv5F8blYnl+dF1tNqeb5xciVEhzP16cSa5P3vzIW8CL7icLSnCnZ+CCLum4r
 6zTe+6ZN0rS69+vMdBELnPHLbRYrideHRsYaTRSerAP3AtoZjla4v5VIldfMDGOY31tT
 C0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711748579; x=1712353379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pArEAfcBoWRoLTw+9rpQkn+sA7AYtKP30pTkmab58vU=;
 b=nxPKuJWSu0cEywF+uaxR/o6NmAVSHVsZJqzGj7YFeAjdA89kzE+w+bMtsVK3CPzA6S
 jd4Duo6w75FTkn6U7Gr+vixwBrTlxHtGi6dXO6l4nSkCzgP7ncjLEuA/d6HpAwViM7Rj
 RU2K6pPkAhgCPhnsto3DrAO0TmrayMFIQ1W81rX5tQJbsWquWcoJ81Xp0EvedhCu7PQY
 awUwRO+o5PydWHrfFT1q5vfLoTwAcvpgiIUDHSUCDlUONAiAe9Huck/CTBukCXBQe+zF
 4zCJ3RMYRlDHH97WlrvnIiFPnRWAsA8I/Nu2qebJfU3r2UwE3q+DwAiH4XEr50ardwpt
 Ky4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXysJ8oPoFAxAqt9gPazXXFYB3aQi8KiJO7NBx7o2CodohmwfXBYlsQsCswcuslTTx745gaOuG9iArb6zgqW/QlzpsnS5QA
X-Gm-Message-State: AOJu0Yy+dJzcEPDVvc03nXgwLpNteqseYlWvw2o5ZR/+99/p59n3h8xa
 YxPt9hEBjTHRx3eWlQt82I+Yz0rC9FZlBIMTFokrNQDLFkcJSZnHpcofJfQiAuiqS8s8x5KecuS
 zPPr4H17mDrJuynPzLf9dXOqgd8k=
X-Google-Smtp-Source: AGHT+IEbDyjwes8qcx+v+mou5qJZ1yJFj9Z6vgQMu66nUO76TGhDerbg0BU4qtIh9sJd+ThZGGO4z4/7rATIrhV2IBE=
X-Received: by 2002:a17:902:e5c1:b0:1e0:c37d:cfcb with SMTP id
 u1-20020a170902e5c100b001e0c37dcfcbmr4616939plf.49.1711748579027; Fri, 29 Mar
 2024 14:42:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240329063148.129343-1-jcmvbkbc@gmail.com>
 <dc81005e-f216-4a39-9900-8598b61d48f3@linaro.org>
In-Reply-To: <dc81005e-f216-4a39-9900-8598b61d48f3@linaro.org>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 29 Mar 2024 14:42:47 -0700
Message-ID: <CAMo8Bf+CYB3Nt+p3DJsa+_+=WL_Ym0W1UDz-rp6RsvMuO1p2-Q@mail.gmail.com>
Subject: Re: [PATCH] linux-user/syscall: xtensa: fix target_msqid_ds and
 ipc_perm conversion
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, Mar 29, 2024 at 5:48=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi Max,
>
> On 29/3/24 07:31, Max Filippov wrote:
> > - target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wi=
de
> >    on xtensa and thus need to use tswap32
> > - target_msqid_ds::msg_*time field pairs are reversed on big-endian
> >    xtensa
>
> Please split in 2 distinct patches.

Ok.

> >   struct target_msqid_ds
> >   {
> >       struct target_ipc_perm msg_perm;
> > +#if defined(TARGET_XTENSA) && TARGET_BIG_ENDIAN
>
> Why restrict to only Xtensa here?

I have detected and tested it on xtensa.
I see other architectures (mips, parisc, ppc, sparc) that may need
that, but AFAICS it's not that it's applicable for all big endians.

> > +    abi_ulong __unused1;
> > +    abi_ulong msg_stime;
> > +    abi_ulong __unused2;
> > +    abi_ulong msg_rtime;
> > +    abi_ulong __unused3;
> > +    abi_ulong msg_ctime;
> > +#else

--=20
Thanks.
-- Max

