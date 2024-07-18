Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E81C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 13:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sURTA-00069M-56; Thu, 18 Jul 2024 09:46:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURT5-0005xy-VC
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:46:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sURT2-0003gs-ST
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 09:46:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721310401;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YA6uFmR4pA0V5aM78IJtZVWjT0yyu91y3toKFa6JWG8=;
 b=gqYncDPcERX9CnAyVLVxFitDHq9QFbqhrtisVRSYJWo1tnTUiUL4rDXn4i/8H9T63iJkTN
 +a95pTBSQr49kvmFcjpBiKzwgVtIizWLz+NNIIrqJV4vpro9zC8umKt+Y53ACaiBBXhRiM
 jmE1R2eZzL2WKuCBDf88KwBU2A5oieQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-MtGJkOmmNVa3-PcBQjFfHA-1; Thu,
 18 Jul 2024 09:46:37 -0400
X-MC-Unique: MtGJkOmmNVa3-PcBQjFfHA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 29F911955F6B; Thu, 18 Jul 2024 13:46:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C5A019560B2; Thu, 18 Jul 2024 13:46:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C19D821E66A3; Thu, 18 Jul 2024 15:46:23 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <t-8ch@linutronix.de>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Kashyap Chamarthy <kchamart@redhat.com>,
 qemu-devel@nongnu.org,  Kevin Wolf <kwolf@redhat.com>,  Hanna Czenczek
 <hreitz@redhat.com>
Subject: Re: [PATCH v5 1/4] docs/interop/firmware.json: add new enum
 FirmwareFormat
In-Reply-To: <20240718152306-277d9707-6fb4-4707-ae1c-78927fa42a4f@linutronix.de>
 ("Thomas =?utf-8?Q?Wei=C3=9Fschuh=22's?= message of "Thu, 18 Jul 2024
 15:25:54 +0200")
References: <20240718-qapi-firmware-json-v5-0-0dba12d7aaf5@linutronix.de>
 <20240718-qapi-firmware-json-v5-1-0dba12d7aaf5@linutronix.de>
 <877cdionhq.fsf@pond.sub.org>
 <20240718152306-277d9707-6fb4-4707-ae1c-78927fa42a4f@linutronix.de>
Date: Thu, 18 Jul 2024 15:46:23 +0200
Message-ID: <87cynan780.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Thomas Wei=C3=9Fschuh <t-8ch@linutronix.de> writes:

> On Thu, Jul 18, 2024 at 03:09:37PM GMT, Markus Armbruster wrote:
>> Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
>>=20
>> > Only a small subset of all blockdev drivers make sense for firmware
>> > images. Introduce and use a new enum to represent this.
>> >
>> > This also reduces the dependency on firmware.json from the global qapi
>> > definitions.
>> >
>> > Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
>> > ---
>> >  docs/interop/firmware.json | 17 +++++++++++++++--
>> >  1 file changed, 15 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/docs/interop/firmware.json b/docs/interop/firmware.json
>> > index 54a1fc6c1041..a26fe81bf2fe 100644
>> > --- a/docs/interop/firmware.json
>> > +++ b/docs/interop/firmware.json
>> > @@ -15,7 +15,6 @@
>> >  ##
>> >=20=20
>> >  { 'include' : 'machine.json' }
>> > -{ 'include' : 'block-core.json' }
>> >=20=20
>> >  ##
>> >  # @FirmwareOSInterface:
>> > @@ -200,6 +199,20 @@
>> >               'enrolled-keys', 'requires-smm', 'secure-boot',
>> >               'verbose-dynamic', 'verbose-static' ] }
>> >=20=20
>> > +##
>> > +# @FirmwareFormat:
>> > +#
>> > +# Formats that are supported for firmware images.
>> > +#
>> > +# @raw: Raw disk image format.
>> > +#
>> > +# @qcow2: QEMU image format.
>>=20
>> It's not the only QEMU image format...  Maybe "The QCOW2 image format."
>> Almost tautological, but I don't have better ideas.
>
> I used the wording from qemu-img(1).

Interesting, wasn't aware.

> If you prefer "The QCOW2 image format", I'll switch to that.

Up to you, unless Kevin or Hanna have a preference.

>> > +#
>> > +# Since: 9.1
>>=20
>> The enum type is indeed since 9.1, but its two members are since 3.0,
>> and that's what matters.
>
> Ack.
>
> So I change the Since: of the whole enum?
> And not on the individual members?

Whole enum is simpler, so that's what I'd do.  Perhaps with a brief
explanation in the commit message.  Here's my try:

    Claim "Since: 3.0" for the new enum, because that's correct for its
    members, and the members are what matters in the interface.

>> > +##
>> > +{ 'enum': 'FirmwareFormat',
>> > +  'data': [ 'raw', 'qcow2' ] }
>> > +
>> >  ##
>> >  # @FirmwareFlashFile:
>> >  #
>> > @@ -219,7 +232,7 @@
>> >  ##
>> >  { 'struct' : 'FirmwareFlashFile',
>> >    'data'   : { 'filename' : 'str',
>> > -               'format'   : 'BlockdevDriver' } }
>> > +               'format'   : 'FirmwareFormat' } }
>> >=20=20
>> >=20=20
>> >  ##
>>=20


