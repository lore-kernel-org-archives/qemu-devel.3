Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0406BD1BDD9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 18:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t81cn-0002lp-PN; Mon, 04 Nov 2024 13:16:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81c8-0002Yg-N3; Mon, 04 Nov 2024 13:15:50 -0500
Received: from fhigh-b5-smtp.messagingengine.com ([202.12.124.156])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <its@irrelevant.dk>)
 id 1t81c5-00055R-4q; Mon, 04 Nov 2024 13:15:42 -0500
Received: from phl-compute-08.internal (phl-compute-08.phl.internal
 [10.202.2.48])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 68E422540130;
 Mon,  4 Nov 2024 13:15:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-08.internal (MEProxy); Mon, 04 Nov 2024 13:15:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=irrelevant.dk;
 h=cc:cc:content-type:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm2; t=1730744139; x=
 1730830539; bh=A2f3X7IGTu83oPA15RMTeU8FaBa7kIhRp2LHBkGrTdo=; b=k
 5ZkzgTlj3VBHG3Lfuknt6+S43t951ecFY/Nw4CUxB22DtU7ZevHe2g8ShtlyO2Nn
 yx3FgctKGolHIc2FDzbuNwsv0TuUnMjG0ZwFg/HKKEUr2dwauGdc0v6YSSXGAy+4
 CDTHYyYPrVJN8ARUHT4jwmlfMu8M1QG+4b2PeR1wEwyKp2d1NpHcYdU36Pc1c3Dt
 BUw6qcIpTfR+EnBKCqzgifhLDu+k0czdGWTeHGaiUILiCW9zJVHZcw8S5ZxShR1R
 atPuwrvAfwDauVjbL0WNg6SpJQLR3cagEdR+er3yvMy51Ay0tFKzokYX7N/Np4LW
 mtmJCwAcDWC8D9ktJyLpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:subject:subject:to
 :to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
 1730744139; x=1730830539; bh=A2f3X7IGTu83oPA15RMTeU8FaBa7kIhRp2L
 HBkGrTdo=; b=gNvFDcpDUumZJ7LaLaiSfWzAsohe3hBzvMEIERGrhueDKXkpz3h
 XVBQ/za3cpp8DhpSrHgNR+SpExVWGQPIvaIXxM7Rpimhl88l7QJbvByef3eCd0CE
 69ivKNS7O2zHm9E36khDxVMYlYmxzSk6lYzqKgeOXS5AuNQ+kh+BkjdKeBJ5Cn+K
 yqhaGXK9ULwa8YP5FERGSMmRbnNIVzhs1v6PXip2gYp4fjkgx/YDI8QEJ1OR72o7
 1SKJDIBWt2jj0RzsVXsMLDvb/ZFuSEZXiOt7VJkvu90ywBQoQaEUQt8OC7Hd15Tc
 qxkyn+BDrRinUo9KgudCLU6g4TCiJ2L+U5A==
X-ME-Sender: <xms:Sw8pZ7aYxfSNkFRDMCQ4K39SJ3XdvOh3e6ux1EEuUH79IYJIcPco6Q>
 <xme:Sw8pZ6alE6Pe7yuT_uEr8yc9KEiE26Ijj_Figk4fKzuOHpQW25j2MPralBMkfrZuY
 clQvcE4zFNpE-c_dH0>
X-ME-Received: <xmr:Sw8pZ98DmbYb4DIj0O9iwMlcMhyV7J1E46Bn8W2PKcCO-JVE62M4EXt293fLqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeliedguddtkecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
 uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
 hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdej
 necuhfhrohhmpefmlhgruhhsucflvghnshgvnhcuoehithhssehirhhrvghlvghvrghnth
 drughkqeenucggtffrrghtthgvrhhnpeefvdeffedvuddvkeetjeffiedvffeugfetgfev
 udegkefgieehleeifedtlefhjeenucffohhmrghinhepghhithhlrggsrdgtohhmpdhkvg
 hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
 fhhrohhmpehithhssehirhhrvghlvghvrghnthdrughkpdhnsggprhgtphhtthhopeekpd
 hmohguvgepshhmthhpohhuthdprhgtphhtthhopehksghushgthheskhgvrhhnvghlrdho
 rhhgpdhrtghpthhtohepfhhoshhsseguvghfmhgrtghrohdrihhtpdhrtghpthhtohepqh
 gvmhhuqdgslhhotghksehnohhnghhnuhdrohhrghdprhgtphhtthhopehqvghmuhdquggv
 vhgvlhesnhhonhhgnhhurdhorhhgpdhrtghpthhtohepkhdrjhgvnhhsvghnsehsrghmsh
 hunhhgrdgtohhmpdhrtghpthhtohepqhgvmhhuqdhsthgrsghlvgesnhhonhhgnhhurdho
 rhhgpdhrtghpthhtohepjhifkhhoiigrtgiiuhhksehgmhgrihhlrdgtohhmpdhrtghpth
 htohepihhtshesihhrrhgvlhgvvhgrnhhtrdgukh
