Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2FD7CD98C5
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQHb-00061I-4X; Wed, 10 Jun 2026 17:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHM-0005PD-AX
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQHK-00075f-UO
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pK7gQpvQUXVW+deSujPMwablsHH/lBUG/WlwpTc7Ic=;
 b=hki1jLVGokShv4ptGctH1mQ8ykCKLswILetdp7nOkmAv1rLbj8rgjuuiRhrve9J6LNTvGo
 pfsufI4LDbqL68ZJtIhJQOCs3h2KcRjGNV12XSV1YIpM68Ps82883u+sPYDHHFkzCgiFul
 XhXgYxIHbetRG9trrJb7I6oE+dvjXnI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-141-sbKXkxphPQ65FBISR_t2Ow-1; Wed,
 10 Jun 2026 17:15:56 -0400
X-MC-Unique: sbKXkxphPQ65FBISR_t2Ow-1
X-Mimecast-MFC-AGG-ID: sbKXkxphPQ65FBISR_t2Ow_1781126154
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09642187BE10; Wed, 10 Jun 2026 21:15:54 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8BC063692B; Wed, 10 Jun 2026 21:15:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 23/35] qemu-options: document new monitor-hmp and
 monitor-qmp objects
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Christian Brauner <brauner@kernel.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@lists.libvirt.org, Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
In-Reply-To: <20260610123415.2883603-24-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-24-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:23 +0400
Message-Id: <178112600376.209622.16416561470304910231.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1505;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=7kaI08a7x9lvn5PGZZsE1fjSkctiW32QjGd3MyjBM0E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdODfjJ3+/klQHki0OcZr1dyqdqLvllMN5+cb
 cWx1p8B50+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainTgwAKCRDa6OEJdZac
 5QFJD/wPmOVPqf7sxXqIkZPuHkCNuajP/kIb5lva80sE6X3L0upPl0/AN3RyZTyqfoH8wMV5eqz
 XI3PqHEYZulTBo7K0yIcvFlD+lNj5lFgmtK6xjzbQXQ4equRL6aznryCbsIaR124FgJ6wDsa9kO
 vSJD6l8UpaJ8H9ujA2KxIU+ALD6it+xcmVYJAoj0NOy8Yci1QY+dfWsdP0RiZX8lqcTvWUwCO7V
 TUnFbuqLbrCLDdnEowBAyNKVVYP4n0JDg4jczNhUOL38CDDdS0VoRsfF8JfGmndwbI9FjWHYsm6
 LlydJGPeBte+xZ5XfoT2w18xac3LoZBkKpYAD03xYdEucqgiGnK9WGO3tZjitfa7HUetygUUbN3
 sePz5gGMVtTy+rEJPSdI8VXzLbUHhZ0Bx5nwtC5B2w5L4/R/TRgM33Eh316/ILLu/EzXGIDQAFZ
 EpGfHXXN4/JtG7pkOAPx0VPEdlrdTOairaxrNTrBTz6uo21xg/D6wDLz7uKvnjGHqh5Hye6QGYI
 BMxe8UjLFRhkM5hO8U3OI5kIi5cMpSQoO+wl9R9h2iJ7tmZlaI4eMb029HPS80SznauInxaHEkK
 bpZqtZLuGxWVYEJwDojoEJRFOw4AahEWQtLWc6VM8dzIhMKsBQWW9uqhNJ7vbAth0RRgkkOeoiu
 snZ9l1m1Y+ankog==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
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

On Wed, 10 Jun 2026 13:34:03 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/qemu-options.hx b/qemu-options.hx
> index 96ae41f787b..031417b79d2 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5709,6 +5719,34 @@ SRST
>      they are specified. Note that the 'id' property must be set. These
>      objects are placed in the '/objects' path.
>  
> +    ``-object monitor-hmp,id=id,chardev=chardv_id,readline=on|off``

chardev_id

> +        Set up a monitor running the Human Monitor Protocol,
> +        connected to the chardev ``chrid``.

chardev_id

> +
> +        The ``id`` parameter is a unique ID that can be used
> +        to dynamically delete the monitor at runtime.

Maybe update the doc at last patch of the series?

> +
> +        The ``readline`` parameter, which defaults to ``on``,
> +        controls whether the monitor provides interactive
> +        prompts

.

> +
> +    ``-object monitor-qmp,id=id,chardev=chardev_id,pretty=on|off``
> +        Set up a monitor running the QEMU Monitor Protocol,
> +        connected to the chardev ``chrid``.

chardev_id

> +
> +        The ``id`` parameter is a unique ID that can be used
> +        to dynamically delete the monitor at runtime. Note
> +        that monitors created using the historical syntax
> +        will be allocated IDs following the pattern ``monNN``.

"qmpcompatN" and "hmpcompatN"

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


