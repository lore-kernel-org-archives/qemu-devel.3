Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80EE7C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgh0I-0003u5-Jt; Mon, 06 Jul 2026 06:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgh0G-0003tg-Qh
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:56:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wgh0F-0008HC-5D
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 06:56:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783335401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vb213gF4C1olZ4rMUxWyuCPnNlN8iNimI/aAnA5L4dQ=;
 b=f14M7H4F/+U4/B3CmbJUEpZt8lFhtL9FioJfmFKSmSCT0GMt6xeF/ijfXFD0XHg4dTL2qz
 Jh23OBSUEcpKRHFms2Tz1cmSH2KfXnbf4e0t8dnRZ13qKosGalqEwP8HXLNo9ktbfvr4xl
 nOMqAZ8F04suvRwGiAd0jJf0CEBYWZc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-i9sO_tKyOaKFGhhcMWCaqA-1; Mon,
 06 Jul 2026 06:56:40 -0400
X-MC-Unique: i9sO_tKyOaKFGhhcMWCaqA-1
X-Mimecast-MFC-AGG-ID: i9sO_tKyOaKFGhhcMWCaqA_1783335399
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE81C1955F15; Mon,  6 Jul 2026 10:56:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8146180028B; Mon,  6 Jul 2026 10:56:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3E61821E6920; Mon, 06 Jul 2026 12:56:35 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  "Dr. David
 Alan Gilbert" <dave@treblig.org>,  Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,
 Christian Brauner <brauner@kernel.org>,  devel@lists.libvirt.org
Subject: Re: [PATCH v6 33/34] qemu-options: document new monitor-hmp and
 monitor-qmp objects
In-Reply-To: <20260702160337.1910921-34-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 2 Jul 2026 17:03:36
 +0100")
References: <20260702160337.1910921-1-berrange@redhat.com>
 <20260702160337.1910921-34-berrange@redhat.com>
Date: Mon, 06 Jul 2026 12:56:35 +0200
Message-ID: <87echgpesc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

> Add new docs for the `-object monitor-hmp` and `-object monitor-qmp`
> options, updating `-mon` to state that it is legacy syntax sugar
> for the new `-object` args.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  qemu-options.hx | 61 ++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 58 insertions(+), 3 deletions(-)
>
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e44b47de68..1aa548c39b 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -4955,6 +4955,11 @@ SRST
>      port). The default device is ``vc`` in graphical mode and ``stdio``
>      in non graphical mode. Use ``-monitor none`` to disable the default
>      monitor.
> +
> +    The use of ``-monitor dev`` is syntax sugar for creating a character

For what it's worth, Wikipedia redirects "syntax sugar" to "syntactic
sugar", and uses only the latter in the article.

Could also use "shorthand".  Matter of taste.

