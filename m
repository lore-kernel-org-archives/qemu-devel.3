Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A3DC54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 04:13:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnWGp-0003mU-0V; Fri, 22 Mar 2024 00:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWGn-0003mC-KV; Fri, 22 Mar 2024 00:12:41 -0400
Received: from mail-vs1-xe2a.google.com ([2607:f8b0:4864:20::e2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rnWGm-0005VA-3Y; Fri, 22 Mar 2024 00:12:41 -0400
Received: by mail-vs1-xe2a.google.com with SMTP id
 ada2fe7eead31-4768156d947so599805137.3; 
 Thu, 21 Mar 2024 21:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711080758; x=1711685558; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHi6njtOcybWfxmRHKBcreZQ01beP+UuUDxZdh3gCbs=;
 b=XKNC//1W2ri8JeBH7ac0koto+6luMb1YlxBvDtVqcWSB4c5IkoO0AjS+3okjxiBphZ
 0QXspHaSWbhFsoZfRkA3mA02deACn5IGt6TKAUQ7vZI1wRwmqJ5sqIK/IXB4Dz5LosU4
 lzJhqqOYlO9rKF/pkPrVFMx2Q2GBHYV81Dqop7am2ZBZ1V+bMuR3KNIpeFpAggbNJG+N
 U7OdGZVtrhzgcQWUNeTDAGdCwI1UPdImzkk3j1rdcXfJ3KYrV81LnaHzlYPpnIXBeNUl
 TSgTokbL6XRs3KHPr1BPjs8im2nR5O0Z5Lalwao6glxLYGn0+Kn+d5bZxeMTleEtDttR
 gBXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711080758; x=1711685558;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kHi6njtOcybWfxmRHKBcreZQ01beP+UuUDxZdh3gCbs=;
 b=nIYO+nHGQsPyEQpVz2bYqSv8gxmqBOFZ/NPHAbkClal45RKkawMWmXBcHd/Pe1xZ1E
 RiASUOzmdzZ7bRW1BsGLDsAQi7ecFKyJ8NVOcl3hbZi7CmGObhGEihzhnlwca5NTXZoj
 ixi2W0gebxR7aeI7DOhqHYxi+F2MGFIDQ6Oos/4+/sRMCpDmURqmV8Y5W7+yAMIn5gax
 W58z++4Q1Tq8lpXa/8/Edg+nbVHKQFBwFCnwj3lNfWqIN6C+HEAX0e4qhe9wQbgVmUcu
 NUa5QJv37uiSgZ4KJ0cWHUE8p6JeyeS5j3Cq2m0n26cVaDiq/nwt0ibCU9Dcm8M9pIsq
 g4vA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxVgQwLrA68MOzzBM+yvzqGDaPtKuaVqhK/GhNgZQ1hi5Bh4x1W54TGZ1i+9A8FWvH4Z44VL59JwxTWjQTK5TdpVgg3qQ=
X-Gm-Message-State: AOJu0YyFR2VQxSSERPY9v6Y7WUHcxzJbZJ2WjnwxpTfkYXDDwv0sZo4a
 uGv9fqacbDDT5YIfMW1Jc7vEDjD9Sb2HrVpU7VXGUF0dCTs+2aEC07gkf6YEsZQ3ztC+FzCqZmP
 JUiHD5ReDDMcSswj4q8cZqjf34w9vhMLaPVsBpg==
X-Google-Smtp-Source: AGHT+IE+Y4EfO5zvXLGm74M36Sq46WE/oVfsO79kmU8wyIUR3X1STPE9va1uNBKeQr8y7zSqsjAYGylBmnJ+XdvmgBY=
X-Received: by 2002:a67:fd73:0:b0:476:aecb:e09c with SMTP id
 h19-20020a67fd73000000b00476aecbe09cmr1331142vsa.9.1711080758355; Thu, 21 Mar
 2024 21:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240320072709.1043227-1-max.chou@sifive.com>
In-Reply-To: <20240320072709.1043227-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 22 Mar 2024 14:12:12 +1000
Message-ID: <CAKmqyKNN_BbxV-Qh=8gOCpb6z6RS2qmGajj--XU7XgnZ3ks10g@mail.gmail.com>
Subject: Re: [PATCH] Fix fp16 checking in vector fp widen/narrow instructions
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2a;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2a.google.com
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

On Wed, Mar 20, 2024 at 5:28=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
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
> Max Chou (4):
>   target/riscv: rvv: Fix Zvfhmin checking for vfwcvt.f.f.v and
>     vfncvt.f.f.w instructions
>   target/riscv: rvv: Check single width operator for vector fp widen
>     instructions
>   target/riscv: rvv: Check single width operator for vfncvt.rod.f.f.w
>   target/riscv: rvv: Remove redudant SEW checking for vector fp
>     narrow/widen instructions

I think something went wrong here. It looks like you meant to send
this as a series, but somehow that information was lost in the subject

Alistair

>
>  target/riscv/insn_trans/trans_rvv.c.inc | 42 ++++++++++++++++---------
>  1 file changed, 28 insertions(+), 14 deletions(-)
>
> --
> 2.31.1
>
>

