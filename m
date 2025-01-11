Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF280E7719A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jan 2025 09:19:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWXdT-0003tt-Eq; Sat, 11 Jan 2025 04:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tWXdS-0003td-G5
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 04:18:26 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tWXdQ-0004WZ-S1
 for qemu-devel@nongnu.org; Sat, 11 Jan 2025 04:18:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=JK74cYQJmRZcuqNJurb8MNH5OGLR8kvyJjcxu0Rtb6s=; b=cjjQWVKJD2d0h3rzI1646hUFxY
 hija7hXi10+y4L7zm44Rv77WKjXPuP/OJVZ4fQXHANXO2h4wNHr5kNbz54X1yvvWJGtVQoeFd29wt
 D1VwNcM2LbvaO/UhfEFEb18AaHY5A2D6M17Nhvb0Z6OmUcOLfNVYmyIOrBILlOyQ0UeVIKzvDilOJ
 zzC1tSJdLJwlPApFNmnctye/bL0nHT9s0jTCR1nO+f2Qg+tqV7FIc/KFZnPK/mnzrF4e/h3AwiJcl
 RVGuf6zlYALDn/CwKGTTLYCvxKcfDBHaCcNn3O849uqoukPOJCwnbmAqMGPE94auS8V3WZjKbmUkw
 YDcupIN1R38tBq2DKqhbGT0K/1wGhOFHuHXJuTyuuBpgNuTnE2snXYaODKyWprxeSZwb+zC49qatT
 Pet7K/kaNwBmtxR2+ibunmrshtS6R1HQR98wSC4muEVlfLsYDau7Z4va3pxOdWwFIIcd73jCs1pg4
 ch5mILHyjrn5wiqjIxTZzmxKh7PqbZn9sVZXRFk/vissBfTuv/cf2Mju6fXXeF++7y0XwAGAdbEFj
 Cd1G8LiY8T5Pj//FqzTB+D0mM1U5umYYh+YrNJN4Dxo/wmRUzP60XneVha3hdAVrGepqzgieVrTjK
 rMBqBC4MZ/adbJEj3wOUebmePCfjAYWqsfEUhW5E8=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?ISO-8859-1?Q?Mathieu=2DDaud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH] MAINTAINERS: Update path to coreaudio.m
Date: Sat, 11 Jan 2025 10:18:16 +0100
Message-ID: <2698029.rbXPDIGej7@silver>
In-Reply-To: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
References: <20250111-maintainers-v1-1-faebe6ef0fec@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Saturday, January 11, 2025 7:42:36 AM CET Akihiko Odaki wrote:
> Commit 8b46d7e2dc8e ("audio: Rename coreaudio extension to use
> Objective-C compiler") renamed coreaudio.c to coreaudio.m.
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 38a290e9c2ce..1e30c0f14057 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2786,7 +2786,7 @@ M: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
>  S: Odd Fixes
>  F: audio/
>  X: audio/alsaaudio.c
> -X: audio/coreaudio.c
> +X: audio/coreaudio.m
>  X: audio/dsound*
>  X: audio/jackaudio.c
>  X: audio/ossaudio.c
> @@ -2808,7 +2808,7 @@ M: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
>  R: Christian Schoenebeck <qemu_oss@crudebyte.com>
>  R: Akihiko Odaki <akihiko.odaki@daynix.com>
>  S: Odd Fixes
> -F: audio/coreaudio.c
> +F: audio/coreaudio.m
> =20
>  DSound Audio backend
>  M: Gerd Hoffmann <kraxel@redhat.com>
>=20
> ---
> base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
> change-id: 20250111-maintainers-28bbada9fd02
>=20
> Best regards,
>=20



