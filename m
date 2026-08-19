Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978B2C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 19:12:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwli9-0006pB-Ob; Wed, 19 Aug 2026 15:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwli8-0006oj-0O
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:12:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1wwli6-0002UE-DV
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 15:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787166744;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1Ia6vYRpzzZuKI7PA41c1rfPIGZBB4H9enZcfYOZ1cU=;
 b=LHPedf3uvds5Q6UpyqgHpXVG4Sr1XUuoGVtwkB2T4a9ywm+CzPvqlfCtdbrRIqjPBHGjUn
 UOAmBH9eaqCfTZU2c4FvhQYsQl+gAtFW/2zY8zYaHcz9ETM9Wd8VUkRwAhgL81l3EPOImR
 eF538z0jUgaWw9o0ZPbMZcdpkHFv1J0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-186-ATtoqTtZPbWle5fjuA3kKw-1; Wed,
 19 Aug 2026 15:12:23 -0400
X-MC-Unique: ATtoqTtZPbWle5fjuA3kKw-1
X-Mimecast-MFC-AGG-ID: ATtoqTtZPbWle5fjuA3kKw_1787166742
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 22EEE1800149; Wed, 19 Aug 2026 19:12:22 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 78FBD1800348; Wed, 19 Aug 2026 19:12:21 +0000 (UTC)
Date: Wed, 19 Aug 2026 15:12:18 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "'Michael S . Tsirkin'" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 'Daniel P =?iso-8859-1?Q?=2E_Berrang=E9'?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH V12 06/15] monitor: track IOThread users with QOM paths
Message-ID: <20260819191217.GE222512@fedora>
References: <20260814174830.1691540-1-zhangckid@gmail.com>
 <20260814174830.1691540-7-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zigYepjfDrHLaLCP"
Content-Disposition: inline
In-Reply-To: <20260814174830.1691540-7-zhangckid@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

--zigYepjfDrHLaLCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 15, 2026 at 01:48:20AM +0800, Zhang Chen wrote:
> @@ -668,6 +668,17 @@ void monitor_cleanup(void)
>          qemu_mutex_unlock(&monitor_lock);
>          monitor_flush(mon);
>          qemu_mutex_lock(&monitor_lock);
> +
> +        if (monitor_requires_iothread(mon)) {
> +            g_autofree char *path = object_get_canonical_path(OBJECT(mon));
> +            const IOThreadHolder io_holder = {
> +                .type = IO_THREAD_HOLDER_KIND_QOM_OBJECT,
> +                .u.qom_object.qom_path = path,
> +            };
> +
> +            iothread_unref_and_put_aio_context(mon_iothread, &io_holder);
> +            mon->ctx = NULL;
> +        }

Is it possible to move this to monitor_finalize() so it's guaranteed to
run when a Monitor object is deleted with object_unparent()? That would
avoid the code duplication in monitor_qmp_prepare_delete().

One complication is that object_get_canonical_path() may not work inside
monitor_finalize(), so it may be necessary to store the IOThreadHolder
or at least the qom_path in Monitor.

--zigYepjfDrHLaLCP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqGABEACgkQnKSrs4Gr
c8j6cwf/evRZ+5Z5GAziWoKmbLFbgacmOBALuVoKQv9ULxSOhZGSwNVby5TfSHe/
6B534pqKvm9diW1RvemiFogW5Id71R9nqYQC4/HQbD92Fay76ROOUXeHOWwWn6Xz
6fdg0heo+U1gSHQxGU6BAMHDitpumYfA8Q6iAOvyt2M/ErpIY2CRpgP/JMV9LAhb
BIDpkJE5IcbQhWJvaKVk6wVh4AIyuCj699t5SCqvI5IOABvX/ivn7JMr978/Oy9W
L35rwBB0AwHPXmYYJUCyDkWls4dERCMgd2ExbiGGnAMUlXw0IDWeu5E/k/n+8bfO
xwao+VTEDncvBuQEl7QyW4/TlLAzRw==
=SKiN
-----END PGP SIGNATURE-----

--zigYepjfDrHLaLCP--


