Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF5BC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYSJ-0004U8-EK; Thu, 15 Feb 2024 04:54:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYSH-0004Kt-8s; Thu, 15 Feb 2024 04:54:57 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYSF-0001Xi-Pl; Thu, 15 Feb 2024 04:54:57 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4c02dfa01a8so229831e0c.1; 
 Thu, 15 Feb 2024 01:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990894; x=1708595694; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hANP1h3NsmU5oQsNrWCHd+g4mBlIaSjguB+KPP+LNm4=;
 b=QMw63DACXfSH3aYnVaDS5sRGVaE2LzacYYNBg/UB/vuweiu7le2cxTOBxlyoYMWhPd
 qR5VNM58nvDGzCvum1Fd2kuZpWbHbEPunTO7YwUw659wWEoNfY9wYzgXpobeCFq4XaxY
 6ncQtH4U9qx8L6kCmLEWJ7usN/aeckPpYvKp4pWCpc//WsFRQLAoMGEp/M5pQleROBTV
 PDu+W0kSDpU0jWQ5ypshHNngp7Ra+huhJ5zK0s4oestsHU/hkBb6pPoGz7PFylBWEGQe
 69aAqxjQIHHA88rT9mDb5IzhjVAZyP21UutIrpmtFrke5YjhvDcC4viGciVet/Xd1BLI
 1S1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990894; x=1708595694;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hANP1h3NsmU5oQsNrWCHd+g4mBlIaSjguB+KPP+LNm4=;
 b=mwvMBthdCVu9uRFkUVLRRhKmnGwbLAu41sELtzK7pTxoinhl2wSKLXlA3lRQcyqEXD
 6GbOtp5Bj65RX12G4B1HVNKl4vgNejaI5/Wh33tjNEkYOUH7l3SVO7HVBnuV2bElKIx1
 v2u0Y8aiMjJQMsXXBXus3HulNTrltaSriadR9NL79PozP5h5v0hwYK3o5AtxZXNI3/QY
 EJcnFjIaSk7CdiDhMHcMF92HaS+Bn6PqZxOhNZN6vOU5hYI/GmcGelMBlWdyQiNIAmKi
 dSqhqQ9t99tS1GWnfk6PG5qWyGwI2Z8dtQS/3FqIseBU997+cFPsP1Q/XWy52Vt3vzLG
 2Kog==
X-Forwarded-Encrypted: i=1;
 AJvYcCV14SsYs/HZ8PerJYvcgko6QsLDrv5d1e5TJ40+M7NUn4fzSNIH+x8h2F4i78/6otMuBxq7T5K370BHYFupUOzX6GGib5o=
X-Gm-Message-State: AOJu0YxmMDrQ6ui1MEyjJB77ybXKstY+O4Ry8npGNCX32id9tZKssH7T
 CNpu6dVXQQsdSsjM3RwyFonai1eh0OwcE/ZCn1VS+ZfYNC7OiT2PQyPen9mqpO0zzPlShfKnRnh
 INtAt8SyI4gGjo0M+K02zaSt3m7oHAM/q
X-Google-Smtp-Source: AGHT+IElzanXDOV+aXd8b5iY3fAdX8k1XwFJ+JqzAij44RcqwKSkJe0pFsEvwVOhTz6NfZm2LJ1lKkF+ZCDY2MorNuQ=
X-Received: by 2002:a1f:6201:0:b0:4c0:d28:9557 with SMTP id
 w1-20020a1f6201000000b004c00d289557mr721932vkb.1.1707990894143; Thu, 15 Feb
 2024 01:54:54 -0800 (PST)
MIME-Version: 1.0
References: <20240207115926.887816-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240207115926.887816-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:54:28 +1000
Message-ID: <CAKmqyKOxUjc-C_hUptj2gy7XzgYWzy6OL5cE_JXCLVPh_26Rhw@mail.gmail.com>
Subject: Re: [PATCH 0/2] linux-user/riscv: Sync hwprobe keys with kernel
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, Feb 7, 2024 at 10:00=E2=80=AFPM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> This series syncs the hwprobe keys with those available in the upstream
> kernel repository with the exception of Ztso, which is not supported in
> QEMU as of now.
>
> The first patch is a resend (sent on Nov 27), as it should have been
> picked up on Dec 6, but seems to got lost.
>
> Christoph M=C3=BCllner (2):
>   linux-user/riscv: Add Zicboz extensions to hwprobe
>   linux-user/riscv: Sync hwprobe keys with Linux

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  linux-user/syscall.c | 99 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 93 insertions(+), 6 deletions(-)
>
> --
> 2.43.0
>
>

