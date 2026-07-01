Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C131C43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 13:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weuYe-0002zU-RQ; Wed, 01 Jul 2026 09:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weuYd-0002zL-E2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:00:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1weuYb-0002GJ-RR
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 09:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782910848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVB59SKyN9STSNxjWz8GFaYjVtgTtuTB0EDYONMgF4Y=;
 b=Mvgfd1uFsXiFiNcJNiFJJ4IpIqNJd32y6cY31l4JqH78SrIXE0AN9Z6w8HMV1uYnLYBz8p
 17Oxggfi4uo876aT4YdYyC+jpIZ4I9dRbZtubEdTqW+bJI3N6fBe5W9nZaPKtUsbGnmXII
 J17pm+baF6RwnCCy2R+utY4wwY8+wY0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-526-bCOUiH2yN86jjuUa2WfBvA-1; Wed,
 01 Jul 2026 09:00:44 -0400
X-MC-Unique: bCOUiH2yN86jjuUa2WfBvA-1
X-Mimecast-MFC-AGG-ID: bCOUiH2yN86jjuUa2WfBvA_1782910843
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB851184A0B6; Wed,  1 Jul 2026 13:00:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54C091800611; Wed,  1 Jul 2026 13:00:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB03421E6920; Wed, 01 Jul 2026 15:00:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  devel@lists.libvirt.org,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Christian Brauner <brauner@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  Peter Krempa
 <pkrempa@redhat.com>
Subject: Re: [PATCH v5 35/35] docs: mark '-mon' as deprecated in favour of
 -object
In-Reply-To: <20260624173752.2928717-36-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 24 Jun 2026 18:37:51
 +0100")
References: <20260624173752.2928717-1-berrange@redhat.com>
 <20260624173752.2928717-36-berrange@redhat.com>
Date: Wed, 01 Jul 2026 15:00:39 +0200
Message-ID: <87a4sa6f0o.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The high level `-qmp` and `-monitor` options can remain as convenience
> wrappers, but the low level `-mon` is completed obsoleted by the new
> `-object` support with 'monitor-qmp' and 'monitor-hmp' types.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Tested-by: Peter Krempa <pkrempa@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/about/deprecated.rst               | 10 ++++++++++
>  docs/devel/writing-monitor-commands.rst |  4 ++--
>  docs/system/arm/xenpvh.rst              |  4 ++--
>  docs/system/i386/xen.rst                |  3 ++-
>  docs/system/i386/xenpvh.rst             |  4 ++--
>  qemu-options.hx                         | 11 ++++++-----
>  system/vl.c                             |  2 ++
>  7 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc..8370fc5680 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -61,6 +61,16 @@ The ``debug-threads`` option of the ``-name`` argument=
 is now
>  ignored. Thread naming is unconditionally enabled for all platforms
>  where it is supported.
>=20=20
> +``-mon`` option (since 11.1)
> +''''''''''''''''''''''''''''
> +
> +The ``-mon`` option was the generic mechanism for creating monitor objec=
ts
> +if the convenience ``-qmp`` or ``-monitor`` options were not flexible
> +enough. The monitor objects have been converted to QOM, so ``-mon mode=
=3Dreadline``
> +is replaced by ``-object monitor-hmp`` and ``-mon mode=3Dcontrol`` is re=
placed
> +by ``-object monitor-qmp``. The short convenience options are not deprec=
ated,
> +only ``-mon``.
> +

Suggest to wrap lines around column 70.

>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>=20=20

[...]


