Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544D606A327
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2026 15:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eQvJbkuY;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=RH3obJsb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xOGNV-0003k6-Qd; Tue, 03 Nov 2026 10:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xOGNU-0003jd-9Q
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcalifano@redhat.com>)
 id 1xOGNP-0002as-EM
 for qemu-devel@nongnu.org; Tue, 03 Nov 2026 10:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793719481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xv5+6KS08xXhkwW11KvsQ4nFj8MchAht2sMtnAEMg2Y=;
 b=eQvJbkuYjE6dk26wNlBiefwJTPvaRTy/+fxYspm0T6kL2/fMi/fFFgwwuN/Z1DkbB8OyHl
 cDnjnTK1O7v6QViEQU612RhYIAXoH5eEUnaRkK+DP9gdUsPvYKbO6jKGmnGQxe1zyGieyk
 851lNwFO5bpfbxvOl9Bd9KYqGg8bmIw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-5xa6P2wyO0qg1iF32_hUHQ-1; Tue, 03 Nov 2026 10:24:40 -0500
X-MC-Unique: 5xa6P2wyO0qg1iF32_hUHQ-1
X-Mimecast-MFC-AGG-ID: 5xa6P2wyO0qg1iF32_hUHQ_1793719479
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-48e0fc747a7so3577950f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2026 07:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793719479; x=1794324279; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Xv5+6KS08xXhkwW11KvsQ4nFj8MchAht2sMtnAEMg2Y=;
 b=RH3obJsbDvJgybAWAT6PyzmPUyw8VntiXPsfR9rpcYnMUib5/DeI7x9eYwlK6whpLg
 NDLqEC2FBDznBU43RjiTtU7xBQQ5O/oEXITIbe1xlTnZXjwmB6MOgk+I9TGLpU8NZ7LJ
 aFI9fbUKzrAFxuTqQyqUiQBgmrVRSkrCdyOR37sJWssEwGPBTy81CAt5DrmORpqnyPWE
 kEDqV3/Kbj5JCNwJbdO1XwtSloV9Fk/vIw8yjzyG/267530oaLxhG7HZEqNPNxBO36Hx
 mfSXKWD+46/2Z11KES0UOrLJfSOPZHT8hUUkm5aL6Op+7Vm+mCIFGXFj8LPBC3pGZOf9
 kFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793719479; x=1794324279;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Xv5+6KS08xXhkwW11KvsQ4nFj8MchAht2sMtnAEMg2Y=;
 b=FMz7O7aaGufG6o11n3hELHcRe3nOy4IygNE2vQK+LA67A34NylqzcU8PibZ5Bfd4zj
 zPR/etRAQOh8mL3zXxsNSzD7xMbMK59lxSkm0aJrFeoVWQRIK8JnR0Rt4hfU7kgXZI0d
 4b9EpEAxRnxIClNfxHn16y686KdTBSmIf6cZQc0vSrn2fOXalfsuO95hW/r6RLgfAq9B
 42RoZHygluNXX25hFehjHT7OqT8Lqq4O3NtnBIfFdC5uIWHWQ5s6/zd7Axvu6t8qo6oU
 9CkM8SOxLZOesnbDfWHnyWC38mCoZbwdSkaI3WRlnxnc+IQ/oFPXqzVnBiQ0Qne9hMul
 jnbQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3wb9Z0pQrb6SPwBnEacmDaqEs03hF/4pY8WP+i2ORWopMdvLG84Cp4dbeUz+CprXExG9Ym5ByhFTt@nongnu.org
X-Gm-Message-State: APuU4Z90pMz3umNabTmNNOgIc3DVn9R4sgjgak73I2pLymdpQn6Z1Zbb
 vrNkAl+lr2IoO9XIde5ozCaT/i5XTJd6c3jRuq7e9L7MyY/WsNNusKRpBWWip7W0NVUaz7nYuX5
 3A3WlylyX8eFzwFkdaEj6yvdmKrYvDrjUayKMvNK6zCc34ygEa5Icfjow
X-Gm-Gg: AYBFou3T8AifQvIaBj0XAr3GFZaeoaXbkNzSZXQwXgIekldlZrAnUdTKdq9lVVvSy+C
 LR97Wj4lmGLh23TptB9sTyqRB30bo7bKrHAb5OKGqg8MJoinYOhhu9Xh/+NdXq4AVKoNBnPexIj
 x+zevm+SYaW8kmBTKceALVSrx9C2dzPYJwTXQhCteRiOB4VkdUPcV5+DRx6AswCnjh8D3nKw9lC
 v/4/g+wFbkF61ALkcg9RcjfOSYMECIvq1MBOuneT7c968gChtL8RkN8gUSn4akwgicX3BB7/N+r
 KttwRVy92jiRVn0D3A3JlGIaAMsNgr+iVe5tiHoO4Vp8D8702pWr+ZNF9ZEF5cm+SInkeZGXIXl
 YgZ+xURcAul4Eb9RzyxBAU0hzAC32q96Y86Y=
