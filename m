Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA68CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:50:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcghq-0004rY-Mx; Thu, 25 Jun 2026 05:49:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wcghp-0004r1-6X; Thu, 25 Jun 2026 05:49:09 -0400
Received: from fout-b6-smtp.messagingengine.com ([202.12.124.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wcghn-00037l-AW; Thu, 25 Jun 2026 05:49:08 -0400
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.stl.internal (Postfix) with ESMTP id 15B891D0012D;
 Thu, 25 Jun 2026 05:49:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-02.internal (MEProxy); Thu, 25 Jun 2026 05:49:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1782380943; x=
 1782467343; bh=stgugfb6aWOrZCaoOg91KE/7B8CpJr+RBROGiaTHL8I=; b=Z
 A3HrTCvjF80FY0AnCB80y6lMDiyYGijoMjm9QHYD+6mLgQ0iq0Q0z5b/pvbXOiah
 OdrVfLYcznkKXMLxgGZ9Da7y3qTKW/QQhUcoUWcsgP0mzBXm4H2UJAacCKgooYa7
 Lt90cmUVBQexB5iFMembuRL+2XahJDurnhqU4Ioh9YE0IBfSa4DEyg/R8uCByKpm
 sUWrhi+2QAzasMmY4Gea+rXgUVEDWyg51aM53S1YQvR1gRMp4yXyTDICArC1ggez
 u1VK5ANjuegdtTcfUAjrDCX2G2yYCmZ+ZF7cFRotQ67mSlnYXP/cF+H9Kti1uZbr
 7lTeWLUU5tA4sTIVPb1xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782380943; x=1782467343; bh=stgugfb6aWOrZCaoOg91KE/7B8CpJr+RBRO
 GiaTHL8I=; b=kbGdYKziHqa6hlMw1x193ADjIMVT1ysuxJEHwyjGim552zQuk7M
 xgg7UtUBL5j8Dh+1cIKJtcilNr9Qx0tqCCspfcosmGRTy63q7wkswF4s8tFk9piW
 hJ7O1WcBsRi6MqBfwnVC/xQTi/RdbM6RGud9jcuYLJbz76omnO1j7cxY6mEWcb/o
 aJ9Axs0Q2ijoLmRiD5CpETOBFTGj4+1W3ZIIpGxmP3R6wr1QJbq3I8L9m/PmhkI3
 D3wJk6aWKIHuYSZaY5rzGQ+jzPyGh88u95wVXr2NGuxMpZHhvyZ9u1RBDmjY2gzm
 CSbn1yHHtD6wcdJ+/DcXtWDoqdM5IT4uDhg==
X-ME-Sender: <xms:jvk8aqB1c1W0OU2eHYgRjbLRSnE6M68xopDTkBwRZ4tHUugghhk5GQ>
 <xme:jvk8aqhMWSbo8k0sD8wRRAyawG3qVyEQX2Iy3C06d-GH_xE4jlAEqqROAhjdvNP9T
 IWvTLjZb3FuUwnLUx0r4uFrqwhyeuVxfd0PjVahIvELuS_UrOMFr3it>
X-ME-Received: <xmr:jvk8aob8hH2hmVjp46Ijm2QGPlS5-6ask5Pdxbku2zPPdfU6a260pzDRYLZDGA>
X-ME-Proxy-Cause: dmFkZTFHyfei6RAPUUekzOV4XE1HvQXw09QhGnaJ0kYaYfQIlYcSqe2IJ22fJ8aZ1YiEq3
 IwIjVlmmLNL98k9xRblu5WRyZwIHsREJ6RlKV+0VghoxT2peIcOOKom3SGYzmYGLVkLrRy
 YzWraQ4dyU63AP+tjCMCd0Ih7i86faU/43i2bnEoQiiioKFZTgpOASha1YYGtXzwbAeqwN
 Rcv/0lo271ImZBCXpLxr4PTAiGlPtB9OOPdk8Ab8PpMV/M2CghTTt1zgSBL2Vu+PBiR/w7
 mOcPtTZnEO0K3UAT9R+AA0BSN1fnda5QIVo50xbsLUOGcJBKOdbbESOVKbIdwsx04ZqKpq
 DmaDsfbM36UO7TJhXs1r6gJg/XlXEFFZEhvDNzXiw0W+uq1csiIKYHmfHh3p06MBiq+TUL
 S1ZdBsR6JNCkVKnH2eCfX9PQZFlzBQ6OUczTnGErDYs8YX4VGLs+1fLrrb7o0dlKdclUGF
 2UkV7MdZr39CaTIXifXM6J71QkFcBW0CjyRfiOP355QuOXaOHFReoVxCkLWsbBq8IoZSNr
 9Nu9RACRcOxLJdgXJaT0b2urpEL4Rzj8gnAkv8g5aJ28v8LwD5loEJP/52q6RmCAWGsxoi
 f4muyw4zhEjMJmwzWpaLXP6JhZSi8spQ+Vf666CQP1D9mtkyKQHMwUaXSv/Q
X-ME-Proxy: <xmx:jvk8arn5ea6TDi8e-lqrx8MZrvghe4emn3dPtllJn9ZvoYO5MwR4BQ>
 <xmx:jvk8auhLUg66Ci3NC5at3MCybSkSf8fcsaXqryyhrHtzsRVo43ND5w>
 <xmx:jvk8atRHlZVgiYbOQzMe7rSWJLtJ6arZ_j9QbFxQ7QrW88MQgrHM2A>
 <xmx:jvk8avZQ1tX-Bjtmj1AG6tGvqEgdkTPzbBW0H5WVuwf1_6REZH1DeA>
 <xmx:j_k8aqtsjJydUiLH26ELyHdJZxADzWPD5eOgHo8W1GvhJlAIStLiGtIQ>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:49:02 -0400 (EDT)
Date: Thu, 25 Jun 2026 11:49:01 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/nvme: HMP commands for inspecting emulated
 controllers
Message-ID: <ajz5jeAm8Ts2PWyu@AALNPWKJENSEN.aal.scsc.local>
References: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DBw/3o+teOWIAoey"
Content-Disposition: inline
In-Reply-To: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
Received-SPF: pass client-ip=202.12.124.149; envelope-from=its@irrelevant.dk;
 helo=fout-b6-smtp.messagingengine.com
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


--DBw/3o+teOWIAoey
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On May 22 10:29, Mateusz Nowicki wrote:
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
>   - Iterate on n->conf_ioqpairs instead of n->params.max_ioqpairs so
>     the listing reflects what the guest driver actually sees,
>     including SR-IOV VFs where conf_ioqpairs is the negotiated subset
>     (not max).  Same fix in both patches.  (Klaus)
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
>  hmp-commands-info.hx |  28 +++++++++
>  hw/nvme/meson.build  |   2 +-
>  hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
>  qapi/machine.json    |  34 +++++++++++
>  4 files changed, 202 insertions(+), 1 deletion(-)
>  create mode 100644 hw/nvme/monitor.c
>=20
> --=20
> 2.53.0
>=20
>=20

Thanks, applied to nvme.next.

Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

--DBw/3o+teOWIAoey
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmo8+YoACgkQTeGvMW1P
Dekvjwf8CmN6zc3ob6xNogJCD3+BwfhqGnZSt/yAl3m5DKzZd29/N4MCLSTrdol/
ijuQvPvf0bk++VA7cBOhOL0HZ00gUWPtiCHzM/iPXoEC5Bwm8HMIbyNxJL+mULzD
Qctw+tTDkpdnX0J2Dl6r+vT25Dd7nv4pmDWu2/YJnTZXEa+qUdqwxiS14OqrU6sU
r9XnvLVZkkeO3YISB2R7fDnSUIN0JdoAAral2/25xj/gPzoUpUu/MXRbnYdjJwKm
tU00kkRZ5+tbC21U0ueC0oY/W/E9pKQOGMqaXZnOH6r8nUe12pAlubo5xkTXGl12
qMyeI23QXOmoYvYmbiHH8+zOFVD+Vw==
=cZJ9
-----END PGP SIGNATURE-----

--DBw/3o+teOWIAoey--

