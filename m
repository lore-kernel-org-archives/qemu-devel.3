Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7088C4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 05:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXEOh-0007Zk-Bh; Tue, 06 Feb 2024 00:53:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXEOf-0007ZW-Tq
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 00:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXEOX-0008PZ-Mt
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 00:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707198800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CgPm7w61z1OJlRDo/qwfFaF3etRPzRA6lJssE31M0wk=;
 b=eRef+cwBywHkbsY2Ow5BTJIR3fHTanYNH+UGS+DyygKEH3eszp3ADVHVw+wLTOx1oX5V7D
 BJtEH4tKsTsaLNfoHtBgElAOrBaucFmhfq3Ca2qEW1xNdc8mS+VryUxbDfsgc74lv9z5Qy
 q8qIT89q6Edi2uDF6VOKls8Mn/tboq4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-8OqfzgYIOeyWiTG0v1J1cQ-1; Tue,
 06 Feb 2024 00:53:17 -0500
X-MC-Unique: 8OqfzgYIOeyWiTG0v1J1cQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3A0D1C0BA47;
 Tue,  6 Feb 2024 05:53:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6319A492BC6;
 Tue,  6 Feb 2024 05:53:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6EBDB21E6757; Tue,  6 Feb 2024 06:53:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,  qemu-devel@nongnu.org,  Hanna
 Czenczek <hreitz@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Richard Henderson
 <richard.henderson@linaro.org>,  Thomas Huth <thuth@redhat.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] docs/style: allow C99 mixed declarations
In-Reply-To: <ZcEdrp-y5YFsfir4@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 5 Feb 2024 17:41:02 +0000")
References: <20240205171819.474283-1-stefanha@redhat.com>
 <ZcEdrp-y5YFsfir4@redhat.com>
Date: Tue, 06 Feb 2024 06:53:15 +0100
Message-ID: <87r0hqyw8k.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.285,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, Feb 05, 2024 at 12:18:19PM -0500, Stefan Hajnoczi wrote:
>> C99 mixed declarations support interleaving of local variable
>> declarations and code.
>>=20
>> The coding style "generally" forbids C99 mixed declarations with some
>> exceptions to the rule. This rule is not checked by checkpatch.pl and
>> naturally there are violations in the source tree.
>>=20
>> While contemplating adding another exception, I came to the conclusion
>> that the best location for declarations depends on context. Let the
>> programmer declare variables where it is best for legibility. Don't try
>> to define all possible scenarios/exceptions.
>
> IIRC, we had a discussion on this topic sometime last year, but can't
> remember what the $SUBJECT was, so I'll just repeat what I said then.

From: Juan Quintela <quintela@redhat.com>
Subject: [PATCH] Change the default for Mixed declarations.
Date: Tue, 14 Feb 2023 17:07:38 +0100
Message-Id: <20230214160738.88614-1-quintela@redhat.com>
https://lore.kernel.org/qemu-devel/20230214160738.88614-1-quintela@redhat.c=
om/

> Combining C99 mixed declarations with 'goto' is dangerous.
>
> Consider this program:
>
> $ cat jump.c
> #include <stdlib.h>
>
> int main(int argc, char**argv) {
>
>   if (getenv("SKIP"))
>     goto target;
>
>   char *foo =3D malloc(30);
>
>  target:
>   free(foo);
> }
>
> $ gcc -Wall -Wuninitialized -o jump jump.c
>
> $ SKIP=3D1 ./jump=20
> free(): invalid pointer
> Aborted (core dumped)
>
>
>  -> The programmer thinks they have initialized 'foo'
>  -> GCC thinks the programmer has initialized 'foo'
>  -> Yet 'foo' is not guaranteed to be initialized at 'target:'
>
> Given that QEMU makes heavy use of 'goto', allowing C99 mixed
> declarations exposes us to significant danger.
>
> Full disclosure, GCC fails to diagnmose this mistake, even
> with a decl at start of 'main', but at least the mistake is
> now more visible to the programmer.
>
> Fortunately with -fanalyzer GCC can diagnose this:
>
> $ gcc -fanalyzer -Wall -o jump jump.c
> jump.c: In function =E2=80=98main=E2=80=99:
> jump.c:12:3: warning: use of uninitialized value =E2=80=98foo=E2=80=99 [C=
WE-457] [-Wanalyzer-use-of-uninitialized-value]
>    12 |   free(foo);
>       |   ^~~~~~~~~
>   =E2=80=98main=E2=80=99: events 1-5
>     |
>     |    6 |   if (getenv("SKIP"))
>     |      |      ~=20=20
>     |      |      |
>     |      |      (3) following =E2=80=98true=E2=80=99 branch...
>     |    7 |     goto target;
>     |      |     ~~~~
>     |      |     |
>     |      |     (4) ...to here
>     |    8 |=20
>     |    9 |  char *foo =3D malloc(30);
>     |      |        ^~~
>     |      |        |
>     |      |        (1) region created on stack here
>     |      |        (2) capacity: 8 bytes
>     |......
>     |   12 |   free(foo);
>     |      |   ~~~~~~~~~
>     |      |   |
>     |      |   (5) use of uninitialized value =E2=80=98foo=E2=80=99 here
>
>
> ...but -fanalyzer isn't something we have enabled by default, it
> is opt-in. I'm also not sure how comprehensive the flow control
> analysis of -fanalyzer is ?  Can we be sure it'll catch these
> mistakes in large complex functions with many code paths ?
>
> Even if the compiler does reliably warn, I think the code pattern
> remains misleading to contributors, as the flow control flaw is
> very non-obvious.

Yup.  Strong dislike.

> Rather than accept the status quo and remove the coding guideline,
> I think we should strengthen the guidelines, such that it is
> explicitly forbidden in any method that uses 'goto'. Personally
> I'd go all the way to -Werror=3Ddeclaration-after-statement, as

I support this.

> while C99 mixed decl is appealing,

Not to me.

I much prefer declarations and statements to be visually distinct.
Putting declarations first and separating from statements them with a
blank line accomplishes that.  Less necessary in languages where
declarations are syntactically obvious.

>                                    it isn't exactly a game
> changer in improving code maintainability.


[...]


