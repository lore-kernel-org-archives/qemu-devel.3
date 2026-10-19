Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B8F3CCF2D4
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 02:02:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIchm-0008CI-Rs; Sun, 18 Oct 2026 22:02:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIchk-0008BM-F6
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:02:24 -0400
Received: from fout-b1-smtp.messagingengine.com ([202.12.124.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xIchi-0007xi-Tt
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 22:02:24 -0400
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id C72AD1D00154
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:02:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 18 Oct 2026 22:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm2;
 t=1792375341; x=1792461741; bh=+8RY4Idf351xf8zdS4WpfA0zLM9Y+k/A
 2C55auqJqno=; b=O3o59IKTC0DGPnODZ7aFpfXOl3RY0vkaAjRJEELF8CE68SIi
 TwgKwPVElie9KoA0C4LaP1k6xZ5ZLr49LO2Ny2W1UuHhwU+0ehH0LQfBQjS4qIZO
 QaBBOVD9lngYo9VWS57YUjumVqsM33iDytDp8qL596RGX2Wai2HcIc5iBk7gu+wF
 T/CDqKmY68M1vPPBW+AW5npEkvRbOCpyIx7tecqKx9UbFDvJ8nIveMkb7KRPZK8q
 eW1qqNVNOCpWDFD/UYd0i1EEZLP4caY3h7pcfQnh8AhEiJMO6tFt4sdvCbMzGs46
 FsuiGD9p0BnBfjdWpxGRB3jBMi9h+As0LOo/nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792375341; x=
 1792461741; bh=+8RY4Idf351xf8zdS4WpfA0zLM9Y+k/A2C55auqJqno=; b=N
 eTn16a0ccR8tNg1E8LTo6T5/YrpvoNjOUho1spo0cbpbluHT2rGPz/jakokxZYE/
 B7JXVkB6c0h7zVFYVmW/Xg54GWc8v5sLltS5DJnwXY6LxE3D9aOsgF6o75aruyJ2
 pzDnvw+HKg2l2OyCOmzd7ZN2uyJdw9ARSRbrByUwwiQv9p43ZfoZzMMCyRLQHCyG
 og8fhTyZbt2J6ucBACDmDhV3uDv3LyZDh96j8V0sgtHaVYKaT04Kr1fHl9igxQLx
 I7/5tmlnRqwbu43qa+uWABe4UozkMbfTvOYYcns3Zlfuc07kqRWZcFlUB/B15uc/
 Ff6Yrbd+HQGGhvlE3g+tA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792375341; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm2:rsa-sha256:GFZnC3sUTwiP8t+t2EnmwhA/CuiwvAb5HGJy3IuVLB7jSQi
 +kE/kvCXYxdVH8dBpW9WmnrRtCG+UmdEOUfvkIMWU5RybqKTWP9weM1WAF/3y38G
 kfNK2tEZAX7JNL/i9LuIAkeWbKbw0zgvXwftT5JtX92MY72veSIeKjkL07mWuX7j
 eVJGu4j/LUKiYswjrGxmcIuc/1cxn1HeapL0cTxksJ58OzDViLJfvw4JFIiOs1wq
 UJbfrVrt3+CkSSDrGqTsuqDc+5XiMeOTE+p/V+vwLcF2cyaUi/BWL+ZSy/eLRKim
 PAUhAxAkhCijhjnKCggWlmI1hwMpQyQxXy6ULdg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
 repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:QKPBE5FLCbo7YX6Z7MHQjzb4Am7UlTTT9jAw5l7yNdA=:+8RY4Idf351xf8zdS4WpfA0zLM9Y+k/A2C55auqJqno=;
X-ME-Sender: <xms:LXrVaq9s2Amc_wic1sYTwMKcf9CZpXC7CNuGpFU_KpcMU_HLabSn1Q>
 <xme:LXrVajraG5rMGxyYiPtq2R-2wJT1YZDHiLTJW3ZzsNk5Fm0VrExmTDf7ix_w-pUWW
 7Wv2O65RAsCbxe5KlwHapIzmV53OAQ0WS2POdSv4jwTICob_eX9WUGp>
X-ME-Received: <xmr:LXrVarlOnXM7xvR71qOakV5AlM9ga3NaaJTQljgUEZ44II4gcRWuBULa-lF-nmVYNST6oZoEghb7QhQRTTkTMVQdJMI>
X-ME-Proxy-Cause: dmFkZTFh3RCwAqJpydauwaGErJZCrXnkaL2p1SLtwfF42hbaL8WcpH8Ng0nERfGumv/O3h
 SlfWT5qrazaHySRt0YSnUorcIMnEihyEJknyQ6EhMwzWbxeWOl3FitiCUYAEl6Sf45nCoM
 6fNIvH8ZU/aGWruErZNg7rikdhgneOLZFlVwPOfuYLAethpU3UNFQ8zuAF5F/Q+tzKsNnN
 aE1WRmbt0KhQCvHHzxtLeT/7x+2fUD/m0aptOT6PK97jcJ8RkWqZyuVFHpUnALnP459IzC
 qjS5d89/spWi3Z49joDqkdahvaOpc8twVKhSbHQXEtaHo8ZmNcIToj57pvgY6T5Vc//1XT
 OKufoStHJd0yjKID4fNm2eeSNucf1KvRpknqISLfbgOyEdAMyqvo6/lzkLs7UV3vCPAMoe
 Xjy5QUPb0ujCQhzLsL+FigxphlvsD62Z92S96B10LLikikjNLtraTF53x4JEEI3YxFQsBM
 sT/9lfPC4vLHeVSsB9uQFK2WYzYh7lRLPwOLGI2DzBM1G0kUWd9fDhuQynYgNMk4rsuwMW
 3Xa/tDp55lL4et0ubW366lZo508GvyphIVj9SPwEZfBpleTZqgOZrHsZOIdbjTBVc0m8QI
 A03AXkvcquz9+ypVYTqmyNvzAJ6uWEY2Rs4PS0ZPjMWeVxrLbxB4GBUe1mIw
X-ME-Proxy: <xmx:LXrVaij8sYYyPw6SjVvIVlwYWnk-qdbDGxVBuX_W8ybUFHl5fGS9_w>
 <xmx:LXrVaren96-FNRQ8qz00YGMgNajGfgdgBGVNaW-d0NTfJhSohMxe_w>
 <xmx:LXrVaqhCwp_6O4YH_Ol7OQS83aBNZCmqk1wnQjK1omOY_-wR5eZcXw>
 <xmx:LXrVarwg7xbNofUm0nSrLc4ETjtvNP-S0L4nMA5VwwSknTg4rNd_HQ>
 <xmx:LXrVaj5NUj2rKTQW7Z3LHmYk91anZsQnVRRQODBcy2upkBQl0zmRaUcv>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 18 Oct 2026 22:02:19 -0400 (EDT)
Message-ID: <7a14708f2b35cc77dfbb8ceb87800ba10afeb0a0.camel@alistair23.me>
Subject: Re: [PATCH] docs: Remove stale chapter on RISC-V 'Z' CPU properties
From: Alistair <alistair@alistair23.me>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, devel@lists.libvirt.org, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:02:17 +1000
In-Reply-To: <20261018230741.6560-1-philmd@oss.qualcomm.com>
References: <20261018230741.6560-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.144;
 envelope-from=alistair@alistair23.me; helo=fout-b1-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Mon, 2026-10-19 at 01:07 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> RISC-V 'Z' CPU properties were removed in commit 455c0fa9eef,
> for the release v10.1.0. Remove the stale comment.
>=20
> Fixes: 455c0fa9eef ("target/riscv: remove capital 'Z' CPU
> properties")
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> =C2=A0docs/about/deprecated.rst | 24 ------------------------
> =C2=A01 file changed, 24 deletions(-)
>=20
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index ccbc4219497..368fa1b4ed3 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -349,30 +349,6 @@ the addition of volatile memory support, it is
> now necessary to distinguish
> =C2=A0between persistent and volatile memory backends.=C2=A0 As such, mem=
dev is
> deprecated
> =C2=A0in favor of persistent-memdev.
> =C2=A0
> -
> -RISC-V CPU properties which start with capital 'Z' (since 8.2)
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -All RISC-V CPU properties which start with capital 'Z' are being
> deprecated
> -starting in 8.2. The reason is that they were wrongly added with
> capital 'Z'
> -in the past. CPU properties were later added with lower-case names,
> which
> -is the format we want to use from now on.
> -
> -Users which try to use these deprecated properties will receive a
> warning
> -recommending to switch to their stable counterparts:
> -
> -- "Zifencei" should be replaced with "zifencei"
> -- "Zicsr" should be replaced with "zicsr"
> -- "Zihintntl" should be replaced with "zihintntl"
> -- "Zihintpause" should be replaced with "zihintpause"
> -- "Zawrs" should be replaced with "zawrs"
> -- "Zfa" should be replaced with "zfa"
> -- "Zfh" should be replaced with "zfh"
> -- "Zfhmin" should be replaced with "zfhmin"
> -- "Zve32f" should be replaced with "zve32f"
> -- "Zve64f" should be replaced with "zve64f"
> -- "Zve64d" should be replaced with "zve64d"
> -
> =C2=A0Block device options
> =C2=A0''''''''''''''''''''
> =C2=A0

