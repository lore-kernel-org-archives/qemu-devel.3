Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXxK-0006bb-Gp; Wed, 08 Apr 2026 14:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAXx7-0006Q6-Py
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:48:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wAXcb-0003pC-Qw
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:27:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775672843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gccVHlOBpy+pQvIgdkZHIOgU/hn+ayZspcjVDxBg0Tc=;
 b=HXOKajyoIDQuYg1VL4HqNmugKoSM83jsKVk9oMbcq5Pedqwl2qWwtBYYEQRwVqzc6uqkmG
 8+OmLJMa8NOTezR6L/ZIpVrzi2WDho6+D4Wmw1S/o/VpjZa+eYjAJWPLMq62tNoM95U67J
 3PqyyeMsptowr6/b/XP6ERviQQcSKGg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-CJQ4qRCFMNaW-9Xs1cfNNQ-1; Wed,
 08 Apr 2026 14:27:17 -0400
X-MC-Unique: CJQ4qRCFMNaW-9Xs1cfNNQ-1
X-Mimecast-MFC-AGG-ID: CJQ4qRCFMNaW-9Xs1cfNNQ_1775672835
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 922F618005BA; Wed,  8 Apr 2026 18:27:13 +0000 (UTC)
Received: from localhost (unknown [10.44.48.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CA2BB19560A6; Wed,  8 Apr 2026 18:27:10 +0000 (UTC)
Date: Wed, 8 Apr 2026 14:27:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Jesper Devantier <foss@defmacro.it>,
 Klaus Jensen <its@irrelevant.dk>,
 =?iso-8859-1?Q?St=E9phane?= Graber <stgraber@stgraber.org>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Fam Zheng <fam@euphon.net>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH v5 7/8] hw/nvme: add basic live migration support
Message-ID: <20260408182708.GA319710@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
 <20260407154803.GB238768@fedora>
 <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l5pW4oqIFRUCRvKh"
Content-Disposition: inline
In-Reply-To: <CAJqdLroJk_EmciJQvYPsywpaOoyFSyNf67DGpOJMGpr+MuhQFg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


--l5pW4oqIFRUCRvKh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2026 at 09:02:26PM +0200, Alexander Mikhalitsyn wrote:
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
> So, I tend to agree that this busy wait is probably not required, but
> I believe that we still need to verify that sq->out_req_list
> is in fact empty. Because if we messed up, then it's better to crash
> on assert() than to have silent data corruption.
>=20
> Then after I have a loop cq->req_list, and this time it is absolutely
> required because we need to write all NvmeRequest
> results to CQ and free NvmeRequest structure, cause I didn't want to
> deal with NvmeRequest serialization.

I don't see how the busy wait approach can work since
migration_completion_precopy() holds the Big QEMU Lock
(bql_lock()/bql_unlock()) while .pre_save() is called. The main loop
thread's event loop will not be able to make progress while .pre_save()
is busy waiting.

Based on what you and Klaus have said, how about:
1. assert(QTAILQ_EMPTY(&sq->out_req_list))
2. Call nvme_post_cqes() from .pre_save() to write CQEs back to RAM.
   Whether or not cq->bh is cancelled too doesn't really matter.
3. Full CQs need to be handled. It will be necessary to serialize the
   remainder of cq->req_list them. Failing live migration for this
   reason is not acceptable from a user perspective.=20
   (virtio-scsi and virtio-blk have a mechanism for serializing failed
   I/O requests that need to be restarted after migration. There might
   be a nicer way to do this with vmstate nowadays, but they are at
   least two examples of how to serialize a storage controller's
   internal request state.)

Stefan

--l5pW4oqIFRUCRvKh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnWnfwACgkQnKSrs4Gr
c8hRNwgAkQi9DxgE5AyVyHy3dWK/t++h27lo0bJgqGcgKwUo84vbcYD0TKHFWMaL
+8BWIYeOJa3ogEfpVz1EZTTdQcfaweQryRcJcOdRTIQUuGuRwekHx+BCgiLc+Ybv
dYIYluk0H3frAhXOammnAfqINSLEMQIdWHO1gxEJ1ir2JerPD4hS/RzQMPACaJOs
QnlMEnIACVmQehzL0Jt/TqzlmrlgG9FQRGyOYMAK6Nbc7bq85pFJYLcAvjTBqLRd
mN/VacGaKu+VFSsQeugregz8c2C+1Zno1vRqy125Hw1zwVZa/zjtjeaGnww6yoUS
HTxXQkUjZDZlK9f25dLgsTW8KQXvtw==
=1QHx
-----END PGP SIGNATURE-----

--l5pW4oqIFRUCRvKh--


