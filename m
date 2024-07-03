Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC58C2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 05:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOsJm-00083D-RT; Wed, 03 Jul 2024 01:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sOsJk-00082d-Pj
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:14:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sOsJf-0005UR-Ip
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 01:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719983641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9jGJxVxvnrXHAapjrXf8PWs8jz7LdDL6OzIh6r4Bvso=;
 b=dVk6qgVRdLXS1F/ajKDOC5EsYZIS4ty3H+kptxE4+H/2mDQtdFOD4+B26Vodyyl73EESVV
 P+3zhMGAfic0GmGgdLU57qemuSE1ejEz6XN0W7KbWJi2gKILOsi8pRGG8mHYq1VElGW4Cx
 e1AGWDumoIjTcbb8P+zQ/Ah+/2jHeXU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-493-t05srrCyPUGkd60uQV155Q-1; Wed,
 03 Jul 2024 01:13:59 -0400
X-MC-Unique: t05srrCyPUGkd60uQV155Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 538231956080; Wed,  3 Jul 2024 05:13:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2DDD184B2DC; Wed,  3 Jul 2024 05:13:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A93621E65D1; Wed,  3 Jul 2024 07:13:55 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/2] docs/python: bump minimum Sphinx version
In-Reply-To: <CAFn=p-Y1r3SfoA=T9rPMnTzk2ZiF28R8GUCGmLdEdhFnSDzarA@mail.gmail.com>
 (John Snow's message of "Tue, 2 Jul 2024 16:01:24 -0400")
References: <20240702195903.204007-1-jsnow@redhat.com>
 <CAFn=p-Y1r3SfoA=T9rPMnTzk2ZiF28R8GUCGmLdEdhFnSDzarA@mail.gmail.com>
Date: Wed, 03 Jul 2024 07:13:55 +0200
Message-ID: <87h6d7hxbg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 127.0.0.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Tue, Jul 2, 2024 at 3:59=E2=80=AFPM John Snow <jsnow@redhat.com> wrote:
>
>> With recent deprecations, we can advance our minimum sphinx version
>> safely. This is heavily motivated by new qapidoc work which is much
>> easier to maintain cross-version compatibility for - see difficulties in
>> our dbus documentation which only works on sphinx >=3D 4.
>>
>> We can only guarantee >=3D 3.4.3 now, but that's still vastly easier than
>> maintaining compatibility all the way back to 1.x.
>>
>> GitLab: https://gitlab.com/jsnow/qemu/-/pipelines/1357902509
>>
>> (failures appear to be unrelated to the series.)
>>
>> John Snow (2):
>>   Python: bump minimum sphinx version to 3.4.3
>>   docs: remove Sphinx 1.x compatibility code
>>
>>  docs/conf.py             |  7 +++----
>>  docs/sphinx/hxtool.py    | 21 ++++-----------------
>>  docs/sphinx/kerneldoc.py | 38 ++++++++++++--------------------------
>>  docs/sphinx/kernellog.py | 28 ----------------------------
>>  docs/sphinx/qapidoc.py   | 29 +++--------------------------
>>  pythondeps.toml          |  2 +-
>>  6 files changed, 23 insertions(+), 102 deletions(-)
>>  delete mode 100644 docs/sphinx/kernellog.py
>>
>> --
>> 2.45.0
>>
>
> Bleurgh. I meant to shuffle some of the changes in patch 1 into patch 2,

I was wondering about the split :)

> I'll fix that on re-spin. If you want to review it anyway, just presume
> I'll fix that next go-around.

Acked-by: Markus Armbruster <armbru@redhat.com>


