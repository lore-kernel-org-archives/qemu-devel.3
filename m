Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E6BF532C4
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 07:03:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4vn3-0006A6-Fv; Tue, 24 Mar 2026 03:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4vn2-00069w-Tm
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w4vn0-0006H4-HT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 03:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774335776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dKJBYzuW9TeFSe55ECjtOMQEYQ3HUZGVlpya2TxZrMg=;
 b=B8jd6cvinzqWQgjl7xNlD88SahAeegkYr8az1VPBgX8yYpllAJSeJAY2qoXue7DF4dBon6
 LEPcuEF5jSY1RayNAHN7RKgJKkwV+Q/IBSOjpmVJRGB61PKeXOpIqN2wV2hzcGwIswSjdY
 8gCaon0gvQA/1JbgpLP+n8xhk8XG3q0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-SjC3H_rlPM6v18cqWsEtmA-1; Tue,
 24 Mar 2026 03:02:52 -0400
X-MC-Unique: SjC3H_rlPM6v18cqWsEtmA-1
X-Mimecast-MFC-AGG-ID: SjC3H_rlPM6v18cqWsEtmA_1774335771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A63451800281; Tue, 24 Mar 2026 07:02:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 36155180058C; Tue, 24 Mar 2026 07:02:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D0EB121E6937; Tue, 24 Mar 2026 08:02:48 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,  qemu-devel@nongnu.org,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH-for-11.0] qapi: Remove deprecated
 SchemaInfoEnumMember::values field
In-Reply-To: <c935883f-66d1-42fd-bb19-9c0b59c9493e@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 24 Mar 2026 06:00:58
 +0100")
References: <20260323152124.93051-1-philmd@linaro.org>
 <8abf41ec-3f8f-4b3c-8966-f9309a404862@linaro.org>
 <c935883f-66d1-42fd-bb19-9c0b59c9493e@linaro.org>
Date: Tue, 24 Mar 2026 08:02:48 +0100
Message-ID: <87qzp9vhev.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 24/3/26 04:19, Pierrick Bouvier wrote:
>> On 3/23/26 8:21 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> SchemaInfoEnumMember::values field has been deprecated for
>>> more than 5 years (see commit 75ecee72625 "qapi: Enable enum
>>> member introspection to show more than name"), it should be
>>> safe enough to remove.
>>>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>> =C2=A0 docs/about/deprecated.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 6 ------
>>> =C2=A0 docs/about/removed-features.rst |=C2=A0 7 +++++++
>>> =C2=A0 qapi/introspect.json=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 12 +-----------
>>> =C2=A0 scripts/qapi/introspect.py=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 +--
>>> =C2=A0 4 files changed, 9 insertions(+), 19 deletions(-)
>>>
>> By curiosity, is this patch goal is simply to remove a deprecated featur=
e/code, or does it unlock something beyond it?
>> No judgment here, that's a genuine question, and both are valid reasons!
>
> In a previous thread Daniel said past deprecation period, feature
> must be removed, otherwise undeprecated and re-introduced.

I think that's too rigid.

Why do we deprecate features?  Reasons include:

* A feature may have become too much of a burden to support.  We
  deprecate it with the firm intent to remove it at the earliest
  opportunity.  The motivation is to help developers, and deprecation is
  the means to do so without inflicting unnecessary pain on users.

* A certain interface has turned out to be too limited, necessitating a
  more expressive one.  Now we have two ways to do the same thing.  We
  deprecate the limited one to guide users to the new one, because
  that's the one we think they should use for their own good.  The
  motivation is to help users, and deprecation is the means.  Removing
  the old interface later on helps future users a bit more.  It also
  inconveniences any remaining users of the old interface.

Mixed reasons are possible.  For instance, we might start for the second
reason (need a new interface), then find the first reason now applies
(maintaining the old interface in addition is bothersome).

Removing a deprecated feature is always a tradeoff, and time is commonly
a factor.  The deprecation grace period is merely a lower bound we
commit to so we don't surprise users.  docs/about/deprecated.rst:

    The [deprecated] feature will remain functional for the release in
    which it was deprecated and one further release. After these two
    releases, the feature is liable to be removed.

Note "liable".

>                                                            I'm just
> trying to be consistent with the deprecation process, removing what
> doesn't seem worth to re-introduce (for the code I'm able to figure
> out at least).
>
> Maybe we should clarify the deprecation process, clarifying that,
> and mentioning that maintainers sending pull request to commit
> patches with deprecations are also a commitment to remove code
> when the proper released is out.

I believe that wouldn't be a clarification of actual practice, it would
be a change of practice.  We can certainly debate such a change.

Back to the patch.  SchemaInfoEnumMember member @values has been
deprecated for five years.  I figure by now the benefit of simplifying
the interface outweighs the inconvenience of removing the deprecated
part.

I'd like an Acked-by from libvirt developers, though.

[...]


