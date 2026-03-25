Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 781B9109C04A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 17:23:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RwO-0003Rb-S1; Wed, 25 Mar 2026 13:22:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RwN-0003RF-2d
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1w5RwL-0006iK-Iu
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 13:22:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774459364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dSIoGAELBOvDIlGwV55y3aa6QDjd6egehwXD3AnnjIo=;
 b=MvV67YpXL1mTnn7eoyOUqv/n4owj7eCBjUZryiojqWEjftoVYOqMxrHqBBayHkFM9QDGPa
 p1UNTgJNnXlQGZDwNTg3bsUzykvBxh1TZVvkLfiySnxeH/BjqgBw7E47HY1K1fuH+fd8I4
 KeC1khkX4+X6r9NY3uWXMR2+gqLWgkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-LQCubnE-NjqWwi3vhB8fOg-1; Wed,
 25 Mar 2026 13:22:41 -0400
X-MC-Unique: LQCubnE-NjqWwi3vhB8fOg-1
X-Mimecast-MFC-AGG-ID: LQCubnE-NjqWwi3vhB8fOg_1774459360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B3071800464; Wed, 25 Mar 2026 17:22:39 +0000 (UTC)
Received: from localhost (unknown [10.44.32.10])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B6971800671; Wed, 25 Mar 2026 17:22:37 +0000 (UTC)
Date: Wed, 25 Mar 2026 13:22:36 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, mjrosato@linux.ibm.com,
 farman@linux.ibm.com, pbonzini@redhat.com, fam@euphon.net,
 armbru@redhat.com, eblake@redhat.com, berrange@redhat.com,
 eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v2 1/3] aio-poll: avoid unnecessary polling time
 computation
Message-ID: <20260325172236.GC701300@fedora>
References: <20260323135451.579655-1-jhkim@linux.ibm.com>
 <20260323135451.579655-2-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LxvD6HeDdU0Cyk9I"
Content-Disposition: inline
In-Reply-To: <20260323135451.579655-2-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--LxvD6HeDdU0Cyk9I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2026 at 08:54:49AM -0500, Jaehoon Kim wrote:
> Nodes are no longer added to poll_aio_handlers when adaptive polling is
> disabled, preventing unnecessary try_poll_mode() calls. Additionally,
> aio_poll() skips try_poll_mode() when timeout is 0.

Skipping when timeout is 0 seems risky to me. VIRTIO devices disable
guest kicks when polling mode is started. When aio_poll(ctx,
blocking=false) is called, we will skip polling and
ctx->fdmon_ops->need_wait(ctx) won't detect an event either. aio_poll()
will return without noticing that the VIRTIO device's AioHandler is
ready.

Is skipping when timeout 0 necessary for performance or can it be
dropped from the patch?

Aside from this:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--LxvD6HeDdU0Cyk9I
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnEGdwACgkQnKSrs4Gr
c8gDswf/VHG8Jm8G0ZuMOl9gsLWmfjLyM5/cX/F4kNgleljTcpIgly+CrrJWwOsi
mhcHN1e9IqiZOc3QZxBF0YTDuob4BBr6EZ/yXty7S1mxnhMVGAOtpj3JqCT0u4uU
2Z7CL+buiwfdtUMHDdOf9yxCvMvpFjAgcsyWlpcdmx7YecrZ5WNG5UJH/FGa3YlT
ae3A/Y2QjOYCzLCjs9Imrf4UGKCUWN2pe2a50aiWNRIrj1ZiB4EFEJFqLDVlKtYC
WoGO9+UaFkNfG1d9o2G7zKGSavPDeCnf6G6Me9NW14kqJwxsbkzLCG/XLQ19gPJQ
LMGCdmNEyeWuVw5ZKh1soo8E1tpIZg==
=pnUL
-----END PGP SIGNATURE-----

--LxvD6HeDdU0Cyk9I--


