Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0E37C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 12:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjcHD-00040h-LD; Tue, 14 Jul 2026 08:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjcH8-0003wn-IN
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:30:15 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1wjcH6-0005n3-EJ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 08:30:14 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-47122683cf3so2356757f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 05:30:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784032209; cv=none;
 d=google.com; s=arc-20260327;
 b=NNkIRek2uHwiDNY9vZXGWGkDyBYBxFLM5zTonLfcT97IKTCCxVUZBMvqUVCIwNC1Fs
 fJsRrPw3i/L1LcNOTTwpFRU8bdUa1hpd9RR7fDclkmqU9JhlWqYMOxf/AO99XgEfBVUy
 IwadWuitjteZlOafbs7jo6HJsTJcy+geSqXvJLYHXwIuSJ45VF6xDC6jFTV3uMauhy1c
 ifixCkwW3aEG595dqLKiRjdORjBSek0+s9ez+HHy4TksmIQE8pTHLq+5FjIT3THwOaXD
 uQra773+kTrA/lqlrx5IrmuJEKU3i5J2bwZVeYgQk8Z48Wo2K4xDIXQXPhFpuehVa1Xn
 3LOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RouHFf1gg4CfIl2pEJihq7YpaJgu5pfYzK/ONP8G5ww=;
 fh=iDp5i+ro4oOWeHQdE5F92zc2sb8szbNgm/kYGOQWLcY=;
 b=gBwky5RXsWAMIqAl0bnB/zRlOCbny+5B3EUX2BqRMmu4WhpCX5Y/7+HdmpCgApg5Ya
 pafzAz/qxykry1S8KALTbUcQR2KYuz2L4D4GBKv44owfB51xAdt5w1ROlMRF1Xoo0kWp
 2E3VFzjtkVPuk/LBczA9kdk/l7xMIr5iZgiBbvo+IORxE+f6IRKSMeZavP0phWeJAhCN
 9vnsBKOkVSpgDc3CuMidQfNhpkMxjVD5geZOgBhvM4wO0VlPbFTlt4N/fIoh2LfYUoYk
 x0TGfYXkdK5y2i3Dd5JWQDnU04NQBU/xvk+8OnvJDwCgVZ30hZlMr9zZLMGcWhMavAmM
 OT9Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784032209; x=1784637009; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RouHFf1gg4CfIl2pEJihq7YpaJgu5pfYzK/ONP8G5ww=;
 b=ONXR40CTy/S6ttgpOhtYVsyg2IvqfYHB5YILhX5PBsfpLgDpG54/RW0xQdGn+uhyQv
 WGdqhuHyXS2sglrWuH1gT8330C7U1ieLYNaMCFFcb1GlXynYOnx2l2F1n2WTzMk4ucdL
 /KkSDgmRN/gxnRFepEl574qtC01cwSJgmB8KhUjCKxruA5szbBvm5cxELYi8ynLmD6If
 YB0f8HVKNTchV+vNDRTtAdZAmy7H33/XzLAuV2Ui6QQJZ27d1ueTpPsQslKc3OLDl14i
 d2iRurDCdlSvLHVle5UB3mqrABOCerJV6ZO/UW3fcG+GdcjMUzRer2A5mUQQ87Ekr/nj
 +J4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784032209; x=1784637009;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RouHFf1gg4CfIl2pEJihq7YpaJgu5pfYzK/ONP8G5ww=;
 b=cYagi9qXD3FOSKyft2FReJbL4WNlAToLTtAKzmRIdnrL4AyqcvQPzLq2rnKfshkJgb
 Ex5Pm4KMLr3fKSgvB5Dmv8xnSyft/ADQKJqIk+vJHM/ScsW2GC2TU/FZ/lcG3mg74sw1
 +qOtx1yKtK8236dI1SfDtSVyCVB5UQJfAIdbTUMht/DcUED9a/b8rOVsxaojM7PgQB1y
 jn+XgAUV4JJ3IefsQIFKVBa4xRr3tVVzN3JIIgvfTN1o8uUUPCajObI3CJ+foruVODg6
 /eF37leJXOFUuWG6KQ/syCi9YbMZ6fOTgdZiJoDDe4RQjjgiOH/mzzWzb2dEigLnYSup
 5nvw==
