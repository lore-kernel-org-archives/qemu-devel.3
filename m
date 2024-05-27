Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1744C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSvK-0003ly-Hr; Mon, 27 May 2024 01:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSvD-0003g3-Np; Mon, 27 May 2024 01:29:23 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSvA-0002v6-AC; Mon, 27 May 2024 01:29:23 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48a39a060b6so591973137.2; 
 Sun, 26 May 2024 22:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716787751; x=1717392551; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpULe0MJtwfC0TlDtxvhf7lxmLBBdL/i9r7gE8O1YBo=;
 b=C08ye0eMlLvKcfvd+05rSgXAE4fjTKnjtfpio/C9XQtI6Us6DLJ6LZjHm17A7ZpPcJ
 x4iIV6DwFaLgMH+7QTaIUvzSp9B2KN7MNTuOiWrVk1xWkugEjFpwK9MD1FU85fE30N3C
 Iszdt7nprhS2ps3L4xawqr3bPEiUHUxEO7KL7maHph+ivXa7AI2Ke0TBRizD9QM5k0XG
 m/plUVTafZ8IQ/CHTLPhUO5vpJetHE3AVqXoXKa9Z3d3KiEXPdZZRdf6yFzcYUcebXwt
 iVh9hVxRVAMtRewVBfX4jW1I4I95upyzAM4wuRgz4RSh6b9H6qZE1VWCf+QFHp8BcRUj
 r4lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716787751; x=1717392551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpULe0MJtwfC0TlDtxvhf7lxmLBBdL/i9r7gE8O1YBo=;
 b=rpsajOClCrdxVjnLdN8oMT7Hnktf4JR3M5F1QyE2OpPmOUM88noc0BU1dB5QdowQiv
 ev/IMAjEqBC0Y992WLQIBnx1LUTTswQ9GVarq3wXgLnifYFFZzQcq2v+/CJVeVESOCmD
 PH6bXc+TWCTpsy/hjvDpiOcBKKFX37gHujtjhxwluwKcU2OXXvXRzEO1hgOT6sUh4YaT
 /x8B32PatiZ/DY939QElQvH0+voxJfKla+hcXy+TqeTMhk+l2dn+OENBraEijucGV6rq
 kZ6U+RA3K9KxQFReNvbzx4cuhj0Oht6pb0C2qXoEqOdsd0ZTTpVecQyhCF1597Y9G+0P
 5aIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5jjPWpu67ccQ+3Q7wZWgkJg8r0GNOia8yi6KxL5W1eCQ4MhLMVIjCJNWeYiAlO0DounVP3Lxcg0yBku9RH1ZIBFXhj1Y=
X-Gm-Message-State: AOJu0YxtCt1Aa0ifYzIIQogWIu31M4QRYFnv+7sJ0KDqP87L4l9jzODh
 MQ/N+X9996kKeQwcZu1cDyy3n58LVOmyOrW5rhilJgKB3HRwzUs4aZd2jAx8prsbIKjNv+gOsWE
 M1U5NUkOIQfHAXskJhtmlezGyXA3gww==
X-Google-Smtp-Source: AGHT+IGE749TOQ1bUr2rtm04rapNzahAMpoIwTL0sHkgWGi1NQWgGPs1v/X/h5S/cYaooArE+QYXYzWU3zQtQCfCpfE=
X-Received: by 2002:a67:fd58:0:b0:48a:3332:595c with SMTP id
 ada2fe7eead31-48a384fa257mr8888962137.5.1716787750701; Sun, 26 May 2024
 22:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240514051615.330979-1-alistair.francis@wdc.com>
In-Reply-To: <20240514051615.330979-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:28:44 +1000
Message-ID: <CAKmqyKMe0ayzJ8RELTXs72zSUudPjmxgNBAA9i43wuhkedq+aw@mail.gmail.com>
Subject: Re: [PATCH] dias/riscv: Decode all of the pmpcfg and pmpaddr CSRs
To: qemu-devel@nongnu.org, bin.meng@windriver.com, qemu-riscv@nongnu.org, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, liwei1518@gmail.com, 
 palmer@dabbelt.com
