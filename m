Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FED2CD98C7
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 21:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXQIO-0003BQ-Sm; Wed, 10 Jun 2026 17:17:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQIM-0002t9-J1
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:17:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXQIL-0007Wo-4I
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 17:17:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781126224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hx66hDBaVZEolDg/qujJvfY6PaR8QyrENkjHad/JGGE=;
 b=cPv5IWQJQggrpVjtwY86f520zVCHV2sDGDMgYl4zAYiLMGU2ikgkOgm3IEDWU/TRxkZ+Mu
 hB4nCgWORext9udaDOkOWgpgapmrnk2qnOtjfFyJmJyPmUs/WllYAqclKpw5dQydYd4Sg7
 Z+x8E1cTJkcbbyFExvsGrrc9u/DBM+Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-SOuAb-Y7ON6nQCeJr4JZug-1; Wed,
 10 Jun 2026 17:17:00 -0400
X-MC-Unique: SOuAb-Y7ON6nQCeJr4JZug-1
X-Mimecast-MFC-AGG-ID: SOuAb-Y7ON6nQCeJr4JZug_1781126219
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9189819772FD; Wed, 10 Jun 2026 21:16:59 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9D36B2ED4; Wed, 10 Jun 2026 21:16:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 35/35] docs: mark '-mon' as deprecated in favour of
 -object
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
In-Reply-To: <20260610123415.2883603-36-berrange@redhat.com>
References: <20260610123415.2883603-1-berrange@redhat.com>
 <20260610123415.2883603-36-berrange@redhat.com>
Date: Thu, 11 Jun 2026 01:13:24 +0400
Message-Id: <178112600413.209622.9239950465927541859.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=848;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=mOnccfKX+fQXQYpnTrdEut4B+KhJCmS4QSxLlgYv2V0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKdOHUno6dPS9ciz49HZWGhDB+mLZxJz6RtzIe
 m+260hCz6qJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCainThwAKCRDa6OEJdZac
 5Un9D/9EZyBUfXO2gBOmEl9WJaKvyVxxU1nPylQBwaAP/FRRK5/xcfyle792wAB+yF99AVmxcgX
 TsQ5NJdhsGVBz+WetYw7lmUvwGgUfXwyFmAAq060dlDC1yltmAONTIsJxBR1+SRz30VQPNOStDs
 J4yx4wxXf3txPP7eRemPjcnkZvsYRjWtGSF1cEiqGXtQnJhzvQdTNuLw0yreEiMQwo01xAqcxcQ
 rxXyOtuxuawitncxERervn3kEB/l6s8tDacCpAZnSkOiq5NzSp5xIdPe1WX8WNrgVMT46TAi6zK
 oK32UG/+aoDcGeOXtqN4ytYEWnhGNLYkEXMqGbJuKp3si3tG13fw7Neq8aeAQ0NWROLEGsA8Drt
 e7GgP7acE94B2NGoqMIrL19baoAmb8PAMmvDMld/EGby6hVjzhUPpr6jEtgYt1TnfrWnUViqXz8
 nq1FYB0QniWBdk26WvXbH7eQHBj2VtVRutCEYcyf0HPFT+WZFKWgII1rXfWe0LcxgViNXvMpzyv
 35XYCnp2IJv5fBNGFdS1IEWbAvJFkUxM1tfLyNHWrqcsw1OoB0E4iVvhbYeKANtyxGRaMsJS6TP
 uSpGfJP3EUaNUBlYcTSDJmQdrGznw8KhyX7IknCjw25znnNIGXD5+M69cWQs7swReCKUA7l1OXR
 4nmj5n8OTN8Aczw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

On Wed, 10 Jun 2026 13:34:15 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 97750f5edc9..fdd1f0a1410 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -61,6 +61,16 @@ The ``debug-threads`` option of the ``-name`` argument is now
>  ignored. Thread naming is unconditionally enabled for all platforms
>  where it is supported.
>  
> +``-mon`` option (since 11.1)
> +''''''''''''''''''''''''''''
> +
> +The ``-mon`` option was the generic mechanism for creating monitor objects
> +if the convenience ``-qmp`` or ``-monitor`` options were not flexible
> +enough. The momitor objects have been converted to QOM, so ``-mon mode=readline``

"momitor" -> "monitor"

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


