Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0C3CD342C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 06:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKVWS-000370-2g; Wed, 06 May 2026 02:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVWQ-00036T-Ha
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKVWO-0000Ha-Dx
 for qemu-devel@nongnu.org; Wed, 06 May 2026 02:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778048051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lmzo2GYK77ta34IgE8RnRh0v7v9Fok8ETwKY/Y6ESxM=;
 b=FSfPvTDrN6ptmqL4Xsca0Iz6c1sX5I5h1TA1obO5Vdq2AJMkFNSBaHTQZW7Sj5TiJKknwM
 lOF0K8gHiUCYTwR17gjrorXX6hY9TTq4LBJYMcOjJrG9dVS70UuwnWyDcsJcLTGWQPdYHn
 4PnMZDcZeXtswfTr9jFzAe/qHOayqps=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-OAATMEY_Pvua5-hOEOU55g-1; Wed,
 06 May 2026 02:14:09 -0400
X-MC-Unique: OAATMEY_Pvua5-hOEOU55g-1
X-Mimecast-MFC-AGG-ID: OAATMEY_Pvua5-hOEOU55g_1778048048
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20AC71800359; Wed,  6 May 2026 06:14:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C37A41944CC4; Wed,  6 May 2026 06:14:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6708121E6A01; Wed, 06 May 2026 08:14:05 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,  qemu-devel@nongnu.org,
 stefanha@redhat.com
Subject: Re: [PULL 0/4] Monitor patches for 2026-05-05
In-Reply-To: <5d1f592d-21cb-4fb8-a8a4-0234af4bc3ed@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 May 2026 16:40:56
 +0200")
References: <20260505123502.1316554-1-armbru@redhat.com>
 <0f68fa39-f190-420c-a55a-f31a7b95663c@linaro.org>
 <CAJSP0QWVdSHvK2g8jncEL40nR=yp65LGZJ6z5NnsKM8ey2Oh_w@mail.gmail.com>
 <5d1f592d-21cb-4fb8-a8a4-0234af4bc3ed@linaro.org>
Date: Wed, 06 May 2026 08:14:05 +0200
Message-ID: <87y0hxdpzm.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> Hi Stefan,
>
> On 5/5/26 16:00, Stefan Hajnoczi wrote:
>> On Tue, May 5, 2026 at 8:59=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote:
>>>
>>> On 5/5/26 14:34, Markus Armbruster wrote:
>>>> The following changes since commit ac0cc20ad2fe0b8df2e5d9458e90a095ac7=
11ab1:
>>>>
>>>>     Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into s=
taging (2026-05-01 14:41:49 -0400)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://repo.or.cz/qemu/armbru.git tags/pull-monitor-2026-05-05
>>>>
>>>> for you to fetch changes up to ea017f67ce1ca34c7503b6f23f48b433585d37a=
c:
>>>>
>>>>     monitor: Add `clear` command (2026-05-05 13:53:03 +0200)
>>>>
>>>> ----------------------------------------------------------------
>>>> Monitor patches for 2026-05-05
>>>>
>>>> ----------------------------------------------------------------
>>>> AlanoSong@163.com (1):
>>>>         monitor: Add `clear` command
>>>>
>>>> Dr. David Alan Gilbert (3):
>>>>         hmp*hx: Move info docs
>>>>         hxtool: Split srst/erst add checks
>>>>         hxtool: Error on missing docs
>>>>
>>>>    include/monitor/hmp.h |  1 +
>>>>    monitor/hmp-cmds.c    | 11 +++++++++++
>>>>    hmp-commands-info.hx  |  9 +--------
>>>>    hmp-commands.hx       | 41 +++++++++++++++++++++++++++++++----------
>>>>    scripts/hxtool        | 39 ++++++++++++++++++++++++++++++++++++---
>>>>    5 files changed, 80 insertions(+), 21 deletions(-)
>>>>
>>>
>>> Obviously this conflicts with the PR I'm waiting since 10 days to post:
>>>
>>> $ git merge pull-monitor-2026-05-05
>>> Auto-merging hmp-commands-info.hx
>>> Auto-merging hmp-commands.hx
>>> CONFLICT (content): Merge conflict in hmp-commands.hx
>>> Auto-merging include/monitor/hmp.h
>>> Auto-merging monitor/hmp-cmds.c
>>> Automatic merge failed; fix conflicts and then commit the result.
>>>
>>> Sigh.

I'm sorry.

>> Hi,
>> What is blocking you from sending your PR and who can do something about=
 it?
>
> Sorry, this comment was for Markus. I understood he wanted to have a
> look on patches related to monitor I was going to pull:
> https://lore.kernel.org/qemu-devel/d434b8b1-e79c-40c7-984d-1164543c7069@l=
inaro.org/

Yes, I'd like to have a look.  But I'm under water, so what I like
doesn't matter.  I'll have to rely on the review of others here.

> More than 1 week passed so I think we are good. Do not hold on Markus
> pull-monitor-2026-05-05 tag, I'll wait it gets merged then fix the
> conflicts and post mine.

Go right ahead.


