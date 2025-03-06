Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B07C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:37:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJph-0000K9-R2; Thu, 06 Mar 2025 17:36:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqJpg-0000Jz-D8
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:36:48 -0500
Received: from nyc.source.kernel.org ([147.75.193.91])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mchehab+huawei@kernel.org>)
 id 1tqJpd-0002qY-Op
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:36:48 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id AD77FA439AD;
 Thu,  6 Mar 2025 22:31:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEFA0C4CEE0;
 Thu,  6 Mar 2025 22:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741300597;
 bh=gt1AQ5QtPCkUd+YdNm+NOU/MJtxuM4Mjf0w6vyoQrkU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=CXG2zHEyOhFh8VjOTwjNt/ho+PFB9w8J32hjPfTPEizh+5+lOl9L4JY3cl3h0V9cO
 FuAtZOQ0gaflJANBGFUSqKd1y7s4R0t+SgNB+88yMT5lp80/+rShnYk383AArq93qP
 RN3C3KLCuM1azD7igj2A2d5Qpt1nIBVvi4fwWN4g7mcIJEvS5zBWl0FTK4CEGH33/W
 zwD1nLiZ0OadJP1tnTfz03qgt5c73WT90cPCtpCL2MSLLTrjknytksvXs5HTC+zfuk
 iBKAfQdNw9AXxPGO0McGV2R6vX6+Nk9ydrkaIDe+yIx40qgjcDicPvtPDL4nLT2O21
 C7Ev3b/XQCBiA==
Date: Thu, 6 Mar 2025 23:36:32 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Gavin Shan <gshan@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PULL 11/41] hw/acpi/ghes: Make ghes_record_cper_errors() static
Message-ID: <20250306233632.5b22e382@foz.lan>
In-Reply-To: <20250305012157.96463-12-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
 <20250305012157.96463-12-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=147.75.193.91;
 envelope-from=mchehab+huawei@kernel.org; helo=nyc.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Em Wed,  5 Mar 2025 02:21:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> escreveu:

> From: Gavin Shan <gshan@redhat.com>
>=20
> acpi_ghes_memory_errors() is the only caller, no need to expose
> the function. Besides, the last 'return' in this function isn't
> necessary and remove it.
>=20
> No functional changes intended.

Please revert this patch, as ghes_record_cper_errors() was written
to be used for error injection. As agreed last year with some ACPI
maintainers, we ended splitting the error injection series on two parts
to make easier for people to review it.

The followup series:

	https://lore.kernel.org/qemu-devel/cover.1740903110.git.mchehab+huawei@ker=
nel.org/

Need this function to be not static, as this will be used by a
QMP caller.

The usage itself is on this patch:

	https://lore.kernel.org/qemu-devel/6ef8d6a3f42e3347ed6fd3d1fc29ab5ff2a070d=
f.1740903110.git.mchehab+huawei@kernel.org/

but this one causes conflict since patch 01 of the series.

Regards,
Mauro


>=20
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Message-ID: <20250214041635.608012-2-gshan@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  include/hw/acpi/ghes.h | 2 --
>  hw/acpi/ghes.c         | 6 ++----
>  2 files changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 39619a2457c..578a582203c 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -75,8 +75,6 @@ void acpi_build_hest(GArray *table_data, GArray *hardwa=
re_errors,
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *vms, FWCfgState *s,
>                            GArray *hardware_errors);
>  int acpi_ghes_memory_errors(uint16_t source_id, uint64_t error_physical_=
addr);
> -void ghes_record_cper_errors(const void *cper, size_t len,
> -                             uint16_t source_id, Error **errp);
> =20
>  /**
>   * acpi_ghes_present: Report whether ACPI GHES table is present
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index b709c177cde..b85bb48195a 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -390,8 +390,8 @@ static void get_hw_error_offsets(uint64_t ghes_addr,
>      *read_ack_register_addr =3D ghes_addr + sizeof(uint64_t);
>  }
> =20
> -void ghes_record_cper_errors(const void *cper, size_t len,
> -                             uint16_t source_id, Error **errp)
> +static void ghes_record_cper_errors(const void *cper, size_t len,
> +                                    uint16_t source_id, Error **errp)
>  {
>      uint64_t cper_addr =3D 0, read_ack_register_addr =3D 0, read_ack_reg=
ister;
>      AcpiGedState *acpi_ged_state;
> @@ -440,8 +440,6 @@ void ghes_record_cper_errors(const void *cper, size_t=
 len,
> =20
>      /* Write the generic error data entry into guest memory */
>      cpu_physical_memory_write(cper_addr, cper, len);
> -
> -    return;
>  }
> =20
>  int acpi_ghes_memory_errors(uint16_t source_id, uint64_t physical_addres=
s)



Thanks,
Mauro

