Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1932FC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 00:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwPL-0003IJ-41; Tue, 28 Jan 2025 19:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwPI-0003Ht-U5; Tue, 28 Jan 2025 19:58:16 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwPH-00045i-EA; Tue, 28 Jan 2025 19:58:16 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51882748165so1966542e0c.3; 
 Tue, 28 Jan 2025 16:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738112293; x=1738717093; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2lBN+EfG4mThOzYZTIUK+GbZIFahDDZUx2NiKI/JLPY=;
 b=V68Ws5+wU4dmhysNO8yvBtcVuuEY2WCt1H0HFHYby2FMTCUlPcTUyVDVGS7ww5H0/b
 thi5NHLSrISpORzOKQpixc0mFO6+SRGTSDlOs7ZkiU4HC8u5s/ZQa3b5t2DHC/gzKhOA
 t7TA29NZRvIo9nfCp8JbjCgIGuj4xUThJuO/o6hjuMpVhjRc4Kgqnym72zREceMEG/5S
 6ppVkTArvieCCiSgn8oACR341QsKQ+YXopsYiyVuhR84RCYW52h2Y8nH9Az4MMUQC/0l
 0K7G+hug6Evc6urQt4RjMpogTgxgMXE76zyIVK6+OsCNct/WJT7GVbNluPypXTicsuJj
 2cnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738112293; x=1738717093;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2lBN+EfG4mThOzYZTIUK+GbZIFahDDZUx2NiKI/JLPY=;
 b=KxohrWQxwGdqQdm/nWCxGrtPE/NVs7WzPFdm/myvJ8Yxu24JpSearj5CaIuxLtzP9v
 lzdEBQI1O+4G6MTGjEeNO81yMz4ltxEertd/BXcRdyhYjbUdPWK+UtmWVSkQL0lPFxmj
 R6UE2ctB748wYMuR0hYqQ1nd8NF79aeG4hOGcKcZ2egXxDeA8kVHAcBzYz69HkXr0/pg
 11ijmD19JZ75PGDpB5HpBB+Zel7hx1AqgP0/00w2FGkvdq3Qhd5YCyhcjIBUEPSOD8Y3
 wqOTJVn8Cno38me93+/D+Sb5+9b8BQu7TjaXEEj3yOyXEovNmV4pKrFSsw1/uvqSG1vE
 BDzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWv1jQA4B1O7IUEwHLQGGh7qkm2WC0iszqYnqUHaAE1248fcW1NcsU31D2T0p0GuirM4zhcNF8V7+X0@nongnu.org
X-Gm-Message-State: AOJu0Yxn12/gIYws0qOo2l21ZoEkkqficeYLGW/M889cTjbY3c8nP136
 6jop7S8P7KTVdUWQUo921fJN4vAQiU0LYKGVzc/xvOPAc6i4cxC5mSwmn/fch9OI0e1xt3aecE0
 q88zqnnIUxvy2HvcBnek4Uqb+UUY=
X-Gm-Gg: ASbGncvvMd3VM4YDbKDb7B1TcfFBiF+1ddOHwTubZTQZ4H319wRsy9C9DrTA5ehaqL3
 ivqhA8B7U0nkq+BWKjCdrMMEfiwbk1KT1jkgh4SupJL38v/xhCorpIDRx7Tn+tIXyDUA7GAIceN
 2M2EnuUwIbINXyy5wtVFwbh3gxqg==
X-Google-Smtp-Source: AGHT+IEBZLAXX++1P+Mk4zJeoAxEfmCZn4zN+u8YNxRWHnx7qis4PnJAz3vmCLI4B5URmpuzK8IjMD5Xhl1TdUzflsk=
X-Received: by 2002:a05:6122:3184:b0:518:97c2:f21a with SMTP id
 71dfb90a1353d-51e9e3ee74amr1741821e0c.6.1738112292899; Tue, 28 Jan 2025
 16:58:12 -0800 (PST)
MIME-Version: 1.0
References: <20250121184847.2109128-1-dbarboza@ventanamicro.com>
 <20250121184847.2109128-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250121184847.2109128-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 10:57:46 +1000
X-Gm-Features: AWEUYZloVsaDSvXTVnSxqJmGSn8fWM3xj7g4ORRCA07L4nNRoMmaCUpvAyoCWPc
Message-ID: <CAKmqyKOodFAC+JVWN-CmZu-xvvTwrbBae=Z0fbCSc_XSv6eHEA@mail.gmail.com>
Subject: Re: [PATCH 3/5] target/riscv/csr.c: fix deadcode in rmw_xiregi()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, peter.maydell@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Wed, Jan 22, 2025 at 4:49=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Coverity found a DEADCODE issue in rmw_xiregi() claiming that we can't
> reach 'RISCV_EXCP_VIRT_INSTRUCTION_FAULT' at the 'done' label:
>
>  > 2652     done:
>  >>>>      CID 1590357:  Control flow issues  (DEADCODE)
>  >>>>      Execution cannot reach the expression "RISCV_EXCP_VIRT_INSTRUC=
TION_FAULT"
>      inside this statement: "return (env->virt_enabled &...".
>  > 2653         return (env->virt_enabled && virt) ?
>  > 2654                 RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_IL=
LEGAL_INST;
>
> This happens because 'virt' is being set to 'false' and it will remain
> as 'false' in any code path where 'done' will be called. The label can
> be safely reduced to:
>
> done:
>      return RISCV_EXCP_ILLEGAL_INST;
>
> And that will leave us with the following usage of a 'goto' skipping a
> single 'return' to do another single 'return':
>
>      } else {
>         goto done;
>      }
>
>      return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
>
> done:
>      return RISCV_EXCP_ILLEGAL_INST;
>
> Which we will eliminate it and just do 'return RISCV_EXCP_ILLEGAL_INST'
> instead.
>
> Resolves: Coverity CID 1590357
> Fixes: 5e33a20827 ("target/riscv: Support generic CSR indirect access")
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 0e83c3b045..75f21ccabb 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2621,7 +2621,6 @@ static int rmw_xireg_csrind(CPURISCVState *env, int=
 csrno,
>  static int rmw_xiregi(CPURISCVState *env, int csrno, target_ulong *val,
>                        target_ulong new_val, target_ulong wr_mask)
>  {
> -    bool virt =3D false;
>      int ret =3D -EINVAL;
>      target_ulong isel;
>
> @@ -2642,16 +2641,11 @@ static int rmw_xiregi(CPURISCVState *env, int csr=
no, target_ulong *val,
>      } else if (CSR_VSIREG <=3D csrno && csrno <=3D CSR_VSIREG6 &&
>                 csrno !=3D CSR_VSIREG4 - 1) {
>          isel =3D env->vsiselect;
> -        virt =3D true;
>      } else {
> -        goto done;
> +        return RISCV_EXCP_ILLEGAL_INST;
>      }
>
>      return rmw_xireg_csrind(env, csrno, isel, val, new_val, wr_mask);
> -
> -done:
> -    return (env->virt_enabled && virt) ?
> -            RISCV_EXCP_VIRT_INSTRUCTION_FAULT : RISCV_EXCP_ILLEGAL_INST;
>  }
>
>  static RISCVException rmw_xireg(CPURISCVState *env, int csrno,
> --
> 2.47.1
>
>

