Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E39C83F1A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 12:02:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaCSJ-0006qE-2o; Fri, 11 Jul 2025 08:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCRr-0006Ud-O6
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:01:51 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uaCRn-0007SY-Bz
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 08:01:50 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2ef60dbaefbso1246622fac.1
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 05:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752235304; x=1752840104; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOXFH8R5r6PmAPMFgeOuloxTzLukrLX0Fs3plxk4ffk=;
 b=cHnFy3UUVmNUiE+0PpNqzg3rfghZNXWsBugr2RP7R7d3xsaELVmsTYY9yzSUaqpSTA
 YhyzUN4lDmqKtBnTyCfkrTobQg88+uYipkxIM0LtwhJJ6KmiRXR5yuf3EZpYimZxGGVJ
 lMa4iBObEcCPpHmdRvWTkI3lV5izcf40Q7J7W0b0nnqPd5Evwo7qqtDShOJx7WdW4T9p
 rgyMtgaof7tTD9VpccLFN9FNFhjotQHPAuL/XfxBrrcr2KRfsXUnh+qC5guaZzECS0Bq
 a1ePFdc9tdbxlE8HCuZaNn8o2cU7fbsRqLUkIqdDXCQlaWCyxgP/RJXgkBc21HKL6V9E
 eZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752235304; x=1752840104;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xOXFH8R5r6PmAPMFgeOuloxTzLukrLX0Fs3plxk4ffk=;
 b=MHB/gWnqYxjvIbsezbrZHys3PWHSdl4h16hTN9fWHcwzhZMYQJzyXjhWHQWMjxKjIz
 qKLCTM4LQiX5o8vKwxs3Lq64sX7aM7dEd/rN3YiyFj3y9reXwKcywOuvLt8xtGXIHSeK
 NgQpC9jov+l5/TNaXD0ennjyCGHtbQHrR27PMgtt2vsP4IaI2GESiJY4v16K43cVWwJ+
 e74Fxl6rYMeV7B3BDejd7JMP5IbXypOtSdmE9K8MkofIkRl81TvFrbi+c0UnorlNRAOQ
 +Mk3JPBO3dCsTO8xCOLhUuVMC/U4t6Qb2W4vq0nNB+6DMhr5DCf8uIrHtUY18SKa6nqi
 LVwQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb3z4axDHBTDzZhLI1AQh1OAtsdROULHbXojG9Pr3eVz/jI3K0JfSO3250Vd5Dn97/bWJKOfGTEPoZ@nongnu.org
X-Gm-Message-State: AOJu0Yxffjc9YCq8WME9hANsb4O4Aey+HziK3Wa4Khqxf9Aj0pK/DoXK
 o0aewg4pRVlIP96KcElkKsAR8LXbMahQJ4DKRvhDJ/YZ4lcUxdCXvbep92oA7X1oZaneYPjgYfb
 +QC08X/twRZapwsP0DuRLOSZeSE8GdAzbAp9XjIy2aQ==
X-Gm-Gg: ASbGncv2B7ZwnEop3CSr+Q3liqbdbg71C6en5CwariSjrWb21Jp0TM2g0Hbqk42D9OX
 gOGsUL9u8Lx+LWFgVqEPxMw1WRZjU9V6nFSqIFfWIyut4s9K7HYRg2c91fyjwi4OWDHKyFZeEXW
 IM/44BXVxxUbr29ZKOzP6q7THLvAT9e5SPTebJO28UzGDQpnCOpMZbBh/EwqisEXsgU7aryYux2
 8WMfEhk
X-Google-Smtp-Source: AGHT+IE5qU2yZFX1QfUGAGuaD+l/F5NaHns3TDaYMvyKdHOgDiVqsV4s2G6GoGc7UgoXgsDoJ2Vf06Xun6cG7ICpbkY=
X-Received: by 2002:a05:6870:6b8c:b0:296:b0d8:9025 with SMTP id
 586e51a60fabf-2ff26929eebmr1846965fac.20.1752235304456; Fri, 11 Jul 2025
 05:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250704083723.1410455-1-clg@redhat.com>
 <20250704083723.1410455-10-clg@redhat.com>
In-Reply-To: <20250704083723.1410455-10-clg@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jul 2025 13:01:32 +0100
X-Gm-Features: Ac12FXyCvtlUz3k6iOexX9mZzdoccOo0JKRc5ZhQKr8zYPOroWONcEv7cN15PLY
Message-ID: <CAFEAcA9-wpDS2_4paQgswqB=NfgxadvGB8WULWGqQXV7d47-Mg@mail.gmail.com>
Subject: Re: [PULL 09/11] docs: add support for gb200-bmc
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ed Tanous <etanous@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 4 Jul 2025 at 09:39, C=C3=A9dric Le Goater <clg@redhat.com> wrote:
>
> From: Ed Tanous <etanous@nvidia.com>
>
> This patch updates the docs for support of gb200-bmc.
>
> Signed-off-by: Ed Tanous <etanous@nvidia.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>
> Link: https://lore.kernel.org/qemu-devel/20250703144249.3348879-3-etanous=
@nvidia.com
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>
> ---
>  docs/system/arm/aspeed.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 43d27d83cb54..bec0a1dfa8b8 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -1,5 +1,4 @@
> -Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``,=
 ``bletchley-bmc``, ``fuji-bmc``, ``fby35-bmc``, ``fp5280g2-bmc``, ``g220a-=
bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-firework-bmc``, ``q=
uanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``sonorapass-bmc``, ``s=
upermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass-bmc``, ``withersp=
oon-bmc``, ``yosemitev2-bmc``)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Aspeed family boards (``ast2500-evb``, ``ast2600-evb``, ``ast2700-evb``,=
 ``bletchley-bmc``, ``fuji-bmc``, ``gb200nvl-bmc``, ``fby35-bmc``, ``fp5280=
g2-bmc``, ``g220a-bmc``, ``palmetto-bmc``, ``qcom-dc-scm-v1-bmc``, ``qcom-f=
irework-bmc``, ``quanta-q71l-bmc``, ``rainier-bmc``, ``romulus-bmc``, ``son=
orapass-bmc``, ``supermicrox11-bmc``, ``supermicrox11spi-bmc``, ``tiogapass=
-bmc``, ``witherspoon-bmc``, ``yosemitev2-bmc``)

Hi. This change removed the "=3D=3D=3D=3D=3D=3D" underlining from the title=
, which
has broken the rendering not just of this page but also of the list of
arm boards in the parent doc:
 https://www.qemu.org/docs/master/system/target-arm.html
as it now has all of aspeed.rst's second-level headers in it.

Could you send a patch to reinstate the underlines, please?

thanks
-- PMM

