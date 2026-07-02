Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32AAC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 16:38:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfKQY-0001Pi-Qn; Thu, 02 Jul 2026 12:38:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wfKQS-0001L1-VL; Thu, 02 Jul 2026 12:38:08 -0400
Received: from fout-b7-smtp.messagingengine.com ([202.12.124.150])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wfKQR-0000GL-4M; Thu, 02 Jul 2026 12:38:08 -0400
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id CE7EE1D0010A;
 Thu,  2 Jul 2026 12:38:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Thu, 02 Jul 2026 12:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1783010285; x=
 1783096685; bh=YPUMJ6x5J0FDtB/YlqKAxkM2D+U/4F2sSW88uVglKw4=; b=n
 N3c2K3u+J1sPZEgkOuL9dk5I0rxCplwmHjrHdsDaSoJMxlu0UwG3s7+/bvd+JYYQ
 5wlu73FFKmUQLJNdP7p2nG+lB1RDHDqMGOmMqzqdd5xIN8Bmvgsfr1R/8LgTiZDO
 XMr3lOlNMVB1NYi2rcO9ZgOK2fE3H52n5GAQXjC90TKcGmV/pDzJ2aIeUiaTri+d
 v3k7ebcXAKC3KzuZETfvWRRrgw6ed1FeFIYwMOFpd21X3I5zNoWV9X0t08gPVYDd
 BI6PxqisBbrICO5cl2wvQCMPDJS6VYXOHyyhX34dBMLdKZ65VnZmQfA7gMj78w+l
 hFVBS6TpDVrW2MnJAM5Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1783010285; x=1783096685; bh=YPUMJ6x5J0FDtB/YlqKAxkM2D+U/4F2sSW8
 8uVglKw4=; b=XdP6q1XRlTS42Rh6eBLWmflz0tzeW4Bm+45l4OnruaHTc9Md8zc
 HzdVh+CJo+e/oWN50XOYngkc8k/SSGFvhKA+E4MwsAOd/+b1G0UMNNy7cIoM0D8D
 Juyotho73XQ/j6ep9BsrFiwpXd9MTG8DP0BoYmdhNBA3aj1bCzPDuDrdB05EfCES
 QSKWaxFm8qzFv7l8Uthyrb86YdiMf29+nxnNzqRai+nRWAUtGGrFPOGxFQqcxWVZ
 U7S3hmtSJfEwcIuNq1fLuPtBgpllG8XTa88j+xezm3CE4VM90ZfTEB63PFn/wgrD
 qhH2H2Z/Rdp+pGlHft+6yu0dZjVSuNokySA==
X-ME-Sender: <xms:7ZNGajOef_x_L3TW5ONil9TCUZx07P2WAg3BVK3adSJXj0RG3bB0Sw>
 <xme:7ZNGaj-lfhTo7RVUD-Kf8oHT0ULlzxPb0YQKTcXQVc2UZwaCkFI8zMqdipbB2tPT4
 fE0Dk0LehkFuiyyEJXBaKS9dyFG5rR4MIDmboqfna9zmr46eLXiB9A>
X-ME-Received: <xmr:7ZNGatFeNw7pom-kp7Sow5SCEaWQmOpmVlAlniRm2GrEKjpynQbyDzOAT3J-Mq7p2opFAdetYkC55cUmkOFIe0rahWLr6Hc>
X-ME-Proxy-Cause: dmFkZTGKnLtvPQWTamfnK7Fcc3+578RiGqYhEgHyqteocUDNtVJHWfy39HkjDGuhkhXI2h
 iz3qdBFmyKg052Ommh6BuYrZwaHVVGKJUNMxDXrWfvJVmtRQs32YPv/tAh2YpoGYB8Bvzs
 8ljURvAo+Ewv2Jg1TIzmSxLGcYSbOCIMnsOrAuUPzJTXBE2HjVMZ+2eEQykdC+lGal1Lec
 Bt2GmNt7J9Dow5fROapIbPXktEWNdEnVdY2QXs54us3crwJG8B2RrWMWjZSDn5JeD5JsLV
 tPBbpcJsmNVeZWCS+MciE/r8mpiWb3s5s9+qmlJe6yXvKtA8EpncchRWd354p8ev5/lVQH
 a6tT4XYRXxoGtptIhJehAiMWriVd3dmrjRlT0joejvOTpoMYExrZB9Tx2Jl9o6FnIH4F70
 5Hp1BlicIvtuTxMk7DVHelvDxiO8wiGEWL+RBTCawALAEmSiAA4BI8UVQT8YrHmsj3RI1L
 an3A4/pB+lO992GuSQNfhnm5pnyHUNew4x9s8egtSZg1+l1GXS5unDBo+TRsTCQN9+2hsR
 J+9iTFxa4BclK4JnpJn1Zd5n0uRy80C5k4U71Rwh1yuNQ0YQ3FRIwWU+LKqCH66NgE732b
 sxjCLTE4+7/JYL42yMzM3ww73X7eceYNm/YvjKjJbDgw9Gd5pAJiB6qs5wxA
