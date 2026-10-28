Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5B4606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 10:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JJ5CFMAu
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM0j2-0008Vz-TY; Wed, 28 Oct 2026 06:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM0j0-0008VU-MD
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:17:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xM0iy-0003yV-M7
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 06:17:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793182658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m3mVGLjy1uMvHqnFZYdvic6+tZbuuSBebyHGoQZ7158=;
 b=JJ5CFMAu3ZU7Kx9vc+pmHuVZJEkG0AF3wqRw9yQnlk9uEQHxjDpvmoS5WoDhTSsnkmlm9J
 hFzvgYuwPMJgid4WOB3UP5rNdLnIJGYALFGcTaaWfp01tf5dUoLgSNm+5bIndivMP951q+
 mjcH5HYIXa574MZ3K+UGjQs63pXBlsU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-249-0d3bNWMlOq6q0EwM5SjAWQ-1; Wed,
 28 Oct 2026 06:17:34 -0400
X-MC-Unique: 0d3bNWMlOq6q0EwM5SjAWQ-1
X-Mimecast-MFC-AGG-ID: 0d3bNWMlOq6q0EwM5SjAWQ_1793182653
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 433A41955F0D; Wed, 28 Oct 2026 10:17:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86D351956086; Wed, 28 Oct 2026 10:17:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2F16A21E6A04; Wed, 28 Oct 2026 11:17:29 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: Timur Maksimov <gessingate@gmail.com>,  qemu-devel@nongnu.org,  Paolo
 Bonzini <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,  Kane Chen
 <kane_chen@aspeedtech.com>,  qemu-arm@nongnu.org,  Fabiano Rosas
 <farosas@suse.de>,  Laurent Vivier <lvivier@redhat.com>,  Corey Minyard
 <cminyard@mvista.com>
Subject: Re: [PATCH v2 1/6] hw/i2c: add dummy device
In-Reply-To: <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 28 Oct 2026 09:54:13 +0100")
References: <20261027-aspeed-i2c-nonpkt-fix-v2-0-07deed1dff60@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v2-1-07deed1dff60@gmail.com>
 <2629ee8a-e817-4764-a1e3-72e0ccbb978b@kaod.org>
Date: Wed, 28 Oct 2026 11:17:29 +0100
Message-ID: <874ie6ku2u.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

C=C3=A9dric Le Goater <clg@kaod.org> writes:

> + Corey for I2C feed back.
>
> + Markus for QOM
>
> The brute-force solution to expose the contents of the device array
> with 128 properties has a slight AI smell. I find it ugly but I am
> human :)

Timur, have you read docs/devel/code-provenance.rst section "Use of
AI-generated content"?

>          That said I don't know if there are better alternatives.
> My approach would have been to use a string property :
>
>       object_property_add_str(obj, "tx",
>                               i2c_dummy_device_get_tx, NULL);
>       object_property_add_str(obj, "rx",
>                               i2c_dummy_device_get_rx,
>                               i2c_dummy_device_set_rx);
>  Any better ideas ?

I believe you're talking about this function:

[...]

>> +static void i2c_dummy_device_init(Object *obj)
>> +{
>> +    I2CDummyDeviceState *s =3D I2C_DUMMY_DEVICE(obj);
>>
>> +    for (int i =3D 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
>> +        g_autofree char *name =3D g_strdup_printf("tx[%d]", i);
>> +
>> +        object_property_add_uint8_ptr(
>> +            obj, name, &s->tx[i],
>> +            OBJ_PROP_FLAG_READWRITE);
>> +    }
>> +
>> +    for (int i =3D 0; i < I2C_DUMMY_ARRAY_SIZE; i++) {
>> +        g_autofree char *name =3D g_strdup_printf("rx[%d]", i);
>> +
>> +        object_property_add_uint8_ptr(
>> +            obj, name, &s->rx[i],
>> +            OBJ_PROP_FLAG_READWRITE);
>> +    }
>> +
>> +    object_property_add_uint8_ptr(
>> +            obj, "tx-pos", &s->tx_pos,
>> +            OBJ_PROP_FLAG_READWRITE);
>> +    object_property_add_uint8_ptr(
>> +            obj, "rx-pos", &s->rx_pos,
>> +            OBJ_PROP_FLAG_READWRITE);
>
> alignment could be improved.

Yes, this style is unusual in QEMU, and should therefore be avoided.

>> +}

The function adds properties "tx-pos", "tx[0]", ... "tx[63]", and same
for rx.

The commit message tells us this is a "Simple I2C device with QOM
properties to access transmit and receive buffers [...] for testing or
prototyping."  It doesn't tell us how it could be used, and I can't see
any documentation, either.  So let's start right there: please show us
how this device could be used.  This should help me understand what the
properties are for.  Only then can I advise on proper QOM usage.

[...]


