Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD64C0219B
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 21:27:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg9Of-0008Lz-Vo; Thu, 06 Feb 2025 16:26:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tg9Od-0008Li-QY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tg9Ob-0005Se-Ua
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 16:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738877207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yshrcejjyNmqyKOzNProobYlBSYAWkwkJerdzyfNPPw=;
 b=ExpaUnEB/Rmt3e0jdQpYCJ8qEpJoCHPvRBz2DXcm7iYMdtbboZEEywb4QHFM1F7QOWh4nd
 mJJ9wJ8ECr7IPxaAbSADhbdiPb2ilVGC5pms+NPA2hFW44GVHqNQ15dLu1Z5NcA/bbx8Qm
 pXmn9x6o6JN5XCIt2+8oWJC0N6mIvP8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-0sIt7lLEPcyXJ_ObIM63JQ-1; Thu, 06 Feb 2025 16:26:45 -0500
X-MC-Unique: 0sIt7lLEPcyXJ_ObIM63JQ-1
X-Mimecast-MFC-AGG-ID: 0sIt7lLEPcyXJ_ObIM63JQ
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-84f54d63095so20114139f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 13:26:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738877205; x=1739482005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yshrcejjyNmqyKOzNProobYlBSYAWkwkJerdzyfNPPw=;
 b=rN79h5enM6hQo0J/keaNZheQP6vneNaiYNjlYiUVS294vl3T1YOVfrJjUDQ2VqjiUF
 P4zDibl1/SQeza/IQWTD8klFamLFZ2AcQjkjVwl54Dns7f6AvmuyIGiszomIkzx+jTwG
 C+6xSmNtfWjPmTRSl+utqW+Qt7bXBEdlyYv9ag4loEhOgFFfXy2+a/wtgm6dtd92P4Fl
 T6h7q2aoKVQxhHMNhcSSvsueN/nWLSutAVvrfXgHavw/j+EpDTL51wxg4YjzzPlfUGHP
 r+xuuqD2YwIRjqXXovRKMcMjKMN+XB6qvLML91a6WoVPP+0Fitmv60u79tT8KUyvn8j3
 dcuQ==
X-Gm-Message-State: AOJu0YyekIsjSx/icpNUGbQDV3059hNNZDJsGS63c73hAoEk55pqt6kB
 idP5BUOwBO0PPxbZ3J87LLpKKDAbT+5u9Ea+eSp45VtcGb+LgNE+7lE4EX2ztiHokaBVuPBRUdd
 kuLNKH7nauObmiNIksYRae0e+sbddpfghMhgSTJEGBWlc9UEDa4dT
X-Gm-Gg: ASbGncsus21m7wDpMp7QZRGLJg1djPU89Ie81buGwAbceG0/00us9hv94Lh7iq+VpVw
 Lxq/vTwJYS1ynjEzBjW+uN3RRiNVgjl1Xf9BtgeOjBjZBTLozKrzprIDK5PsvWlT1pPFhm6sNyc
 hu+MB/ND92Q5y/hZM2GCfqonm/1sqqUbpIXdubidnK3BhPyyqKEDCQ30N0uVEhwfDx8VwPVylJL
 slq68nyu1tz2nay+OXTLjrDYhBk53EXcnEtlou0sdBMMu1d3iVuLRQqV2/CjOLk1JsWuGzqHISf
 P7mRUpjF
X-Received: by 2002:a05:6602:4811:b0:847:51e2:eae with SMTP id
 ca18e2360f4ac-854fd97c514mr31703439f.5.1738877204830; 
 Thu, 06 Feb 2025 13:26:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQ/N6eeNi4Rdqpsy3+AxqrdP3tg/ihOsCTwVL+s61IFyaWMDVS/pExupilnfdca5tWWrumng==
X-Received: by 2002:a05:6602:4811:b0:847:51e2:eae with SMTP id
 ca18e2360f4ac-854fd97c514mr31702639f.5.1738877204421; 
 Thu, 06 Feb 2025 13:26:44 -0800 (PST)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccf9e3e26sm434556173.46.2025.02.06.13.26.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 13:26:43 -0800 (PST)
Date: Thu, 6 Feb 2025 14:26:41 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Corvin =?UTF-8?B?S8O2aG5l?= <corvin.koehne@gmail.com>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Corvin
 =?UTF-8?B?S8O2aG5l?= <c.koehne@beckhoff.com>
Subject: Re: [PATCH 3/4] vfio/igd: use PCI ID defines to detect IGD gen
Message-ID: <20250206142641.2acb7ab1.alex.williamson@redhat.com>
In-Reply-To: <20250206121341.118337-4-corvin.koehne@gmail.com>
References: <20250206121341.118337-1-corvin.koehne@gmail.com>
 <20250206121341.118337-4-corvin.koehne@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu,  6 Feb 2025 13:13:39 +0100
Corvin K=C3=B6hne <corvin.koehne@gmail.com> wrote:

