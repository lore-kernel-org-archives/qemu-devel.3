Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C4CCD195
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 15:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9PYH-0003rj-FB; Thu, 16 Oct 2025 11:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9PYF-0003qU-On
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:06:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v9PYC-0001U5-Ci
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 11:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760627151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d64uKOGvxQXkA39TQtij4kjvsCg3Ac2XrIZiGMYHeeU=;
 b=N6742cdbMPbD9Ca9JMJ3kkjSIuarbyCAt+ME5SRtChzGGK7WXYTJumK7n6/Yagd9GIUaCu
 iEUzvR3+CiSo29d8zipH8Y16FOiDv3hBrqMxcJqaC7/zqfM/ma5tZ8BEZhS7LFl/CE/SAw
 vyhF+u/6GBDChIZuKAkb7bIavFrpypc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-Cv25eFtlP2KDPLnuDEpPfQ-1; Thu,
 16 Oct 2025 11:05:48 -0400
X-MC-Unique: Cv25eFtlP2KDPLnuDEpPfQ-1
X-Mimecast-MFC-AGG-ID: Cv25eFtlP2KDPLnuDEpPfQ_1760627146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F04B18001E9; Thu, 16 Oct 2025 15:05:46 +0000 (UTC)
Received: from localhost (unknown [10.2.16.165])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DE586180044F; Thu, 16 Oct 2025 15:05:45 +0000 (UTC)
Date: Thu, 16 Oct 2025 11:05:44 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 hi@alyssa.is, david@redhat.com, jasowang@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org,
 Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, slp@redhat.com,
 manos.pitsidianakis@linaro.org, Albert Esteve <aesteve@redhat.com>
Subject: Re: [PATCH v10 0/7] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20251016150544.GA1174075@fedora>
References: <20251016143827.1850397-1-aesteve@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6z2AckPOKacpH1TT"
Content-Disposition: inline
In-Reply-To: <20251016143827.1850397-1-aesteve@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


--6z2AckPOKacpH1TT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 16, 2025 at 04:38:20PM +0200, Albert Esteve wrote:
> v9->v10
> - Fix transaction_commit invoked without transaction_begin
>   on vhost_user_backend_handle_shmem_map() early errors
> - Removed fd tracking on VirtioSharedMemoryMapping, it
>   is handled by the RAMBlock
> - Reject invalid BAR configurations when VIRTIO Shared Memory
>   Regions are in use by vhost-user-test-device

Hi Michael,
I have finished reviewing this series. If no one else has comments then
it can be considered for merging through your VIRTIO/vhost tree.

Thanks,
Stefan

--6z2AckPOKacpH1TT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmjxCcgACgkQnKSrs4Gr
c8iZDwf9Fmp8LmdLZ933hvMs/5egTVtSDoDPvOOiYx0i/U5ZbGepNENZaGK1BORB
Gs108ZwtAtTozAwtnfKMizWwuax/Jh6tL7UoBajjTmWkncxFuilj9C4YURC3pNO1
50NZppcldWPHV86FhgObdO0PJVqALTAtpVe8/SIQtcL4IK5aV30JcjqCM2PZ0el7
HS34xQEQ2GXU5tRDiIcY+LJ1O336pI472vkfDL2H0ZTouEjRgrYzLBNWaqTmpwXp
dWO9cGmSbnBF+qghjGoCei5EoR1m8qeMWYQvbdFhXiEEr/AFZnx5Im60sEcUTSEa
vryfQZfLDk8oeM5iGUargqVcIoj9vQ==
=f9f6
-----END PGP SIGNATURE-----

--6z2AckPOKacpH1TT--