X-Gm-Message-State: AOJu0Yw+V5hecXHLpnUCUr3rZ0OuRxaLY05JoNUQetxZiSX+QwLbc2+t
 aYlNVQ3m/z1pDofoXzVRsn4T/TrU/w0P48RfCWhTldIA1tsmJ1FFnXd02JsvJxUu5ExJifO7Beu
 Tl0+EDX5IRpCGgXCrBTs41qkxuA2+gko=
X-Gm-Gg: AfdE7cnH4Uzo3Oh0vwMVKgfXOGRsmvD4zq4MagCkxVuMwMdiGVQR4gwh8bxJxm1xOAe
 Rz/V/3ntWx+oOfpxfmWf6LYxtY00zSfYAKQfEb1nHTyLjHOMtuORu2z0BUrVMIwsKJPc9FHN71s
 dY0iDWUqHnzKNYLF6qL0V+zxmbqoztxy4DQX3vKgWCcyYSuZs2D6rjQCyvKn7QlADnfqDgzfdAt
 8qwv2xvXDmRm10pos7UNCPVdXZPRrLDFo7i1guUBxfKo2p//9WiTfL5bxkjBHNfm04eeyZX
X-Received: by 2002:a05:600c:1f90:b0:493:f29d:d591 with SMTP id
 5b1f17b1804b1-4951832618amr35062615e9.39.1784032208604; Tue, 14 Jul 2026
 05:30:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260713161647.20211-1-dingtao0430@163.com>
 <20260713161647.20211-2-dingtao0430@163.com>
In-Reply-To: <20260713161647.20211-2-dingtao0430@163.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 14 Jul 2026 20:29:54 +0800
X-Gm-Features: AUfX_mzPL2T2A_1rzR8aQQQ0rnaxFMVCOg7BcB9NvLHgIMwVxGhQuKszhLRAJco
Message-ID: <CAEUhbmUKp7Y5X57YPaP6puuwpJTztHuQQck8j1B8f5g2mjC9+w@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] hw/sd: sdhci: Fix SDMA boundary bug
To: Tao Ding <dingtao0430@163.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=bmeng.cn@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jul 14, 2026 at 12:19=E2=80=AFAM Tao Ding <dingtao0430@163.com> wro=
te:
>
> During SDMA transfers, the controller raises an interrupt at buffer bound=
aries
> to request a system address update. The host driver will rewrite the SDHC=
_SYSAD register.
> (according to PartA2_SD_Host_Controller_Simplified_Specification_Ver2.00.=
pdf section 2.2.1)
> However, the current code will ignore write operations to SDHC_SYSAD.
>
> To fix this bug, when SDMA encounters a boundary, a state is set to recor=
d it.
> In this state, SDHC_SYSAD can be written. In other cases, it is still pro=
tected by TRANSFERRING_DATA.
>
> Meanwhile, a subsection has been added for migration.
>
> Suggested-by: Bin Meng <bmeng.cn@gmail.com>
> Signed-off-by: Tao Ding <dingtao0430@163.com>
> ---
> This bug may be encountered when using uboot with SDMA functionality, and=
 can be reproduced by following the steps below.
> Uboot test:
>     1. Prepare zImage, uboot and rootfs.cpio.gz, make sure uboot config (=
MMC_SDHCI_SDMA=3Dy).
>         for more detail, can obtained
>         "https://lore.kernel.org/qemu-devel/20260617155857.7451-1-dingtao=
0430@163.com/T/#mcdf231e6bd762903f8393bf93253cbcb12ececcf"
>     2. ./qemu-system-aarch64 -M xilinx-zynq-a9 -machine boot-mode=3Dsd -m=
 1024 -display none -serial null -serial stdio -monitor none \
