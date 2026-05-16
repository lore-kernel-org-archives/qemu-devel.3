Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F24ECD4F54
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 12:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOx9Q-0004FT-Lg; Mon, 18 May 2026 08:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8m-0003vy-6b
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wOx8k-0004oM-2s
 for qemu-devel@nongnu.org; Mon, 18 May 2026 08:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779107527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMWo2uB5qI+vo6fKU7tCjJ0sI0b6Z+VFzIElmxdMmo0=;
 b=RfnAWDVUxB/OQshfY/9eapDNw1QkV5m7kFeupKVj3AziLm4/u7tJs+H1v9FODXbe86fUIV
 kcIU1yehhhUVDcxlBEEbIo3up9eBDTYJ+RHfkG2XiFFT/Zyhsj/RWA5prRRm9kwk4HgGW5
 m0kwI0+7KuNhPyJ9gc5Ye5mdZmwluOo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-JedWvRyGPTawrz3CnYuuDQ-1; Mon,
 18 May 2026 08:32:05 -0400
X-MC-Unique: JedWvRyGPTawrz3CnYuuDQ-1
X-Mimecast-MFC-AGG-ID: JedWvRyGPTawrz3CnYuuDQ_1779107525
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6903195609D; Mon, 18 May 2026 12:32:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.101])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 29D8519560B0; Mon, 18 May 2026 12:32:03 +0000 (UTC)
Date: Sat, 16 May 2026 19:25:16 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 00/23] target-arm queue
Message-ID: <20260516232516.GA39137@fedora>
References: <20260515104945.4145203-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0V5FRkppvQ2IlAJL"
Content-Disposition: inline
In-Reply-To: <20260515104945.4145203-1-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_24_48=1.34,
 DKIMWL_WL_HIGH=-0.445, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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


--0V5FRkppvQ2IlAJL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.1 for any user-visible changes.

--0V5FRkppvQ2IlAJL
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmoI/NwACgkQnKSrs4Gr
c8jOGwf/TY+CKuj4L/Sg9P1udZC6KcO3tjTqzZDKlcXF0qzk8LTX+ILUcDxORMoB
4mkDlgqDQ+VIgNa4sEtrbMhJGZm70OEFvKKkuV49KF1LyW5okaxcjLLHTC9nzQ5W
JE52MJzLc2IwKMqKKWwuE8sUeQ3SxbKKYV4Pie4c+//mjlaW0mWUA/0Xv4ewkvap
w4E7dEboe31LVmTd77TqML0OeWRTGP+2Dbw3Xcydi0pOZrWfrY65UHDWA9IzeiOH
3faflvD7LjiLGhnRig1cE4BpU2Bk6xCX20I2Y0d17YzPJiljMXJBSrmB5hXGGj/h
531pNq7WeDYQQmeO1pZmLfm2VdlD0A==
=iMGV
-----END PGP SIGNATURE-----

--0V5FRkppvQ2IlAJL--


