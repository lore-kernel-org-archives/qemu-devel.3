Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67FA5C25B75
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 05:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6kdP-000887-G3; Tue, 14 May 2024 01:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kdI-00084H-NT; Tue, 14 May 2024 01:23:24 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1s6kdD-0000LG-66; Tue, 14 May 2024 01:23:23 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4df7cb5894fso1511721e0c.1; 
 Mon, 13 May 2024 22:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715664196; x=1716268996; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pytnmWuo8tjsD0T3qfHSk0y766500IORgcnsDvGZT30=;
 b=bLzbeobJS4XpITyFoMNX84mePyCuWBJ+Tx0WpWm7Qm+5IhhAI/LQV/ZyO0S91dsQl9
 rRRST/DSzcPTZ+SAdXy8WgLRPXQjrzwwCsthpQTmavCiETyNTg/ypS7HaISqIFTY/WJh
 jBHfnymCpYKSaCicllbuXPZ9dRAgjZK69NO5xHb/3RpLn8cdpHAZrP4f7yJvOl/znWwP
 UBIfxqrTeJPNpnjwdwH9Yf03UoS5D4EIQIQyhQqjEPi5HBjOIdZYxqU7XpaK79XLrtho
 B8BPQxLdjDQaHVeGV6qCMjWcaWESGAt2KJwftdAA6pyucx3JsXi0OUFwceGzdrilik3J
 LhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715664196; x=1716268996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pytnmWuo8tjsD0T3qfHSk0y766500IORgcnsDvGZT30=;
 b=CpIZh/rII9Af/hbGffamXQZHMFZAcOErF5hSdRanlokS3PQ944TKRLJjI3nZs3yESN
 tw+W/0+vt8jhoZrcetHrApTGcpLHrHyHLzUMPzwrRq0DacgsFPt5Yp4a3+hDe60vVLvB
 NOU4ldXLA+ptOrIw1xBbTW0oXvSZv36Hbpa8s7Jgwt7k6rxIkzzUSp7EmDZePeoCOCQn
 4TBEVfAGfw6Kni+3jptRSF2snSl0258i1JbB7npZd+L68RgOrAFhNK6SYRPluZhNo/71
 sgxP2BAGsDUwUU9lvUZP95TOq6VJMj5jaJBX5fAf6AESDeE97dXKT0DIxNSP9lxE061M
 eK0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgYMlkx8SBYtGv6IhbX05nToJT+EUXsEW2/Ff3ORdLuzC7PB/UWpyiy2DR2InXKswcomKIkCP+hvcibYjcHZzQgeJrWcA=
X-Gm-Message-State: AOJu0YzSxj7Kc48s7I1PkFTnyYUEa5L6zENdxIXKB6YwanOB24HqH4EP
 m1GOx6XDZlTiJlsJliV2LBjZGw63dzATGtUY9YmwiWq1OLHpWQiql8nWvB9hDBYA9zKG/TrUxMU
 BFumuxfp12j9X9Ma1CpfzUuAEjjV1pIxAmvk=
X-Google-Smtp-Source: AGHT+IF9L+IGzchxm10YKSnI7sF8yEwsj0owZNXWHBB7FSY9kALE5birjwS1T2dUN+bf7lHPy2FD/Wer02hUVBmAD5I=
X-Received: by 2002:a05:6122:3c4f:b0:4d8:5e2f:c235 with SMTP id
 71dfb90a1353d-4df88131d48mr9011494e0c.0.1715664195719; Mon, 13 May 2024
 22:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240322092600.1198921-1-max.chou@sifive.com>
In-Reply-To: <20240322092600.1198921-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 14 May 2024 15:22:49 +1000
Message-ID: <CAKmqyKPZPHC4qRaUfs4Wipzre4QHKKox51qf9Qru-Wp+eLs6wQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Fix fp16 checking in vector fp widen/narrow
 instructions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Fri, Mar 22, 2024 at 7:33=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> When SEW is 16, we need to check whether the Zvfhmin is enabled for the
> single width operator for vector floating point widen/narrow
> instructions.
>
> The commits in this patchset fix the single width operator checking and
> remove the redudant SEW checking for vector floating point widen/narrow
> instructions.
>
> v2:
>   Group patchset and rebase to the riscv-to-apply.next branch(commit 385e=
575)
>
>
> Thanks to those who have already reviewed:
>
>     Daniel Henrique Barboza dbarboza@ventanamicro.com
>         [PATCH] target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v =
and vfncvt.f.f.w instructions
>         [PATCH] target/riscv: rvv: Check single width operator for vector=
 fp widen instructions
>         [PATCH] target/riscv: rvv: Check single width operator for vfncvt=
.rod.f.f.w
>         [PATCH] target/riscv: rvv: Remove redudant SEW checking for vecto=
r fp narrow/widen instructions
>
>
> Max Chou (4):
>   target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and
>     vfncvt.f.f.w instructions
>   target/riscv: rvv: Check single width operator for vector fp widen
>     instructions
>   target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
>   target/riscv: rvv: Remove redudant SEW checking for vector fp
>     narrow/widen instructions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++---------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> --
> 2.34.1
>
>

