Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B792CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 17:10:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUScX-0000XU-U5; Tue, 02 Jun 2026 13:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSbs-0000QU-U9
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:09:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wUSbV-0006Ka-0U
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 13:08:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780420114;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bFRu6l3tw5DhwdOltUx6UhUe3gy5CY+EDWbFTOV/MEk=;
 b=K56J1KIj+VRi/cBXGQ3SfIpOW5j9qj/GfzDshYDwSzwTwwbtJhtxWScc1+afzesnpBRpwP
 XMANP01wp+S6vzg7vnPzw/+8TF8iirjJZFHpGH0hZ93aW11PUxdj95oEPyS+pUeqmD5my8
 8001d7QaM4FSGvOPYoveTEuUt3EE4K4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-s1KEaGM3N2e8Wen-eetg9w-1; Tue,
 02 Jun 2026 13:08:30 -0400
X-MC-Unique: s1KEaGM3N2e8Wen-eetg9w-1
X-Mimecast-MFC-AGG-ID: s1KEaGM3N2e8Wen-eetg9w_1780420109
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0F3618002C8; Tue,  2 Jun 2026 17:08:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 52A921800465; Tue,  2 Jun 2026 17:08:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0252521E6A01; Tue, 02 Jun 2026 19:08:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  John Snow
 <jsnow@redhat.com>,  Cleber Rosa <cleber@redhat.com>
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
In-Reply-To: <35c9d179-821a-48e5-8c71-22236053d67c@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Tue, 2 Jun 2026 08:35:21 -0700")
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
 <87y0gy8thg.fsf@pond.sub.org>
 <c7cc0040-872d-425c-827f-c57db87ee12c@oss.qualcomm.com>
 <87wlwh77gv.fsf@pond.sub.org>
 <35c9d179-821a-48e5-8c71-22236053d67c@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 19:08:26 +0200
Message-ID: <874ijkswdx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 6/2/2026 12:00 AM, Markus Armbruster wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> On 6/1/2026 3:06 AM, Markus Armbruster wrote:
>>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>>
>>>>> Hi Markus,
>>>>>
>>>>> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>>>>>> Quite a few F: lines don't match any files.  The quick & dirty check
>>>>>>
>>>>>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>>>>>
>>>>>> finds about fifty.
>>>>>>
>>>>>> Philippe Mathieu-Daud=C3=A9 recently posted a few fixes:
>>>>>>
>>>>>>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker pa=
th
>>>>>>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch se=
ction
>>>>>>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>>>>>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>>>>>   MAINTAINERS: Cover python.docker with Python library section
>>>>>>   MAINTAINERS: Fix s390x storage key/attribute device paths
>>>>>>   MAINTAINERS: Fix tcg/s390x/ path
>>>>>>   MAINTAINERS: Correct scripts/coverity-model.c path
>>>>>>   MAINTAINERS: Fix hexagon-linux-user.mak path

[...]

>>>> I'm afraid this matches files not in git, just like my quick & dirty
>>>> one-liner.  Shouldn't we match against contents of HEAD, say output of
>>>> "git-ls-tree -r --name-only @"?
>>>>
>>>
>>> I don't think it's needed to restrict to git ls-tree. The only risk is
>>> that people have a local file they forgot (or didn't want) to add in
>>> git. It will be caught by CI that won't have such a file, so we're safe.
>>>
>>> What do you think?
>>=20
>> Yes, we're safe, but the earlier we catch mistakes, the better.  Now,
>> the juice isn't always worth the squeeze.  How hard would we have to
>> squeeze here?  We could use fnmatch.filter(names, pat) to test whether
>> @pat matches anything in @names, where @names is from git-ls-tree.
>>
>
> "the earlier we catch mistakes, the better" is a good paradigm, but I
> don't think we should project that to developer machine. The only thing
> we need to keep "green" are our upstream branches.
>
> I like the simplicity of current script, only dealing with file paths,
> instead of having to do string regexp compare with git ls-files output,
> but it's just a matter of personal taste and choosing the easiest
> solution for a given problem.
>
> That said, if filtering through git ls-files is a strong requirement, I
> would be happy to implement it. Only thing that matters is that we have
> something catching mistakes.

It's what I would do, but that does *not* make it a requirement, let
alone a strong one.  I'm not the maintainer here.  You, however, are the
patch's author :)

If you want simple, consider

    $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null

[...]


