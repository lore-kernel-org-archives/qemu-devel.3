Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C7EFD60D15
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 03:34:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDF0a-0006G4-2X; Mon, 18 Nov 2024 22:34:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDF0X-0006EW-G1; Mon, 18 Nov 2024 22:34:29 -0500
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tDF0V-0001if-Q4; Mon, 18 Nov 2024 22:34:29 -0500
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-50d2c02875cso209745e0c.2; 
 Mon, 18 Nov 2024 19:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731987266; x=1732592066; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S4UDJO+YDNUyxXhV5VgMzb9YFiXebfusYTBUFD7pjyY=;
 b=cdybYDCLwH6Fq289mgPk9pgP43EAPcFHbyoiNnllW5ej55RnpZ4osolg3DTC1IfQIB
 Jr0cTJwKQV4o11zbriBlSQvBd7ppPrmYcoGeZHIfEAFA1XejOU0x5yefFUsfVkn85hH0
 yXIl57WQuvOqVSxQhzn64oqs0FwyVPqkrqDzFYfJ8nE/WbFXyfDckeOc9qpyn88PKa5S
 21aZyauSrkwsNoL01x8XZ8IK9y/I4EmQ3v6sItQZFoGebPxuXyZDOYBllzXWz7akWJd4
 HnxJ/aBEcHOuO+FiPQWx5woEWevLYj+45/F9mrCbDlGMWFEdP+ST7XS6hENXKHFppqHQ
 TXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731987266; x=1732592066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S4UDJO+YDNUyxXhV5VgMzb9YFiXebfusYTBUFD7pjyY=;
 b=ivND+dfQuVmwJw+vuE92VD6uhuMcxkiqfWJav1670vZYs8nUtHiREgUSfadChkl89w
 s8gYfb8iCNvdRn+4tU7T+Rq9eG8m21+Qk/JT0pDuHkGRejnUQQh35g9mKav5AKl8VyCs
 6chEVLeBxBDNyQwuHZzV4wW6p7mgqS2qaS7rcI1CmAGdFuubXsQLaLlDoGQ0cQiRhERo
 twcL6a4u/EliEc2B4lMW2VdPPGmQCpclcPS3gyrILABdt5U/AjzqHUzHBf05NJRLHrjl
 YSxkOjLlm9SPfgGmHcCt2l63KmKQBqDe3XnyTGw8j3sIYzrSb0xh6wbwQyvNFzo/cfRR
 +Npw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtsvCn7X33mUeyHJLzqirNVUHDMLY3r9GD0RJHZY0mTRIW6IsVHEpHwfDqr555BGuCbUITXvaE8Lib@nongnu.org
X-Gm-Message-State: AOJu0Yyo45/YGusSm9CWu3YlMUgVPrSXcaauOXCw4kI5oIgGEWOGF7dD
 SXipjAwZG7TKDWpu5BepnFOLJ9+axQebt0OIssg0Vme8L+g+AI9NEU8Gdhm3NU0tOEs0SnDmcHT
 vbX60onafxFRnCkcJEwnOOhcvP0s=
X-Google-Smtp-Source: AGHT+IErleYHpHe3MDdUyDSKV9ZJJUBxVLn+H96hxf6HJBvZCWGo998w+jWo79c+OodO5ia4Vw91NzYFALQjDNgJOfE=
X-Received: by 2002:a05:6122:a06:b0:509:2c72:2427 with SMTP id
 71dfb90a1353d-51478679caamr13050691e0c.12.1731987264825; Mon, 18 Nov 2024
 19:34:24 -0800 (PST)
MIME-Version: 1.0
References: <20241112091423.2529583-1-fea.wang@sifive.com>
 <20241112091423.2529583-6-fea.wang@sifive.com>
In-Reply-To: <20241112091423.2529583-6-fea.wang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 Nov 2024 13:33:59 +1000
Message-ID: <CAKmqyKMc2rL24MfRQsU-ahQsLw=BQUQ83=+OZ8B-6YNPAA0A0A@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] target/riscv: Expose svukte ISA extension
To: "Fea.Wang" <fea.wang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
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

On Tue, Nov 12, 2024 at 7:14=E2=80=AFPM Fea.Wang <fea.wang@sifive.com> wrot=
e:
>
> Add "svukte" in the ISA string when svukte extension is enabled.
>
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---
>  target/riscv/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index f219f0c3b5..6d3e9d563d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -199,6 +199,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svinval, PRIV_VERSION_1_12_0, ext_svinval),
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
> +    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xtheadba, PRIV_VERSION_1_11_0, ext_xtheadba),
>      ISA_EXT_DATA_ENTRY(xtheadbb, PRIV_VERSION_1_11_0, ext_xtheadbb),
> @@ -1595,6 +1596,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[=
] =3D {
>
>  /* These are experimental so mark with 'x-' */
>  const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] =3D {
> +    MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),

There should be a check to make sure this isn't enabled for RV32

Alistair

