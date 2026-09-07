Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B32C79FA3
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 05:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3Rqe-0004vJ-Dy; Mon, 07 Sep 2026 01:24:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1x3Rqc-0004uY-FW; Mon, 07 Sep 2026 01:24:50 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1x3Rqa-0007tW-Fe; Mon, 07 Sep 2026 01:24:50 -0400
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
 by mailfout.stl.internal (Postfix) with ESMTP id B37051D000AC;
 Mon,  7 Sep 2026 01:24:44 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-08.internal (MEProxy); Mon, 07 Sep 2026 01:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm1;
 t=1788758684; x=1788845084; bh=tCoqH0DU08osWA5sXJXCSlLAP3CblK3k
 +RlCgzE/tK0=; b=WrJEDCDw/8QP9d47btV7EfbAgtvilZc5fBpK3wcuvmCDjxAe
 WgYn7YIU6Cw8E0ck5c/Qkyvxg16nYY7xIRV5rjyZsl04kdAWq7+qiHhnMZVQHxx6
 H5uqSJNlnf1MZCSMUOxAAJB/6PfIG0iG2tTi0UBqUBHn38Q42nW0f+x+FDqohkpb
 5q8toQNVqRa6DnGxP1AdDkM5mqY1ME7OV65FPxntuC6ddY0nLccdpfbHFz9oj9eb
 ACTRtjnGkZIHPMMd0qqtO66n3jIDL/GrPqx/+oj6A+pcCMmfpv9Ko+Yo5ykSEIvM
 iqj+a8QNnoHuy4EoZYDPzKAzzvlyV4ZoeMRf2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788758684; x=
 1788845084; bh=tCoqH0DU08osWA5sXJXCSlLAP3CblK3k+RlCgzE/tK0=; b=j
 6PcmuAjq59C80Utf92Y6q9QpOVhI4Qd3/qi0momFYdkM4hoValiOmefgAaT7AHtd
 yI3Mc6CvwjjnwkjqQJmPTVb5h40k9pWiao1Xm/li/pf/VA1WVn9olb+56Nn1oHNd
 NaTsrOrcYQ8Jw5NKiuSk17QlXOZdk+qfWV4npEtn0E0QtKpk4wASBbE6H7OYT8Mb
 ff4Yds2WX66Q4CfuJAlXGjIlOJeyiiK1JWcb9BST8uf6rOEmM6lxXbwGoEHRKBHY
 PcRegDAijNdnDcChxV/2xaS4EM7dhMEQxo+OSllQpQ9YtOt+sDhEUYOm08lKlON0
 n3pnFFcewV2aHwe/sGA8Q==
X-ME-Sender: <xms:m0qeag5S2-yc3bfEEv0ozBLqmxqZcKs4q8LE7Oz05pO2csYrov1pwQ>
 <xme:m0qeatvuM2vgL1MoP0KyFIIclXkgZGmMRJtxv9XGnxJItbO0wFqkOSAns8DFMGekc
 V_WqNT37Aes9LZbZPFJ2EfYFK5yfi1sgdS2AKfozUK6TZ4FZfO6CYU>
X-ME-Received: <xmr:m0qeaq2u6jF7pUH2QvBSVxr4KZ0_otDNX_HN4jQiqzkXX4ryWfmla2noI1lUyNKTFerIdAOVDlogdhjrOg-DJV12ngw>
X-ME-Proxy-Cause: dmFkZTEXhusqCaOIUJRx//dOZw8Zsikr+wAXLW5z0cwH9dtPpPmYAT2fy7alPwS+OK827s
 68Ep2EWFLTcvnMb7myUy8Em53zYKaS5I9WB6m68MXy6uQSPkaKlcl3W9KO6AT6b3iE29fr
 5hADSK9buhPAvnIe2uBKEzz721z2UBTbpRJipZUnCYW5fG5T5nueU+5xgsxSjjFlGR8QOW
 ekYXi6gZaPy/lFjvcn3ZyFXw1I1LILHGMcGM+To+tmtK3Yq+Zap8E03XfWTJ4pLrllUNqN
 PO9pAXq77ZELYf5b7PXs6ZgoLPNOsmjC+pCL9qpd3q4eOY/RZ1kHfmVJZx3pGgTwfNH4X7
 4awJ0cOeIrD1n2mVkUbmtB6saZP/9SX/HQAbgXwJBj0hLcSfCwvmj/fg44ArZMTTOUQhcO
 XZNjG88eUdEIBAWfKkzFgPxcDHcgLAtorlSaqk0xSKZfs/71aGFeTVjjOAgCV/UuGzH6tp
 PekR/PJHjB/ppdXTKcIqmyNKuWSzbQRPvGXhcL9BlYEDpoTIxlAcC3x+HjjbvkrYTUrcXy
 HUiH0Auw6poSXoX3UbQge6oIrJ3zPjqyUWGdQ9ypZ7BqbtMs6X7+sGBHuDTilN67P9aMvv
 YxGF6Zgi65pjcW63K/7xBvARjoOQH/0eYNF3gfVZgVoq4nizdXwV/Z5NXreQ
