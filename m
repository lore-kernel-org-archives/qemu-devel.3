Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288F9E7719E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:54:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXEKn-0005QD-LT; Mon, 13 Jan 2025 01:54:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXEKl-0005PE-G5
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:53:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tXEKj-0005QJ-Dd
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 01:53:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736751236;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WxrwpAjjdjreIkyI2bgo1HNnCZ/82qbcJetGPVeamBI=;
 b=V0TRPbVjM/kb/x8RFs7/LZbltDnSDv8pEXF9Yaqkw6SuN/mV6FxQ2m7QwsgXOT4dHxKTVV
 AkZjWl3BZc0n3smzn41O7F+qVJqV9C6tuX38H/TarZXu+08cWeyDcnfyLW2n5XkRomZDV6
 S+WpDaPDYlO3nr5qsb5xp2Elvf6d0xw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-b0qPUnj1NaqNMP5iBpzQ4w-1; Mon,
 13 Jan 2025 01:53:50 -0500
X-MC-Unique: b0qPUnj1NaqNMP5iBpzQ4w-1
X-Mimecast-MFC-AGG-ID: b0qPUnj1NaqNMP5iBpzQ4w
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF80919560B7; Mon, 13 Jan 2025 06:53:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 946CC19560AD; Mon, 13 Jan 2025 06:53:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 750BE21E6924; Mon, 13 Jan 2025 07:53:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,  qemu-devel@nongnu.org,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Daniel P. =?utf-8?Q?Be?=
 =?utf-8?Q?rrang=C3=A9?=
 <berrange@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Markus Armbruster
 <armbru@redhat.com>
Subject: Re: [PATCH v2] Add a b4 configuration file
In-Reply-To: <b7d08568-153c-4a35-9395-214cd8d0a228@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Sun, 12 Jan 2025 19:01:26
 +0100")
References: <20250102-b4-config-v2-1-cc7299e399bb@flygoat.com>
 <b7d08568-153c-4a35-9395-214cd8d0a228@linaro.org>
Date: Mon, 13 Jan 2025 07:53:45 +0100
Message-ID: <87bjwbtdae.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.025,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 2/1/25 23:53, Jiaxun Yang wrote:
>> b4 [1] is a convenient tool to manage patch series with mailing list
>> working flow.
>> Add a project default config file to match QEMU's mailing list conventio=
ns
>> as well as adopting differences on scripting.
>> Examples of b4:
>> ```
>> $ b4 prep --check
>> Checking patches using:
>>    scripts/checkpatch.pl -q --terse --no-summary --mailback -
>> ---
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>> Changes in v2:
>> - Add lore masks (philmd) from:
>>    https://lore.kernel.org/qemu-devel/20241224135054.10243-1-philmd@lina=
ro.org/
>> - Link to v1: https://lore.kernel.org/r/20241222-b4-config-v1-1-b3667beb=
30a4@flygoat.com
>> ---
>> =E2=97=8F cc5a4c890fed: Add a b4 configuration file
>>    =E2=97=8F checkpatch.pl: 27: WARNING: added, moved or deleted file(s)=
, does MAINTAINERS need updating?
>> ---
>> Success: 0, Warning: 1, Error: 0
>> ```
>> ```
>> $ b4 prep -c
>> Will collect To: addresses using echo
>> Will collect Cc: addresses using get_maintainer.pl
>> Collecting To/Cc addresses
>>      + To: qemu-devel@nongnu.org
>> ---
>> You can trim/expand this list with: b4 prep --edit-cover
>> Invoking git-filter-repo to update the cover letter.
>> New history written in 0.02 seconds...
>> Completely finished after 0.06 seconds
>> ```
>> [1]: https://b4.docs.kernel.org/
>> Co-developed-by: Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@lina=
ro.org>
>> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
>> ---
>>   .b4-config | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>
> Squashing in order to avoid checkpatch.pl error:
>
> -- >8 --
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ec898a3cbc6..0c71eb3f925 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4310,3 +4310,9 @@ Machine development tool
>  M: Maksim Davydov <davydov-max@yandex-team.ru>
>  S: Supported
>  F: scripts/compare-machine-types.py
> +
> +b4 tool configuration

Start the title with a capital letter, please.

> +M: Jiaxun Yang <jiaxun.yang@flygoat.com>
> +M: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> +S: Odd Fixes
> +F: .b4-config

The scope of this entry is less than clear.  What kind of tools?

It's not our own tooling (scripts/...).  Perhaps it's tools used by
enough developers to warrant committing common configuration to Git.  We
have such configuration files already, not covered by MAINTAINERS, e.g.:

    .dir-locals.el
    .editorconfig
    .exrc
    .gdbinit
    .gitpublish
    .pylintrc

The path of least resistance is to add .b4-config the same way.

If we decide we want a new entry in MAINTAINERS, its scope should be
reasonably clear, and we should add existing files, if any, to it.

> ---
>
> and queued, thanks!


