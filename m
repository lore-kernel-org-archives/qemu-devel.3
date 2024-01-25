Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364CBC47422
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 20:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT6CE-0002EU-In; Thu, 25 Jan 2024 15:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rT6CC-0002Du-OW
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:19:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rT6CA-0007l7-R8
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:19:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706213969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PZhqRzWkL9o4AvkJMmtAt4S78YrRluM1CHjquD6nHio=;
 b=KtlV+GgTYnLSo0gaXgKAirN1SfLjb3H8DOxiZPK54wPhSSBLLwgTx6esUEU25yATPGyVNI
 0jUKDhvSpQUXoYBWld4bjsyLkt20L/VuCd4kooOtP4g8bkApJ43z0aFU2wuJwqX7NuacCr
 8YzKdg1M4IVpemFL2gorzMPzbU5H/VM=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-bK2klKrROQW6UjYoU1y5Mw-1; Thu, 25 Jan 2024 15:19:27 -0500
X-MC-Unique: bK2klKrROQW6UjYoU1y5Mw-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3618c6a1cceso61626085ab.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 12:19:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706213967; x=1706818767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZhqRzWkL9o4AvkJMmtAt4S78YrRluM1CHjquD6nHio=;
 b=mJBpwJPtC6e5LehffXgKo5gidKmHWSDm8XE+RV4fG9g8enAINUXiQsgG/unuwyNWXs
 xgFXSDRNI17fqCjEy0cvQRrO6FCDfppTcBzUWm0Ai2d8D0PokNgBLMl3kPAM4sIAJkZ8
 e3Q+N+gt6a9hRXyXUCgIcPg4nkXJ79yKi2z9MZNI6sz/wHmhPP5cv9Qkn/jNCTaq8HlF
 KzzB+VF8JAIFC++OQb70eAu/c3QYuzE6UDhIekjamfWlSfiP+3AUSykymWr/7+bm/mQc
 YXpd3g920KguMzBUQpT7IJf43/7ag3EcYXJ50c4lQxKiuSKiFf38EGt4FqrwT15VXB3u
 WC6w==
X-Gm-Message-State: AOJu0YyyeA8sen5M5rEhgJFIsJG0CBbsNMoG3jAv2ynbdp83hkc587nd
 ZF5wbpMO7L3YeR95uXdviGAQJtTVbFcLKAm8PdEmtoLE3CcSruuJXy+X1E+lcRzc/6B+N0fjmpK
 BnWTzlVHrb1lZ0FFA+LuIvbru4I4Jpp3U76vLI0XmtIeGldp4+iqT
X-Received: by 2002:a92:c604:0:b0:361:9a1f:f177 with SMTP id
 p4-20020a92c604000000b003619a1ff177mr297094ilm.34.1706213967023; 
 Thu, 25 Jan 2024 12:19:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEr1KON24pYskVmUoLzoFLTdsZmBMnqCsSebLeYctONT1y1OuqMHysQZfFBNf3TMMckacaCoA==
X-Received: by 2002:a92:c604:0:b0:361:9a1f:f177 with SMTP id
 p4-20020a92c604000000b003619a1ff177mr297083ilm.34.1706213966744; 
 Thu, 25 Jan 2024 12:19:26 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 c8-20020a056e020cc800b0036197f7f157sm3874233ilj.2.2024.01.25.12.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 12:19:26 -0800 (PST)
Date: Thu, 25 Jan 2024 13:19:24 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Jing Liu
 <jing2.liu@intel.com>
Subject: Re: [PATCH] vfio/pci: Clear MSI-X IRQ index always
Message-ID: <20240125131924.0768fead.alex.williamson@redhat.com>
In-Reply-To: <20240125144220.770725-1-clg@redhat.com>
References: <20240125144220.770725-1-clg@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 25 Jan 2024 15:42:20 +0100
C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> When doing device assignment of a physical device, MSI-X can be
> enabled with no vectors enabled and this sets the IRQ index to
> VFIO_PCI_MSIX_IRQ_INDEX. However, when MSI-X is disabled, the IRQ
> index is left untouched if no vectors are in use. Then, when INTx
> is enabled, the IRQ index value is considered incompatible (set to
> MSI-X) and VFIO_DEVICE_SET_IRQS fails. QEMU complains with :
>=20
> qemu-system-x86_64: vfio 0000:08:00.0: Failed to set up TRIGGER eventfd s=
ignaling for interrupt INTX-0: VFIO_DEVICE_SET_IRQS failure: Invalid argume=
nt
>=20
> To avoid that, unconditionaly clear the IRQ index when MSI-X is
> disabled.
>=20
> Buglink: https://issues.redhat.com/browse/RHEL-21293
> Fixes: 5ebffa4e87e7 ("vfio/pci: use an invalid fd to enable MSI-X")
> Cc: Jing Liu <jing2.liu@intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  hw/vfio/pci.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index d7fe06715c4b9cde66a68c31aaf405315921b0d6..4fa387f0430d62ca2ba1b5ae5=
b7037f8f06b33f9 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -826,9 +826,11 @@ static void vfio_msix_disable(VFIOPCIDevice *vdev)
>          }
>      }
> =20
> -    if (vdev->nr_vectors) {
> -        vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
> -    }
> +    /*
> +     * Always clear MSI-X IRQ index. A PF device could have enabled
> +     * MSI-X with no vectors. See vfio_msix_enable().
> +     */
> +    vfio_disable_irqindex(&vdev->vbasedev, VFIO_PCI_MSIX_IRQ_INDEX);
> =20
>      vfio_msi_disable_common(vdev);
>      vfio_intx_enable(vdev, &err);

LGTM, at worst the SET_IRQS ioctl return an errno if we try to disable
an unconfigured interrupt index, so seems safe to call unconditionally
here.

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


