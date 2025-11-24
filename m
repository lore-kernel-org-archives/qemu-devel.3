Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF11CFA466
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:02:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVGI-0005vd-Qm; Mon, 24 Nov 2025 07:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vNVFh-0005lm-Hk
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:01:15 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangfei.gao@linaro.org>)
 id 1vNVFW-0007h5-Mt
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:00:57 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5942bac322dso3888727e87.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763985650; x=1764590450; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxcugJN4iqbUkWCXcF/hds4Q0Hkw5d2C87ToQwh/bEA=;
 b=B9oszzushFBsTWaWc9VPPia7ph+eYNAgrkjoGvMjPec+wKuNbD8VJy2CkvGboWSJI6
 +QMzEMyVtLopXTHwr4mRL6PJnazDi7ksqDoY7k3iPrApYB5oPQInjFhRduTRHW5GFx+Y
 K3PGKVUPIeoYi9P6DQ5/2o1FQUKo5bVUIeI4HcwIEfaGdGpzF5AgLVm0GlYd2lwBktFz
 bQ3mhpB1yu/cKr3xCBQvrexoKejL028JkKLcW409TOG4ULiAtcKwBSTRJtV9Ke0a5Noo
 w3hrpvOC3BRuvKl6/4ugQHJDmtYc5mWs/K8YbAqDsrgZX5HCEvr+VW1+ASLjGG1xU9JO
 fG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763985650; x=1764590450;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fxcugJN4iqbUkWCXcF/hds4Q0Hkw5d2C87ToQwh/bEA=;
 b=saNouFogd34j81mvmFoKRTTD/+2cZJlG+d1T1K1dqB+HBdGZ31sO1szFcD2aaepsUT
 7rRDuAgi3yrEAMwSP7KocVc31BReyg9ObihxVgTZCjoBpaiS1vGFp/hubQw7KnWZblNq
 cyVw5SVpOiSjOMxkT1bE6kfjZz7oL04K2e4Ycl+R6a4n0RVwBt2fucyeAhsh30pYvudy
 /qeanGwVyiw9wlNV68QANdyLb0y9xthGJ9mQkUW7bQEHJWy/7/M3iJccIArXBacTYbzv
 RwNnxWO5R2WgTWrKlEtX9MREy+4nIeCt5709o/r0xDKVNdltKLbxZO4M5urnJ+1TQPMY
 I/2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+gXtsayHao1o8LFAqnVRRpf5MTij1Lkc3NOJb+W9IKJ03FVlJGp4i4/QbDMuDrz7ogPeRKpzG8X9A@nongnu.org
X-Gm-Message-State: AOJu0Yx0l8gvM4WqaWdP/0Fz4mLJxZbPFfwafdH1Rals7CeMhCCvi2fN
 Yhi1I19O1lqGD6ZmNIn4crEnzXI5rc2rGkz/QYYDVYyGTjhFGOtoc1zy+C5fJtlML7RSs1LtFM5
 zdtSCC+4SykMzi2LVWXLj0rzPovDTk2rMDPdWy9/egg==
X-Gm-Gg: ASbGncuJjIPvPhmFLcb0n6vlGfGSRkNHE2DOlkxAVh+MGi0jQpZ/0ihQf+/X0D9NhOe
 fcbscaQBB5MrqeeD50B+k/SFMB29DbtLZP9dIyZaEbBBBSJS24QMHPfE3mHlV47Gfw9d6E0MGWg
 sFOzqm26BcvxGGAIr2hovtsM8eq+wYADAmsVoE2qzLxEFJC8v1g0rEHIOFFv1T9EJvf5CS2oBcu
 ja5xc2T90tTTCF/WfnfYyqyBpg+6kB3pQKFZ87RsfLZdrLquGOGXjxxdw9DfcFXaQ7GSWD6oJD8
 ErDbDANV1nc=
X-Google-Smtp-Source: AGHT+IFv7gFMEtQDnv1NmWpGmVYWF7dNTnkyvG1rIgB6f0KRhw1YNa/jJetR5fJQM++/pPnQCF8Q3YqBUprxH8x8mt4=
X-Received: by 2002:a05:6512:2354:b0:594:36b3:d1f9 with SMTP id
 2adb3069b0e04-596a3ec4221mr3745923e87.25.1763985649848; Mon, 24 Nov 2025
 04:00:49 -0800 (PST)
