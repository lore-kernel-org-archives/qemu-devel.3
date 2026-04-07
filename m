Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3612FFF5135
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUM-00069W-4q; Tue, 07 Apr 2026 14:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wABSG-0003JL-Ls
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wA8f3-0000dV-C9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 11:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775576896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/WtDDYCH30MLlkAsE+toTlNmLHxZNuJfcuL63QotBFs=;
 b=FJWxrL3IF+slN+rQkTZym0YGZOeyImFZczCNLlNeliTSuCNUTtVZjjTZP7FrY6rMgE+anH
 n/DmDtXgFSjaaHxnpsgQ8mlMQ3Fw1pbSv3kWP+G1MXzMAEXDifUsFI7FeUMT2FHpbqOH82
 5VIwjVHEP7ALwGqXPnMKrySldlm7Sek=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-k6sSRjOdO2CrdoSRDJZgLQ-1; Tue,
 07 Apr 2026 11:48:12 -0400
X-MC-Unique: k6sSRjOdO2CrdoSRDJZgLQ-1
X-Mimecast-MFC-AGG-ID: k6sSRjOdO2CrdoSRDJZgLQ_1775576889
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC33318002E5; Tue,  7 Apr 2026 15:48:08 +0000 (UTC)
Received: from localhost (unknown [10.44.34.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 84AD8180035F; Tue,  7 Apr 2026 15:48:05 +0000 (UTC)
Date: Tue, 7 Apr 2026 11:48:03 -0400
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
Message-ID: <20260407154803.GB238768@fedora>
References: <20260317102708.126725-1-alexander@mihalicyn.com>
 <20260317102708.126725-8-alexander@mihalicyn.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sKp2MTVxKjtu18Kf"
Content-Disposition: inline
In-Reply-To: <20260317102708.126725-8-alexander@mihalicyn.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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


--sKp2MTVxKjtu18Kf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2026 at 11:27:07AM +0100, Alexander Mikhalitsyn wrote:
> +    /* wait when all in-flight IO requests (except NVME_ADM_CMD_ASYNC_EV_REQ) are processed */
> +    for (i = 0; i < n->num_queues; i++) {
> +        NvmeRequest *req;
> +        NvmeSQueue *sq = n->sq[i];
> +
> +        if (!sq)
> +            continue;
> +
> +        trace_pci_nvme_pre_save_sq_out_req_drain_wait(n, i, sq->head, sq->tail, sq->size);
> +
> +wait_out_reqs:
> +        QTAILQ_FOREACH(req, &sq->out_req_list, entry) {
> +            if (req->cmd.opcode != NVME_ADM_CMD_ASYNC_EV_REQ) {
> +                cpu_relax();
> +                goto wait_out_reqs;
> +            }
> +        }
> +
> +        trace_pci_nvme_pre_save_sq_out_req_drain_wait_end(n, i, sq->head, sq->tail);
> +    }

Emulated storage controllers usually do not drain requests themselves.
They rely on core migration code (e.g. migration_completion_precopy())
to stop vCPUs and call bdrv_drain_all_begin/end() to quiesce I/O. Why
does NVMe busy wait for requests here?

--sKp2MTVxKjtu18Kf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnVJzMACgkQnKSrs4Gr
c8h/mQf+MW6VlcPNfiPB2YtWOoWy4hJa5e9Dv9K7z57ODtvGFbzzNgPmgypI9bKy
ALAKZ3DcWfHIrCaCairw5A+8qEWNPDS5uW+I44AcNW3jgxtoKo3+SznL+2IHDLCl
J8Won+bZsNn/Vio6csVDLNqunfOB2s1rk05o9b8UgeFKx5R8dCjGV33L7QuTPebm
0+jUChntpmLEt+Ux+NPK46P1x+pgXmvRoJSQgK3D2IgUny9EL+g0UvAF/OfH8W2A
Vzb5ULYp66XkoJwq9d8V4Oyxiwit4xlfZMlw9KAR41e+pDiSmOnODHg/BrEe9P/b
qlrNlWgtqYuyJKjRedc8jrMNqMsdgw==
=eUr+
-----END PGP SIGNATURE-----

--sKp2MTVxKjtu18Kf--


