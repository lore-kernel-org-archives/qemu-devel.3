Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BEF0CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPi94-00045G-5P; Wed, 20 May 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPi8z-0003yh-94
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:43:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wPi8x-00038N-94
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:43:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779288210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xva2A+JP9GMXMX4xRTA3le4X47kLPWBYE55Uc9u/Mqs=;
 b=L85Quk5vlJD/wdAjzptW/z6+3cu6tLmL9fQQCsOlVz4XVS5O2SIOKTWHFG3QCLJxwvZiHl
 mtAI6gWc9C8Kou8t1LbXnTkeO941xcv44hEMU9sPRRKVOP7LoXqmjpCNqQFFPeMFt0GUEe
 xZFiHXFq6wD1w2CyWUHsF9AJZFZceMc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-X3Yb4V9MNb6uIL19JID76Q-1; Wed,
 20 May 2026 10:43:24 -0400
X-MC-Unique: X3Yb4V9MNb6uIL19JID76Q-1
X-Mimecast-MFC-AGG-ID: X3Yb4V9MNb6uIL19JID76Q_1779288203
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C423D18005BB; Wed, 20 May 2026 14:43:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40ED81684; Wed, 20 May 2026 14:43:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EBAFC21E6A01; Wed, 20 May 2026 16:43:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>
Subject: Re: [PATCH] MAINTAINERS: Fix hexagon-linux-user.mak path
In-Reply-To: <8bf4fb20-d675-4569-92c2-b8921b2991e4@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Wed, 20 May 2026 16:05:24
 +0200")
References: <20260520123947.12711-1-philmd@linaro.org>
 <87fr3ms0oi.fsf@pond.sub.org>
 <f52ebf28-1921-4ada-a7c5-ec3342cd3acb@linaro.org>
 <57f7a25a-dce1-452f-8529-187d66a6d8de@linaro.org>
 <87fr3mkz26.fsf@pond.sub.org>
 <8bf4fb20-d675-4569-92c2-b8921b2991e4@linaro.org>
Date: Wed, 20 May 2026 16:43:19 +0200
Message-ID: <878q9ejg54.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 20/5/26 15:09, Markus Armbruster wrote:
>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>=20
>>> On 20/5/26 14:57, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> On 20/5/26 14:52, Markus Armbruster wrote:
>>>>> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:
>>>>>
>>>>>> Fixes: 812b31d3f91 ("configs: rename default-configs to configs and =
reorganise")
>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>>>> ---
>>>>>>  =C2=A0 MAINTAINERS | 2 +-
>>>>>>  =C2=A0 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index b75f3222f2f..2a4d124fb3c 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -256,7 +256,7 @@ X: target/hexagon/gen_idef_parser_funcs.py
>>>>>>  =C2=A0 F: linux-user/hexagon/
>>>>>>  =C2=A0 F: tests/tcg/hexagon/
>>>>>>  =C2=A0 F: disas/hexagon.c
>>>>>> -F: configs/targets/hexagon-linux-user/default.mak
>>>>>> +F: configs/targets/hexagon-linux-user.mak
>>>>>>  =C2=A0 F: docker/dockerfiles/debian-hexagon-cross.docker
>>>>>
>>>>> This one's wrong, too.
>>>> Already fixed in Alex's tree:
>>>> https://lore.kernel.org/qemu-devel/20260518102222.80735-2-philmd@linar=
o.org/
>>>> Pierrick suggested to repost patch dependencies already queued in
>>>> maintainer tree when posting series; while this seem counter
>>>> productive it could indeed have saved us time.
>>>>
>>>>> I have an unsent patch fixing both.=C2=A0 In fact, I have an unsent s=
eries
>>>>> fixing *all* F: patterns that don't resolve to any file.
>>>
>>> I looked for your series without success, then realized you mentioned
>>> it is "unsent". This patch is still valid then.
>>
>> Yes.
>>=20
>>>                                                  Why mention unsent wor=
k?
>> To avoid duplicated work.
>
> I'm not sure this thread is making sense o_O

Are we talking past each other?

> Let's try to figure what you meant here. I'm not racing to get
> this patch in nor enjoying duplicating work, but this is the
> mailing list rules (due to the intrinsic email workflow latency,
> not to mention subscriber processing their INBOX in FIFO mode).

Let me recap the obvious :)

1. First workable patch on the list has priority, with a generous
interpretation of "workable".

2. If a workable patch on the list overlaps with one I haven't sent, I
rebase mine onto it.  No arguing, no whining.

In fact, I did exactly that, and then told you: "I've been picking [your
patches] into my tree".  When my patches are ready, I intend to post
them with a bunch of Based-on: pointing to yours, or include yours with
mine, whatever feels more convenient.

Okay?

> See for example last week at least 3 developers fixed the same
> GCC warning issue. Generically, how could we improve that?

I don't have better ideas than "watch the mailing list", and "let the
right people know what you're doing".

>>>> Oh :( I already sent various patches about that yesterday :(
>>
>> I've been picking them into my tree as I went.  I may have missed the
>> odd patch, but I'll fix that.
>>=20
>>>>>
>>>>>>  =C2=A0 F: gdbstub/gdb-xml/hexagon*.xml
>>>>>>  =C2=A0 T: git https://github.com/quic/qemu.git hex-next
>>=20


