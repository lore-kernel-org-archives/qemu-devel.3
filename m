Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72EB4C5320E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNbV-0000AF-5S; Sun, 25 Aug 2024 20:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNbT-0008VR-MW; Sun, 25 Aug 2024 20:29:03 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNbS-0003Nx-3x; Sun, 25 Aug 2024 20:29:03 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a869332c2c2so550458166b.0; 
 Sun, 25 Aug 2024 17:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724632140; x=1725236940; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1MX4Lr0OEKs9MXTNGgEzVKP1paPH1geOSzlrntY7HGY=;
 b=PzGVoAyhG5upHq7jJy0WqUzsrLeDxFHcky6zjdK8uuwVBsW1KoEYMpSpeC9Xl0RHn6
 f2XsgjaYECw1eZQxzRmNYCLloIGsw5Q88LhEjJ9d5ziBt1X8K8FFlE8vEFr9QZLKzmtD
 +o6wkZR9aIVOK5w0Rv9vpeedZP17yjzvukCAx579lI85ZDsHZIlB8ZyRPQCK2f2dxZ5c
 6j1LDxKhNbzItG6OXO5RTtLixnTb3gmWw3j4F6D/7y2K7YgBMrwh69pGCs6t+hli5eXB
 xvUj1h0Tz6bM6eOyozknV/oD3Wu4avCQSr4MeydLG8jycB9rnEHqd1IgeWsilSeoLRQf
 E43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724632140; x=1725236940;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1MX4Lr0OEKs9MXTNGgEzVKP1paPH1geOSzlrntY7HGY=;
 b=F2sD7IzZaOwq2i9T3QpzW4tuokQMvt4I+l+3pTCN3ztynUbq3RHWNbtebXvFhX15jb
 4MtFT9Feg73EUIN2mJ/FuL98yQfu3Z3XEUsXllOIlCzAXVV1CSCN+C8BA4KfXtIMecCD
 duXEtXfTC26EqCMOlO0zSu6Mz1OnSKJeshLycV+16FODjuD5SBNU3fjgHJyWfhjF4eVx
 QK2Yv2tJFZ088pUYyCRONo4rVrR3/jqZq248T3KYFzDpvjgFcGd2AycHRVEhgb8af7LN
 GuBJOm8YCcNt45Lz1rqV8Qm3nOSUdosDzP+zDVocYQTgcx07pz5L/RyIWCC6J5x2p1dV
 19tQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtEZu5pimWBQ16IFfhdslDxHJNBxzb1H9hf+L6v2I+n05NHK2pZhGevDZDCDagF0043m0YBl0s7TmN@nongnu.org
X-Gm-Message-State: AOJu0Yz1hH9WVQjxh3vTLyNw73mcr4RFq+a13ZqMdy+vlwprwom8o/zm
 1MBOZK7YE8rzcKcjrvtNzlKJuJEAV8vfgSRV76FuawZqaVwxHFWnIuN/niVvSCdpaOPXcJT49bW
 IaL14BSei5gpOlfZGEDsoR8Dfq7c=
X-Google-Smtp-Source: AGHT+IFVHi+fISY8iDHwjIlfLz/nKiUCwegoZb7OXaEckTeRKX6/Wsk7TzkjSVPQpTEpkBKyJ6q629vDE6Dbdv7AN5w=
X-Received: by 2002:a17:907:2dac:b0:a7a:8dcd:ffb4 with SMTP id
 a640c23a62f3a-a868a69568cmr1164795166b.17.1724632139453; Sun, 25 Aug 2024
 17:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20240821075040.498945-2-ajones@ventanamicro.com>
In-Reply-To: <20240821075040.498945-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:28:32 +1000
Message-ID: <CAKmqyKNM7_ux4o+=yVkW9xzfzwZRbu_YYy9aO3bQD6ZMuOe0nQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/kvm: Fix the group bit setting of AIA
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, yongxuan.wang@sifive.com, 
 dbarboza@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x630.google.com
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

On Wed, Aug 21, 2024 at 5:51=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> Just as the hart bit setting of the AIA should be calculated as
> ceil(log2(max_hart_id + 1)) the group bit setting should be
> calculated as ceil(log2(max_group_id + 1)). The hart bits are
> implemented by passing max_hart_id to find_last_bit() and adding
> one to the result. Do the same for the group bit setting.
>
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index f6e3156b8d2f..341af901c5b0 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1695,6 +1695,7 @@ void kvm_riscv_aia_create(MachineState *machine, ui=
nt64_t group_shift,
>      uint64_t max_hart_per_socket =3D 0;
>      uint64_t socket, base_hart, hart_count, socket_imsic_base, imsic_add=
r;
>      uint64_t socket_bits, hart_bits, guest_bits;
> +    uint64_t max_group_id;
>
>      aia_fd =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_RISCV_AIA, fals=
e);
>
> @@ -1742,7 +1743,8 @@ void kvm_riscv_aia_create(MachineState *machine, ui=
nt64_t group_shift,
>
>
>      if (socket_count > 1) {
> -        socket_bits =3D find_last_bit(&socket_count, BITS_PER_LONG) + 1;
> +        max_group_id =3D socket_count - 1;
> +        socket_bits =3D find_last_bit(&max_group_id, BITS_PER_LONG) + 1;
>          ret =3D kvm_device_access(aia_fd, KVM_DEV_RISCV_AIA_GRP_CONFIG,
>                                  KVM_DEV_RISCV_AIA_CONFIG_GROUP_BITS,
>                                  &socket_bits, true, NULL);
> --
> 2.45.2
>
>

