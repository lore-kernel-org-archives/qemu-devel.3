Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADB2606A31F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XFcIyPoe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMQu1-0001rY-B7; Thu, 29 Oct 2026 10:14:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMQtb-0001py-BJ
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xMQtX-0005EK-Of
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:14:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793283253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQ2CJ5p07QnKSMBt6DqrLBt42EO8sQJwRt7FIkOcEw0=;
 b=XFcIyPoeWKLN3rV/31Bvj2A1HQ3JYJrwk69n+uvdYf+kQmMKlKvq4+Z+Hl+gzKeggodDPd
 +cV4cQpm52A94NJHUSkdDllNIrjtBWAWVukx2sTx33h8eqMv25NryLoyErB9/aKV9Zl9sn
 HRhCuM8oZRr3kkpxatmKrEjxj6rTgtk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-Uz3zfkIsPKmCIOQ7xqxt9w-1; Thu,
 29 Oct 2026 10:14:00 -0400
X-MC-Unique: Uz3zfkIsPKmCIOQ7xqxt9w-1
X-Mimecast-MFC-AGG-ID: Uz3zfkIsPKmCIOQ7xqxt9w_1793283240
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 373EA19541A0
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 14:13:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A79CA1955F08
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 14:13:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 39DB521E6A04; Thu, 29 Oct 2026 15:13:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 7/8] qemu-options: document -compat insecure-input
 parameter
In-Reply-To: <auMmXsaXkKTzy4Mj@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 29 Oct 2026 10:56:30 +0000")
References: <20261028133603.1893289-1-berrange@redhat.com>
 <20261028133603.1893289-8-berrange@redhat.com>
 <871p99gfrf.fsf@pond.sub.org> <auMmXsaXkKTzy4Mj@redhat.com>