X-ME-Proxy: <xmx:Sw8pZxpsGHG7sFfwe11fv5NWYKpogOVtCuMP3MXvBeHcmTrjB7LO2w>
 <xmx:Sw8pZ2onwYi3UDbVKMmNgiWiyynLhQmzzhhyLpbY1rGHkYKq1S9UsA>
 <xmx:Sw8pZ3SgRYaW6xX8kE4CN30JLuhPozZOoi0JCfH9vBnFn47kXtx4jg>
 <xmx:Sw8pZ-oaW6-xSTMUywDI6HF0r2xdf2aX9hmx-MrjKG_9vXBMB6Qb9A>
 <xmx:Sw8pZyeinCf9oAhUnA0qmB3MpExX9_MrPi7gfTYPbJhXTnldFn6DQZbe>
Feedback-ID: idc91472f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Nov 2024 13:15:38 -0500 (EST)
Date: Mon, 4 Nov 2024 19:15:37 +0100
From: Klaus Jensen <its@irrelevant.dk>
To: Keith Busch <kbusch@kernel.org>, Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Klaus Jensen <k.jensen@samsung.com>, qemu-stable@nongnu.org,
 Waldemar Kozaczuk <jwkozaczuk@gmail.com>
Subject: Re: [PATCH v2] hw/nvme: fix handling of over-committed queues
Message-ID: <ZykPSWjwhLPe1K3h@AALNPWKJENSEN.aal.scsc.local>
References: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="DCRh0ozZzAtltWBB"
Content-Disposition: inline
In-Reply-To: <20241029-issue-2388-v2-1-e335658104cf@samsung.com>
Received-SPF: pass client-ip=202.12.124.156; envelope-from=its@irrelevant.dk;
 helo=fhigh-b5-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--DCRh0ozZzAtltWBB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Oct 29 13:15, Klaus Jensen wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
