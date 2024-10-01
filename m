Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 313FECEACE5
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:13:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfU7-0005ZC-9U; Tue, 01 Oct 2024 12:12:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svfTe-0005Wo-Pe; Tue, 01 Oct 2024 12:11:56 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svfTc-0003Ab-78; Tue, 01 Oct 2024 12:11:54 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6cb37b34a87so40816006d6.0; 
 Tue, 01 Oct 2024 09:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727799110; x=1728403910; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4W/uO5gFzop3Vn7VW7r+255Jx/9QDITdeNJGg8Y6eKA=;
 b=J+HB8aCM2RqnW2vbJjroVgDlsKda2ttI8zKeng+5++G8Zf0wNxWAMyzIsKesk7DyIr
 ErbrMGhEsf1NTQfruhZcNNkbLDxvG6GwowvHDWMVoPP6u0pqHiH4US2WM2KX0lLpAeAv
 QUgiF86sNC0j68+qtXRlP37ILY5VkvCdVDUYGT+9BJh4iRCJxAzOnVL4XGEAGx7sdsFJ
 3eyNodPZ8dCNqLCUwtR6WtrGye/IYLhzLaoZjaUB/QCoEDTAYVgQ/RRe/97o7uTzMPuA
 9eH0dmUfuuXjo4u9ed2puGSQOJh8grJISsdVs9cIyFL3AvjopuzumYRaOZ/6WMJxiiFo
 Dftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727799110; x=1728403910;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4W/uO5gFzop3Vn7VW7r+255Jx/9QDITdeNJGg8Y6eKA=;
 b=l9O+WvwW83/XCbMI1PtogjJ3RjoZGQqY/qz56Fo/qCFKHrzDMCtoCRJIvjFNT4ydVR
 Lc3+l2l3rKkp7uWJ2m8lY+lRW0oHtRsa+XP145hJz6yFoibk3Q5UhJYjPDeyW8HqP3sr
 W3v/+IL6L0/Gh/5Poq8U0YguU4EvDBfNHl3dI3r0Hi0rv7SgdJQokL4NS+vY9DH3QQkR
 jt5t6f0AHJ79xq77WtChSBMRMCa6i60QlhI7nxHy65Br9hB0L2NewNompx70kcV9Z2An
 PzYlZAmacIHIdfMT2NpZ3uwMHdtHvoEAVmHNrpWuAB6OoIGdpUb04/8xp8N6zxKweKa8
 m73w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi7qDG2lpDB/A8/aNVvdAMX/M8nclY6FFYYhlUOWzDz2LG4jlpLA6IlffhI8Y16r+mqn0O3UPd5S2N@nongnu.org
X-Gm-Message-State: AOJu0YxCJGpSWpjQKhe6wBU2q/yTagBNofdBRd8HR6pmHPH/ojME99Ww
 vKiej17v0A7ITSctjSKA4+ocQdNqk3meAAALBTxXaXcjSL3IJA1zpKWv9eDDmgDNcIuJdskXNVa
 WjXZqOIwWjene+CnxTd20QQI73Tt6VA==
X-Google-Smtp-Source: AGHT+IEpEsyewQ0afuqTTdtpQz9qrkWBgU9QYZcef+7U5vYkLHyOBUdq1L0IQA3KyAkl6UTHatv5Ri7K77h9Nm9V9SY=
X-Received: by 2002:a05:6102:54a2:b0:49b:e7d7:3e1b with SMTP id
 ada2fe7eead31-4a2cefe047cmr13081735137.3.1727763160902; Mon, 30 Sep 2024
 23:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
In-Reply-To: <20240927083508.59483-1-yanmingzhu@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 1 Oct 2024 16:12:14 +1000
Message-ID: <CAKmqyKMobSzu-q8jdPhAU9PMG2GsGG1eOsemSS-Ny2vrX+wSbQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/riscv_htif: Fix htif_mm_write that causes
 infinite loop in ACT.
To: MingZhu Yan <trdthg47@gmail.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 MingZhu Yan <yanmingzhu@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Sep 27, 2024 at 11:26=E2=80=AFPM MingZhu Yan <trdthg47@gmail.com> w=
rote:
>
> Applications sometimes only write the lower 32-bit payload bytes, this is=
 used