>         -device loader,file=3Du-boot-dtb.bin,addr=3D0x04000000,cpu-num=3D=
0  \
>         -drive file=3Dzynq-sd.img,format=3Draw,if=3Dsd -D qemu.log
>
>
> After applying the fix, success load sd card:
>
> U-Boot 2026.07-rc4-g1e80ee41441c (Jun 15 2026 - 19:05:05 +0800)
>
> Model: Xilinx ZC702 board
> DRAM:  ECC disabled 1 GiB
> Core:  33 devices, 21 uclasses, devicetree: board
> Flash: 0 Bytes
> NAND:  0 MiB
> MMC:   mmc@e0100000: 0
> Loading Environment from FAT... *** Error - No Valid Environment Area fou=
nd
> *** Warning - bad env area, using default environment
>
> In:    serial@e0001000
> Out:   serial@e0001000
> Err:   serial@e0001000
> Net:
> ZYNQ GEM: e000b000, mdio bus e000b000, phyaddr 7, interface rgmii-id
>
> Warning: ethernet@e000b000 (eth0) using random MAC address - 4a:63:5a:a4:=
d3:6b
> eth0: ethernet@e000b000
> Hit any key to stop autoboot: 0
> Zynq> fatload mmc 0 ${kernel_addr_r} zImage
> 10838528 bytes read in 4316 ms (2.4 MiB/s)
> Zynq> fatload mmc 0 ${ramdisk_addr_r} rootfs-arm32.cpio.gz
> 406531 bytes read in 199 ms (1.9 MiB/s)
> Zynq> setenv ramdisk_size ${filesize}
> Zynq> fatload mmc 0 ${fdt_addr_r} zynq-zc702.dtb
> 15754 bytes read in 21 ms (732.4 KiB/s)
> Zynq> setenv bootargs console=3DttyPS0,115200 earlycon ignore_loglevel rd=
init=3D/init
> Zynq> bootz ${kernel_addr_r} ${ramdisk_addr_r}:${ramdisk_size} ${fdt_addr=
_r}
> Kernel image @ 0x2000000 [ 0x000000 - 0xa56200 ]
> ## Flattened Device Tree blob at 01f00000
>    Booting using the fdt blob at 0x1f00000
> Working FDT set to 1f00000
>    Loading Ramdisk to 2ff9c000, end 2ffff403 ... OK
>    Loading Device Tree to 2ff95000, end 2ff9bd89 ... OK
> Working FDT set to 2ff95000
>
> Starting kernel ...
>
>  hw/sd/sdhci.c         | 25 ++++++++++++++++++++++++-
>  include/hw/sd/sdhci.h |  2 ++
>  2 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c86dfa281f..e614afa346 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -307,6 +307,7 @@ static void sdhci_reset(SDHCIState *s)
>      s->data_count =3D 0;
>      s->stopped_state =3D sdhc_not_stopped;
>      s->pending_insert_state =3D false;
> +    s->sdma_boundary_paused =3D false;
>      if (object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_BE) ||
>              object_dynamic_cast(OBJECT(s), TYPE_FSL_ESDHC_LE)) {
>          s->norintstsen =3D 0x013f;
> @@ -414,6 +415,7 @@ static void sdhci_end_transfer(SDHCIState *s)
>          s->norintsts |=3D SDHC_NIS_TRSCMP;
>      }
>
> +    s->sdma_boundary_paused =3D false;
>      sdhci_update_irq(s);
>  }
>
> @@ -681,6 +683,7 @@ static void sdhci_sdma_transfer_multi_blocks(SDHCISta=
te *s)
>      if (s->blkcnt =3D=3D 0) {
>          sdhci_end_transfer(s);
>      } else {
> +        s->sdma_boundary_paused =3D true;
>          sdhci_update_irq(s);
>      }
>  }
> @@ -1164,6 +1167,7 @@ static inline void sdhci_reset_write(SDHCIState *s,=
 uint8_t value)
