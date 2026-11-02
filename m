Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779F606A324
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=I2cU1f0B
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNkfq-00006S-BJ; Mon, 02 Nov 2026 00:33:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkfo-00005y-K1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:33:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNkfn-0006Y7-6y
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 00:33:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793597613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1C6fUa8Qk0KkX87u9aia6i6jTEVvNuwiTEGT1HSkjyc=;
 b=I2cU1f0BPM7Wxr+IFC96qNwTAqtgD5WyLHve0Jl6HrrZfNguMvgeVr8jcU03UrGupH+G8F
 ugA6o2U6EtRPa/Wcs3rUuavcy600jI7cUvT8Z8Y5DbXoZJ4uh+ZR6gJEhZaFYl051ztc+G
 3Jko7BS06Wh8lAyjXNhySxlJF74oz3E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-UuJm2D6YPSeEYtFFCfOZuA-1; Mon,
 02 Nov 2026 00:33:32 -0500
X-MC-Unique: UuJm2D6YPSeEYtFFCfOZuA-1
X-Mimecast-MFC-AGG-ID: UuJm2D6YPSeEYtFFCfOZuA_1793597611
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FE971956048
 for <qemu-devel@nongnu.org>; Mon,  2 Nov 2026 05:33:31 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B404195608B; Mon,  2 Nov 2026 05:33:29 +0000 (UTC)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 16/56] qom: New object_property_add_enum() etc.
 parameter @qapi_type
From: marcandre.lureau@redhat.com
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 berrange@redhat.com
In-Reply-To: <20261101201717.3911097-17-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
 <20261101201717.3911097-17-armbru@redhat.com>
Date: Mon, 02 Nov 2026 09:33:15 +0400
Message-Id: <179359759596.3177668.362798704667518496.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=618;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KGlqISeBC2wJN2sQCM93ml4/TZ29nolSTpZ6rDJj4+k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq6CCe3+7hVtQ06sWpcvGO1lFI3/n+lQZ/OcLIM
 feh7VLlypaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCauggngAKCRDa6OEJdZac
 5YYGD/9ho2MZz6M2pmMpXJ/axEpc3IUmSsvmf2GVFKoGsv/z5mxwQYotCx9GHpKFAXOO7G6LbBE
 A8Q1/jJVL4uoF6w+LgBS+Vds9idzIHERGZgezbpXTArgiyrzmX9w0PgiBxxru60lcFgTHKxpx2o
 XVRgrwQ0BK2LwCqh9mY22tqHVIzM0sQrefLT6jMrjpzFcj6TdTdjknZl7rR/RvH1GEhWHz+fbC2
 9mPJiAAwKSy2c2BhINHVzzBhwJz4cwdzCe0Ubk9MWiQ0LYUPbHDKjzDPxg1S5aZXUlXdtNNNbFs
 0/xjb+10NWqGxa3J5ERpVytiRq4PRIOiVQ6zgZUgNzbahF/Cm13jHk6vTtl0Av3Jfyyru/Uyio5
 DeeiLIQxU9mQtbV2/02rOMSQ2k8zSWmknBdNjqYUrsmfRIVuQDMFyDq8mIJM/YjAEtaIgDB8Lfk
 Gkn6Fc04EL6VhDNP4jbUBfraasyGryxD+LrQF8q/8wPk6r4INAMeIeF9Je7zBjEYhfjgZ97hpZ3
 2dZLxpJd1TUHXQO3D6UrtNUwHggbVfudgNOM5pGv4AmuiCOuQE3am9YEKrVtm1In5ZsxebW1CHM
 oJNa+c5I7s2TJdEAhWL7z/KGbOP09YxxO2BE3FEA01+LEdEbo7c3rK/yN2iBhjRVXAGDpvYfGNA
 2f7ZylsLzXCDsOg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 01 Nov 2026 21:16:37 +0100, Markus Armbruster <armbru@redhat.com> wrote:
> Callers may either pass a non-null @lookup, or a non-null @qapi_type.
> For now, all pass a non-null @lookup and a null @qapi_type.  Callers
> updated with this Coccinelle script:
> 
> @@
> identifier fun = {
>     object_property_add_enum, object_class_property_add_enum
> };
> expression obj, name, type;
> @@
> -    fun(obj, name, type,
> +    fun(obj, name, type, NULL,
>      ...)
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