MIME-Version: 1.0
References: <20251120132213.56581-1-skolothumtho@nvidia.com>
 <20251120132213.56581-29-skolothumtho@nvidia.com>
In-Reply-To: <20251120132213.56581-29-skolothumtho@nvidia.com>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Mon, 24 Nov 2025 20:00:34 +0800
X-Gm-Features: AWmQ_bkzm1loeZ68F2GglU3pwemcmcrtJEIDA8KfwBL8G5qBxoxAIh42Y0Xoscc
Message-ID: <CABQgh9EuxEfHYOtMdCMBcaSqJZjzm2Q8Tz108jGcxcfTRpi3mA@mail.gmail.com>
Subject: Re: [PATCH v6 28/33] hw/arm/smmuv3-accel: Add support for ATS
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, eric.auger@redhat.com, 
 peter.maydell@linaro.org, jgg@nvidia.com, nicolinc@nvidia.com, 
 ddutile@redhat.com, berrange@redhat.com, nathanc@nvidia.com, mochs@nvidia.com, 
 smostafa@google.com, wangzhou1@hisilicon.com, jiangkunkun@huawei.com, 
 jonathan.cameron@huawei.com, zhenzhong.duan@intel.com, yi.l.liu@intel.com, 
 kjaju@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=zhangfei.gao@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 20 Nov 2025 at 21:25, Shameer Kolothum <skolothumtho@nvidia.com> wr=
ote:
>
> QEMU SMMUv3 does not enable ATS (Address Translation Services) by default=
.
> When accelerated mode is enabled and the host SMMUv3 supports ATS, it can
> be useful to report ATS capability to the guest so it can take advantage
> of it if the device also supports ATS.
>
> Note: ATS support cannot be reliably detected from the host SMMUv3 IDR
> registers alone, as firmware ACPI IORT tables may override them. The
> user must therefore ensure the support before enabling it.
>
> The ATS support enabled here is only relevant for vfio-pci endpoints,
> as SMMUv3 accelerated mode does not support emulated endpoint devices.
> QEMU=E2=80=99s SMMUv3 implementation still lacks support for handling ATS
> translation requests, which would be required for emulated endpoints.
>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> ---
>  hw/arm/smmuv3-accel.c    |  3 +++
>  hw/arm/smmuv3.c          | 21 ++++++++++++++++++++-
>  hw/arm/virt-acpi-build.c | 10 ++++++++--
>  include/hw/arm/smmuv3.h  |  1 +
>  4 files changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> index b6429c8b42..73c7ce586a 100644
> --- a/hw/arm/smmuv3-accel.c
> +++ b/hw/arm/smmuv3-accel.c
> @@ -647,6 +647,9 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>
>      /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled =
it */
>      s->idr[3] =3D FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
> +
> +    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-on by property */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>  }
>
>  /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT=
 */
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index 296afbe503..ad476146f6 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -1498,13 +1498,24 @@ static int smmuv3_cmdq_consume(SMMUv3State *s, Er=
ror **errp)
>               */
>              smmuv3_range_inval(bs, &cmd, SMMU_STAGE_2);
>              break;
> +        case SMMU_CMD_ATC_INV:
> +            SMMUDevice *sdev =3D smmu_find_sdev(bs, CMD_SID(&cmd));
> +
> +            if (!sdev) {
> +                break;
> +            }
> +
> +            if (!smmuv3_accel_issue_inv_cmd(s, &cmd, sdev, errp)) {
> +                cmd_error =3D SMMU_CERROR_ILL;
> +                break;
> +            }
> +            break;

got build error here, need { }

../hw/arm/smmuv3.c: In function =E2=80=98smmuv3_cmdq_consume=E2=80=99:
../hw/arm/smmuv3.c:1505:13: error: a label can only be part of a
statement and a declaration is not a statement
 1505 |             SMMUDevice *sdev =3D smmu_find_sdev(bs, CMD_SID(&cmd));
      |             ^~~~~~~~~~


Thanks

