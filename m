Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A4BC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 06:58:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqo7l-0006iF-Dd; Sat, 08 Mar 2025 01:57:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo7a-0006h7-QO
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqo7Y-0004EZ-TZ
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 01:57:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741417035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dLJPMxmXCfogqY6J68Eah5wIIVShxvWPEMLvb3qaGOM=;
 b=CnT3w7H5lZxTbycXWcyJOu/V2rk6LKIJcXYEcGZymUUMvaMqRAH46jaCg9NiF0HlxMdHf/
 FgXkPL+acdNI/0FEPEEEY7DWzYyTKBLHxCQ8mog7W40xV4JLmE2JdqD0fVVjDeJ/glkcww
 9EVRJ5NLfmbpyAQ5ZBGOS5hLQn/li0M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-g5DjMzSrNMWvuK7rvYmWsw-1; Sat,
 08 Mar 2025 01:57:13 -0500
X-MC-Unique: g5DjMzSrNMWvuK7rvYmWsw-1
X-Mimecast-MFC-AGG-ID: g5DjMzSrNMWvuK7rvYmWsw_1741417032
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 24DD919560BC; Sat,  8 Mar 2025 06:57:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CE88A1801748; Sat,  8 Mar 2025 06:57:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C1CA21E675F; Sat, 08 Mar 2025 07:57:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>
Subject: Re: [PATCH 16/57] docs/qapi-domain: add "Returns:" field lists
In-Reply-To: <CAFn=p-ahdYmxDsPg7NmfwBK-vAHFEQ3jkB_vuAEi2Zj-naFWgQ@mail.gmail.com>
 (John Snow's message of "Fri, 7 Mar 2025 17:58:53 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-17-jsnow@redhat.com>
 <87tt85p90k.fsf@pond.sub.org>
 <CAFn=p-ahdYmxDsPg7NmfwBK-vAHFEQ3jkB_vuAEi2Zj-naFWgQ@mail.gmail.com>
Date: Sat, 08 Mar 2025 07:57:08 +0100
Message-ID: <875xkkdn7f.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

John Snow <jsnow@redhat.com> writes:

> On Fri, Mar 7, 2025 at 2:58=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
>> John Snow <jsnow@redhat.com> writes:
>>
>> > Add "Returns:" field list syntax to QAPI Commands.
>> >
>> > Like "Arguments:" and "Errors:", the type name isn't currently process=
ed
>> > for cross-referencing, but this will be addressed in a forthcoming
>> > commit.
>> >
>> > This patch adds "errors" as a GroupedField, which means that multiple
>>
>> "errors"?
>>
>
> Copy-pasto :)
>
>
>>
>> > return values can be annotated - this is only done because Sphinx does
>> > not seemingly (Maybe I missed it?) support mandatory type arguments to
>> > Ungrouped fields. Because we want to cross-reference this type
>> > information later, we want to make the type argument mandatory. As a
>> > result, you can technically add multiple :return: fields, though I'm n=
ot
>> > aware of any circumstance in which you'd need or want
>> > to. Recommendation: "Don't do that, then."
>>
>> scripts/qapi/parser.py rejects duplicate 'Returns:' tags.  So, to do the
>> thing you shouldn't do, you'd have to use the QAPI domain directly.
>> I doubt such shenanigans would survive review :)
>>
>
> Sure, but it's a little weird to be in the headspace of writing a domain
> extension that was based on one which *can* be used directly. I know we
> won't, but I suppose I am still documenting it and treating it as if you
> could.

Valid argument.

Our test suite only covers use via transmogrifier, not direct use.
Fixable.  I'm not asking you to fix it now.

Commit message could mention the emerging new QAPI doc tool chain obeys
"Don't do that, then".  But I figure you have bigger fish to fry.

> More the case, it serves as reference if anyone wants to adjust the
> behavior of the transmogrifier.
>
> So, consider this documentation for me in the future, or whoever touches
> qapidoc if I am felled by an errant spacerock.
>
>
>>
>> > Since this field describes an action/event instead of describing a list
>> > of nouns (arguments, features, errors), I added both the imperative and
>> > indicative forms (:return: and :returns:) to allow doc writers to use
>> > whichever mood "feels right" in the source document. The rendered outp=
ut
>> > will always use the "Returns:" label, however.
>> >
>> > I'm sure you'll let me know how you feel about that. O:-)
>>
>> My personal taste is imperative mood, always.
>>
>> Sadly, the QAPI schema language uses 'Returns:'.
>>
>> The Sphinx Python Domain appears to use :return:.
>>
>> I recommend to go for consistency with the Python Domain, and ditch
>> :returns:.
>>
>
> Done.

Thanks!  A few instrances of "returns" in later commit messages need
adjustment.

[...]


