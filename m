Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E8CC71157
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 19:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRcO6-0000Er-Ao; Tue, 17 Jun 2025 15:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRcO4-0000Du-A2
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:54:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uRcO1-0000sj-2x
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 15:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750190063;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4+yv49Gp8LjvUnTJ3f3eZHXRHCpvWv0B1jgNMuP9viU=;
 b=c7tb+2zMCYfL67Q8GUTcigOzvnbg03GrEGCG3JLjOpNESn5/aNGqryR0X1w0gjNKfLzHnT
 9KsC+Sx0qJpRsnTqR/qmp0PNFhUUw5f0TMZAKruOArfduiidjfuSECRPebReXaJ6YRqccX
 dOm8Hl/6WhECWWSpJAEBXygljv/RSuE=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-Q4E4Sm2dOgWnyfvagBCutQ-1; Tue, 17 Jun 2025 15:54:20 -0400
X-MC-Unique: Q4E4Sm2dOgWnyfvagBCutQ-1
X-Mimecast-MFC-AGG-ID: Q4E4Sm2dOgWnyfvagBCutQ_1750190060
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-31220ecc586so5924559a91.2
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 12:54:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750190060; x=1750794860;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4+yv49Gp8LjvUnTJ3f3eZHXRHCpvWv0B1jgNMuP9viU=;
 b=eXYxwz2ThI2itqaYK71awocd1AZaYNbnTHbF05UJ4ekndigElu+37NfYHuoVepGaKC
 Yd6e/j0RB1BDlmubovvCs3qPUxDqL7WOFV0tYyPzDkye2TX551YR9oC0GjGSYcPXRkP5
 IoVB17stvrhwjt1vUJeHcDAzttqS2TJIDxC2xwhKeSqMicPry8+QSHn7vSeaJFQeLI7Q
 +vAiZ33BFCyrWHThMArISC/wuTWRhNnaO5kVgID6xhusp17FTJnwb+E6Um5f8uJFDyo6
 3zFMPqxzm8Eh6L3NZ11AvT2c335YkozTBqTlhEyqFemiCLMnF5/QqhjowS/niuhiAuIv
 wsww==
X-Gm-Message-State: AOJu0Yz0ayBZLaACpXJ8SPfHn3axICmRFxteOoMIww7bwanEdKmf/5VX
 cZmYq4Ky+0KWqHnEIjjSFC2jRf6XjKCNI5A/uz6Je/KOBU1fKqHj0QiP2pHDIWGFUZCGxvtGfyK
 PXE/V2YiDCo+i7xMnzekiFtf8ethOpGdOTxpFN8hEl7PbLrFlGVX2P3aKAoLe6TDqXHTg/W1Fx4
 AhDh2dhJdDOj/yrAhkBwspr6D59LBbSh4=
X-Gm-Gg: ASbGncvoTD9jyk/XWJeLHOT3aj2bk5YmGJEjCLm40NAZxOpiMtYaNpxUjkroTA6msXR
 o6+aSqmaY5gRwNYe0IDNWSjVZ1UX3B91Kb7voxEojB+T/Pu9BGAkmgMKEJrqbXdkYyDscNW4EOH
 vO8U7xWh5rxcdVgcGa45v9dCtEcXUE0Z58U8w=
X-Received: by 2002:a17:90a:e7c3:b0:313:27cc:69cd with SMTP id
 98e67ed59e1d1-313f1c015e8mr25533389a91.12.1750190059372; 
 Tue, 17 Jun 2025 12:54:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtHB+4tKZr1cqhD+HBI2aWcjNyUdEKA4b4RFn4fKc8y9IBYyiBeMaZqwAe2uNzPYpRV5zIJdXVsSTev1TOko4=
X-Received: by 2002:a17:90a:e7c3:b0:313:27cc:69cd with SMTP id
 98e67ed59e1d1-313f1c015e8mr25533333a91.12.1750190058851; Tue, 17 Jun 2025
 12:54:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250612221051.1224565-1-jsnow@redhat.com>
 <20250612221051.1224565-3-jsnow@redhat.com>
 <87ldprho83.fsf@pond.sub.org>
