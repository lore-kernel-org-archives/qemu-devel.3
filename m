Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA173C02183
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 09:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXd5S-0003np-W6; Tue, 14 Jan 2025 04:19:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXd5Q-0003nb-AV
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:19:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXd5L-0001pI-Va
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 04:19:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736846381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4C3m1ijWWUNfNwvKq7aXOlQrTawV5r/4d0ZgdfwR84A=;
 b=cC7irVG3F+pZ2uj+4p38lBemVbVjN7A8kA/q5kH45OWxYePyulgbJBfec8ghoEJu9JBBNo
 +EVRVBp5DfJVseNrF0YbyFwMwwUda74NW1k0oo71YHw8Logl5Rk1GnijyYeFiYu4DoOv7V
 NSgu6UAowzaKS1/UEnVrWeCGAl7laNU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-q1dFA--wMfSMelKXbc0YnQ-1; Tue,
 14 Jan 2025 04:19:38 -0500
X-MC-Unique: q1dFA--wMfSMelKXbc0YnQ-1
X-Mimecast-MFC-AGG-ID: q1dFA--wMfSMelKXbc0YnQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7247F1953955; Tue, 14 Jan 2025 09:19:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F28C195608A; Tue, 14 Jan 2025 09:19:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 28A6B21E6924; Tue, 14 Jan 2025 10:19:34 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/23] docs/qapidoc: support header-less freeform sections
In-Reply-To: <CAFn=p-bYFhOh1iuij_AXAZ3s3k5FY8cVwAMiQ-FNCn8Du-kduA@mail.gmail.com>
 (John Snow's message of "Mon, 13 Jan 2025 14:12:53 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-2-jsnow@redhat.com>
 <877c7zdb1h.fsf@pond.sub.org>
 <CAFn=p-bYFhOh1iuij_AXAZ3s3k5FY8cVwAMiQ-FNCn8Du-kduA@mail.gmail.com>
Date: Tue, 14 Jan 2025 10:19:34 +0100
Message-ID: <874j21kb15.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.019,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Mon, Dec 16, 2024 at 8:15=E2=80=AFAM Markus Armbruster <armbru@redhat.=
com> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > The code as written can't handle if a header isn't found, because `nod=
e`
>> > will be uninitialized.
>>
>> Yes, we initialize @node only if we have a heading.
>>
>> Made me wonder what happens when we don't.  So I deleted the =3D from the
>> "# =3D Subsection" line in doc-good.json, and got:
>>
>>     Exception occurred:
>>       File "/work/armbru/qemu/docs/sphinx/qapidoc.py", line 425, in
>> freeform
>>         self._parse_text_into_node(text, node)
>>                                          ^^^^
>>     UnboundLocalError: cannot access local variable 'node' where it is n=
ot
>> associated with a value
>>
>> So you're fixing a crash bug, but that's perhaps less than clear from
>> the commit message.
>>
>> >                        If we don't have a section title, create a
>> > generic block to insert text into instead.
>> >
>> > This patch removes a lingering pylint warning in the QAPIDoc implement=
ation
>>
>> Can you show me the warning?  My pylint doesn't...
>>
>> > that prevents getting a clean baseline to use for forthcoming
>> > additions.
>> >
>> > I am not attempting to *fully* clean up the existing QAPIDoc
>> > implementation in pylint because I intend to delete it anyway; this
>> > patch merely accomplishes a baseline under a specific pylint
>> > configuration:
>> >
>> > PYTHONPATH=3D../../scripts/ pylint --disable=3Dfixme,too-many-lines,\
>> >     consider-using-f-string,missing-docstring,unused-argument,\
>> >     too-many-arguments,too-many-positional-arguments,\
>> >     too-many-public-methods \
>> >     qapidoc.py
>>
>> What version of pylint?  Mine chokes on too-many-positional-arguments.
>
> 3.3.1 here; if yours doesn't have that warning, there's no need to disable
> it. just remove that flag from the CLI.

I've since upgraded to  3.3.3, which doesn't choke.

> (I promise I do want to get this rigorously checked and automated, I'm
> sorry it's taken so long to achieve.)

[...]


