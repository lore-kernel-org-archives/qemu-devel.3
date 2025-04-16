Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD17C369B1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 05:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4viV-00021b-8J; Wed, 16 Apr 2025 01:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4viT-000219-Fs; Wed, 16 Apr 2025 01:53:45 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u4viS-0000eS-5r; Wed, 16 Apr 2025 01:53:45 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-524168b16d3so5506136e0c.0; 
 Tue, 15 Apr 2025 22:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744782822; x=1745387622; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=awZExRevPW6ijiKnOK5pcpL/ssFfPxmm3s1coNKpI88=;
 b=dJXF3k08lIDB519xwqx4tZtl76SXHHXnxYAEaTSGp8/+94Z8u1Cb81R3fV1Fzxoafa
 KsvEtpJM0AaIRlqAYdrMRI6szaaA6cC9LM2rbGAoYeCyQQAe5TO7WSWS/uMGakvg6YD1
 wfCIG+IKHUYwYnxhzqmFqYjmp0+a90S/Fok0CXkBqPh2l1bJDjwh3gyWGgR2OE2BgNFi
 5PB32hy1BoHVFH1NSP0vJJhNdeeZ8/AegpT5S4xgnlG7dD6AgMp2yBqhlZ7UHBJvEjyp
 9X20UEnmUK+ZfUMgnaEjedIGjUQh/U/O+0hRFSr87I1zgX9dqLUZNQrWhujt3vuty6Qk
 2PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744782822; x=1745387622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=awZExRevPW6ijiKnOK5pcpL/ssFfPxmm3s1coNKpI88=;
 b=g1PEVP5bmD5xgtYA51+m6JVYOQxDqTdlaOt0bbmUjl4iYI4OPsHRE093CsefaRIpL8
 SJZJ/xsMik4wTCNiLXRaycsfDGpQxTNk9VAJullDZ2GS/gucc445gPsvGYI4wXMaAij2
 HvrrZdc8r4ArzTcno9JUiBGU+UYnq+oB87Jk/t3CyKuc9r+/Y3NFIMOU5qIMORrLXyr0
 i1oomwdGeN/mX/uFVfBHQtYZI4pG+MVyUxrOAmIVx03MfxDkczfjg6eMIiHXgmjRVqiI
 5Ogih2xtmPMlRuTtOiRK1jCZYR0n9t1b3I7NCnh4/mHzpYKxN0QJ6fni0YXnu8eDvX11
 tftA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOB0LdiBsqegItQ6UsDvD9DbH8D+LxcMWu6H4QkJep2Blc02/IXHuznhWZI5UBIcSZb1iVrCJ8MajMfp8=@nongnu.org
X-Gm-Message-State: AOJu0YxqDGRU4FPlMO0/yTRB/sDOYVHpREGk1Q0JqlAO6zxqFXCLrE7Q
 4m+/3RHJzQ09dc+iHWrSfmydIZi6mNACQlnl0LNImhIAs5nMG3ok2aXjw+CIyow+NA8V3bCYEt4
 mtxsN+85dWl0knvrOod/hYl+l3EQ=
X-Gm-Gg: ASbGncvp019ZPzDwLyLbMlFVuBZtWzO4n8uBfgD+FXNWRYYYkvxOHK0JEvuJrcOhuTO
 tiaiPdBAUH13fnAc3E7Ewd4/jSIxd1u8saRnEhQBrva9YN5dp0v0Isj8Lj9Orn5YIOT0pqIDxIq
 YOKKOh3xWq1LF4qcLOxPhOQ2P6hSJ1WMJjHjHh0WDZ9dWcMMbsI/1N
X-Google-Smtp-Source: AGHT+IGfJD90KBsfZeTntiZF3Uzg1AVVz93SMx+NLemnY79UPIixv/IAuTlkCsWhaa+ZkcorNiROzuZN2Ov3/3ip9Bs=
X-Received: by 2002:a05:6122:218f:b0:518:91b3:5e37 with SMTP id
 71dfb90a1353d-5290dfe1bb1mr233452e0c.5.1744782822458; Tue, 15 Apr 2025
 22:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250415080254.3667878-1-ziqiaokong@gmail.com>
In-Reply-To: <20250415080254.3667878-1-ziqiaokong@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Apr 2025 15:53:16 +1000
X-Gm-Features: ATxdqUEjSVpkEiHm98uXd7atWS2djH4ruTefhs2bY5ggxYKs59CwFmwrjBQ80r8
Message-ID: <CAKmqyKNy4E_PRYcaXnJ7ca3AyZyHzt0Rquw4b0E3Qa_w9E7qZQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/1] Fix endless translation loop of riscv
To: Ziqiao Kong <ziqiaokong@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair.francis@wdc.com, 
 richard.henderson@linaro.org, philmd@linaro.org, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Tue, Apr 15, 2025 at 6:05=E2=80=AFPM Ziqiao Kong <ziqiaokong@gmail.com> =
wrote:
>
> This version fixes the return value `old_pte` not correctly handled in
> my previous patch.
>
> This patch refers to common usages of qatomic_cmpxchg like those in
> target/i386/tcg/system/excp_helper.c and target/arm/ptw.c. I also add
> a brief explanation of the correctness in the commit message.
>
> Thanks Philippe Mathieu-Daud=C3=A9 for offering previous review for my
> previous patch!
>
> Ziqiao Kong (1):
>   target/riscv: fix endless translation loop on big endian systems

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu_helper.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> --
> 2.34.1
>
>

