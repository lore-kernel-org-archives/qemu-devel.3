Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 047B1CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 09:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBqfF-0002Ij-IB; Wed, 30 Sep 2026 05:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqel-0002CD-1Z; Wed, 30 Sep 2026 05:31:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7264c68bd=Conor.Dooley@microchip.com>)
 id 1xBqej-0007Ap-Kf; Wed, 30 Sep 2026 05:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1790760677; x=1822296677;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=5lkZ9SBE/WpmL18BebrYlWkkS8tU1dyb5pgDkqGgP0M=;
 b=T7WinxM60qz4fHKxCcWUt2hdGHCfJnBbhXFO07odExB8HW8RkMMTxGLz
 AUks5bXD1iHb6CchFJ8T17Fgh5+oHDwdqKyRzJmw49dqX5Y/762NQF0xc
 RWMPFaCgwMYQxl6Ho5vQ+q/nON0cm9piSlcCeI4dorIFvOKFzsur+KhWA
 /kPtItCPck1vvrSKq1RvTRhQEXrB/fHM6rbhU5HBy4yt2o42NB0ANcfqN
 sovpCpOrO5s5ISQXonjcg+wYxSHWq/wGr9CFe2N5e506KojhTxb6ju7bd
 A0N4sxJbFgc3lf83+8gs3mnJh9/bGrLJI3wim+PUzP5iIrlyOM79B4fAI Q==;
X-CSE-ConnectionGUID: p0XD7+GaQE+816TqrWku5Q==
X-CSE-MsgGUID: 3rEyXLHQRqS8LVDPgCeOuQ==
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
 d="asc'?scan'208";a="295773349"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 30 Sep 2026 02:31:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Wed, 30 Sep 2026 02:31:14 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex03.mchp-main.com (10.10.85.151)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.58 via Frontend
 Transport; Wed, 30 Sep 2026 02:31:12 -0700
Date: Wed, 30 Sep 2026 10:29:53 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Bin Meng <bin.meng@processmission.com>
CC: QEMU <qemu-devel@nongnu.org>, Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, Conor Dooley <conor@kernel.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Palmer Dabbelt <palmer@dabbelt.com>, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Sebastian Huber
 <sebastian.huber@embedded-brains.de>, Weiwei Li <liwei1518@gmail.com>,
 <qemu-riscv@nongnu.org>
Subject: Re: [PATCH v2 18/24] hw/riscv: pfsoc: Fix Icicle Kit RAM size at 2 GiB
Message-ID: <20260930-grapple-thwarting-bf46a4271320@wendy>
References: <20260904155758.3833179-1-bin.meng@processmission.com>
 <20260904155758.3833179-19-bin.meng@processmission.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qsfIJTQJj4lJNsX2"
Content-Disposition: inline
In-Reply-To: <20260904155758.3833179-19-bin.meng@processmission.com>
Received-SPF: pass client-ip=68.232.153.233;
 envelope-from=prvs=7264c68bd=Conor.Dooley@microchip.com;
 helo=esa.microchip.iphmx.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
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

--qsfIJTQJj4lJNsX2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

--qsfIJTQJj4lJNsX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarzWkQAKCRB4tDGHoIJi
0tZHAP9S19AiY+7z6jbnb/VcMTm0pKDfVNoDwO9XAu32wZ9/6QD5AR+Yo3aFEuwa
6QWdXC8NeA2yJd1fwuvHKJ53jGYGqws=
=7Vjb
-----END PGP SIGNATURE-----

--qsfIJTQJj4lJNsX2--

