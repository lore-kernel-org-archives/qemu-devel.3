Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCB7C5B56A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 21:38:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtuAb-0004sp-7c; Tue, 11 Aug 2026 17:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuAV-0004r3-Qt
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wtuAU-0006O1-D0
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 17:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786484273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LmXO2onVkRJ7RTKgTdp5oEyhxjetzxDO7GOxqm9msK8=;
 b=fQGfrNUKNDOss85E9INRoVBlenRo4q19x63f8DoxUtlgHKW9/UAPofIoVCp8oQeCSwEoLm
 F+A5peS23TapiUIh1oslozTOmjmII5vfWNpWhF8ld0Is1ZRNHiCaHjhIqrPPxVQoHEdKyx
 ++Ek7GUC1M7NYXPIfk1OA4uL9JBpCw0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-wwLwWj36PWCyLA34fgR1fA-1; Tue,
 11 Aug 2026 17:37:52 -0400
X-MC-Unique: wwLwWj36PWCyLA34fgR1fA-1
X-Mimecast-MFC-AGG-ID: wwLwWj36PWCyLA34fgR1fA_1786484271
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF12018001CD; Tue, 11 Aug 2026 21:37:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC69A19560AB; Tue, 11 Aug 2026 21:37:49 +0000 (UTC)
Date: Tue, 11 Aug 2026 17:37:49 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, stefanha@redhat.com
Subject: Re: [PULL 0/3] Hex queue
Message-ID: <20260811213748.GA201069@fedora>
References: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="x4+Hxp8rYB10bzeI"
Content-Disposition: inline
In-Reply-To: <20260806213640.699905-1-brian.cain@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

--x4+Hxp8rYB10bzeI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.2 for any user-visible changes.

--x4+Hxp8rYB10bzeI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmp7liwACgkQnKSrs4Gr
c8gWxQf/eH+GgKCWNYgaPfwQkd95VWP7VqD4VjGsrjyMkv67Z0hif0uN9auuZ4sI
dWTqq2JGZjcH96a2D7ShxQ2xi94vYgUHeDzqypNaw1SL4/5ImturU2OttLXpdQAp
6pfPP8b94MSHvL8/bcDhMr0CTlULtwMK+bI9utRGSoMs7z7SFpBv915z/eIU+DLX
JYBHzeoJ9V8E0VZoUQzmQN9E2Bc1VSgM0sVgWny/b1IZS8ei6cAuTWJD25gtL7Qu
KfIWAJMay9fG4mZDE4CePfmpN0Rks6QlI71MCnYUCjuKujg7DWeefUNjt3JOLz5L
yk5uB02t23gQ+ttFkBnq6NhPJeYskg==
=Z23k
-----END PGP SIGNATURE-----

--x4+Hxp8rYB10bzeI--


