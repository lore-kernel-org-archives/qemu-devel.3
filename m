Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BE0CDB47F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:33:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcSPT-0006aC-8y; Wed, 24 Jun 2026 14:33:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPQ-0006a0-MC
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wcSPN-0007Iy-Lj
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 14:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782325988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XNtbzle1NAotZ36MXTdqge7XEyqvkZ8Sy7RWuFjE3nU=;
 b=d4OoCbHb1p2U4jrAbNuq+N/29l3z6PR9m5NAtplrvo5g4ewDbfoEy/43MXd8K5UzHPsRKz
 ZROPjiYufRIwQuXbBKVR8A9sa5jlv9/EsAqB0pb/TbzP/JsiQs7jQ3BPL4suU4t+Js76Yu
 AF/eIAMLjVyeoqeyphhQ8moX6p05baQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-tqackmBpNCG6vX3pWbvnBQ-1; Wed,
 24 Jun 2026 14:33:05 -0400
X-MC-Unique: tqackmBpNCG6vX3pWbvnBQ-1
X-Mimecast-MFC-AGG-ID: tqackmBpNCG6vX3pWbvnBQ_1782325983
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 067A61800581; Wed, 24 Jun 2026 18:33:03 +0000 (UTC)
Received: from localhost (unknown [10.2.17.97])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 630663652A; Wed, 24 Jun 2026 18:33:02 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:19:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH V9 04/17] iothread: introduce
 iothread_unsafe_get_aio_context()
Message-ID: <20260624171941.GC109308@fedora>
References: <20260624070851.13342-1-zhangckid@gmail.com>
 <20260624070851.13342-5-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="S+LdgbO0s3QgK3qc"
Content-Disposition: inline
In-Reply-To: <20260624070851.13342-5-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--S+LdgbO0s3QgK3qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 03:08:38PM +0800, Zhang Chen wrote:
> diff --git a/include/system/iothread.h b/include/system/iothread.h
> index b483bbfab3..064c05e78d 100644
> --- a/include/system/iothread.h
> +++ b/include/system/iothread.h
> @@ -71,6 +71,12 @@ DECLARE_INSTANCE_CHECKER(IOThread, IOTHREAD,
>  char *iothread_get_id(IOThread *iothread);
>  IOThread *iothread_by_id(const char *id);
>  AioContext *iothread_get_aio_context(IOThread *iothread);
> +/*
> + * The iothread_unsafe_get_aio_context() is a low-level unsafe way of getting
> + * the AioContext, recommend migrating to the new API with IOThreadHolder
> + * as much as possible.

This should describe the safety concerns and when it is okay to use this
API. Something like:

  Normally the IOThread's AioContext is fetched using
  iothread_ref_and_get_aio_context(), but there are legacy callers
  without a clear ref/unref lifecycle. They cannot unref (e.g. because
  they do not have an IOThread pointer), so provide an unsafe way to
  fetch the AioContext without holding a reference count. This unsafe
  API serves legacy callers - do not use it in new code.

> + */
> +AioContext *iothread_unsafe_get_aio_context(IOThread *iothread);
>  AioContext *iothread_ref_and_get_aio_context(IOThread *iothread,
>                                               const IOThreadHolder *holder);
>  void iothread_put_aio_context(IOThread *iothread, const IOThreadHolder *holder);

--S+LdgbO0s3QgK3qc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmo8Ea0ACgkQnKSrs4Gr
c8imtgf+MjLYmmEpOyjRgnLt4FlfwvYkZpCL4ewQlpVlPKF3EzWhGmb8FC1UrBHg
xS0epGITzl/Kip+zj9hFAxgE+2Y9GcsxnV+NWmdj0Sr3sLiR9DQcSyBlcPaNmWZB
iKJOMBAO4+HEEQdTkTjRxbnGRsRUGx/9NsauoXLIogNatV1ZtTYwf4ilI1DM+LCH
6/XAa6hRDhrm8XR8Ag0CLJqdK6FOYW6FIxNhhkAaKp4WwAt6BdhBVnjYnGtKK51+
+SzVVS5ayM4XtgignfAqs/0SM8TlFLajAZA0wSo6kOjgTahKjaZp4mqLZreiZsHC
C/xqhCBJvMRVUpW6XQVCtZ9d/2jn5w==
=+gJl
-----END PGP SIGNATURE-----

--S+LdgbO0s3QgK3qc--


