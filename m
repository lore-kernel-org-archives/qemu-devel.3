Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9E1CD6E6B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVOXD-0007fj-BW; Fri, 05 Jun 2026 03:00:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVOXA-0007eW-5f; Fri, 05 Jun 2026 03:00:00 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>)
 id 1wVOX8-0006n2-Dy; Fri, 05 Jun 2026 02:59:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1780642778; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A6rALD49tyXQBhKRmoiZeci4AIXTqXZD9eAB6v1+TP8lCJJ/jbGqRN623qo8OcYeW/kPmhx7JXW27Hl8oiEoZWk5L48PGxHwVzzrIHLfRILCp30ZQaBBuQBFq6T7HSDX+ec0wRPVxWtgpNtAeZt5y6jrmCa/FeeV3oWC9rEp8+8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1780642778;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=1AJMRkIDmj8Dxnv02Bm1Zg3eEAiVJYJvjGXe+p/TJQ8=; 
 b=oLuafldfdyR+t8DzOe8kIh1TLyYuLTzmNVm91+49aooeXlLHrpUtQ2+0LSjJ09Mb04BBSuqFA8LjGDaP4MFGkzet12P+Q0U4TZQlZjVHkbxG8mqS+QuuqcNJ2HbaGXsyNTss+GHoHh4jl1bXy5LZd787wt28WUW+mKBfnY+KWEs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780642778; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
 bh=1AJMRkIDmj8Dxnv02Bm1Zg3eEAiVJYJvjGXe+p/TJQ8=;
 b=UvloSPb3cjD/DWNhFBF9L86SQ3raAVQJwSv/QI3gZTZWKZ5gc7r+lAWI8GZpfolp
 H/gafnWHQ54GZ+ZBdvO2rf3pHvDIcX7PjB7QQOMg0FOS4Z6zZe8cwQnF4QhTsi6YC5+
 roN93Fx0YjSgl+KHZsG/w/TsXXIt6UTuLAXjrAZu5ESaPWloNT8+BoD74l42AkgYTS2
 d4CMPFPkBnh7+hgc/6iLDmhqEC9l5ysbAQsikfWLwXG3usjusbQC0Th5qHv5uJC72x4
 I6nvje7cf2dwLst9RYxNuPPG6GsQw4nYP76Z/Z5qXsufoOb1xGUHeF3ps8TIjWj2fZg
 LgZEC+bfrw==
Received: by mx.zohomail.com with SMTPS id 1780642776077152.07251563982675;
 Thu, 4 Jun 2026 23:59:36 -0700 (PDT)
Message-ID: <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
From: Icenowy Zheng <uwu@icenowy.me>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, leif.lindholm@oss.qualcomm.com, Fei Wu
 <wu.fei9@sanechips.com.cn>, Palmer Dabbelt <palmer@dabbelt.com>
Date: Fri, 05 Jun 2026 14:59:29 +0800
In-Reply-To: <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.12; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

=E5=9C=A8 2026-06-04=E5=9B=9B=E7=9A=84 06:52 -0300=EF=BC=8CDaniel Henrique =
Barboza=E5=86=99=E9=81=93=EF=BC=9A
> From: Fei Wu <wu.fei9@sanechips.com.cn>
>=20
> The harts requirements of RISC-V server platform [1] require RVA23
> ISA
> profile support and others.
>=20
> This patch provides a new "riscv-server-ref" CPU to go along with the
> future "riscv-server-ref" board.
>=20
> [1]
> https://github.com/riscv-non-isa/riscv-server-platform/blob/main/server_p=
latform_requirements.adoc
>=20
> Signed-off-by: Fei Wu <wu.fei9@sanechips.com.cn>
> Signed-off-by: Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com>
> ---
> =C2=A0target/riscv/cpu-qom.h |=C2=A0 1 +
> =C2=A0target/riscv/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0 | 11 +++++++++++
> =C2=A02 files changed, 12 insertions(+)
>=20
> diff --git a/target/riscv/cpu-qom.h b/target/riscv/cpu-qom.h
> index 30dcdcfaae..a150acd151 100644
> --- a/target/riscv/cpu-qom.h
> +++ b/target/riscv/cpu-qom.h
> @@ -42,6 +42,7 @@
> =C2=A0#define TYPE_RISCV_CPU_RVA22S64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> RISCV_CPU_TYPE_NAME("rva22s64")
> =C2=A0#define TYPE_RISCV_CPU_RVA23U64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> RISCV_CPU_TYPE_NAME("rva23u64")
> =C2=A0#define TYPE_RISCV_CPU_RVA23S64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0
> RISCV_CPU_TYPE_NAME("rva23s64")
> +#define TYPE_RISCV_CPU_RVSERVER_REF=C2=A0=C2=A0=C2=A0=C2=A0 RISCV_CPU_TY=
PE_NAME("riscv-
> server-ref")
> =C2=A0#define TYPE_RISCV_CPU_IBEX=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> RISCV_CPU_TYPE_NAME("lowrisc-ibex")
> =C2=A0#define TYPE_RISCV_CPU_SHAKTI_C=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 RISCV_CPU_TYPE_NAME("shakti-
> c")
> =C2=A0#define TYPE_RISCV_CPU_SIFIVE_E=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 RISCV_CPU_TYPE_NAME("sifive-
> e")
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3f0f931335..c4a5a7f1cb 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3315,6 +3315,17 @@ static const TypeInfo riscv_cpu_type_infos[] =3D
> {
> =C2=A0#endif
> =C2=A0=C2=A0=C2=A0=C2=A0 ),
> =C2=A0
> +=C2=A0=C2=A0=C2=A0 DEFINE_RISCV_CPU(TYPE_RISCV_CPU_RVSERVER_REF,
> TYPE_RISCV_BARE_CPU,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .misa_mxl_max =3D MXL_RV64,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .profile =3D &RVA23S64,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg.ext_zkr =3D true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg.ext_svadu =3D true,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg.ext_sdext =3D true,
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg.max_satp_mode =3D VM_1_1=
0_SV48,

Here it only declares the maximum supported SATP mode is Sv48, but the
RVSP spec requires Sv48, and the RVSP REF machine created in the next
patch also requires it (because the above 4G PCIe memory space is
beyond 40-bit physical address space).

Without `,sv48=3Don` explicitly enabled on the CPU, booting EDK2 firmware
will fail because of the out-of-address-space PCIe memory space.

Maybe a RVSERVER profile could be defined for CPUs conformant to server
platform spec (because that spec really adds some requireed
extensions), and use it for RVSERVER_REF CPU type?

Thanks,
Icenowy

> +=C2=A0=C2=A0=C2=A0 ),
> +
> =C2=A0#if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE128, TYPE_RI=
SCV_DYNAMIC_CPU,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .cfg.max_satp_mode =3D V=
M_1_10_SV57,

