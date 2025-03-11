Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF6DC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 08:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trulk-0001dG-Qa; Tue, 11 Mar 2025 04:15:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trulc-0001UN-9w
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:15:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trulZ-0000Vd-PP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 04:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741680906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vPIx/DqWqcZ2Qj7oDca1NuEQQ9hKsfqA3onVwHrIe5A=;
 b=HWkDdL6nnEjHUeEZUg87cCPxTJTRZTkuEKUfat3ElXygNbBYKeHxizbJYlBw42hmWb5nav
 ebcwb9L0kwGUnM2KYB83LsSF1SXBSWppYktdD8H5BbX6nvs56u1APjBvzVS8nyNYOMmHmj
 hsW+vSvhFpPHq5NnCS5CBcVAbenStfU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-9q4-2CSAMfGt5E-91XR9DQ-1; Tue,
 11 Mar 2025 04:14:58 -0400
X-MC-Unique: 9q4-2CSAMfGt5E-91XR9DQ-1
X-Mimecast-MFC-AGG-ID: 9q4-2CSAMfGt5E-91XR9DQ_1741680897
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E267A1955BC1; Tue, 11 Mar 2025 08:14:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 580641800366; Tue, 11 Mar 2025 08:14:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8128121E66C4; Tue, 11 Mar 2025 09:14:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 59/63] qapi/parser: add undocumented stub members to
 all_sections
In-Reply-To: <877c4w82vr.fsf@pond.sub.org> (Markus Armbruster's message of
 "Tue, 11 Mar 2025 08:04:08 +0100")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-60-jsnow@redhat.com>
 <877c4w82vr.fsf@pond.sub.org>
Date: Tue, 11 Mar 2025 09:14:51 +0100
Message-ID: <87y0xc56h0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
>> This helps simplify the new doc generator if it doesn't have to check
>> for undocumented members, it can just blindly operate on a sequence of
>> QAPIDoc.Section instances.
>>
>> NB: If there is no existing 'member' section, these undocumented stub
>> members will be inserted directly after the leading section.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>

This doesn't affect the output.  It's not obvious why.

The old doc generator processes doc.body, .args, .features, .sections.
.sections has all sections not in the other three.  It does not use
.all_sections.

The new doc generator processes doc.all_sections.  It does not use
.body, .args, .features, .sections.

Parser and doc generator cooperate on generating stub documentation for
undocumented members.  The parser makes up an ArgSection with an empty
description, and the doc generator makes up a description.

The old doc generator needs the made-up ArgSections in .args.

The new one needs it in .all_sections.

>> ---
>>  scripts/qapi/parser.py | 17 ++++++++++++++++-
>>  1 file changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
>> index 11c11bb09e5..52bc44facf2 100644
>> --- a/scripts/qapi/parser.py
>> +++ b/scripts/qapi/parser.py
>> @@ -789,8 +789,23 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                if self.symbol not in member.info.pragma.documentation_exceptions:
>>                  raise QAPISemError(member.info,
>>                                     "%s '%s' lacks documentation"
>>                                     % (member.role, member.name))

The code above rejects missing documentation unless permitted by a
pragma.

The code below makes up for missing documentation.

[*]

>> -            self.args[member.name] = QAPIDoc.ArgSection(
>> +            section = QAPIDoc.ArgSection(
>>                  self.info, QAPIDoc.Kind.MEMBER, member.name)
>> +            self.args[member.name] = section

This puts the aforementioned made-up ArgSection into .args.  The patch
doesn't change behavior.

>> +
>> +            # Insert stub documentation section for missing member docs.
>> +            # TODO: drop when undocumented members are outlawed

I'm going to move this comment up to [*].

>> +
>> +            # Determine where to insert stub doc - it should go at the
>> +            # end of the members section(s), if any. Note that index 0
>> +            # is assumed to be an untagged intro section, even if it is
>> +            # empty.
>> +            index = 1
>> +            if len(self.all_sections) > 1:
>> +                while self.all_sections[index].kind == QAPIDoc.Kind.MEMBER:
>> +                    index += 1
>> +            self.all_sections.insert(index, section)

This puts it into .all_sections.

>> +
>>          self.args[member.name].connect(member)
>>  
>>      def connect_feature(self, feature: 'QAPISchemaFeature') -> None:

I'm going to clarify the commit message as follows:

    Parser and doc generator cooperate on generating stub documentation for
    undocumented members.  The parser makes up an ArgSection with an empty
    description, and the doc generator makes up a description.

    Right now, the made-up ArgSections go into doc.args.  However, the new
    doc generator uses .all_sections, not .args.  So put them into
    .all_sections, too.

    Insert them right after existing 'member' sections.  If there are none,
    insert directly after the leading section.

    Doesn't affect the old generator, because that one doesn't use
    .all_sections.

> Reviewed-by: Markus Armbruster <armbru@redhat.com>

With that, my R-by stands.


