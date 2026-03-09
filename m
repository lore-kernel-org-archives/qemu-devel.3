Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CF7EF371E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWQR-00024L-Qm; Mon, 09 Mar 2026 04:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzWQB-0001yb-H4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1vzWQ8-0001RK-Om
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773046619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a+v/pH8jQhRyrvv+LIMqXIv9rVJIwOwTaocY/oVfV9s=;
 b=gMiKyYiziMiH+/BcFa6VqcRjL/WCEqXvCHwudr4eg6gtEhliMeDbSba4B6EIJy/eHQBCw5
 YiGKeN+YA9FvYDkBq7FCUQYvKr4UYq37gIdLcoG1tLfg9aq8vDwMErGDr1YuluZewz2gu2
 czrZAexGaHdwGNCBKcXA+5fNWCmTpwQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-167-rbxTZtn9OZ-FXdHV5-j97w-1; Mon,
 09 Mar 2026 04:56:58 -0400
X-MC-Unique: rbxTZtn9OZ-FXdHV5-j97w-1
X-Mimecast-MFC-AGG-ID: rbxTZtn9OZ-FXdHV5-j97w_1773046617
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3A84E195609F; Mon,  9 Mar 2026 08:56:57 +0000 (UTC)
Received: from localhost (unknown [10.44.32.11])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 154A91800351; Mon,  9 Mar 2026 08:56:55 +0000 (UTC)
Date: Mon, 9 Mar 2026 16:56:53 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH V5 09/13] monitor: Update tracking iothread users with
 holder name
Message-ID: <20260309085653.GI39949@fedora>
References: <20260305142459.52559-1-zhangckid@gmail.com>
 <20260305142459.52559-10-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PdcXcjgJP+VMlK4r"
Content-Disposition: inline
In-Reply-To: <20260305142459.52559-10-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


--PdcXcjgJP+VMlK4r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 05, 2026 at 10:24:55PM +0800, Zhang Chen wrote:
> Because of monitor create own iothread, and use the
> iothread suspend/resume with bh handler and chardev handler.
> The QOM lifecycle is hard to track. Update the legacy usage
> of "iothread_get_aio_context()" and "iothread_put_aio_context()".

As mentioned in the prevoius patch, this feature needs to be implemented
fully in order to merged. If only half of it works, then it's not a
feature that users can rely on.

Stefan

--PdcXcjgJP+VMlK4r
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmui1UACgkQnKSrs4Gr
c8iHRwgAlUq/HaFYNETdcwuSQ/2Z5XdbjX2xpixB+GouXNQTIHmn+9KtS+veBVCS
QpPef8eDvYg1ezrSxf816aDh9y75uhBADnT5rS0gxktAaF41qJK6n0MqoITE4G5P
PPHVBr2/x1uBRWK6VKflCaJooMjsPS0UX5kQ/63+r1ov7Sw1E9g6gxsc0kMw8kRz
CJpIL6BmituOjdUJrj2sLE56ChiMAnUr+Wxt60ZsRS9SVa5nOlSGImXk9YRxUP4w
0bg4WwEdFedWMBdha9psvBkkrPk/E/14grjGEZOETfyufNnf/ns2VkuYtJ80BaUg
T3et8jGp8MgSgQ9dKgm3zSCGaJV/7g==
=2WoT
-----END PGP SIGNATURE-----

--PdcXcjgJP+VMlK4r--


