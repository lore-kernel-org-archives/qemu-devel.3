Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0E3DC3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 14:08:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVthX-0004Jl-3L; Mon, 22 Jul 2024 10:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sVthT-0004Il-KG
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:07:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sVthQ-0000vH-Te
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 10:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721657254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rzl4IwoAVgEgzwZUGfQ2dc/+Xt24rcF772K130ZonTY=;
 b=JisI/DDdahvBBlvUwadEA4Z+lydVocGC/MzrOtiE6kZ8+TPqF2OOQ6VooRcK9bnAJKbhCF
 LM1uF2u3/Z418/8pluYcAjKfSEu00whedxGoyIcce0VrkaCggv/vx55uFyW3YAxTSoQHgR
 pO7Ew7xrJtC8MtbjAnQJ0M4srmtluw0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-26-TloiqygdOQm1pLqdp6aZog-1; Mon,
 22 Jul 2024 10:07:32 -0400
X-MC-Unique: TloiqygdOQm1pLqdp6aZog-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E0D751955D55
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:07:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 941C6195605F
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 14:07:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F28B221E668F; Mon, 22 Jul 2024 16:07:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH for-9.0] qapi: drop unused
 QCryptoBlockCreateOptionsLUKS.detached-header
In-Reply-To: <Zp5YICB4dCjh3e-X@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 22 Jul 2024 14:01:20 +0100")
References: <20240319153908.194975-1-berrange@redhat.com>
 <87jzlyyzo0.fsf@pond.sub.org> <Zp5YICB4dCjh3e-X@redhat.com>
Date: Mon, 22 Jul 2024 16:07:28 +0200
Message-ID: <8734o134gv.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Tue, Mar 19, 2024 at 05:06:07PM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The 'detached-header' field in QCryptoBlockCreateOptionsLUKS
>> > was left over from earlier patch iterations.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  qapi/crypto.json | 5 +----
>> >  1 file changed, 1 insertion(+), 4 deletions(-)
>> >
>> > diff --git a/qapi/crypto.json b/qapi/crypto.json
>> > index 931c88e688..ad9e3d0297 100644
>> > --- a/qapi/crypto.json
>> > +++ b/qapi/crypto.json
>> > @@ -226,8 +226,6 @@
>> >  # @iter-time: number of milliseconds to spend in PBKDF passphrase
>> >  #     processing.  Currently defaults to 2000. (since 2.8)
>> >  #
>> > -# @detached-header: create a detached LUKS header. (since 9.0)
>> > -#
>> >  # Since: 2.6
>> >  ##
>> >  { 'struct': 'QCryptoBlockCreateOptionsLUKS',
>> > @@ -237,8 +235,7 @@
>> >              '*ivgen-alg': 'QCryptoIVGenAlgorithm',
>> >              '*ivgen-hash-alg': 'QCryptoHashAlgorithm',
>> >              '*hash-alg': 'QCryptoHashAlgorithm',
>> > -            '*iter-time': 'int',
>> > -            '*detached-header': 'bool'}}
>> > +            '*iter-time': 'int' }}
>> >=20=20
>> >  ##
>> >  # @QCryptoBlockOpenOptions:
>>=20
>> Glad you caught this in time.
>>=20
>> Acked-by: Markus Armbruster <armbru@redhat.com>
>
> Urgh, it appears this patch got lost and was not in fact included in
> 9.0.  What's your opinion on removing it from 9.1 with no deprecation
> period ?  Functionally it did absolutely nothing even if used, so
> removing it at most would cause an incorrect field to now be rejected.

Doc section "Deprecated features":

    In general features are intended to be supported indefinitely once
    introduced into QEMU. In the event that a feature needs to be removed,
    it will be listed in this section. The feature will remain functional f=
or the
    release in which it was deprecated and one further release. After these=
 two
    releases, the feature is liable to be removed. Deprecated features may =
also
    generate warnings on the console when QEMU starts up, or if activated v=
ia a
    monitor command, however, this is not a mandatory requirement.

Note this talks about *features*.

The software industry has a longstanding habit of declaring bugs
features.  By removing @detached-header without a deprecation period, we
effectively do the opposite.  The opposite of something bad must be
good, right?  ;-)

Seriously, it's a judgement call.  I'm happy to defer to your judgement
here.


