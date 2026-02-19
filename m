Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A14DC531E5
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 22:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtCUe-00070A-5P; Thu, 19 Feb 2026 17:27:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vtCUc-0006zo-IA
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 17:27:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vtCUa-0000nZ-S0
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 17:27:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771540046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5t/Mg7u3vkgLc7ynLOtN45ij2Ztgo7/QzQzyfLnzA/w=;
 b=A3BezREZ+3r6KER6QWyaaTDnoGzVuwbLVmX+oJj+2b+w4GmNC9oglybx+fONK+AyLDzgrB
 Du8cuo4Tlujb9z2EpRBo9tbgezYgmPpFNEv1zKQX9S02fkRZYoOtFdVGiyCVpohQ8lVFx2
 97TwuC4q8FEQz2XnJPSD69+70G05CVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-676-_rNta4XAODmy5UR6zgWXdw-1; Thu,
 19 Feb 2026 17:27:22 -0500
X-MC-Unique: _rNta4XAODmy5UR6zgWXdw-1
X-Mimecast-MFC-AGG-ID: _rNta4XAODmy5UR6zgWXdw_1771540041
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20ED31956080; Thu, 19 Feb 2026 22:27:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.138])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D4D9195410F; Thu, 19 Feb 2026 22:27:18 +0000 (UTC)
Date: Thu, 19 Feb 2026 17:27:17 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jaehoon Kim <jhkim@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, pbonzini@redhat.com,
 fam@euphon.net, armbru@redhat.com, eblake@redhat.com,
 berrange@redhat.com, eduardo@habkost.net, dave@treblig.org, sw@weilnetz.de
Subject: Re: [PATCH RFC v1 0/3] aio-poll: improve aio-polling efficiency
Message-ID: <20260219222717.GA1011077@fedora>
References: <20260113174824.464720-1-jhkim@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1yxXrd/Ttan4ZuPJ"
Content-Disposition: inline
In-Reply-To: <20260113174824.464720-1-jhkim@linux.ibm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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


--1yxXrd/Ttan4ZuPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Jaehoon,
Following the call earlier this week I ran a single fio job to get a
clearer picture of:
1. The QEMU 10.0.0 regression that prompted you to optimize AioContext
   polling.
2. How the poll-weight parameter affects IOPS.

run      rw        bs   numjobs iothreads iops   diff
v9.2.0   randread  8k   1       1         174944 3.6%
v10.0.0  randread  8k   1       1         174285 3.2%
baseline randread  8k   1       1         168908 0.0%
w2       randread  8k   1       1         163718 -3.1%
w3       randread  8k   1       1         165805 -1.8%
w4       randread  8k   1       1         167388 -0.9%

This time I only ran randread bs=8k iodepth=8 numjobs=1 with a single
IOThread.

Observations:

- There might be an IOPS regression between v10.0.0 and the baseline
  (9ad7f544c696) that your patches apply on top of. This is different
  from the CPU utilization regression that you found in v9.2.0 ->
  v10.0.0. I will bisect it.

- poll-weight=3 and 4 improve IOPS to a level that is acceptable. CPU
  utilization looks like this:

run         %usr     %nice      %sys   %iowait    %steal      %irq     %soft    %guest    %gnice     %idle
baseline   49.37      0.00     31.10      0.00      0.00     11.61      0.04      0.00      0.00      7.89
w2         46.24      0.00     32.61      0.00      0.00     11.84      0.10      0.00      0.00      9.21
w3         48.04      0.00     32.17      0.00      0.00     11.98      0.08      0.00      0.00      7.73
w4         48.56      0.00     31.23      0.00      0.00     11.48      0.03      0.00      0.00      8.69

poll-weight=2 is the winner at CPU utilization. I'm not sure if
poll-weight=3 will produce an acceptable CPU utilization improvement for
you. Do you have data or want to re-run to measure poll-weight=3?

Stefan

--1yxXrd/Ttan4ZuPJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmXjkUACgkQnKSrs4Gr
c8gCPgf/f4ZYLlkZ3Rn9Xo1lclPSpd5B9vPp6/mGmWfLeZF6YBKsELP4LowzLaqx
+D0omCpDQ4/zcMN+VKMjG8IQ83A9expHDmVBq9QLKWiOgAc4Q05pYvvtbV4N4XOv
Nul9kYsa8zySe8lOZ9FE+3FbpYZBeH4fZUcd4gIG2a9QvawPeNDy6HAHhN4Fegka
cxlD/mtBFBew2akow++3AmyORVHyHNz25udrGAMpss6DsLX9IHxbXthsKKQPU87H
vWJJulAfcsXT5UXxbUJXB5QAF3fltfjwFXF8RJImDTti+aFsz7ARm2x6X4OGDWBG
2SZBK+CK2Cpij+Ps+b7ynrAF5ahFbw==
=bToP
-----END PGP SIGNATURE-----

--1yxXrd/Ttan4ZuPJ--


