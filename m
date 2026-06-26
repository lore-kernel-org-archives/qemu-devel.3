Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 227B5CDE008
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 08:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd1oJ-0003JS-1x; Fri, 26 Jun 2026 04:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wd1oG-0003Iw-US; Fri, 26 Jun 2026 04:21:12 -0400
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wd1oE-0008Fb-I1; Fri, 26 Jun 2026 04:21:12 -0400
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
 by mailfout.stl.internal (Postfix) with ESMTP id A50711D00024;
 Fri, 26 Jun 2026 04:21:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-09.internal (MEProxy); Fri, 26 Jun 2026 04:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1782462067; x=
 1782548467; bh=daj70LZLoT8/bDjV5FmNZqGE+iQu7Sw43HWZLZLZyJM=; b=b
 xw5TmvA2egAOX+hYI21pUWbXOx6Uv9/JorGsI2/e36du2FyVzK14WSSbSOkH53zW
 L77leuA0QLgzEi6BcaG4TQPHP6nzQnu8BChZvUcy31g0qidIPF618W5jfC2JrBfF
 EqRz4YQ3wbf5O6J38LNZuT8yO3pZOMEZQYpnzGYFKylRZTqVgF3bqA/A7XQqqmui
 RFLJiTApgwVcWhj9g3G+oTwVrlj9kaZ4IYilqQXKFrq7Qo4vql69+LMEjmZeAkhQ
 3LwH9aLiwC4Ww/1VjJhUjFC7N+SDt6hBU6CIspX+FFWcOwzClt+K8HDwTWBJ5ZY0
 Y0iI5/9cO/u/WQG8nRQdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1782462067; x=1782548467; bh=daj70LZLoT8/bDjV5FmNZqGE+iQu7Sw43HW
 ZLZLZyJM=; b=T22PVbuijD5OOmEurywI2GKvqYn0AoCrLQ2M6pfT7NX3POxWXyM
 IIOS1hTLRXkBJrsDZCHl5XcoMT4uFRcVggaP434PSkYXF9UlIcszRYL+rRu4oxPZ
 ypMZElKRiR57O6URTVzExAvtHlHhPwllfS6e57iplA79MCUPoghyvabVG++CzcfU
 ZsEECMc4YKvlpWmL1pN52eJQJbyoyH1T4BCu/DWNa7R2IPEItmwvJqQpZmikqc0m
 uEZOKyNGnriGfgg4wdLQtsDSIExfK+LtY1EE8cD/1KmIvX/AdS4DWb8kIWMkvI3K
 GosOeyS/b8/EdiXbKvAChNUdRZWNs7J24Xw==
X-ME-Sender: <xms:cjY-amR_690tG38icJc33Q0uRjyGq-o870730ZUAykYfGkwgU3gg_g>
 <xme:cjY-ahyN6xJqEzu46Z5s4MQUdKe9nCvhQm4G-R1nQi_TInRKD13HEnzZpMQlYrhxw
 wNkhZcmqq0Qym4K-dKW5HrcgMATIWRuChaieKfEEyoeLzwfk2NDUyA>
X-ME-Received: <xmr:cjY-auqloqAqzgEekfZIhSRlk74SRAQzaukTGL07P7wkPgwof_S4vHqJ_1OXOg>
X-ME-Proxy-Cause: dmFkZTGhcRprT/qk9fdQ1whBgsKkCGdNQxicgENxGTgcfyKgDh5E05WQrt0p+XKcJjpgeB
 BBAMoiJ+VtqJbIvLJouJhNj/9D+KnqxcTgj98q1rOnP01pHavhG+uhiH+cuUr4vZxPvEGU
 6RPiK5WIzHsWkRalnAThHwXM7ctRrReYSC5VqKjgxslpn24UHeuvp3dkwfs2EEhE8DDTeY
 lsFdHxXAryqrI3sdFX17m7GBAhCKQnnGxMS2MUZ0jHSx+5ki7aVD9+tr5ZUFGbu6E6Ay0L
 YTjBzgXPJS/Qn+PmLe60jkFBFjZ+fuzKqt6Rg20tkIQtoeljiQ2t4eupijQ8XTl55F4rW2
 2J1uTJ8ozNuKWMfGfM+PgE09EOnahVmJvvdyr8VBerJYZasywT/xKLQ6QQ8YL4BkrlPHBg
 rdO81FmeL4p0UrJg5+gCcx7uEG5HjhGIzirL+6osFzBPi0e6nGCeFHE/HozQawZCn9ipml
 s26oK0UM6NNIPHXG2VB0qvC/jdmlPb9YCJVo6jC8SLrILVIYkCwnALX34/pm3qvsd0yQt9
 ib4xvCVimXBD+qClvy3iMkBq/gYF5l0SBfgtIARIs7kAg8xR3TsvkKIQYQlbzl4++85Oxc
 s9R2o6gd3z0C125E617irl20lqoYspPKbPucN/nNVnVl/btSNujU/y1NflmA
