Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B048D609AD
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 08:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGDBP-0007MD-G2; Wed, 27 Nov 2024 03:13:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <agraf@csgraf.de>) id 1tGDBN-0007Ly-Ef
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:13:57 -0500
Received: from mail.csgraf.de ([85.25.223.15] helo=zulu616.server4you.de)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <agraf@csgraf.de>) id 1tGDBL-00054m-5k
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 03:13:56 -0500
Received: from smtpclient.apple (unknown [194.72.32.180])
 by csgraf.de (Postfix) with ESMTPSA id 01B616080102;
 Wed, 27 Nov 2024 09:13:45 +0100 (CET)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Alexander Graf <agraf@csgraf.de>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] docs: Document that hvf on Arm is supported
Date: Wed, 27 Nov 2024 08:13:35 +0000
Message-Id: <B4E0EC0D-811F-4288-87C1-232B3FD8EEE4@csgraf.de>
References: <20241127-build-v1-1-65b8162733f0@daynix.com>
Cc: Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, qemu-devel@nongnu.org,
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20241127-build-v1-1-65b8162733f0@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: iPhone Mail (22B91)
Received-SPF: pass client-ip=85.25.223.15; envelope-from=agraf@csgraf.de;
 helo=zulu616.server4you.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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



> Am 27.11.2024 um 07:15 schrieb Akihiko Odaki <akihiko.odaki@daynix.com>:
>=20
> =EF=BB=BFhvf on Arm is supported since commit a1477da3ddeb ("hvf: Add Appl=
e
> Silicon support").
>=20
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>

Reviewed-by: Alexander Graf <agraf@csgraf.de>

Alex

> ---
> docs/about/build-platforms.rst | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/docs/about/build-platforms.rst b/docs/about/build-platforms.r=
st
> index 6102f00aec0f..d8b0445157f0 100644
> --- a/docs/about/build-platforms.rst
> +++ b/docs/about/build-platforms.rst
> @@ -40,7 +40,7 @@ Those hosts are officially supported, with various accel=
erators:
>    * - CPU Architecture
>      - Accelerators
>    * - Arm
> -     - kvm (64 bit only), tcg, xen
> +     - hvf (64 bit only), kvm (64 bit only), tcg, xen
>    * - MIPS (64 bit little endian only)
>      - kvm, tcg
>    * - PPC
>=20
> ---
> base-commit: 34754a3a627e1937be7f3daaa0c5e73d91c7d9b5
> change-id: 20241121-build-c1661b2e728d
>=20
> Best regards,
> --
> Akihiko Odaki <akihiko.odaki@daynix.com>
>=20

