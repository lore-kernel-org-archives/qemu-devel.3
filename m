Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6245FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 11:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHgsj-0008RN-6Y; Tue, 28 Apr 2026 07:45:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHgse-0008Nj-8H
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wHgsc-0003Ux-NR
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 07:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777376728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Gr1m0oFiB6DELBeVxVbWPmM/ASNIRdBFuwVRbO3e7s0=;
 b=bnR8JhjUCD8ArGLcCl0wALmparN+EhwytSdUAtxtbleRZLMe0eiUZNx2XQbdtQRbp2dx8Z
 sxx9hh5R3olLaVEqashqYfnu1+lflxPTLQ9LT0Gh+GpOMp395GGyGcSUMigx0rhr2UCG0m
 6DkV72SlGFL0dXZa7W6vZgxMaAsSVkA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-JwAXLQ0ANSy-QGq5kbgipQ-1; Tue,
 28 Apr 2026 07:45:24 -0400
X-MC-Unique: JwAXLQ0ANSy-QGq5kbgipQ-1
X-Mimecast-MFC-AGG-ID: JwAXLQ0ANSy-QGq5kbgipQ_1777376723
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 096AA1956056; Tue, 28 Apr 2026 11:45:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B4371800446; Tue, 28 Apr 2026 11:45:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 017DD21E6A28; Tue, 28 Apr 2026 13:45:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,  Igor Mammedov
 <imammedo@redhat.com>,  Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  Ani Sinha <anisinha@redhat.com>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Eric Blake <eblake@redhat.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 00/12] qapi: add formal "intro" section
In-Reply-To: <CAFn=p-YvfpOm17VgeTmR=e+H+aRjZ8H1C5cV4kx3BZdiZmfVwA@mail.gmail.com>
 (John Snow's message of "Fri, 24 Apr 2026 15:19:38 -0400")
References: <20260423220022.2180059-1-jsnow@redhat.com>
 <CAFn=p-YvfpOm17VgeTmR=e+H+aRjZ8H1C5cV4kx3BZdiZmfVwA@mail.gmail.com>
Date: Tue, 28 Apr 2026 13:45:19 +0200
Message-ID: <87wlxr1f74.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.109,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> On Thu, Apr 23, 2026, 6:00=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
>> Hiya, this is a series that explores a potential syntax for a
>> designated "Intro" section. Markus knows why I want this, but for
>> everyone else: a designated "Introduction" section is useful for the
>> desired "inliner" feature for the new QAPI doc system. Commits explain
>> a bit more. This is prep work and doesn't really change anything
>> tangibly except source code syntax for the QAPI docs.
>>
>> It is designed so that this conversion can happen incrementally with
>> no actual difference to the rendered manuals, so each QAPI module can
>> be converted one at a time for easier review and merging in an
>> arbitrary order.
>>
>> This series demonstrates conversion of just four modules; if I'm given
>> a thumbs up, I will convert the rest of QAPI, one module (or
>> maintainer stanza) per patch like how I handled adding
>> cross-references.
>>
>> John Snow (12):
>>   tests/qapi: generate output in source order
>>   qapi/docs: remove unused QAPIDoc subsection members
>>   qapi/docs: make remaining subsection members "private"
>>   qapi/docs: add "Intro" section
>>   qapi/docs: adjust stub member insertion algorithm
>>   qapi/docs: remove implicit Plain section
>>   qapi/docs: add "Intro" section parsing
>>   qapi/docs: Add rendering for INTRO sections
>>   qapi: convert intro sections for accelerator.json
>>   qapi: convert intro sections for acpi-hest.json
>>   qapi: convert intro sections for acpi.json
>>   qapi: convert intro sections for audio.json
>>
>>  docs/devel/qapi-code-gen.rst            |  17 +-
>>  docs/sphinx/qapidoc.py                  |  52 +++---
>>  qapi/accelerator.json                   |  24 +--
>>  qapi/acpi-hest.json                     |   5 +-
>>  qapi/acpi.json                          |  23 +--
>>  qapi/audio.json                         | 112 ++++---------
>>  .editorconfig                           |   1 +
>>
>
> Whoops, that snuck in by accident. Ignore! I needed some help doing the
> line wraps in qapi :)

Would it make sense as a separate patch?

>>  scripts/qapi/parser.py                  | 204 ++++++++++++++----------
>>  tests/qapi-schema/doc-good.out          |  30 ++--
>>  tests/qapi-schema/doc-missing-colon.err |   2 +-
>>  tests/qapi-schema/test-qapi.py          |  15 +-
>>  11 files changed, 239 insertions(+), 246 deletions(-)
>>
>> --
>> 2.53.0
>>
>>
>>


