Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6DE7C02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBb8-0002fm-RZ; Wed, 12 Feb 2025 07:12:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiBb6-0002eT-6x
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:12:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tiBb0-0008Va-Gh
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739362320;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XW1rA0H1nr+qBBUoAjCh/emWM2TDDn8HQD/tQui2NfA=;
 b=B2cZafTMe7BUsRgmCf4DQxTJtrwWJnIUoMiJgCKrDoGx86mmawc38EhQj+Mr5bo9oJoSC3
 Td4Y+PoNED3a/1Bubt317a17LJ4I1nhBy/hnhS9xeHR0EkWoTDFftAl4XeotKC3vzwj9He
 XQSCFybtM9n6ZvkvLAdvTYe8BVJKHLg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-nuHbwGeSNES2990pIvEtpg-1; Wed,
 12 Feb 2025 07:11:57 -0500
X-MC-Unique: nuHbwGeSNES2990pIvEtpg-1
X-Mimecast-MFC-AGG-ID: nuHbwGeSNES2990pIvEtpg_1739362316
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D03FD1800871; Wed, 12 Feb 2025 12:11:54 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.110])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6642B18004A7; Wed, 12 Feb 2025 12:11:46 +0000 (UTC)
Date: Wed, 12 Feb 2025 12:11:42 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
Subject: Re: [PATCH v6 01/11] hw/qdev-properties-system: Introduce EndianMode
 QAPI enum
Message-ID: <Z6yP_k0QYXpDrtMt@redhat.com>
References: <20250212112413.37553-1-philmd@linaro.org>
 <20250212112413.37553-2-philmd@linaro.org>
 <cb828dd8-25f6-47c6-9ac7-cae5b0d0932e@redhat.com>
 <50ba4e4b-4124-46bb-bb84-4758ce9c5e66@linaro.org>
 <24377a63-0772-4dda-875d-2c4fddd1bbca@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <24377a63-0772-4dda-875d-2c4fddd1bbca@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 12, 2025 at 01:02:18PM +0100, Philippe Mathieu-Daudé wrote:
> On 12/2/25 12:43, Philippe Mathieu-Daudé wrote:
> > On 12/2/25 12:37, Thomas Huth wrote:
> > > On 12/02/2025 12.24, Philippe Mathieu-Daudé wrote:
> > > > Introduce the EndianMode type and the DEFINE_PROP_ENDIAN() macros.
> > > > Endianness can be BIG, LITTLE or unspecified (default).
> > > > 
> > > > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > > ---
> > > >   qapi/common.json                    | 16 ++++++++++++++++
> > > >   include/hw/qdev-properties-system.h |  7 +++++++
> > > >   hw/core/qdev-properties-system.c    | 11 +++++++++++
> > > >   3 files changed, 34 insertions(+)
> > > > 
> > > > diff --git a/qapi/common.json b/qapi/common.json
> > > > index 6ffc7a37890..217feaaf683 100644
> > > > --- a/qapi/common.json
> > > > +++ b/qapi/common.json
> > > > @@ -212,3 +212,19 @@
> > > >   ##
> > > >   { 'struct': 'HumanReadableText',
> > > >     'data': { 'human-readable-text': 'str' } }
> > > > +
> > > > +##
> > > > +# @EndianMode:
> > > > +#
> > > > +# An enumeration of three options: little, big, and unspecified
> > > > +#
> > > > +# @little: Little endianness
> > > > +#
> > > > +# @big: Big endianness
> > > > +#
> > > > +# @unspecified: Endianness not specified
> > > > +#
> > > > +# Since: 10.0
> > > > +##
> > > > +{ 'enum': 'EndianMode',
> > > > +  'data': [ 'little', 'big', 'unspecified' ] }
> > > 
> > > Should 'unspecified' come first? ... so that it gets the value 0,
> > > i.e. when someone forgets to properly initialize a related variable,
> > > the chances are higher that it ends up as "unspecified" than as
> > > "little" ?
> 
> BTW I'm not sure QAPI guaranty enums are following an order
> (at least, as in C, I wouldn't rely on that assumption).

If we don't document a guaranteed order IMHO we should, mostly just for the
sake for guaranteeing exactly what will be the 0 value . It is pretty common
to want a particular enum constant to be special default for the 0 value.
It allows enums to be retrofitted into existing code, with confidence that
any code forgetting to initialize a variable/field will get the special
default. Missed initialization is relatively common as a C bug, and we
use -ftrivial-auto-var-init=zero to give well defined (usually safe)
semantics.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