X-Received: by 2002:a05:6000:4021:b0:48e:4300:c70e with SMTP id
 ffacd0b85a97d-48e6e304059mr28974629f8f.46.1793719478744; 
 Tue, 03 Nov 2026 07:24:38 -0800 (PST)
X-Received: by 2002:a05:6000:4021:b0:48e:4300:c70e with SMTP id
 ffacd0b85a97d-48e6e304059mr28974578f8f.46.1793719478219; 
 Tue, 03 Nov 2026 07:24:38 -0800 (PST)
Received: from localhost ([213.175.37.14]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e7a1d9d71sm20300171f8f.48.2026.11.03.07.24.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2026 07:24:37 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 16:24:36 +0100
Message-Id: <DMLOHJM9LAT0.2367RNILQXXIQ@redhat.com>
Cc: <thuth@redhat.com>, <jamin_lin@aspeedtech.com>,
 <philmd@oss.qualcomm.com>, <clg@redhat.com>, <peter.maydell@linaro.org>,
 <kraxel@redhat.com>, <marcandre.lureau@redhat.com>, <farosas@suse.de>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>,
 <qemu-devel-bounces+tcalifano=redhat.com@nongnu.org>
Subject: Re: [PATCH 2/2] tests/qtest/usb-hcd-ehci: test descriptor reads
 that fail
From: "Tommaso Califano" <tcalifano@redhat.com>
To: "Junjie Cao" <junjie.cao@linux.dev>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.22.0
References: <20261103123350.1253202-1-junjie.cao@linux.dev>
 <20261103123350.1253202-3-junjie.cao@linux.dev>
In-Reply-To: <20261103123350.1253202-3-junjie.cao@linux.dev>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=tcalifano@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue Nov 3, 2026 at 1:33 PM CET, Junjie Cao wrote:
> Run the async schedule into an unreadable list head, into a head QH
> whose horizontal link is unreadable and into a QH whose next qTD is
> unreadable, and the periodic schedule into an unreadable siTD.  Each
> must raise HSE, clear Run/Stop and leave the controller halted with
> both schedules idle on the following frames; before the previous patch
> QEMU aborted there.  A reset afterwards must bring the controller back.
>
> Signed-off-by: Junjie Cao <junjie.cao@linux.dev>

I'm not very familiar with qtest, but this LGTM.

Reviewed-by: Tommaso Califano <tcalifano@redhat.com>

Regards,
Tommaso

> ---
>  tests/qtest/usb-hcd-ehci-test.c | 119 ++++++++++++++++++++++++++++++++
>  1 file changed, 119 insertions(+)
>
> diff --git a/tests/qtest/usb-hcd-ehci-test.c b/tests/qtest/usb-hcd-ehci-t=
est.c
> index 87e37cdd7c..b0a0b6df9b 100644
> --- a/tests/qtest/usb-hcd-ehci-test.c
> +++ b/tests/qtest/usb-hcd-ehci-test.c
> @@ -12,6 +12,7 @@
>  #include "libqos/pci-pc.h"
>  #include "hw/usb/uhci-regs.h"
>  #include "hw/usb/ehci-regs.h"
> +#include "hw/usb/hcd-ehci.h"
>  #include "libqos/usb.h"
> =20
>  static QPCIBus *pcibus;
> @@ -142,6 +143,123 @@ static void pci_ehci_port_hotplug(void)
>      usb_test_hotplug(global_qtest, "ich9-ehci-1", "3", pci_ehci_port_3_h=
otplug);
>  }
> =20
> +/* operational registers, relative to the BAR */
> +#define EHCI_USBCMD             0x20
> +#define EHCI_USBSTS             0x24
> +#define EHCI_PERIODICLISTBASE   0x34
> +#define EHCI_ASYNCLISTADDR      0x38
> +
> +#define NLPTR_TYPE_QH           (1 << 1)
> +#define NLPTR_TYPE_SITD         (2 << 1)
> +#define NLPTR_T                 1
> +
> +#define QH_ADDR                 0x100000    /* in the default 128 MiB of=
 RAM */
> +#define FRAME_LIST_ADDR         0x101000
> +#define BAD_ADDR                0x40000000  /* above RAM, nothing mapped=
 */
