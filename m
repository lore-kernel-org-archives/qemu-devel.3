Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA843E83837
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 21:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs5sm-0008OC-KH; Mon, 16 Feb 2026 16:11:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vs5sl-0008O0-0T
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:11:51 -0500
Received: from esa12.hc2706-39.iphmx.com ([216.71.137.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alxndr@bu.edu>) id 1vs5sh-000854-Un
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 16:11:50 -0500
X-CSE-ConnectionGUID: v6WUQ12JQcS8EskHmXzvhA==
X-CSE-MsgGUID: 2L6R8xNCSRKcE5MhhW4+Cg==
Authentication-Results: ob1.hc2706-39.iphmx.com;
 dkim=pass (signature verified) header.i=@bu.edu;
 spf=SoftFail smtp.mailfrom=alxndr@bu.edu;
 dmarc=pass (p=quarantine dis=none) d=bu.edu
X-IronPort-RemoteIP: 209.85.221.197
X-IronPort-MID: 113184612
X-IronPort-Reputation: None
X-IronPort-Listener: OutgoingMail
X-IronPort-SenderGroup: RELAY_GSUITE
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:YO3bbq8cvqeYjbKOmg9hDrUD0H+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 mJKXjjUPK2KNjTyL4t0atzlpkMHvZCDnddgHAZppCkxFiIbosf7XuiUfxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG/6yE6iefQH+SU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCkaGt
 MiaT/f3YTdJ4BYqdDhNg06/gEk35qqq4mpG5gFWic1j5zcyqVFEVPrzGonsdxMUcqEMdsamS
 uDKyq2O/2+x138FFtO/n7/nRVYBS7jUMBLmoiI+t3+K20UqSoQai87XBdJFAatlo2zhc+NZk
 b2hgaeNpTIBZcUgrgi/vy5wSEmSNYUekFPOzOPWXca7liUqeFO1qxli4d1f0ST1NY+bDEkXn
 cH0JgzhYTid2d2L+evhaNBnvZQON8rLObMNpHFJmGSx4fYOGfgvQo3P7N5cmSkz34VARKeBI
 cUebjVrYVLLZBgn1lU/Uspv2rf1wCOlKnsB+Q39SakfugA/yCR41KjrPMD9cMHMSMlI9qqdj
 jufpD2pXk9DbrRzzxLf1iyW1v/pthjBe4k/SZi49sE2w3ackzl75Bo+EAHTTeOColezXs8aJ
 0EK9y4Gq680+0q2CN7nUHWFTGWsuxcdX59OELR/5ljclezb5AGWAmVCRTlEADA7iPILqfUR/
 gbht/vjGHpivKD9dJ5X3u78Qe+aUcTNEVI/WA==
IronPort-HdrOrdr: A9a23:xTvEuK9TE3k/4sPLdlBuk+A0I+orL9Y04lQ7vn2ZFiY4TiXIra
 2TdaogvyMcRgxhJk3I/urwSJVoIEmshKKdhLN/AV7MZnichILFFvAE0WKm+UyZJ8SczJ8l6U
 4DSdkCNDSYNzET5reekW2F+pQbsb+6GcuT9JvjJhlWPH5XQpAlwQM8JQqSD1FsSBMuP+tCKL
 OsouRC4xSvEE52Ui15PBg4tir4yeHjpdbBXSMsISIBxU2nsQ6IgYSKYCRwFy1uMEIs/Ysf
X-Talos-CUID: 9a23:YkLWJWF4i4i0rjagqmJ5qnEpI5l/UETW9yf9OEyYDFZ7Vr28HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AJVdEog2wSWTDYnyr7oC/N+1H5zUjuYDwMhAdt74?=
 =?us-ascii?q?9geqPGHFVOzei0HecTdpy?=
Received: from mail-vk1-f197.google.com ([209.85.221.197])
 by ob1.hc2706-39.iphmx.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384;
 16 Feb 2026 16:11:44 -0500
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56640897b95so38081011e0c.2
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 13:11:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771276303; cv=none;
 d=google.com; s=arc-20240605;
 b=eRCvaPvRBbHmE9jyzcG/cuv8fjq0SWKNJmNdMfB6GWnds7YS+YQ0eW1CIkQGb7BeYc
 tIRjez59/FNFIAgt4e441NXpCK+twr14xUpxTES26Q3AHfD0/c1O+/oF0v9a1CiC3cRS
 xH+Irmc4bCANfCJiBj/67+WklGwRow1VydHIqgCn3CueHNedrB7V8GWPaXBCyYv6DAGi
 sfTnXzONf7xEWGbc+dEeYih1Txq54gt4HyghcAAC+6c3BCHfxo5pVZia4SEd5lVGo/1V
 X74LBFDsTK3wxkzE0BlzWVcQNb6hlAHbtLrba8YNGCgVuF3g0JyB3v8AqfIjABx/5C+G
 kRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:dkim-signature;
 bh=l3qxdHxHWpL/gqjCEtcid1OhMY/V5YF3f2g1o/grhHI=;
 fh=u6sPJ48aulQF2k+Id6JBTIF3oZ/ZZevtdAckTeDQr34=;
 b=Jzn87nkOIja0OvkDAY+sZ1wlrEztPeSArmphinDiO+gc233WHb3nPsmMgwvkpv00wU
 xFqyF2TDsmXojYUZcigM2oPOyOOog2QKQ8EM015E7lqb28K5HRQeqXuexlG6qfDqNztR
 VUyptNGPDNiauDqO+7eTFNqeB2Ne116kGqLZ5nW11TKxrYPJry67vkJH+uzDmOwR5P3L
 iGxRGz/PEiEObV2KAcoYbLO0oF9UOC+b7yb3qPIzzCckExZDyDoCsJAjRsR9cZn25cQM
 a9iezbP0j03bYkvH/dzBJoHo6E+AVGuWOvaA30X/U6H5qu0hDG34HGlCdCFqJQo6mf6s
 jpjg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bu.edu; s=s1gsbu; t=1771276303; x=1771881103; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:from:to:cc:subject:date:message-id
 :reply-to; bh=l3qxdHxHWpL/gqjCEtcid1OhMY/V5YF3f2g1o/grhHI=;
 b=nHAyKceN1DcOcJQY4jeawE9Raj5b/RNbp0EYH5rOYc4ElPshiR0sB/lhUQ6ohm8c6V
 45OFrRo5GRt/5sHDZt7n2mal8zeQFdHmOWe2mPr0jTfVdeT9tcWeOFHkxu85QfdtOHVj
 bRVP7a8eRIrzsxK+KSB9piIj48PZbPgpfhw9pX4dVV3eeybXtI+YgqMJP1wwBTwIMGSd
 xts+grOvAxrnYvrnXBjPjIvKB18h1nJPYbfvyW+JcPw57B6/UMDXro8eMj6KtnYGmqoD
 YveJe2M4+mKf0aCRs/i3xpTeknZnuuxBcYARYoXdp+D0YpuoZn08OyviV5+7PPGo61zv
 fM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771276303; x=1771881103;
 h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
 :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l3qxdHxHWpL/gqjCEtcid1OhMY/V5YF3f2g1o/grhHI=;
 b=L4TJc29kgaG12hVjThZVxwhPNGw2G7Gks46f3O9n8LpsJbLLBoclZXMbyRAY7OKfUv
 4n/VWDojUOgBBgvqUP2XhZUzGRzJglr2i37i/ePJskoTFd5n4UM75lQ2y5TLDC/J4IfB
 vX6VHFY/V15QwZsX4mDbAKcOxGctITWzxPS9q59AjbF7yTmNEvP6CB2jFXCa05ACxQxe
 HhFxkJwmBfCy+FUGLHVRmhkvOQt5YhbRFwujZrL/+qi+jUJa4y+GuSa+AR3Kls2Sxx8m
 yBlpLWr8eyMpRdNT6xwo6eDfS2CwK7HssBfyuvYJ/ex1uF2lppqykoZqmFCfGCBpWCqj
 iuWQ==
X-Gm-Message-State: AOJu0YyvdqafuqP5hfl2mwzo9yHdI2A3Y8Z7sSNbjVNCqGQ+8XFtVeeO
 8Y3T2ufZmc+twrYSWwjhOP+UaDRongEkHfltgneY4yA2Tp9M8nbi/xy6CPxYouEOtrR+sFidDrs
 n+xSrTeGiW9hn5ziY6PP5tUkUIooFh8Cqycrx9HB37GQTozW4ewEMuan0BsWA7z+IiZwXSqdmlm
 qP2iBRMEOcMVnLyfhccDfggOYpHX33cku1U7opLgf9c+TR
X-Gm-Gg: AZuq6aIvWF8tO75XBGg7eWbCs7eYYv5bEunOmmb8BG8ao83hTVFk6NJFHSJLQDrEJyV
 DUNmKagIeSPhlOoyk8T8m0X0NtEueQRfIXoDQTCBkI9UdN1qw9N+gD5TQNUnp1zYXbyPvZNCQO8
 8qTD36zHzbHJWuJfZCOpAdCW+Nvc6GvuMDewBKxd1gSGu2U8NTCk/Wkk1Yr5kZiiqwUEUFrgs6D
 yLmktJ6XlmWUNdthagIl0xHH2+qfM5tnmhKfOVvbfWlYsMkfhkvR5fhSgBrPMO4KI4=
X-Received: by 2002:a05:6122:d2a:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-5676aa84ce3mr3853670e0c.13.1771276303378; 
 Mon, 16 Feb 2026 13:11:43 -0800 (PST)
X-Received: by 2002:a05:6122:d2a:b0:55a:ab0d:bf74 with SMTP id
 71dfb90a1353d-5676aa84ce3mr3853657e0c.13.1771276303041; Mon, 16 Feb 2026
 13:11:43 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 13:11:42 -0800
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Feb 2026 13:11:42 -0800
From: Alexander Bulekov <alxndr@bu.edu>
References: <20260216205527.45938-1-philmd@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20260216205527.45938-1-philmd@linaro.org>
Date: Mon, 16 Feb 2026 13:11:42 -0800
X-Gm-Features: AaiRm525A5pB6z23dSsEDx1YEVPi6Z3BtOPB8Ehqmx8Frnsq_dGa3iZV2VHgoQ4
Message-ID: <CAHUE=o9t+E2bgke5dFXTh+hdZwTYJwq+2NMxgWBbYcPp+m7hhQ@mail.gmail.com>
Subject: Re: [PATCH] hw/char/virtio-serial-bus: Fix Heap-buffer-overflow in
 set_config()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Amit Shah <amit@kernel.org>, Laurent Vivier <lvivier@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.71.137.82; envelope-from=alxndr@bu.edu;
 helo=esa12.hc2706-39.iphmx.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 WEIRD_PORT=0.001 autolearn=no autolearn_force=no
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

On 260216 2155, Philippe Mathieu-Daud=C3=A9 wrote:
> When removing the 'emergency-write' property in commit d0660e5b7fc
> we neglected to remove the code reducing the virtio_console_config
> structure size, allowing to access up to the unallocated 'emerg_wr'
> field.
>
> Can be reproduced running:
>
>   $ cat << EOF | qemu-system-i386 -nodefaults \
>                      -machine q35 -m 512M \
>                      -device virtio-serial \
>                      -display none \
>                      -machine accel=3Dqtest -qtest stdio
>   outl 0xcf8 0x80000810
>   outl 0xcfc 0xc000
>   outl 0xcf8 0x80000804
>   outw 0xcfc 0x01
>   outl 0xc014 0x00
>   EOF
>   =3D=3D3210206=3D=3DERROR: AddressSanitizer: heap-buffer-overflow
>       on address 0x502000090858 at pc 0x5638f1300a9b bp 0x7fff6b525b80 sp=
 0x7fff6b525b70
>   READ of size 4 at 0x502000090858 thread T0
>       #0 0x5638f1300a9a in set_config hw/char/virtio-serial-bus.c:590
>       #1 0x5638f0bccdcf in virtio_config_writel hw/virtio/virtio-config-i=
o.c:104
>       #2 0x5638f0bd0c89 in virtio_pci_config_write hw/virtio/virtio-pci.c=
:637
>       #3 0x5638f0cf90cf in memory_region_write_accessor system/memory.c:4=
91
>       #4 0x5638f0cf975b in access_with_adjusted_size system/memory.c:567
>       #5 0x5638f0d01d3f in memory_region_dispatch_write system/memory.c:1=
547
>       #6 0x5638f0d2fa1e in address_space_stm_internal system/memory_ldst.=
c.inc:85
>       #7 0x5638f0d30013 in address_space_stl_le system/memory_ldst_endian=
.c.inc:53
>       #8 0x5638f0ceb568 in cpu_outl system/ioport.c:79
>       #9 0x5638f0d3c0f9 in qtest_process_command system/qtest.c:483
>
>   0x502000090858 is located 0 bytes to the right of 8-byte region [0x5020=
00090850,0x502000090858)
>   allocated by thread T0 here:
>       #0 0x7f0dc32cba57 in __interceptor_calloc src/libsanitizer/asan/asa=
n_malloc_linux.cpp:154
>       #1 0x7f0dc2382c50 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.s=
o.0+0x5ec50)
>       #2 0x5638f1303c27 in virtio_serial_device_realize hw/char/virtio-se=
rial-bus.c:1046
>       #3 0x5638f1396a9c in virtio_device_realize hw/virtio/virtio.c:4053
>       #4 0x5638f13ea370 in device_set_realized hw/core/qdev.c:523
>       #5 0x5638f13fdaf6 in property_set_bool qom/object.c:2376
>       #6 0x5638f13f9098 in object_property_set qom/object.c:1450
>       #7 0x5638f140283c in object_property_set_qobject qom/qom-qobject.c:=
28
>       #8 0x5638f13f9616 in object_property_set_bool qom/object.c:1520
>       #9 0x5638f13e91cc in qdev_realize hw/core/qdev.c:276
>       #10 0x5638f0c3d94b in virtio_serial_pci_realize hw/virtio/virtio-se=
rial-pci.c:69
>       #11 0x5638f0bda886 in virtio_pci_realize hw/virtio/virtio-pci.c:235=
1
>       #12 0x5638f09bc2ae in pci_qdev_realize hw/pci/pci.c:2310
>       #13 0x5638f0bdb2f2 in virtio_pci_dc_realize hw/virtio/virtio-pci.c:=
2473
>       #14 0x5638f13ea370 in device_set_realized hw/core/qdev.c:523
>
>     SUMMARY: AddressSanitizer: heap-buffer-overflow hw/char/virtio-serial=
-bus.c:590 in set_config
>
> Fixes: d0660e5b7fc ("hw/char/virtio-serial: Do not expose the 'emergency-=
write' property")
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3303
> Buglink: https://issues.oss-fuzz.com/issues/484647006
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Tested-by: Alexander Bulekov <alxndr@bu.edu>

Thank you

> ---
>  hw/char/virtio-serial-bus.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
> index b7c57ea9678..cd234dc6db1 100644
> --- a/hw/char/virtio-serial-bus.c
> +++ b/hw/char/virtio-serial-bus.c
> @@ -1039,10 +1039,6 @@ static void virtio_serial_device_realize(DeviceSta=
te *dev, Error **errp)
>          return;
>      }
>
> -    if (!virtio_has_feature(vdev->host_features,
> -                            VIRTIO_CONSOLE_F_EMERG_WRITE)) {
> -        config_size =3D offsetof(struct virtio_console_config, emerg_wr)=
;
> -    }
>      virtio_init(vdev, VIRTIO_ID_CONSOLE, config_size);
>
>      /* Spawn a new virtio-serial bus on which the ports will ride as dev=
ices */
> --
> 2.52.0
>