>                  SDHC_DATA_INHIBIT | SDHC_DAT_LINE_ACTIVE);
>          s->blkgap &=3D ~(SDHC_STOP_AT_GAP_REQ | SDHC_CONTINUE_REQ);
>          s->stopped_state =3D sdhc_not_stopped;
> +        s->sdma_boundary_paused =3D false;
>          s->norintsts &=3D ~(SDHC_NIS_WBUFRDY | SDHC_NIS_RBUFRDY |
>                  SDHC_NIS_DMA | SDHC_NIS_TRSCMP | SDHC_NIS_BLKGAP);
>          break;
> @@ -1185,7 +1189,7 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t v=
al, unsigned size)
>
>      switch (offset & ~0x3) {
>      case SDHC_SYSAD:
> -        if (!TRANSFERRING_DATA(s->prnsts)) {
> +        if (!TRANSFERRING_DATA(s->prnsts) || s->sdma_boundary_paused) {
>              s->sdmasysad =3D (s->sdmasysad & mask) | value;
>              MASKED_WRITE(s->sdmasysad, mask, value);
>              /* Writing to last byte of sdmasysad might trigger transfer =
*/
> @@ -1464,6 +1468,13 @@ static bool sdhci_pending_insert_vmstate_needed(vo=
id *opaque)
>      return s->pending_insert_state;
>  }
>
> +static bool sdhci_sdma_boundary_paused_vmstate_needed(void *opaque)
> +{
> +    SDHCIState *s =3D opaque;
> +
> +    return s->sdma_boundary_paused;
> +}
> +
>  static const VMStateDescription sdhci_pending_insert_vmstate =3D {
>      .name =3D "sdhci/pending-insert",
>      .version_id =3D 1,
> @@ -1475,6 +1486,17 @@ static const VMStateDescription sdhci_pending_inse=
rt_vmstate =3D {
>      },
>  };
>
> +static const VMStateDescription sdhci_sdma_boundary_paused_vmstate =3D {
> +    .name =3D "sdhci/sdma_boundary_paused",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D sdhci_sdma_boundary_paused_vmstate_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_BOOL(sdma_boundary_paused, SDHCIState),
> +        VMSTATE_END_OF_LIST()
> +    },
> +};

Need to add a pre_load/post_load pair to ensure
s->sdma_boundary_paused can be correctly migrated.

The pre_load() should set the state to false and the post_load()
should reconstruct the state based on the migrated register values
when the migrated stream does not contain the state.

  static int sdhci_pre_load(void *opaque)
  {
      SDHCIState *s =3D opaque;

      s->sdma_boundary_paused =3D false;
      return 0;
  }

  static bool sdhci_sdma_transfer_active(SDHCIState *s)
  {
      return TRANSFERRING_DATA(s->prnsts) &&
             (s->trnmod & SDHC_TRNS_DMA) &&
             s->blkcnt &&
             (s->blksize & BLOCK_SIZE_MASK) &&
             SDHC_DMA_TYPE(s->hostctl1) =3D=3D SDHC_CTRL_SDMA;
  }

  static int sdhci_post_load(void *opaque, int version_id)
  {
      SDHCIState *s =3D opaque;

      if (!s->sdma_boundary_paused) {
          s->sdma_boundary_paused =3D sdhci_sdma_transfer_active(s);
      }
      return 0;
  }

> +
>  const VMStateDescription sdhci_vmstate =3D {
>      .name =3D "sdhci",
>      .version_id =3D 1,
> @@ -1512,6 +1534,7 @@ const VMStateDescription sdhci_vmstate =3D {
>      },
>      .subsections =3D (const VMStateDescription * const []) {
>          &sdhci_pending_insert_vmstate,
> +        &sdhci_sdma_boundary_paused_vmstate,
>          NULL
>      },
>  };
> diff --git a/include/hw/sd/sdhci.h b/include/hw/sd/sdhci.h
> index a9da6203fc..c485277744 100644
> --- a/include/hw/sd/sdhci.h
> +++ b/include/hw/sd/sdhci.h
> @@ -103,6 +103,8 @@ struct SDHCIState {
>       * to be protected. Set wp_inverted to invert the signal.
>       */
>      bool wp_inverted;
> +    /* Indicate that SDMA transfer is paused due to hitting the boundary=
 */
> +    bool sdma_boundary_paused;
>  };
>  typedef struct SDHCIState SDHCIState;
>

Regards,
Bin