Cc: Alistair Francis <Alistair.Francis@wdc.com>, eric_devolder@yahoo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Tue, May 14, 2024 at 3:16=E2=80=AFPM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> Previously we only listed a single pmpcfg CSR and the first 16 pmpaddr
> CSRs. This patch fixes this to list all 16 pmpcfg and all 64 pmpaddr
> CSRs are part of the dissassembly.
>
> Reported-by: Eric DeVolder <eric_devolder@yahoo.com>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  disas/riscv.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 64 insertions(+), 1 deletion(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index e236c8b5b7..297cfa2f63 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -2190,7 +2190,22 @@ static const char *csr_name(int csrno)
>      case 0x0383: return "mibound";
>      case 0x0384: return "mdbase";
>      case 0x0385: return "mdbound";
> -    case 0x03a0: return "pmpcfg3";
> +    case 0x03a0: return "pmpcfg0";
> +    case 0x03a1: return "pmpcfg1";
> +    case 0x03a2: return "pmpcfg2";
> +    case 0x03a3: return "pmpcfg3";
> +    case 0x03a4: return "pmpcfg4";
> +    case 0x03a5: return "pmpcfg5";
> +    case 0x03a6: return "pmpcfg6";
> +    case 0x03a7: return "pmpcfg7";
> +    case 0x03a8: return "pmpcfg8";
> +    case 0x03a9: return "pmpcfg9";
> +    case 0x03aa: return "pmpcfg10";
> +    case 0x03ab: return "pmpcfg11";
> +    case 0x03ac: return "pmpcfg12";
> +    case 0x03ad: return "pmpcfg13";
> +    case 0x03ae: return "pmpcfg14";
> +    case 0x03af: return "pmpcfg15";
>      case 0x03b0: return "pmpaddr0";
>      case 0x03b1: return "pmpaddr1";
>      case 0x03b2: return "pmpaddr2";
> @@ -2207,6 +2222,54 @@ static const char *csr_name(int csrno)
>      case 0x03bd: return "pmpaddr13";
>      case 0x03be: return "pmpaddr14";
>      case 0x03bf: return "pmpaddr15";
> +    case 0x03c0: return "pmpaddr16";
> +    case 0x03c1: return "pmpaddr17";
> +    case 0x03c2: return "pmpaddr18";
> +    case 0x03c3: return "pmpaddr19";
> +    case 0x03c4: return "pmpaddr20";
> +    case 0x03c5: return "pmpaddr21";
> +    case 0x03c6: return "pmpaddr22";
> +    case 0x03c7: return "pmpaddr23";
> +    case 0x03c8: return "pmpaddr24";
> +    case 0x03c9: return "pmpaddr25";
> +    case 0x03ca: return "pmpaddr26";
> +    case 0x03cb: return "pmpaddr27";
> +    case 0x03cc: return "pmpaddr28";
> +    case 0x03cd: return "pmpaddr29";
> +    case 0x03ce: return "pmpaddr30";
> +    case 0x03cf: return "pmpaddr31";
> +    case 0x03d0: return "pmpaddr32";
> +    case 0x03d1: return "pmpaddr33";
> +    case 0x03d2: return "pmpaddr34";
> +    case 0x03d3: return "pmpaddr35";
> +    case 0x03d4: return "pmpaddr36";
> +    case 0x03d5: return "pmpaddr37";
> +    case 0x03d6: return "pmpaddr38";
> +    case 0x03d7: return "pmpaddr39";
> +    case 0x03d8: return "pmpaddr40";
> +    case 0x03d9: return "pmpaddr41";
> +    case 0x03da: return "pmpaddr42";
> +    case 0x03db: return "pmpaddr43";
> +    case 0x03dc: return "pmpaddr44";
> +    case 0x03dd: return "pmpaddr45";
> +    case 0x03de: return "pmpaddr46";
> +    case 0x03df: return "pmpaddr47";
> +    case 0x03e0: return "pmpaddr48";
> +    case 0x03e1: return "pmpaddr49";
> +    case 0x03e2: return "pmpaddr50";
> +    case 0x03e3: return "pmpaddr51";
> +    case 0x03e4: return "pmpaddr52";
> +    case 0x03e5: return "pmpaddr53";
> +    case 0x03e6: return "pmpaddr54";
> +    case 0x03e7: return "pmpaddr55";
> +    case 0x03e8: return "pmpaddr56";
> +    case 0x03e9: return "pmpaddr57";
> +    case 0x03ea: return "pmpaddr58";
> +    case 0x03eb: return "pmpaddr59";
> +    case 0x03ec: return "pmpaddr60";
> +    case 0x03ed: return "pmpaddr61";
> +    case 0x03ee: return "pmpaddr62";
> +    case 0x03ef: return "pmpaddr63";
>      case 0x0780: return "mtohost";
>      case 0x0781: return "mfromhost";
>      case 0x0782: return "mreset";
> --
> 2.45.0
>