>=20
> If a host chooses to use the SQHD "hint" in the CQE to know if there is
> room in the submission queue for additional commands, it may result in a
> situation where there are not enough internal resources (struct
> NvmeRequest) available to process the command. For a lack of a better
> term, the host may "over-commit" the device (i.e., it may have more
> inflight commands than the queue size).
>=20
> For example, assume a queue with N entries. The host submits N commands
> and all are picked up for processing, advancing the head and emptying
> the queue. Regardless of which of these N commands complete first, the
> SQHD field of that CQE will indicate to the host that the queue is
> empty, which allows the host to issue N commands again. However, if the
> device has not posted CQEs for all the previous commands yet, the device
> will have less than N resources available to process the commands, so
> queue processing is suspended.
>=20
> And here lies an 11 year latent bug. In the absense of any additional
> tail updates on the submission queue, we never schedule the processing
> bottom-half again unless we observe a head update on an associated full
> completion queue. This has been sufficient to handle N-to-1 SQ/CQ setups
> (in the absense of over-commit of course). Incidentially, that "kick all
> associated SQs" mechanism can now be killed since we now just schedule
> queue processing when we return a processing resource to a non-empty
> submission queue, which happens to cover both edge cases. However, we
> must retain kicking the CQ if it was previously full.
>=20
> So, apparently, no previous driver tested with hw/nvme has ever used
> SQHD (e.g., neither the Linux NVMe driver or SPDK uses it). But then OSv
> shows up with the driver that actually does. I salute you.
>=20
> Fixes: f3c507adcd7b ("NVMe: Initial commit for new storage interface")
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2388
> Reported-by: Waldemar Kozaczuk <jwkozaczuk@gmail.com>
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> ---
> Changes in v2:
> - Retain cq kick on previously full queue
> - Link to v1: https://lore.kernel.org/r/20241025-issue-2388-v1-1-16707e0d=
3342@samsung.com
> ---
>  hw/nvme/ctrl.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
>=20
> diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
> index f4e89203c1a6e3b051fd7185cbf01ec9bae9684a..1185455a94c4af43a39708b1b=
97dba9624fc7ad3 100644
> --- a/hw/nvme/ctrl.c
> +++ b/hw/nvme/ctrl.c
> @@ -1520,9 +1520,16 @@ static void nvme_post_cqes(void *opaque)
>              stl_le_p(&n->bar.csts, NVME_CSTS_FAILED);
>              break;
>          }
> +
>          QTAILQ_REMOVE(&cq->req_list, req, entry);
> +
>          nvme_inc_cq_tail(cq);
>          nvme_sg_unmap(&req->sg);
> +
> +        if (QTAILQ_EMPTY(&sq->req_list) && !nvme_sq_empty(sq)) {
> +            qemu_bh_schedule(sq->bh);
> +        }
> +
>          QTAILQ_INSERT_TAIL(&sq->req_list, req, entry);
>      }
>      if (cq->tail !=3D cq->head) {
> @@ -7950,7 +7957,6 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr add=
r, int val)
>          /* Completion queue doorbell write */
> =20
>          uint16_t new_head =3D val & 0xffff;
> -        int start_sqs;
>          NvmeCQueue *cq;
> =20
>          qid =3D (addr - (0x1000 + (1 << 2))) >> 3;
> @@ -8001,19 +8007,16 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr a=
ddr, int val)
> =20
>          trace_pci_nvme_mmio_doorbell_cq(cq->cqid, new_head);
> =20
> -        start_sqs =3D nvme_cq_full(cq) ? 1 : 0;
> -        cq->head =3D new_head;
> -        if (!qid && n->dbbuf_enabled) {
> -            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPEC=
IFIED);
> -        }
> -        if (start_sqs) {
> -            NvmeSQueue *sq;
> -            QTAILQ_FOREACH(sq, &cq->sq_list, entry) {
> -                qemu_bh_schedule(sq->bh);
> -            }
> +        /* scheduled deferred cqe posting if queue was previously full */
> +        if (nvme_cq_full(cq)) {
>              qemu_bh_schedule(cq->bh);
>          }
> =20
> +        cq->head =3D new_head;
> +        if (!qid && n->dbbuf_enabled) {
> +            stl_le_pci_dma(pci, cq->db_addr, cq->head, MEMTXATTRS_UNSPEC=
IFIED);
> +        }
> +
>          if (cq->tail =3D=3D cq->head) {
>              if (cq->irq_enabled) {
>                  n->cq_pending--;
>=20
> ---
> base-commit: fdf250e5a37830615e324017cb3a503e84b3712c
> change-id: 20241025-issue-2388-bd047487f74c
>=20
> Best regards,
> --=20
> Klaus Jensen <k.jensen@samsung.com>
>=20

Ping. Tested, but would appreciate a review ;)

--DCRh0ozZzAtltWBB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUigzqnXi3OaiR2bATeGvMW1PDekFAmcpD0kACgkQTeGvMW1P
DelwEwf/aXEngXSvfQc6yUK1qdWyAdo8vHqB0DEWncHE4CYlK+yWWz9sgPpk0/3+
CcVH85cxGnaMM+Aew+MVCkp+R+HhTy/VQvRb1IivI1JyC42SrWxCj/SLkznlU/sM
4dqFrMos7J29zFRD3YvRSP0TycYaxn6jLilRDrA0MIDo0nt/YEP7/D3tLvannPdV
sJbod4X9Xus+n2Mi+u5D0avdIT+JcfGP5jATk6VihTLdiODDGD48ie/MeRTuSE97
0yH7Rimr8JucqDMjvFY9nutZFKJIRnoKXK6gFg/pVvqijFHY63QwK0NMkmwAG6A9
4x6xheKt0lgnbzSSPMCW8qC2eGrj4g==
=HYpL
-----END PGP SIGNATURE-----

--DCRh0ozZzAtltWBB--