X-ME-Proxy: <xmx:m0qeauoKBlqD62ZKfTJRGhDsj8kDgPWCvu8vof5UNbArvd9L8f3E0w>
 <xmx:m0qeaiJ4owTxQQzhnd6hu_E_bJ_1NLpupuuQp59uD1PHYrMCY2qdFA>
 <xmx:m0qeaiSE3z0kAFAObMlMAuyZqeMKS08vUMjp15jX3WaFvzpHk1q6ig>
 <xmx:m0qeaiOprPt8945nEAlJ8dJ_m4sE3xgaSknYBYBWB9ZbbGwVx4ZvDw>
 <xmx:nEqeatYquigRL6inNEBawU-gBXcc0D1tpBJFOSUsU0IM8lQtJuCtFP-Z>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Sep 2026 01:24:40 -0400 (EDT)
Message-ID: <7319c76d91b020477c5f5ed33c46dfb3dfc03e83.camel@alistair23.me>
Subject: Re: [PATCH v10 01/10] build: add optional librpmi dependency
From: Alistair <alistair@alistair23.me>
To: Subrahmanya Lingappa <subrahmanya.lingappa@oss.qualcomm.com>, 
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Daniel Henrique Barboza	
 <daniel.barboza@oss.qualcomm.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@oss.qualcomm.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau	
 <marcandre.lureau@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=	
 <berrange@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=	
 <philmd@mailo.com>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Alex =?ISO-8859-1?Q?Benn=E9e?=	 <alex.bennee@linaro.org>
Date: Mon, 07 Sep 2026 15:24:38 +1000
In-Reply-To: <20260828112803.86636-2-subrahmanya.lingappa@oss.qualcomm.com>
References: <20260828112803.86636-1-subrahmanya.lingappa@oss.qualcomm.com>
 <20260828112803.86636-2-subrahmanya.lingappa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.150;
 envelope-from=alistair@alistair23.me; helo=fout-b7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Fri, 2026-08-28 at 16:57 +0530, Subrahmanya Lingappa wrote:
