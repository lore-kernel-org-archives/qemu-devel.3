Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223E3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 10:33:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weVlI-0001mE-Et; Tue, 30 Jun 2026 06:32:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1weVl9-0001lc-Rq; Tue, 30 Jun 2026 06:32:07 -0400
Received: from fhigh-b8-smtp.messagingengine.com ([202.12.124.159])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1weVl6-0000El-4a; Tue, 30 Jun 2026 06:32:06 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id D8DFC7A007F;
 Tue, 30 Jun 2026 06:31:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Tue, 30 Jun 2026 06:32:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1782815519; x=
 1782901919; bh=AcMS9OzUeOOJUP/YBmx/zB2Fq1k2uNovFLnkwEFa7/E=; b=V
 LW9Cd5p6iCDHAYSKE4J9sgyBd7K7UOf+QA73vnKQ4a4bVyuEAtGzBmaWpxK304sR
 5Ip00kba61GSnDXsYGS1cV9vV2GolBkkeOGFw+DOEV3w0NVJZBEKYdtu31m8PXXl
 mr7QqcYj5lcPTpb1Ts2dZbLImgDJtEr+60Ztai5YXAXZ5zeiFEshY2L+mW9MG7Hd
 WQyEZdv53kdJ05TF2Mwn6z5Zvtf4xnh34NWR5vF6+ajp963dWVzJcIyKieOmBznO
 35pY5rXO+h3wz7ik4OhEOfH1QO5En+PBnA0T6tROt4qlHVONppX9ZjWBZJHvDS1p
 Fy0JlEY15H6BSTxiBuqYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782815519; x=1782901919; bh=AcMS9OzUeOOJUP/YBmx/zB2Fq1k2uNovFLn
 kwEFa7/E=; b=EDtjh2eOIrvq3xPZZIMM8OgflNvg9alokApDIW0Nd1po0hHCQYw
 U9agmLKNPqyZMYpJWUcZO0rpktB2pZ8c1xYnqHsYrB80KDetryDcRNoa5crDMlEE
 0cItqwZiRJssNzQPGaaRisIPZixE8Cpic9CEPa8/Ft6dYCcgZdPMULbpNDA6BVlF
 5ebPyjfcpdZg8SqoaA8log2pIL5ySd7j9pn9B47FFG6TRWqmpom3TNGcepo94NWj
 BJYKTm4YrTW6SGeRspWRCg8XwN/+oiJhPsvvH6fZNY+KhH7cqc/7GKpze3eCzB09
 gxkGBl9SiInh3XJUEtXlNOe/GEN5Q2YnjVA==
X-ME-Sender: <xms:HptDaobPa6tKqbK5E_xgBdbScuCKS83Oz955YH1mE_8OekW3gplG6A>
 <xme:HptDapY35DXmYomDorE9xaT0v7cenDzunVUH3Kpk-f-GO7bs2uOOHr7jSGRl8EzMq
 jfZskHdhYlrT7fC7rCyYG85XzpphGD3pYya7xlbq7Dkxlx7hF74Lw>
X-ME-Received: <xmr:HptDatzXJOJbaMG0LFZk08St4l8TCQi2UlwOhVUay5QdlT_BWflfVjk0GkIX8w>
X-ME-Proxy-Cause: dmFkZTF0ICRrCWl0HDfvP2UKBMxVAFNKR5Erwlhj+k9QEpYWKGf0028+jc61gvAd35yL0Q
 KY0omSR83bIVJ30gLum54huxvhg00I047vHa2ETp5GBJ7XRuIFjcixNXTqH1GiWAV/n/75
 VZdNqXo6hdmWXCNmD8yURfyByaCyYs1dMZie7hFfuOpIpJl3JfhQofNra5+4qpKwU6PyDh
 jNvWZVQphGbUSH6+MFtgip3PDRQKyi/8ZicF5/xJpi9UxcsOBhFjYd3B6f/3aFouqRut/U
 WrU4qxTGYEWg8Lomf+IwxbUgxWZH6jkZEvTDdUPSkWZsRHJPwUc0kzcAvMWKcBTlozVxZU
 rBfh/275mLMZAn0YyDt4awGCWl7mOEBGkiyy0XCIYV7XU9tGeenVTYKKzfbVxo63dco2k3
 Y80JAj1p5fNtCvgDnV0SyixqKf6gtJKP3x09TnUFkzuGqXA9ZKC2GVY96mdgLNoGO7cwmK
 OJuJqEWMuNVbyooRE3fQh6KSk72clRaVGft0Fk8P+H9hhI0aLgMavKpoxAApVVv3LJlUIv
 VAvVTBHgCePbaztBSMDzTSbC9wPooqJHlj0TEUvc6Mkrh+LJPyVVhREvvPCv0o5bnDlpZ+
 2EQQpmk2l+ht1oav1VOVjE3i7BDpLsVj0pXg4EFsFH+dCr/VnlW7c/zGeUwg