> +    device from ``dev`` and pairing it with ``-object monitor-hmp``.
> +    Both the character device and monitor object will be given an ID
> +    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
>  ERST
>  DEF("qmp", HAS_ARG, QEMU_OPTION_qmp, \
>      "-qmp dev        like -monitor but opens in 'control' mode\n",
> @@ -4966,9 +4971,10 @@ SRST
>=20=20
>          -qmp tcp:localhost:4444,server=3Don,wait=3Doff
>=20=20
> -    Not all options are configurable via this syntax; for maximum
> -    flexibility use the ``-mon`` option and an accompanying ``-chardev``.
> -
> +    The use of ``-monitor dev`` is syntax sugar for creating a character

Pasto, you mean ``-qmp dev``.

> +    device from ``dev`` and pairing it with ``-object monitor-qmp``.
> +    Both the character device and monitor object will be given an ID
> +    ``compat_monitorNNN`` where ``NNN`` is a counter starting from 0.
>  ERST
>  DEF("qmp-pretty", HAS_ARG, QEMU_OPTION_qmp_pretty, \
>      "-qmp-pretty dev like -qmp but uses pretty JSON formatting\n",
> @@ -4997,6 +5003,16 @@ SRST
>        -mon chardev=3Dmon1,mode=3Dcontrol,pretty=3Don
>=20=20
>      enables the QMP monitor on localhost port 4444 with pretty-printing.
> +
> +    The use of ``-mon mode=3Dreadline`` is historical syntax sugar

What does "historical" mean?  The next patch replaces it by
"deprecated".  Suggest to scratch it here.

> +    for the new ``-object monitor-hmp`` option, each use of which
> +    creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
> +    a counter starting from 0.
> +
> +    The use of ``-mon mode=3Dcontrol`` is historical syntax sugar
> +    for the new ``-object monitor-qmp`` option, each use of which
> +    creates an object with the ID ``compat_monitorNNN`` where ``NNN`` is
> +    a counter starting from 0.
>  ERST
>=20=20
>  DEF("debugcon", HAS_ARG, QEMU_OPTION_debugcon, \
> @@ -5747,6 +5763,45 @@ SRST
>      they are specified. Note that the 'id' property must be set. These
>      objects are placed in the '/objects' path.
>=20=20
> +    ``-object monitor-hmp,id=3Did,chardev=3Dchardev_id,readline=3Don|off=
``
> +        Set up a monitor running the Human Monitor Protocol,
> +        connected to the chardev ``chardev_id``.
> +
> +        The ``id`` parameter is a unique ID that can be used
> +        to dynamically delete the monitor at runtime. Note
> +        that monitors created using the historical syntax
> +        will be allocated IDs following the pattern ``hmpcompatNN``.

``compat_monitorNNN``

> +        Mixing ``-object`` with the historical monitor syntax is
> +        discouraged.

Clearer, I think: "with -monitor and -mon".

The next patch deprecates -mon, and then this could become just "with
-monitor".

> +
> +        The ``readline`` parameter, which defaults to ``on``,
> +        controls whether the monitor provides line editing.
> +
> +    ``-object monitor-qmp,id=3Did,chardev=3Dchardev_id,pretty=3Don|off,c=
lose-action=3Dnone|delete``
> +        Set up a monitor running the QEMU Monitor Protocol,
> +        connected to the chardev ``chardev_id``.
> +
> +        The ``id`` parameter is a unique ID that can be used
> +        to dynamically delete the monitor at runtime. Note
> +        that monitors created using the historical syntax
> +        will be allocated IDs following the pattern ``qmpcompatNN``.

``compat_monitorNNN``

> +        Mixing ``-object`` with the historical monitor syntax is
> +        discouraged.

"with -qmp, -qmp-pretty, and -mon".

The next patch deprecates -mon, and then this could become just "with
-qmp and -qmp-pretty".

> +
> +        The ``pretty`` parameter, which defaults to ``off``,
> +        controls whether the monitor responses are pretty
> +        printed as multi-line indented JSON, as opposed to
> +        constrained to a single line without extraneous
> +        whitespace.
> +
> +        The ``close-action`` parameter, which defaults to ``none``,
> +        controls what happens when the connection to the monitor
> +        is terminated by the user. If set to ``delete``, then the
> +        ``monitor-qmp`` object and its associated character
> +        device are both immediately deleted. This can be useful
> +        if an extra monitor was hotplugged for a specific task

Comma after task?

> +        and should be unplugged when completed.
> +
>      ``-object memory-backend-file,id=3Did,size=3Dsize,mem-path=3Ddir,sha=
re=3Don|off,discard-data=3Don|off,merge=3Don|off,dump=3Don|off,prealloc=3Do=
n|off,host-nodes=3Dhost-nodes,policy=3Ddefault|preferred|bind|interleave,al=
ign=3Dalign,offset=3Doffset,readonly=3Don|off,rom=3Don|off|auto``
>          Creates a memory file backend object, which can be used to back
>          the guest RAM with huge pages.


