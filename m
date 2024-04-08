Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A12CD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 07:55:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtjqD-0003Sm-7d; Mon, 08 Apr 2024 03:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtjqB-0003SS-Op
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mcascell@redhat.com>)
 id 1rtjq9-0004Xf-S2
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 03:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712562892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lVYOntfJW+z1bIKZI8zkdsAZG65eWEv0R4QmEqfsAvY=;
 b=FMjeKQbeT+adFKdaXA+QzFTn4uBoyBIqGgDhvC7pq0DLB7LQaZaiQsRphOLQEIuJuTXGmx
 i80uwuJ1HDPlZ0qAHDOsCWAsTCM9slJf1hS/knGH18gRBp1j9Keq9g5sDSjN4HXFJi7bcQ
 H+T0Fvl92MV88q+YejDI8fOl0km+8iQ=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-NGdT4MmZMWGWjoaavspnqA-1; Mon, 08 Apr 2024 03:54:51 -0400
X-MC-Unique: NGdT4MmZMWGWjoaavspnqA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-5d8bdadc79cso3735371a12.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 00:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712562890; x=1713167690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lVYOntfJW+z1bIKZI8zkdsAZG65eWEv0R4QmEqfsAvY=;
 b=Bi/cZv7W/3DtyvYdpCeYD0oBwqIDSQtVDL2CWBNWVGCf1Fb/+LUcZ0bF+qpi64R/Mq
 92poxBJFZrTDqPu9diJMaX78Z+sZKIpcdWWwIiQKu0syGarcvJwilVUZjjxyCQRvJGY1
 oodBQmMoGhV2td4wHqptgx48M3LKUR9VYVhlmbXa5jrYo5VpehnLa2lS7hfEv10GYS/a
 UWmOtaHV2w4FlgZiewvs4nUazlbEQOv09CEzyRZaTdW/qcJzW7ofLBUhmQNMmowfSvPp
 Aul95WAlNpbLTKQQjXsPNNFQRnFslS+u8xpR6nz2QO0tPd9G7mX6smAF6RHIcbuKeP8B
 l6Hw==
X-Gm-Message-State: AOJu0YydcmsndoiMAKoWsHbFAXl2GZRPCjvsBRQDRNXKUMF+KHuKfsPU
 1QTun/jimztt2/vg6TbgIWwqoHzd6T35VP38Ei9gPLFbQkIwZQr2PFD93KmQlyoyaX9SXdnd6Vs
 CC73fs2VKZdN+WmvQ0GV1dpQOXUC3f/CC+q++CtrkzPJnWwkLxlcHu3luvDRvJmR6u76EPvb0O9
 MqKeeT4PiE0N4J30Bw+FmdXs68ybk=
X-Received: by 2002:a05:6a20:2d0a:b0:1a7:86d7:ef3d with SMTP id
 g10-20020a056a202d0a00b001a786d7ef3dmr836663pzl.27.1712562890696; 
 Mon, 08 Apr 2024 00:54:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi87seyQyjUqjF901itYGr5uEMh8rpsmeDM4VuLlFMXPnjyvIxd6avdda3iGyqWKkEHa1yodU1Pggt8imRtgw=
X-Received: by 2002:a05:6a20:2d0a:b0:1a7:86d7:ef3d with SMTP id
 g10-20020a056a202d0a00b001a786d7ef3dmr836646pzl.27.1712562890382; Mon, 08 Apr
 2024 00:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240404085549.16987-1-philmd@linaro.org>
In-Reply-To: <20240404085549.16987-1-philmd@linaro.org>
From: Mauro Matteo Cascella <mcascell@redhat.com>
Date: Mon, 8 Apr 2024 09:54:39 +0200
Message-ID: <CAA8xKjXW=DsuFzc_4fmdK0EG9Oke3fNs1Rwzu-ykfXpCjLX5dA@mail.gmail.com>
Subject: Re: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to
 Buffer Data Port register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, qemu-stable@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mcascell@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 4, 2024 at 10:55=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Per "SD Host Controller Standard Specification Version 3.00":
