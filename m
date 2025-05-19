Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E26C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 15:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH25y-0000vA-Ba; Mon, 19 May 2025 11:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH25w-0000ul-LQ
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:08:00 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1uH25u-0002sx-On
 for qemu-devel@nongnu.org; Mon, 19 May 2025 11:08:00 -0400
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-2322bace4ceso11993195ad.2
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747667276; x=1748272076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=h4f7ThviEqoGUFcfoXPyaBHotL5yvO8ybJfBX0itN6U=;
 b=KycfuA2aT6Bjv6jbAE4HLonLSD7jZ4q0RtJjqmHyRY1TWJqYSRAfeOh+c5MVn1DJWC
 Si20IjFyk7UGlhwUpruySeMODkmVmqRIXiFSRIoRxbHzKriFUuogMujUHBo0k0F93fLh
 i2W8Ot9vej6QMj1CvOT8p7VTH3gDvpEdZ+GP0h84miaDdqjL0Ne4v1xwa17myGKo36Z4
 DBjJRxkHDX9g3I8ovb7bI7ePlFd59MDzcXMJmm/RDKQctJr0Z2NkEsUSpCbRDit9MLK6
 xyTnu7p1JBafO+8Tn7hyt2MEiun8qpiDKml8C5yx0O5sdbadjyLRPGxK2Q5mGpwiSBAV
 5z3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747667276; x=1748272076;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4f7ThviEqoGUFcfoXPyaBHotL5yvO8ybJfBX0itN6U=;
 b=lNeOrHX+BAHdxSzHrB/T83TCCWKeR1BpOywA0TzzD63ygYF21QXr5XxwUn7N3hRYXo
 8P8/q9lp+lPOhw9YVi54s4qYIPJHwPfkmwxfSrHnpV7/IEpZsBAsSlr+w/RuxdKERNdH
 YConU0Z8GqivS/vV7lXaG/gSxB1CrBXjWUKbIslcJXLRhYwryOFnVPSZXlJn9Kayq20v
 dI7XQuEjsi+7WhDVJbpObzKkLGfR/XfKWUP6dd9t8RWoC2xgZS/NfxG/XYnHX+w+VUUp
 Nm2uQvOkR9rFDE5pwLWb16WjpEynPcpireJtSNbwhZ8Vab5WVRxOcjAd/JeLx8/gRWCy
 R0HQ==
X-Gm-Message-State: AOJu0Yzaojd+/pOxCYLqd+aQoQZ6/dcMMPvADqRue+6Nlre+AHS8tLHb
 AFWpohZwdJDlvxh5gSTLcplpwo5plbouiu7dv19fWqgIg2wIoL1vasg=
X-Gm-Gg: ASbGncvgGShXhrkBHof2ADrcyF9H418nFaA9pCH39HQO+lHm7Ea5tjXuEFCoW8qbZg5
 XxQcaykWBg0YjZ+69SX9n750T9+9npuMCWXA+CglIgJz2dbuSzsVCiNszZVPiAxT9ZuBYWFWKU2
 X8AKL/WjTo7v2hkhx9q1A3UQqNhlQFnxnEsHElgquJC+r+og1Xc8dhPulIUx9TKX/l2vbY/dpRx
 9RBK6d7WDWoLe/1vwwkEBifq95iZ7yFkuZc9I6Oa0qthVnAWBUFfCKHja9WIYChHpkNaq/VyFhL
 QEPLSF9KNKScQWo6CKvm2iC/PGvVZCXwDgoONOyBWIM0Iz7CLlvUPoqQdVY=
X-Google-Smtp-Source: AGHT+IHEMbCyldF2/Z9VBe3kRExMZXFLiQB/xlRnHk20y92nj0Hd61WnorQl3C1cWD/bFOpL4iVRJg==
X-Received: by 2002:a17:903:41d0:b0:231:c86b:ff77 with SMTP id
 d9443c01a7336-231d43cd9b2mr180100275ad.26.1747667276370; 
 Mon, 19 May 2025 08:07:56 -0700 (PDT)
Received: from [192.168.0.113] ([139.227.182.131])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231e26d8395sm57601185ad.5.2025.05.19.08.07.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 May 2025 08:07:55 -0700 (PDT)
Message-ID: <9fc2ce95-0846-48ab-aecb-d79c9c1a01b2@gmail.com>
Date: Mon, 19 May 2025 23:07:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Respect x-igd-opregion=off in IGD quirk
 handling
