Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BBE9E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 03:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIgRb-0008Dy-41; Tue, 03 Dec 2024 22:52:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgRW-0008Dl-3Q; Tue, 03 Dec 2024 22:52:50 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tIgRU-0006KT-HO; Tue, 03 Dec 2024 22:52:49 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-51529df6202so1452611e0c.3; 
 Tue, 03 Dec 2024 19:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733284367; x=1733889167; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5ZjIZc4aHu66f4IKfPpKvr2D+KMGOwk7hi7goJa+cI=;
 b=SlINofJxeqyPW0TGFKFr8saiT0SAWpcl46xOmPh+MuAsSNrALdECBY1L7rkizC4Eo/
 t4QjMZtTqPIO3yz6+IhoPRUzy6B7AmTiQxJdb+TCQPXhkQ7nqh+kU8B4nrj5SV3oupKn
 faUvl8jSn/po9o2VOsag5w2up+qX4Qclob7eT7OXcfMj+CVDqgti8VoVFbOwVYr2Vvbp
 8w+gtbyGJ3BX6lGfmbUc2GbwLJ1FNNn+12ePv5vb1IP92FU48zosPPOW0I3+T+YmQBEz
 cUsDJdHdLnyhcdXei9Geya4qOobESR3Wg1KvpaJRz3JOpSNwJA8RV/tpINLeaomGNAVb
 YFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733284367; x=1733889167;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5ZjIZc4aHu66f4IKfPpKvr2D+KMGOwk7hi7goJa+cI=;
 b=hqKg87pFv0AD+Urd6S5tAcmxOPIRfZcyHGevfmcg1CDE5To2yRPfULrAtb5mThZ/S+
 AhB/DYcTlqMSq7Rz9+UPKxXXQDuio29yw1MvXI8PeRUCBgE473gkN2vtVJOM0oZRvGB3
 ARwwQac5Off9EUsGASo3Op5cPyAB9WSGC039Fe+EKSAnntkSPFMx97xxshkkc7jVPWXm
 s9qoCylRy8C/rGMIVWcBpE8YxTf/GMOSFS0YrsTGmFAcJk0Dy+dzpC6gdLp6vCl9kqsF
 nWwGwM+eMo4kpdZsYAAtlqqccl5HhXoyihFXQY/YIUf0grrCtNojfjPHrf6N+8D26j/f
 WoyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJaZx3iBYkC/WkfRQ88JB1F5JP+4OV39N707A3ArH5pkgDuABspJ8xadfG7lbr2YZyrnN7ow1UqbGi@nongnu.org
X-Gm-Message-State: AOJu0YwzB7V4Y7bzS8BdF4dom9C/KiHiQdAMlHZ2rF895zSvsANa0U3T
 eEFe9SFqJ3sDrhXADLE/JvowHWHBi7wrsWmn01DqT+XFx5ydehFFeHAsTMZhzYFSk6YiEUrhw5p
 Caem+amPpgHts6r5gdQ3rWU2IP7U=
X-Gm-Gg: ASbGnctbwZILCoONTxYzd6TgU7nDwpM5/AT7yaw1f8wowMN7sLU2HDrK396MwMbD4uO
 +wxRc2AqAEJQvWC8YNxIgGWmPVUPDv8Bn
X-Google-Smtp-Source: AGHT+IFAPUg2wcQbRbpJ7C+bUvwhj/B+f5hObokC6UKWytm3igJDgzNN5ndylJto4QsItZDuPraphOyQgN/kLp8X2DQ=
X-Received: by 2002:a05:6122:1815:b0:50d:69a8:f5d6 with SMTP id
 71dfb90a1353d-515cf786776mr4588180e0c.8.1733284367095; Tue, 03 Dec 2024
 19:52:47 -0800 (PST)
MIME-Version: 1.0
References: <20241113171755.978109-1-dbarboza@ventanamicro.com>
 <20241113171755.978109-7-dbarboza@ventanamicro.com>
In-Reply-To: <20241113171755.978109-7-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 4 Dec 2024 12:52:21 +0900
Message-ID: <CAKmqyKNJk090=UeqrzLsgAoFawPP384hbKSijHb+cBsir5HS4A@mail.gmail.com>
Subject: Re: [PATCH for-10.0 6/9] target/riscv: add shvstvecd
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Nov 14, 2024 at 2:20=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> shvstvecd is defined in RVA22 as:
>
> "vstvec.MODE must be capable of holding the value 0 (Direct).
> When vstvec.MODE=3DDirect, vstvec.BASE must be capable of holding any
> valid four-byte-aligned address."
>
> This is always true for TCG so let's claim support for it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 7b54c50794..ae5676976b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -186,6 +186,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
>      ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
>      ISA_EXT_DATA_ENTRY(smepmp, PRIV_VERSION_1_12_0, ext_smepmp),
> --
> 2.47.0
>
>