>
>   * 1.7 Buffer Control
>
>   - 1.7.1 Control of Buffer Pointer
>
>     (3) Buffer Control with Block Size
>
>     In case of write operation, the buffer accumulates the data
>     written through the Buffer Data Port register. When the buffer
>     pointer reaches the block size, Buffer Write Enable in the
>     Present State register changes 1 to 0. It means no more data
>     can be written to the buffer. Excess data of the last write is
>     ignored. For example, if just lower 2 bytes data can be written
>     to the buffer and a 32-bit (4-byte) block of data is written to
>     the Buffer Data Port register, the lower 2 bytes of data is
>     written to the buffer and the upper 2 bytes is ignored.
>
> Discard the excess of data to avoid overflow reported by fuzzer:
>
>   $ cat << EOF | qemu-system-i386 \
>                      -display none -nodefaults \
>                      -machine accel=3Dqtest -m 512M \
>                      -device sdhci-pci,sd-spec-version=3D3 \
>                      -device sd-card,drive=3Dmydrive \
>                      -drive if=3Dnone,index=3D0,file=3Dnull-co://,format=
=3Draw,id=3Dmydrive -nographic \
>                      -qtest stdio
>   outl 0xcf8 0x80001013
>   outl 0xcfc 0x91
>   outl 0xcf8 0x80001001
>   outl 0xcfc 0x06000000
>   write 0x9100002c 0x1 0x05
>   write 0x91000058 0x1 0x16
>   write 0x91000005 0x1 0x04
>   write 0x91000028 0x1 0x08
>   write 0x16 0x1 0x21
>   write 0x19 0x1 0x20
>   write 0x9100000c 0x1 0x01
>   write 0x9100000e 0x1 0x20
>   write 0x9100000f 0x1 0x00
>   write 0x9100000c 0x1 0x00
>   write 0x91000020 0x1 0x00
>   EOF
>
> Stack trace (part):
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =3D=3D89993=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on address
> 0x615000029900 at pc 0x55d5f885700d bp 0x7ffc1e1e9470 sp 0x7ffc1e1e9468
> WRITE of size 1 at 0x615000029900 thread T0
>     #0 0x55d5f885700c in sdhci_write_dataport hw/sd/sdhci.c:564:39
>     #1 0x55d5f8849150 in sdhci_write hw/sd/sdhci.c:1223:13
>     #2 0x55d5fa01db63 in memory_region_write_accessor system/memory.c:497=
:5
>     #3 0x55d5fa01d245 in access_with_adjusted_size system/memory.c:573:18
>     #4 0x55d5fa01b1a9 in memory_region_dispatch_write system/memory.c:152=
1:16
>     #5 0x55d5fa09f5c9 in flatview_write_continue system/physmem.c:2711:23
>     #6 0x55d5fa08f78b in flatview_write system/physmem.c:2753:12
>     #7 0x55d5fa08f258 in address_space_write system/physmem.c:2860:18
>     ...
> 0x615000029900 is located 0 bytes to the right of 512-byte region
> [0x615000029700,0x615000029900) allocated by thread T0 here:
>     #0 0x55d5f7237b27 in __interceptor_calloc
>     #1 0x7f9e36dd4c50 in g_malloc0
>     #2 0x55d5f88672f7 in sdhci_pci_realize hw/sd/sdhci-pci.c:36:5
>     #3 0x55d5f844b582 in pci_qdev_realize hw/pci/pci.c:2092:9
>     #4 0x55d5fa2ee74b in device_set_realized hw/core/qdev.c:510:13
>     #5 0x55d5fa325bfb in property_set_bool qom/object.c:2358:5
>     #6 0x55d5fa31ea45 in object_property_set qom/object.c:1472:5
>     #7 0x55d5fa332509 in object_property_set_qobject om/qom-qobject.c:28:=
10
>     #8 0x55d5fa31f6ed in object_property_set_bool qom/object.c:1541:15
>     #9 0x55d5fa2e2948 in qdev_realize hw/core/qdev.c:292:12
>     #10 0x55d5f8eed3f1 in qdev_device_add_from_qdict system/qdev-monitor.=
c:719:10
>     #11 0x55d5f8eef7ff in qdev_device_add system/qdev-monitor.c:738:11
>     #12 0x55d5f8f211f0 in device_init_func system/vl.c:1200:11
>     #13 0x55d5fad0877d in qemu_opts_foreach util/qemu-option.c:1135:14
>     #14 0x55d5f8f0df9c in qemu_create_cli_devices system/vl.c:2638:5
>     #15 0x55d5f8f0db24 in qmp_x_exit_preconfig system/vl.c:2706:5
>     #16 0x55d5f8f14dc0 in qemu_init system/vl.c:3737:9
>     ...
> SUMMARY: AddressSanitizer: heap-buffer-overflow hw/sd/sdhci.c:564:39
> in sdhci_write_dataport
>
> Cc: qemu-stable@nongnu.org
> Fixes: d7dfca0807 ("hw/sdhci: introduce standard SD host controller")
> Buglink: https://bugs.chromium.org/p/oss-fuzz/issues/detail?id=3D58813
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Reported-by: Chuhong Yuan <hslester96@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/sd/sdhci.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c5e0bc018b..2dd88fa139 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -552,7 +552,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
>   * register */
>  static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned=
 size)
>  {
> -    unsigned i;
> +    unsigned i, available;
>
>      /* Check that there is free space left in a buffer */
>      if (!(s->prnsts & SDHC_SPACE_AVAILABLE)) {
> @@ -560,6 +560,14 @@ static void sdhci_write_dataport(SDHCIState *s, uint=
32_t value, unsigned size)
>          return;
>      }
>
> +    available =3D s->buf_maxsz - s->data_count;
> +    if (size > available) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SDHC buffer data full (size: %"P=
RIu32")"
> +                                       " discarding %u byte%s\n",
> +                                       s->buf_maxsz, size - available,
> +                                       size - available > 1 ? "s" : "");
> +        size =3D available; /* Excess data of the last write is ignored.=
 */
> +    }
>      for (i =3D 0; i < size; i++) {
>          s->fifo_buffer[s->data_count] =3D value & 0xFF;
>          s->data_count++;
> --
> 2.41.0
>

Thank you Philippe. This was assigned CVE-2024-3447.

--=20
Mauro Matteo Cascella
Red Hat Product Security
PGP-Key ID: BB3410B0