> Add a meson option and config probe for librpmi so RISC-V machines
> can
> opt into RPMI support when the library is available. Keep the
> dependency
> optional so default builds without librpmi continue to work.
>=20
> Signed-off-by: Subrahmanya Lingappa
> <subrahmanya.lingappa@oss.qualcomm.com>
> Reviewed-by: Daniel Henrique Barboza
> <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0Kconfig.host=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 +++
> =C2=A0meson.build=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 14 ++++++++++++++
> =C2=A0meson_options.txt=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 ++
> =C2=A0scripts/meson-buildoptions.sh |=C2=A0 3 +++
> =C2=A04 files changed, 22 insertions(+)
>=20
> diff --git a/Kconfig.host b/Kconfig.host
> index 933425c74b..6f98dadb2e 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -8,6 +8,9 @@ config LINUX
> =C2=A0config LIBCBOR
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0
> +config LIBRPMI
> +=C2=A0=C2=A0=C2=A0 bool
> +
> =C2=A0config GNUTLS
> =C2=A0=C2=A0=C2=A0=C2=A0 bool
> =C2=A0
> diff --git a/meson.build b/meson.build
> index 6dcfdceb50..1e1e19e655 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2018,6 +2018,17 @@ if lzo.found() and not cc.links('''
> =C2=A0=C2=A0 endif
> =C2=A0endif
> =C2=A0
> +librpmi =3D not_found
> +if not get_option('librpmi').auto() or have_system
> +=C2=A0 librpmi =3D dependency('librpmi', required: get_option('librpmi')=
,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 method: 'pkg-c=
onfig')
> +=C2=A0 if librpmi.found() and not cc.has_header_symbol('librpmi.h',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> 'rpmi_service_group_syssusp_create',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 de=
pendencies:
> librpmi)
> +=C2=A0=C2=A0=C2=A0 error('librpmi support requires the RPMI system suspe=
nd service
> group API')
> +=C2=A0 endif
> +endif
> +
> =C2=A0numa =3D not_found
> =C2=A0if not get_option('numa').auto() or have_system or have_tools
> =C2=A0=C2=A0 numa =3D cc.find_library('numa', has_headers: ['numa.h'],
> @@ -2440,6 +2451,7 @@ config_host_data.set('CONFIG_LINUX', host_os =3D=3D
> 'linux')
> =C2=A0config_host_data.set('CONFIG_POSIX', host_os !=3D 'windows')
> =C2=A0config_host_data.set('CONFIG_WIN32', host_os =3D=3D 'windows')
> =C2=A0config_host_data.set('CONFIG_LZO', lzo.found())
> +config_host_data.set('CONFIG_LIBRPMI', librpmi.found())
> =C2=A0config_host_data.set('CONFIG_MPATH', mpathpersist.found())
> =C2=A0config_host_data.set('CONFIG_BLKIO', blkio.found())
> =C2=A0if blkio.found()
> @@ -3272,6 +3284,7 @@ host_kconfig =3D \
> =C2=A0=C2=A0 (multiprocess_allowed ? ['CONFIG_MULTIPROCESS_ALLOWED=3Dy'] =
: []) +
> \
> =C2=A0=C2=A0 (vfio_user_server_allowed ? ['CONFIG_VFIO_USER_SERVER_ALLOWE=
D=3Dy']
> : []) + \
> =C2=A0=C2=A0 (hv_balloon ? ['CONFIG_HV_BALLOON_POSSIBLE=3Dy'] : []) + \
> +=C2=A0 (librpmi.found() ? ['CONFIG_LIBRPMI=3Dy'] : []) + \
> =C2=A0=C2=A0 (have_rust ? ['CONFIG_HAVE_RUST=3Dy'] : [])
> =C2=A0
> =C2=A0ignored =3D [ 'TARGET_XML_FILES', 'TARGET_ABI_DIR' ]
> @@ -4988,6 +5001,7 @@ summary_info +=3D {'TPM support':=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 have_tpm}
> =C2=A0summary_info +=3D {'IGVM support':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ig=
vm}
> =C2=A0summary_info +=3D {'libssh support':=C2=A0=C2=A0=C2=A0 libssh}
> =C2=A0summary_info +=3D {'lzo support':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 lzo}
> +summary_info +=3D {'RPMI support':=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 librpmi=
}
> =C2=A0summary_info +=3D {'snappy support':=C2=A0=C2=A0=C2=A0 snappy}
> =C2=A0summary_info +=3D {'bzip2 support':=C2=A0=C2=A0=C2=A0=C2=A0 libbzip=
2}
> =C2=A0summary_info +=3D {'lzfse support':=C2=A0=C2=A0=C2=A0=C2=A0 liblzfs=
e}
> diff --git a/meson_options.txt b/meson_options.txt
> index a07cb47d35..a65af0e633 100644
> --- a/meson_options.txt
> +++ b/meson_options.txt
> @@ -204,6 +204,8 @@ option('lzfse', type : 'feature', value : 'auto',
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'lzfse support fo=
r DMG images')
> =C2=A0option('lzo', type : 'feature', value : 'auto',
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'lzo compression =
support')
> +option('librpmi', type : 'feature', value : 'auto',
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'RPMI support')
> =C2=A0option('pvg', type: 'feature', value: 'auto',
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 description: 'macOS paravirtua=
lized graphics support')
> =C2=A0option('rbd', type : 'feature', value : 'auto',
> diff --git a/scripts/meson-buildoptions.sh b/scripts/meson-
> buildoptions.sh
> index c003985047..12179f6024 100644
> --- a/scripts/meson-buildoptions.sh
> +++ b/scripts/meson-buildoptions.sh
> @@ -140,6 +140,7 @@ meson_options_help() {
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libkeyutils=C2=A0=C2=A0=C2=A0=C2=A0 Li=
nux keyutils support'
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libnfs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 libnfs block device driver'
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libpmem=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 libpmem support'
> +=C2=A0 printf "%s\n" '=C2=A0 librpmi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 RPMI support'
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libssh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ssh block device support'
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libudev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Use libudev to enumerate host
> devices'
> =C2=A0=C2=A0 printf "%s\n" '=C2=A0 libusb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 libusb support for USB
> passthrough'
> @@ -376,6 +377,8 @@ _meson_option_parse() {
> =C2=A0=C2=A0=C2=A0=C2=A0 --disable-libnfs) printf "%s" -Dlibnfs=3Ddisable=
d ;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --enable-libpmem) printf "%s" -Dlibpmem=3Denable=
d ;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --disable-libpmem) printf "%s" -Dlibpmem=3Ddisab=
led ;;
> +=C2=A0=C2=A0=C2=A0 --enable-librpmi) printf "%s" -Dlibrpmi=3Denabled ;;
> +=C2=A0=C2=A0=C2=A0 --disable-librpmi) printf "%s" -Dlibrpmi=3Ddisabled ;=
;
> =C2=A0=C2=A0=C2=A0=C2=A0 --enable-libssh) printf "%s" -Dlibssh=3Denabled =
;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --disable-libssh) printf "%s" -Dlibssh=3Ddisable=
d ;;
> =C2=A0=C2=A0=C2=A0=C2=A0 --enable-libudev) printf "%s" -Dlibudev=3Denable=
d ;;

