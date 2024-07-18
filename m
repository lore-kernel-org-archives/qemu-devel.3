Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81988C3DA60
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:10:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUQtL-000593-Vc; Thu, 18 Jul 2024 09:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUQtK-00058X-2v
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:09:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sUQtF-0000GB-RE
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:09:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721308182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui7YZiowJlBY62Z/ePJCfXcXPM0w/vDNMy7PIQi0EJ8=;
 b=jJid0+gXOyuQJqmK+d7PkLQfzq6FthRZh3fiXvnDgwrtzM/rNY2r1tOFj7oAsRS/4JnWXU
 l+gVApSncTGN6z0nj+xH0RIQsDEGYtvB6XRUaIZ4LAxN7ikgkyuOXJqBjpBhS1LsTy3B/4
 8XoEA2ajbq2YKc6eCL5AA0WrMI5TZnY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-zhvBC-xjPxW7k0hev8Fo5g-1; Thu,
 18 Jul 2024 09:09:41 -0400
X-MC-Unique: zhvBC-xjPxW7k0hev8Fo5g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 817491955D57; Thu, 18 Jul 2024 13:09:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F32FD1955F40; Thu, 18 Jul 2024 13:09:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C88D221E668E; Thu, 18 Jul 2024 15:09:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [PATCH v5 1/4] docs/interop/firmware.json: add new enum
 FirmwareFormat
In-Reply-To: <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Thu, 18 Jul 2024
 14:21:45 +0200")
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
Date: Thu, 18 Jul 2024 15:09:37 +0200
Message-ID: <877cdionhq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:

> Only a small subset of all blockdev drivers make sense for firmware
> images. Introduce and use a new enum to represent this.
>
> This also reduces the dependency on firmware.json from the global qapi
> definitions.
>
> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
>  docs/interop/firmware.json | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
> index 54a1fc6c1041..a26fe81bf2fe 100644
> --- a/docs/interop/firmware.json
> +++ b/docs/interop/firmware.json
> @@ -15,7 +15,6 @@
>  ##
>=20=20
>  { 'include' : 'machine.json' }
> -{ 'include' : 'block-core.json' }
>=20=20
>  ##
>  # @FirmwareOSInterface:
> @@ -200,6 +199,20 @@
>               'enrolled-keys', 'requires-smm', 'secure-boot',
>               'verbose-dynamic', 'verbose-static' ] }
>=20=20
> +##
> +# @FirmwareFormat:
> +#
> +# Formats that are supported for firmware images.
> +#
> +# @raw: Raw disk image format.
> +#
> +# @qcow2: QEMU image format.

It's not the only QEMU image format...  Maybe "The QCOW2 image format."
Almost tautological, but I don't have better ideas.

> +#
> +# Since: 9.1

The enum type is indeed since 9.1, but its two members are since 3.0,
and that's what matters.

> +##
> +{ 'enum': 'FirmwareFormat',
> +  'data': [ 'raw', 'qcow2' ] }
> +
>  ##
>  # @FirmwareFlashFile:
>  #
> @@ -219,7 +232,7 @@
>  ##
>  { 'struct' : 'FirmwareFlashFile',
>    'data'   : { 'filename' : 'str',
> -               'format'   : 'BlockdevDriver' } }
> +               'format'   : 'FirmwareFormat' } }
>=20=20
>=20=20
>  ##


