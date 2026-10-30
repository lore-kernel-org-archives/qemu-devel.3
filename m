Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4AB606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bG8QIeEP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbs7-0006DA-7j; Sun, 01 Nov 2026 15:09:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbrh-0006Ah-8q
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:09:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbrd-0005vz-MY
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:09:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793563753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=6xiHC1mSdhm2b+9+r5HslhdzfxCHymEuJlauQYw+tfo=;
 b=bG8QIeEPtK+lUxUXI6O3/sP1zp/zI2sVAkdev+YrK8rBwxqTHW0y8lR4wR137wrVTaahT8
 yVtaWrfvql9YTqnHxi40K8bQuYyS1ZNzSDxkn+D0g9TJzxoUQrhmgAqAEhM1VyHA9K4/Su
 scATGz6nIwOSDXrH9TtnQa6bxgnvyHI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-498-o7Mwu5yZPweRzmiIbsA0Pg-1; Sun,
 01 Nov 2026 15:09:07 -0500
X-MC-Unique: o7Mwu5yZPweRzmiIbsA0Pg-1
X-Mimecast-MFC-AGG-ID: o7Mwu5yZPweRzmiIbsA0Pg_1793563746
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FF31956056; Sun,  1 Nov 2026 20:09:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A19F51800495; Sun,  1 Nov 2026 20:09:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DC7821E6A04; Sun, 01 Nov 2026 21:09:03 +0100 (CET)
Resent-To: michael.roth@amd.com, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, farosas@suse.de, dave@treblig.org
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Sun, 01 Nov 2026 21:09:03 +0100
Resent-Message-ID: <87v76g1fhc.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,  Richard
 Henderson <richard.henderson@linaro.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>,  Eric Blake
 <eblake@redhat.com>,  Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 07/21] util: introduce 'tldr', a system data recorder
 for crash handling
In-Reply-To: <auNnqSCB-1fNrAlb@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Thu, 29 Oct 2026 15:35:05 +0000")
References: <20261015112044.1999748-1-berrange@redhat.com>
 <20261015112044.1999748-8-berrange@redhat.com>
 <87ecd8gba1.fsf@pond.sub.org> <auNnqSCB-1fNrAlb@redhat.com>
Date: Fri, 30 Oct 2026 09:59:53 +0100
Message-ID: <87tsm3a7hy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Thu, Oct 29, 2026 at 09:29:26AM +0100, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > Introduce a new subsystem "tldr" aka "thrifty live data recorder"
>> > that will be able to continuously collect certain information at
>> > runtime and dump that in a crash report when QEMU exits abnormally.
>> > As a second use case, it will support manual triggering on interesting
>> > events such as guest OS panic.
>>=20
>> What's manual about that?
>
> Manual in the sense that the mgmt app has to explicitly request
> the data recorder contents when a guest OS panics, vs automatic
> dump when QEMU dies with a fatal signal.

Suggest to clarify like this: "it lets a management application dump it
manually, say when it received an interesting event such as
GUEST_PANICKED."

>> > diff --git a/qapi/qom.json b/qapi/qom.json
>> > index 49f222796ab..1c9031fba9a 100644
>> > --- a/qapi/qom.json
>> > +++ b/qapi/qom.json
>> > @@ -1233,6 +1233,19 @@
>> >    'data': { '*pretty': 'bool',
>> >              '*close-action': 'MonitorQMPCloseAction' } }
>> >=20=20
>> > +##
>> > +# @QTLDRConfigProperties:
>> > +#     Configuration for data recorder
>> > +#
>> > +# @crash-target: fully qualified path to perserve data recorder
>> > +#                contents on QEMU crash
>>=20
>> What's a "fully qualified path"?
>>=20
>> Do you mean what POSIX calls "absolute pathname"?
>
> Yes.

Let's use that term then.

[...]


