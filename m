Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41897606A32D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 07:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A9/AukAj
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNm3U-0004Pb-6E; Mon, 02 Nov 2026 02:02:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNm3E-0004P2-1e
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:01:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNm3C-0005Eu-08
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 02:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793602908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7a+By6S0duiXlB+AwybqGYHZ0Bja7wycgKO3GumZic=;
 b=A9/AukAjfkbj24bHnsT6C0hkZ/sZOI7WHjsf3zt3ptu1H1ZWfbnKDoGxCRrtHzS1gzfdEN
 RJj8ZM5m2uyroYLOk19Q6ezUyslYmM9lmUhcNSaW8nqGURvSuTFKI/4vu85D5HaeHdtnCI
 jyhqRDm8QrzcRm35HftUQgsPsToIOPY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-727gF-KCMKeu7hjfmMTKQQ-1; Mon,
 02 Nov 2026 02:01:45 -0500
X-MC-Unique: 727gF-KCMKeu7hjfmMTKQQ-1
X-Mimecast-MFC-AGG-ID: 727gF-KCMKeu7hjfmMTKQQ_1793602904
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 508C01800624; Mon,  2 Nov 2026 07:01:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EB81956087; Mon,  2 Nov 2026 07:01:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B9F821E6A04; Mon, 02 Nov 2026 08:01:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Stefan Hajnoczi <stefanha@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v4 13/14] docs: expand security docs with info about
 security status
In-Reply-To: <20260910103628.2326622-14-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Thu, 10 Sep 2026 11:36:27
 +0100")
References: <20260910103628.2326622-1-berrange@redhat.com>
 <20260910103628.2326622-14-berrange@redhat.com>
Date: Mon, 02 Nov 2026 08:01:41 +0100
Message-ID: <87ik2fvhre.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The description of virtualization vs non-virtualization use
> cases is a crude approximation of the security characteristics
> of QEMU devices.
>
> Document how QEMU can be probed to obtain information on the
> security status of type classes, and how policies can be set
> to inform or control their usage.
>
> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  docs/system/security.rst | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> diff --git a/docs/system/security.rst b/docs/system/security.rst
> index 8c42d1a6d8..75e39caede 100644
> --- a/docs/system/security.rst
> +++ b/docs/system/security.rst
> @@ -158,6 +158,42 @@ an issue as a normal bug.
>    usually not justify handling as security bugs, nor assignment
>    of CVEs. They will be fixed as routine bugs when time allows.
>=20=20
> +Security status reporting
> +'''''''''''''''''''''''''
> +
> +The QEMU project annotates types to explicitly state whether they are
> +considered to provide a security boundary or not. For machine, accelerat=
or
> +and device types, only those annotated with the "secure" flag will be
> +eligible for CVE assignment. Annotations will be extended to other backe=
nd
> +and object types over time, to make their security status explicit.
> +
> +It is possible to control or identify the usage of types that do not off=
er
> +an explicit security boundary using the ``insecure-types`` parameter to =
the
> +``-compat`` argument, which accepts three values:
> +
> + * accept: usage of any type will be permitted. This is the current
> +   and historical default behaviour
> + * warn: usage of types not explicitly declared secure will result
> +   in a warning message, but still be permitted.
> + * reject: usage of types not explicitly declared secure will result
> +   in an error message, and will not be permitted.
> +
> +The compatibility policy will be honoured both at initial startup of
> +QEMU and during any runtime alterations made with monitor commands.
> +
> +The status of any type class can be queried at runtime using the
> +``qom-list-types`` command, whose returned information will flag any
> +types declared as secure. The ``query-machines`` command will also
> +reflect this same information for machine types.

Yes, member @secure of qom-list-type's return type ObjectTypeInfo and
query-machine's return type MachineInfo.  However, nothing appears to be
marked secure:

    --> {"execute": "qom-list-types", "arguments": {"secure": true}}
    <-- {"return": []}

I did not expect this after reading the documentation.  Am I confused?

If not, what's the plan for the release?

> +
> +Machine type, accelerator and device security status can be queried
> +using ``-machine help``, ``-accel help`` and ``-device help`` command
> +line options respectively.
> +
> +Setting the ``.secure`` field to ``true`` in the ``TypeInfo``
> +instance for an Object class, declares that the type aims to provide
> +a security boundary.
> +
>  Architecture
>  ------------


