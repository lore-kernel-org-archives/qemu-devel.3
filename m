Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA8910F9974
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYJH-0007cs-3P; Wed, 08 Apr 2026 15:11:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wAYGh-0004HB-Hz; Wed, 08 Apr 2026 15:08:52 -0400
Received: from fhigh-a7-smtp.messagingengine.com ([103.168.172.158])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1wAMbc-00042Q-VE; Wed, 08 Apr 2026 02:41:42 -0400
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 925531400191;
 Wed,  8 Apr 2026 02:41:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-01.internal (MEProxy); Wed, 08 Apr 2026 02:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1775630499; x=
 1775716899; bh=AiE/0ztClLsC4oEIXywhujdJUDqUrolkBz7YUUVmrsw=; b=P
 9NiWmSMzAnJyDUS9a8VnFOYBB1QEW1pmcWJXiKsVSIdzvHIdszz9A4+sy/VdaEcp
 Pq5eC+8iDU8WrIpxhSxBXtKvWaeHwQSQfkw5T2i8jf5J5nA8H84A2n8nSbGcoXMX
 cBoY2rqo0fYgkWJp+XsVIhP01nE961v1trxkL+jlpg9nLmIbLo07hW6MHd7FLJ1V
 76DagUkzqUFrUydOKolxDwpx9/FXHCYrstI4CsBSVf513QkJjn+hJhEVXOWeSYDS
 jx1bq2dhUCtcsw3/5z3etIEulUlX2ZN+7lvzyZFFPj0TuG4G7z2qu+JqUu60EdIw
 eHsK3OAb6cvoMCXB+dI/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
 1775630499; x=1775716899; bh=AiE/0ztClLsC4oEIXywhujdJUDqUrolkBz7
 YUUVmrsw=; b=fN07h0WJDaYEO5Nyiu6S23qxMpjkazw3Rs77SrT7M6kMwS9tu90
 oEMx0q7/Ny98bH4AY/yJS7zxhdw/hsQxrGByzWtEZ/JmSDKLjSL9SdowEZ5dlj4J
 clUA6ggohj+QRqY/6EWNa3xNN/XIg1e89IOSiQcuPxbcvRiU3dtzmwkJsEWimGQ/
 SgID9xwGMTvuutYOcqF7B0DzsVenm4b7jCl2uf3TjjOghpjvMZjiFRi2pSF8nz6J
 Dk9kzZhCL8v2q6/apxMT1i5wTVN7+nRnINzlWz/Zxw3jmLQZtSb6esqo+zzRu1Ko
 pzOraVaSegp0OgY/lU2YnR5+b+UjxEyU/KA==
X-ME-Sender: <xms:ovjVaRsmlwS7YMsYSIgks4uCpMfevCEQRiFIYGStgnrEUPAXTJ_ucg>
 <xme:ovjVaQDbLv-tpkQVp6r-AgaCpC5JUPtC5S5--tFx4Ut_11G1rmdMxcXmWxkJbq4n0
 DSfN97sMzeCv7TSyKmP6IgIkjeG0taOxU8bkG0Wa5Li0zrSnY6aLNQ>
X-ME-Received: <xmr:ovjVaeXGBrj-eIe4Zb6K1t_QENR4mlsl_IlrPUb7vj8adC2YzAII75HOtC9R9LdYy48UQGAO_rIOYED3Fw74N216X7qhxEo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvvdekkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
 ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
 hrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefmlhgruhhsucfl
 vghnshgvnhcuoehithhssehirhhrvghlvghvrghnthdrughkqeenucggtffrrghtthgvrh
 hnpeejgfejfeffvdeuhfeifefhgffgueelhedukeevjeevtdduudegieegteffffejveen
 ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehithhsse
 hirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopedujedpmhhouggvpehsmhht
 phhouhhtpdhrtghpthhtoheprghlvgigrghnuggvrhesmhhihhgrlhhitgihnhdrtghomh
 dprhgtphhtthhopehsthgvfhgrnhhhrgesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 qhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopehpvghtvghrgi
 esrhgvughhrghtrdgtohhmpdhrtghpthhtohepfhgrrhhoshgrshesshhushgvrdguvgdp
 rhgtphhtthhopehfohhsshesuggvfhhmrggtrhhordhithdprhgtphhtthhopehsthhgrh
 grsggvrhesshhtghhrrggsvghrrdhorhhgpdhrtghpthhtohepqhgvmhhuqdgslhhotghk
 sehnohhnghhnuhdrohhrghdprhgtphhtthhopehhrhgvihhtiiesrhgvughhrghtrdgtoh
 hm
X-ME-Proxy: <xmx:ovjVaZGrNkJA76VJeFjBcv36LFaV5W68YyuZQUZv_-Gh65wz0-aHug>
 <xmx:ovjVaZNuE62cb1FohLYglyH15ffNpiqnInNSCxzhjCuwC1p1YIQiDw>
 <xmx:ovjVaVVyiGEh_O6ThzM018cWeJ3c4UEeAnf8Ea-cLRIgsZ43BBizSg>
 <xmx:ovjVaQxKLAonRuhMeFcaDjaPl-0F_5S7LuXqlZekqCxt1h2rHL5KRA>
 <xmx:o_jVaTwsekEj_eHdmlGW26e00jfx4RNQWKCv8n8ZGq3mMcP-3p3DFzHH>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Apr 2026 02:41:38 -0400 (EDT)
