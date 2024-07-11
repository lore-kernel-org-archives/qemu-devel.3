Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B20C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 13:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRtQY-0001jl-A7; Thu, 11 Jul 2024 09:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtQV-0001fD-J0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRtQT-0006gp-NU
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 09:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720702891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OmQEP0evxf2HNqltBgGwCejTHjD+TWys02mP8aNBLQU=;
 b=QH4toRrnUAUzvhkHgTqyQw4wfPp3zEHcZ9Vf7Rd5doBMcMaTDBlavtnmGQ5yfve26vR/pQ
 xOqLB3jvyHJftvmqbtYHJbumLeYWa7VsBiJEPVnRA0vDaOBVFN+OteOZQ3loDrPFuSzmGE
 QJmHFYvpT4UDtSe6Q8VcKhPyqf9IBHY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-sbaoQU7INryxM766yxGsrw-1; Thu,
 11 Jul 2024 09:01:26 -0400
X-MC-Unique: sbaoQU7INryxM766yxGsrw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDFCF1955F3E; Thu, 11 Jul 2024 13:01:20 +0000 (UTC)
Received: from localhost (unknown [10.39.192.146])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F37F03000181; Thu, 11 Jul 2024 13:01:18 +0000 (UTC)
Date: Thu, 11 Jul 2024 15:01:17 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Changqi Lu <luchangqi.123@bytedance.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com,
 hreitz@redhat.com, fam@euphon.net, ronniesahlberg@gmail.com,
 pbonzini@redhat.com, pl@dlhnet.de, kbusch@kernel.org,
 its@irrelevant.dk, foss@defmacro.it, philmd@linaro.org,
 pizhenwei@bytedance.com
Subject: Re: [PATCH v8 05/10] hw/scsi: add persistent reservation in/out api
 for scsi device
Message-ID: <20240711130117.GB16124@fedora.home>
References: <20240709024706.4108-1-luchangqi.123@bytedance.com>
 <20240709024706.4108-6-luchangqi.123@bytedance.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AvGj/o4G49FtHKvm"
Content-Disposition: inline
In-Reply-To: <20240709024706.4108-6-luchangqi.123@bytedance.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--AvGj/o4G49FtHKvm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 09, 2024 at 10:47:01AM +0800, Changqi Lu wrote:
> Add persistent reservation in/out operations in the
> SCSI device layer. By introducing the persistent
> reservation in/out api, this enables the SCSI device
> to perform reservation-related tasks, including querying
> keys, querying reservation status, registering reservation
> keys, initiating and releasing reservations, as well as
> clearing and preempting reservations held by other keys.
>=20
> These operations are crucial for management and control of
> shared storage resources in a persistent manner.
>=20
> Signed-off-by: Changqi Lu <luchangqi.123@bytedance.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>  hw/scsi/scsi-disk.c | 368 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 368 insertions(+)

Paolo: Please review this patch, I'm not familiar enough with hw/scsi/.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AvGj/o4G49FtHKvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmaP150ACgkQnKSrs4Gr
c8iLVggAu8oFmMNcAwVmOrPejQRFuq+ZvOsBYEsMWa3NHMJFmo38HSWrvUKRNWTr
PtMOKgirU2lO00eGRss+9uR0igxZRislh2fIdmiINDSO265xg0fbE1xDRew28ck6
RKSV1C1BGH1I5RsAIXK3g1fF6XVKmr4H8KcdYFXhnSIxtD79ve0jHDiS3x/TmKQW
ejGDoBH5pPx6YfP93YbmzwiLP+xHa9AbPyWUey2Qc+cbcCuH0ZDCQ8CqrH+HS9ah
l1dE3NthQmr2Gk3pDAahxtIpHqAdOX4OF6RUkbRItddB5KSeaxOS14PkXtG99WgM
FuzP6U1KSFNiaRsBXWlKawD/zIEKhA==
=hwDm
-----END PGP SIGNATURE-----

--AvGj/o4G49FtHKvm--


