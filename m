Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59CC2C5DF9C
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 10:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wySEU-0002pg-Dp; Mon, 24 Aug 2026 06:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wySET-0002pI-2C
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wySEQ-0007De-LJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 06:48:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787568523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qaFLB4AJJ2Uguw4rcDY33BLUdjnMmj2Qtv/diyv5PAY=;
 b=T962ASiQdikJ0ZSieOSjdXV7wjWnaLVX5R/5mtm9brFa0HF68zp1k0iLciEARA5/JGbuaq
 KTdQSZZps/VumkgqQdWrg4xNzsel8LEGKqykvhkix87a2VxBttTVvJYot0b9zg+2HTjLzu
 kuu34j41tfduB2phxRv1LqslI3K1aPg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-GK1Gqn1jN6yGR1-X4qL7yg-1; Mon,
 24 Aug 2026 06:48:40 -0400
X-MC-Unique: GK1Gqn1jN6yGR1-X4qL7yg-1
X-Mimecast-MFC-AGG-ID: GK1Gqn1jN6yGR1-X4qL7yg_1787568519
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 898151955D77; Mon, 24 Aug 2026 10:48:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F500434; Mon, 24 Aug 2026 10:48:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A92EC21E6920; Mon, 24 Aug 2026 12:48:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  stefanha@redhat.com,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Subject: Re: [PULL 35/35] docs: mark '-mon' as deprecated in favour of -object
In-Reply-To: <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
 (Peter Maydell's message of "Mon, 24 Aug 2026 11:26:31 +0100")
References: <20260707110300.1918153-1-armbru@redhat.com>
 <20260707110300.1918153-36-armbru@redhat.com>
 <CAFEAcA-tUz_YGhvqU8-o-jw-jhR4MTMFDJ3S9rA2ZG-0GpLtVw@mail.gmail.com>
Date: Mon, 24 Aug 2026 12:48:36 +0200
Message-ID: <87o6erssjf.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Tue, 7 Jul 2026 at 12:06, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>
>> The high level `-qmp` and `-monitor` options can remain as convenience
>> wrappers, but the low level `-mon` is completed obsoleted by the new
>> `-object` support with 'monitor-qmp' and 'monitor-hmp' types.
>>
>
>> @@ -3239,6 +3239,8 @@ void qemu_init(int argc, char **argv)
>>                  default_monitor =3D 0;
>>                  break;
>>              case QEMU_OPTION_mon:
>> +                warn_report_once("'-mon' is deprecated, use '-object' w=
ith "
>> +                                 "'monitor-hmp' or 'monitor-qmp' types =
instead");
>
> Can we be more precise in deprecation messages of this kind, please?
> This warning is not enough for the user to be able to figure out how
> to change their existing command line.
>
> I had to look into deprecated.rst, check the git history to see which
> commit added the deprecation, then find out how this commit was adjusting
> the examples in the tree.
>
> Notably, "-object monitor-hmp" appears to require an "id=3D" despite
> nothing actually caring what that ID is,

Yes, -object requires @id regardless of object type.  It calls
object_new_with_props_from_qdict() via user_creatable_add_qapi().
Together, they create the object at /objects/ID.

>                                          and the warning message
> doesn't say how to determine whether your existing -mon option
> should be changed to monitor-hmp or monitor-qmp. The deprecated.rst
> docs do say that part, but don't mention the ID bit.

Fair points.

Is this just "do better in the future", or are you also asking for a
patch to improve this warning?


