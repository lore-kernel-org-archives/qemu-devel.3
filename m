Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E02DC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 10:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7u7X-0007Qn-Iw; Thu, 24 Apr 2025 06:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u7V-0007QJ-Dj; Thu, 24 Apr 2025 06:47:53 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u7u7P-0000YJ-4P; Thu, 24 Apr 2025 06:47:53 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-86d69774081so423026241.0; 
 Thu, 24 Apr 2025 03:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745491664; x=1746096464; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcdLTDZKdD21fz88Km10UC4/+wQCjjJ76rvL4NQUY98=;
 b=dadTPDRaab7WZl4772jfCL6lfv+o+9EkD3ipqKsb900930FdQ12DbMfDCBAMs/1VwU
 lZ+GXpSF5At/ZIe+wKAo+rXNQE9ZANtmTHzHHYbGtIUn06cuv7dbAUtrWbOywtuyA6qt
 EeFrcDjJxCziYwoyyON8deVfeHZJNUrIGWH1HvhLjlIMeHci1r0iPtbRuE4VZkEgEA/n
 uQ4wz4eMbZbJwx77QBXmaRgE2SqUpq7JQOVMtrKGgVFOv0Oa7p1FZrj1C5CNg7xRC01H
 Bl/gd6c20X6YPZ7ytsLT41q+7fIVnlBITd90r4IH69Ol/oh5Qg/geNjsq3oODLCB6Hlh
 qeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745491664; x=1746096464;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AcdLTDZKdD21fz88Km10UC4/+wQCjjJ76rvL4NQUY98=;
 b=Uo+Q2kLRPCgoVcD4X7TfXtlfiDSc3JO/v6YtY2aRyHcyRuPcb5sf2kCVVeFBjg2EDS
 D1iuO9l1pmkgjhEGVHPdPSacwbHFfnCxg7xJ454m30o3aUR8TxpeYMGTY2gA6HSe9pDr
 eSmcjMZyYJGrq28SHeNE/yK1IHrz2F1eg24ejtZmSVEtSJE5x0My0sVPUpQpB0xsB8QM
 KK+oiudmt9kp+RcH9Mv629rqMKonwHxeAiH9gkKeda8prHKOguR/euGQj5ZteDXhgYTq
 IwEPD1A72bA+6/tKxNTmJ0hBB4eKJ+NySjvBT9GuXtZ3Di/0W6D6Z8pr1ttoAZyTKZcf
 hjFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD2TOPF9/y+lGyAOXBEgFuLxVr36v/15vjjT8di5vN3Kpif2oBWCQPnVkelW5TW3zYxjknp0m16LCI@nongnu.org
X-Gm-Message-State: AOJu0YzhEV5obQDQhaYXZsfbIrK3VjQZyInOwtMjONMbQnG3dwoUd3GY
 y4XhmgBIDqUTqNgRIChc3qNiygERCGWKcvtqCB1f12L9Hw+fiJPZyW2uf0bMWXfBckbSIcU4ooP
 y3QDrBaziN888PlFYTHGwCmil3O0=
X-Gm-Gg: ASbGncsrHf13JE1v61O8mptCFsXcck6RV+i/eHY//FIQBX02pE5bS7lnsHqJ/kTBRs1
 Cu+1uo5G6XB6gfkfRWxS2JVXI+4Z1s/Ng1f3D/sB2Aq/jlRFZgKqQllz09A8EA4ghMRsC6qBPh7
 mxJN9qpWc6Xiw2JB2SJGgLFsuKh2uOx783MYSEehb1qA4G1/ymQEsc
X-Google-Smtp-Source: AGHT+IGalIyOdsHHTd1mamzQkl0iIv12aetniSOVUnpCVkCTQTnUCTD5RdxTgpiVdSslnqPm7RTiN0Wwx3j+apii50E=
X-Received: by 2002:a05:6102:f06:b0:4c8:55b8:6fad with SMTP id
 ada2fe7eead31-4d38eef41d9mr1420374137.17.1745491664006; Thu, 24 Apr 2025
 03:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250422024752.2060289-1-alistair.francis@wdc.com>
In-Reply-To: <20250422024752.2060289-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 20:47:18 +1000
X-Gm-Features: ATxdqUHaGKxq2l_wpOZ335bVIqAK5wt2dOYqbba8vqZP6HEWs6NnNpwjOUXsgTg
Message-ID: <CAKmqyKP0CJpum7ffKvoZnJeDUigzvi-FM0YTAj4o3hgnoB5_9g@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add common-user/host/riscv to RISC-V section
To: palmer@dabbelt.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, uwu@icenowy.me
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x932.google.com
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

On Tue, Apr 22, 2025 at 12:48=E2=80=AFPM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d54b5578f8..d1551d9cc6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -328,6 +328,7 @@ F: include/hw/char/riscv_htif.h
>  F: include/hw/riscv/
>  F: linux-user/host/riscv32/
>  F: linux-user/host/riscv64/
> +F: common-user/host/riscv*
>  F: tests/functional/test_riscv*
>  F: tests/tcg/riscv64/
>
> --
> 2.49.0
>

