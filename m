Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA095C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 14:27:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU4bb-0006Bx-Ul; Tue, 24 Jun 2025 10:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU4bZ-0006BN-Pn
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:26:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uU4bT-0004qN-EG
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 10:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750775184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+J65IVGtR1gDn8xQSIJp50m2P3zyAbtTN2UNQmCV3E=;
 b=HRjQRBsRrFbKfUOgcyKl1qmc6k7NtOyI9k2a9JVsKCjsfgAtzD7JNTe1AP3W00BK44sIRN
 2kGg5o/LbmH/kLwpXhf7pUxczTpCWEYd2xwKFV8KUB1nAKNieqHhDRKvemvyGF7VwXNOjr
 3S46zahP54Cycn2zwJcxAwrHLa14ZZQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-46-UXDKFL3OMPCDR_aQnMwZuw-1; Tue,
 24 Jun 2025 10:26:22 -0400
X-MC-Unique: UXDKFL3OMPCDR_aQnMwZuw-1
X-Mimecast-MFC-AGG-ID: UXDKFL3OMPCDR_aQnMwZuw_1750775181
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ECE71800368; Tue, 24 Jun 2025 14:26:21 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 878BB19560AF; Tue, 24 Jun 2025 14:26:20 +0000 (UTC)
Date: Tue, 24 Jun 2025 10:26:19 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tanish Desai <tanishdesai37@gmail.com>
Cc: qemu-devel@nongnu.org, Mads Ynddal <mads@ynddal.dk>
Subject: Re: [PATCH v2 3/3] tracetool: remove redundant event_get_state checks
Message-ID: <20250624142619.GA5027@fedora>
References: <20250620143720.3143-1-tanishdesai37@gmail.com>
 <20250620143720.3143-4-tanishdesai37@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jz22eiZSklO55hFA"
Content-Disposition: inline
In-Reply-To: <20250620143720.3143-4-tanishdesai37@gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


--jz22eiZSklO55hFA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 20, 2025 at 02:37:20PM +0000, Tanish Desai wrote:
> diff --git a/scripts/tracetool/backend/ftrace.py b/scripts/tracetool/backend/ftrace.py
> index baed2ae61c..2d6d608add 100644
> --- a/scripts/tracetool/backend/ftrace.py
> +++ b/scripts/tracetool/backend/ftrace.py
> @@ -34,18 +34,15 @@ def generate_h(event, group):
>          '        char ftrace_buf[MAX_TRACE_STRLEN];',
>          '        int unused __attribute__ ((unused));',
>          '        int trlen;',
> -        '        if (trace_event_get_state(%(event_id)s)) {',
>          '#line %(event_lineno)d "%(event_filename)s"',
>          '            trlen = snprintf(ftrace_buf, MAX_TRACE_STRLEN,',
>          '                             "%(name)s " %(fmt)s "\\n" %(argnames)s);',

Please unindent lines now that "if (trace_event_get_state(...)) {" is
gone and deeper indentation is not necessary anymore. There are more
instances below in this patch.

--jz22eiZSklO55hFA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhatYoACgkQnKSrs4Gr
c8hy3wf/Yq0fwEGsGg7rDk6e59IEajmL9BJB6Cs7HswmjiDqFv7DH81gDG88R7vM
8QfchUkIr6wFPvjXKN5uPskVsUtryE0vNo7zgNuOjn7Y8XKsPP3L7gMRVdCkwbJf
vt+Z7Ip4WpmGk4TZ3QNA6XWAXFWkWIUOB25RtgIoiwG8N7/OGzRC/05HxY/9qZ56
FubJq2urMKbIEwLQd98kMbO56dzLV1d/3So7ZRF5onq5ysUY0fw1aNwx0q9qO8Km
ctKZHolHdJobG9njM0YKWHp/fiVSoFro5RxV2wMy7wwF4qvSUaxEn0r3q6MrqNBb
4TCr/4WCE8CMk9s8rig8oBWH8uyeow==
=pdnv
-----END PGP SIGNATURE-----

--jz22eiZSklO55hFA--