In-Reply-To: <87ldprho83.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 17 Jun 2025 15:54:07 -0400
X-Gm-Features: AX0GCFvatfhhPej0Ee6ZFdaFYDr0pZgi1N0tPoO2JW_PCMB0XVKmkN6s3N-i4CY
Message-ID: <CAFn=p-bwa7ETp9znOQ_zMD5icJz2e7=Lj+uLWNctADwLrtqnhA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] docs: remove legacy QAPI manual generator
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Zhenwei Pi <pizhenwei@bytedance.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Jiri Pirko <jiri@resnulli.us>, 
 Ani Sinha <anisinha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, 
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Hanna Reitz <hreitz@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Eric Blake <eblake@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 Lukas Straub <lukasstraub2@web.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fan Ni <fan.ni@samsung.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Konstantin Kostiuk <kkostiuk@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000bf76120637c9e070"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=unavailable autolearn_force=no
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

--000000000000bf76120637c9e070
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 8:20=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Thanks for your service!
> >
> > Remove the old qapidoc and the option to enable the transmogrifier,
> > leaving the "transmogrifier" as the ONLY qapi doc generator. This in
> > effect also converts the QAPI test to use the new documentation
> > generator, too.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
> Fails "make check", because tests/qapi-schema/doc-good.txt needs an
> update.
>
> Unfortunately, the diff of the update is less than useful.  To make
> sense of what changes, I split doc-good.txt into parts before and after,
> and diffed those.
>
>
>   diff -rupw o/01 n/01
>   --- o/01      2025-06-16 13:53:05.036940854 +0200
>   +++ n/01      2025-06-16 13:49:07.167435996 +0200
>   @@ -1,11 +1,13 @@
>    Section
>    *******
>
>   +Just text, no heading.
>   +
>
> Looks like a bug fix.  Needs a mention in the commit message then.
>

I think before, these sections just got ... discarded? but with no special
formatting, they just get copied through. You could call it a bugfix, you
could call it an unintentional side effect.

For my money, I think it's fine to allow free-form docs to have any
arbitrary content. If it produces bad results, don't do it, then. Fewer
constraints =3D less code.


>
>    Subsection
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   -*with emphasis* "var" {in braces}
>   +*with emphasis* @var {in braces}
>
> Rendering of @references changes.  Okay.
>

Unintentional. Freeform sections are handled outside of "visit_sections",
because they are not attached to an entity, and so the @references
rendering is missed. Bug, I'll fix it.