Date: Thu, 29 Oct 2026 15:13:51 +0100
Message-ID: <87wlr0bnmo.fsf@pond.sub.org>
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 29, 2026 at 07:52:36AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > This adds documentation for the previously added 'insecure-input'
>> > parameter to -compat, which controls policy for insecure
>> > configuration requests.
>> >
>> > Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> > ---
>> >  qemu-options.hx | 22 +++++++++++++++++++++-
>> >  1 file changed, 21 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/qemu-options.hx b/qemu-options.hx
>> > index 16d9c6c9072..0487e74bb3e 100644
>> > --- a/qemu-options.hx
>> > +++ b/qemu-options.hx
>> > @@ -4696,7 +4696,9 @@ DEF("compat", HAS_ARG, QEMU_OPTION_compat,
>> >      "-compat [deprecated-input=3Daccept|reject|crash|warn][,deprecate=
d-output=3Daccept|hide]\n"
>> >      "                Policy for handling deprecated management interf=
aces\n"
>> >      "-compat [unstable-input=3Daccept|reject|crash|warn][,unstable-ou=
tput=3Daccept|hide]\n"
>> > -    "                Policy for handling unstable management interfac=
es\n",
>> > +    "                Policy for handling unstable management interfac=
es\n"
>> > +    "-compat [insecure-input=3Daccept|reject|crash|warn]\n"
>> > +    "                Policy for handling requests for insecure config=
uration requests\n",
>> >      QEMU_ARCH_ALL)
>> >  SRST
>> >  ``-compat [deprecated-input=3D<input-policy>][,deprecated-output=3D<o=
utput-policy>]``
>> > @@ -4734,6 +4736,24 @@ SRST
>> >          Suppress unstable command results and events
>> >=20=20
>> >      Limitation: covers only syntactic aspects of QMP.
>> > +
>> > +``-compat [insecure-input=3D<input-policy>]
>> > +    Set policy for handling requests for insecure configuration
>> > +    requests:
>> > +
>> > +    ``insecure-input=3Daccept`` (default)
>> > +        Accept insecure configurations requests silently
>> > +    ``insecure-input=3Dwarn``
>> > +        Accept insecure configuration requests with warning on stderr
>> > +    ``insecure-input=3Dreject``
>> > +        Reject insecure configuration requests
>> > +    ``insecure-input=3Dcrash``
>> > +        Crash on insecure configuration requests
>> > +
>> > +    Limitation: an insecure configuration is one where QEMU has
>> > +    not intended to provide a security boundary to protect against
>>=20
>> "Where QEMU has not intended to provide" sounds odd to me.  Mind, I'm
>> not a native speaker.  "Where QEMU does not provide".
>
> Yeah, that language choice was me by pessimistic expecting that
> QEMU is full of undiscovered flaws. I'll change to what you
> suggested.
>
>> > +    malicious usage. Covers only QOM types for devices, machine types
>> > +    and accelerators.
>>=20
>> The policy check is in
>>=20
>> * qemu_create_machine(), which covers machine creation.
>>=20
>> * do_configure_accelerator(), which covers accelerator creation.
>>=20
>> * qdev_device_add_from_qdict(), which covers *some* device creation:
>>=20
>>   * device_add and -device always
>>=20
>>   * Half of -audio model=3Dhda: covers the "intel-hda" device, but not t=
he
>>     "hda-duplex" device.  See intel_hda_and_codec_init().
>>=20
>>   * The "primary device" created in failover_hide_primary_device() for
>>     the virtio-net standby feature.
>>=20
>>   * The "usb-host" device device created in xen-usb.c for some reason.
>>=20
>>   There's plenty of device creation it doesn't cover.  Isn't this
>>   problematic?  I certainly expected it to cover *all* device creation!
>
> Yes, eventually, but not yet....
>
>>=20
>>   Say board code creates a certain onboard device with the usual low
>>   level interfaces like qdev_new() and qdev_realize().  Say we mark the
>>   onboard device insecure.  The policy check doesn't apply.  We need to
>>   manually mark the machine type insecure as well.  Feels awfully prone
>>   to human error.
>>=20
>>   Moreover, what if the onboard device is configurable?  Then the
>>   machine type may be secure unless you configure this insecure device.
>>   Marking the machine type would be too coarse.
>>=20
>>   Could we check policy in qdev_realize() instead?
>
> Yes and no.
>
> To make this a tractable problem I only wanted to add '.secure =3D true'
> annotations for public facing types initially, so needed the check in
> the device_add/-device code path only.
>
> This is sufficient to let us tell bug report filers to take their demo
> command line and add
>
>   '-compat insecure-input=3Dreject -nodfaults'
>
> as a pre-requisite for a bug being considered a security flaw
> egligible for CVE handling.
>
>
> If we put a check in qdev_realize(), then we need to add annotations
> for *all* types, before the -compat insecure-input=3D....  option is
> viable to use. That requires a much bigger effort to mark all types.
>
> In the 12.0 dev cycle, my intention is to
>
>  a) Expand ".secure =3D true" markers to all parents of leaf node types
>     marked secure, and enforce them.
>  b) Expand ".secure =3D true" markers to all built-in devices that are
>     indirectly created by a leaf node type marked secure, when
>     -nodefaults is present
>
> Once (b) is done, then qdev_realize() will likely be the better place
> to put the policy check.

Let's see whether I got this.

* A type can be known to be secure, known to be insecure, or unknown.

* Exactly the types known to be secure are marked secure.  Thus, the
  policy check must treat known to be insecure and unknown the same,
  which makes sense.

* We start with all types unknown.

* To move a type from unknown to known, we need to examine it.
  Examining all types in time for the next release is infeasible.  Even
  examining all types usable with a useful set of machines is
  infeasible.  What is feasible is examining a useful set of types
  available with certain user interfaces, so that's what we did.

* We check the policy in these interfaces only.  This lets users
  restrict these interfaces to known secure types, which is useful.

* However, types created differently get a blanket exception.  Not
  ideal, but no worse than before, unless the new policy creates a false
  sense of security.  The best we can (and should) do about that is to
  clearly document the policy's current limitations.

Right?


