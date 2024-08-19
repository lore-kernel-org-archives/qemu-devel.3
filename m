Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2270C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 03:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sftG8-0006Ra-52; Sun, 18 Aug 2024 23:40:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftG5-0006Ni-UP; Sun, 18 Aug 2024 23:40:41 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sftG4-0007sP-9m; Sun, 18 Aug 2024 23:40:41 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4f6ac477ff4so2138274e0c.3; 
 Sun, 18 Aug 2024 20:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724038839; x=1724643639; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3TlPcQdkiCmf4tAUK54ZEyuVmy0HJKl6dEVRxeqvUtw=;
 b=JVnl0KQe76qXhmtqDIxaoIMPHT0DYy39lz2prQHWiD3fR7XDqXDz6TYdTMB8D7Cwmx
 Fsgt+UPPBFO2EdFTpJp8R5j4jkBy+yO4pkgcg5NESoor/heruept0PURTWf/BLvAdrXu
 GQloqWfJX1SCHRZ88dKgKAdiUNl7Dr1KlvoKO5iPYjdiwKMWhUxQ59FWXo7fHsQCvXl5
 yYAs5ozlgnA/U4b45WUkJpkKhyWHLcqYiBs0FOLyMSkxJMNS/z0bciqv2ScOxkbkWqr3
 AIOd0UqnZiOk3C/RSiMuSwItjg9k0yecUsCpzPEeGixk7RPy0dqMNcbjMjUtZGBzfbRC
 PlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724038839; x=1724643639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3TlPcQdkiCmf4tAUK54ZEyuVmy0HJKl6dEVRxeqvUtw=;
 b=SGMOEWph8Btv0hUcjuIAgRL2+MRkBv4UiUexIzB36RNqvXXqgbGeREBK/C+uyZHEmM
 /Tqk1oSaug9nkV5bxMA81PF/oH8aKZM3r7/Br5OXgkwISEq7DygfeyZxqb4YD4+L7xF5
 nogY83WYPtNyIWbaN4M3OPiRLoQgqmC3R+su97pVGJaeTK6G7Kfwcra18VfkhV6e/N/W
 ZicroIJSkYBW/1jQ01jU40vmIzbqKW4KHVK5ct+LSz2qboYCFNY2lJVhCrErOI2GZgUA
 HS18e6zuU8wj9odRyzvAjMpMhTrFsCCItgZSEGPsC0vAr9yJEAwSx5pN2nM/9UcgKsii
 Ks+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Q7xICIm14s+j+ZziMqFjz17KOlYB4FQnCE7vbvo5lFUCj/9EQDMHLx7VAG5qecmEVjEhUa4/5h0lo2EgFBQoyXpCC6g=
X-Gm-Message-State: AOJu0Yxgsba6rwC4Evc/Qok7lwVqYgOnrN3H6D5WDPF9CiB0UFatbiKv
 I2RoqS1sWt06cdcd2C1gGi8rw5UE8scJg1mly6n8odKonyb2rBJ+YKqKh5QbZDsQWMEBl3YUEU7
 fB5VTUnCKYfVP2oxuKOtUC8xB4gU=
X-Google-Smtp-Source: AGHT+IFkJi6ZRYPT4/IrGRD0mk/x7i0EhB9jLyrPxyDecJ/LezuTN6MtQwXnjhVNoBYJprnmoYW4dGDTja5aAHrfvus=
X-Received: by 2002:a05:6122:3b1c:b0:4eb:5d5d:6add with SMTP id
 71dfb90a1353d-4fc6ca110e3mr10882398e0c.13.1724038838675; Sun, 18 Aug 2024
 20:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240809081227.1588508-1-tommy.wu@sifive.com>
 <20240809081227.1588508-2-tommy.wu@sifive.com>
In-Reply-To: <20240809081227.1588508-2-tommy.wu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 Aug 2024 13:40:12 +1000
Message-ID: <CAKmqyKPDLABisVSmWza6OciSYSoeqyYN5hKLNBjAoarY=T52HQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] target/riscv: Add `ext_smrnmi` in the
 RISCVCPUConfig.
To: Tommy Wu <tommy.wu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, frank.chang@sifive.com, 
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com, 
 liweiwei@iscas.ac.cn, dbarboza@ventanamicro.com
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

On Fri, Aug 9, 2024 at 6:12=E2=80=AFPM Tommy Wu <tommy.wu@sifive.com> wrote=
:
>
> The boolean variable `ext_smrnmi` is used to determine whether the
> Smrnmi extension exists.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Signed-off-by: Tommy Wu <tommy.wu@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_cfg.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 8b272fb826..ae2a945b5f 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -125,6 +125,7 @@ struct RISCVCPUConfig {
>      bool ext_ssaia;
>      bool ext_sscofpmf;
>      bool ext_smepmp;
> +    bool ext_smrnmi;
>      bool rvv_ta_all_1s;
>      bool rvv_ma_all_1s;
>
> --
> 2.39.3
>

