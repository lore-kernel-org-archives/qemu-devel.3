Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1913CD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 12:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPfuS-0001qw-7i; Wed, 20 May 2026 08:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPfuQ-0001mo-0U
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:20:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPfuO-0001AF-8X
 for qemu-devel@nongnu.org; Wed, 20 May 2026 08:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779279618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gK1VOXQeNJZgVFRn/NUm3o/XtixWs8zWE1S6+THduMg=;
 b=NG2jKbYDwGv09g9lUzCTzNetHVXl5/sga46UvEjXUqBGC4wGqEl4+uMSHlf5CYEw+zvMHK
 pE47yAx7ZRoT0lXK3XCevylqRw6+KJe+T3AJ8dk/wWgAtwjMW12aC8+O3dI7g4yCS249c/
 VWGYXu1tXqymKPJfjunAHQbkVi8ScUM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-606-hpJHQzgZNem0A6QXS9FzwQ-1; Wed,
 20 May 2026 08:20:15 -0400
X-MC-Unique: hpJHQzgZNem0A6QXS9FzwQ-1
X-Mimecast-MFC-AGG-ID: hpJHQzgZNem0A6QXS9FzwQ_1779279614
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9DEF195605B; Wed, 20 May 2026 12:20:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 51914180034E; Wed, 20 May 2026 12:20:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB0BF21E6A01; Wed, 20 May 2026 14:20:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: J. =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@9elements.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] docs/devel/qom: Fix some editing errors
In-Reply-To: <20260520-qom-v1-1-baad87fefe4f@9elements.com> ("J.
 =?utf-8?Q?Neusch=C3=A4fer=22's?=
 message of "Wed, 20 May 2026 13:15:20 +0200")
References: <20260520-qom-v1-1-baad87fefe4f@9elements.com>
Date: Wed, 20 May 2026 14:20:10 +0200
Message-ID: <87o6iaz30l.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

J. Neusch=C3=A4fer <j.neuschaefer@9elements.com> writes:

> "devices have an two additional [...]" -> "devices have two additional",
> and also a case of "were" vs. "where".
>
> Signed-off-by: J. Neusch=C3=A4fer <j.neuschaefer@9elements.com>
> ---
>  docs/devel/qom.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/devel/qom.rst b/docs/devel/qom.rst
> index 5870745ba27b108726da0756aa2b90109d5e0bd6..935bb1004a7839c8e963985e7=
65c866d5b980c53 100644
> --- a/docs/devel/qom.rst
> +++ b/docs/devel/qom.rst
> @@ -435,14 +435,14 @@ OBJECT_DEFINE_ABSTRACT_TYPE() macro can be used ins=
tead:
>  Device Life-cycle
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
> -As class initialisation cannot fail devices have an two additional
> +As class initialisation cannot fail, devices have two additional
>  methods to handle the creation of dynamic devices. The ``realize``
>  function is called with ``Error **`` pointer which should be set if
>  the device cannot complete its setup. Otherwise on successful
>  completion of the ``realize`` method the device object is added to the
>  QOM tree and made visible to the guest.
>=20=20
> -The reverse function is ``unrealize`` and should be were clean-up
> +The reverse function is ``unrealize`` and should be where clean-up
>  code lives to tidy up after the system is done with the device.
>=20=20
>  All devices can be instantiated by C code, however only some can
>
> ---
> base-commit: e89049b3ba5f1f0468bc0d294173345597514a1b
> change-id: 20260520-qom-76537da673b6
>
> Best regards,

Reviewed-by: Markus Armbruster <armbru@redhat.com>

Perhaps this could go via qemu-trivial (cc'ed).