> +#define FRAME_NS                1000000
> +
> +static uint32_t ehci_readl(uint32_t off)
> +{
> +    return qpci_io_readl(ehci1.dev, ehci1.bar, off);
> +}
> +
> +static void ehci_writel(uint32_t off, uint32_t val)
> +{
> +    qpci_io_writel(ehci1.dev, ehci1.bar, off, val);
> +}
> +
> +static void ehci_hcreset(void)
> +{
> +    ehci_writel(EHCI_USBCMD, USBCMD_HCRESET);
> +    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_HCRESET, =3D=3D, 0)=
;
> +    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & USBSTS_HALT, =3D=3D, USBST=
S_HALT);
> +}
> +
> +static void ehci_write_qh(uint32_t next, uint32_t next_qtd)
> +{
> +    uint32_t qh[16] =3D {
> +        next,
> +        QH_EPCHAR_H | (64 << QH_EPCHAR_MPLEN_SH) |
> +            (EHCI_QH_EPS_HIGH << QH_EPCHAR_EPS_SH),
> +        1 << QH_EPCAP_MULT_SH,
> +        0,                                      /* current qTD */
> +        next_qtd,
> +        NLPTR_T,                                /* alternate next qTD */
> +        0,                                      /* token: inactive */
> +    };
> +
> +    memwrite(QH_ADDR, qh, sizeof(qh));
> +}
> +
> +/* Run a schedule into a descriptor that cannot be read. */
> +static void ehci_run_into_dma_error(uint32_t usbcmd)
> +{
> +    uint32_t sts;
> +    int i;
> +
> +    ehci_writel(EHCI_USBCMD, usbcmd);
> +    for (i =3D 0; i < 16; i++) {
> +        clock_step(FRAME_NS);
> +        if (ehci_readl(EHCI_USBSTS) & USBSTS_HSE) {
> +            break;
> +        }
> +    }
> +    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & USBSTS_HSE, =3D=3D, USBSTS=
_HSE);
> +    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_RUNSTOP, =3D=3D, 0)=
;
> +
> +    for (i =3D 0; i < 4; i++) {
> +        clock_step(FRAME_NS);
> +    }
> +    sts =3D ehci_readl(EHCI_USBSTS);
> +    g_assert_cmphex(sts & USBSTS_HALT, =3D=3D, USBSTS_HALT);
> +    g_assert_cmphex(sts & (USBSTS_ASS | USBSTS_PSS), =3D=3D, 0);
> +
> +    /* a reset must bring the controller back */
> +    ehci_hcreset();
> +    ehci_write_qh(QH_ADDR | NLPTR_TYPE_QH, NLPTR_T);
> +    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
> +    ehci_writel(EHCI_USBCMD, USBCMD_RUNSTOP | USBCMD_ASE);
> +    for (i =3D 0; i < 4; i++) {
> +        clock_step(FRAME_NS);
> +    }
> +    g_assert_cmphex(ehci_readl(EHCI_USBSTS) & (USBSTS_HSE | USBSTS_HALT)=
,
> +                    =3D=3D, 0);
> +    g_assert_cmphex(ehci_readl(EHCI_USBCMD) & USBCMD_RUNSTOP, =3D=3D,
> +                    USBCMD_RUNSTOP);
> +    ehci_hcreset();
> +}
> +
> +static void pci_ehci_dma_error(void)
> +{
> +    uint32_t entries[32];
> +    int i;
> +
> +    g_assert(pcibus !=3D NULL);
> +    ehci_hcreset();
> +
> +    /* async schedule: the list head itself is unreadable */
> +    ehci_writel(EHCI_ASYNCLISTADDR, BAD_ADDR);
> +    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
> +
> +    /* async schedule: the head QH links to an unreadable QH */
> +    ehci_write_qh(BAD_ADDR | NLPTR_TYPE_QH, NLPTR_T);
> +    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
> +    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
> +
> +    /* async schedule: a readable QH points at an unreadable qTD */
> +    ehci_write_qh(QH_ADDR | NLPTR_TYPE_QH, BAD_ADDR);
> +    ehci_writel(EHCI_ASYNCLISTADDR, QH_ADDR);
> +    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_ASE);
> +
> +    /* periodic schedule: the frame list points at an unreadable siTD */
> +    for (i =3D 0; i < ARRAY_SIZE(entries); i++) {
> +        entries[i] =3D BAD_ADDR | NLPTR_TYPE_SITD;
> +    }
> +    memwrite(FRAME_LIST_ADDR, entries, sizeof(entries));
> +    ehci_writel(EHCI_PERIODICLISTBASE, FRAME_LIST_ADDR);
> +    ehci_run_into_dma_error(USBCMD_RUNSTOP | USBCMD_PSE);
> +}
> +
> =20
>  int main(int argc, char **argv)
>  {
> @@ -160,6 +278,7 @@ int main(int argc, char **argv)
>      qtest_add_func("/ehci/pci/uhci-port-2", pci_uhci_port_2);
>      qtest_add_func("/ehci/pci/ehci-port-2", pci_ehci_port_2);
>      qtest_add_func("/ehci/pci/ehci-port-3-hotplug", pci_ehci_port_hotplu=
g);
> +    qtest_add_func("/ehci/pci/ehci-dma-error", pci_ehci_dma_error);
> =20
>      qtest_start("-machine q35 -device ich9-usb-ehci1,bus=3Dpcie.0,addr=
=3D1d.7,"
>                  "multifunction=3Don,id=3Dich9-ehci-1 "



