Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E183C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 11:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trbFu-0004nT-0V; Mon, 10 Mar 2025 07:25:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trbFp-0004lG-EQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:25:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trbFn-0002sy-BV
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 07:25:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741605901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ThiCyph5MWKRU2ZCMgmDAtl6vAQaDHbHS1XjrNN4Mg=;
 b=bJhpt/SQhOQJupp3iO8klrxHu3j4iAzTLI4FQJh30bZsD61ojkewmVs353dXM8HeVxbVRs
 /PLXZdg26FI3jA0iPvc9OOLy+1KrmeAtkSbQMv0M+ET1Wov3nWNlhwJWx8GwjliY7OXj3i
 3QOgYQRdby9Vfy5ZUSnvX6KIfIGLdUk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-9iwnEJrYOCKKqub4DgldpA-1; Mon,
 10 Mar 2025 07:25:00 -0400
X-MC-Unique: 9iwnEJrYOCKKqub4DgldpA-1
X-Mimecast-MFC-AGG-ID: 9iwnEJrYOCKKqub4DgldpA_1741605899
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AC4919560BB; Mon, 10 Mar 2025 11:24:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D37661956096; Mon, 10 Mar 2025 11:24:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B3B621E66C1; Mon, 10 Mar 2025 12:24:56 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 43/62] docs/qapidoc: add preamble() method
In-Reply-To: <8734flgqun.fsf@pond.sub.org> (Markus Armbruster's message of
 "Mon, 10 Mar 2025 10:46:56 +0100")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-44-jsnow@redhat.com>
 <8734flgqun.fsf@pond.sub.org>
Date: Mon, 10 Mar 2025 12:24:56 +0100
Message-ID: <87jz8xxh4n.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Markus Armbruster <armbru@redhat.com> writes:

> John Snow <jsnow@redhat.com> writes:
>
>> This method adds the options/preamble to each definition block. Notably,
>> :since: and :ifcond: are added, as are any "special features" such as
>> :deprecated: and :unstable:.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 38 insertions(+), 3 deletions(-)
>>
>> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
>> index cf5dbb0133d..d8bf0073dfa 100644
>> --- a/docs/sphinx/qapidoc.py
>> +++ b/docs/sphinx/qapidoc.py
>> @@ -37,7 +37,12 @@
>>  from docutils.parsers.rst import Directive, directives
>>  from docutils.statemachine import StringList
>>  from qapi.error import QAPIError
>> -from qapi.schema import QAPISchema, QAPISchemaVisitor
>> +from qapi.parser import QAPIDoc
>> +from qapi.schema import (
>> +    QAPISchema,
>> +    QAPISchemaDefinition,
>> +    QAPISchemaVisitor,
>> +)
>>  from qapi.source import QAPISourceInfo
>>  
>>  from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
>> @@ -56,8 +61,6 @@
>>          Sequence,
>>      )
>>  
>> -    from qapi.parser import QAPIDoc
>> -
>>      from sphinx.application import Sphinx
>>      from sphinx.util.typing import ExtensionMetadata
>>  
>> @@ -125,6 +128,38 @@ def ensure_blank_line(self) -> None:
>>              # +2: correct for zero/one index, then increment by one.
>>              self.add_line_raw("", fname, line + 2)
>>  
>> +    # Transmogrification helpers
>> +
>> +    def preamble(self, ent: QAPISchemaDefinition) -> None:
>> +        """
>> +        Generate option lines for qapi entity directives.
>
> QAPI index unless there's a reason for lower case.

Pasto; I mean QAPI entity, of course.

>> +        """
>
> [...]


