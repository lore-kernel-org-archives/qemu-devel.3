Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A681C54798
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 00:28:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhf8B-0006zM-IX; Tue, 05 Mar 2024 19:27:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rhf88-0006yw-Lh; Tue, 05 Mar 2024 19:27:32 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <conor@kernel.org>)
 id 1rhf87-0003Wx-2s; Tue, 05 Mar 2024 19:27:32 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7384C618D1;
 Wed,  6 Mar 2024 00:27:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078AFC433F1;
 Wed,  6 Mar 2024 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1709684839;
 bh=X3Cxon6PKD/7QFUjeZpbc46kk5sj5qSR/Or+azdsqGE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BneO3g1irWgmrDU9MQOOGxBPBZ1gDVXR5AvkXD0pZgkaMa8o5ijWDboFqClsUXAdX
 CtUXmtenyDibi4CUEn/RnQ/iEG1gRJ6ooK6sw9c+6Ssg7C7L+oOsetedEB/Wdmj+A7
 vHr5npUIj3tNPVvkUCfbKP5HEVTkC79Vv3elqx0JJj3mhId8sWZGjExkDgSCVVGkz+
 UmUOM/FNvw4TzIsJgOUWredNiQXLua2SmVPBHnv02XB9smsFVXI7PzdfY/VdmKeVlk
 fxDE4n5UwF82SuEvILVt8SWVLnksluM80rzcpSz0pNEvcq/O/eorb+SORutqoFA0wi
 egagJ6tAdJl5A==
Date: Wed, 6 Mar 2024 00:27:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Fei Wu <fei2.wu@intel.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 andrei.warkentin@intel.com, shaolin.xie@alibaba-inc.com,
 ved@rivosinc.com, sunilvl@ventanamicro.com, haibo1.xu@intel.com,
 evan.chai@intel.com, yin.wang@intel.com,
 tech-server-platform@lists.riscv.org, tech-server-soc@lists.riscv.org
Subject: Re: [RFC 1/2] hw/riscv: Add server platform reference machine
Message-ID: <20240306-peddling-superglue-fce995d0be84@spud>
References: <20240304102540.2789225-1-fei2.wu@intel.com>
 <20240304102540.2789225-2-fei2.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SncxPZo0AIJqJL5+"
Content-Disposition: inline
In-Reply-To: <20240304102540.2789225-2-fei2.wu@intel.com>
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=conor@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


--SncxPZo0AIJqJL5+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2024 at 06:25:39PM +0800, Fei Wu wrote:

> +        name = riscv_isa_string(cpu_ptr);
> +        qemu_fdt_setprop_string(ms->fdt, cpu_name, "riscv,isa", name);
> +        g_free(name);

Please use riscv_isa_write_fdt() here so that you populate more than the
deprecated property here please.

Thanks,
Conor.

--SncxPZo0AIJqJL5+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZee4YAAKCRB4tDGHoIJi
0oG8AP9lJ9RhYBRSJIBYpePu35m5rdr9pqPENGOWxHPV9CDLZgEAnc6XtlOa8RTb
9Zy+Ms5vI/SxoswICQkkqo8JOCnfoQQ=
=Zm4n
-----END PGP SIGNATURE-----

--SncxPZo0AIJqJL5+--