X-ME-Proxy: <xmx:cjY-ak3xeiihJoJYtJdLh0I93vIq5WkoEDeSqS3sk_UttlJqezKkNg>
 <xmx:cjY-auytmnPEsQC8A8FjaJaMAFtlJ3IEowwqJIRanAvyrlSqb_Vt3A>
 <xmx:cjY-aoibJpGBB5xRjWdI8A3eP4smTqgzWv7JGrO8w5Kc4RKzF7IJbQ>
 <xmx:cjY-apqs2sU8DD_nQSxVldCoC92i5mw5NhJtDY_NMC-ovKlB-ZiFcw>
 <xmx:czY-ap-UabB9hsdBH2p288qnq9NYKKdbF5E41FkQ3XdwKVhFIDtoBmE4>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jun 2026 04:21:05 -0400 (EDT)
Date: Fri, 26 Jun 2026 10:21:04 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/nvme: HMP commands for inspecting emulated
 controllers
Message-ID: <aj42cGDJPEfZGizB@AALNPWKJENSEN.aal.scsc.local>
References: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
 <ajz5jeAm8Ts2PWyu@AALNPWKJENSEN.aal.scsc.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hpM5mctIxdDPkac9"
Content-Disposition: inline
In-Reply-To: <ajz5jeAm8Ts2PWyu@AALNPWKJENSEN.aal.scsc.local>
Received-SPF: pass client-ip=202.12.124.147; envelope-from=its@irrelevant.dk;
 helo=fout-b4-smtp.messagingengine.com
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


--hpM5mctIxdDPkac9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jun 25 11:49, Klaus Jensen wrote:
> On May 22 10:29, Mateusz Nowicki wrote:
> > Add two HMP commands for inspecting emulated NVMe controllers from
> > the QEMU monitor without attaching gdb to the QEMU process:
> >=20
> >   - 'info nvme'        - per-controller summary (PCI, identify
> >                          fields, CC/CSTS/AQA, queue counts)
> >   - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
> >                          (size, head/tail, PRP1, doorbell offset,
> >                          phase tag)
> >=20
> > Useful for verifying queue setup, doorbell rings, AERs held in the
> > admin SQ and similar driver/controller interaction details from a
> > running QEMU monitor.
> >=20
> > Changes in v3:
> >   - Iterate on n->conf_ioqpairs instead of n->params.max_ioqpairs so
> >     the listing reflects what the guest driver actually sees,
> >     including SR-IOV VFs where conf_ioqpairs is the negotiated subset
> >     (not max).  Same fix in both patches.  (Klaus)
> >=20
> > Changes in v2:
> >   - hw/nvme/meson.build: add the missing trailing newline (Markus).
> >   - Pick up Acked-by tags from Dr. David Alan Gilbert and Markus
> >     Armbruster on both patches.
> >=20
> > v2: https://lore.kernel.org/qemu-devel/cover.1778694320.git.mateusz.now=
icki@posteo.net/
> > v1: https://lore.kernel.org/qemu-devel/cover.1778409416.git.mateusz.now=
icki@posteo.net/
> >=20
> > Mateusz Nowicki (2):
> >   hw/nvme: add 'info nvme' HMP command
> >   hw/nvme: add 'info nvme-queues' HMP command
> >=20
> >  hmp-commands-info.hx |  28 +++++++++
> >  hw/nvme/meson.build  |   2 +-
> >  hw/nvme/monitor.c    | 139 +++++++++++++++++++++++++++++++++++++++++++
> >  qapi/machine.json    |  34 +++++++++++
> >  4 files changed, 202 insertions(+), 1 deletion(-)
> >  create mode 100644 hw/nvme/monitor.c
> >=20
> > --=20
> > 2.53.0
> >=20
> >=20
>=20
> Thanks, applied to nvme.next.
>=20
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

This seems to break CI, please take a look.

https://gitlab.com/birkelund/qemu/-/pipelines/2628581800


Thanks,
Klaus

--hpM5mctIxdDPkac9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmo+Nm0ACgkQTeGvMW1P
DempaQf+Orwpk7CnWdH0/7r+yiQw8V8ZJQM9G65vSgBZQpJV5p/rFZG8TZ9GQfaD
B6LbHufe3LLsGC32GG7sgvyoEeL3ZFlASXSNfR68ufsxozg0YZNmgq59oHyi5yz9
3WYmsqJXj3B/AJBbOixGD+kLrl94au/Pgy8+RGdZV+2VXspQJ1ajIduJxERVWFVQ
4wPoofKZRRcBk6+3x72NkRat1K5wtRTyQGYUXpjlbIWswc8pRmE01P4sXlaa/ZEq
kwwi93ofHmsoGYgwju2q56ur1YHaoTtamAzp2uTqDq24Wv9XjcCGPzhA50dVujST
WF6ErbNc/Z1kawi5XaM6LtWmzXgccg==
=PFK8
-----END PGP SIGNATURE-----

--hpM5mctIxdDPkac9--

