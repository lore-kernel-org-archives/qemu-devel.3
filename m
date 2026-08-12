Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F21C1C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:02:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu9XQ-0007uX-PI; Wed, 12 Aug 2026 10:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9XE-0007tW-Rs; Wed, 12 Aug 2026 10:02:26 -0400
Received: from fout-a8-smtp.messagingengine.com ([103.168.172.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1wu9XB-0002Nu-GB; Wed, 12 Aug 2026 10:02:24 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.phl.internal (Postfix) with ESMTP id 13E9CEC006D;
 Wed, 12 Aug 2026 10:02:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Wed, 12 Aug 2026 10:02:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1786543337; x=1786629737; bh=ey8Tm/l1CibtSG95Qt+jqOA5SO2w7prG
 nsd+/homs3w=; b=jrW7gadDUXQLBTAZq5QHFr2UptHgLkZBusna0+5+4lXWzGqI
 D2sbI/bVDxd/SRpT0c3bRmVjw6FXEC0lE5vhnxGjtIuC9Wil1uikTH4sVm6ME1xh
 /ZP+yYo6i8NPb0m90+LUwnULlFLL96mmxrbgQaO/ve2hGDSbCnMOqK1OK/CW+lZM
 8jTWFkhpsVL9SdkerQWGb1eBg+KVlpDrrNzI079p96WxOrAZHObmZq5+PTwXGKFS
 6lEgnFe83cqlIbT+VWYEkT1wnq4ms1HpukINyO/e1meBjzFqm6HxJhtdTUdrH+rC
 b+KZ+R6jCIhC7m9TUsRig4A2lQelXRPr2YCI1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786543337; x=
 1786629737; bh=ey8Tm/l1CibtSG95Qt+jqOA5SO2w7prGnsd+/homs3w=; b=b
 NiKirjBIcidhCEFZSO8NCM5YAs+Q93spEw7HFgtisanGi2Pvy5m5+r+zuGpeHYjq
 yVpWArVmLz6v9rilZXBSNTmPLJEsA/Kqd7MaS1QNxfi+bvr9ZzAU/bQFV3UwDUdC
 j3Hhxq4szW3O7OV8atuJGNS11T5cUwSzDjJPH1yLz1bQ/l3lmls9+Zu4ryjT4Ztw
 9AT9ejgQWEArsrIRsT5J3fxbLEek0jQm4dMjmnkjky1/9fi9ZhKMMnp5HGCuGEis
 pLYlbQwfWrxWenyI76W6UMb0+iSyVlkwHYPSUn8RNXg2gm4XHrPSNhBt8CQ3mPsk
 ECdpEdCJtWZ4+WuRUq8Ug==
X-ME-Sender: <xms:53x8arMH7CUJlXquDB-N57eiC5eNpI2hHVr21py7ZheYYZZQ7kB1Lw>
 <xme:53x8akdX9GYTmNZ1cYWiLFZMcCv5gRIDuSt18TPXZtktCNpoz6NAeU0BDCyRvT1va
 5XCqfAyH3s_m6r8StPdTN7Xqg0ddNOsXR69YAKuxL8JD2psrU3eLMs>
X-ME-Received: <xmr:53x8ahEP49mOKeO-zAFBgdBSbwYW-acg2VvD5dJqZWNltL3mi8fo4D_o6iwVp1cuuYL4Qw>
X-ME-Proxy-Cause: dmFkZTFsqhFi5OHec8z4spF7YXvJhFsBrzm4DkJqlUBsxeTjyi3hSG0iar8WL5yG+aNnH3
 sjBRmuZbtTHoYoorUR3qlR+DX/fmI/y6y/IHksk37Gm4mX1uDphkDJhqUSb6zDGUrn6W6D
 bkT5lmEW0Iu3AloMVxH9R0KDVlvK5JWiJkDKGJpfS2lggKHWf9Rs9Ir0weaG4FCywmSw7p
 zucGI+T3qSU3nbQa/zTAVWIYX10hQ8RCkfYO+B3QLnb7ys/Ws7WdsDpJLmWBI2Mm+5MSwo
 +/2eJXkcdumFZaYha73AnfJGbeieGmgKKpAIsawyu7z1meKHIjbfbYkc+xHw9XN8zqbgMc
 AKlR1Z6zy72bQqTtIk/MiIxcXdr5QsPMNqhw0OmGNuwfLgpHi2uI7kIdY1z/aItgYEKNZb
 ujuStOrZp8hQVu8kq3DKrGYULw1oFEXvx5nEhKmxck1tRPxXC2iRGyYz9laG03tZd1JtVJ
 8wMMySPG1IhDbHkdneMtbelqV709TOR3u07SFX7pPYu3Zo3C0rCcsHSlqM0lIDKcTQMn6z
 2uN2KCg4CZXW24yWOXR+apzIeEiNSV4+nen/f68CWhS0eTb7WTvqznyk6vq/t7PG9hGfZ3
 J20YWXlDFijQ1ejFOr7ImpNAuX5ywPWAIrnaKrouZilKCR530S2wEvAbKn0g
X-ME-Proxy: <xmx:53x8avv7SDjKYbiUydCZeC8G9JMaSLo4Yyh1_nMpxTgmekVeCe2hbA>
 <xmx:53x8aroJ2k5ef0LQAJAf61aQqKQPGZIcAt6xY_JyctVg1_GZ3JqyTA>
 <xmx:53x8amm-Q_fKmUomyUMXkI0jROHpv8XZIz-pCgYfRq1tkX2upBAUuQ>
 <xmx:53x8aohuY5pq50if25ndO9K1AgTvTGz6D358lWHjvKHdAJMSOiRc2w>
 <xmx:6Xx8asdCZcZrjbXcz9YQ0xFOD-ftfVDKKzP8RQkkgKHQlYjh5-k3o3my>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Aug 2026 10:02:14 -0400 (EDT)
Message-ID: <41fb7dd23c94be376cf6f03fb54f66443c5e905d.camel@alistair23.me>
Subject: Re: [PATCH v4 0/3] riscv-iommu: always send MRIF notice MSI
From: Alistair <alistair@alistair23.me>
To: Flavien Solt <flavien.solt97@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, Tao
 Tang <tangtao1634@phytium.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis	 <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Chao Liu	 <chao.liu@processmission.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier	 <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Nutty Liu	 <nutty.liu@hotmail.com>,
 qemu-stable@nongnu.org
Date: Thu, 13 Aug 2026 00:02:14 +1000
In-Reply-To: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
References: <20260727-qemu-mrif-v4-v4-0-73e0890ad395@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=103.168.172.151;
 envelope-from=alistair@alistair23.me; helo=fout-a8-smtp.messagingengine.com
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

On Mon, 2026-07-27 at 15:22 +0800, Flavien Solt wrote:
> The AIA specification requires an IOMMU to send the configured notice
> MSI after storing an MSI to an MRIF even when the destination
> interrupt
> is disabled. QEMU currently reads the MRIF interrupt-enable word and
> returns without sending the notice when the matching bit is clear.
>=20
> Patch 1 lets iommu-testdev select an MSI payload and supplies its PCI
> requester ID. Patch 2 removes the invalid enable-bit gate. Patch 3
> checks
> both enable states through qemu-system-riscv64.
>=20
> The complete RISC-V IOMMU qtest suite passes:
>=20
> =C2=A0 MRIF notice: enable=3D0 pending=3D0x20 notice=3D0x12d
> =C2=A0 MRIF notice: enable=3D1 pending=3D0x20 notice=3D0x12d
> =C2=A0 6/6 tests passed
>=20
> V3 used MIME transfer encoding to protect the patch body, but lore
> still
> received five hard-wrapped hunk headers. This revision resends
> unchanged
> code through b4 and carries the review tags received on v1 and v3.
>=20
> Changes in v4:
> =C2=A0 - Resend through b4 after the v3 lore copy remained line-wrapped.
> =C2=A0 - Restore Daniel Henrique Barboza's Reviewed-by tag on patch 2.
> =C2=A0 - Add review and test tags from Nutty Liu and Chao Liu.
>=20
> Changes in v3:
> =C2=A0 - Attempt to protect the patch body with MIME transfer encoding.
> =C2=A0 - Add Tao Tang's Reviewed-by tag to patch 1.
>=20
> Changes in v2:
> =C2=A0 - Wrap the fix commit message.
> =C2=A0 - Keep the existing notification comment.
> =C2=A0 - Add deterministic IE-clear and IE-set qtests.
>=20
> Signed-off-by: Flavien Solt <flavien.solt97@gmail.com>
> ---
> Flavien Solt (3):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/misc/iommu-testdev: support PCI MSI tes=
t writes
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hw/riscv/riscv-iommu.c: always send MRIF n=
otice MSI
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tests/qtest: add RISC-V IOMMU MRIF notice =
tests

Thanks!

Applied to riscv-to-apply.next

Alistair

>=20
> =C2=A0hw/misc/iommu-testdev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 14 +++++-
> =C2=A0hw/riscv/riscv-iommu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 13 -----
> =C2=A0include/hw/misc/iommu-testdev.h |=C2=A0=C2=A0 1 +
> =C2=A0tests/qtest/iommu-riscv-test.c=C2=A0 | 102
> ++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 115 insertions(+), 15 deletions(-)
> ---
> base-commit: 499039798cdad7d86b787fec0eaf1da4151c0f05
> change-id: 20260727-qemu-mrif-v4-c8e3c3a48b9c
>=20
> Best regards,
> --=C2=A0=20
> Flavien Solt <flavien.solt97@gmail.com>
>=20

