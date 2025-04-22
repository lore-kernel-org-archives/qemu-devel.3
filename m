Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A3EC369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 09:10:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79dz-0005bf-3V; Tue, 22 Apr 2025 05:10:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u79dx-0005b4-HJ
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 05:10:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u79du-0006lN-TL
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 05:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745313013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V+gz5HlxFSSaFG/+oTwV2Zx/1gzahZKo5aSuM23ge28=;
 b=HhrGDRw+ovgj+OaRopj1NjGdGWmOoedUFcm9J5Wj1rLeqoldH+zbBSvtpx/9JyifW6EMMI
 sAbumoMTkCxiCN83h+V1XJdjUly1PxkO3eFmiWuVtsYyR2IWf5kt1RYM1WkHUFCiqoTbTf
 s1lORe3inyJeZCaYSlJ8TTSdLFf0sVo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-201-gWphw8-LMfyzbzRJ1qj-iA-1; Tue,
 22 Apr 2025 05:10:08 -0400
X-MC-Unique: gWphw8-LMfyzbzRJ1qj-iA-1
X-Mimecast-MFC-AGG-ID: gWphw8-LMfyzbzRJ1qj-iA_1745313006
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71D1B1800373; Tue, 22 Apr 2025 09:10:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.5])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 968751955BCB; Tue, 22 Apr 2025 09:10:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 058BA21E66C2; Tue, 22 Apr 2025 11:10:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,  Anton Johansson
 <anjo@rev.ng>
Subject: Re: [RFC PATCH v3 01/14] qapi: Rename TargetInfo structure as
 BinaryTargetInfo
In-Reply-To: <b846a12d-bbe3-4a88-aecd-b62cd57d297d@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 22 Apr 2025 09:35:39
 +0200")
References: <20250418172908.25147-1-philmd@linaro.org>
 <20250418172908.25147-2-philmd@linaro.org>
 <878qnsagfo.fsf@pond.sub.org>
 <b846a12d-bbe3-4a88-aecd-b62cd57d297d@linaro.org>
Date: Tue, 22 Apr 2025 11:10:02 +0200
Message-ID: <877c3c7ead.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.692,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 22/4/25 07:55, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> The QAPI-generated 'TargetInfo' structure name is only used
>>> in a single file. We want to heavily use another structure
>>> similarly named. Rename the QAPI one, since structure names
>>> are not part of the public API.
>>>
>>> Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>   qapi/machine.json          | 12 ++++++------
>>>   hw/core/machine-qmp-cmds.c |  4 ++--
>>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/qapi/machine.json b/qapi/machine.json
>>> index a6b8795b09e..3246212f048 100644
>>> --- a/qapi/machine.json
>>> +++ b/qapi/machine.json
>>> @@ -275,15 +275,15 @@
>>>  { 'command': 'query-current-machine', 'returns': 'CurrentMachineParams=
' }
>>>=20=20=20
>>>  ##
>>> -# @TargetInfo:
>>> +# @BinaryTargetInfo:
>>>  #
>>> -# Information describing the QEMU target.
>>> +# Information describing the QEMU binary target.
>>=20
>> What's "the QEMU binary target"?  The QEMU binary's target?
>
> For me 'qemu-system-aarch64' is a QEMU binary,

Makes sense to me.

>                                                but for Pierrick and
> Richard it is the QEMU target,

Make about as much sense to me as calling my /usr/bin/gcc "the GNU C
compiler target", i.e. none.  It's the GNU C compiler targeting x86_64.

>                                so I merged both names =C2=AF\_(=E3=83=84)=
_/=C2=AF

If it gets your patch merged...

> This structure describes the static target configuration built into
> a binary, i.e. TARGET_NAME=3Daarch64, TARGET_BIG_ENDIAN=3Dfalse.
>
> For the forthcoming single/heterogeneous binary, we don't have a
> particular restricted configuration in the binary.
>
> What about "Information describing the QEMU target configuration
> built in a binary."?

That's better.  Here's my try: "Information on the target configuration
built into the QEMU binary."

>>  From the QMP user's point of view, perhaps "the QEMU process's target"
>> would make more sense.
>
> So maybe ProcessTargetInfo is a better structure name.

QemuTargetInfo would sidestep binary vs. process.

> For heterogeneous target I suppose we'll return SYS_EMU_TARGET_HETERO
> and we'll provide new QMP commands, possibly returning array of
> ProcessTargetInfo.

[...]