> From: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
>=20
> We've recently imported the PCI ID list of knwon Intel GPU devices from
> Linux. It allows us to properly match GPUs to their generation without
> maintaining an own list of PCI IDs.
>=20
> Signed-off-by: Corvin K=C3=B6hne <c.koehne@beckhoff.com>
> ---
>  hw/vfio/igd.c | 77 ++++++++++++++++++++++++++++-----------------------
>  1 file changed, 42 insertions(+), 35 deletions(-)
>=20
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 0740a5dd8c..e5d7006ce2 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -18,6 +18,7 @@
>  #include "hw/hw.h"
>  #include "hw/nvram/fw_cfg.h"
>  #include "pci.h"
> +#include "standard-headers/drm/intel/pciids.h"
>  #include "trace.h"
> =20
>  /*
> @@ -51,6 +52,42 @@
>   * headless setup is desired, the OpRegion gets in the way of that.
>   */
> =20
> +struct igd_device {
> +    const uint32_t device_id;
> +    const int gen;
> +};
> +
> +#define IGD_DEVICE(_id, _gen) { \
> +    .device_id =3D (_id), \
> +    .gen =3D (_gen), \
> +}
> +
> +static const struct igd_device igd_devices[] =3D {
> +    INTEL_SNB_IDS(IGD_DEVICE, 6),
> +    INTEL_IVB_IDS(IGD_DEVICE, 6),
> +    INTEL_HSW_IDS(IGD_DEVICE, 7),
> +    INTEL_VLV_IDS(IGD_DEVICE, 7),
> +    INTEL_BDW_IDS(IGD_DEVICE, 8),
> +    INTEL_CHV_IDS(IGD_DEVICE, 8),
> +    INTEL_SKL_IDS(IGD_DEVICE, 9),
> +    INTEL_BXT_IDS(IGD_DEVICE, 9),
> +    INTEL_KBL_IDS(IGD_DEVICE, 9),
> +    INTEL_CFL_IDS(IGD_DEVICE, 9),
> +    INTEL_CML_IDS(IGD_DEVICE, 9),
> +    INTEL_GLK_IDS(IGD_DEVICE, 9),
> +    INTEL_ICL_IDS(IGD_DEVICE, 11),
> +    INTEL_EHL_IDS(IGD_DEVICE, 11),
> +    INTEL_JSL_IDS(IGD_DEVICE, 11),
> +    INTEL_TGL_IDS(IGD_DEVICE, 12),
> +    INTEL_RKL_IDS(IGD_DEVICE, 12),
> +    INTEL_ADLS_IDS(IGD_DEVICE, 12),
> +    INTEL_ADLP_IDS(IGD_DEVICE, 12),
> +    INTEL_ADLN_IDS(IGD_DEVICE, 12),
> +    INTEL_RPLS_IDS(IGD_DEVICE, 12),
> +    INTEL_RPLU_IDS(IGD_DEVICE, 12),
> +    INTEL_RPLP_IDS(IGD_DEVICE, 12),
> +};

I agree with Connie's comment on the ordering and content of the first
two patches.

For these last two, I wish these actually made it substantially easier
to synchronize with upstream.  Based on the next patch, I think it
still requires manually tracking/parsing internal code in the i915
driver to extract generation information.

Is it possible that we could split the above into a separate file
that's auto-generated from a script?  For example maybe some scripting
and C code that can instantiate the pciidlist array from i915_pci.c and
regurgitate it into a device-id/generation table?  Thanks,

Alex

> +
>  /*
>   * This presumes the device is already known to be an Intel VGA device, =
so we
>   * take liberties in which device ID bits match which generation.  This =
should
> @@ -60,42 +97,12 @@
>   */
>  static int igd_gen(VFIOPCIDevice *vdev)
>  {
> -    /*
> -     * Device IDs for Broxton/Apollo Lake are 0x0a84, 0x1a84, 0x1a85, 0x=
5a84
> -     * and 0x5a85, match bit 11:1 here
> -     * Prefix 0x0a is taken by Haswell, this rule should be matched firs=
t.
> -     */
> -    if ((vdev->device_id & 0xffe) =3D=3D 0xa84) {
> -        return 9;
> -    }
> +    for (int i =3D 0; i < ARRAY_SIZE(igd_devices); i++) {
> +        if (igd_devices[i].device_id !=3D vdev->device_id) {
> +            continue;
> +        }
> =20
> -    switch (vdev->device_id & 0xff00) {
> -    case 0x0100:    /* SandyBridge, IvyBridge */
> -        return 6;
> -    case 0x0400:    /* Haswell */
> -    case 0x0a00:    /* Haswell */
> -    case 0x0c00:    /* Haswell */
> -    case 0x0d00:    /* Haswell */
> -    case 0x0f00:    /* Valleyview/Bay Trail */
> -        return 7;
> -    case 0x1600:    /* Broadwell */
> -    case 0x2200:    /* Cherryview */
> -        return 8;
> -    case 0x1900:    /* Skylake */
> -    case 0x3100:    /* Gemini Lake */
> -    case 0x5900:    /* Kaby Lake */
> -    case 0x3e00:    /* Coffee Lake */
> -    case 0x9B00:    /* Comet Lake */
> -        return 9;
> -    case 0x8A00:    /* Ice Lake */
> -    case 0x4500:    /* Elkhart Lake */
> -    case 0x4E00:    /* Jasper Lake */
> -        return 11;
> -    case 0x9A00:    /* Tiger Lake */
> -    case 0x4C00:    /* Rocket Lake */
> -    case 0x4600:    /* Alder Lake */
> -    case 0xA700:    /* Raptor Lake */
> -        return 12;
> +        return igd_devices[i].gen;
>      }
> =20
>      /*