X-ME-Proxy: <xmx:7ZNGaqg14TXH22XfI2-QFeclb9tVNstfDrE-W9BHJyc0sC8X4YPcOA>
 <xmx:7ZNGaquKc_eiv0X2RKx-g3aQ3Y3rq3-NGQHtdNlI8c_m923J5juUQQ>
 <xmx:7ZNGatsy5KwW7rQ9zpGxYhzMfO4ASh_sCM-Z3RFEWGlbEDvcqIYBkA>
 <xmx:7ZNGavGsDGZXs383bq6E4-kPGrs2lTKo1t9u9TsnGPbL6s-ulVJ9Ig>
 <xmx:7ZNGauLKTxg6oT2vMod9yAUs08my07iVmd3yhbi6ktzl1RwA4d92dcIf>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Jul 2026 12:38:04 -0400 (EDT)
Date: Thu, 2 Jul 2026 18:38:03 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Jesper Devantier <foss@defmacro.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v4 0/2] hw/nvme: add monitor commands for inspecting state
Message-ID: <akaT68VgedRDLQU-@AALNPWKJENSEN.aal.scsc.local>
References: <cover.1782819251.git.mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z+zeJHobSGqADqP6"
Content-Disposition: inline
In-Reply-To: <cover.1782819251.git.mateusz.nowicki@posteo.net>
Received-SPF: pass client-ip=202.12.124.150; envelope-from=its@irrelevant.dk;
 helo=fout-b7-smtp.messagingengine.com
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

--Z+zeJHobSGqADqP6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 30 11:52, Mateusz Nowicki wrote:
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
> Changes in v4:
>   - Drop the v3 attempt to gate the new commands with
>     'if': 'CONFIG_NVME_PCI'.  CONFIG_NVME_PCI is a device symbol and
>     is poisoned in common code, so the generated qapi-introspect.c
>     failed to build (reported by Klaus Jensen).  Instead the x-query
>     commands stay unconditional and hw/nvme/monitor-stub.c provides
>     qmp_x_query_nvme[_queues]() stubs, built when CONFIG_NVME_PCI is
>     not set, so targets without NVMe (e.g. riscv64-softmmu) link.
>=20
> Changes in v3:
>   - hw/nvme/meson.build: keep the source file list alphabetically
>     sorted (Markus).
>=20
> Changes in v2:
>   - hw/nvme/meson.build: add the missing trailing newline (Markus).
>   - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
>     Armbruster on both patches.
>=20
> v3: https://lore.kernel.org/qemu-devel/20260626112116.7621-1-mateusz.nowi=
cki@posteo.net/
> v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.nowic=
ki@posteo.net/
> v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.nowic=
ki@posteo.net/
>=20
> Mateusz Nowicki (2):
>   hw/nvme: add 'info nvme' HMP command
>   hw/nvme: add 'info nvme-queues' HMP command
>=20
>  hmp-commands-info.hx   |  28 +++++++++
>  hw/nvme/meson.build    |   4 +-
>  hw/nvme/monitor-stub.c |  21 +++++++
>  hw/nvme/monitor.c      | 139 +++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json      |  34 ++++++++++
>  5 files changed, 225 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor-stub.c
>  create mode 100644 hw/nvme/monitor.c
>=20
> --=20
> 2.53.0
>=20
>=20

Thanks for the fix, back in nvme.next :)

--Z+zeJHobSGqADqP6
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmpGk+sACgkQTeGvMW1P
DekB2Af9Gjr0k5JL9Bm/sYaZ2e+MOfYafM3WZmCOwlXMettOzcs/hGV6R9Ze9PM8
9Q3j7mtc0oYCC5FlRpdtCXfvCo38yzIxlrnRwKI/do2LBdBjWw0QMFVesQMT1Fh3
VF9hIajBNvDTvR70mn8qWrXyEPgnUcc74DQ7YbzPAKV1E64N91/NDsXZJFVEOCS7
5JUMnHzKmoads2hYuiKi6seQtC3uQ0H8Dd2f/eoxT0bYOpIlhEbqum6HgMPsSjjj
Bq4o5XppySdJ8G11oox5OaqxQzKtGAkdFiv8l81ukEKvtMxLVvjoK64VlSWsbSKN
s8KRObKaCsQ3IjM/Qg96SQioqUEN6Q==
=1/de
-----END PGP SIGNATURE-----

--Z+zeJHobSGqADqP6--