X-ME-Proxy: <xmx:HptDaleh4ewW7ES1bO2VIsImhdNdiv5zopV-y9Rajap2AVwci1oJAg>
 <xmx:HptDai6etEoBCMyCVJyvrAXILEIMtC0TRFYNcfU5WzHv0Z9-AsGjGA>
 <xmx:HptDaqIz5S3UvkOezvmN1cYx0CcVUAotlavyC6FC0AmKSfsCmvw1pA>
 <xmx:HptDaqzLoIN3hu3xP9fimKW-ELDNGx_nWE_J3iOxG-xFPRgtpvA0Yw>
 <xmx:H5tDatlKODE7IQH3mAHaUP_8fGSj_ovPMkJxx2lbYHwRwKpkxTudAGux>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 06:31:58 -0400 (EDT)
Date: Tue, 30 Jun 2026 12:31:57 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/nvme: add monitor commands for inspecting state
Message-ID: <akObGmLY1mRSedwd@AALNPWKJENSEN.aal.scsc.local>
References: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nApFfMhECkHwgzGP"
Content-Disposition: inline
In-Reply-To: <20260626112116.7621-1-mateusz.nowicki@posteo.net>
Received-SPF: pass client-ip=202.12.124.159; envelope-from=its@irrelevant.dk;
 helo=fhigh-b8-smtp.messagingengine.com
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

--nApFfMhECkHwgzGP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 26 11:21, Mateusz Nowicki wrote:
> Add two HMP commands for inspecting emulated NVMe controllers from
> the QEMU monitor without attaching gdb to the QEMU process:
>=20
>   - 'info nvme'        - per-controller summary (PCI, identify
>                          fields, CC/CSTS/AQA, queue counts)
>   - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
>                          (size, head/tail, PRP1, doorbell offset,
>                          phase tag)
>=20
> Useful for verifying queue setup, doorbell rings, AERs held in the
> admin SQ and similar driver/controller interaction details from a
> running QEMU monitor.
>=20
> Changes in v3:
>   - Gate the new x-query-nvme[-queues] commands and their 'info'
>     counterparts behind CONFIG_NVME_PCI.  They were registered
>     unconditionally while the implementations live in hw/nvme/, so
>     targets built without NVMe (e.g. riscv64-softmmu) failed to link
>     with an undefined reference to qmp_x_query_nvme.
>   - hw/nvme/meson.build: keep the source file list alphabetically
>     sorted (Markus).
>=20
> Changes in v2:
>   - hw/nvme/meson.build: add the missing trailing newline (Markus).
>   - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
>     Armbruster on both patches.
>=20
> v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowic=
ki@posteo.net/
> v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowic=
ki@posteo.net/
>=20
> Mateusz Nowicki (2):
>   hw/nvme: add 'info nvme' HMP command
>   hw/nvme: add 'info nvme-queues' HMP command
>=20
>  hmp-commands-info.hx |  32 ++++++++++
>  hw/nvme/meson.build  |   2 +-
>  hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json    |  36 +++++++++++
>  4 files changed, 208 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor.c
>=20
> --=20
> 2.53.0
>=20
>=20

With this, my build complains about CONFIG_NVME_PCI being poisoned now:

qapi/qapi-introspect.c:1743:13: error: attempt to use poisoned =E2=80=98CON=
FIG_NVME_PCI=E2=80=99
 1743 | #if defined(CONFIG_NVME_PCI)
      |             ^
In file included from /home/kjensen/src/qemu/include/exec/poison.h:7,
                 from /home/kjensen/src/qemu/include/qemu/osdep.h:38,
                 from qapi/qapi-introspect.c:12:
=2E/config-poison.h:277:20: note: poisoned here
  277 | #pragma GCC poison CONFIG_NVME_PCI
      |                    ^~~~~~~~~~~~~~~
qapi/qapi-introspect.c:1756:13: error: attempt to use poisoned =E2=80=98CON=
FIG_NVME_PCI=E2=80=99
 1756 | #if defined(CONFIG_NVME_PCI)
      |             ^
=2E/config-poison.h:277:20: note: poisoned here
  277 | #pragma GCC poison CONFIG_NVME_PCI
      |                    ^~~~~~~~~~~~~~~


--nApFfMhECkHwgzGP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpDmxoACgkQTeGvMW1P
DekHRwf9HgKPKnNsf9lJMggaP9pw2aOsOI+nIz7gggJIgD0dJJQovgTRm9h4c8fy
FcFU8wxd4Bw3oE9mBZ3GGFHg6sz1B6yxeQFDRMZ+Ug5x7MaenMr5BJd+iR8MyPYB
uvuCubXYWWxpepQvsNh0PEqafTt2Ys/DbUIf+fbp0F0dZ1D1LQH8RyZkimVYK/P+
pm2fBENE4oPC0hDqg7g8ayaNaXMlRFmjA88ZYjxy+Ujwd6bVIVrC3OE4SmFh+G/C
ohIia3kHxhTaDuB/BtIEaXEavkniaeQDYD/hb8Rub0j7PIH2B49nzdnVDU93XJxL
7l/DsIPoM1Izphi107SzKFSqLgi9pQ==
=KxvM
-----END PGP SIGNATURE-----

--nApFfMhECkHwgzGP--

