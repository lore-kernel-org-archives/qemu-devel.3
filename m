Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D2CC61DD6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:35:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1iIh-0000Bs-Dd; Wed, 02 Sep 2026 06:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iIf-0000BU-Ib
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:34:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iId-0002fk-VV
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788345274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8/5N7bRGDJ50rA1Y4/FmAiImUXX0EIs2omskb74Yj5E=;
 b=PRWx1CBZ+6Qy0OV8UIS0BBbCGVSGwPpYyJKMhGma6E+1VAsIAgqqI8CFfA3iI6AwDYbpB/
 EBvAgfxzjwypCHRCPOGdtHPLodZuwD+lx06z4mxrsAz4fuBzChWMUOhuWd0wiQsFBupXTr
 W7nmeJogvKdkD6C/N9dF4j6BxidXn4k=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-bVV7CZiyMYmB04SXZjbrvw-1; Wed,
 02 Sept 2026 06:34:31 -0400
X-MC-Unique: bVV7CZiyMYmB04SXZjbrvw-1
X-Mimecast-MFC-AGG-ID: bVV7CZiyMYmB04SXZjbrvw_1788345270
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 07F7719776A7; Wed,  2 Sep 2026 10:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9E0527EA; Wed,  2 Sep 2026 10:34:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E34621E682E; Wed, 02 Sep 2026 12:34:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: John Snow <jsnow@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@gmail.com>,  Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>,  QEMU <qemu-devel@nongnu.org>
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
In-Reply-To: <apfhDvrlNFQKJLI7@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 2 Sep 2026 09:40:46 +0100")
References: <20260901195334.463267-1-jsnow@redhat.com>
 <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
 <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
 <apfhDvrlNFQKJLI7@redhat.com>
Date: Wed, 02 Sep 2026 12:34:27 +0200
Message-ID: <87ik4o3psc.fsf@pond.sub.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Sep 01, 2026 at 06:11:03PM -0400, John Snow wrote:
>> On Tue, Sep 1, 2026 at 4:18=E2=80=AFPM Marc-Andr=C3=A9 Lureau
>> <marcandre.lureau@gmail.com> wrote:
>> >
>> >
>> > Hi
>> >
>> > Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a =C3=A9crit=
 :
>> >>
>> >> I was unable to get in touch with Stefan and I am not currently sure
>> >> if this module is maintained or not. To prevent an avalanche of
>> >> bounced emails, remove his contact information.
>> >
>> >
>> > Really? There must be something wrong. He is a very responsive and act=
ive maintainer.
>>=20
>> All of the emails I have are bouncing; I hope they turn up! I would
>> love to be proven hasty.
>
> When I replied to John's docs series last week it triggered a
> blizzard of non-delivery emails for Stefan's address:
>
>   Attempting to deliver following mail to recipient(s):
>     <stefanb@linux.ibm.com>
>   VMSDVM9.POK.IBM.COM unable to connect for 1 days to recipient host.
>   Delivery will be attempted for a total of 3 days.
>
> but I never got any more of those after that, and the 3 days passed,
> so I'm thinking they did indeed get delivered in the end.
>
> With regards,
> Daniel

I got several "552 Over quota" bounces in the past few days.