To: "edmund.raile" <edmund.raile@protonmail.com>,
 "clg@redhat.com" <clg@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "edmund.raile@proton.me" <edmund.raile@proton.me>
References: <tgKYxqCs9bUrxIZV2h4pSnR4gEjle4oq8tKs65J8lM70PMsBpuxOPKbv0cUJLfLQdks2C-PUIBJx3kqMQ78ufP2EMEBwwjzT6FxfsZlBfcs=@protonmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
Autocrypt: addr=tomitamoeko@gmail.com; keydata=
 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
In-Reply-To: <tgKYxqCs9bUrxIZV2h4pSnR4gEjle4oq8tKs65J8lM70PMsBpuxOPKbv0cUJLfLQdks2C-PUIBJx3kqMQ78ufP2EMEBwwjzT6FxfsZlBfcs=@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x641.google.com
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

On 5/19/25 16:03, edmund.raile wrote:
> Restore SR-IOV Intel iGPU VF passthrough capability:
> Check x-igd-opregion=off parameter in vfio_pci_igd_config_quirk and
> vfio_pci_kvmgt_config_quirk to ensure x-igd-opregion=off is
> respected despite subsequent attempt of automatic
> IGD opregion detection.
> 
> Fixes: c0273e77f2d7 ("vfio/igd: Detect IGD device by OpRegion")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2968
> Signed-off-by: Edmund Raile <edmund.raile@protonmail.com>
> ---
> This patch fixes a regression in QEMU’s VFIO IGD quirk handling that
> established automatic IGD opregion detection which ignores 
> x-igd-opregion=off necessary for SR-IOV VF passthrough of
> Intel iGPUs using i915-sriov-dkms.
> 
> Please review and provide feedback.
> Let me know if additional testing or changes are needed.
> 
> Kind regards,
> Edmund Raile.

Hi, Edmund

I did a quick test with x-igd-opregion=off with c0273e77f2d7 included on
SRIOV PF, setting x-igd-opregion=off works as expected on my linux
guest. Per my understanding, SRIOV PF should not have OpRegion address
in its config space 0xfc, kernel returns -ENODEV when accessing, and
QEMU continues after vfio_pci_igd_opregion_detect() fails by returing
true. Could you please share more details about this issue?

[    0.655035] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] graphic opregion physical addr: 0x0
[    0.655490] i915 0000:00:02.0: [drm:intel_opregion_setup [i915]] ACPI OpRegion not supported!
[    0.656088] i915 0000:00:02.0: Invalid PCI ROM header signature: expecting 0xaa55, got 0x0000
[    0.656462] i915 0000:00:02.0: [drm] Failed to find VBIOS tables (VBT)

If you are mentioning the log "Device does not supports IGD OpRegion
feature", it is a false error and can be ignored I think. Maybe we can
improve this, making it more clear?

 
>  hw/vfio/igd.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index e7952d15a0..e54a2a2f00 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -523,6 +523,11 @@ static bool vfio_pci_igd_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> +    /* Respect x-igd-opregion=off by skipping OpRegion handling */
> +    if (!vdev->igd_opregion) {
> +        return true;
> +    }
> +

Here (vdev->igd_opregion == NULL) is always true, the pointer is zero-
initialized and only get assigned in vfio_pci_igd_opregion_init().
Enabling OpRegion or not is by VFIO_FEATURE_ENABLE_IGD_OPREGION bit.

>      /* IGD device always comes with OpRegion */
>      if (!vfio_pci_igd_opregion_detect(vdev, &opregion, errp)) {
>          return true;
> @@ -689,6 +694,11 @@ static bool vfio_pci_kvmgt_config_quirk(VFIOPCIDevice *vdev, Error **errp)
>          return true;
>      }
>  
> +    /* Respect x-igd-opregion=off by skipping OpRegion handling */
> +    if (!vdev->igd_opregion) {
> +        return true;
> +    }
> +

As I mentioned in a comment below, GVT-g vGPU always emulate OpRegion,
so let QEMU fail immediately if OpRegion is not avaliable here.

Thanks,
Moeko

>      /* FIXME: Cherryview is Gen8, but don't support GVT-g */
>      gen = igd_gen(vdev);
>      if (gen != 8 && gen != 9) {

