Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524C3C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8TX-0002YW-Cc; Wed, 12 Aug 2026 08:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8TV-0002WW-Pi; Wed, 12 Aug 2026 08:54:29 -0400
Received: from fhigh-a3-smtp.messagingengine.com ([103.168.172.154])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu8TU-0001mS-8m; Wed, 12 Aug 2026 08:54:29 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 7402E1400162;
 Wed, 12 Aug 2026 08:54:27 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 12 Aug 2026 08:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786539267; x=1786625667; bh=sKxena1Sk3esAgejaA5lRk8yLizaxXPr
 tKti/lzyfAE=; b=olv7QCDUpuyVSXa4dc9WKfZ0ADYtLbBct9klwnVVlx48srco
 lSmYMLu8YQgjtr1YJpwEwohbtskv2KxCeDXHAELHz3njL7DTa3l2rJcLCpOSeFjV
 7uV6xH17QOZJZkYW0KAyiqr6ps4U5EfBX6H61vcWZ8wzGFySVxOFtISuthFTDqoO
 KE9X/e0K/tBHryX/Tfg56rMkFt4ZKUilP/d+veigDxQf1h4dkFw68cSF4nBdU3Qz
 iDgVVyi6+2FyXRbPRPU+y2i70x0oXcOEYQJa1zo0nlU6Y6IVqEXXpq3uT5ZSyCCd
 0i0K1otgR+iT+HQAOVv3pGHUa+zP7p0MWNh2EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786539267; x=
 1786625667; bh=sKxena1Sk3esAgejaA5lRk8yLizaxXPrtKti/lzyfAE=; b=R
 85VPPiqK31S6EF67gogTXNzva6zk02wZF9rcaMUj3wOHBcqFm/7tOm57kLf0tmRn
 wpkMARkWBjv82/A1L3rYkFBEFSZ0iIINj9c7i7dsAtDCpyesrwjjqfSCzlJqSDcI
 rw3WdajgMjPxGRswzHA/PrCvF8efoaOgBB+ceIrvQPvtjPcEra6yj/NNxdlaBMtH
 x7YQYoEJiSCxKeriBSqOATFI4j7eVAKgye5w6Ldbpw4WmY/6M9XRiUznvh0sxrOo
 Shug2JYxuVdS0wUtuvNZvoSyGl8DjzKT6Ez8FCujyFCi0l0gQ054U+4K4HWW41Zb
 ugKEHO21zwWvBLxIILFTQ==
X-ME-Sender: <xms:A218alL_XmbL_xUuB55awAK7RgsXdM2_6T5OxASUgs7fgnEhVs5P2g>
 <xme:A218aldNBgkS0GJBstzNcRKZ4FKbG2rDwdwTbw5lK_w0V1xyLg4gAorG2s8d7-8v_
 pGWHQP-lhiP1IQQCFsH1TixioSydO4J6jGqg8Dz4fWgmoAz6El9IFrE>
X-ME-Received: <xmr:A218as3K8xpdt9O8Gx80KhZPIkWuqYgQA4ZIYXezJiU9ypnBFcvBbLqmakwtlnE9NVjYcQ>
X-ME-Proxy-Cause: dmFkZTFBl8NfP07YVm2uEj56aKFTjJ5PpdZmd1UCTIPFKX5NUa/2gqY4/xBVLKw0nNGzLb
 KjqAAr20ASfj07WNPGAOVDB/bQS3vGh1LEG6Jzfk63lG2qhdTHTFDngWd/WvFd+c4JFxq/
 0hPHgSkFgdDQ6ZUO5wTwyBLrtevOTWi6jdSSiG8IxRz/3xTHjpJ/zei2QEDas+X2tw4SL4
 bbyeIlKQJ01TQTlXyddau2VfhIAVstTMm79qOEyIDNCGYzKdAjdu7q1maKARN2lGu8Qi/V
 E065oEYqd1/GrmZSxyQU4GA90m/qeFg3lFo4yhw4XEgWv9UsYHcZge6g4NNqFJ2Ay7V/IZ
 SRiysZCXGygwILsBgv0kvc1Ewic7YNC2z0cIRDXbrsfJEgPU28EAJC42Jtv3U29tV8uHUm
 Rfe9M8c0Y2SGLETN64pxanNQfUwY5Rbw6vqsh7n7ZPlR+Dsx04u6aGaBOue/PZhH2nGPg8
 M8h+ol61xKbX8ydULN5xjzutkTXCgKAfMLv2vB/wMDKZfD8X5bmvPUysKqcFkPuhGiX643
 sgHJcdbur3sp+KPFPEFoWLgVz/+vg49uGNb0/naVA0CRFaoIaTm6qyx48iF89L5x7xW2QB
 REMEeh3bdVgcF4l9IPu9guWLemslkx/ZRzMonykPR9OV+CND5ogxvZjGiCRg
X-ME-Proxy: <xmx:A218auh-z-626js62y7Eq_eGUJnIHUx4ahAlBlcb4a2uAduUtlpfRw>
 <xmx:A218aiSBu3wMFHhtpSj11Pdg4i6flOM1WAe01C-_YZ1Q44kbJaTbUg>
 <xmx:A218avjX1r8uK7PVBGc9-JdZUUVXatFHXSuBLAVyqkWxONoDr49QQQ>
 <xmx:A218ai5AhEfamnJGB_zwsDyr-lreZpxTQSVP-D3loZqZBfvTeuRGdQ>
 <xmx:A218aq8FtwFbb3JtYCY629F898Sk5HZhCNr0BjrIFtq8EMvXdjMmyco3>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 08:54:27 -0400 (EDT)
Message-ID: <6de16df752239d2cb2fbd7d251732606798694d7.camel@alistair23.me>
Subject: Re: [PATCH 48/56] disas/riscv: Move rv_op_illegal to riscv.c
From: Alistair <alistair@alistair23.me>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org
Date: Wed, 12 Aug 2026 22:54:26 +1000
In-Reply-To: <20260809223545.730664-49-richard.henderson@linaro.org>
References: <20260809223545.730664-1-richard.henderson@linaro.org>
 <20260809223545.730664-49-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.154;
 envelope-from=alistair@alistair23.me; helo=fhigh-a3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, 2026-08-09 at 15:35 -0700, Richard Henderson wrote:
> illegal is no longer used in other files.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0disas/riscv.h | 4 ----
> =C2=A0disas/riscv.c | 2 +-
> =C2=A02 files changed, 1 insertion(+), 5 deletions(-)
>=20
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 241dd47d7f..5ac8c41616 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -200,10 +200,6 @@ typedef struct {
> =C2=A0=C2=A0=C2=A0=C2=A0 uint8_t=C2=A0=C2=A0 rlist;
> =C2=A0} rv_decode;
> =C2=A0
> -enum {
> -=C2=A0=C2=A0=C2=A0 rv_op_illegal =3D 0
> -};
> -
> =C2=A0/* instruction formats */
> =C2=A0
> =C2=A0#define rv_fmt_none=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "O\t"
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 4141741d79..f0b3bc6be7 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -29,7 +29,7 @@
> =C2=A0#include "disas/riscv-xlrbr.h"
> =C2=A0
> =C2=A0typedef enum {
> -=C2=A0=C2=A0=C2=A0 /* 0 is reserved for rv_op_illegal. */
> +=C2=A0=C2=A0=C2=A0 rv_op_illegal =3D 0,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_lui =3D 1,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_auipc =3D 2,
> =C2=A0=C2=A0=C2=A0=C2=A0 rv_op_jal =3D 3,

