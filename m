Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B3C0C5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 08:53:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMjrY-00072a-6x; Wed, 04 Jun 2025 04:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMjrU-00071D-Ft
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:52:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uMjrR-0002IC-Mt
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 04:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749027156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LMuriBF7t8o6cXbjiyQ4OTkRWlo3nRO0cd7m7x9hsiA=;
 b=IbEv2LUJtEcnu3yB9YO/9i7gULom6UroJ0E192Fl2BHi5ZiOhMoHGr9+2L9ks5QwehvHT9
 mmKSoz8s9bnnZsUwBxAAqbj7f4XdNouOGg8ErGexgJ8EioBKu/fAa39EmXAJw1YtkHIMgx
 xe2xiuu+ONyYaLOIoxcMAnWjxQ6a3R8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-656-H62qn7DpNouTyZqcVwpdow-1; Wed,
 04 Jun 2025 04:52:32 -0400
X-MC-Unique: H62qn7DpNouTyZqcVwpdow-1
X-Mimecast-MFC-AGG-ID: H62qn7DpNouTyZqcVwpdow_1749027151
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48DDC1809C92; Wed,  4 Jun 2025 08:52:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 315421955D8A; Wed,  4 Jun 2025 08:52:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E705621E6757; Wed, 04 Jun 2025 10:52:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Thomas Huth
 <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Kevin Wolf <kwolf@redhat.com>,  Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>,  Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 1/3] docs: introduce dedicated page about code
 provenance / sign-off
In-Reply-To: <37b3f3a1-bacb-4682-a9d2-7771e29fe55f@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 4 Jun 2025 09:46:59
 +0200")
References: <20250603142524.4043193-1-armbru@redhat.com>
 <20250603142524.4043193-2-armbru@redhat.com>
 <87a56o3gxc.fsf@draig.linaro.org> <87r000ypi0.fsf@pond.sub.org>
 <37b3f3a1-bacb-4682-a9d2-7771e29fe55f@linaro.org>
Date: Wed, 04 Jun 2025 10:52:15 +0200
Message-ID: <87msanyjls.fsf@pond.sub.org>
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
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 4/6/25 08:44, Markus Armbruster wrote:
>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>=20
>>> Markus Armbruster <armbru@redhat.com> writes:
>>>
>>>> From: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>>
>>>> Currently we have a short paragraph saying that patches must include
>>>> a Signed-off-by line, and merely link to the kernel documentation.
>>>> The linked kernel docs have a lot of content beyond the part about
>>>> sign-off an thus are misleading/distracting to QEMU contributors.
>>>>
>>>> This introduces a dedicated 'code-provenance' page in QEMU talking
>>>> about why we require sign-off, explaining the other tags we commonly
>>>> use, and what to do in some edge cases.
>>>>
>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>>>> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>   docs/devel/code-provenance.rst    | 218 ++++++++++++++++++++++++++++=
++
>>>>   docs/devel/index-process.rst      |   1 +
>>>>   docs/devel/submitting-a-patch.rst |  18 +--
>>>>   3 files changed, 221 insertions(+), 16 deletions(-)
>>>>   create mode 100644 docs/devel/code-provenance.rst
>
>
>>>> +
>>>> +   Signed-off-by: YOUR NAME <YOUR@EMAIL>
>>>> +
>>>> +using a known identity (sorry, no anonymous contributions.)
>>>> +
>>>
>>> maybe "(contributions cannot be anonymous)" is more direct?
>> If we're deviating from the kernel's text (which is *fine*), let's get
>> rid of the parenthesis:
>>      using a known identity.  Contributions cannot be anonymous.
>> or in active voice:
>>      using a known identity.  We cannot accept anonymous contributions.
>
> I'd add an anchor in the "commonly known identity" paragraph added in
> commit 270c81b7d59 and here link to it.

Makes sense, thanks!

>> I like this one the best.