>
>    * List item one
>
>   @@ -35,4 +37,3 @@ Example:
>
>    -> in <- out Examples: - *verbatim* - {braces}
>
>   -
>   diff -rupw o/02 n/02
>   --- o/02      2025-06-16 13:53:17.133712123 +0200
>   +++ n/02      2025-06-16 13:49:21.024174424 +0200
>   @@ -1,32 +1,15 @@
>   -"Enum" (Enum)
>   --------------
>   +Enum Enum
>   +    *Availability*: "IFCOND"
>
>   +   Values:
>   +      * **one** -- The _one_ {and only}, description on the same line
>
>   -Values
>   -~~~~~~
>   +      * **two** -- Not documented
>
>   -"one" (**If: **"IFONE")
>
> Member conditional is lost.  Known issue; see commit dbf51d15fdb.
>
>   -   The _one_ {and only}, description on the same line
>   +   Features:
>   +      * **enum-feat** -- Also _one_ {and only}
>
>   -"two"
>   -   Not documented
>   -
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"enum-feat"
>   -   Also _one_ {and only}
>   -
>   -"enum-member-feat"
>   -   a member feature
>   +      * **enum-member-feat** -- a member feature
>
>    "two" is undocumented
>
>   -
>   -If
>   -~~
>   -
>   -"IFCOND"
>   -
>   -
>   diff -rupw o/03 n/03
>   --- o/03      2025-06-16 13:53:27.556514971 +0200
>   +++ n/03      2025-06-16 13:50:44.582595942 +0200
>   @@ -1,17 +1,7 @@
>   -"Base" (Object)
>   ----------------
>   -
>   -
>   -Members
>   -~~~~~~~
>   -
>   -"base1": "Enum"
>   -   description starts on a new line, minimally indented
>   -
>   -
>   -If
>   -~~
>   -
>   -"IFALL1 and IFALL2"
>   +Object Base
>   +    *Availability*: "IFALL1 and IFALL2"
>
>   +   Members:
>   +      * **base1** ("Enum") -- description starts on a new line,
>   +        minimally indented
>
>   diff -rupw o/04 n/04
>   --- o/04      2025-06-16 13:53:39.356291772 +0200
>   +++ n/04      2025-06-16 13:50:54.486408751 +0200
>   @@ -1,5 +1,4 @@
>   -"Variant1" (Object)
>   --------------------
>   +Object Variant1
>
>    A paragraph
>
>   @@ -7,21 +6,11 @@ Another paragraph
>
>    "var1" is undocumented
>
>   +   Members:
>   +      * **var1** ("string") -- Not documented
>
>   -Members
>   -~~~~~~~
>   -
>   -"var1": "string" (**If: **"IFSTR")
>
> Likewise.
>
>   -   Not documented
>   -
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"variant1-feat"
>   -   a feature
>   -
>   -"member-feat"
>   -   a member feature
>   +   Features:
>   +      * **variant1-feat** -- a feature
>
>   +      * **member-feat** -- a member feature
>
>   diff -rupw o/05 n/05
>   --- o/05      2025-06-16 13:53:43.429214731 +0200
>   +++ n/05      2025-06-16 13:51:05.247205330 +0200
>   @@ -1,4 +1,2 @@
>   -"Variant2" (Object)
>   --------------------
>   -
>   +Object Variant2
>
>   diff -rupw o/06 n/06
>   --- o/06      2025-06-16 13:53:48.461119551 +0200
>   +++ n/06      2025-06-16 13:51:10.990096739 +0200
>   @@ -1,19 +1,12 @@
>   -"Object" (Object)
>   ------------------
>   +Object Object
>
>   +   Members:
>   +      * The members of "Base".
>
>   -Members
>   -~~~~~~~
>   +      * When "base1" is "one": The members of "Variant1".
>
>   -The members of "Base"
>   -The members of "Variant1" when "base1" is ""one""
>   -The members of "Variant2" when "base1" is ""two"" (**If: **"IFONE or
>   -IFTWO")
>
> Likewise.
>
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"union-feat1"
>   -   a feature
>   +      * When "base1" is "two": The members of "Variant2".
>
>   +   Features:
>   +      * **union-feat1** -- a feature
>
>   diff -rupw o/07 n/07
>   --- o/07      2025-06-16 13:53:55.988977158 +0200
>   +++ n/07      2025-06-16 13:51:16.869985559 +0200
>   @@ -1,28 +1,13 @@
>   -"Alternate" (Alternate)
>   ------------------------
>   +Alternate Alternate
>   +    *Availability*: "not (IFONE or IFTWO)"
>
>   +   Alternatives:
>   +      * **i** ("int") -- description starts on the same line remainder
>   +        indented the same "b" is undocumented
>
>   -Members
>   -~~~~~~~
>   +      * **b** ("boolean") -- Not documented
>
>   -"i": "int"
>   -   description starts on the same line remainder indented the same "b"
>   -   is undocumented
>   -
>   -"b": "boolean"
>   -   Not documented
>   -
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"alt-feat"
>   -   a feature
>   -
>   -
>   -If
>   -~~
>   -
>   -"not (IFONE or IFTWO)"
>   +   Features:
>   +      * **alt-feat** -- a feature
>
>
>   diff -rupw o/08 n/08
>   --- o/08      2025-06-16 13:54:11.692680115 +0200
>   +++ n/08      2025-06-16 13:51:35.957624638 +0200
>   @@ -1,47 +1,29 @@
>    Another subsection
>    =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>   +Command cmd (Since: 2.10)
>
>   -"cmd" (Command)
>   ----------------
>   +   Arguments:
>   +      * **arg1** ("int") -- description starts on a new line, indented
>
>   +      * **arg2** ("string", *optional*) -- description starts on the
>   +        same line remainder indented differently
>
>   -Arguments
>   -~~~~~~~~~
>   +      * **arg3** ("boolean") -- Not documented
>
>   -"arg1": "int"
>   -   description starts on a new line, indented
>   +   Features:
>   +      * **cmd-feat1** -- a feature
>
>   -"arg2": "string" (optional)
>   -   description starts on the same line remainder indented differently
>   -
>   -"arg3": "boolean"
>   -   Not documented
>   -
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"cmd-feat1"
>   -   a feature
>   -
>   -"cmd-feat2"
>   -   another feature
>   +      * **cmd-feat2** -- another feature
>
>    Note:
>
>      "arg3" is undocumented
>
>   +   Return:
>   +      "Object" -- "Object"
>
>   -Returns
>   -~~~~~~~
>   -
>   -"Object"
>   -
>   -
>   -Errors
>   -~~~~~~
>   -
>   +   Errors:
>    * some
>
>    Notes:
>   @@ -68,10 +50,3 @@ Examples:
>    Note::
>       Ceci n'est pas une note
>
>   -
>   -Since
>   -~~~~~
>   -
>   -2.10
>   -
>   -
>   diff -rupw o/09 n/09
>   --- o/09      2025-06-16 14:11:32.819939859 +0200
>   +++ n/09      2025-06-16 13:51:43.469482599 +0200
>   @@ -1,22 +1,14 @@
>   -"cmd-boxed" (Command)
>   ----------------------
>   +Command cmd-boxed
>
>    If you're bored enough to read this, go see a video of boxed cats
>
>   +   Arguments:
>   +      * The members of "Object".
>
>   -Arguments
>   -~~~~~~~~~
>   +   Features:
>   +      * **cmd-feat1** -- a feature
>
>   -The members of "Object"
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"cmd-feat1"
>   -   a feature
>   -
>   -"cmd-feat2"
>   -   another feature
>   +      * **cmd-feat2** -- another feature
>
>    Example::
>
>   @@ -24,4 +16,3 @@ Example::
>
>       <- ... has no title ...
>
>   -
>   diff -rupw o/10 n/10
>   --- o/10      2025-06-16 14:11:35.771883514 +0200
>   +++ n/10      2025-06-16 13:51:46.653422395 +0200
>   @@ -1,14 +1,7 @@
>   -"EVT_BOXED" (Event)
>   --------------------
>   +Event EVT_BOXED
>
>   +   Members:
>   +      * The members of "Object".
>
>   -Arguments
>   -~~~~~~~~~
>   -
>   -The members of "Object"
>   -
>   -Features
>   -~~~~~~~~
>   -
>   -"feat3"
>   -   a feature
>   +   Features:
>   +      * **feat3** -- a feature
>
> The only unexpected change is the first hunk.


Some of these look a little silly, let me see what I can do ... The IFCOND
stuff is a known issue, and I believe is best tackled in conjunction with
your project to add conditional documentation entities.

Everything else, I'll review and see what can be improved upon if anything.

--000000000000bf76120637c9e070
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Jun 16,=
 2025 at 8:20=E2=80=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@red=
hat.com">armbru@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">John Snow &lt;<a href=3D"mailto:jsnow@redhat.com"=
 target=3D"_blank">jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Thanks for your service!<br>
&gt;<br>
&gt; Remove the old qapidoc and the option to enable the transmogrifier,<br=
>
&gt; leaving the &quot;transmogrifier&quot; as the ONLY qapi doc generator.=
 This in<br>
&gt; effect also converts the QAPI test to use the new documentation<br>
&gt; generator, too.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank">jsnow@redhat.com</a>&gt;<br>
<br>
Fails &quot;make check&quot;, because tests/qapi-schema/doc-good.txt needs =
an<br>
update.<br>
<br>
Unfortunately, the diff of the update is less than useful.=C2=A0 To make<br=
>
sense of what changes, I split doc-good.txt into parts before and after,<br=
>
and diffed those.<br>
<br>
<br>
=C2=A0 diff -rupw o/01 n/01<br>
=C2=A0 --- o/01=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:05.036940854 +0200<br>
=C2=A0 +++ n/01=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:49:07.167435996 +0200<br>
=C2=A0 @@ -1,11 +1,13 @@<br>
=C2=A0 =C2=A0Section<br>
=C2=A0 =C2=A0*******<br>
<br>
=C2=A0 +Just text, no heading.<br>
=C2=A0 +<br>
<br>
Looks like a bug fix.=C2=A0 Needs a mention in the commit message then.<br>=
</blockquote><div><br></div><div>I think before, these sections just got ..=
. discarded? but with no special formatting, they just get copied through. =
You could call it a bugfix, you could call it an unintentional side effect.=
</div><div><br></div><div>For my money, I think it&#39;s fine to allow free=
-form docs to have any arbitrary content. If it produces bad results, don&#=
39;t do it, then. Fewer constraints =3D less code.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0Subsection<br>
=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 -*with emphasis* &quot;var&quot; {in braces}<br>
=C2=A0 +*with emphasis* @var {in braces}<br>
<br>
Rendering of @references changes.=C2=A0 Okay.<br></blockquote><div><br></di=
v><div>Unintentional. Freeform sections are handled outside of &quot;visit_=
sections&quot;, because they are not attached to an entity, and so the @ref=
erences rendering is missed. Bug, I&#39;ll fix it.</div><div>=C2=A0</div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
<br>
=C2=A0 =C2=A0* List item one<br>
<br>
=C2=A0 @@ -35,4 +37,3 @@ Example:<br>
<br>
=C2=A0 =C2=A0-&gt; in &lt;- out Examples: - *verbatim* - {braces}<br>
<br>
=C2=A0 -<br>
=C2=A0 diff -rupw o/02 n/02<br>
=C2=A0 --- o/02=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:17.133712123 +0200<br>
=C2=A0 +++ n/02=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:49:21.024174424 +0200<br>
=C2=A0 @@ -1,32 +1,15 @@<br>
=C2=A0 -&quot;Enum&quot; (Enum)<br>
=C2=A0 --------------<br>
=C2=A0 +Enum Enum<br>
=C2=A0 +=C2=A0 =C2=A0 *Availability*: &quot;IFCOND&quot;<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Values:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **one** -- The _one_ {and only}, description=
 on the same line<br>
<br>
=C2=A0 -Values<br>
=C2=A0 -~~~~~~<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **two** -- Not documented<br>
<br>
=C2=A0 -&quot;one&quot; (**If: **&quot;IFONE&quot;)<br>
<br>
Member conditional is lost.=C2=A0 Known issue; see commit dbf51d15fdb.<br>
<br>
=C2=A0 -=C2=A0 =C2=A0The _one_ {and only}, description on the same line<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **enum-feat** -- Also _one_ {and only}<br>
<br>
=C2=A0 -&quot;two&quot;<br>
=C2=A0 -=C2=A0 =C2=A0Not documented<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;enum-feat&quot;<br>
=C2=A0 -=C2=A0 =C2=A0Also _one_ {and only}<br>
=C2=A0 -<br>
=C2=A0 -&quot;enum-member-feat&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a member feature<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **enum-member-feat** -- a member feature<br>
<br>
=C2=A0 =C2=A0&quot;two&quot; is undocumented<br>
<br>
=C2=A0 -<br>
=C2=A0 -If<br>
=C2=A0 -~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;IFCOND&quot;<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 diff -rupw o/03 n/03<br>
=C2=A0 --- o/03=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:27.556514971 +0200<br>
=C2=A0 +++ n/03=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:50:44.582595942 +0200<br>
=C2=A0 @@ -1,17 +1,7 @@<br>
=C2=A0 -&quot;Base&quot; (Object)<br>
=C2=A0 ----------------<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Members<br>
=C2=A0 -~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;base1&quot;: &quot;Enum&quot;<br>
=C2=A0 -=C2=A0 =C2=A0description starts on a new line, minimally indented<b=
r>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -If<br>
=C2=A0 -~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;IFALL1 and IFALL2&quot;<br>
=C2=A0 +Object Base<br>
=C2=A0 +=C2=A0 =C2=A0 *Availability*: &quot;IFALL1 and IFALL2&quot;<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Members:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **base1** (&quot;Enum&quot;) -- description =
starts on a new line,<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 minimally indented<br>
<br>
=C2=A0 diff -rupw o/04 n/04<br>
=C2=A0 --- o/04=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:39.356291772 +0200<br>
=C2=A0 +++ n/04=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:50:54.486408751 +0200<br>
=C2=A0 @@ -1,5 +1,4 @@<br>
=C2=A0 -&quot;Variant1&quot; (Object)<br>
=C2=A0 --------------------<br>
=C2=A0 +Object Variant1<br>
<br>
=C2=A0 =C2=A0A paragraph<br>
<br>
=C2=A0 @@ -7,21 +6,11 @@ Another paragraph<br>
<br>
=C2=A0 =C2=A0&quot;var1&quot; is undocumented<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Members:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **var1** (&quot;string&quot;) -- Not documen=
ted<br>
<br>
=C2=A0 -Members<br>
=C2=A0 -~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;var1&quot;: &quot;string&quot; (**If: **&quot;IFSTR&quot;)<br=
>
<br>
Likewise.<br>
<br>
=C2=A0 -=C2=A0 =C2=A0Not documented<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;variant1-feat&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 -<br>
=C2=A0 -&quot;member-feat&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a member feature<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **variant1-feat** -- a feature<br>
<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **member-feat** -- a member feature<br>
<br>
=C2=A0 diff -rupw o/05 n/05<br>
=C2=A0 --- o/05=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:43.429214731 +0200<br>
=C2=A0 +++ n/05=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:05.247205330 +0200<br>
=C2=A0 @@ -1,4 +1,2 @@<br>
=C2=A0 -&quot;Variant2&quot; (Object)<br>
=C2=A0 --------------------<br>
=C2=A0 -<br>
=C2=A0 +Object Variant2<br>
<br>
=C2=A0 diff -rupw o/06 n/06<br>
=C2=A0 --- o/06=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:48.461119551 +0200<br>
=C2=A0 +++ n/06=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:10.990096739 +0200<br>
=C2=A0 @@ -1,19 +1,12 @@<br>
=C2=A0 -&quot;Object&quot; (Object)<br>
=C2=A0 ------------------<br>
=C2=A0 +Object Object<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Members:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * The members of &quot;Base&quot;.<br>
<br>
=C2=A0 -Members<br>
=C2=A0 -~~~~~~~<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * When &quot;base1&quot; is &quot;one&quot;: T=
he members of &quot;Variant1&quot;.<br>
<br>
=C2=A0 -The members of &quot;Base&quot;<br>
=C2=A0 -The members of &quot;Variant1&quot; when &quot;base1&quot; is &quot=
;&quot;one&quot;&quot;<br>
=C2=A0 -The members of &quot;Variant2&quot; when &quot;base1&quot; is &quot=
;&quot;two&quot;&quot; (**If: **&quot;IFONE or<br>
=C2=A0 -IFTWO&quot;)<br>
<br>
Likewise.<br>
<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;union-feat1&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * When &quot;base1&quot; is &quot;two&quot;: T=
he members of &quot;Variant2&quot;.<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **union-feat1** -- a feature<br>
<br>
=C2=A0 diff -rupw o/07 n/07<br>
=C2=A0 --- o/07=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:53:55.988977158 +0200<br>
=C2=A0 +++ n/07=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:16.869985559 +0200<br>
=C2=A0 @@ -1,28 +1,13 @@<br>
=C2=A0 -&quot;Alternate&quot; (Alternate)<br>
=C2=A0 ------------------------<br>
=C2=A0 +Alternate Alternate<br>
=C2=A0 +=C2=A0 =C2=A0 *Availability*: &quot;not (IFONE or IFTWO)&quot;<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Alternatives:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **i** (&quot;int&quot;) -- description start=
s on the same line remainder<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 indented the same &quot;b&quot; is undo=
cumented<br>
<br>
=C2=A0 -Members<br>
=C2=A0 -~~~~~~~<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **b** (&quot;boolean&quot;) -- Not documente=
d<br>
<br>
=C2=A0 -&quot;i&quot;: &quot;int&quot;<br>
=C2=A0 -=C2=A0 =C2=A0description starts on the same line remainder indented=
 the same &quot;b&quot;<br>
=C2=A0 -=C2=A0 =C2=A0is undocumented<br>
=C2=A0 -<br>
=C2=A0 -&quot;b&quot;: &quot;boolean&quot;<br>
=C2=A0 -=C2=A0 =C2=A0Not documented<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;alt-feat&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -If<br>
=C2=A0 -~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;not (IFONE or IFTWO)&quot;<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **alt-feat** -- a feature<br>
<br>
<br>
=C2=A0 diff -rupw o/08 n/08<br>
=C2=A0 --- o/08=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:54:11.692680115 +0200<br>
=C2=A0 +++ n/08=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:35.957624638 +0200<br>
=C2=A0 @@ -1,47 +1,29 @@<br>
=C2=A0 =C2=A0Another subsection<br>
=C2=A0 =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>
<br>
=C2=A0 +Command cmd (Since: 2.10)<br>
<br>
=C2=A0 -&quot;cmd&quot; (Command)<br>
=C2=A0 ----------------<br>
=C2=A0 +=C2=A0 =C2=A0Arguments:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **arg1** (&quot;int&quot;) -- description st=
arts on a new line, indented<br>
<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **arg2** (&quot;string&quot;, *optional*) --=
 description starts on the<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 =C2=A0 same line remainder indented differentl=
y<br>
<br>
=C2=A0 -Arguments<br>
=C2=A0 -~~~~~~~~~<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **arg3** (&quot;boolean&quot;) -- Not docume=
nted<br>
<br>
=C2=A0 -&quot;arg1&quot;: &quot;int&quot;<br>
=C2=A0 -=C2=A0 =C2=A0description starts on a new line, indented<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **cmd-feat1** -- a feature<br>
<br>
=C2=A0 -&quot;arg2&quot;: &quot;string&quot; (optional)<br>
=C2=A0 -=C2=A0 =C2=A0description starts on the same line remainder indented=
 differently<br>
=C2=A0 -<br>
=C2=A0 -&quot;arg3&quot;: &quot;boolean&quot;<br>
=C2=A0 -=C2=A0 =C2=A0Not documented<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;cmd-feat1&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 -<br>
=C2=A0 -&quot;cmd-feat2&quot;<br>
=C2=A0 -=C2=A0 =C2=A0another feature<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **cmd-feat2** -- another feature<br>
<br>
=C2=A0 =C2=A0Note:<br>
<br>
=C2=A0 =C2=A0 =C2=A0&quot;arg3&quot; is undocumented<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Return:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 &quot;Object&quot; -- &quot;Object&quot;<br>
<br>
=C2=A0 -Returns<br>
=C2=A0 -~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;Object&quot;<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 -Errors<br>
=C2=A0 -~~~~~~<br>
=C2=A0 -<br>
=C2=A0 +=C2=A0 =C2=A0Errors:<br>
=C2=A0 =C2=A0* some<br>
<br>
=C2=A0 =C2=A0Notes:<br>
=C2=A0 @@ -68,10 +50,3 @@ Examples:<br>
=C2=A0 =C2=A0Note::<br>
=C2=A0 =C2=A0 =C2=A0 Ceci n&#39;est pas une note<br>
<br>
=C2=A0 -<br>
=C2=A0 -Since<br>
=C2=A0 -~~~~~<br>
=C2=A0 -<br>
=C2=A0 -2.10<br>
=C2=A0 -<br>
=C2=A0 -<br>
=C2=A0 diff -rupw o/09 n/09<br>
=C2=A0 --- o/09=C2=A0 =C2=A0 =C2=A0 2025-06-16 14:11:32.819939859 +0200<br>
=C2=A0 +++ n/09=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:43.469482599 +0200<br>
=C2=A0 @@ -1,22 +1,14 @@<br>
=C2=A0 -&quot;cmd-boxed&quot; (Command)<br>
=C2=A0 ----------------------<br>
=C2=A0 +Command cmd-boxed<br>
<br>
=C2=A0 =C2=A0If you&#39;re bored enough to read this, go see a video of box=
ed cats<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Arguments:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * The members of &quot;Object&quot;.<br>
<br>
=C2=A0 -Arguments<br>
=C2=A0 -~~~~~~~~~<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **cmd-feat1** -- a feature<br>
<br>
=C2=A0 -The members of &quot;Object&quot;<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;cmd-feat1&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 -<br>
=C2=A0 -&quot;cmd-feat2&quot;<br>
=C2=A0 -=C2=A0 =C2=A0another feature<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **cmd-feat2** -- another feature<br>
<br>
=C2=A0 =C2=A0Example::<br>
<br>
=C2=A0 @@ -24,4 +16,3 @@ Example::<br>
<br>
=C2=A0 =C2=A0 =C2=A0 &lt;- ... has no title ...<br>
<br>
=C2=A0 -<br>
=C2=A0 diff -rupw o/10 n/10<br>
=C2=A0 --- o/10=C2=A0 =C2=A0 =C2=A0 2025-06-16 14:11:35.771883514 +0200<br>
=C2=A0 +++ n/10=C2=A0 =C2=A0 =C2=A0 2025-06-16 13:51:46.653422395 +0200<br>
=C2=A0 @@ -1,14 +1,7 @@<br>
=C2=A0 -&quot;EVT_BOXED&quot; (Event)<br>
=C2=A0 --------------------<br>
=C2=A0 +Event EVT_BOXED<br>
<br>
=C2=A0 +=C2=A0 =C2=A0Members:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * The members of &quot;Object&quot;.<br>
<br>
=C2=A0 -Arguments<br>
=C2=A0 -~~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -The members of &quot;Object&quot;<br>
=C2=A0 -<br>
=C2=A0 -Features<br>
=C2=A0 -~~~~~~~~<br>
=C2=A0 -<br>
=C2=A0 -&quot;feat3&quot;<br>
=C2=A0 -=C2=A0 =C2=A0a feature<br>
=C2=A0 +=C2=A0 =C2=A0Features:<br>
=C2=A0 +=C2=A0 =C2=A0 =C2=A0 * **feat3** -- a feature<br>
<br>
The only unexpected change is the first hunk.</blockquote><div><br></div><d=
iv>Some of these look a little silly, let me see what I can do ... The IFCO=
ND stuff is a known issue, and I believe is best tackled in conjunction wit=
h your project to add conditional documentation entities.</div><div><br></d=
iv><div>Everything else, I&#39;ll review and see what can be improved upon =
if anything. <br></div></div></div>

--000000000000bf76120637c9e070--


