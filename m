Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF2EC3DA41
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQeQI-0005FW-IZ; Sun, 07 Jul 2024 22:48:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeQH-0005Dq-3f; Sun, 07 Jul 2024 22:48:13 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeQC-0007pP-7Q; Sun, 07 Jul 2024 22:48:12 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-81014dd6c5bso997658241.0; 
 Sun, 07 Jul 2024 19:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720406887; x=1721011687; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSUowzKEE8wApaAyeMmTmFpcStudDwz+I/owE3/asUs=;
 b=SXF1ytiZ4dLGlc73ysZEv/0InenUi9OgqPidQ7dqfjt3NCOZXdZLK6rB7REkqtLlra
 2c6v332qXPeDlGZPza+AqF++24YLBwjRkVDViTTnNTynHolcGkqOeUgKtshVebEWLh0Y
 UlMx/BKIrVpL4J90Z9PKZfE4oDLMoKQQCCh22fa031/lzBhHeIaYItdc/KgAHfATX4ia
 BY5SqZTvlI3yzUetDvQPM3NSaoGow5UlAOYnKOvvvNvSPZ+pjXEQWgH5fq8rdp6SvTMl
 y3n1D5CPaWfZOKTiy4GJDUzjrbtA0WTI2Xsx/xjzwEj5yRbIqJGeUzsFnFyZZfQq2yQv
 uk3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720406887; x=1721011687;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gSUowzKEE8wApaAyeMmTmFpcStudDwz+I/owE3/asUs=;
 b=BO4cSU8/b8gdvlyvPkndK12LZXPaC/ZrXwqRNOYeclijYLnpk0gHpX3cqykqTHTC8S
 vDwNewjWi8w3ck2z5bjK6xOnZlVH3LP9k1bAuLcqjSuTC1fUsWD7sBMxD306OL4urWTV
 8ShBoGnYU6yYef/TrBqKo4WnDc65snU8EM5Z2t52LwV16i4m25nTsINrhTzP0sAhyWZc
 5ik2293BhEK6G+eqLJNBrJjmfW3ZW2oW9drhB+I7zPtiU+oCkDALrVjBFH1VOwsduG7B
 Xh7I/NtGj5kvXb2AtAPUMkMU7xtS6cqtPvldtIdKNrF/TxVPy8ZY9zC2Ai9une+G5lPj
 sPdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5KFbN0CSFTqR+1RtLGM4vYQMtG3nycSuYS0tn2ysdf+Ks3N8HXt46vIXfYvnaKpGhxssFoKVtT7r8C3w+ma/ybo5WrsE=
X-Gm-Message-State: AOJu0YyZRWu52DRULQv1w3KXt/PuF3AUaoKk5RxWt7cjDYZpFnPrW3qc
 kcg+y259fWIC1w8Cu1U/uTtH4jP8N3HqX0b2wY0CSyI6oHYLb/NpG0hikX6LCijzc4MVIIV6m5P
 103t2eTHMl+DPvA6JZEN6nYoWjSk=
X-Google-Smtp-Source: AGHT+IGZBJkNXK33m7gXMk5WQtcgkZx2L9pwZXK8nv6Bj/nU5GJucrDI1Fzf92iLsggp7D9Sko3tJeEHrc0UCoQukwM=
X-Received: by 2002:a05:6122:488a:b0:4d3:3846:73bb with SMTP id
 71dfb90a1353d-4f2f3f06cd3mr12879987e0c.7.1720406886818; Sun, 07 Jul 2024
 19:48:06 -0700 (PDT)
MIME-Version: 1.0
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-8-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240703144921.1281-8-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:47:40 +1000
Message-ID: <CAKmqyKNre6i0B0i-hYY6nkV1ssxoN3oAe3RmXu1hKzmr5DDpVA@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] tests/avocado: Add an avocado test for riscv64
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Thu, Jul 4, 2024 at 12:55=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> To regularly test booting Linux with rv32 on QEMU RV64,
> we have added a test to boot_linux_console.py to retrieve
> cpuinfo and verify if it shows 'rv32' when using RV64 to
> boot rv32 CPUs.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/avocado/boot_linux_console.py | 37 +++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>
> diff --git a/tests/avocado/boot_linux_console.py b/tests/avocado/boot_lin=
ux_console.py
> index c35fc5e9ba..193b03d970 100644
> --- a/tests/avocado/boot_linux_console.py
> +++ b/tests/avocado/boot_linux_console.py
> @@ -12,6 +12,7 @@
>  import lzma
>  import gzip
>  import shutil
> +import time
>
>  from avocado import skip
>  from avocado import skipUnless
> @@ -1545,3 +1546,39 @@ def test_xtensa_lx60(self):
>          """
>          tar_hash =3D '49e88d9933742f0164b60839886c9739cb7a0d34'
>          self.do_test_advcal_2018('02', tar_hash, 'santas-sleigh-ride.elf=
')
> +
> +    def test_riscv64_virt_rv32i(self):
> +        """
> +        :avocado: tags=3Darch:riscv64
> +        :avocado: tags=3Dmachine:virt
> +        :avocado: tags=3Dcpu:rv32
> +        """
> +        kernel_url =3D ('https://github.com/romanheros/rv32-linux/raw'
> +                      '/master/Image32.xz')
> +        kernel_hash =3D 'a7ced5c38722481e0821b7cd70719cf53e46c13b'
> +        kernel_path_xz =3D self.fetch_asset(kernel_url, asset_hash=3Dker=
nel_hash)
> +
> +        kernel_path =3D  os.path.join(self.workdir, 'kernel.riscv32')
> +        archive.lzma_uncompress(kernel_path_xz, kernel_path)
> +
> +        rootfs_url =3D ('https://github.com/romanheros/rv32-linux/raw'
> +                      '/master/rootfs.ext2.xz')
> +        rootfs_hash =3D 'dc25ab9d4b233e8e0bcf7eb220d56fd2008fe263'
> +        rootfs_path_xz =3D self.fetch_asset(rootfs_url, asset_hash=3Droo=
tfs_hash)
> +
> +        rootfs_path =3D  os.path.join(self.workdir, 'rootfs.riscv32')
> +        archive.lzma_uncompress(rootfs_path_xz, rootfs_path)
> +
> +        self.vm.set_console()
> +        kernel_command_line =3D 'root=3D/dev/vda ro console=3DttyS0'
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', kernel_command_line,
> +                         '-drive', f'file=3D{rootfs_path},format=3Draw,i=
d=3Dhd0',
> +                         '-device', 'virtio-blk-device,drive=3Dhd0',)
> +        self.vm.launch()
> +
> +        console_pattern =3D 'Welcome to Buildroot'
> +        self.wait_for_console_pattern(console_pattern)
> +        exec_command(self, 'root')
> +        time.sleep(0.1)
> +        exec_command_and_wait_for_pattern(self, 'cat /proc/cpuinfo', 'rv=
32i')
> --
> 2.25.1
>
>