> in ACT tests. As a workaround, this refers to the solution of sail-riscv.

I'm not sure what ACT is, but this feels like a guest bug, not a QEMU issue=
.

Alistair

> if the payload is written a few times with the same value, we process the=
 whole
> htif command anyway.
>
> Signed-off-by: MingZhu Yan <yanmingzhu@iscas.ac.cn>
> ---
>  hw/char/riscv_htif.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>
> diff --git a/hw/char/riscv_htif.c b/hw/char/riscv_htif.c
> index 9bef60def1..d74cce3bef 100644
> --- a/hw/char/riscv_htif.c
> +++ b/hw/char/riscv_htif.c
> @@ -65,16 +65,8 @@ void htif_symbol_callback(const char *st_name, int st_=
info, uint64_t st_value,
>  {
>      if (strcmp("fromhost", st_name) =3D=3D 0) {
>          fromhost_addr =3D st_value;
> -        if (st_size !=3D 8) {
> -            error_report("HTIF fromhost must be 8 bytes");
> -            exit(1);
> -        }
>      } else if (strcmp("tohost", st_name) =3D=3D 0) {
>          tohost_addr =3D st_value;
> -        if (st_size !=3D 8) {
> -            error_report("HTIF tohost must be 8 bytes");
> -            exit(1);
> -        }
>      } else if (strcmp("begin_signature", st_name) =3D=3D 0) {
>          begin_sig_addr =3D st_value;
>      } else if (strcmp("end_signature", st_name) =3D=3D 0) {
> @@ -290,18 +282,26 @@ static void htif_mm_write(void *opaque, hwaddr addr=
,
>                            uint64_t value, unsigned size)
>  {
>      HTIFState *s =3D opaque;
> -    if (addr =3D=3D TOHOST_OFFSET1) {
> -        if (s->tohost =3D=3D 0x0) {
> -            s->allow_tohost =3D 1;
> -            s->tohost =3D value & 0xFFFFFFFF;
> +    int htif_cmd_write =3D 0;
> +    if (size =3D=3D 8 && addr =3D=3D TOHOST_OFFSET1) {
> +        htif_cmd_write =3D 1;
> +        s->tohost =3D value;
> +        htif_handle_tohost_write(s, s->tohost);
> +    } else if (size =3D=3D 4 && addr =3D=3D TOHOST_OFFSET1) {
> +        if ((value) =3D=3D (s->tohost & 0xFFFF)) {
> +            s->allow_tohost =3D s->allow_tohost + 1;
>          } else {
>              s->allow_tohost =3D 0;
>          }
> -    } else if (addr =3D=3D TOHOST_OFFSET2) {
> -        if (s->allow_tohost) {
> -            s->tohost |=3D value << 32;
> -            htif_handle_tohost_write(s, s->tohost);
> +        s->tohost =3D deposit64(s->tohost, 0, 32, value);
> +    } else if (size =3D=3D 4 && addr =3D=3D TOHOST_OFFSET2) {
> +        if ((value & 0xFF) =3D=3D (s->tohost & 0xFF00)) {
> +            s->allow_tohost =3D s->allow_tohost + 1;
> +        } else {
> +            s->allow_tohost =3D 1;
>          }
> +        htif_cmd_write =3D 1;
> +        s->tohost =3D deposit64(s->tohost, 32, 32, value);
>      } else if (addr =3D=3D FROMHOST_OFFSET1) {
>          s->fromhost_inprogress =3D 1;
>          s->fromhost =3D value & 0xFFFFFFFF;
> @@ -312,6 +312,9 @@ static void htif_mm_write(void *opaque, hwaddr addr,
>          qemu_log("Invalid htif write: address %016" PRIx64 "\n",
>              (uint64_t)addr);
>      }
> +    if ((s->tohost =3D=3D 1 && htif_cmd_write) || s->allow_tohost > 2) {
> +        htif_handle_tohost_write(s, s->tohost);
> +    }
>  }
>
>  static const MemoryRegionOps htif_mm_ops =3D {
> --
> 2.34.1
>
>

