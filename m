Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC99C43602
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 06:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgzh8-0001Ki-JM; Tue, 07 Jul 2026 02:54:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgzh6-0001KJ-5U
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:54:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgzh4-0004qb-HU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 02:54:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783407249;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NR3KO1tvDFcqvHPLiQA0oVSL69mqF+1Mz7lXhYCgMsU=;
 b=DyNH9Iu/KwogZt27TiXlzz25CnFmgH0d8nSl0u9hRaEVGQYsBqhILfk7IKcg5Ju/9dwfiz
 HEo0jIcipPNrggNgbTr3S9S0A4qJGOZRqP9Esee/gxJykIVb5C5fyT6xFXtxxW1p11IyTz
 TImcFdzTahW1TpSLYVv2B/4uN6fVQG4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-wg-deY7QOgq4T-b9RKOKmA-1; Tue,
 07 Jul 2026 02:54:06 -0400
X-MC-Unique: wg-deY7QOgq4T-b9RKOKmA-1
X-Mimecast-MFC-AGG-ID: wg-deY7QOgq4T-b9RKOKmA_1783407244
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D6E11954B05; Tue,  7 Jul 2026 06:54:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 030323691C; Tue,  7 Jul 2026 06:54:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AB4FD21E6920; Tue, 07 Jul 2026 08:54:01 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Christian Brauner <brauner@kernel.org>,
 devel@lists.libvirt.org,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Peter Krempa <pkrempa@redhat.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH v7 35/35] docs: mark '-mon' as deprecated in favour of
 -object
In-Reply-To: <20260706135824.2623960-36-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 6 Jul 2026 14:58:23
 +0100")
References: <20260706135824.2623960-1-berrange@redhat.com>
 <20260706135824.2623960-36-berrange@redhat.com>
