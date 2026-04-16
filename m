Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEBCF8D753
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDO90-0003xr-2E; Thu, 16 Apr 2026 10:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDO8x-0003xV-OD
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:56:35 -0400
Received: from mout.web.de ([212.227.15.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1wDO8v-0007KA-Gi
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 10:56:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1776351389; x=1776956189; i=lukasstraub2@web.de;
 bh=OueuJ5EV+QKcR0/1I6k7QyWb/lNVeSavzXgFKUscORs=;
 h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=fN6XbwgHhLctVH0GNknxaSMqDWHSwJwggLSaLTY81DOzfeF8tOJbAoN4Fw5i0wNH
 fqV+zDxRqzEUXEV9BGeneHOCCUbqV7BUdzsWt3yMlBcKBXruW8nMpSha142FPIDLl
 r7EQL/V0v8mp7u9FLml2FI0zqAEbSFwJSZIzp/p0wK2t/89oA6OA7AefIGlJAYGfE
 sYCzXn+at/omHeTvK9W8XyAKOzqAHI6ASMxcx72LE5W4Den2NfmZcVwwrTV2xO617
 MVaAQsWg7/6VckZDYITt4Yl4VZlGJAaVCoP9DLDOH92wiCZ/6Oi61wiuxKF9XKB7Q
 o2Ovs1BdkejdJLf0vw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MumJD-1vNDIM2xG7-00vk7V for
 <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 16:56:29 +0200
Date: Thu, 16 Apr 2026 16:56:19 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH 26/28] MAINTAINERS: Remove Wen Congyang
Message-ID: <20260416165619.5752fc0a@penguin>
In-Reply-To: <20260416091654.316158-27-peter.maydell@linaro.org>
References: <20260416091654.316158-1-peter.maydell@linaro.org>
 <20260416091654.316158-27-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kydNu4jWCLk4K0NBp0cdzW.";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:GWwMqfdk6GrA+/eMEAp38tGYLXiA9GpHT5Hreavl8mSXwv523yA
 nQU4FaDrVvSz07FCZnm7fWsgOZon7u1ipoMzAlA1NoUgmWJj+AOvg4RRpZgUmU1s/+rbYsF
 oBg3zaFr3Y7mgkna2AZTvRqPEA2R18/395dIWB4I4BsfEwzhM05hFzd7A5yq4bhl8Kcq/oq
 CWE6R5/ULCQdbcvlWCbcQ==
UI-OutboundReport: notjunk:1;M01:P0:HajjRzPJY9k=;z/UTjHzCwhh8vTU0WRCM/mHBzk0
 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
 nN
Received-SPF: pass client-ip=212.227.15.14; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--Sig_/kydNu4jWCLk4K0NBp0cdzW.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Apr 2026 10:16:52 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> Wen Congyang has not posted to qemu-devel in some years and did not
> respond to a query about whether they still wished to be listed in
> our MAINTAINERS file.  Remove them, on the assumption that they are
> no longer active in QEMU.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ca64361b24..81ffb56c31 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4383,7 +4383,6 @@ F: block/export/vduse-blk.c
>  F: block/export/vduse-blk.h
> =20
>  Replication
> -M: Wen Congyang <wencongyang2@huawei.com>
>  M: Xie Changlong <xiechanglong.d@gmail.com>
>  S: Supported
>  F: replication*

Reviewed-by: Lukas Straub <lukasstraub2@web.de>

--Sig_/kydNu4jWCLk4K0NBp0cdzW.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmng+JMACgkQNasLKJxd
slg4RQ//Zu2Mm478HXXY7IOcSVIw9QAxCdcbD/+mfRm7zHUlt7mAH/IeA8M4n2u4
mrISCj8J28mwl+DrIyQ4MKiGD4C0NWwUb6SSc45m0S2nOXBlfTnzXiHp9PXmPl1u
kTmaaebpLkRo2/nn9Vi0xClM90BRhDgSu13twDgpqEcF5tbbA0IIWV6UaDOQqW42
RlpuUpKyXXNNaN5z0bRbIfgs+20iUKx87/utIbUWtBYxrVoFu6snNUWqn8s8H2Qj
7VB1AREaDUgtyfhMYAcmyfx03vPquSFToeuifOA3kHGGh6T/YSZybc0D+WW8mvPx
jVmYf53rVX+ZQzzxJly/gbjSP1/kSS3TKDSg3fVxZbiKR2lvmOT78fETkVLyk935
T8ePaG7BlE8RTD7A+dlaI2es56PQKzR5xe2oBEA0ihz4fUBjXxXct1Fv2SrdOhMN
XJGB1rtIhKvYov6L9Kqm4HJgU6zbsJb9PJjd/IquVRFvCC0/CqfhSXt8MxZk/RhK
y1yhXJOlyd9muqY+LLqWp6NXeqjxa/9a7elGYLtcl+gVCD7LlmAUV8PsU4/UyMnI
2TGfSC6MBDTqM7dCehBEAQfRWpjCOUJWHo9kcQbBz3a1KUsXiaQyny0OWvqcocHH
FnB4pYsMDutdu1Cjjre4aMprlBfSovw+4Y3zcKGq7Tzz5VEALf0=
=8ECh
-----END PGP SIGNATURE-----

--Sig_/kydNu4jWCLk4K0NBp0cdzW.--

