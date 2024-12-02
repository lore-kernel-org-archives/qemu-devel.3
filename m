Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0752D78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 14:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI7gE-0003fW-O8; Mon, 02 Dec 2024 09:45:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7gA-0003cu-5X
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:45:40 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dorjoychy111@gmail.com>)
 id 1tI7g8-0001c5-5D
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 09:45:37 -0500
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3ea55d16d73so1336576b6e.2
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733150734; x=1733755534; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vpollOTkFm6ZEJG0/nzYDTNjMeHTlJut25BlVcFxoC8=;
 b=Fe5pA4v2HEYuBE34m2rLmvnPBc7bSWcLKSCKXbcs3/EN+ZFkZLxbsqxR2PPCY4p7yE
 msMoQa7cOx9pl6DsviHRCXgeMlHYo9bK/4IDnCzfgFehivpJeeTzoCAQjicxiv/eRFM4
 Y0TeDfaaa5G7BDkrG4VoA1ROV51vCWwFF0NBT24ChXmaq2f5etUuttU+vr8RzGT/c8Xn
 MmaN6HoT+MvnmNGEq0IAWbdAx3mkc38sFeUczQvBQVPxwWJzNp9Agms/V/6ZwAuE86hl
 Xsp61uJC//7LByksc4vR1BThIPiyK+OOvKTkJqw9kuXaI9dgeE/rifiJQnJ0yQTmxnGL
 cGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733150734; x=1733755534;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vpollOTkFm6ZEJG0/nzYDTNjMeHTlJut25BlVcFxoC8=;
 b=gCZRUXoN/RUKFG7f8yvLonEhUYsbUi13CsW8nFlZERPFyCGf7oUKdOEKdUNAEiHdJr
 OA/UB1JFg1vPhOAYu7E3rva3fSbYOW//lau0j7KbZQly18wCM10n6EKnpAyiuWTzViP9
 FbE1tL1r1jJMmT1hZbbeO5ura9zgwu4KM6W+MKcMJgc5pEGuQKTfVOnUXr+/t5MCWPS7
 NuSGZlOB+cK49pAGmrqMsZv/ijqKVR5Sycsu285KlMZV8YkcFN/aL4tRbBjpjVYM1p+C
 Y6TFvVY3KBDVQfkDFFAaSOwUf1H6KYfw+mcjPve7oNjf7HpSP2zXzJSxvYPkJrepPtFe
 rk9g==
X-Gm-Message-State: AOJu0YzInnusmT2CqqWzgWJISUWST9K6X7HzFez7nCyhtqjUeVRhY2Bm
 /Fn09JdTITTqryhk+/fWF7yMRXFICuEz7Wq9bKiwfBXGO6Ty2aUtSnzeYtf51TtdqeuEar/cOjv
 W2P0gXlEJN9KvCQqipdC8p754vpKaQw==
X-Gm-Gg: ASbGnctp/gcJZ4oe6uYDb0hZ0MEOpK8nVu96opNqrTQzxABNSjnfzQSU9ivFt6BVntL
 zNlrmcY3Zcowf9r5JS1v3O58/ay+j/SvNzw==
X-Google-Smtp-Source: AGHT+IGoNpHuabOfShM7JdAHHPJM6fZC7elOjT934NH2kpOAGGIQ8JIebJDmLgz6QQDgxdXTxX6QNEQUl3kX/IPon3I=
X-Received: by 2002:a05:6359:459d:b0:1ca:9727:e00c with SMTP id
 e5c5f4694b2df-1cab1585c67mr874865855d.3.1733150734637; Mon, 02 Dec 2024
 06:45:34 -0800 (PST)
MIME-Version: 1.0
References: <20241109123039.24180-1-dorjoychy111@gmail.com>
 <CAFfO_h7Gmq9vQYOXB255c4jWK3KUEF0xro53i0qior5XQhqbNQ@mail.gmail.com>
 <CAFfO_h7rjZiaP6LsFHPeOAHR=qitmodGq4jNQW1+1-0HtqM4qQ@mail.gmail.com>
In-Reply-To: <CAFfO_h7rjZiaP6LsFHPeOAHR=qitmodGq4jNQW1+1-0HtqM4qQ@mail.gmail.com>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 2 Dec 2024 20:45:43 +0600
Message-ID: <CAFfO_h5hy9NV=twXyfvv8oTMjMGoSdMvsmRnMiUfiZpEvebn2A@mail.gmail.com>
Subject: Re: [PATCH] eif: Use stateful qcrypto apis
To: qemu-devel@nongnu.org, graf@amazon.com, berrange@redhat.com
Cc: pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=dorjoychy111@gmail.com; helo=mail-oi1-x22e.google.com
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

On Mon, Nov 25, 2024 at 9:01=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gmai=
l.com> wrote:
>
> On Mon, Nov 18, 2024 at 7:13=E2=80=AFPM Dorjoy Chowdhury <dorjoychy111@gm=
ail.com> wrote:
> >
> > Ping.
> >
>
> Ping...
> This hasn't been reviewed and I think this one simplifies the code in
> eif.c and is quite small.
>

Gentle ping.

Regards,
Dorjoy