Date: Tue, 07 Jul 2026 08:54:01 +0200
Message-ID: <87qzlfjnna.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
>  qemu-options.hx                         | 16 ++++++++--------
>  system/vl.c                             |  2 ++
>  7 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 169c5dfe4f..023612748b 100644
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
> +The ``-mon`` option was the generic mechanism for creating monitor
> +objects if the convenience ``-qmp`` or ``-monitor`` options were not
> +flexible enough. The monitor objects have been converted to QOM, so
> +``-mon mode=3Dreadline`` is replaced by ``-object monitor-hmp`` and
> +``-mon mode=3Dcontrol`` is replaced by ``-object monitor-qmp``. The
> +short convenience options are not deprecated, only ``-mon``.
> +
>  QEMU Machine Protocol (QMP) commands
>  ------------------------------------
>=20=20
> diff --git a/docs/devel/writing-monitor-commands.rst b/docs/devel/writing=
-monitor-commands.rst
> index 930da5cd06..7ae7efe327 100644
> --- a/docs/devel/writing-monitor-commands.rst
> +++ b/docs/devel/writing-monitor-commands.rst
> @@ -52,8 +52,8 @@ shown here.
>  First, QEMU should be started like this::
>=20=20
>   # qemu-system-TARGET [...] \
> -     -chardev socket,id=3Dqmp,port=3D4444,host=3Dlocalhost,server=3Don \
> -     -mon chardev=3Dqmp,mode=3Dcontrol,pretty=3Don
> +     -chardev socket,id=3Dchrqmp0,port=3D4444,host=3Dlocalhost,server=3D=
on \
> +     -object monitor-qmp,chardev=3Dchrqmp0,pretty=3Don,id=3Dqmp0
>=20=20
>  Then, in a different terminal::
>=20=20
> diff --git a/docs/system/arm/xenpvh.rst b/docs/system/arm/xenpvh.rst
> index 430ac2c02e..511af63e3d 100644
> --- a/docs/system/arm/xenpvh.rst
> +++ b/docs/system/arm/xenpvh.rst
> @@ -27,9 +27,9 @@ Sample QEMU xenpvh commands for running and connecting =
with Xen:
>=20=20
>      qemu-system-aarch64 -xen-domid 1 \
>        -chardev socket,id=3Dlibxl-cmd,path=3Dqmp-libxl-1,server=3Don,wait=
=3Doff \
> -      -mon chardev=3Dlibxl-cmd,mode=3Dcontrol \
> +      -object monitor-qmp,id=3Dqmp0,chardev=3Dlibxl-cmd \
>        -chardev socket,id=3Dlibxenstat-cmd,path=3Dqmp-libxenstat-1,server=
=3Don,wait=3Doff \
> -      -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol \
> +      -object monitor-qmp,id=3Dqmp1,chardev=3Dlibxenstat-cmd \
>        -xen-attach -name guest0 -vnc none -display none -nographic \
>        -machine xenpvh -m 1301 \
>        -chardev socket,id=3Dchrtpm,path=3Dtmp/vtpm2/swtpm-sock \
> diff --git a/docs/system/i386/xen.rst b/docs/system/i386/xen.rst
> index 46db5f34c1..6ff5cdb1e4 100644
> --- a/docs/system/i386/xen.rst
> +++ b/docs/system/i386/xen.rst
> @@ -79,7 +79,8 @@ of type ``xen-console`` to connect to it. For the Xen c=
onsole equivalent of
>  the handy ``-serial mon:stdio`` option, for example:
>=20=20
>  .. parsed-literal::
> -   -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff -mon char0 \\
> +   -chardev stdio,mux=3Don,id=3Dchar0,signal=3Doff \\
> +   -object monitor-hmp,chardev=3Dchar0,id=3Dhmp0 \\
>     -device xen-console,chardev=3Dchar0
>=20=20
>  The Xen network device is ``xen-net-device``, which becomes the default =
NIC
> diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
> index 354250f073..904778e3f5 100644
> --- a/docs/system/i386/xenpvh.rst
> +++ b/docs/system/i386/xenpvh.rst
> @@ -33,9 +33,9 @@ case you need to construct one manually:
>=20=20
>      qemu-system-i386 -xen-domid 3 -no-shutdown        \
>        -chardev socket,id=3Dlibxl-cmd,path=3D/var/run/xen/qmp-libxl-3,ser=
ver=3Don,wait=3Doff \
> -      -mon chardev=3Dlibxl-cmd,mode=3Dcontrol             \
> +      -object monitor-qmp,id=3Dqmp0,chardev=3Dlibxl-cmd   \
>        -chardev socket,id=3Dlibxenstat-cmd,path=3D/var/run/xen/qmp-libxen=
stat-3,server=3Don,wait=3Doff \
> -      -mon chardev=3Dlibxenstat-cmd,mode=3Dcontrol        \
> +      -object monitor-qmp,id=3Dqmp1,chardev=3Dlibxenstat-cmd \
>        -nodefaults                                     \
>        -no-user-config                                 \
>        -xen-attach -name g0                            \
> diff --git a/qemu-options.hx b/qemu-options.hx
> index fe76c18c81..acf68f8961 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4154,7 +4154,7 @@ The general form of a character device option is:
>      ::
>=20=20
>          -chardev stdio,mux=3Don,id=3Dchar0 \
> -        -mon chardev=3Dchar0,mode=3Dreadline \
> +        -object monitor-hmp,id=3Dhmp0,chardev=3Dchar0 \
>          -serial chardev:char0 \
>          -serial chardev:char0
>=20=20
> @@ -4166,7 +4166,7 @@ The general form of a character device option is:
>      ::
>=20=20
>          -chardev stdio,mux=3Don,id=3Dchar0 \
> -        -mon chardev=3Dchar0,mode=3Dreadline \
> +        -object monitor-hmp,id=3Dhmp0,chardev=3Dchar0 \
>          -parallel chardev:char0 \
>          -chardev tcp,...,mux=3Don,id=3Dchar1 \
>          -serial chardev:char1 \
> @@ -5004,12 +5004,13 @@ SRST
>=20=20
>      enables the QMP monitor on localhost port 4444 with pretty-printing.
>=20=20
> -    The use of ``-mon mode=3Dreadline`` is syntactic sugar
> +    The use of ``-mon mode=3Dreadline`` is deprecated syntactic sugar
> +    The use of ``-mon mode=3Dreadline`` is deprecated syntax sugar

Whoops!

Can fix this without a respin.

>      for the new ``-object monitor-hmp`` option, each use of which
>      creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
>      a counter starting from 0.
>=20=20
> -    The use of ``-mon mode=3Dcontrol`` is syntactic sugar
> +    The use of ``-mon mode=3Dcontrol`` is deprecated syntactic sugar
>      for the new ``-object monitor-qmp`` option, each use of which
>      creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
>      a counter starting from 0.

[...]