Date: Wed, 8 Apr 2026 08:41:37 +0200
From: Klaus Jensen <its@irrelevant.dk>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jesper Devantier <foss@defmacro.it>,
 =?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
Message-ID: <adX4oSW5u1k0nLOk@AALNPWKJENSEN.aal.scsc.local>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RTvK7Yapl5XbfB86"
Content-Disposition: inline
In-Reply-To: <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
Received-SPF: pass client-ip=103.168.172.158; envelope-from=its@irrelevant.dk;
 helo=fhigh-a7-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--RTvK7Yapl5XbfB86
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Apr  7 21:02, Alexander Mikhalitsyn wrote:
> Am Di., 7. Apr. 2026 um 17:48 Uhr schrieb Stefan Hajnoczi <stefanha@redha=
t.com>:
> >
> > On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wrote:
> > > +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYN=
C_EV_REQ) are processed */
> > > +    for (i =3D 0; i < n->num_queues; i++) {
> > > +        NvmeRequest *req;
> > > +        NvmeSQueue *sq =3D n->sq[i];
> > > +
> > > +        if (!sq)
> > > +            continue;
> > > +
> > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head=
, sq->tail, sq->size);
> > > +
> > > +wait_out_reqs:
> > > +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> > > +            if (req->cmd.opcode !=3D NVME_ADM_CMD_ASYNC_EV_REQ) {
> > > +                cpu_relax();
> > > +                goto wait_out_reqs;
> > > +            }
> > > +        }
> > > +
> > > +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->=
head, sq->tail);
> > > +    }
> >
>=20
> Hi Stefan,
>=20
> > Emulated storage controllers usually do not drain requests themselves.
> > They rely on core migration code (e.g. migration_completion_precopy())
> > to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. Why
> > does NVMe busy wait for requests here?
>=20
> I rely on core migration code to stop vCPUs and drain requests, *but*
> a challenge here is that
> a concept of "in-flight" request in NVMe is not that simple and we
> have a few different types of in-flight requests:
> - request was written in SQ (sq->head !=3D sq->tail) -> this I don't
> even consider as in-flight, because we just stop SQ processing
>   and these requests don't require any special handling during migration
> - request was taken from SQ by nvme_process_sq() and it now lives in
> sq->out_req_list - this means that
>   we have also initialized req->aiocb and submitted IO for processing
> in QEMU block layer. After request is processed, completion callback
>   will be called (for read/write requests it is
> nvme_rw_complete_cb()), then nvme_enqueue_req_completion() will be
> called and remove
>   NvmeRequest from sq->out_req_list and put it into cq->req_list.
>   I expect, that by the time when we enter nvme_ctrl_pre_save(),
> bdrv_drain_all_begin/end() were called and
>   all AIO is finished and sq->out_req_list is empty (except AERs).
> *But* to be on a safe side I also added busy loop on
>   sq->out_req_list.
>=20

Correct. When nvme_rw_complete_cb (and friends) returns, we still have
the completion laying around, not posted on the CQ. That is queued up
for a BH to handle to coalesce CQE posting.

> So, I tend to agree that this busy wait is probably not required, but
> I believe that we still need to verify that sq->out_req_list
> is in fact empty. Because if we messed up, then it's better to crash
> on assert() than to have silent data corruption.
>=20
> Then after I have a loop cq->req_list, and this time it is absolutely
> required because we need to write all NvmeRequest
> results to CQ and free NvmeRequest structure, cause I didn't want to
> deal with NvmeRequest serialization.
>=20

There is a subtle catch here. There may not be room in the CQ to post
all CQEs. For example, in the extreme, the host has allocated a CQ with
room for 1 entry (size 2) and several deep SQs all associated with the
same CQ. If the controller has nowhere to post CQEs, then we need to
either abort migration (and try again) or migrate the CQEs.

--RTvK7Yapl5XbfB86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmnV+KAACgkQTeGvMW1P
Deluxgf+P62CffzUNPFY9KzFaCGLCUAyj4cl9e94MjUERacflPwpj/39ksA55e5b
yartZ1YPZXnqe6EDYeG+YvFqCfqiQGJKLXczwYrmLMox80a5tjGjzhqKeSjeBSSf
KzJTR1ca+bQO2QYw4pjIeq2B5rZi7gSaHZLP9VpwvzA3mTGufFw/HpA2YhqBGOdZ
WyOrqDxQiSPAKhVXemdZCfYcj23pKit/EpvCqOd2q5/dVvq8Ghv/yTfSF1rREERH
KWmtf14DVI1ZyWpMJeq1W6QUzhqyURdvawCX33xaZPhYE1GuKozAbDKHg5xVUhb1
DDGeB0zMKZy1RPnJtrOWVokwPIvjrg==
=f3Ry
-----END PGP SIGNATURE-----

--RTvK7Yapl5XbfB86--

