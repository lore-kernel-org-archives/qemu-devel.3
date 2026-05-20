Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0819DCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlNV-0004Jb-0J; Wed, 20 May 2026 14:10:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPlNT-0004JP-TR
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:10:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPlNS-0005oF-0k
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779300640;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TIP4KTGiSFOLoH3uSJ8jM8jPF2ywzg1cc9+/8ElCMcE=;
 b=PdbC1kX+zuIILXeSooZgod/73/wGb8opf56eHhMaOevBdxsINB+uQYsjmc7yzH0rU9kA9g
 EvydqIJKUbtdo3nYOZKVnHdr3cpcfDqAVXecSTmFNrYaOEnRAtyysURBIQF3NHkTb3wc0v
 waZRY2AqzXEqvpoSW/8xOTCqxPBAgKM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-EILuW4ztOGaxqOvDG06yuA-1; Wed,
 20 May 2026 14:10:34 -0400
X-MC-Unique: EILuW4ztOGaxqOvDG06yuA-1
X-Mimecast-MFC-AGG-ID: EILuW4ztOGaxqOvDG06yuA_1779300632
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4ECB118005B8; Wed, 20 May 2026 18:10:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E3D261800357; Wed, 20 May 2026 18:10:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9622221E6A01; Wed, 20 May 2026 20:10:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
In-Reply-To: <114b06cc-c6a0-4d09-89ae-f23b45965f19@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 20 May 2026 12:28:44 -0500")
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <114b06cc-c6a0-4d09-89ae-f23b45965f19@oss.qualcomm.com>
Date: Wed, 20 May 2026 20:10:29 +0200
Message-ID: <87pl2qgdey.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

> On 5/20/2026 7:52 AM, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and reo=
rganise")
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> ---
>>>  MAINTAINERS | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index b75f3222f2f..2a4d124fb3c 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>>  F: linux-user/hexagon/
>>>  F: tests/tcg/hexagon/
>>>  F: disas/hexagon.c
>>> -F: configs/targets/hexagon-linux-user/default.mak
>>> +F: configs/targets/hexagon-linux-user.mak
>>>  F: docker/dockerfiles/debian-hexagon-cross.docker
>>=20
>> This one's wrong, too.
>>=20
>> I have an unsent patch fixing both.  In fact, I have an unsent series
>> fixing *all* F: patterns that don't resolve to any file.
>>
>
> I planned to take a look at this, and would be happy to review yours.

I hope to post tomorrow.  Review is always appreciated!

> Any chance you have a script that we could integrate directly into our
> meson.build? (I feel it's better than checkpatch, since checkpatch is
> not blocking anything CI wise).

Good idea.

Here's my quick & dirty way to find broke F:

    $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null

Easily fooled by untracked files.  I double-checked in a fresh clone
just to be sure.

> This way, any time a project is configured (not built, configured), it
> would trigger a check. Since every file removal/adding implies a
> meson.build modification, it should keep the MAINTAINERS file consistent
> by design.

Yep.

>>>  F: gdbstub/gdb-xml/hexagon*.xml
>>>  T: git https://github.com/quic/qemu.git hex-next


